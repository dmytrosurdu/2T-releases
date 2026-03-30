# uom_simulator/utils.py

import math
import numpy as np
from scipy.optimize import brentq
from typing import Dict, Any, Optional, Tuple

import torch  # NEW: used for per-batch L4 evaluation (kept CPU/GPU agnostic)

from uom_simulator.config import SimConfig


# --------------------------------------------------------------------------------------
# 0) Geometric/physics helpers (kept from your original with docstrings added)
# --------------------------------------------------------------------------------------

def compute_degeneracy(l_max: int) -> np.ndarray:
    """Degeneracy D_ℓ = (ℓ+1)^2 on S^3, for ℓ = 0..l_max."""
    ells = np.arange(l_max + 1)
    return (ells + 1) ** 2


def compute_eigenvalues(l_max: int) -> np.ndarray:
    """S^3 Laplacian eigenvalues λ_ℓ = ℓ(ℓ+2), for ℓ = 0..l_max."""
    ells = np.arange(l_max + 1)
    return ells * (ells + 2)


def M4_sq(Lambda: float, m5_ell: float, a_cft: float, kappa_ct: float, M5_cubed: float) -> float:
    """
    Surrogate for the induced 4D Planck mass (squared) on the brane:
        M4^2(Λ) = M5^3 * ℓ + κ_ct * a_cft * Λ^2.
    """
    return M5_cubed * m5_ell + kappa_ct * a_cft * (Lambda ** 2)


def r_screen(Lambda: float, m5_ell: float, a_cft: float, kappa_ct: float, M5_cubed: float) -> float:
    """
    Screening strength r(Λ) used in BY kernel:
        r(Λ) = M4^2(Λ) / (2 M5^3).
    """
    return M4_sq(Lambda, m5_ell, a_cft, kappa_ct, M5_cubed) / (2.0 * M5_cubed)


def window_ell(ell: np.ndarray, L4: float, Lambda: float, cL: float, deltaL: float) -> np.ndarray:
    """
    Soft S^3 mode window with knee ℓ_max ≈ cL * L4 * Λ.
    """
    ell_max = cL * L4 * Lambda
    return 1.0 / (1.0 + np.exp((ell - ell_max) / max(deltaL, 1e-9)))


def acceptance_flat_G12_sq(k: float, m_bullet: float, d: float, r1: float, r2: float) -> float:
    """
    Flat-space two-wall acceptance factor |G12|^2 with finite separation d, bullet mass m_bullet.
    """
    q = math.sqrt(max(0.0, k ** 2 + m_bullet ** 2))
    if q <= 1e-9:
        return 0.0

    qd = q * d
    if qd > 70:
        coth_qd = 1.0
        csch_qd = 2.0 * math.exp(-qd)
    else:
        try:
            exp_2qd = math.exp(2.0 * qd)
            if exp_2qd == 1.0:
                return 0.0
            coth_qd = (exp_2qd + 1.0) / (exp_2qd - 1.0)
            sinh_qd = 0.5 * (math.exp(qd) - math.exp(-qd))
            csch_qd = 1.0 / sinh_qd if sinh_qd > 1e-30 else 0.0
        except (OverflowError, ZeroDivisionError):
            coth_qd, csch_qd = 1.0, 0.0

    A1 = r1 * k ** 2 + q * coth_qd
    A2 = r2 * k ** 2 + q * coth_qd
    C = q * csch_qd

    determinant = A1 * A2 - C ** 2
    if abs(determinant) < 1e-40:
        return 0.0

    G12 = C / determinant
    return G12 ** 2


def K_BY(Lambda: float, alpha_t: float, alpha_x: float, v_geom: float,
         gamma_anomaly: float, C_LoG: float, G_throughput: float, avg_kernel_sq: float) -> float:
    """
    Older analytic surrogate for BY throughput scaling (unused by GPU kernels, kept for completeness).
    """
    if Lambda <= 1e-9:
        return 0.0
    s_t = alpha_t / Lambda
    s_x = alpha_x / (v_geom * Lambda)
    denominator = s_t * (s_x ** 3) * G_throughput
    if denominator < 1e-40:
        return 0.0
    G4_sq_8pi_sq = (8 * math.pi) ** 2
    return gamma_anomaly * G4_sq_8pi_sq * C_LoG * (avg_kernel_sq / denominator)


# Legacy RG “mu/lambda” helpers (not used by the new wall kernel, kept for compatibility)
def mu_rg(Lambda: float, mu_rg0: float, mu_rg2: float) -> float:
    return mu_rg0 + mu_rg2 * (Lambda ** 2)


def lambda_rg(Lambda: float, mu_rg0: float, mu_rg2: float) -> float:
    return mu_rg0 * Lambda + (mu_rg2 / 3.0) * (Lambda ** 3)


def inverse_lambda_rg(lambda_val: float, mu_rg0: float, mu_rg2: float) -> float:
    if lambda_val < 0:
        return 0.0
    if abs(mu_rg2) < 1e-9:
        return lambda_val / mu_rg0 if mu_rg0 > 0 else 0.0
    try:
        upper_bound = (3 * abs(lambda_val) / max(abs(mu_rg2), 1e-9)) ** (1 / 3) * 2 + 10
        root = brentq(lambda L: lambda_rg(L, mu_rg0, mu_rg2) - lambda_val, 0, upper_bound)
        return root
    except (ValueError, RuntimeError):
        return (3 * abs(lambda_val) / max(abs(mu_rg2), 1e-9)) ** (1 / 3) if mu_rg2 > 0 else 0.0


# --------------------------------------------------------------------------------------
# 1) Curvature-radius ↔︎ scalar-curvature helpers (useful for initialization/debug)
# --------------------------------------------------------------------------------------

def R0_from_L4(L4: float) -> float:
    """Static-patch scalar curvature R0 ≈ 12 / L4^2 (sign handled elsewhere)."""
    if L4 <= 1e-30:
        return float('inf')
    return 12.0 / (L4 * L4)


def L4_from_R0(R0_abs: float) -> float:
    """Inverse of the above: L4 = sqrt(12 / |R0|)."""
    if R0_abs <= 0:
        return float('inf')
    return math.sqrt(12.0 / R0_abs)


# --------------------------------------------------------------------------------------
# 2) map_config_to_kernels — now includes L4_init & a default L4 drift section
# --------------------------------------------------------------------------------------

def map_config_to_kernels(config: SimConfig) -> Tuple[Dict[str, Any], Dict[str, Any]]:
    """
    Translates SimConfig into kernel configuration + geometry constants.

    Adds:
      - geometry_constants['L4_init'] for downstream L4(Λ) evaluation.
      - kernel_config['surrogate']['l4_drift'] with defaults (curvature-locked).
    """
    sc = config.scenario
    phys = config.physics
    rec = sc.receiver

    # gamma anomaly
    gamma_anomaly = phys.gamma_anomaly
    if gamma_anomaly < 0:
        gamma_anomaly = (phys.m5_ell ** 2) / 96.0

    geometry_constants = {
        "gamma": gamma_anomaly,
        "G4": 1.0,  # normalization absorbed elsewhere
        "L4": rec.L4_init,            # kept for backward-compat kernels
        "L4_init": rec.L4_init,       # NEW: explicit initial radius
        "m_g": 1.0 / rec.L4_init,
        "ads5_radius_ell": phys.m5_ell,
        "induced_gravity_C_m3": (phys.kappa_ct * rec.a_cft_rec) / (2.0 * phys.M5_cubed),
        # stash Planck/tension params to avoid threading SimConfig everywhere
        "M5_cubed": phys.M5_cubed,
        "kappa_ct": phys.kappa_ct,
        "a_cft_rec": rec.a_cft_rec,
        "m5_ell": phys.m5_ell,
        # a sensible reference Λ (initial Λ) for tension-coupled drift
        "lambda_ref": float(sc.aeon.initial_Lambda) if hasattr(sc, "aeon") else 1.0,
    }

    GEV_TO_INV_METERS = 5.068e15
    kernel_config = {
        "utils": {"GEV_TO_INV_METERS": GEV_TO_INV_METERS},
        "geometry": {"ads4_radius_L4": rec.L4_init},  # reference gap for m_phys in CONF
        "receiver": {"os_rp_grid": {"mu": 1.0, "N_tau": 64}},
        "surrogate": {
            "grid_config": {"n_omega": 128, "n_ell": 64, "dimensionless_u_max": 10.0},
            "conf_kernel_config": {
                "weyl_basis_vectors": 3,
                "num_cubature_points": 8,
                "blur_c": 1.0,
                "blur_sigma_floor": 1e-6
            },
            "rp_kernel_config": {},
            # NEW: default L4 drift mode; override in your config if desired
            "l4_drift": {
                #"mode": "curvature-locked",  # "tension-coupled" or "target-curvature"
                "mode":"tension-coupled", #or "target-curvature"
                "drift_alpha": 1.0           # power on M4^2 ratio for tension-coupled mode
            }
        }
    }

    return kernel_config, geometry_constants


# --------------------------------------------------------------------------------------
# 3) L4(Λ) evaluator used by the optimizer to build L4_batch for BY/CONF
# --------------------------------------------------------------------------------------

def eval_L4_of_lambda_batch(
    lambda_batch: torch.Tensor,                 # [B] (float64 or float32)
    kernel_config: Dict[str, Any],
    geometry_constants: Dict[str, Any],
    r0_abs_target: Optional[float] = None,      # required if mode == "target-curvature"
    lambda_ref: Optional[float] = None,         # optional override of reference Λ for tension-coupled
) -> torch.Tensor:
    """
    Produces a per-candidate L4(Λ) vector [B] according to a selectable drift rule:

      mode = "curvature-locked":
          L4(Λ) = L4_init.
      mode = "target-curvature":
          L4(Λ) = sqrt(12 / |R0_target|)  (ignores Λ; useful for debugging).
      mode = "tension-coupled":
          L4(Λ) = L4_init * [ M4^2(Λ_ref) / M4^2(Λ) ]^(alpha/2).

    The "tension-coupled" rule uses your surrogate M4^2(Λ)=M5^3*ℓ + κ_ct * a_cft * Λ^2.
    This is a *controlled* way to let the 3-sphere radius drift mildly with the wall tension.

    Returns:
        torch.Tensor [B] (float64) on the same device as lambda_batch.
    """
    dev = lambda_batch.device
    dtype = torch.float64 if lambda_batch.dtype == torch.float64 else torch.float64
    lam = lambda_batch.to(device=dev, dtype=dtype).view(-1)

    # Pull defaults / constants
    l4_drift = kernel_config.get("surrogate", {}).get("l4_drift", {})
    mode = str(l4_drift.get("mode", "curvature-locked")).lower()
    alpha = float(l4_drift.get("drift_alpha", 1.0))

    L4_init = float(geometry_constants.get("L4_init", geometry_constants.get("L4", 100.0)))
    m5_ell = float(geometry_constants["m5_ell"])
    M5_cubed = float(geometry_constants["M5_cubed"])
    kappa_ct = float(geometry_constants["kappa_ct"])
    a_cft_rec = float(geometry_constants["a_cft_rec"])

    lam_ref = float(lambda_ref if lambda_ref is not None
                    else geometry_constants.get("lambda_ref", 1.0))

    if mode == "curvature-locked":
        return torch.full_like(lam, L4_init, dtype=dtype, device=dev)

    if mode == "target-curvature":
        if r0_abs_target is None or r0_abs_target <= 0:
            # Fall back to L4_init if invalid target provided
            return torch.full_like(lam, L4_init, dtype=dtype, device=dev)
        L4_target = L4_from_R0(r0_abs_target)
        return torch.full_like(lam, L4_target, dtype=dtype, device=dev)

    if mode == "tension-coupled":
        # L4(Λ) = L4_init * ( M4^2(Λ_ref) / M4^2(Λ) )^(alpha/2)
        # Vectorized M4^2(Λ)
        M4_sq_ref = M4_sq(lam_ref, m5_ell, a_cft_rec, kappa_ct, M5_cubed)
        M4_sq_vec = M4_sq(lam.cpu().numpy(), m5_ell, a_cft_rec, kappa_ct, M5_cubed)  # scalar func; make vector
        M4_sq_vec = torch.from_numpy(np.asarray(M4_sq_vec, dtype=np.float64)).to(device=dev, dtype=dtype)

        ratio = (M4_sq_ref / torch.clamp(M4_sq_vec, min=1e-30))
        scale = torch.pow(torch.clamp(ratio, min=1e-30), alpha / 2.0)
        return torch.clamp(L4_init * scale, min=1e-12, max=1e30)

    # Unknown mode → safe fallback
    return torch.full_like(lam, L4_init, dtype=dtype, device=dev)
