# uom_simulator/external/penalties_calculator/core/by_kernel.py
import torch
import numpy as np
import logging
from typing import Dict, Tuple, Optional

from . import utils

DEVICE = utils.DEVICE


def _welded_log_time_spectrum_dimensionless(u: torch.Tensor) -> torch.Tensor:
    """
    Dimensionless time-spectrum shape φ(u) used consistently with the throughput.
    """
    u_sq = u.square()
    return -u_sq * torch.exp(-0.5 * u_sq)


def compute_by_batch(
        params_batch: torch.Tensor,
        config: Dict,
        geometry_constants: Dict,
        d_sep: float,
        L4_batch: Optional[torch.Tensor] = None,
        debug_print: bool = False
) -> torch.Tensor:
    """
    Brown–York (BY) penalty evaluated in batch for candidate Λ values.

    Args:
        params_batch: [B, 4] with columns [log(ΔI), log(s_t), log(s_x), log(Λ)].
        config:       kernel configuration dict (grid etc).
        geometry_constants: dict with at least:
                           {'gamma','G4','L4','m_g','ads5_radius_ell','induced_gravity_C_m3'}.
                           'L4' is used as a fallback when L4_batch is None.
        d_sep:        proper brane separation (attenuation e^{-d_sep q} is applied).
        L4_batch:     optional [B] tensor of per-candidate L4(Λ). If None, uses scalar L4.
        debug_print:  print internal diagnostics for the first candidate.

    Returns:
        Theta_k_batch: [B] float64 tensor.
    """
    params_batch_64 = params_batch.to(dtype=torch.float64, device=DEVICE)
    log_delta_i, log_s_t, log_s_x, log_lambda = params_batch_64.T

    delta_i  = torch.exp(log_delta_i)  # [B]
    s_t      = torch.exp(log_s_t)      # [B]
    s_x      = torch.exp(log_s_x)      # [B]
    lambda_k = torch.exp(log_lambda)   # [B]

    try:
        gamma = float(geometry_constants['gamma'])
        G4 = float(geometry_constants['G4'])
        L4_fallback = float(geometry_constants['L4'])
        m_g = float(geometry_constants['m_g'])
        ads5_radius_ell = float(geometry_constants['ads5_radius_ell'])
        induced_gravity_C_m3 = float(geometry_constants['induced_gravity_C_m3'])
    except KeyError as e:
        logging.error(f"BY Kernel is missing a required geometry constant: {e}")
        raise

    grid_config = config.get('surrogate', {}).get('grid_config', {})
    n_omega = grid_config.get('n_omega', 128)
    n_ell   = grid_config.get('n_ell',   64)
    u_max   = grid_config.get('dimensionless_u_max', 10.0)

    # Time grid (dimensionless u) and scaling to ω by s_t per batch
    u_grid = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    d_u    = u_grid[1] - u_grid[0] if n_omega > 1 else torch.tensor(1.0, dtype=torch.float64, device=DEVICE)
    omega_grid_scaled = u_grid.view(1, -1) / s_t.view(-1, 1)   # [B, Nω]

    # ℓ-grid and per-batch kℓ=(ℓ+1)/L4(Λ)
    ell_grid = torch.arange(1, n_ell + 1, device=DEVICE, dtype=torch.float64)  # [L]
    if L4_batch is None:
        # broadcast scalar L4 over batch
        k_ell_map = (ell_grid.view(1, -1) + 1.0) / torch.full_like(
            s_t.view(-1, 1), L4_fallback, dtype=torch.float64, device=DEVICE
        )  # [B, L]
    else:
        L4_use = L4_batch.to(dtype=torch.float64, device=DEVICE).view(-1, 1)   # [B,1]
        k_ell_map = (ell_grid.view(1, -1) + 1.0) / L4_use                      # [B, L]

    k_sq = k_ell_map.square()  # [B, L]
    degeneracy_weights = (ell_grid + 1.0) ** 2  # [L]

    # --- Throughput G (no amplitude) ---
    # Time part
    phi_u = _welded_log_time_spectrum_dimensionless(u_grid)     # [Nω]
    phi_sq_integral = torch.sum(phi_u ** 2) * d_u               # scalar
    G_t_noA = (1.0 / (2.0 * np.pi)) * (phi_sq_integral / s_t ** 5)  # [B]

    # Space part (uses welded log space spectrum)
    tau_x_spectrum = _welded_log_space_spectrum(ell_grid, s_x.view(-1, 1))     # [B, L]

    # Degeneracy-SUMMED measure for spatial part
    G_x_noA_sum = torch.sum(degeneracy_weights.view(1, -1) * tau_x_spectrum ** 2, dim=1)  # [B]

    G_batch = (G_t_noA.view(-1) * G_x_noA_sum.clamp(min=1e-300))   # [B]

    # Effective amplitude A_eff
    A_eff_batch = torch.sqrt(delta_i / G_batch.clamp(min=1e-100))  # [B]

    # Build τ(ω,ℓ) = τ_t(ω) * τ_x(ℓ)
    tau_t_physical = (A_eff_batch / s_t ** 2).view(-1, 1) * phi_u.view(1, -1)      # [B, Nω]
    tau_spectrum_2d = tau_t_physical.unsqueeze(2) * tau_x_spectrum.unsqueeze(1)    # [B, Nω, L]

    # BY response kernel K(ω,kℓ;Λ) with screening strength r(Λ) and geometric mass m_g
    r_func_params = (ads5_radius_ell, induced_gravity_C_m3, 0)
    r_batch = _screen_strength_r_batch(lambda_k, r_func_params)                    # [B]
    K_kernel = _build_trace_response_kernel_batch_euclidean(
        omega_grid_scaled, k_sq, r_batch, m_g, d_sep
    )  # [B, Nω, L]

    # |response|^2 and |τ|^2
    response_sq_mag = (8.0 * np.pi * G4 * K_kernel) ** 2           # [B, Nω, L]
    tau_sq_mag      = torch.abs(tau_spectrum_2d) ** 2              # [B, Nω, L]
    integrand       = response_sq_mag * tau_sq_mag                 # [B, Nω, L]

    # Fisher measure integration over ω and ℓ with degeneracy, and dω = du / s_t
    integral_val = torch.sum(
        integrand * degeneracy_weights.view(1, 1, -1), dim=(-1, -2)
    ) * (d_u / s_t) / (2.0 * np.pi)  # [B]

    Theta_k_batch = gamma * integral_val                           # [B]
    Theta_k_batch = torch.nan_to_num(Theta_k_batch, nan=0.0)

    if debug_print and Theta_k_batch.numel() > 0:
        print("\n--- [DEBUG] BY kernel (first candidate) ---")
        print(f"  Inputs: ΔI={delta_i[0].item():.3e}, s_t={s_t[0].item():.3f}, s_x={s_x[0].item():.3f}, "
              f"Λ={lambda_k[0].item():.3f}, L4={float(L4_fallback if L4_batch is None else L4_batch[0]):.3f}")
        print(f"  Throughput: G_t={G_t_noA[0].item():.3e}, G_x_sum={G_x_noA_sum[0].item():.3e}, "
              f"G_batch={G_batch[0].item():.3e}")
        print(f"  Amplitude: A_eff = sqrt({delta_i[0].item():.3e} / {G_batch[0].item():.3e}) "
              f"= {A_eff_batch[0].item():.3e}")
        print(f"  Kernel: ⟨|K|^2⟩ ~ {torch.mean(K_kernel[0] ** 2).item():.3e}, r(Λ)={r_batch[0].item():.3e}")
        print(f"  Final: γ={gamma:.3e}, Integral={integral_val[0].item():.3e} => Θ={Theta_k_batch[0].item():.3e}")
        print("-------------------------------------------------------------")

    return Theta_k_batch


def _welded_log_space_spectrum(ell: torch.Tensor, s_x: torch.Tensor) -> torch.Tensor:
    """
    Spatial welded log-spectrum over S^3 harmonics.
    Returns shape [B, L] given ell [L] and s_x [B,1].
    """
    lambda_ell = ell * (ell + 2.0)                     # [L]
    exponent = -0.5 * (s_x ** 2) * lambda_ell          # [B, L]
    return -lambda_ell * torch.exp(exponent.clamp(min=-700.0))


def _screen_strength_r_batch(lambda_batch: torch.Tensor, params: Tuple[float, float, float]) -> torch.Tensor:
    """
    r(Λ) = ℓ_AdS5 / 2  +  C_m3 * Λ^2
    """
    ell_ads5, C_m3, _ = params
    r0 = ell_ads5 / 2.0
    return r0 + C_m3 * (lambda_batch ** 2)


def _build_trace_response_kernel_batch_euclidean(
        omega_grid_scaled: torch.Tensor,  # [B, Nω]
        k_sq: torch.Tensor,               # [B, L]
        r_batch: torch.Tensor,            # [B]
        m_g: float,
        d_sep: float
) -> torch.Tensor:
    """
    Build K(ω,k;Λ) with an evanescent attenuation exp(-d_sep * q):
        q = sqrt(k^2 + m_g^2 + ω^2)
        K = q / (q + r(Λ) k^2)
    All broadcasting done in batch; returns [B, Nω, L].
    """
    # Shapes to broadcast to [B, Nω, L]
    omega_sq = omega_grid_scaled.square().unsqueeze(2)   # [B, Nω, 1]
    k_sq_b   = k_sq.unsqueeze(1)                         # [B, 1,   L]
    r_b      = r_batch.view(-1, 1, 1)                    # [B, 1,   1]

    q = torch.sqrt(k_sq_b + (m_g ** 2) + omega_sq).clamp(min=1e-300)  # [B, Nω, L]
    denom = q + r_b * k_sq_b
    K = q / denom.clamp(min=1e-300)

    if d_sep > 0:
        K = K * torch.exp(-d_sep * q)  # evanescent suppression across the gap

    return K
