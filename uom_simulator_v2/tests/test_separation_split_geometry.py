import math

from uom_simulator.config import load_config
from uom_simulator.shadow_sector import ShadowStack, ShadowBrane
from uom_simulator.separation import SeparationState, apply_split_geometry


def test_split_geometry_offsets_shadow_distances(tmp_path):
    config = load_config("configs/benchmark_params.json")
    shadow_stack = ShadowStack()
    shadow_stack.add_brane(ShadowBrane(
        aeon_id=0,
        mass_eff=1.0,
        d_sep=1.0,
        Lambda_frozen=1.0,
        R_signed_frozen=0.01,
        H_frozen=1.0,
        a_cft_src=1.0,
    ))
    shadow_stack.add_brane(ShadowBrane(
        aeon_id=0,
        mass_eff=1.0,
        d_sep=2.0,
        Lambda_frozen=1.0,
        R_signed_frozen=0.01,
        H_frozen=1.0,
        a_cft_src=1.0,
    ))
    sep_state = SeparationState(d_active=0.5, shadow_stack=shadow_stack)

    d_sep_pre = 0.5
    Lambda_star = 2.0
    L4_prev = 10.0

    result = apply_split_geometry(
        sep_state=sep_state,
        d_sep_pre_split=d_sep_pre,
        Lambda_star=Lambda_star,
        L4_prev=L4_prev,
        source_params=config.scenario.source,
        receiver_params=config.scenario.receiver,
        cfg=config.separation,
        sim_config=config,
        shadow_params=config.shadow,
        aeon_id=0,
    )

    assert math.isclose(result.d_active_next, result.d_birth, rel_tol=1e-12, abs_tol=1e-12)
    assert math.isclose(result.d0_new_shadow, d_sep_pre + result.d_birth, rel_tol=1e-12, abs_tol=1e-12)
    assert result.n_shadow_after == result.n_shadow_before + 1
    assert all(brane.d_sep >= result.d_birth for brane in sep_state.shadow_stack.branes)
