
# uom_simulator/aeon_driver.py  (energy-balance version)
import csv
import json
import math
import os
import sys
from dataclasses import dataclass
from datetime import datetime

import matplotlib.pyplot as plt
import numpy as np
import torch

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import SimConfig, load_config, enforce_source_hubble
from uom_simulator.utils import compute_degeneracy, window_ell
from uom_simulator.lambda_solver import solve_next_lambda, KappaRunSpec
from uom_simulator.shadow_sector import ShadowStack
from uom_simulator.separation import SeparationState, apply_tick_growth, apply_split_geometry
from uom_simulator.external.penalties_calculator.core.utils import DEVICE


@dataclass
class SourceState:
    F_dS: float
    H_src: float
    d_sep: float


@dataclass
class ReceiverState:
    Lambda: float
    R_signed: float  # signed curvature (AdS < 0, dS > 0)
    L4: float         # current AdS4 radius (derived each tick for convenience)


def initialize_source_state(config: SimConfig) -> SourceState:
    enforce_source_hubble(config.scenario.source)
    H = config.scenario.source.H_src
    F0 = config.scenario.aeon.initial_F_dS_factor * H
    return SourceState(F_dS=F0, H_src=H, d_sep=config.scenario.aeon.initial_d_sep)


def run_aeon(config: SimConfig, zeta: float = 1.0,
             kappa_model: str = "const", kappa_b: float = 0.0,
             debug_ticks: int = 0,
             shadow_stack: ShadowStack | None = None,
             aeon_id: int = 0):

    print("--- Starting new aeon simulation (Energy-Balance Λ Solver) ---")
    print(f"Target |R₀| = {config.scenario.aeon.initial_R0_abs:.10e}")
    print(f"Initial Λ = {config.scenario.aeon.initial_Lambda:.10f}")
    print(f"Using device: {DEVICE}")

    # States
    source = initialize_source_state(config)
    L4_init = config.scenario.receiver.L4_init
    R0_signed = -float(config.scenario.aeon.initial_R0_abs)
    receiver = ReceiverState(Lambda=config.scenario.aeon.initial_Lambda,
                             R_signed=R0_signed,
                             L4=L4_init)
    if shadow_stack is None:
        shadow_stack = ShadowStack()
    sep_state = SeparationState(d_active=config.scenario.aeon.initial_d_sep,
                                shadow_stack=shadow_stack)
    source.d_sep = sep_state.d_active

    # Running κ spec (reference κ0 at λ0 = initial Λ)
    kappa_spec = KappaRunSpec(
        model=kappa_model,
        kappa0=float(config.physics.kappa_ct),
        lambda0=float(config.scenario.aeon.initial_Lambda),
        b=float(kappa_b)
    )

    history = []
    export_sum = 0.0

    for k in range(config.scenario.aeon.max_ticks):
        is_debug = k < debug_ticks
        if is_debug:
            print(f"\n==================== TICK {k} (DEBUG ON) ====================")

        R_prev = receiver.R_signed
        L4_prev = receiver.L4

        # Solve next Λ with zero bank
        res = solve_next_lambda(
            F_dS_k=source.F_dS,
            Lambda_prev=receiver.Lambda,
            R_prev=R_prev,
            d_sep=sep_state.d_active,
            sim_config=config,
            zeta=zeta,
            kappa_spec=kappa_spec,
            shadow_stack=sep_state.shadow_stack,
            verbose=is_debug
        )

        if res.event_type == "stop":
            summary = {
                "flipped": False,
                "flip_tick": None,
                "Theta_flip": 0.0,
                "ended_by": res.status,
                "I_export_sum": export_sum,
            }
            if res.status == "negative_leak_detected":
                summary.update({
                    "Lambda_prev": receiver.Lambda,
                    "Lambda_next": res.Lambda_next,
                    "R_prev": R_prev,
                    "Q_rg": res.Q_rg,
                    "J_RP": res.J_RP,
                    "beta_dS": float("nan"),
                    "DeltaE_geom": res.DeltaE_geom,
                    "J_wall": res.J_wall,
                    "Residual": res.Residual,
                })
            return history, summary, sep_state.shadow_stack

        # Update states (normal tick or split)
        receiver.Lambda = res.Lambda_next
        receiver.R_signed = res.R_next
        receiver.L4 = res.L4_next
        export_sum += res.delta_I_k

        # Source coherence stock drains by ΔI_k (used only for Θ amplitude scaling)
        source.F_dS = max(0.0, source.F_dS - res.delta_I_k)

        # Log
        split = res.split
        F_dS_seed = float("nan")
        if res.event_type == "split" and split is not None:
            F_dS_seed = max(config.split_model.FdS_floor,
                            config.split_model.q0_to_FdS_scale * abs(split.Q0))

        shadow_summary = sep_state.shadow_stack.summary()
        history.append({
            "tick": k,
            "Lambda": receiver.Lambda,
            "F_dS": source.F_dS,
            "H_src": source.H_src,
            "d_sep": source.d_sep,
            "d_active": sep_state.d_active,
            "n_shadow": shadow_summary.get("count", 0),
            "min_shadow_d": shadow_summary.get("d_min"),
            "max_shadow_d": shadow_summary.get("d_max"),
            "Theta_k": res.Theta,
            "R_signed_prev": R_prev,
            "R_signed_next": receiver.R_signed,
            "L4": receiver.L4,
            "J_wall": res.J_wall,
            "Q_rg": res.Q_rg,
            "J_RP": res.J_RP,
            "beta_dS": float("nan"),
            "Q_shadow_drain": res.Q_rg,
            "DeltaE_geom": res.DeltaE_geom,
            "Residual": res.Residual,
            "band_fraction": res.band_fraction,
            "beta_k": res.beta_k,
            "delta_I_k": res.delta_I_k,
            "status": res.status,
            "event_type": res.event_type,
            "Lambda_star": split.Lambda_star if split else float("nan"),
            "Theta_star": split.Theta_star if split else float("nan"),
            "Q_rg": split.Q_rg_star if split else float("nan"),
            "Q0": split.Q0 if split else float("nan"),
            "Q0_bias": split.Q0 if split else float("nan"),
            "R_ads_post": split.split_curvatures.R_ads if split else float("nan"),
            "R_ds_post": split.split_curvatures.R_ds if split else float("nan"),
            "Landau_a": split.landau.a if split else float("nan"),
            "Landau_K": split.landau.K if split else float("nan"),
            "Landau_b": split.landau.b if split else float("nan"),
            "Landau_Q0": split.landau.Q0 if split else float("nan"),
            "Landau_Q0_bias": split.landau.Q0 if split else float("nan"),
            "Landau_eps": split.landau.eps if split else float("nan"),
            "Landau_delta_U_shadow": split.landau.delta_U_shadow if split else float("nan"),
            "M_ads": split.M_ads if split else float("nan"),
            "M_ds": split.M_ds if split else float("nan"),
            "F_dS_seed": F_dS_seed,
            "resid_star": split.resid_star if split else float("nan"),
            "imag_root_proxy": split.imag_root_proxy if split else float("nan"),
        })

        if is_debug:
            print(f"[ENERGY] ΔE_geom={res.DeltaE_geom:.4e}  J_wall={res.J_wall:.4e}  Q_rg={res.Q_rg:.4e}  resid={res.Residual:.2e}")
            print(f"[MOVE]   Λ: {float(history[-1]['Lambda']):.6g}  L4: {float(receiver.L4):.6g}")
            print(f"[Θ]      Θ_k={res.Theta:.4e}  R_signed={receiver.R_signed:.4e}")
            print(f"[PAYLOAD] ΔI_k={res.delta_I_k:.4e}  band={res.band_fraction:.3f}  β={res.beta_k:.3e}  status={res.status}")
            if res.event_type == "split" and split is not None:
                print(f"[SPLIT]  Λ*={split.Lambda_star:.6g}  Q0={split.Q0:.4e}  "
                      f"R_ads={split.split_curvatures.R_ads:.4e}  R_ds={split.split_curvatures.R_ds:.4e}")

        if res.event_type == "split" and split is not None:
            d_sep_pre_split = sep_state.d_active
            sep_result = apply_split_geometry(
                sep_state=sep_state,
                d_sep_pre_split=d_sep_pre_split,
                Lambda_star=split.Lambda_star,
                L4_prev=L4_prev,
                source_params=config.scenario.source,
                receiver_params=config.scenario.receiver,
                cfg=config.separation,
                sim_config=config,
                shadow_params=config.shadow,
                aeon_id=aeon_id,
            )
            history[-1].update({
                "d_sep_pre_split": sep_result.d_sep_pre_split,
                "d_birth": sep_result.d_birth,
                "d_active_next": sep_result.d_active_next,
                "omega_star": sep_result.omega_star,
                "k_star": sep_result.k_star,
                "q_by_star": sep_result.q_by,
                "n_shadow_before": sep_result.n_shadow_before,
                "n_shadow_after": sep_result.n_shadow_after,
                "d0_new_shadow": sep_result.d0_new_shadow,
                "min_shadow_d": sep_result.min_shadow_d,
                "max_shadow_d": sep_result.max_shadow_d,
            })
            F_dS_seed = max(config.split_model.FdS_floor,
                            config.split_model.q0_to_FdS_scale * abs(split.Q0))
            summary = {
                "flipped": False,
                "flip_tick": None,
                "Theta_flip": 0.0,
                "ended_by": "split",
                "split_tick": k,
                "Lambda_star": split.Lambda_star,
                "Theta_star": split.Theta_star,
                "Q_rg": split.Q_rg_star,
                "Q0": split.Q0,
                "Q0_bias": split.Q0,
                "Q_shadow_drain": split.Q_rg_star,
                "R_prev": R_prev,
                "L4_prev": L4_prev,
                "R_ads_post": split.split_curvatures.R_ads,
                "R_ds_post": split.split_curvatures.R_ds,
                "Landau_a": split.landau.a,
                "Landau_K": split.landau.K,
                "Landau_b": split.landau.b,
                "Landau_Q0": split.landau.Q0,
                "Landau_Q0_bias": split.landau.Q0,
                "Landau_eps": split.landau.eps,
                "Landau_delta_U_shadow": split.landau.delta_U_shadow,
                "M_ads": split.M_ads,
                "M_ds": split.M_ds,
                "F_dS_seed": F_dS_seed,
                "I_export_sum": export_sum,
                "resid_star": split.resid_star,
                "imag_root_proxy": split.imag_root_proxy,
                "shadow_stack_summary": sep_state.shadow_stack.summary(),
                "d_sep_pre_split": sep_result.d_sep_pre_split,
                "d_birth": sep_result.d_birth,
                "d_active_next": sep_result.d_active_next,
                "omega_star": sep_result.omega_star,
                "k_star": sep_result.k_star,
                "q_by_star": sep_result.q_by,
                "birth_d_sep": sep_result.d_active_next,
                "birth_q_star": sep_result.q_by,
                "birth_k_star": sep_result.k_star,
                "birth_L4_prev": L4_prev,
                "d0_new_shadow": sep_result.d0_new_shadow,
            }
            return history, summary, sep_state.shadow_stack

        # Separation update (active + shadow) for normal ticks
        apply_tick_growth(
            sep_state,
            H_src=source.H_src,
            tick_duration=config.scenario.aeon.tick_duration,
            Lambda=receiver.Lambda,
            receiver_params=config.scenario.receiver,
            aeon_params=config.scenario.aeon,
            shadow_params=config.shadow,
            cfg=config.separation,
        )
        source.d_sep = sep_state.d_active

    print("Aeon ended: Maximum ticks reached without a flip.")
    return history, {
        "flipped": False,
        "flip_tick": None,
        "Theta_flip": 0.0,
        "ended_by": "max_ticks",
        "I_export_sum": export_sum,
    }, sep_state.shadow_stack


def _default_output_dir() -> str:
    base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    return os.path.join(base_dir, "outputs")


def _resolve_output_dir(output_dir: str | None) -> str:
    if output_dir is None:
        output_dir = _default_output_dir()
    os.makedirs(output_dir, exist_ok=True)
    return output_dir


def _default_run_id() -> str:
    return datetime.now().strftime("%Y%m%d_%H%M%S")


def _json_default(obj):
    if isinstance(obj, (np.floating, np.integer)):
        return obj.item()
    if isinstance(obj, np.ndarray):
        return obj.tolist()
    return str(obj)


def save_aeon_history(history: list[dict], output_dir: str | None = None,
                      run_id: str | None = None) -> dict:
    if not history:
        print("No history to save.")
        return {}

    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()

    base = f"aeon_{run_id}"
    json_path = os.path.join(output_dir, f"{base}_history.json")
    csv_path = os.path.join(output_dir, f"{base}_history.csv")

    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(history, f, indent=2, default=_json_default)

    keys = sorted({key for row in history for key in row.keys()})
    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(history)

    print(f"Saved history JSON to {json_path}")
    print(f"Saved history CSV to {csv_path}")
    return {"json": json_path, "csv": csv_path}


def save_aeon_summary(summary: dict, output_dir: str | None = None,
                      run_id: str | None = None) -> str:
    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()

    path = os.path.join(output_dir, f"aeon_{run_id}_summary.json")
    with open(path, "w", encoding="utf-8") as f:
        json.dump(summary, f, indent=2, default=_json_default)

    print(f"Saved summary JSON to {path}")
    return path


def plot_aeon_history(history: list[dict], config: SimConfig,
                      output_dir: str | None = None,
                      run_id: str | None = None) -> str | None:
    if not history:
        print("No history to plot.")
        return None

    keys = [
        "tick", "Lambda", "Theta_k", "R_signed_next", "F_dS", "L4",
        "J_wall", "DeltaE_geom", "beta_k", "Residual", "Q0", "Q_rg", "J_RP",
        "d_active", "min_shadow_d",
    ]
    data = {key: [rec.get(key, float('nan')) for rec in history] for key in keys}

    fig, axs = plt.subplots(5, 2, figsize=(16, 20), constrained_layout=True)
    fig.suptitle("Aeon Evolution (Energy-Balance Λ Solver)", fontsize=18)

    split_tick = next((rec["tick"] for rec in history if rec.get("event_type") == "split"), None)

    axs[0, 0].plot(data["tick"], data["R_signed_next"], label="R_signed")
    axs[0, 0].axhline(0.0, color='r', linestyle='--', label="R = 0")
    if split_tick is not None:
        axs[0, 0].axvline(split_tick, color='m', linestyle=':', label=f"Split @ Tick {split_tick}")
    axs[0, 0].set_title("Signed Curvature R"); axs[0, 0].set(xlabel="Tick", ylabel="R"); axs[0, 0].legend(); axs[0, 0].grid(True)

    axs[0, 1].plot(data["tick"], data["Lambda"], marker='.', linestyle='-')
    if split_tick is not None:
        axs[0, 1].axvline(split_tick, color='m', linestyle=':')
    axs[0, 1].set_title(r"Receiver Cutoff $\Lambda$"); axs[0, 1].set(xlabel="Tick", ylabel=r"$\Lambda$"); axs[0, 1].grid(True)

    axs[1, 0].plot(data["tick"], data["Theta_k"])
    if split_tick is not None:
        axs[1, 0].axvline(split_tick, color='m', linestyle=':')
    axs[1, 0].set_title(r"BY Penalty per Tick $\Theta_k$"); axs[1, 0].set(xlabel="Tick", ylabel=r"$\Theta_k$"); axs[1, 0].grid(True)
    axs[1, 1].plot(data["tick"], data["F_dS"])
    if split_tick is not None:
        axs[1, 1].axvline(split_tick, color='m', linestyle=':')
    axs[1, 1].set_title("Source Coherence Stock"); axs[1, 1].set(xlabel="Tick", ylabel=r"$F_{dS}$"); axs[1, 1].grid(True)

    axs[2, 0].plot(data["tick"], data["L4"])
    if split_tick is not None:
        axs[2, 0].axvline(split_tick, color='m', linestyle=':')
    axs[2, 0].set_title(r"AdS$_4$ Radius $L_4$"); axs[2, 0].set(xlabel="Tick", ylabel=r"$L_4$"); axs[2, 0].grid(True)
    axs[2, 1].plot(data["tick"], data["J_wall"], label="J_wall"); axs[2, 1].plot(data["tick"], data["DeltaE_geom"], label="ΔE_geom")
    if split_tick is not None:
        axs[2, 1].axvline(split_tick, color='m', linestyle=':')
    axs[2, 1].legend(); axs[2, 1].set_title("Energy Balance"); axs[2, 1].grid(True)

    axs[3, 0].plot(data["tick"], data["beta_k"])
    if split_tick is not None:
        axs[3, 0].axvline(split_tick, color='m', linestyle=':')
    axs[3, 0].set_title("Dephasing Exponent β"); axs[3, 0].set(xlabel="Tick", ylabel="β"); axs[3, 0].grid(True)
    axs[3, 1].plot(data["tick"], data["d_active"], label="d_active")
    axs[3, 1].plot(data["tick"], data["min_shadow_d"], label="min_shadow_d", linestyle="--")
    if split_tick is not None:
        axs[3, 1].axvline(split_tick, color='m', linestyle=':')
    axs[3, 1].set_title("Active/Shadow Separation")
    axs[3, 1].set(xlabel="Tick", ylabel="Distance")
    axs[3, 1].legend()
    axs[3, 1].grid(True)

    axs[4, 0].plot(data["tick"], data["Residual"], label="Residual")
    axs[4, 0].plot(data["tick"], data["Q_rg"], label="Q_rg", linestyle="--")
    if split_tick is not None:
        axs[4, 0].axvline(split_tick, color='m', linestyle=':')
    axs[4, 0].set_title("Residual and Split Q0")
    axs[4, 0].set(xlabel="Tick", ylabel="Value")
    axs[4, 0].legend()
    axs[4, 0].grid(True)

    axs[4, 1].axis("off")

    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()
    plot_path = os.path.join(output_dir, f"aeon_{run_id}_plot.png")
    fig.savefig(plot_path, dpi=150)
    plt.close(fig)
    print(f"Saved plot to {plot_path}")
    return plot_path


if __name__ == "__main__":
    config_path = "configs/default_params.json"
    if not os.path.exists(config_path):
        print(f"Error: Default config file '{config_path}' not found. Please run from project root.")
        sys.exit(1)

    try:
        sim_config = load_config(config_path)
        history, summary, _ = run_aeon(sim_config, zeta=1.0, kappa_model="const", kappa_b=0.0)
        print("\n--- Aeon Simulation Summary ---")
        print(json.dumps(summary, indent=2))
        if history:
            run_id = _default_run_id()
            save_aeon_summary(summary, run_id=run_id)
            save_aeon_history(history, run_id=run_id)
            plot_aeon_history(history, sim_config, run_id=run_id)
    except Exception as e:
        print(f"Simulation failed: {e}")
        import traceback; traceback.print_exc()
        sys.exit(1)
