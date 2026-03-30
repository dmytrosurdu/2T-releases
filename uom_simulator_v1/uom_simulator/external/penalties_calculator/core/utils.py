# penalties_calculator/core/utils.py
"""Shared GPU utilities for computing "ground truth" penalties."""
import torch
import numpy as np
from scipy.fft import dct
from typing import Callable, Tuple
import logging

if torch.cuda.is_available():
    DEVICE = torch.device("cuda")
    torch.set_default_device(DEVICE)
else:
    DEVICE = torch.device("cpu")
    print("Warning: CUDA not available. Running on CPU. This will be very slow.")


# -----------------------------------------------------------------------------
# 1. UTILITIES FOR REFLECTION POSITIVITY (RP) PENALTY
# -----------------------------------------------------------------------------

def fft_hankel_matvec_batch(
        hankel_anti_diag: torch.Tensor,
        vec_to_mul: torch.Tensor
) -> torch.Tensor:
    """
    Performs a batched Hankel matrix-vector product using FFT-based convolution.
    A true Hankel matvec `(Hx)_i = sum_j h(i+j) x_j` is a convolution with the
    reversed vector `x_rev`.

    Args:
        hankel_anti_diag (torch.Tensor): Tensor defining the Hankel matrix anti-diagonals.
            Shape: `[B, N_ell, 2*N-1]`.
        vec_to_mul (torch.Tensor): Batch of vectors to be multiplied.
            Shape: `[B, N_ell, N]`.

    Returns:
        torch.Tensor: The result of the matrix-vector products, shape `[B, N_ell, N]`.
    """
    B, N_ell, N = vec_to_mul.shape
    M = 2 * N - 1

    if hankel_anti_diag.shape[-1] != M:
        raise ValueError(
            f"Hankel definition vector must have length 2*N-1 = {M}, but got {hankel_anti_diag.shape[-1]}.")

    n_fft = 1 << (M + N - 1).bit_length()

    x_rev = torch.flip(vec_to_mul, dims=[-1])

    Hf = torch.fft.rfft(hankel_anti_diag, n=n_fft, dim=-1)
    Xf = torch.fft.rfft(x_rev, n=n_fft, dim=-1)
    Yf = Hf * Xf
    y_full = torch.fft.irfft(Yf, n=n_fft, dim=-1)

    # Correct slice for Hankel convolution result, length N
    return y_full[..., N - 1: 2 * N - 1]


def get_chebyshev_coeffs(
        degree: int, mu: float, spectral_range: Tuple[float, float]
) -> np.ndarray:
    """Computes Jackson-damped Chebyshev coefficients for the smoothed hinge function."""
    lmin, lmax = spectral_range
    if not (np.isfinite(lmin) and np.isfinite(lmax)) or lmax <= lmin:
        lmin, lmax = -1.0, 1.0

    def smoothed_hinge(x_norm):
        x = 0.5 * (lmax - lmin) * x_norm + 0.5 * (lmax + lmin)
        return 0.5 * (torch.sqrt(x ** 2 + mu ** 2) - x)

    nodes = torch.cos(torch.pi * (torch.arange(degree + 1, device=DEVICE) + 0.5) / (degree + 1))
    f_values = smoothed_hinge(nodes)
    coeffs = dct(f_values.cpu().numpy(), type=1) / degree

    n = np.arange(degree + 1)
    angle = np.pi / (degree + 1)
    jackson_kernel = ((degree - n + 1) * np.cos(n * angle) +
                      np.sin(n * angle) / np.tan(angle)) * angle
    return jackson_kernel * coeffs


# -----------------------------------------------------------------------------
# 2. UTILITIES FOR CONFORMAL MISMATCH PENALTY
# -----------------------------------------------------------------------------

def construct_weyl_basis_and_projector(
        ell_grid: torch.Tensor,
        C_star_inv_diag: torch.Tensor,
        degeneracy_weights: torch.Tensor,
        num_basis_vectors: int = 3
) -> torch.Tensor:
    """Constructs a Fisher-orthonormal basis for the Weyl (trace) tangent space."""
    N_ell = len(ell_grid)
    basis_vectors = torch.zeros(num_basis_vectors, N_ell, device=DEVICE, dtype=C_star_inv_diag.dtype)
    laplacian_eigenvalues = ell_grid * (ell_grid + 2.0)

    basis_vectors[0, :] = 1.0
    if num_basis_vectors > 1:
        basis_vectors[1] = laplacian_eigenvalues
    if num_basis_vectors > 2:
        basis_vectors[2] = laplacian_eigenvalues ** 2

    basis_vectors /= torch.linalg.norm(basis_vectors, dim=-1, keepdim=True).clamp(min=1e-12)
    basis_vectors = torch.nan_to_num(basis_vectors)

    fisher_weights = 0.5 * degeneracy_weights * (C_star_inv_diag ** 2)
    fisher_weights = torch.nan_to_num(fisher_weights, nan=0.0, posinf=1e60, neginf=-1e60)

    gram_matrix = torch.zeros(num_basis_vectors, num_basis_vectors, device=DEVICE, dtype=basis_vectors.dtype)
    for i in range(num_basis_vectors):
        for j in range(i, num_basis_vectors):
            inner_product = torch.sum(fisher_weights * basis_vectors[i] * basis_vectors[j])
            gram_matrix[i, j] = inner_product
            gram_matrix[j, i] = inner_product

    gram_matrix = torch.nan_to_num(gram_matrix, nan=0.0, posinf=1e60, neginf=-1e60)

    try:
        S, V = torch.linalg.eigh(gram_matrix)
    except torch._C._LinAlgError:
        logging.error("Eigh failed in Weyl basis construction despite sanitization.")
        return torch.zeros(0, N_ell, device=DEVICE)

    singular_value_threshold = 1e-10 * S.max() if S.numel() > 0 and S.max() > 0 else 1e-10
    rank = torch.sum(S > singular_value_threshold)

    if rank < num_basis_vectors:
        logging.warning(f"Weyl basis rank deficient. Original rank {num_basis_vectors}, using rank {rank}.")

    if rank == 0:
        return torch.zeros(0, N_ell, device=DEVICE)

    S_inv_sqrt = torch.diag(1.0 / torch.sqrt(S[-rank:]))
    transform_matrix = V[:, -rank:] @ S_inv_sqrt
    orthonormal_basis = basis_vectors.T @ transform_matrix

    return orthonormal_basis.T