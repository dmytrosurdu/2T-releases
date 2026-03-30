import math
import os
import sys
import unittest

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config, MultiAeonParams
from uom_simulator.multi_aeon_driver import build_next_aeon_config


class TestMultiAeonInheritance(unittest.TestCase):
    def setUp(self):
        self.cfg = load_config("configs/default_params.json")

    def test_build_next_aeon_config_v1(self):
        params = MultiAeonParams(
            n_aeons=2,
            inheritance_model="v1_residual_pin",
            FdS_model="from_split_seed",
        )
        self.cfg.separation.active_init_mode = "config"
        history = [
            {"tick": 0, "Lambda": 1.0, "Theta_k": 1e-4, "delta_I_k": 1e-3,
             "beta_k": 0.01, "F_dS": 10.0, "R_signed_prev": -0.1, "d_sep": 0.5},
            {"tick": 1, "Lambda": 1.2, "Theta_k": 8e-5, "delta_I_k": 9e-4,
             "beta_k": 0.01, "F_dS": 9.0, "R_signed_prev": -0.0999, "d_sep": 0.55},
        ]
        summary = {
            "ended_by": "split",
            "R_ads_post": -0.002,
            "Theta_star": 1e-4,
            "Lambda_star": 10.0,
            "R_ds_post": 0.0012,
            "F_dS_seed": 0.05,
        }

        next_cfg, handover_info = build_next_aeon_config(self.cfg, history, summary, params)
        self.assertIsNotNone(next_cfg)
        self.assertEqual(handover_info, {})
        self.assertAlmostEqual(next_cfg.scenario.aeon.initial_R0_abs, 0.002, places=12)
        self.assertAlmostEqual(next_cfg.scenario.receiver.L4_init, math.sqrt(12.0 / 0.002), places=12)
        expected_f0 = 0.05 / next_cfg.scenario.source.H_src
        self.assertAlmostEqual(next_cfg.scenario.aeon.initial_F_dS_factor, expected_f0, places=12)


if __name__ == "__main__":
    unittest.main()
