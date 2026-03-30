# tests/test_payload_torch.py

import unittest
import torch
import numpy as np
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.payload_engine import compute_retarded_knee as compute_knee_np
from uom_simulator.payload_engine_torch import compute_retarded_knee_torch


class TestPayloadTorch(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.config = load_config("configs/default_params.json")

    def test_torch_vs_numpy_consistency(self):
        """
        Ensures the PyTorch wrapper for the knee calculation returns results
        consistent with the original NumPy version.
        """
        print("\nTesting PyTorch vs NumPy consistency for payload engine...")

        lambda_rec = 2.5
        d_sep = self.config.scenario.aeon.initial_d_sep

        # NumPy version
        ell_star_np, taper_np = compute_knee_np(
            lambda_rec, d_sep,
            self.config.scenario.source, self.config.scenario.receiver, self.config.physics
        )

        # PyTorch wrapper version
        ell_star_torch, taper_torch = compute_retarded_knee_torch(
            lambda_rec, d_sep,
            self.config.scenario.source, self.config.scenario.receiver, self.config.physics
        )

        # Compare ell_star (float)
        self.assertAlmostEqual(ell_star_np, ell_star_torch, places=5)

        # Compare taper (torch tensor vs numpy array)
        taper_torch_cpu = taper_torch.cpu().numpy()
        self.assertTrue(np.allclose(taper_np, taper_torch_cpu, atol=1e-7))

        print("Consistency test PASSED.")


if __name__ == '__main__':
    unittest.main()