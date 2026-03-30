import math

from uom_simulator.config import load_config
from uom_simulator.shadow_sector import ShadowStack, ShadowBrane
from uom_simulator.separation import SeparationState, apply_tick_growth


def test_growth_updates_active_and_shadow():
    config = load_config("configs/benchmark_params.json")
    config.separation.shadow_growth_model = "frozen_H"
    config.separation.tick_duration_mode = "config"
    config.shadow.d_growth_factor = 0.5

    shadow_stack = ShadowStack()
    shadow_stack.add_brane(ShadowBrane(
        aeon_id=0,
        mass_eff=1.0,
        d_sep=2.0,
        Lambda_frozen=1.0,
        R_signed_frozen=0.01,
        H_frozen=1.0,
        a_cft_src=1.0,
    ))

    sep_state = SeparationState(d_active=1.0, shadow_stack=shadow_stack)

    apply_tick_growth(
        sep_state,
        H_src=1.0,
        tick_duration=0.1,
        Lambda=1.5,
        receiver_params=config.scenario.receiver,
        aeon_params=config.scenario.aeon,
        shadow_params=config.shadow,
        cfg=config.separation,
    )

    active_factor = 1.0 + 1.0 * 0.1
    shadow_factor = 1.0 + 0.5 * 1.0 * 0.1
    assert math.isclose(sep_state.d_active, 1.0 * active_factor, rel_tol=1e-12, abs_tol=1e-12)
    assert math.isclose(sep_state.shadow_stack.branes[0].d_sep, 2.0 * shadow_factor, rel_tol=1e-12, abs_tol=1e-12)
