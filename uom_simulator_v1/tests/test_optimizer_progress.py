# tests/test_optimizer_progress.py
import os
import math
import unittest
import types
import torch

from uom_simulator.config import load_config
import uom_simulator.p3_optimizer as p3


class TestOptimizerProgress(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.cfg = load_config("configs/default_params.json")

    def test_progress_when_cap_inactive_and_theta_decreasing(self):
        # --- Monkey-patch kernels with simple controllable surrogates ---
        # Θ(Λ) = C / Λ^p  (strictly decreasing)
        def fake_by(params_batch, kernel_cfg, geom_consts, debug_print=False):
            logL = params_batch[:, 3]
            L = torch.exp(logL)
            C = 1.0
            p = 2.0
            return (C / (L ** p)).to(torch.float64)

        # D_conf ≡ 0 (keep it simple)
        def fake_conf(deltaC_batch, params_batch, kernel_cfg, geom_consts):
            B = params_batch.shape[0]
            return torch.zeros(B, dtype=torch.float64, device=params_batch.device)

        # Wall work returns zero for all Λ (cap inactive)
        def fake_wall(params_batch, kernel_cfg, geom_consts, debug_print=False):
            B = params_batch.shape[0]
            return torch.zeros(B, dtype=torch.float64, device=params_batch.device)

        # Install fakes
        p3.compute_by_batch = fake_by
        p3.compute_conf_batch = fake_conf
        p3.compute_wall_penalty_batch = fake_wall

        # --- Run one tick with debug on ---
        F_dS_k = 100.0
        F_dS_band_fraction = 0.1
        L_k = 2.0
        beta_k = 1e-3  # small but non-zero
        os.environ["UOM_TICK_HINT"] = "99999"  # avoid overwriting any real file
        res = p3.optimize_tick_p3(
            F_dS_k, F_dS_band_fraction, L_k, beta_k, self.cfg, d_sep=0.5, debug_print=True
        )

        # Because Θ is decreasing and there is no cap, Λ must increase
        self.assertGreater(res.optimal_next_Lambda, L_k * 1.05,
                           msg="Λ failed to advance despite strictly decreasing Θ and no cap.")

        # Θ must drop at the chosen Λ
        self.assertLess(res.Theta_k, (1.0 / (L_k ** 2)),
                        msg="Θ at chosen Λ is not smaller than Θ at Λ_k.")

        # Wall work must be zero (cap was inactive)
        self.assertAlmostEqual(res.wall_work_req, 0.0, places=12)


if __name__ == "__main__":
    unittest.main()
