
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
from typing import Dict, Tuple, Optional, Literal
import copy
import math
import os

import numpy as np
import torch
from scipy.optimize import root_scalar, minimize_scalar

from uom_simulator.config import SimConfig
from uom_simulator.utils import window_ell, compute_degeneracy
from uom_simulator.shadow_sector import ShadowStack, mass_eff
from uom_simulator.split_landau import solve_landau_minima, LandauParams, SplitCurvatures
from uom_simulator.tangents import build_delta_c_tangent
from uom_simulator.rg_complement_leak import compute_j_rp_single, compute_q_rg, beta_ds
from uom_simulator.external.penalties_calculator.core.utils import DEVICE
from uom_simulator.external.penalties_calculator.core.by_kernel import compute_by_batch
from uom_simulator.external.penalties_calculator.core.wall_kernel import compute_wall_penalty_varL4_batch


_UNDERFLOW_DIAG_MAX = int(os.getenv("UOM_THETA_DIAG_MAX", "5"))
_UNDERFLOW_DIAG_COUNT = 0


def _maybe_log_theta_underflow(*, Lambda_prev: float, Lambda_next: float, theta: float,
                               delta_I_k: float, d_sep: float, L4_prev: float,
                               alpha_t: float, grid_cfg: Dict, m_g: float,
                               band_frac: float, beta_k: float, status: str) -> None:
    global _UNDERFLOW_DIAG_COUNT
    if _UNDERFLOW_DIAG_COUNT >= _UNDERFLOW_DIAG_MAX:
        return
    if not os.getenv("UOM_THETA_DIAG"):
        return

    n_ell = int(grid_cfg.get("n_ell", 64))
    u_max = float(grid_cfg.get("dimensionless_u_max", 10.0))
    s_t = alpha_t / max(float(Lambda_next), 1e-300)
    omega_max = u_max / max(s_t, 1e-300)
    k_max = (n_ell + 1.0) / max(float(L4_prev), 1e-300)
    q_max = math.sqrt(k_max * k_max + float(m_g) * float(m_g) + omega_max * omega_max)
    log_atten = -float(d_sep) * q_max if d_sep > 0 else 0.0
    log_delta_i = math.log(max(float(delta_I_k), 1e-300))

    diag_thresh = float(os.getenv("UOM_THETA_DIAG_THRESH", "0.0"))
    log_theta = (diag_thresh > 0.0 and abs(theta) <= diag_thresh)

    # Log only if Theta is zero/suspicious or attenuation underflows.
    if theta == 0.0 or log_theta or not math.isfinite(theta) or log_atten < -700.0 or log_delta_i <= -690.0:
        _UNDERFLOW_DIAG_COUNT += 1
        print(
            "[THETA_DIAG] status={status} "
            "Lambda_prev={lam_prev:.6g} Lambda_next={lam_next:.6g} "
            "Theta={theta:.3e} delta_I={delta_i:.3e} log_delta_I={log_di:.2f} "
            "band_frac={band:.3e} beta_k={beta:.3e} d_sep={d_sep:.6g} "
            "L4_prev={l4:.6g} n_ell={n_ell} u_max={u_max:.3g} "
            "omega_max={omega:.3e} k_max={kmax:.3e} q_max={qmax:.3e} "
            "log_att={log_att:.2f}".format(
                status=status,
                lam_prev=Lambda_prev,
                lam_next=Lambda_next,
                theta=theta,
                delta_i=delta_I_k,
                log_di=log_delta_i,
                band=band_frac,
                beta=beta_k,
                d_sep=d_sep,
                l4=L4_prev,
                n_ell=n_ell,
                u_max=u_max,
                omega=omega_max,
                kmax=k_max,
                qmax=q_max,
                log_att=log_atten,
            )
        )


# -----------------------------
# κ(Λ) running models
# -----------------------------

KappaModel = Literal["const", "log", "power", "riccati"]

SplitObjective = Literal["abs_resid", "resid2"]
SplitMinimizer = Literal["grid", "grid_then_refine"]
TickEventType = Literal["move", "split", "stall", "stop"]

@dataclass
class SplitParams:
    enabled: bool = True
    objective: SplitObjective = "resid2"
    minimizer: SplitMinimizer = "grid_then_refine"
    grid_n: int = 128
    eps_lambda_step: Optional[float] = None

@dataclass
class SplitEvent:
    Lambda_star: float
    Theta_star: float
    R_prev: float
    Q_rg_star: float
    J_RP_star: float
    beta_dS: float
    DeltaE_geom_star: float
    J_wall_star: float
    Q0: float
    resid_star: float
    fpp_star: Optional[float]
    imag_root_proxy: Optional[float]
    landau: LandauParams
    split_curvatures: SplitCurvatures
    M_ads: float
    M_ds: float

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
    R_next: float
    L4_next: float
    J_wall: float
    Q_rg: float
    J_RP: float
    DeltaE_geom: float
    Residual: float
    band_fraction: float
    beta_k: float
    delta_I_k: float
    status: str
    event_type: TickEventType = "move"
    split: Optional[SplitEvent] = None


def _band_fraction_for_tick(Lambda_rec: float, d_sep: float, sim_config: SimConfig) -> float:
    """
    Rebuild the same band fraction used in the previous driver:
      band_fraction = sum(taper * window * degeneracy) / sum(window * degeneracy).
    """
    # TEMP: skip bandlimit control entirely (force full payload acceptance).
    return 1.0

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

    # Receiver soft window with constant cL=1 so ℓ_max ≈ L4 * Λ.
    win = window_ell(
        ells, sim_config.scenario.receiver.L4_init, Lambda_rec,
        1.0, sim_config.scenario.receiver.deltaL_soft
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
    R_prev: float,
    d_sep: float,
    sim_config: SimConfig,
    zeta: float = 1.0,
    kappa_spec: Optional[KappaRunSpec] = None,
    shadow_stack: Optional[ShadowStack] = None,
    split_params: Optional[SplitParams] = None,
    max_growth: float = 64.0,
    verbose: bool = False,
) -> SolveResult:
    """
    One-tick implicit solve for Λ_{k+1} with signed curvature R.
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
    if split_params is None:
        split_params = SplitParams()
    if shadow_stack is None:
        shadow_stack = ShadowStack()
    shadow_params = sim_config.shadow
    split_model = sim_config.split_model
    eps_num = float(split_model.eps_num)
    leak_model = str(sim_config.leak.model).lower()
    if leak_model not in ("none", "rg_complement"):
        raise ValueError(f"unsupported leak.model: {leak_model}")
    beta_dS = beta_ds(sim_config.scenario.source.H_src)
    kernel_cfg, geom_consts = _map_like_config(sim_config)
    grid_cfg = kernel_cfg.get("surrogate", {}).get("grid_config", {})
    m_g = float(geom_consts.get("m_g", 0.0))

    # Band fraction @ current Λ (receiver window & retarded knee)
    band_frac = _band_fraction_for_tick(Lambda_prev, d_sep, sim_config)

    # Dephasing exponent and per-tick payload (used only to set Θ amplitude scale)
    beta_k = sim_config.scenario.aeon.beta_factor * sim_config.scenario.source.H_src * band_frac * \
             (Lambda_prev / max(aeon.initial_Lambda, 1e-30)) ** 1.0

    F_dS_band = F_dS_k * band_frac
    # Use expm1 for small beta_k to avoid catastrophic cancellation.
    delta_I_k = min(F_dS_k, (-np.expm1(-beta_k)) * F_dS_band)

    # Geometry constants used repeatedly
    A_const = phys.M5_cubed / max(phys.m5_ell, 1e-30)
    a_cft = rec.a_cft_rec
    if not np.isfinite(R_prev):
        raise ValueError("R_prev must be finite.")
    L4_prev = np.sqrt(12.0 / max(abs(R_prev), eps_num))
    if R_prev >= 0.0:
        return SolveResult(
            Lambda_next=Lambda_prev,
            Theta=0.0,
            R_next=float(R_prev),
            L4_next=float(L4_prev),
            J_wall=0.0,
            Q_rg=0.0,
            J_RP=0.0,
            DeltaE_geom=0.0,
            Residual=0.0,
            band_fraction=band_frac,
            beta_k=float(beta_k),
            delta_I_k=float(delta_I_k),
            status="invalid_state",
            event_type="stop",
        )

    kernel_cfg_rp = None
    geom_rp = None
    if leak_model == "rg_complement":
        kernel_cfg_rp = copy.deepcopy(kernel_cfg)
        kernel_cfg_rp["geometry"]["ads4_radius_L4"] = float(L4_prev)
        geom_rp = dict(geom_consts)
        geom_rp["L4"] = float(L4_prev)

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

        s_t = rec.alpha_t / lam
        s_x = rec.alpha_x / (rec.v_geom * lam)

        # Θ at candidate (one-candidate call)
        theta = _theta_at_candidate(lam_phys=lam, lam_eff_for_r=lam_eff,
                                    L4_prev=L4_prev, delta_I_k=delta_I_k,
                                    sim_config=sim_config, d_sep=d_sep)

        # Update curvature → new L4 (signed update; no clamps)
        R_new = R_prev + theta
        L4_new = np.sqrt(12.0 / max(abs(R_new), eps_num))

        # ΔE_geom = E_prev - E_new
        E_prev = e_by_geom(Lambda_prev, L4_prev, a_cft, phys.M5_cubed, phys.m5_ell,
                           kappa_spec.kappa(Lambda_prev), zeta)
        E_new  = e_by_geom(lam, L4_new,  a_cft, phys.M5_cubed, phys.m5_ell, kap, zeta)
        dE = E_prev - E_new

        # J_wall with midpoint κ along path
        k_mid = kappa_spec.kappa(np.sqrt(lam * Lambda_prev))
        j_wall = _j_wall_varL4(Lambda_prev, lam, L4_prev, k_mid, delta_I_k, sim_config)

        j_rp = 0.0
        q_rg = 0.0
        if leak_model == "rg_complement":
            delta_C = build_delta_c_tangent(delta_I_k, s_t, s_x, grid_cfg)
            params_rp = torch.tensor([[
                np.log(max(delta_I_k, 1e-300)),
                np.log(max(s_t, 1e-300)),
                np.log(max(s_x, 1e-300)),
                np.log(max(lam, 1e-300)),
            ]], dtype=torch.float64, device=DEVICE)
            j_rp = compute_j_rp_single(delta_C, params_rp, kernel_cfg_rp, geom_rp)
            q_rg = compute_q_rg(j_rp, sim_config.scenario.source.H_src, sim_config.leak.chi)

        resid = (j_wall + q_rg - dE)
        return resid, dict(theta=theta, R_new=R_new, L4_new=L4_new, J=j_wall,
                           Q_rg=q_rg, J_RP=j_rp, beta_dS=beta_dS, dE=dE, resid=resid)

    def objective(resid: float) -> float:
        if split_params.objective == "abs_resid":
            return abs(resid)
        return float(resid) * float(resid)

    def minimize_residual(lam_start: float, lam_end: float) -> Tuple[float, float, Dict]:
        grid = np.geomspace(lam_start, lam_end, max(3, int(split_params.grid_n)))
        best = (float("inf"), float(grid[0]), None)
        best_idx = 0
        for idx, x in enumerate(grid):
            v, inf = f_of(float(x))
            obj = objective(v)
            if obj < best[0]:
                best = (obj, float(x), inf)
                best_idx = idx

        lam_star = best[1]
        info_star = best[2]
        resid_star = info_star["resid"]

        if split_params.minimizer == "grid_then_refine" and 0 < best_idx < (len(grid) - 1):
            a = float(grid[best_idx - 1])
            b = float(grid[best_idx])
            c = float(grid[best_idx + 1])

            def obj_fun(x: float) -> float:
                v, _ = f_of(float(x))
                return objective(v)

            try:
                sol = minimize_scalar(
                    obj_fun,
                    bracket=(a, b, c),
                    method="brent",
                    options={"maxiter": 200, "xtol": 1e-20},
                )
                if sol.success:
                    lam_star = float(sol.x)
                    resid_star, info_star = f_of(lam_star)
            except Exception:
                pass

        return lam_star, float(resid_star), info_star

    def stop_negative_leak(lam: float, info: Dict) -> SolveResult:
        return SolveResult(
            Lambda_next=float(lam),
            Theta=float(info["theta"]),
            R_next=float(info["R_new"]),
            L4_next=float(info["L4_new"]),
            J_wall=float(info["J"]),
            Q_rg=float(info["Q_rg"]),
            J_RP=float(info["J_RP"]),
            DeltaE_geom=float(info["dE"]),
            Residual=float(info["resid"]),
            band_fraction=band_frac,
            beta_k=float(beta_k),
            delta_I_k=float(delta_I_k),
            status="negative_leak_detected",
            event_type="stop",
        )

    def diag_underflow(lam: float, info: Dict, status: str) -> None:
        _maybe_log_theta_underflow(
            Lambda_prev=Lambda_prev,
            Lambda_next=lam,
            theta=float(info["theta"]),
            delta_I_k=float(delta_I_k),
            d_sep=float(d_sep),
            L4_prev=float(L4_prev),
            alpha_t=float(rec.alpha_t),
            grid_cfg=grid_cfg,
            m_g=m_g,
            band_frac=float(band_frac),
            beta_k=float(beta_k),
            status=status,
        )

    # Trivial fixed     point at Λ_prev. We search for the next nontrivial root.
    eps_lambda = split_params.eps_lambda_step
    if eps_lambda is None:
        eps_lambda = split_model.eps_lambda
    lam_lo = Lambda_prev * (1.0 + eps_lambda)
    val_lo, info_lo = f_of(lam_lo)

    neg_tol = 0.0

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
            sol = root_scalar(fun, bracket=[lam_lo, lam_hi], method="brentq", xtol=1e-20, rtol=1e-16, maxiter=500)
            lam_star = float(sol.root if sol.converged else lam_lo)
            val_star, info_star = f_of(lam_star)
            status = "root-bracketed" if sol.converged else "root-fallback"
            if float(info_star["Q_rg"]) < -neg_tol or not np.isfinite(float(info_star["Q_rg"])):
                return stop_negative_leak(lam_star, info_star)
            r_new = float(info_star["R_new"])
            if r_new >= 0.0:
                diag_underflow(lam_star, info_star, "unexpected_curvature_crossing")
                return SolveResult(Lambda_next=lam_star, Theta=info_star["theta"],
                                   R_next=r_new, L4_next=info_star["L4_new"],
                                   J_wall=info_star["J"], Q_rg=info_star["Q_rg"], J_RP=info_star["J_RP"],
                                   DeltaE_geom=info_star["dE"],
                                   Residual=info_star["resid"], band_fraction=band_frac,
                                   beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                                   status="unexpected_curvature_crossing", event_type="stop")
            diag_underflow(lam_star, info_star, status)
            return SolveResult(Lambda_next=lam_star, Theta=info_star["theta"],
                               R_next=r_new, L4_next=info_star["L4_new"],
                               J_wall=info_star["J"], Q_rg=info_star["Q_rg"], J_RP=info_star["J_RP"],
                               DeltaE_geom=info_star["dE"],
                               Residual=info_star["resid"], band_fraction=band_frac,
                               beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                               status=status, event_type="move")
        except Exception:
            # fallthrough to grid fallback
            pass

    # Case 2: no sign change (flat or monotone). Minimize residual and decide split vs. approximate move.
    lam_star, resid_star, info_star = minimize_residual(lam_lo, cap)
    tol = float(split_model.split_resid_tol)

    if abs(resid_star) <= tol or not split_params.enabled:
        if float(info_star["Q_rg"]) < -neg_tol or not np.isfinite(float(info_star["Q_rg"])):
            return stop_negative_leak(lam_star, info_star)
        r_new = float(info_star["R_new"])
        if r_new >= 0.0:
            diag_underflow(lam_star, info_star, "unexpected_curvature_crossing")
            return SolveResult(Lambda_next=lam_star, Theta=info_star["theta"],
                               R_next=r_new, L4_next=info_star["L4_new"],
                               J_wall=info_star["J"], Q_rg=info_star["Q_rg"], J_RP=info_star["J_RP"],
                               DeltaE_geom=info_star["dE"],
                               Residual=info_star["resid"], band_fraction=band_frac,
                               beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                               status="unexpected_curvature_crossing", event_type="stop")
        diag_underflow(lam_star, info_star, "approx-min")
        return SolveResult(Lambda_next=lam_star, Theta=info_star["theta"],
                           R_next=r_new, L4_next=info_star["L4_new"],
                           J_wall=info_star["J"], Q_rg=info_star["Q_rg"], J_RP=info_star["J_RP"],
                           DeltaE_geom=info_star["dE"],
                           Residual=info_star["resid"], band_fraction=band_frac,
                           beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                           status="approx-min", event_type="move")

    # Split event: derive Landau parameters and two signed curvatures.
    if float(info_star["Q_rg"]) < -neg_tol or not np.isfinite(float(info_star["Q_rg"])):
        return stop_negative_leak(lam_star, info_star)

    Theta_star = float(info_star["theta"])
    dE_star = float(info_star["dE"])
    J_star = float(info_star["J"])
    Q_rg_star = float(info_star["Q_rg"])
    J_RP_star = float(info_star["J_RP"])
    Q0 = float(Q_rg_star)

    theta_gate = max(float(split_model.theta_min_abs),
                     float(split_model.theta_min_rel) * max(abs(R_prev), eps_num))
    if not np.isfinite(Theta_star) or abs(Theta_star) <= theta_gate:
        diag_underflow(lam_star, info_star, "split_failed")
        return SolveResult(Lambda_next=lam_star, Theta=Theta_star,
                           R_next=float(info_star["R_new"]), L4_next=info_star["L4_new"],
                           J_wall=J_star, Q_rg=Q_rg_star, J_RP=J_RP_star, DeltaE_geom=dE_star,
                           Residual=float(resid_star), band_fraction=band_frac,
                           beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                           status="split_failed", event_type="stop")

    a = float(split_model.landau_s_a) * abs(Theta_star)
    K = float(4.0 * abs(Q0))
    if not np.isfinite(K) or K <= 0.0:
        diag_underflow(lam_star, info_star, "split_failed")
        return SolveResult(Lambda_next=lam_star, Theta=Theta_star,
                           R_next=float(info_star["R_new"]), L4_next=info_star["L4_new"],
                           J_wall=J_star, Q_rg=Q_rg_star, J_RP=J_RP_star, DeltaE_geom=dE_star,
                           Residual=float(resid_star), band_fraction=band_frac,
                           beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                           status="split_failed", event_type="stop")

    b = 0.0

    # Diagnostic: local quadratic approximation in log Λ
    fpp_star = None
    imag_root_proxy = None
    try:
        h = 1e-3
        lam_p = float(lam_star * np.exp(h))
        lam_m = float(lam_star * np.exp(-h))
        f_p, _ = f_of(lam_p)
        f_m, _ = f_of(lam_m)
        fpp_star = float((f_p - 2.0 * resid_star + f_m) / (h * h))
        if fpp_star > 0.0 and resid_star > 0.0:
            imag_root_proxy = float(lam_star * np.sqrt(2.0 * resid_star / fpp_star))
    except Exception:
        fpp_star = None
        imag_root_proxy = None

    try:
        split_curvatures = solve_landau_minima(
            a=a,
            K=K,
            b=b,
            Q0=Q0,
            eps=split_model.landau_eps,
            delta_U_shadow=None,
        )
    except Exception:
        diag_underflow(lam_star, info_star, "split_failed")
        return SolveResult(Lambda_next=lam_star, Theta=Theta_star,
                           R_next=float(info_star["R_new"]), L4_next=info_star["L4_new"],
                           J_wall=J_star, Q_rg=Q_rg_star, J_RP=J_RP_star, DeltaE_geom=dE_star,
                           Residual=float(resid_star), band_fraction=band_frac,
                           beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                           status="split_failed", event_type="stop")

    M_ads = mass_eff(lam_star, split_curvatures.R_ads, rec.a_cft_rec, sim_config, shadow_params)
    M_ds = mass_eff(lam_star, split_curvatures.R_ds, sim_config.scenario.source.a_cft_src, sim_config, shadow_params)

    split = SplitEvent(
        Lambda_star=float(lam_star),
        Theta_star=Theta_star,
        R_prev=float(R_prev),
        Q_rg_star=Q_rg_star,
        J_RP_star=J_RP_star,
        beta_dS=float(beta_dS),
        DeltaE_geom_star=dE_star,
        J_wall_star=J_star,
        Q0=float(Q0),
        resid_star=float(resid_star),
        fpp_star=fpp_star,
        imag_root_proxy=imag_root_proxy,
        landau=split_curvatures.landau,
        split_curvatures=split_curvatures,
        M_ads=float(M_ads),
        M_ds=float(M_ds),
    )

    diag_underflow(lam_star, info_star, "split")
    return SolveResult(Lambda_next=lam_star, Theta=Theta_star,
                       R_next=split_curvatures.R_ads,
                       L4_next=float(np.sqrt(12.0 / max(abs(split_curvatures.R_ads), eps_num))),
                       J_wall=J_star, Q_rg=Q_rg_star, J_RP=J_RP_star, DeltaE_geom=dE_star,
                       Residual=float(resid_star), band_fraction=band_frac,
                       beta_k=float(beta_k), delta_I_k=float(delta_I_k),
                       status="split", event_type="split", split=split)
