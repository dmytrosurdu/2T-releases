# tests/test_optimizer.py

import unittest
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.p3_optimizer import optimize_tick_p3


class TestP3Optimizer(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.config = load_config("configs/default_params.json")

    def test_optimizer_basic_run(self):
        """
        Tests that the P3 optimizer runs without crashing and returns a valid TickResult.
        """
        print("\nTesting P3 Optimizer basic run...")

        # Inputs for a single tick
        F_dS_k = 10.0
        F_dS_band_fraction = 0.5
        Lambda_k = 1.5
        beta_k = 0.1

        tick_result = optimize_tick_p3(
            F_dS_k, F_dS_band_fraction, Lambda_k, beta_k, self.config,
            d_sep=self.config.scenario.aeon.initial_d_sep,
            wall_work_bank=0.0
        )

        # Assertions
        self.assertIsInstance(tick_result.delta_I, float)
        self.assertGreaterEqual(tick_result.delta_I, 0.0)
        self.assertLessEqual(tick_result.delta_I, F_dS_k * F_dS_band_fraction)

        self.assertIsInstance(tick_result.Theta_k, float)
        self.assertGreaterEqual(tick_result.Theta_k, 0.0)

        self.assertIsInstance(tick_result.optimal_next_Lambda, float)
        self.assertGreaterEqual(tick_result.optimal_next_Lambda, Lambda_k)

        self.assertGreaterEqual(tick_result.wall_work_avail, tick_result.wall_work_req)

        print(f"Optimizer returned next_Lambda: {tick_result.optimal_next_Lambda:.4f}")
        print("P3 Optimizer basic run test PASSED.")


if __name__ == '__main__':
    unittest.main()
