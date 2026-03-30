
# uom_simulator/lambda_solver.py
"""
Energy-balance Λ-solver (no payload-funded cap).

We solve for Λ_{k+1} from the implicit tick constraint:
    J_wall(Λ_k -> Λ_{k+1})  =  E_BY_geom(Λ_k, L4_k; κ(Λ_k))
                               - E_BY_geom(Λ_{k+1}, L4_{k+1}(Θ(Λ_{k+1})); κ(Λ_{k+1})),
with L4_{k+1} obtained by updating the curvature via the BY kernel’s Θ at the candidate Λ:

    |R_0|_{k+1} = max(ε, |R_0|_k - Θ(Λ_{k+1}; L4_k)),   L4_{k+1} = sqrt(12/|R_0|_{k+1}).

Notes
-----
* Θ(·) is computed with the existing GPU BY kernel for a one-point batch, using L4_k
  (the new L4_{k+1} is *result* of the tick, not an input to BY).
* J_wall(Λ_k -> Λ) is computed with the existing varL4 wall kernel. Because κ runs with Λ,
  we pass an *effective* κ evaluated at the geometric mean κ(√(Λ_k Λ)) to that kernel
  (slow–running mid-point approximation).
* For BY screening r(Λ) ~ ℓ_AdS5/2 + C_m3 Λ^2 with C_m3 ∝ κ, the current BY kernel accepts a
  scalar C_m3. To approximately account for κ(Λ) in r, we keep C_m3 fixed at κ_ref and feed
  an *effective* λ_r = Λ * sqrt[ κ(Λ) / κ_ref ] to the BY kernel. Time/space widths still use
  the *physical* Λ. This preserves the intended κ–dependence in screening while not
  disturbing welded widths.
"""

from dataclasses import dataclass
from typing import Callable, Dict, Tuple, Optional, Literal

import numpy as np
import torch
from scipy.optimize import root_scalar

from uom_simulator.config import SimConfig
from uom_simulator.utils import window_ell, compute_degeneracy, R0_from_L4
from uom_simulator.external.penalties_calculator.core.utils import DEVICE
from uom_simulator.external.penalties_calculator.core.by_kernel import compute_by_batch
from uom_simulator.external.penalties_calculator.core.wall_kernel import compute_wall_penalty_varL4_batch


# -----------------------------
# κ(Λ) running models
# -----------------------------

KappaModel = Literal["const", "log", "power", "riccati"]

@dataclass
class KappaRunSpec:
    model: KappaModel = "ricatti"
    kappa0: float = 0.01
    lambda0: float = 1.0
    b: float = 1.0  # slope/one-loop coefficient

    def kappa(self, lam: float) -> float:
        if self.model == "const":
            return float(self.kappa0)
        x = max(float(lam), 1e-30)
        x0 = max(float(self.lambda0), 1e-30)
        if self.model == "log":
            return float(self.kappa0 + self.b * np.log(x / x0))
        if self.model == "power":
            return float(self.kappa0 * (x / x0) ** self.b)
        if self.model == "riccati":
            denom = (1.0 - self.b * self.kappa0 * np.log(x / x0))
            # avoid poles / negative
            if abs(denom) < 1e-12:
                denom = np.sign(denom) * 1e-12
            return float(self.kappa0 / denom)
        # fallback
        return float(self.kappa0)


# -----------------------------
# Geometry-side energy
# -----------------------------

def e_by_geom(lam: float, L4: float, a_cft_rec: float,
              M5_cubed: float, m5_ell: float, kappa_ct: float, zeta: float) -> float:
    """
    E_BY^{geom}(Λ, L4; κ) = ζ * (1/L4) * [ A + κ a_cft Λ^2 ],  A = M5^3 / ℓ_AdS5
    """
    A = (M5_cubed / max(m5_ell, 1e-30))
    return float(zeta) * (A + float(kappa_ct) * float(a_cft_rec) * (lam ** 2)) / max(float(L4), 1e-30)


@dataclass
class SolveResult:
    Lambda_next: float
    Theta: float
    R_abs_next: float
    L4_next: float
    J_wall: float
    DeltaE_geom: float
    band_fraction: float
    beta_k: float
    delta_I_k: float
    status: str


def _band_fraction_for_tick(Lambda_rec: float, d_sep: float, sim_config: SimConfig) -> float:
    """
    Rebuild the same band fraction used in the previous driver:
      band_fraction = sum(taper * window * degeneracy) / sum(window * degeneracy).
    """
    from uom_simulator.payload_engine_torch import compute_retarded_knee_torch

    # Precompute weights
    lmax = sim_config.scenario.source.l_max_source
    ells = np.arange(lmax + 1, dtype=np.float64)
    degeneracy = compute_degeneracy(lmax).astype(np.float64)

    # Taper from knee
    ell_star, taper_torch = compute_retarded_knee_torch(
        Lambda_rec, d_sep,
        sim_config.scenario.source, sim_config.scenario.receiver, sim_config.physics
    )
    taper = taper_torch.detach().cpu().numpy()

    # Receiver soft window
    win = window_ell(
        ells, sim_config.scenario.receiver.L4_init, Lambda_rec,
        sim_config.scenario.receiver.cL_map, sim_config.scenario.receiver.deltaL_soft
    ).astype(np.float64)

    num = np.sum(taper * win * degeneracy)
    den = np.sum(win * degeneracy)
    return float(num / den) if den > 1e-30 else 0.0


def _theta_at_candidate(
    lam_phys: float,              # physical Λ used for widths
    lam_eff_for_r: float,         # effective Λ used only in r(Λ) inside BY kernel
    L4_prev: float,
    delta_I_k: float,
    sim_config: SimConfig,
    d_sep: float,
) -> float:
    """Evaluate Θ(Λ) with BY kernel for one candidate, keeping L4=L4_prev in this tick."""
    rec = sim_config.scenario.receiver
    kernel_cfg, geom_consts = _map_like_config(sim_config)

    # Build the single-candidate parameter row
    s_t = rec.alpha_t / lam_phys
    s_x = rec.alpha_x / (rec.v_geom * lam_phys)

    params = torch.tensor([[
        np.log(max(delta_I_k, 1e-300)),
        np.log(max(s_t,      1e-300)),
        np.log(max(s_x,      1e-300)),
        np.log(max(lam_eff_for_r, 1e-300))
    ]], dtype=torch.float64, device=DEVICE)

    # Force L4 for this tick
    L4_batch = torch.full((1,), float(L4_prev), dtype=torch.float64, device=DEVICE)

    with torch.no_grad():
        theta = compute_by_batch(params, kernel_cfg, geom_consts, d_sep=d_sep, L4_batch=L4_batch, debug_print=False)
    return float(theta[0].item())


def _map_like_config(sim_config: SimConfig) -> Tuple[Dict, Dict]:
    """Lightweight reimplementation of map_config_to_kernels with only the pieces we need here."""
    from uom_simulator.utils import map_config_to_kernels
    kernel_cfg, geom_consts = map_config_to_kernels(sim_config)
    # We will overwrite L4 in- tick as needed; leave induced_gravity_C_m3 at baseline (κ_ref already baked in)
    return kernel_cfg, geom_consts


def _j_wall_varL4(
    lam_prev: float,
    lam_new: float,
    L4_prev: float,
    kappa_mid: float,
    delta_I_k: float,
    sim_config: SimConfig,
) -> float:
    """
    Call the variable-L4 wall kernel for a single candidate (midpoint κ approximation).
    """
    rec = sim_config.scenario.receiver
    phys = sim_config.physics

    # params_batch: [logΔI, log s_t(Λ_phys), log s_x(Λ_phys), log Λ_phys]
    s_t = rec.alpha_t / lam_new
    s_x = rec.alpha_x / (rec.v_geom * lam_new)
    params = torch.tensor([[
        np.log(max(delta_I_k, 1e-300)),
        np.log(max(s_t, 1e-300)),
        np.log(max(s_x, 1e-300)),
        np.log(max(lam_new, 1e-300))
    ]], dtype=torch.float64, device=DEVICE)

    wall_geom = dict(
        M5_cubed=float(phys.M5_cubed),
        m5_ell=float(phys.m5_ell),
        kappa_ct=float(kappa_mid),
        a_cft_rec=float(rec.a_cft_rec),
        L4_init=float(L4_prev),
        Lambda0=float(lam_prev),
        alpha_w=1.0,
    )

    with torch.no_grad():
        j = compute_wall_penalty_varL4_batch(params, wall_geom, lambda_prev=float(lam_prev), debug_print=False)
    return float(j[0].item())


def solve_next_lambda(
    F_dS_k: float,
    Lambda_prev: float,
    R_abs_prev: float,
    d_sep: float,
    sim_config: SimConfig,
    zeta: float = 1.0,
    kappa_spec: Optional[KappaRunSpec] = None,
    max_growth: float = 64.0,
    verbose: bool = False,
) -> SolveResult:
    """
    One-tick implicit solve for Λ_{k+1} with zero BY bank.
    Returns a SolveResult with the chosen Λ and bookkeeping.
    """
    if kappa_spec is None:
        kappa_spec = KappaRunSpec(model="const",
                                  kappa0=float(sim_config.physics.kappa_ct),
                                  lambda0=float(sim_config.scenario.aeon.initial_Lambda),
                                  b=0.0)

    rec = sim_config.scenario.receiver
    phys = sim_config.physics
    aeon = sim_config.scenario.aeon

    # Band fraction @ current Λ (receiver window & retarded knee)
    band_frac = _band_fraction_for_tick(Lambda_prev, d_sep, sim_config)

    # Dephasing exponent and per-tick payload (used only to set Θ amplitude scale)
    beta_k = sim_config.scenario.aeon.beta_factor * sim_config.scenario.source.H_src * band_frac * \
             (Lambda_prev / max(aeon.initial_Lambda, 1e-30)) ** 1.0

    F_dS_band = F_dS_k * band_frac
    delta_I_k = min(F_dS_k, (1.0 - np.exp(-beta_k)) * F_dS_band)

    # Geometry constants used repeatedly
    A_const = phys.M5_cubed / max(phys.m5_ell, 1e-30)
    a_cft = rec.a_cft_rec
    L4_prev = np.sqrt(12.0 / max(R_abs_prev, 1e-30))

    # κ reference used inside BY screening (the "induced_gravity_C_m3" was built with this at init)
    kappa_ref = KappaRunSpec(model="const",
                             kappa0=float(sim_config.physics.kappa_ct),
                             lambda0=float(aeon.initial_Lambda),
                             b=0.0).kappa(aeon.initial_Lambda)

    # Helper: objective f(Λ) whose root we seek
    def f_of(lam: float) -> Tuple[float, Dict]:
        lam = float(max(lam, Lambda_prev))  # no downward moves in this solver
        # running κ and effective λ for BY screening
        kap = kappa_spec.kappa(lam)
        lam_eff = lam * np.sqrt(max(kap, 1e-30) / max(kappa_ref, 1e-30))

        # Θ at candidate (one-candidate call)
        theta = _theta_at_candidate(lam_phys=lam, lam_eff_for_r=lam_eff,
                                    L4_prev=L4_prev, delta_I_k=delta_I_k,
                                    sim_config=sim_config, d_sep=d_sep)

        # Update curvature → new L4
        R_abs_new = max(R_abs_prev - theta, 1e-30)
        L4_new = np.sqrt(12.0 / R_abs_new)

        # ΔE_geom = E_prev - E_new
        E_prev = e_by_geom(Lambda_prev, L4_prev, a_cft, phys.M5_cubed, phys.m5_ell,
                           kappa_spec.kappa(Lambda_prev), zeta)
        E_new  = e_by_geom(lam, L4_new,  a_cft, phys.M5_cubed, phys.m5_ell, kap, zeta)
        dE = E_prev - E_new

        # J_wall with midpoint κ along path
        k_mid = kappa_spec.kappa(np.sqrt(lam * Lambda_prev))
        j_wall = _j_wall_varL4(Lambda_prev, lam, L4_prev, k_mid, delta_I_k, sim_config)

        return (j_wall - dE), dict(theta=theta, R_abs_new=R_abs_new, L4_new=L4_new, J=j_wall, dE=dE)

    # Trivial fixed point at Λ_prev. We search for the next nontrivial root.
    lam_lo = Lambda_prev * (1.0 + 1e-9)
    val_lo, info_lo = f_of(lam_lo)

    # If even a tiny step produces ~zero residual, accept minimal step
    if abs(val_lo) < 1e-14:
        return SolveResult(Lambda_next=lam_lo, Theta=info_lo["theta"],
                           R_abs_next=info_lo["R_abs_new"], L4_next=info_lo["L4_new"],
                           J_wall=info_lo["J"], DeltaE_geom=info_lo["dE"],
                           band_fraction=band_frac, beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                           status="tiny-step")

    # Try a monotone expansion until we bracket a sign change
    sign0 = np.sign(val_lo) if val_lo != 0.0 else 1.0
    lam_hi = lam_lo
    val_hi = val_lo
    info_hi = info_lo
    growth = 1.25
    cap = min(aeon.Lambda_star, Lambda_prev * max_growth)

    while lam_hi < cap and np.sign(val_hi) == sign0:
        lam_hi = min(cap, lam_hi * growth)
        val_hi, info_hi = f_of(lam_hi)

    # Case 1: we bracketed a root
    if np.sign(val_hi) != sign0:
        def fun(x): return f_of(x)[0]
        try:
            sol = root_scalar(fun, bracket=[lam_lo, lam_hi], method="brentq", xtol=1e-12, rtol=1e-9, maxiter=200)
            lam_star = float(sol.root if sol.converged else lam_lo)
            val_star, info_star = f_of(lam_star)
            status = "root-bracketed" if sol.converged else "root-fallback"
            return SolveResult(Lambda_next=lam_star, Theta=info_star["theta"],
                               R_abs_next=info_star["R_abs_new"], L4_next=info_star["L4_new"],
                               J_wall=info_star["J"], DeltaE_geom=info_star["dE"],
                               band_fraction=band_frac, beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                               status=status)
        except Exception:
            # fallthrough to grid fallback
            pass

    # Case 2: no sign change (flat or monotone). Pick the feasible Λ that minimizes |residual|.
    # Sample a modest grid up to 'cap'.
    grid = np.linspace(lam_lo, cap, 64)
    best = (abs(val_lo), lam_lo, info_lo)
    for x in grid[1:]:
        v, inf = f_of(float(x))
        if abs(v) < best[0]:
            best = (abs(v), float(x), inf)

    return SolveResult(Lambda_next=best[1], Theta=best[2]["theta"],
                       R_abs_next=best[2]["R_abs_new"], L4_next=best[2]["L4_new"],
                       J_wall=best[2]["J"], DeltaE_geom=best[2]["dE"],
                       band_fraction=band_frac, beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                       status="grid-min")