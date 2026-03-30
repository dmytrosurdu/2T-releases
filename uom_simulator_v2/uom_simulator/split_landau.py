from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Tuple

import numpy as np


@dataclass
class LandauParams:
    a: float
    K: float
    b: float
    Q0: float
    eps: Optional[float] = None
    delta_U_shadow: Optional[float] = None


@dataclass
class SplitCurvatures:
    R_ads: float
    R_ds: float
    weights: Optional[Tuple[float, float]]
    landau: LandauParams


def _real_roots_cubic(b: float) -> list[float]:
    # Solve x^3 - x - b = 0
    coeffs = [1.0, 0.0, -1.0, -b]
    roots = np.roots(coeffs)
    real_roots = []
    for r in roots:
        if abs(r.imag) < 1e-10:
            real_roots.append(float(r.real))
    return real_roots


def _Vx(x: float, K: float, b: float) -> float:
    return K * (0.25 * (x * x - 1.0) ** 2 - b * x)


def _Vxx(x: float, K: float) -> float:
    return K * (3.0 * x * x - 1.0)


def solve_landau_minima(a: float, K: float, b: float, Q0: float,
                        eps: Optional[float] = None,
                        delta_U_shadow: Optional[float] = None) -> SplitCurvatures:
    if not np.isfinite(a) or a <= 0.0:
        raise ValueError("Landau parameter 'a' must be positive and finite.")
    if not np.isfinite(K) or K <= 0.0:
        raise ValueError("Landau parameter 'K' must be positive and finite.")
    if not np.isfinite(b):
        raise ValueError("Landau parameter 'b' must be finite.")

    roots = _real_roots_cubic(b)
    minima = []
    for x in roots:
        vxx = _Vxx(x, K)
        if vxx > 0.0:
            minima.append((x, vxx))

    if len(minima) < 2:
        raise ValueError("Landau split failed: fewer than two minima.")

    # pick most negative and most positive minima
    x_ads = min(minima, key=lambda item: item[0])[0]
    x_ds = max(minima, key=lambda item: item[0])[0]

    R_ads = a * x_ads
    R_ds = a * x_ds

    if not (R_ads < 0.0 and R_ds > 0.0):
        raise ValueError("Landau split failed: minima do not yield opposite-sign curvatures.")

    weights = None
    if eps is not None and eps > 0.0:
        v_ads = _Vx(x_ads, K, b)
        v_ds = _Vx(x_ds, K, b)
        # convert V'' in x to V'' in R: V_RR = V_xx / a^2
        vxx_ads = _Vxx(x_ads, K) / (a * a)
        vxx_ds = _Vxx(x_ds, K) / (a * a)
        w_ads = np.exp(-v_ads / eps) / np.sqrt(max(vxx_ads, 1e-300))
        w_ds = np.exp(-v_ds / eps) / np.sqrt(max(vxx_ds, 1e-300))
        norm = w_ads + w_ds
        if norm > 0.0:
            weights = (float(w_ads / norm), float(w_ds / norm))

    landau = LandauParams(a=float(a), K=float(K), b=float(b),
                          Q0=float(Q0), eps=eps, delta_U_shadow=delta_U_shadow)
    return SplitCurvatures(R_ads=float(R_ads), R_ds=float(R_ds),
                           weights=weights, landau=landau)
