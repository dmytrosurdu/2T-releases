# tests/test_payload.py

import unittest
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import os
import sys
import json
from copy import deepcopy

# Ensure the main package is in the Python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config, SourceParams
from uom_simulator.payload_engine import compute_retarded_knee


class TestPayloadEngine(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        """Load default and test-specific configurations once for all tests."""
        config_path = "configs/default_params.json"
        if not os.path.exists(config_path):
            raise FileNotFoundError("Default config file not found. Run tests from project root.")
        cls.config = load_config(config_path)

        test_config_path = "configs/test_params.json"
        if os.path.exists(test_config_path):
            with open(test_config_path, 'r') as f:
                cls.test_params = json.load(f).get('test_overrides', {})
        else:
            # If the test config is missing, create an empty dict to avoid errors
            cls.test_params = {}

    def test_knee_bounds(self):
        """Test if the computed ell_star is within the expected physical bounds."""
        d_sep = self.config.scenario.aeon.initial_d_sep
        ell_star, _ = compute_retarded_knee(
            Lambda_rec=2.0,
            d_sep=d_sep,
            source_params=self.config.scenario.source,
            receiver_params=self.config.scenario.receiver,
            phys_const=self.config.physics
        )
        self.assertIsInstance(ell_star, float)
        self.assertGreaterEqual(ell_star, 0.0)
        self.assertLessEqual(ell_star, self.config.scenario.source.l_max_source)

    def test_taper_shape(self):
        """Test the shape and values of the generated Fermi-Dirac taper."""
        d_sep = self.config.scenario.aeon.initial_d_sep
        ell_star, taper = compute_retarded_knee(
            Lambda_rec=2.0,
            d_sep=d_sep,
            source_params=self.config.scenario.source,
            receiver_params=self.config.scenario.receiver,
            phys_const=self.config.physics
        )

        self.assertEqual(len(taper), self.config.scenario.source.l_max_source + 1)
        self.assertTrue(np.all(taper >= 0) and np.all(taper <= 1))

        ell_star_int = int(round(ell_star))
        if 0 <= ell_star_int < len(taper):
            self.assertAlmostEqual(taper[ell_star_int], 0.5, delta=0.1, msg="Taper should be ~0.5 at the knee.")

    def test_knee_monotonicity_with_lambda_rec(self):
        """Test if ell_star is non-decreasing with the receiver cutoff Lambda_rec."""
        d_sep = self.config.scenario.aeon.initial_d_sep
        lambda1, lambda2 = 1.0, 5.0

        ell_star1, _ = compute_retarded_knee(lambda1, d_sep, self.config.scenario.source, self.config.scenario.receiver,
                                             self.config.physics)
        ell_star2, _ = compute_retarded_knee(lambda2, d_sep, self.config.scenario.source, self.config.scenario.receiver,
                                             self.config.physics)

        print(f"\nMonotonicity Test (Λ_rec): ell_star({lambda1})={ell_star1:.2f}, ell_star({lambda2})={ell_star2:.2f}")
        self.assertGreaterEqual(ell_star2, ell_star1 - 1e-6, "ell_star should be non-decreasing with Lambda_rec")

    def test_knee_monotonicity_with_d_sep(self):
        """Test if ell_star is non-increasing with increasing brane separation d_sep."""
        d_sep_near = self.config.scenario.aeon.initial_d_sep
        d_sep_far = self.test_params.get('receiver_far', {}).get('d_sep', 10.0)

        ell_star_near, _ = compute_retarded_knee(5.0, d_sep_near, self.config.scenario.source,
                                                 self.config.scenario.receiver, self.config.physics)
        ell_star_far, _ = compute_retarded_knee(5.0, d_sep_far, self.config.scenario.source,
                                                self.config.scenario.receiver, self.config.physics)

        print(
            f"Monotonicity Test (d_sep): ell_star(d={d_sep_near})={ell_star_near:.2f}, ell_star(d={d_sep_far})={ell_star_far:.2f}")
        self.assertLessEqual(ell_star_far, ell_star_near)


class TestPayloadVisualization(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.config = load_config("configs/default_params.json")
        test_config_path = "configs/test_params.json"
        if os.path.exists(test_config_path):
            with open(test_config_path, 'r') as f:
                cls.test_params = json.load(f).get('test_overrides', {}).get('plot_3d', {})
        else:
            cls.test_params = {}

    def test_plot_bandlimit_surface(self):
        """Generate and display a 3D surface plot of ell_star(Lambda_rec, Lambda_src)."""
        print("\nGenerating 3D bandlimit surface plot...")

        n_points = self.test_params.get('n_points', 20)
        lambda_min_log = self.test_params.get('lambda_min_log', 0)
        lambda_max_log = self.test_params.get('lambda_max_log', 2.5)

        lambda_rec_vals = np.logspace(lambda_min_log, lambda_max_log, n_points)
        lambda_src_vals = np.logspace(lambda_min_log, lambda_max_log, n_points)
        X, Y = np.meshgrid(lambda_rec_vals, lambda_src_vals)
        Z = np.zeros_like(X)

        d_sep_for_plot = self.config.scenario.aeon.initial_d_sep

        for i in range(n_points):
            for j in range(n_points):
                # Create a temporary source config with the current Lambda_src for the grid
                temp_source_dict = self.config.scenario.source.__dict__.copy()
                temp_source_dict['Lambda_src'] = Y[i, j]
                temp_source_params = SourceParams(**temp_source_dict)

                ell_star, _ = compute_retarded_knee(
                    X[i, j],
                    d_sep_for_plot,
                    temp_source_params,
                    self.config.scenario.receiver,
                    self.config.physics
                )
                Z[i, j] = ell_star

        fig = plt.figure(figsize=(12, 8))
        ax = fig.add_subplot(111, projection='3d')
        surf = ax.plot_surface(np.log10(X), np.log10(Y), Z, cmap='viridis', edgecolor='none')

        ax.set_title(r"Bandlimit Knee $\ell_\star$ as a Function of Cutoffs")
        ax.set_xlabel(r"Receiver Cutoff $\log_{10}(\Lambda_{rec})$")
        ax.set_ylabel(r"Source Cutoff $\log_{10}(\Lambda_{src})$")
        ax.set_zlabel(r"Knee $\ell_\star$")
        fig.colorbar(surf, shrink=0.5, aspect=5, label=r"$\ell_\star$")

        print("Displaying 3D plot. Close the plot window to continue tests.")
        plt.show()


if __name__ == '__main__':
    unittest.main()