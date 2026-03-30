from __future__ import annotations

import math
from typing import Dict

import torch

from uom_simulator.external.penalties_calculator.core.rp_kernel import compute_rp_batch


def beta_ds(H_src: float) -> float:
    """Effective inverse temperature for the dS source."""
    return (2.0 * math.pi) / max(float(H_src), 1e-300)


@torch.no_grad()
def compute_j_rp_single(
    delta_C: torch.Tensor,
    params: torch.Tensor,
    kernel_config: Dict,
    geom_constants: Dict,
) -> float:
    """Compute RP penalty for a single candidate (batch size 1)."""
    j = compute_rp_batch(delta_C, params, kernel_config, geom_constants)
    return float(j[0].item())


def compute_q_rg(j_rp: float, H_src: float, chi: float) -> float:
    """RG-complement leak: chi * J_RP / beta_ds."""
    beta = beta_ds(H_src)
    return float(chi) * float(j_rp) / beta
