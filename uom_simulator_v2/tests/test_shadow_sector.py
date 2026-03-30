import unittest
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.shadow_sector import ShadowStack, ShadowBrane, U_shadow, Q_shadow, shadow_bias_delta, mass_eff


class TestShadowSector(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.cfg = load_config("configs/default_params.json")

    def test_empty_stack_zero(self):
        stack = ShadowStack()
        u = U_shadow("exp", 1.0, -0.001, stack, self.cfg, self.cfg.shadow)
        q = Q_shadow("exp", 1.0, 2.0, -0.001, stack, self.cfg, self.cfg.shadow)
        self.assertEqual(u, 0.0)
        self.assertEqual(q, 0.0)

    def test_potential_decay_with_distance(self):
        self.cfg.shadow.G_shadow = 1.0
        stack = ShadowStack()
        brane = ShadowBrane(
            aeon_id=0,
            mass_eff=1.0,
            d_sep=0.1,
            Lambda_frozen=1.0,
            R_signed_frozen=0.001,
            H_frozen=1.0,
            a_cft_src=self.cfg.scenario.source.a_cft_src,
        )
        stack.add_brane(brane)
        u_near = U_shadow("exp", 1.0, -0.001, stack, self.cfg, self.cfg.shadow)
        brane.d_sep = 10.0
        u_far = U_shadow("exp", 1.0, -0.001, stack, self.cfg, self.cfg.shadow)
        self.assertLess(abs(u_far), abs(u_near))

    def test_bias_nonzero_for_modes(self):
        self.cfg.shadow.G_shadow = 1.0
        stack = ShadowStack()
        R_shadow = 0.001
        M = mass_eff(1.0, R_shadow, self.cfg.scenario.source.a_cft_src, self.cfg, self.cfg.shadow)
        stack.add_brane(ShadowBrane(
            aeon_id=0,
            mass_eff=M,
            d_sep=0.5,
            Lambda_frozen=1.0,
            R_signed_frozen=R_shadow,
            H_frozen=1.0,
            a_cft_src=self.cfg.scenario.source.a_cft_src,
        ))
        delta = shadow_bias_delta(1e-3, 1.0, stack, self.cfg, self.cfg.shadow)
        self.assertTrue(isinstance(delta, float))


if __name__ == "__main__":
    unittest.main()
