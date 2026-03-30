# uom_simulator/external/penalties_calculator/core/conf_kernel.py
import torch
import torch.nn.functional as F
import logging
import numpy as np
from typing import Dict, Optional

from . import utils

DEVICE = utils.DEVICE


def gaussian_blur_l_real(x_real: torch.Tensor, sigma_l: torch.Tensor) -> torch.Tensor:
    """
    Per-batch Gaussian blur along the ℓ-axis for a real-valued tensor.
    x_real:  [B, Nω, L]
    sigma_l: [B]    (per-candidate blur)
    """
    B, Nw, L = x_real.shape
    if torch.all(sigma_l <= 1e-12):
        return x_real

    # Kernel half-width: 3σ rounded up
    half = int(3 * float(sigma_l.max().item()) + 1)
    if half < 1:
        return x_real

    k_range = torch.arange(-half, half + 1, device=DEVICE, dtype=torch.float64)  # [K]
    # Build B Gaussian kernels of length K, normalized
    gauss = torch.exp(-0.5 * (k_range.view(1, -1) / sigma_l.view(-1, 1)) ** 2)  # [B, K]
    gauss = gauss / gauss.sum(dim=-1, keepdim=True)

    # Reshape for grouped 1D conv over ℓ (treat [B, Nw] streams independently)
    x = x_real.reshape(1, B * Nw, L)                      # [1, B*Nw, L]
    g_kernel = gauss.repeat_interleave(Nw, dim=0)         # [B*Nw, K]
    g_kernel = g_kernel.view(B * Nw, 1, -1)               # [B*Nw, 1, K]

    y = F.conv1d(x, g_kernel, padding='same', groups=B * Nw)  # [1, B*Nw, L]
    return y.reshape(B, Nw, L)


def gaussian_blur_l(x_complex: torch.Tensor, sigma_l: torch.Tensor) -> torch.Tensor:
    """
    Complex version: blur real/imag parts separately.
    x_complex: [B, Nω, L]
    sigma_l :  [B]
    """
    real = gaussian_blur_l_real(x_complex.real, sigma_l)
    imag = gaussian_blur_l_real(x_complex.imag, sigma_l)
    return torch.complex(real, imag)


def legendre_all(cos_theta: torch.Tensor, n_ell: int) -> torch.Tensor:
    """
    Returns P_ℓ(cosθ) for ℓ=1..n_ell as a vector [n_ell].
    """
    if n_ell <= 0:
        return torch.empty(0, device=DEVICE, dtype=cos_theta.dtype)
    P = torch.empty(n_ell + 1, device=DEVICE, dtype=cos_theta.dtype)
    P[0] = 1.0
    if n_ell >= 1:
        P[1] = cos_theta
    for l in range(1, n_ell):
        P[l + 1] = ((2 * l + 1) * cos_theta * P[l] - l * P[l - 1]) / (l + 1)
    return P[1: n_ell + 1]  # ℓ=1..n_ell


@torch.no_grad()
def compute_conf_batch(
        delta_C_batch: torch.Tensor,     # [B, Nω, L] complex128
        params_batch: torch.Tensor,      # [B, 4] float64  (logΔI, log s_t, log s_x, log Λ)
        config: Dict,
        geometry_constants: Dict,
        L4_batch: Optional[torch.Tensor] = None,  # [B] per-candidate L4(Λ); fallback to scalar if None
) -> torch.Tensor:
    """
    Fisher-norm of the conformality mismatch component (after Weyl-projection),
    with full propagation of per-candidate L4(Λ).

    Returns: [B] float64 (D_conf per candidate).
    """
    # Shapes / grids
    delta_C_batch_64 = delta_C_batch.to(dtype=torch.complex128, device=DEVICE)
    params_batch_64  = params_batch.to(dtype=torch.float64, device=DEVICE)
    B, n_omega_in, n_ell_in = delta_C_batch_64.shape

    conf_config = config.get('surrogate', {}).get('conf_kernel_config', {})
    grid_config = config.get('surrogate', {}).get('grid_config', {})

    n_omega = grid_config.get('n_omega', 128)
    n_ell   = grid_config.get('n_ell',   64)

    # Time grid (dimensionless u)
    u_max = grid_config.get('dimensionless_u_max', 10.0)
    u_grid = torch.linspace(0, u_max, n_omega, device=DEVICE, dtype=torch.float64)
    d_u    = u_grid[1] - u_grid[0] if n_omega > 1 else torch.tensor(1.0, device=DEVICE, dtype=torch.float64)

    # Read s_t, Λ
    log_s_t  = params_batch_64[:, 1]
    s_t      = torch.exp(log_s_t)         # [B]
    d_omega_per_batch = d_u / s_t         # [B]

    logLambda = params_batch_64[:, 3]
    Lambda    = torch.exp(logLambda)      # [B]

    # ℓ grid and degeneracy
    ell_grid = torch.arange(1, n_ell + 1, device=DEVICE, dtype=torch.float64)  # [L]
    degeneracy_weights = (ell_grid + 1.0) ** 2                                   # [L]

    # Geometry constants
    try:
        L4_fallback = float(geometry_constants['L4'])
    except KeyError:
        logging.error("CONF Kernel requires 'L4' in geometry_constants.")
        raise

    # Ads4 radius in config.geometry is the fixed reference gap; keep it for m_phys
    m_phys = 1.0 / float(config.get("geometry", {}).get("ads4_radius_L4", L4_fallback))

    # Per-candidate L4(Λ)
    if L4_batch is None:
        L4_eff = torch.full((B,), L4_fallback, dtype=torch.float64, device=DEVICE)  # [B]
    else:
        L4_eff = L4_batch.to(dtype=torch.float64, device=DEVICE).view(-1)           # [B]

    # ω_ℓ(Λ) = sqrt( m_phys^2 + ((ℓ+1)/L4(Λ))^2 )  → shapes [B, L]
    k_ell = (ell_grid.view(1, -1) + 1.0) / L4_eff.view(-1, 1)                       # [B, L]
    omega_ell = torch.sqrt((m_phys ** 2) + k_ell.square())                           # [B, L]

    # C*^{-1} diag (squared): (2 ω_ell)^2  and per-batch Fisher weights w_{ℓ}
    C_star_inv_diag_sq = (2.0 * omega_ell) ** 2                                      # [B, L]
    fisher_weights_L = 0.5 * degeneracy_weights.view(1, -1) * C_star_inv_diag_sq    # [B, L]
    fisher_weights_L = torch.nan_to_num(fisher_weights_L, posinf=1e60)

    # Helper: Fisher norm of a batch of tensors (per-candidate)
    def fisher_norm_sq(tensor_batch: torch.Tensor) -> torch.Tensor:
        """
        tensor_batch: [B, Nω, L] (complex)
        returns     : [B] float64
        """
        if not torch.is_complex(tensor_batch):
            tb = tensor_batch.to(torch.complex128)
        else:
            tb = tensor_batch

        # |·|^2 then sum with per-candidate Fisher weights over ω,ℓ
        abs2 = (tb.abs() ** 2).real                                      # [B, Nω, L]
        # weight along L
        wL  = fisher_weights_L.view(B, 1, n_ell)                          # [B, 1, L]
        acc = torch.sum(wL[:, :, :abs2.shape[-1]] * abs2, dim=(-1, -2))   # [B]
        # integrate ω with dω = du / s_t (per batch) and divide by 2π
        return acc * (d_omega_per_batch / (2.0 * np.pi))

    # --- Weyl projection basis per candidate (Fisher-orthonormal, rank ≤ 3) ---
    # Build per-candidate orthonormal basis of {1, Δ_S^3, Δ_S^3^2} in Fisher metric
    num_basis_vectors = int(conf_config.get('weyl_basis_vectors', 3))
    # Precompute Laplacian eigenvalues on S^3: λ_ℓ = ℓ(ℓ+2)
    lap_eigs = ell_grid * (ell_grid + 2.0)  # [L]

    def build_basis_per_candidate() -> list[torch.Tensor]:
        bases = []
        for b in range(B):
            # utils.construct_weyl_basis_and_projector expects C_star_inv_diag (not squared)
            basis_b = utils.construct_weyl_basis_and_projector(
                ell_grid,
                (2.0 * omega_ell[b]).view(-1),     # C*^{-1} diag
                degeneracy_weights,
                num_basis_vectors=num_basis_vectors
            )
            bases.append(basis_b)  # [r_b, L] (r_b ≤ num_basis_vectors)
        return bases

    weyl_bases = build_basis_per_candidate()

    # Gaussian blur scale σ_ℓ(Λ): σ ~ c / (ℓ_char+1), ℓ_char ≈ Λ·L4(Λ) − 1
    ell_char = (Lambda * L4_eff) - 1.0
    ell_char = torch.clamp(ell_char, min=0.0)
    c_blur       = float(conf_config.get('blur_c', 1.0))
    sigma_floor  = float(conf_config.get('blur_sigma_floor', 1e-6))
    sigma_l      = torch.clamp(c_blur / (ell_char + 1.0), min=sigma_floor)  # [B]

    # Group average over a small set of rotations (Legendre cubature over cosθ)
    num_group_samples = int(conf_config.get('num_cubature_points', 8))
    cos_thetas_np, weights_np = np.polynomial.legendre.leggauss(num_group_samples)
    cos_thetas = torch.tensor(cos_thetas_np, device=DEVICE, dtype=torch.float64)
    weights    = torch.tensor(weights_np,    device=DEVICE, dtype=torch.float64)

    total_mismatch = torch.zeros(B, device=DEVICE, dtype=torch.float64)  # [B]

    for i in range(num_group_samples):
        cos_theta = cos_thetas[i]
        w_i       = weights[i]

        # U_g acts diagonally in ℓ via P_ℓ(cosθ)
        P_l = legendre_all(cos_theta, n_ell_in).view(1, 1, -1)  # [1, 1, L]
        U_delta = P_l * delta_C_batch_64                        # [B, Nω, L]

        # Commutator-like mismatch: Kg(U δC) − U Kg(δC) with Λ-dependent blur
        Kg_U_delta = gaussian_blur_l(U_delta, sigma_l)          # [B, Nω, L]
        U_Kg_delta = P_l * gaussian_blur_l(delta_C_batch_64, sigma_l)
        mismatch   = Kg_U_delta - U_Kg_delta                    # [B, Nω, L]

        # Project out Weyl (trace) tangent piece in Fisher metric PER CANDIDATE
        proj = torch.zeros_like(mismatch)
        for b in range(B):
            basis_b = weyl_bases[b]  # [rb, L] or [0, L]
            if basis_b.numel() == 0:
                continue
            rb = basis_b.shape[0]
            # Per-candidate Fisher weights incl. dω measure
            wL_b = (0.5 * degeneracy_weights * (2.0 * omega_ell[b]) ** 2).view(1, 1, -1)  # [1,1,L]
            scale_b = (d_omega_per_batch[b] / (2.0 * np.pi))
            # Inner products < mismatch_b , e_j >_F  (sum over ω,ℓ)
            # mismatch_b: [Nω, L]; basis_b: [rb, L]
            mb = mismatch[b].unsqueeze(0)                 # [1, Nω, L]
            # Broadcast to [rb, Nω, L]
            e = basis_b.view(rb, 1, -1).to(torch.complex128)            # [rb,1,L]
            # Weighted inner products (real)
            inner = torch.sum(wL_b * (mb.conj() * e).real, dim=(-1, -2)) * scale_b  # [rb]
            # Reconstruct projection: sum_j inner_j * e_j
            proj[b] = torch.sum(inner.view(rb, 1, 1) * e, dim=0)        # [Nω, L]

        conf_component = mismatch - proj  # [B, Nω, L]
        total_mismatch += w_i * fisher_norm_sq(conf_component)  # accumulate per Gauss weight

    return torch.nan_to_num(total_mismatch, nan=0.0, posinf=1e300, neginf=0.0)
