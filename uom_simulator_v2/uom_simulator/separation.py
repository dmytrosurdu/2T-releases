from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

import math

from uom_simulator.config import SeparationParams, SimConfig
from uom_simulator.shadow_sector import ShadowStack, ShadowBrane, mass_eff


@dataclass
class SeparationState:
    d_active: float
    shadow_stack: ShadowStack
    last_birth_gap: Optional[float] = None
    last_q_by: Optional[float] = None
    last_q_sh: Optional[float] = None


@dataclass
class SplitSeparationResult:
    d_sep_pre_split: float
    d_birth: float
    d_active_next: float
    omega_star: float
    k_star: float
    q_by: float
    n_shadow_before: int
    n_shadow_after: int
    d0_new_shadow: float
    min_shadow_d: Optional[float]
    max_shadow_d: Optional[float]


def compute_tick_scales(Lambda: float, receiver_params, eps: float) -> tuple[float, float, float, float]:
    s_t = receiver_params.alpha_t / max(float(Lambda), eps)
    s_x = receiver_params.alpha_x / max(receiver_params.v_geom * float(Lambda), eps)
    omega_star = math.sqrt(2.0) / max(s_t, eps)
    k_star = 1.0 / max(s_x, eps)
    return s_t, s_x, omega_star, k_star


def compute_q_by_peak(omega_star: float, k_star: float, L4_prev: float, eps: float) -> float:
    m_g = 1.0 / max(float(L4_prev), eps)
    return math.sqrt(omega_star * omega_star + k_star * k_star + m_g * m_g)


def compute_birth_gap(Lambda_star: float, receiver_params, L4_prev: float,
                      cfg: SeparationParams) -> tuple[float, float, float, float]:
    eps = float(cfg.numeric_eps)
    _, _, omega_star, k_star = compute_tick_scales(Lambda_star, receiver_params, eps)
    q_by = compute_q_by_peak(omega_star, k_star, L4_prev, eps)
    if not math.isfinite(q_by) or q_by <= 0.0:
        raise ValueError("invalid q_by for birth gap")
    d_birth = float(cfg.c_by) / q_by
    if not math.isfinite(d_birth) or d_birth <= 0.0:
        raise ValueError("invalid d_birth for birth gap")
    return d_birth, q_by, omega_star, k_star


def apply_tick_growth(sep_state: SeparationState, H_src: float, tick_duration: float,
                      Lambda: float, receiver_params,
                      aeon_params, shadow_params, cfg: SeparationParams) -> None:
    dt_eff = float(tick_duration)
    if cfg.tick_duration_mode == "kernel_st":
        eps = float(cfg.numeric_eps)
        s_t = receiver_params.alpha_t / max(float(Lambda), eps)
        dt_eff = float(cfg.c_tick) * float(s_t)
    if cfg.active_growth_model == "aeon_expansion":
        sep_state.d_active *= (1.0 + float(H_src) * float(dt_eff))

    if not sep_state.shadow_stack.branes:
        return

    growth_model = cfg.shadow_growth_model
    xi_sh = float(shadow_params.d_growth_factor)
    if xi_sh == 0.0:
        return

    if growth_model == "current_H":
        for brane in sep_state.shadow_stack.branes:
            brane.d_sep *= (1.0 + xi_sh * float(H_src) * float(dt_eff))
        return

    # default: frozen_H
    for brane in sep_state.shadow_stack.branes:
        brane.d_sep *= (1.0 + xi_sh * float(brane.H_frozen) * float(dt_eff))


def apply_split_geometry(sep_state: SeparationState, d_sep_pre_split: float,
                         Lambda_star: float, L4_prev: float,
                         source_params, receiver_params,
                         cfg: SeparationParams, sim_config: SimConfig,
                         shadow_params, aeon_id: int) -> SplitSeparationResult:
    n_shadow_before = len(sep_state.shadow_stack.branes)
    d_birth, q_by, omega_star, k_star = compute_birth_gap(
        Lambda_star, receiver_params, L4_prev, cfg
    )

    for brane in sep_state.shadow_stack.branes:
        brane.d_sep += d_birth

    d0_new_shadow = float(d_sep_pre_split + d_birth)
    R_signed = float(12.0 / (source_params.L4_src ** 2))
    M_eff = mass_eff(source_params.Lambda_src, R_signed, source_params.a_cft_src, sim_config, shadow_params)
    sep_state.shadow_stack.add_brane(ShadowBrane(
        aeon_id=int(aeon_id),
        mass_eff=M_eff,
        d_sep=d0_new_shadow,
        Lambda_frozen=float(source_params.Lambda_src),
        R_signed_frozen=R_signed,
        H_frozen=float(source_params.H_src),
        a_cft_src=float(source_params.a_cft_src),
    ))

    sep_state.d_active = d_birth
    sep_state.last_birth_gap = d_birth
    sep_state.last_q_by = q_by

    n_shadow_after = len(sep_state.shadow_stack.branes)
    shadow_summary = sep_state.shadow_stack.summary()
    return SplitSeparationResult(
        d_sep_pre_split=float(d_sep_pre_split),
        d_birth=float(d_birth),
        d_active_next=float(sep_state.d_active),
        omega_star=float(omega_star),
        k_star=float(k_star),
        q_by=float(q_by),
        n_shadow_before=n_shadow_before,
        n_shadow_after=n_shadow_after,
        d0_new_shadow=float(d0_new_shadow),
        min_shadow_d=shadow_summary.get("d_min"),
        max_shadow_d=shadow_summary.get("d_max"),
    )
