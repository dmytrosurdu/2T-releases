# uom_simulator/tests/test_split_solver.py

import unittest
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.lambda_solver import solve_next_lambda, KappaRunSpec, SplitParams
import uom_simulator.lambda_solver as ls

import torch
from uom_simulator.external.penalties_calculator.core.utils import DEVICE


class TestSplitSolver(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.cfg = load_config("configs/default_params.json")

    def test_split_when_no_root_exists(self):
        """
        Force residual to be strictly positive for all Λ so no root exists.
        That should yield a split event.
        """
        self.cfg.split_model.split_resid_tol = 0.0
        orig_by = ls.compute_by_batch
        orig_var = ls.compute_wall_penalty_varL4_batch
        orig_j_rp = ls.compute_j_rp_single

        try:
            def fake_by(params_batch, kernel_cfg, geom_consts, d_sep, L4_batch=None, debug_print=False):
                # Small Θ to allow Landau split fitting
                return torch.full((params_batch.shape[0],), 1e-6, dtype=torch.float64, device=DEVICE)

            def fake_var(params_batch, wall_geom, lambda_prev, n_quad=16, debug_print=False):
                # J_wall = 0
                return torch.zeros(params_batch.shape[0], dtype=torch.float64, device=DEVICE)

            ls.compute_by_batch = fake_by
            ls.compute_wall_penalty_varL4_batch = fake_var
            ls.compute_j_rp_single = lambda *args, **kwargs: 1.0
            self.cfg.leak.model = "rg_complement"
            self.cfg.leak.chi = 10.0

            res = solve_next_lambda(
                F_dS_k=10.0,
                Lambda_prev=1.0,
                R_prev=-(12.0/(100.0**2)),
                d_sep=self.cfg.scenario.aeon.initial_d_sep,
                sim_config=self.cfg,
                zeta=1.0,
                kappa_spec=KappaRunSpec(model="const", kappa0=self.cfg.physics.kappa_ct,
                                        lambda0=self.cfg.scenario.aeon.initial_Lambda, b=0.0),
                split_params=SplitParams(eps_lambda_step=0.1),
            )

            self.assertEqual(res.event_type, "split")
            self.assertIsNotNone(res.split)
            self.assertLess(res.R_next, 0.0)
            self.assertAlmostEqual(res.split.Q0, res.split.Q_rg_star)
        finally:
            ls.compute_by_batch = orig_by
            ls.compute_wall_penalty_varL4_batch = orig_var
            ls.compute_j_rp_single = orig_j_rp


if __name__ == "__main__":
    unittest.main()
