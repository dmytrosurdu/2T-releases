# uom_simulator/payload_engine.py

import numpy as np
import math
from scipy.optimize import root_scalar

from uom_simulator.config import SourceParams, ReceiverParams, PhysicsConstants
from uom_simulator.utils import r_screen, window_ell, acceptance_flat_G12_sq


def knee_objective_log(ell: float, Lambda_rec: float, d_sep: float,  # d_sep is now a direct arg
                       source_params: SourceParams, receiver_params: ReceiverParams,
                       phys_const: PhysicsConstants) -> float:
    if ell <= 1e-6: return float('inf')

    k_ell = math.sqrt(ell * (ell + 2.0)) / receiver_params.L4_init
    rho_src = (ell + 1.0) ** 2

    Delta_omega = Lambda_rec / max(receiver_params.alpha_t, 1e-9)
    Delta_k = (receiver_params.v_geom * Lambda_rec) / max(receiver_params.alpha_x, 1e-9)
    omega_ell = math.sqrt(source_params.H_src ** 2 * ell * (ell + 2) + source_params.m_src ** 2)
    pi_src = source_params.cost_t_factor * (omega_ell / Delta_omega) ** 2 + \
             source_params.cost_x_factor * (k_ell / Delta_k) ** 2

    r1 = r_screen(Lambda_rec, phys_const.m5_ell, receiver_params.a_cft_rec, phys_const.kappa_ct, phys_const.M5_cubed)
    r2 = r_screen(source_params.Lambda_src, phys_const.m5_ell, source_params.a_cft_src, phys_const.kappa_ct,
                  phys_const.M5_cubed)

    W1 = window_ell(np.array([ell]), receiver_params.L4_init, Lambda_rec, receiver_params.cL_map,
                    receiver_params.deltaL_soft)[0]
    W2 = window_ell(np.array([ell]), source_params.L4_src, source_params.Lambda_src, source_params.cL_map_src,
                    source_params.deltaL_soft_src)[0]

    eps2 = acceptance_flat_G12_sq(k_ell, receiver_params.m_bullet, d_sep, r1, r2)

    value_term = rho_src * W1 * W2 * eps2
    if value_term <= 1e-40: return -float('inf')

    return math.log(value_term) - math.log(max(pi_src, 1e-40))


def compute_retarded_knee(
        Lambda_rec: float, d_sep: float,
        source_params: SourceParams, receiver_params: ReceiverParams, phys_const: PhysicsConstants
) -> tuple[float, np.ndarray]:
    max_ell_source = source_params.l_max_source
    Lambda_src = source_params.Lambda_src
    ell_min, ell_max = 1e-3, float(max_ell_source)

    args = (Lambda_rec, d_sep, source_params, receiver_params, phys_const)

    grid = np.linspace(ell_min, ell_max, 400)
    vals = np.array([knee_objective_log(x, *args) for x in grid])
    mask = np.isfinite(vals)
    grid, vals = grid[mask], vals[mask]

    if not len(vals): return 0.0, np.zeros(max_ell_source + 1)

    idx = np.where(np.sign(vals[:-1]) * np.sign(vals[1:]) < 0)[0]
    if len(idx) > 0:
        a, b = grid[idx[0]], grid[idx[0] + 1]
        try:
            sol = root_scalar(knee_objective_log, args=args, bracket=[a, b], method='brentq')
            ell_star = sol.root
        except (ValueError, RuntimeError):
            ell_star = float(grid[np.argmin(np.abs(vals))])
    else:
        ell_star = float(grid[np.argmin(np.abs(vals))])

    ells = np.arange(max_ell_source + 1)
    kw_taper = 1.0 / (1.0 + np.exp((ells - ell_star) / max(1e-6, receiver_params.deltaL_taper)))
    return ell_star, kw_taper