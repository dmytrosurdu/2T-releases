from __future__ import annotations

from dataclasses import dataclass, field
from typing import Literal, Optional

import numpy as np

from uom_simulator.config import ShadowParams, SimConfig, ShadowSeed
from uom_simulator.utils import r_screen, M4_sq


ShadowKernelMode = Literal["exp", "exp_cos"]


@dataclass
class ShadowBrane:
    aeon_id: int
    mass_eff: float
    d_sep: float
    Lambda_frozen: float
    R_signed_frozen: float
    H_frozen: float
    a_cft_src: float


@dataclass
class ShadowStack:
    branes: list[ShadowBrane] = field(default_factory=list)

    def add_brane(self, brane: ShadowBrane) -> None:
        self.branes.append(brane)

    def summary(self) -> dict:
        if not self.branes:
            return {"count": 0, "mass_total": 0.0, "d_min": None, "d_max": None}
        masses = [b.mass_eff for b in self.branes]
        ds = [b.d_sep for b in self.branes]
        return {
            "count": len(self.branes),
            "mass_total": float(sum(masses)),
            "d_min": float(min(ds)),
            "d_max": float(max(ds)),
        }


def _L4_from_R(R_signed: float, eps: float) -> float:
    return float(np.sqrt(12.0 / max(abs(R_signed), eps)))


def mass_eff(Lambda: float, R_signed: float, a_cft: float,
             sim_config: SimConfig, shadow_params: ShadowParams) -> float:
    eps = sim_config.split_model.eps_num
    L4 = _L4_from_R(R_signed, eps)
    m4_sq = M4_sq(Lambda, sim_config.physics.m5_ell, a_cft,
                 sim_config.physics.kappa_ct, sim_config.physics.M5_cubed)
    return float(shadow_params.mass_scale) * float(m4_sq) / max(L4, eps)


def k_eff(Lambda: float, R_signed: float, sim_config: SimConfig, shadow_params: ShadowParams) -> float:
    eps = sim_config.split_model.eps_num
    L4 = _L4_from_R(R_signed, eps)
    return float(shadow_params.k_eff_factor) * float(Lambda) / max(L4, eps)


def _attenuation(mode: ShadowKernelMode, d_sep: float, q_eff: float) -> float:
    base = np.exp(-float(d_sep) * float(q_eff))
    if mode == "exp_cos":
        return float(base * np.cos(float(d_sep) * float(q_eff)))
    return float(base)


def shadow_coupling(branch: ShadowKernelMode, Lambda: float, R_signed: float, d_sep: float,
                    sim_config: SimConfig, shadow_params: ShadowParams) -> float:
    rec = sim_config.scenario.receiver
    phys = sim_config.physics

    k = k_eff(Lambda, R_signed, sim_config, shadow_params)
    q = np.sqrt(k * k + rec.m_bullet * rec.m_bullet)
    r = r_screen(Lambda, phys.m5_ell, rec.a_cft_rec, phys.kappa_ct, phys.M5_cubed)
    s = q / (q + r * (k * k))
    return _attenuation(branch, d_sep, q) * float(s)


def U_shadow(branch: ShadowKernelMode, Lambda: float, R_signed: float,
             stack: ShadowStack, sim_config: SimConfig,
             shadow_params: ShadowParams, a_cft_rec: Optional[float] = None) -> float:
    if not stack.branes or shadow_params.G_shadow == 0.0:
        return 0.0

    if a_cft_rec is None:
        a_cft_rec = sim_config.scenario.receiver.a_cft_rec

    M_rec = mass_eff(Lambda, R_signed, a_cft_rec, sim_config, shadow_params)
    total = 0.0
    for brane in stack.branes:
        g = shadow_coupling(branch, Lambda, R_signed, brane.d_sep, sim_config, shadow_params)
        total += brane.mass_eff * g
    return -float(shadow_params.G_shadow) * M_rec * total


def Q_shadow(branch: ShadowKernelMode, Lambda_prev: float, Lambda_new: float, R_prev: float,
             stack: ShadowStack, sim_config: SimConfig, shadow_params: ShadowParams,
             a_cft_rec: Optional[float] = None) -> float:
    if not stack.branes or shadow_params.G_shadow == 0.0:
        return 0.0
    u_new = U_shadow(branch, Lambda_new, R_prev, stack, sim_config, shadow_params, a_cft_rec=a_cft_rec)
    u_prev = U_shadow(branch, Lambda_prev, R_prev, stack, sim_config, shadow_params, a_cft_rec=a_cft_rec)
    return float(u_prev - u_new)


def shadow_bias_delta(a: float, Lambda_star: float, stack: ShadowStack,
                      sim_config: SimConfig, shadow_params: ShadowParams) -> float:
    if not stack.branes or shadow_params.G_shadow == 0.0:
        return 0.0
    if a == 0.0:
        return 0.0
    U_plus = U_shadow(shadow_params.kernel_mode_ds, Lambda_star, +a, stack,
                      sim_config, shadow_params, a_cft_rec=sim_config.scenario.source.a_cft_src)
    U_minus = U_shadow(shadow_params.kernel_mode_ads, Lambda_star, -a, stack,
                       sim_config, shadow_params, a_cft_rec=sim_config.scenario.receiver.a_cft_rec)
    return float(U_plus - U_minus)


def update_shadow_distances(stack: ShadowStack, dt: float, shadow_params: ShadowParams) -> None:
    if not stack.branes or shadow_params.d_growth_factor == 0.0:
        return
    for brane in stack.branes:
        brane.d_sep *= (1.0 + shadow_params.d_growth_factor * brane.H_frozen * dt)


def insert_shadow_brane(stack: ShadowStack, aeon_id: int, d_sep_base: float,
                        sim_config: SimConfig, shadow_params: ShadowParams) -> None:
    src = sim_config.scenario.source
    eps = sim_config.split_model.eps_num
    d_sep = float(d_sep_base + shadow_params.insert_offset)
    for brane in stack.branes:
        brane.d_sep += shadow_params.insert_offset

    R_signed = float(12.0 / (src.L4_src ** 2))
    M_eff = mass_eff(src.Lambda_src, R_signed, src.a_cft_src, sim_config, shadow_params)
    stack.add_brane(ShadowBrane(
        aeon_id=aeon_id,
        mass_eff=M_eff,
        d_sep=d_sep,
        Lambda_frozen=float(src.Lambda_src),
        R_signed_frozen=R_signed,
        H_frozen=float(src.H_src),
        a_cft_src=float(src.a_cft_src),
    ))


def build_shadow_stack_from_config(sim_config: SimConfig) -> ShadowStack:
    stack = ShadowStack()
    seeds = sim_config.shadow.stack_seed if sim_config.shadow else []
    for seed in seeds:
        if isinstance(seed, ShadowSeed):
            seed_obj = seed
        elif isinstance(seed, dict):
            try:
                seed_obj = ShadowSeed(**seed)
            except TypeError:
                continue
        else:
            continue
        a_cft_src = seed_obj.a_cft_src if seed_obj.a_cft_src is not None else sim_config.scenario.source.a_cft_src
        M_eff = mass_eff(seed_obj.Lambda_frozen, seed_obj.R_signed_frozen, a_cft_src, sim_config, sim_config.shadow)
        stack.add_brane(ShadowBrane(
            aeon_id=0,
            mass_eff=M_eff,
            d_sep=float(seed_obj.d0),
            Lambda_frozen=float(seed_obj.Lambda_frozen),
            R_signed_frozen=float(seed_obj.R_signed_frozen),
            H_frozen=float(seed_obj.H_frozen),
            a_cft_src=float(a_cft_src),
        ))
    return stack
