from __future__ import annotations

import copy
import csv
import json
import math
import os
from datetime import datetime

import matplotlib.pyplot as plt

from uom_simulator.analysis import analyze_aeon_history, analyze_multi_aeon
from uom_simulator.aeon_driver import run_aeon, save_aeon_history, save_aeon_summary, plot_aeon_history
from uom_simulator.shadow_sector import build_shadow_stack_from_config
from uom_simulator.separation import compute_birth_gap
from uom_simulator.config import MultiAeonParams, SimConfig, enforce_source_hubble


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


def _initial_F_dS(config: SimConfig) -> float:
    return config.scenario.aeon.initial_F_dS_factor * config.scenario.source.H_src


def _safe_sqrt(x: float) -> float:
    return math.sqrt(max(x, 1e-300))


def _birth_d_sep(config: SimConfig, summary: dict, params: MultiAeonParams) -> tuple[float, dict]:
    d_birth = summary.get("d_birth") or summary.get("birth_d_sep")
    if d_birth is not None and math.isfinite(float(d_birth)) and float(d_birth) > 0.0:
        info = {
            "birth_d_sep": float(d_birth),
            "birth_q_by": summary.get("q_by_star"),
            "birth_omega_star": summary.get("omega_star"),
            "birth_k_star": summary.get("k_star"),
            "birth_L4_prev": summary.get("birth_L4_prev"),
        }
        return float(d_birth), info

    lam_star = summary.get("Lambda_star")
    L4_prev = summary.get("birth_L4_prev")
    if lam_star is None or L4_prev is None:
        raise ValueError("missing Lambda_star or L4_prev for birth separation")
    d_birth, q_by, omega_star, k_star = compute_birth_gap(
        float(lam_star),
        config.scenario.receiver,
        float(L4_prev),
        config.separation,
    )
    info = {
        "birth_d_sep": d_birth,
        "birth_q_by": q_by,
        "birth_omega_star": omega_star,
        "birth_k_star": k_star,
        "birth_L4_prev": float(L4_prev),
    }
    return d_birth, info


def _pin_next_R0_abs(summary: dict) -> float:
    eps_r = 1e-300
    r_ads = summary.get("R_ads_post", -eps_r)
    return max(abs(float(r_ads)), eps_r)


def _predict_r0_formula_b(config: SimConfig, history: list[dict],
                          params: MultiAeonParams) -> float:
    eps_r = 1e-300
    tail_n = min(20, len(history))
    tail = history[-tail_n:] if tail_n > 0 else history
    k_tail = []
    for rec in tail:
        di = rec.get("delta_I_k", 0.0)
        if di != 0.0:
            k_tail.append(rec.get("Theta_k", 0.0) / di)
    k_tail_mean = sum(k_tail) / len(k_tail) if k_tail else 0.0
    beta_tail = [rec.get("beta_k", 0.0) for rec in tail]
    beta_mean = sum(beta_tail) / len(beta_tail) if beta_tail else 0.0
    r0_prev = config.scenario.aeon.initial_R0_abs
    f0 = _initial_F_dS(config)
    s_pre = sum(rec.get("Theta_k", 0.0) for rec in history[:-tail_n]) if len(history) > tail_n else 0.0
    candidate = math.sinh(beta_mean) * max(k_tail_mean * f0 - r0_prev + s_pre, 0.0)
    return max(params.inherit_c * candidate, eps_r)


def build_next_aeon_config(prev_config: SimConfig, history: list[dict],
                           summary: dict, params: MultiAeonParams) -> tuple[SimConfig | None, dict]:
    if summary.get("ended_by") != "split":
        return None, {}

    next_config = copy.deepcopy(prev_config)
    handover_info: dict = {}

    r0_next = _pin_next_R0_abs(summary)
    next_config.scenario.aeon.initial_R0_abs = r0_next
    next_config.scenario.receiver.L4_init = _safe_sqrt(12.0 / r0_next)

    if params.max_ticks_per_aeon is not None:
        next_config.scenario.aeon.max_ticks = params.max_ticks_per_aeon

    if params.lambda_reset == "carry":
        next_config.scenario.aeon.initial_Lambda = history[-1].get("Lambda", prev_config.scenario.aeon.initial_Lambda)
    elif params.lambda_reset == "scale":
        last = history[-1].get("Lambda", prev_config.scenario.aeon.initial_Lambda)
        next_config.scenario.aeon.initial_Lambda = last * params.lambda_scale

    sep_mode = prev_config.separation.active_init_mode
    if sep_mode == "config":
        next_config.scenario.aeon.initial_d_sep = prev_config.scenario.aeon.initial_d_sep
    elif sep_mode == "carry":
        next_config.scenario.aeon.initial_d_sep = history[-1].get("d_active", prev_config.scenario.aeon.initial_d_sep)
    elif sep_mode == "birth_by":
        try:
            d_sep_birth, info = _birth_d_sep(prev_config, summary, params)
        except ValueError as exc:
            handover_info.update({
                "handover_status": "invalid_birth_separation",
                "handover_error": str(exc),
            })
            return None, handover_info
        next_config.scenario.aeon.initial_d_sep = d_sep_birth
        handover_info.update(info)
    else:
        handover_info.update({
            "handover_status": "invalid_separation_mode",
            "handover_error": f"unknown separation mode: {sep_mode}",
        })
        return None, handover_info

    r_ds = summary.get("R_ds_post")
    if r_ds and r_ds > 0:
        l4_seed = _safe_sqrt(12.0 / r_ds)
        next_config.scenario.source.L4_src = l4_seed
        lam_star = summary.get("Lambda_star")
        if lam_star and lam_star > 0:
            next_config.scenario.source.Lambda_src = max(
                next_config.scenario.source.Lambda_src,
                float(lam_star),
            )

    enforce_source_hubble(next_config.scenario.source)

    if params.FdS_model == "from_split_seed":
        f_seed = summary.get("F_dS_seed", 0.0)
        h_src = max(next_config.scenario.source.H_src, 1e-300)
        next_config.scenario.aeon.initial_F_dS_factor = f_seed / h_src
    elif params.FdS_model == "from_exported_payload":
        export_sum = float(summary.get("I_export_sum", 0.0))
        export_sum = max(export_sum, 0.0)
        f0_next = params.inherit_c * export_sum
        h_src = max(next_config.scenario.source.H_src, 1e-300)
        next_config.scenario.aeon.initial_F_dS_factor = f0_next / h_src
    elif params.FdS_model == "rg_integrated_info":
        i_prev = prev_config.scenario.aeon.initial_F_dS_factor
        i_rg = summary.get("I_rg_sum", 0.0)
        i_next = max(i_prev + params.inherit_c * i_rg, i_prev)
        next_config.scenario.aeon.initial_F_dS_factor = i_next
    elif params.FdS_model == "carry_plus_gain":
        last_f = history[-1].get("F_dS", 0.0)
        f_seed = summary.get("F_dS_seed", 0.0)
        h_src = max(next_config.scenario.source.H_src, 1e-300)
        next_config.scenario.aeon.initial_F_dS_factor = (last_f + f_seed) / h_src

    return next_config, handover_info


def run_multi_aeon(config: SimConfig, zeta: float = 1.0,
                   kappa_model: str = "const", kappa_b: float = 0.0) -> tuple[list[list[dict]], list[dict], dict]:
    params = config.multi_aeon or MultiAeonParams()
    aeon_histories: list[list[dict]] = []
    aeon_summaries: list[dict] = []
    shadow_stack = build_shadow_stack_from_config(config)

    for aeon_index in range(params.n_aeons):
        debug_ticks = 0 if params.logging_level == "minimal" else 5
        history, summary, shadow_stack = run_aeon(
            config,
            zeta=zeta,
            kappa_model=kappa_model,
            kappa_b=kappa_b,
            debug_ticks=debug_ticks,
            shadow_stack=shadow_stack,
            aeon_id=aeon_index,
        )

        initial_f_dS = _initial_F_dS(config)
        summary = {
            **summary,
            "aeon_index": aeon_index,
            "initial_R0_abs": config.scenario.aeon.initial_R0_abs,
            "initial_Lambda": config.scenario.aeon.initial_Lambda,
            "initial_F_dS": initial_f_dS,
            "initial_F_dS_factor": config.scenario.aeon.initial_F_dS_factor,
            "initial_H_src": config.scenario.source.H_src,
            "initial_d_sep": config.scenario.aeon.initial_d_sep,
        }
        summary.update(analyze_aeon_history(history))

        r0_pred = _predict_r0_formula_b(config, history, params)
        r0_actual = abs(float(summary.get("R_ads_post", float("nan"))))
        r0_prev = config.scenario.aeon.initial_R0_abs
        q_actual = (r0_actual / r0_prev) if summary.get("ended_by") == "split" and r0_prev else float("nan")
        q_pred = (r0_pred / r0_prev) if r0_prev else float("nan")
        q_ratio = (q_pred / q_actual) if q_actual and not math.isnan(q_actual) else float("nan")
        summary.update({
            "R0_pred_formula_B": r0_pred,
            "q_actual": q_actual,
            "q_pred_formula_B": q_pred,
            "q_pred_over_actual": q_ratio,
            "inheritance_model_used": "split_handover_only",
        })

        aeon_histories.append(history)
        aeon_summaries.append(summary)

        next_config, handover_info = build_next_aeon_config(config, history, summary, params)
        if handover_info:
            summary.update(handover_info)
        if next_config is None:
            break
        config = next_config

    multi_summary = {
        "aeons": aeon_summaries,
        "analysis": analyze_multi_aeon(aeon_summaries),
    }
    return aeon_histories, aeon_summaries, multi_summary


def save_multi_aeon_summary(multi_summary: dict, output_dir: str | None = None,
                            run_id: str | None = None) -> dict:
    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()

    json_path = os.path.join(output_dir, f"multi_aeon_{run_id}_summary.json")
    csv_path = os.path.join(output_dir, f"multi_aeon_{run_id}_summary.csv")

    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(multi_summary, f, indent=2)

    aeons = multi_summary.get("aeons", [])
    if aeons:
        keys = sorted({k for row in aeons for k in row.keys()})
        with open(csv_path, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=keys)
            writer.writeheader()
            writer.writerows(aeons)

    return {"json": json_path, "csv": csv_path}


def save_multi_aeon_history(aeon_histories: list[list[dict]], output_dir: str | None = None,
                            run_id: str | None = None) -> dict:
    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()

    json_path = os.path.join(output_dir, f"multi_aeon_{run_id}_history.json")
    csv_path = os.path.join(output_dir, f"multi_aeon_{run_id}_history.csv")

    flat = []
    for i, history in enumerate(aeon_histories):
        for rec in history:
            entry = dict(rec)
            entry["aeon_index"] = i
            flat.append(entry)

    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(flat, f, indent=2)

    if flat:
        keys = sorted({k for row in flat for k in row.keys()})
        with open(csv_path, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=keys)
            writer.writeheader()
            writer.writerows(flat)

    return {"json": json_path, "csv": csv_path}


def plot_multi_aeon_summary(multi_summary: dict, output_dir: str | None = None,
                            run_id: str | None = None) -> str | None:
    aeons = multi_summary.get("aeons", [])
    if not aeons:
        return None

    output_dir = _resolve_output_dir(output_dir)
    if run_id is None:
        run_id = _default_run_id()

    aeon_index = [row.get("aeon_index", i) for i, row in enumerate(aeons)]
    r0 = [row.get("initial_R0_abs", float("nan")) for row in aeons]
    r_ads = [abs(row.get("R_ads_post", float("nan"))) for row in aeons]
    lam_star = [row.get("Lambda_star", float("nan")) for row in aeons]

    fig, axs = plt.subplots(3, 1, figsize=(10, 12), constrained_layout=True)
    fig.suptitle("Multi-Aeon Summary", fontsize=16)

    axs[0].plot(aeon_index, r0, marker="o", label="R0_abs (init)")
    axs[0].plot(aeon_index, r_ads, marker="x", linestyle="--", label="|R_ads_post|")
    axs[0].set_yscale("log")
    axs[0].set_title("Curvature Magnitudes by Aeon")
    axs[0].set_xlabel("Aeon")
    axs[0].set_ylabel("|R|")
    axs[0].legend()
    axs[0].grid(True, which="both", linestyle=":")

    axs[1].plot(aeon_index, lam_star, marker="o")
    axs[1].set_title("Split Cutoff Λ* by Aeon")
    axs[1].set_xlabel("Aeon")
    axs[1].set_ylabel("Λ*")
    axs[1].grid(True, linestyle=":")

    q_actual = [row.get("q_actual", float("nan")) for row in aeons]
    q_pred = [row.get("q_pred_formula_B", float("nan")) for row in aeons]
    axs[2].plot(aeon_index, q_actual, marker="o", label="q_actual (handover)")
    axs[2].plot(aeon_index, q_pred, marker="x", linestyle="--", label="q_pred (formula B)")
    axs[2].set_title("Aeon Contraction: Actual vs Predicted")
    axs[2].set_xlabel("Aeon")
    axs[2].set_ylabel("q")
    axs[2].legend()
    axs[2].grid(True, linestyle=":")

    path = os.path.join(output_dir, f"multi_aeon_{run_id}_plot.png")
    fig.savefig(path, dpi=150)
    plt.close(fig)
    return path
