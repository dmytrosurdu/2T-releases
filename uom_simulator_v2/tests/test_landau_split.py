import unittest
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.split_landau import solve_landau_minima


class TestLandauSplit(unittest.TestCase):
    def test_symmetric_minima(self):
        a = 1e-3
        K = 4e-8
        b = 0.0
        res = solve_landau_minima(a=a, K=K, b=b, Q0=1e-8)
        self.assertAlmostEqual(res.R_ads, -a, places=10)
        self.assertAlmostEqual(res.R_ds, a, places=10)

    def test_biased_minima(self):
        a = 1e-3
        K = 4e-8
        b = 0.1
        res = solve_landau_minima(a=a, K=K, b=b, Q0=1e-8)
        self.assertLess(res.R_ads, 0.0)
        self.assertGreater(res.R_ds, 0.0)

    def test_split_failure_single_minimum(self):
        a = 1e-3
        K = 4e-8
        b = 10.0  # large bias; expect failure to find two minima
        with self.assertRaises(ValueError):
            solve_landau_minima(a=a, K=K, b=b, Q0=1e-8)


if __name__ == "__main__":
    unittest.main()
