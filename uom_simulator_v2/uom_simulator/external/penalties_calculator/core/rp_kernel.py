# penalties_calculator/core/rp_kernel.py
import torch
import logging
import numpy as np
from typing import Dict

from uom_simulator.external.penalties_calculator.core import utils

DEVICE = utils.DEVICE


def compute_rp_batch(
        delta_C_batch: torch.Tensor,
        params_batch: torch.Tensor,
        config: Dict,
        geometry_constants: Dict
) -> torch.Tensor:
    """
    Computes the correct RP penalty: the squared Fisher norm of the reflection-odd
    component of the welded state perturbation δC.

    J_RP = (1/2) * || Π_RP * δC ||²_F
    """
    delta_C_batch_64 = delta_C_batch.to(dtype=torch.complex128)
    params_batch_64 = params_batch.to(dtype=torch.float64)
    batch_size = params_batch_64.shape[0]
    log_s_t = params_batch_64[:, 1]
    s_t = torch.exp(log_s_t)

    rp_config = config.get('surrogate', {}).get('rp_kernel_config', {})
    os_grid_config = config['receiver']['os_rp_grid']
    grid_config = config.get('surrogate', {}).get('grid_config', {})

    mu, N_tau = os_grid_config['mu'], os_grid_config['N_tau']

    # Use a full Euclidean time grid for the reflection operation
    tau_full_grid = torch.linspace(0, 2 * mu, 2 * (N_tau + 1) - 1, device=DEVICE, dtype=torch.float64)
    delta_tau = tau_full_grid[1] - tau_full_grid[0]

    try:
        L4 = float(geometry_constants['L4'])
    except KeyError as e:
        logging.error(f"RP Kernel is missing a required constant: {e}")
        raise

    n_omega_in, n_ell_in = delta_C_batch_64.shape[1], delta_C_batch_64.shape[2]
    ell_grid = torch.arange(1, n_ell_in + 1, device=DEVICE, dtype=torch.float64)
    degeneracy_weights = (ell_grid + 1.0) ** 2

    # --- Build Welded Euclidean 2-pt Function δC(τ) ---
    u_max = grid_config.get('dimensionless_u_max', 10.0)
    u_grid = torch.linspace(0, u_max, n_omega_in, device=DEVICE, dtype=torch.float64)
    d_u = u_grid[1] - u_grid[0] if n_omega_in > 1 else 1.0

    # Laplace transform table: E[k, m] = exp(- (u_k / s_t) * τ_m)
    E = torch.exp(-(u_grid.view(1, -1, 1) / s_t.view(-1, 1, 1)) * tau_full_grid.view(1, 1, -1))

    # Perform the Laplace transform to get δC(τ) for each ell-mode
    deltaC_tau = (2.0 / (2.0 * np.pi)) * torch.einsum(
        'bol,bon->bln', torch.real(delta_C_batch_64), E
    ) * (d_u / s_t.view(-1, 1, 1))

    # --- Apply the Reflection-Odd Projector Π_RP ---
    # δC_odd(τ) = 0.5 * (δC(τ) - δC(2μ - τ))
    deltaC_tau_odd = 0.5 * (deltaC_tau - torch.flip(deltaC_tau, dims=[-1]))

    # --- Compute the Fisher Norm of the Odd Component ---
    #m_phys_gev = rp_config.get('physical_mass_m', 1.0)

    #gev_to_inv_m = config.get('utils', {}).get('GEV_TO_INV_METERS')
    #m_phys_m1 = m_phys_gev * gev_to_inv_m  # Convert mass to inverse meters for consistency
    m_phys_m1 = 1.0 / config.get("geometry").get("ads4_radius_L4")

    omega_ell = torch.sqrt(m_phys_m1 ** 2 + ((ell_grid + 1.0) / L4) ** 2)

    # Fisher weights: w_ell = (1/2) * D_ell * (2*ω_ell)²
    w_ell = 0.5 * degeneracy_weights * (2.0 * omega_ell) ** 2
    w_ell = torch.nan_to_num(w_ell, posinf=1e60)

    # J_RP = (1/2) * ∫ |Π_RP * δC|²_F d(measure)
    # The (1/2π) and Δτ are from the measure. The outer 0.5 is from the J_RP definition.
    J_RP = 0.5 * (delta_tau / (2.0 * np.pi)) * torch.sum(
        w_ell.view(1, -1, 1) * (deltaC_tau_odd.abs() ** 2), dim=(-1, -2)
    )

    return torch.nan_to_num(J_RP, nan=0.0)