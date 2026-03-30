# scripts/test_kernel_harness.py

import torch
import sys
import os

# Add project root to path to allow imports
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.utils import map_config_to_kernels
from uom_simulator.external.penalties_calculator.core.by_kernel import compute_by_batch
from uom_simulator.external.penalties_calculator.core.conf_kernel import compute_conf_batch
from uom_simulator.external.penalties_calculator.core.utils import DEVICE


def run_harness():
    print("--- Running Kernel Test Harness ---")
    print(f"Using device: {DEVICE}")

    # 1. Load Config and Map to Kernel Format
    config_path = "configs/default_params.json"
    sim_config = load_config(config_path)
    kernel_config, geom_constants = map_config_to_kernels(sim_config)
    print("Configuration loaded and mapped successfully.")

    # 2. Create Dummy Batch Data on GPU
    batch_size = 4
    n_omega = kernel_config['surrogate']['grid_config']['n_omega']
    n_ell = kernel_config['surrogate']['grid_config']['n_ell']

    # Mimic the optimizer's candidate parameters
    log_delta_i = torch.log(torch.linspace(0.1, 1.0, batch_size, device=DEVICE))
    log_s_t = torch.log(torch.linspace(0.5, 2.0, batch_size, device=DEVICE))
    log_s_x = torch.log(torch.linspace(1.0, 4.0, batch_size, device=DEVICE))
    log_lambda = torch.log(torch.linspace(1.0, 5.0, batch_size, device=DEVICE))

    params_batch = torch.stack([log_delta_i, log_s_t, log_s_x, log_lambda], dim=1)

    # Create a dummy welded tangent tensor for the conformality kernel
    # δC ~ A_eff * TimeShape * SpaceShape
    # For a harness, a simple random tensor is sufficient.
    delta_C_batch = torch.randn(batch_size, n_omega, n_ell, device=DEVICE, dtype=torch.complex128)

    print(f"Created dummy data with batch_size={batch_size}, n_omega={n_omega}, n_ell={n_ell}")

    # 3. Call Kernels
    try:
        with torch.no_grad():
            # Test BY Kernel
            print("\nCalling BY Kernel...")
            theta_k_batch = compute_by_batch(params_batch, kernel_config, geom_constants, )
            print(f"BY Kernel returned tensor of shape: {theta_k_batch.shape}")
            print(f"Sample output (Theta_k): {theta_k_batch.cpu().numpy()}")

            # Test CONF Kernel
            print("\nCalling CONF Kernel...")
            d_conf_batch = compute_conf_batch(delta_C_batch, params_batch, kernel_config, geom_constants)
            print(f"CONF Kernel returned tensor of shape: {d_conf_batch.shape}")
            print(f"Sample output (D_conf): {d_conf_batch.cpu().numpy()}")

            print("\n--- Kernel Harness Test PASSED ---")

    except Exception as e:
        print(f"\n--- Kernel Harness Test FAILED ---")
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    run_harness()