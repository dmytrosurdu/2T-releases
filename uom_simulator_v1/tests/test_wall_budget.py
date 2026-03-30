# tests/test_wall_budget.py
import unittest
from uom_simulator.config import load_config
from uom_simulator.p3_optimizer import optimize_tick_p3

class TestWallBudget(unittest.TestCase):
    def test_budget_positive_moves(self):
        cfg = load_config("configs/benchmark_params.json")
        # ensure eta>0 for this test
        self.assertGreater(cfg.scenario.receiver.eta_wall_work, 0.0)
        res = optimize_tick_p3(
            F_dS_k=100.0,
            F_dS_band_fraction=0.1,
            Lambda_k=1.0,
            beta_k=1e-3,
            sim_config=cfg,
            d_sep=cfg.scenario.aeon.initial_d_sep,
            debug_print=True
        )
        self.assertGreater(res.wall_work_avail, 0.0)
        self.assertGreaterEqual(res.optimal_next_Lambda, 1.0)

if __name__ == "__main__":
    unittest.main()
