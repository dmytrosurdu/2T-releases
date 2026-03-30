# uom_simulator/external/penalties_calculator/core/wall_kernel.py
import math
from typing import Dict

import numpy as np
import torch
from .utils import DEVICE

def _to_tensor(x, dtype=torch.float64):
    if isinstance(x, torch.Tensor):
        return x.to(dtype=dtype, device=DEVICE)
    return torch.tensor(x, dtype=dtype, device=DEVICE)

@torch.no_grad()
def compute_wall_penalty_batch(
    params_batch: torch.Tensor,
    wall_constants: Dict[str, float],
    lambda_prev: float,
    debug_print: bool = False,
) -> torch.Tensor:
    # legacy constant-L4 closed form (kept for tests)
    params_batch_64 = params_batch.to(dtype=torch.float64, device=DEVICE)
    lam = torch.exp(params_batch_64[:, 3]).clamp(min=1e-300)

    alpha_w = float(wall_constants.get("alpha_w", 1.0))
    A = float(wall_constants.get("A", 0.0))
    B = float(wall_constants.get("B", 0.0))
    lam_prev = max(float(lambda_prev), 1e-300)

    ratio = lam / lam_prev
    log_ratio = torch.log(ratio)
    quad = 0.5 * (lam * lam - lam_prev * lam_prev)

    j_wall = alpha_w * (A * log_ratio + B * quad)
    j_wall = torch.where(j_wall.abs() < 1e-24, torch.zeros_like(j_wall), j_wall)
    j_wall = torch.nan_to_num(j_wall, nan=0.0, posinf=1e300, neginf=-1e300)
    return j_wall

def _M4_sq(lambda_val: torch.Tensor, M5_cubed: float, m5_ell: float,
           kappa_ct: float, a_cft_rec: float) -> torch.Tensor:
    return _to_tensor(M5_cubed*m5_ell, lambda_val.dtype) + _to_tensor(kappa_ct*a_cft_rec, lambda_val.dtype) * (lambda_val ** 2)

def _L4_of_lambda(lambda_val: torch.Tensor, M5_cubed: float, m5_ell: float,
                  kappa_ct: float, a_cft_rec: float, Lambda4_eff_const: float) -> torch.Tensor:
    M4_sq = _M4_sq(lambda_val, M5_cubed, m5_ell, kappa_ct, a_cft_rec)
    return torch.sqrt(3.0 * M4_sq / _to_tensor(Lambda4_eff_const, lambda_val.dtype)).clamp(min=1e-18)

def _A_of_lambda(L4_val: torch.Tensor, M5_cubed: float, m5_ell: float) -> torch.Tensor:
    return 12.0 * _to_tensor(M5_cubed, L4_val.dtype) * (2.0 * L4_val + _to_tensor(m5_ell, L4_val.dtype)) / (L4_val ** 3)

def _B_of_lambda(L4_val: torch.Tensor, kappa_ct: float, a_cft_rec: float) -> torch.Tensor:
    return 12.0 * _to_tensor(kappa_ct * a_cft_rec, L4_val.dtype) / (L4_val ** 3)

@torch.no_grad()
def compute_wall_penalty_varL4_batch(
    params_batch: torch.Tensor,
    wall_geom: Dict[str, float],
    lambda_prev: float,
    n_quad: int = 16,
    debug_print: bool = False,
) -> torch.Tensor:
    dtype = torch.float64
    params_batch = params_batch.to(dtype=dtype, device=DEVICE)
    lam = torch.exp(params_batch[:, 3]).clamp(min=1e-300)
    lam_prev = _to_tensor(max(float(lambda_prev), 1e-300), dtype)

    M5_cubed = float(wall_geom["M5_cubed"])
    m5_ell = float(wall_geom["m5_ell"])
    kappa_ct = float(wall_geom["kappa_ct"])
    a_cft_rec = float(wall_geom["a_cft_rec"])
    L4_init = float(wall_geom["L4_init"])
    Lambda0 = float(wall_geom["Lambda0"])
    alpha_w = float(wall_geom.get("alpha_w", 1.0))

    M4_sq_0 = M5_cubed * m5_ell + kappa_ct * a_cft_rec * (Lambda0 ** 2)
    Lambda4_eff = 3.0 * M4_sq_0 / (L4_init ** 2)

    nodes, weights = np.polynomial.legendre.leggauss(n_quad)
    t = torch.tensor(0.5 * (nodes + 1.0), dtype=dtype, device=DEVICE)
    w = torch.tensor(0.5 * weights, dtype=dtype, device=DEVICE)

    log_ratio = torch.log(lam / lam_prev)
    lam_samples = torch.exp(torch.log(lam_prev) + log_ratio[:, None] * t[None, :]).clamp(min=1e-300)

    L4_samples = _L4_of_lambda(lam_samples, M5_cubed, m5_ell, kappa_ct, a_cft_rec, Lambda4_eff)
    A_samples = _A_of_lambda(L4_samples, M5_cubed, m5_ell)
    B_samples = _B_of_lambda(L4_samples, kappa_ct, a_cft_rec)
    integrand = A_samples + B_samples * (lam_samples ** 2)

    J = alpha_w * log_ratio * torch.sum(integrand * w[None, :], dim=1)
    J = torch.nan_to_num(J, nan=0.0, posinf=1e300, neginf=-1e300)

    if debug_print and J.numel() > 0:
        print(f"[WALL/varL4] α={alpha_w:.3e} Λ_prev={float(lam_prev):.6e} Λ0={float(lam[0]):.6e} ΔJ0={float(J[0]):.3e}")
    return J
