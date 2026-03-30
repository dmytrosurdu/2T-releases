from __future__ import annotations

import numpy as np
import torch

from uom_simulator.external.penalties_calculator.core.utils import DEVICE


def _throughput_noA_batch(s_t: torch.Tensor, s_x: torch.Tensor, grid: dict) -> torch.Tensor:
    """
    Candidate-specific “throughput” G_batch (no amplitude), used to scale δC.
    Mirrors the construction in p3_optimizer.
    """
    n_omega, n_ell = grid["n_omega"], grid["n_ell"]
    u_max = grid["dimensionless_u_max"]

    u = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    d_u = (u[1] - u[0]) if n_omega > 1 else torch.tensor(1.0, device=DEVICE, dtype=torch.float64)

    phi = -(u ** 2) * torch.exp(-0.5 * u ** 2)
    G_t = (1.0 / (2.0 * np.pi)) * (torch.sum(phi ** 2) * d_u) / (s_t ** 5)

    ell = torch.arange(1, n_ell + 1, device=DEVICE, dtype=torch.float64)
    lam = ell * (ell + 2.0)
    degeneracy = (ell + 1.0) ** 2
    tau_x = -lam * torch.exp(-0.5 * (s_x.view(-1, 1) ** 2) * lam.view(1, -1))  # [B, L]
    G_x_sum = torch.sum(degeneracy * tau_x ** 2, dim=1)  # [B]
    return G_t.view(-1) * G_x_sum.clamp(min=1e-300)  # [B]


def build_delta_c_tangent(
    delta_I: float, s_t: float, s_x: float, grid_config: dict
) -> torch.Tensor:
    """
    Builds a welded tangent δC(ω,ℓ) with amplitude so Fisher-norm power ∝ ΔI.
    Returns a complex128 tensor of shape [1, n_omega, n_ell].
    """
    s_t_t = torch.tensor([float(s_t)], device=DEVICE, dtype=torch.float64)
    s_x_t = torch.tensor([float(s_x)], device=DEVICE, dtype=torch.float64)
    delta_I_t = torch.tensor([float(delta_I)], device=DEVICE, dtype=torch.float64)

    G_batch = _throughput_noA_batch(s_t_t, s_x_t, grid_config)
    A_eff = torch.sqrt(delta_I_t / G_batch.clamp(min=1e-300))

    n_omega, n_ell = grid_config["n_omega"], grid_config["n_ell"]
    u_max = grid_config["dimensionless_u_max"]
    u = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    ell = torch.arange(1, n_ell + 1, device=DEVICE, dtype=torch.float64)
    lam = ell * (ell + 2.0)

    time_factor = -(u.view(1, -1) ** 2) / (s_t_t.view(-1, 1) ** 2) * torch.exp(-0.5 * u.view(1, -1) ** 2)
    space_factor = -lam.view(1, -1) * torch.exp(-0.5 * (s_x_t.view(-1, 1) ** 2) * lam.view(1, -1))

    delta_C = A_eff.view(-1, 1, 1) * time_factor.unsqueeze(2) * space_factor.unsqueeze(1)
    return delta_C.to(dtype=torch.complex128)
