
# uom_simulator/aeon_driver.py  (energy-balance version)
import json
import math
import os
import sys
from dataclasses import dataclass

import numpy as np
import torch

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import SimConfig, load_config
from uom_simulator.utils import compute_degeneracy, window_ell
from uom_simulator.lambda_solver import solve_next_lambda, KappaRunSpec
from uom_simulator.external.penalties_calculator.core.utils import DEVICE


@dataclass
class SourceState:
    F_dS: float
    H_src: float
    d_sep: float


@dataclass
class ReceiverState:
    Lambda: float
    R_cumulative: float  # accumulated Θ
    L4: float            # current AdS4 radius (derived each tick for convenience)


def initialize_source_state(config: SimConfig) -> SourceState:
    H = config.scenario.source.H_src
    F0 = config.scenario.aeon.initial_F_dS_factor * H
    return SourceState(F_dS=F0, H_src=H, d_sep=config.scenario.aeon.initial_d_sep)


def run_aeon(config: SimConfig, zeta: float = 1.0,
             kappa_model: str = "const", kappa_b: float = 0.0,
             debug_ticks: int = 5000):

    print("--- Starting new aeon simulation (Energy-Balance Λ Solver) ---")
    print(f"Target |R₀| = {config.scenario.aeon.initial_R0_abs:.10e}")
    print(f"Initial Λ = {config.scenario.aeon.initial_Lambda:.10f}")
    print(f"Using device: {DEVICE}")

    # States
    source = initialize_source_state(config)
    L4_init = config.scenario.receiver.L4_init
    receiver = ReceiverState(Lambda=config.scenario.aeon.initial_Lambda,
                             R_cumulative=0.0,
                             L4=L4_init)

    # Running κ spec (reference κ0 at λ0 = initial Λ)
    kappa_spec = KappaRunSpec(
        model=kappa_model,
        kappa0=float(config.physics.kappa_ct),
        lambda0=float(config.scenario.aeon.initial_Lambda),
        b=float(kappa_b)
    )

    history = []

    for k in range(config.scenario.aeon.max_ticks):
        is_debug = k < debug_ticks
        if is_debug:
            print(f"\n==================== TICK {k} (DEBUG ON) ====================")

        # Separation used for this tick (source→receiver proper gap)
        d_sep_prev = float(source.d_sep)

        # Current |R0| from cumulative Θ
        R_abs_prev = config.scenario.aeon.initial_R0_abs - receiver.R_cumulative

        # Solve next Λ with zero bank
        res = solve_next_lambda(
            F_dS_k=source.F_dS,
            Lambda_prev=receiver.Lambda,
            R_abs_prev=R_abs_prev,
            d_sep=d_sep_prev,
            sim_config=config,
            zeta=zeta,
            kappa_spec=kappa_spec,
            verbose=is_debug
        )

        # Update states
        receiver.Lambda = res.Lambda_next
        receiver.R_cumulative += res.Theta
        receiver.L4 = res.L4_next

        # Source coherence stock drains by ΔI_k (used only for Θ amplitude scaling)
        source.F_dS = max(0.0, source.F_dS - res.delta_I_k)

        # Proper brane separation update (same as before)
        source.d_sep = d_sep_prev * (1 + config.scenario.aeon.d_sep_expansion_factor *
                                     config.scenario.source.H_src * config.scenario.aeon.tick_duration)
        d_sep_next = float(source.d_sep)

        # Log
        history.append({
            "tick": k,
            "Lambda": receiver.Lambda,
            "F_dS": source.F_dS,
            "d_sep_prev": d_sep_prev,
            "d_sep_next": d_sep_next,
            "Theta_k": res.Theta,
            "R_cumulative": receiver.R_cumulative,
            "L4": receiver.L4,
            "R_abs_prev": R_abs_prev,
            "R_abs_next": res.R_abs_next,
            "J_wall": res.J_wall,
            "DeltaE_geom": res.DeltaE_geom,
            "band_fraction": res.band_fraction,
            "beta_k": res.beta_k,
            "delta_I_k": res.delta_I_k,
            "status": res.status
        })

        if is_debug:
            print(f"[ENERGY] ΔE_geom={res.DeltaE_geom:.4e}  J_wall={res.J_wall:.4e}  resid={res.J_wall-res.DeltaE_geom:.2e}")
            print(f"[MOVE]   Λ: {float(history[-1]['Lambda']):.6g}  L4: {float(receiver.L4):.6g}")
            print(f"[Θ]      Θ_k={res.Theta:.4e}  R_cumul={receiver.R_cumulative:.4e}")
            print(f"[PAYLOAD] ΔI_k={res.delta_I_k:.4e}  band={res.band_fraction:.3f}  β={res.beta_k:.3e}  status={res.status}")

        # Flip condition
        if receiver.R_cumulative >= config.scenario.aeon.initial_R0_abs:
            print(f"*** Flip occurred at tick {k}! ***")
            summary = {"flipped": True, "flip_tick": k, "Theta_flip": res.Theta}
            return history, summary

        # Early stop if Θ ≈ 0 over many ticks (stalled)
        if res.Theta < 1e-20 and k > 10:
            print("Θ nearly zero; stopping early.")
            break

    print("Aeon ended: Maximum ticks reached without a flip.")
    return history, {"flipped": False, "flip_tick": None, "Theta_flip": 0.0}


def plot_aeon_history(history: list[dict], config: SimConfig):
    import matplotlib.pyplot as plt

    if not history:
        print("No history to plot.")
        return

    keys = ["tick", "Lambda", "Theta_k", "R_cumulative", "F_dS", "L4", "J_wall", "DeltaE_geom", "beta_k"]
    data = {key: [rec.get(key, float('nan')) for rec in history] for key in keys}

    fig, axs = plt.subplots(4, 2, figsize=(16, 16), constrained_layout=True)
    fig.suptitle("Aeon Evolution (Energy-Balance Λ Solver)", fontsize=18)

    axs[0, 0].plot(data["tick"], data["R_cumulative"], label="Cumulative R")
    axs[0, 0].axhline(config.scenario.aeon.initial_R0_abs, color='r', linestyle='--', label=r"$|R_0|$ Target")
    if history and history[-1]['R_cumulative'] >= config.scenario.aeon.initial_R0_abs:
        axs[0, 0].axvline(history[-1]['tick'], color='g', linestyle=':', label=f"Flip @ Tick {history[-1]['tick']}")
    axs[0, 0].set_title("Curvature Accumulation and Flip"); axs[0, 0].set(xlabel="Tick", ylabel="Cumulative R"); axs[0, 0].legend(); axs[0, 0].grid(True)

    axs[0, 1].plot(data["tick"], data["Lambda"], marker='.', linestyle='-')
    axs[0, 1].set_title(r"Receiver Cutoff $\Lambda$"); axs[0, 1].set(xlabel="Tick", ylabel=r"$\Lambda$"); axs[0, 1].grid(True)

    axs[1, 0].plot(data["tick"], data["Theta_k"]); axs[1, 0].set_title(r"BY Penalty per Tick $\Theta_k$"); axs[1, 0].set(xlabel="Tick", ylabel=r"$\Theta_k$"); axs[1, 0].grid(True)
    axs[1, 1].plot(data["tick"], data["F_dS"]); axs[1, 1].set_title("Source Coherence Stock"); axs[1, 1].set(xlabel="Tick", ylabel=r"$F_{dS}$"); axs[1, 1].grid(True)

    axs[2, 0].plot(data["tick"], data["L4"]); axs[2, 0].set_title(r"AdS$_4$ Radius $L_4$"); axs[2, 0].set(xlabel="Tick", ylabel=r"$L_4$"); axs[2, 0].grid(True)
    axs[2, 1].plot(data["tick"], data["J_wall"], label="J_wall"); axs[2, 1].plot(data["tick"], data["DeltaE_geom"], label="ΔE_geom"); axs[2, 1].legend(); axs[2, 1].set_title("Energy Balance"); axs[2, 1].grid(True)

    axs[3, 0].plot(data["tick"], data["beta_k"]); axs[3, 0].set_title("Dephasing Exponent β"); axs[3, 0].set(xlabel="Tick", ylabel="β"); axs[3, 0].grid(True)
    axs[3, 1].axis('off')

    plt.show()


if __name__ == "__main__":
    config_path = "configs/default_params.json"
    if not os.path.exists(config_path):
        print(f"Error: Default config file '{config_path}' not found. Please run from project root.")
        sys.exit(1)

    try:
        sim_config = load_config(config_path)
        history, summary = run_aeon(sim_config, zeta=1.0, kappa_model="const", kappa_b=0.0)
        print("\n--- Aeon Simulation Summary ---")
        print(json.dumps(summary, indent=2))
        if history:
            plot_aeon_history(history, sim_config)
    except Exception as e:
        print(f"Simulation failed: {e}")
        import traceback; traceback.print_exc()
        sys.exit(1)
