# uom_simulator/p3_optimizer.py

import math
from dataclasses import dataclass
from typing import Tuple

import numpy as np
import torch

from uom_simulator.config import SimConfig
from uom_simulator.utils import (
    map_config_to_kernels,
    eval_L4_of_lambda_batch,
)
from uom_simulator.external.penalties_calculator.core.utils import DEVICE
from uom_simulator.external.penalties_calculator.core.by_kernel import compute_by_batch
from uom_simulator.external.penalties_calculator.core.conf_kernel import compute_conf_batch
from uom_simulator.external.penalties_calculator.core.wall_kernel import (
    compute_wall_penalty_batch,
)


# --------------------------------------------------------------------------------------
# Result structure
# --------------------------------------------------------------------------------------

@dataclass(frozen=True)
class TickResult:
    delta_I: float
    Theta_k: float
    D_conf: float
    optimal_next_Lambda: float
    wall_work_req: float
    wall_work_avail: float
    best_action_value: float


# --------------------------------------------------------------------------------------
# Internal helpers (time/space surrogate for building δC and rough throughput)
# --------------------------------------------------------------------------------------

def _throughput_noA_batch(s_t: torch.Tensor, s_x: torch.Tensor, grid: dict) -> torch.Tensor:
    """
    Candidate-specific “throughput” G_batch (no amplitude), used only to scale δC in CONF.
    """
    import numpy as np
    n_omega, n_ell = grid['n_omega'], grid['n_ell']
    u_max = grid['dimensionless_u_max']

    u = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    d_u = (u[1]-u[0]) if n_omega > 1 else torch.tensor(1.0, device=DEVICE, dtype=torch.float64)

    # same φ(u) shape as BY kernel
    phi = -(u**2) * torch.exp(-0.5 * u**2)
    G_t = (1.0/(2.0*np.pi)) * (torch.sum(phi**2) * d_u) / (s_t**5)

    ell = torch.arange(1, n_ell+1, device=DEVICE, dtype=torch.float64)
    lam = ell * (ell + 2.0)
    degeneracy = (ell + 1.0)**2
    tau_x = -lam * torch.exp(-0.5 * (s_x.view(-1,1)**2) * lam.view(1,-1))  # [B, L]
    G_x_sum = torch.sum(degeneracy * tau_x**2, dim=1)                      # [B]
    return G_t.view(-1) * G_x_sum.clamp(min=1e-300)                         # [B]


def _construct_delta_c_tangent(
    delta_I: torch.Tensor, s_t: torch.Tensor, s_x: torch.Tensor, grid_config: dict
) -> torch.Tensor:
    """
    Builds a welded tangent δC(ω,ℓ) with the correct per-candidate amplitude so that
    Fisher-norm power ∝ ΔI for CONF. This does not need L4 explicitly.
    """
    G_batch = _throughput_noA_batch(s_t, s_x, grid_config)    # [B]
    A_eff = torch.sqrt(delta_I / G_batch.clamp(min=1e-300))

    n_omega, n_ell = grid_config['n_omega'], grid_config['n_ell']
    u_max = grid_config['dimensionless_u_max']
    u = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    ell = torch.arange(1, n_ell+1, device=DEVICE, dtype=torch.float64)
    lam = ell * (ell + 2.0)

    time_factor  = -(u.view(1,-1)**2) / (s_t.view(-1,1)**2) * torch.exp(-0.5*u.view(1,-1)**2)
    space_factor = -lam.view(1,-1) * torch.exp(-0.5 * (s_x.view(-1,1)**2) * lam.view(1,-1))

    delta_C = A_eff.view(-1,1,1) * time_factor.unsqueeze(2) * space_factor.unsqueeze(1)
    return delta_C.to(dtype=torch.complex128)


# --------------------------------------------------------------------------------------
# Wall constants (A, B, α_w) evaluated at a given L4 “pivot”
# --------------------------------------------------------------------------------------

def _build_wall_constants_at_L4(
    L4_pivot: float,
    geometry_constants: dict,
    alpha_w: float = 1.0,
) -> dict:
    """
    Implements the small-step HJ/Weyl wall-work form (per area):
        dW/dΛ ≈ (α_w / L4) [ (M5^3/ℓ) + κ_ct a_cft Λ^2 ]  (local-in-Λ surrogate)
    which leads to the closed-form used in wall_kernel:
        J_wall(Λ_prev→Λ) = α_w [ A ln(Λ/Λ_prev) + (B/2)(Λ^2-Λ_prev^2) ],
    with A = (M5^3/ℓ)/L4_pivot and B = (κ_ct a_cft)/L4_pivot.

    We keep α_w as a knob (default 1).
    """
    M5_cubed = float(geometry_constants["M5_cubed"])
    ell_ads5 = float(geometry_constants["ads5_radius_ell"])
    kappa_ct = float(geometry_constants["kappa_ct"])
    a_cft    = float(geometry_constants["a_cft_rec"])

    L4_eff = max(float(L4_pivot), 1e-30)

    A = (M5_cubed / max(ell_ads5, 1e-30)) / L4_eff
    B = (kappa_ct * a_cft) / L4_eff
    return {"alpha_w": float(alpha_w), "A": float(A), "B": float(B)}


def _cap_from_wall_budget(
    lambda_prev: float,
    W_total: float,
    wall_constants: dict,
    expand_factor: float = 8.0,
) -> float:
    """
    Compute the maximum Λ reachable within the wall-work budget W_total by solving
    J_wall(Λ_prev→Λ_cap) = W_total, using the same closed-form as wall_kernel.

    We do a safe bracketing + Brent solve. If budget is tiny, Λ_cap ≈ Λ_prev.
    """
    if W_total <= 1e-30:
        return float(lambda_prev)

    A = float(wall_constants["A"])
    B = float(wall_constants["B"])
    alpha_w = float(wall_constants["alpha_w"])
    lam0 = max(float(lambda_prev), 1.0e-30)

    # Closed-form J(λ): α_w [ A ln(λ/λ0) + (B/2)(λ^2-λ0^2) ]
    def J_of(lam: float) -> float:
        lam = max(lam, lam0)
        return alpha_w * (A * math.log(lam / lam0) + 0.5 * B * (lam * lam - lam0 * lam0))

    # Quick exit: small budget ⇒ tiny move
    if J_of(lam0 * (1.0 + 1e-6)) > W_total and J_of(lam0 * (1.0 + 1e-3)) > W_total:
        return lam0

    # Bracket
    lo = lam0
    hi = lam0 * (1.0 + 1e-3)
    # Expand exponentially until we exceed budget or reach a large factor
    for _ in range(60):
        if J_of(hi) >= W_total:
            break
        hi *= expand_factor
        if hi > 1.0e30:
            hi = 1.0e30
            break

    # If even huge hi doesn't reach budget (practically impossible), return hi
    if J_of(hi) < W_total:
        return hi

    # Brent solve on [lo, hi]
    from scipy.optimize import brentq
    try:
        root = brentq(lambda L: J_of(L) - W_total, lo, hi, maxiter=200, xtol=1e-12, rtol=1e-10)
        return float(max(root, lam0))
    except Exception:
        # If numerical failure, fall back to hi where J>=W
        return float(max(hi, lam0))


# --------------------------------------------------------------------------------------
# Main optimizer
# --------------------------------------------------------------------------------------

def optimize_tick_p3(
        F_dS_k: float,
        F_dS_band_fraction: float,
        Lambda_k: float,
        beta_k: float,
        sim_config: SimConfig,
        d_sep: float,
        wall_work_bank:float,
        debug_print: bool = False
) -> TickResult:
    """
    Minimize the per-tick P3 action over Λ candidates, with:
      A_k(Λ) = (F_dS_k - ΔI_k)
               + λ_by * Θ_by(Λ)
               + λ_conf * D_conf(Λ)
               + λ_wall * J_wall(Λ_k → Λ),
    subject to the hard **wall budget** J_wall(Λ_k→Λ) ≤ W_total per tick.

    Notes:
      * BY and CONF both receive per-candidate L4(Λ) from eval_L4_of_lambda_batch.
      * BY also receives d_sep.
      * The wall work is both a constraint (budget cap) and a soft term (λ_wall).
    """
    # 0) Fetch kernel + geometry
    kernel_config, geom_constants = map_config_to_kernels(sim_config)
    grid_cfg = kernel_config['surrogate']['grid_config']
    l4_drift_cfg = kernel_config['surrogate'].get('l4_drift', {})

    rec = sim_config.scenario.receiver
    aeon = sim_config.scenario.aeon

    # 1) Payload this tick
    F_dS_band = F_dS_k * F_dS_band_fraction
    delta_I_k = (1.0 - math.exp(-beta_k)) * F_dS_band
    delta_I_k = min(delta_I_k, F_dS_k)

    if delta_I_k < 1e-20:
        # No action possible this tick
        return TickResult(
            delta_I=0.0,
            Theta_k=0.0,
            D_conf=0.0,
            optimal_next_Lambda=Lambda_k,
            wall_work_req=0.0,
            wall_work_avail=0.0,
            best_action_value=F_dS_k
        )

    # Wall work budget (per-tick)
    W_tick = float(rec.eta_wall_work) * delta_I_k
    W_total = W_tick+wall_work_bank  # if you later introduce banking, add it here

    # 2) Build candidate Λ grid within **budget cap**
    #    Derive (A, B, α_w) at a pivot L4; we take L4 at Λ_prev for local consistency
    L4_prev = float(geom_constants.get("L4_init", geom_constants.get("L4", rec.L4_init)))
    # allow drift rule even for pivot (tension-coupled users): evaluate at Λ_prev
    L4_prev = float(eval_L4_of_lambda_batch(
        torch.tensor([Lambda_k], device=DEVICE, dtype=torch.float64),
        kernel_config, geom_constants,
        r0_abs_target=None,
        lambda_ref=geom_constants.get("lambda_ref", aeon.initial_Lambda)
    )[0].item())

    wall_consts = _build_wall_constants_at_L4(L4_prev, geom_constants, alpha_w=1.0)
    lam_cap = _cap_from_wall_budget(Lambda_k, W_total, wall_consts, expand_factor=4.0)

    # Build monotone candidate set in [Λ_k, Λ_cap]. If cap==Λ_k, keep at least one tiny step.
    if lam_cap <= Lambda_k * (1.0 + 1e-9):
        lam_cap = Lambda_k * (1.0 + 1.0e-9)

    num_candidates = 63
    Lambda_candidates = torch.linspace(
        Lambda_k, lam_cap, num_candidates, device=DEVICE, dtype=torch.float64
    )

    # 3) Prepare per-candidate parameters
    #    Time/space widths (s_t, s_x) are functions of Λ
    s_t_batch = rec.alpha_t / Lambda_candidates
    s_x_batch = rec.alpha_x / (rec.v_geom * Lambda_candidates)

    log_delta_i_batch = torch.full((num_candidates,), math.log(delta_I_k), device=DEVICE, dtype=torch.float64)
    log_s_t_batch     = torch.log(s_t_batch)
    log_s_x_batch     = torch.log(s_x_batch)
    log_lambda_batch  = torch.log(Lambda_candidates)

    params_batch = torch.stack([log_delta_i_batch, log_s_t_batch, log_s_x_batch, log_lambda_batch], dim=1)

    # 4) Per-candidate L4(Λ) (drift mode controlled via kernel_config['surrogate']['l4_drift'])
    L4_batch = eval_L4_of_lambda_batch(
        Lambda_candidates,
        kernel_config,
        geom_constants,
        r0_abs_target=None,  # you could pass aeon.initial_R0_abs to force "target-curvature" mode
        lambda_ref=geom_constants.get("lambda_ref", aeon.initial_Lambda)
    )

    # 5) BY, CONF, WALL terms
    with torch.no_grad():
        # BY: pass d_sep and L4_batch
        Theta_batch = compute_by_batch(
            params_batch, kernel_config, geom_constants,
            d_sep=d_sep, debug_print=False, L4_batch=L4_batch
        )

        # Build δC tangent with proper amplitude for CONF
        delta_C_batch = _construct_delta_c_tangent(
            torch.exp(log_delta_i_batch), s_t_batch, s_x_batch, grid_cfg
        )
        D_conf_batch = compute_conf_batch(
            delta_C_batch, params_batch, kernel_config, geom_constants, L4_batch=L4_batch
        )

        # WALL penalty for each candidate move
        # Recompute A,B at the **local** L4 of the *previous* point (Λ_k); J_wall is defined for (Λ_k -> Λ)
        # If you prefer fully Λ-dependent L4 inside J, derive a path integral; here we keep the local surrogate.
        wall_consts_local = _build_wall_constants_at_L4(float(L4_prev), geom_constants, alpha_w=1.0)
        J_wall_batch = compute_wall_penalty_batch(
            params_batch, wall_consts_local, lambda_prev=float(Lambda_k), debug_print=False
        )

    # Mask by **hard budget** (safety)
    budget_mask = (J_wall_batch <= (W_total + 1e-30))
    if not torch.any(budget_mask):
        # Only Λ_k is feasible
        feasible_idx = torch.tensor([0], device=DEVICE, dtype=torch.long)
    else:
        feasible_idx = torch.nonzero(budget_mask, as_tuple=False).view(-1)

    # Take feasible slices
    Lam_feas   = Lambda_candidates[feasible_idx]
    Theta_feas = Theta_batch[feasible_idx]
    Dconf_feas = D_conf_batch[feasible_idx]
    Jwall_feas = J_wall_batch[feasible_idx]

    # 6) Compose action and choose optimum
    source_dwell_cost = F_dS_k - delta_I_k
    #action_feas = (source_dwell_cost
    #               + rec.lambda_by   * Theta_feas
    #               + rec.lambda_conf * Dconf_feas
    #               + getattr(rec, "lambda_wall", 1.0) * Jwall_feas)
    action_feas = (rec.lambda_by * Theta_feas
                   + rec.lambda_conf * Dconf_feas
                   + rec.lambda_wall * Jwall_feas)

    # select min
    best_local = torch.argmin(action_feas)
    best_idx = int(feasible_idx[best_local].item())

    optimal_next_Lambda = float(Lambda_candidates[best_idx].item())
    best_action_value   = float(action_feas[best_local].item())
    optimal_Theta_k     = float(Theta_batch[best_idx].item())
    optimal_D_conf      = float(D_conf_batch[best_idx].item())
    wall_work_req       = float(J_wall_batch[best_idx].item())
    wall_work_avail     = float(W_total)


    if debug_print:
        # small human-friendly snapshot
        first_dA = []
        if Lam_feas.numel() >= 3:
            # ∂A/∂logΛ (finite difference on feasible set)
            eps = 1e-12
            Llog = torch.log(Lam_feas.clamp(min=1e-300))
            dA = (action_feas[1:4] - action_feas[0:3]) / (Llog[1:4] - Llog[0:3] + eps)
            first_dA = np.round(dA.detach().cpu().numpy(), 6).tolist()

        print(f"[BUDGET] eta_wall_work={rec.eta_wall_work}  ΔI_tick={delta_I_k:.3e}  "
              f"=>  W_tick={W_tick:.3e}")
        print(f"[CAP] wall-only: {'active' if lam_cap>Lambda_k else 'inactive'}, Λ_cap={lam_cap:.5g}")
        print(f"  Λ grid: [{Lambda_k:g} → {lam_cap:g}]  (n={num_candidates})")
        t0 = Theta_batch[:4].detach().cpu().numpy()
        print("  Θ(Λ) first 4:", np.round(t0, 6))
        print("  ∂A/∂logΛ (first 3):", first_dA)
        print(f"  chosen Λ_next={optimal_next_Lambda:g}, Θ={optimal_Theta_k:.3e}, "
              f"D_conf={optimal_D_conf:.3e}, ΔJ_wall+={wall_work_req:.3e}, "
              f"A_best={best_action_value:.6e}")

    return TickResult(
        delta_I=delta_I_k,
        Theta_k=optimal_Theta_k,
        D_conf=optimal_D_conf,
        optimal_next_Lambda=optimal_next_Lambda,
        wall_work_req=wall_work_req,
        wall_work_avail=wall_work_avail,
        best_action_value=best_action_value
    )
