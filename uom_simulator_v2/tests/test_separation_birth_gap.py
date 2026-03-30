import math

from uom_simulator.config import ReceiverParams, SeparationParams
from uom_simulator.separation import compute_birth_gap


def _make_receiver(m_bullet: float) -> ReceiverParams:
    return ReceiverParams(
        L4_init=100.0,
        a_cft_rec=1.0,
        m_bullet=m_bullet,
        v_geom=1.0,
        alpha_t=1.5,
        alpha_x=1.5,
        eta_wall_work=1.0,
        lambda_by=1.0,
        lambda_conf=1.0,
        lambda_wall=1.0,
        cL_map=10.0,
        deltaL_soft=15.0,
        deltaL_taper=5.0,
    )


def test_birth_gap_independent_of_m_bullet():
    cfg = SeparationParams(c_by=1.0)
    L4_prev = 10.0
    lam_star = 2.5

    rec1 = _make_receiver(m_bullet=0.05)
    rec2 = _make_receiver(m_bullet=0.2)

    d1, q1, _, _ = compute_birth_gap(lam_star, rec1, L4_prev, cfg)
    d2, q2, _, _ = compute_birth_gap(lam_star, rec2, L4_prev, cfg)

    assert math.isclose(d1, d2, rel_tol=1e-12, abs_tol=1e-12)
    assert math.isclose(q1, q2, rel_tol=1e-12, abs_tol=1e-12)
