
# uom_simulator/tests/test_lambda_solver.py

import unittest
import os, sys, math
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.lambda_solver import solve_next_lambda, KappaRunSpec
import uom_simulator.external.penalties_calculator.core.by_kernel as byk
import uom_simulator.external.penalties_calculator.core.wall_kernel as wk

import torch
from uom_simulator.external.penalties_calculator.core.utils import DEVICE


class TestLambdaSolver(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.cfg = load_config("configs/default_params.json")

    def test_smoke_runs_and_residual_small_with_fakes(self):
        """
        Monkey-patch kernels to controlled surrogates so we can assert movement & balance.
        Θ(Λ) strictly decreasing; J_wall grows ~ log Λ + Λ^2.
        """
        # Save originals
        orig_by = byk.compute_by_batch
        orig_var = wk.compute_wall_penalty_varL4_batch

        try:
            def fake_by(params_batch, kernel_cfg, geom_consts, d_sep, L4_batch=None, debug_print=False):
                # Θ(Λ) = C / Λ^2 ; read Λ from params col 3 (effective) but scale with physical s_t to keep monotone
                lam_eff = torch.exp(params_batch[:, 3])
                C = torch.tensor(1.0, dtype=torch.float64, device=DEVICE)
                return (C / (lam_eff ** 2)).to(torch.float64)

            def fake_var(params_batch, wall_geom, lambda_prev, n_quad=16, debug_print=False):
                lam = torch.exp(params_batch[:, 3])
                lam0 = torch.tensor(float(lambda_prev), dtype=torch.float64, device=DEVICE)
                A = torch.tensor(0.1, dtype=torch.float64, device=DEVICE)
                B = torch.tensor(0.01, dtype=torch.float64, device=DEVICE)
                j = (A * torch.log(lam/lam0) + 0.5 * B * (lam*lam - lam0*lam0))
                return j

            byk.compute_by_batch = fake_by
            wk.compute_wall_penalty_varL4_batch = fake_var

            res = solve_next_lambda(
                F_dS_k=10.0,
                Lambda_prev=1.0,
                R_prev=-(12.0/(100.0**2)),  # L4=100 ⇒ |R0| ≈ 0.0012 (AdS)
                d_sep=self.cfg.scenario.aeon.initial_d_sep,
                sim_config=self.cfg,
                zeta=1.0,
                kappa_spec=KappaRunSpec(model="const", kappa0=self.cfg.physics.kappa_ct,
                                        lambda0=self.cfg.scenario.aeon.initial_Lambda, b=0.0)
            )

            self.assertGreaterEqual(res.Lambda_next, 1.0)
            self.assertLess(abs(res.J_wall - res.DeltaE_geom), 1e-6)
            self.assertEqual(res.event_type, "move")
        finally:
            # Restore originals
            byk.compute_by_batch = orig_by
            wk.compute_wall_penalty_varL4_batch = orig_var


if __name__ == "__main__":
    unittest.main()
