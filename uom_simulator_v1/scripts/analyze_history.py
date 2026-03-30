#!/usr/bin/env python3
"""
Analyze an exported aeon history (JSON or CSV) and report the tick where |R|
crosses a chosen threshold (default: 1e-120), along with the source→receiver
proper separation d_sep if available.

This script intentionally uses only the Python standard library so it can run
even in minimal environments.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
import os
import sys
from typing import Any, Dict, Iterable, List, Optional, Tuple


def _coerce_float(value: Any) -> Optional[float]:
    if value is None:
        return None
    if isinstance(value, (int, float)):
        return float(value)
    if isinstance(value, str):
        s = value.strip()
        if s == "":
            return None
        try:
            return float(s)
        except ValueError:
            return None
    return None


def _load_history(path: str) -> List[Dict[str, Any]]:
    ext = os.path.splitext(path)[1].lower()
    if ext == ".json":
        with open(path, "r", encoding="utf-8") as f:
            obj = json.load(f)
        if isinstance(obj, dict) and "history" in obj and isinstance(obj["history"], list):
            return obj["history"]
        if isinstance(obj, list):
            return obj
        raise ValueError("JSON history must be a list, or an object with a 'history' list.")

    if ext == ".csv":
        with open(path, "r", encoding="utf-8", newline="") as f:
            reader = csv.DictReader(f)
            return [dict(row) for row in reader]

    raise ValueError("Unsupported history format. Use .json or .csv.")


def _load_dsep_growth_from_config(config_path: str) -> Tuple[float, float]:
    """
    Returns (initial_d_sep, growth_per_tick) where:
      d_sep(tick=k, at tick start) = initial_d_sep * growth_per_tick**k
    """
    with open(config_path, "r", encoding="utf-8") as f:
        cfg = json.load(f)
    initial_d_sep = float(cfg["scenario"]["aeon"]["initial_d_sep"])
    exp_factor = float(cfg["scenario"]["aeon"]["d_sep_expansion_factor"])
    H_src = float(cfg["scenario"]["source"]["H_src"])
    dt = float(cfg["scenario"]["aeon"]["tick_duration"])
    growth = 1.0 + exp_factor * H_src * dt
    return initial_d_sep, growth


def _compute_dsep_at_tick(
    tick: int,
    initial_d_sep: float,
    growth_per_tick: float,
) -> float:
    return float(initial_d_sep) * (float(growth_per_tick) ** int(tick))


def _first_crossing(
    history: Iterable[Dict[str, Any]],
    threshold_rabs: float,
    use_field: str,
) -> Optional[Dict[str, Any]]:
    for rec in history:
        rabs = _coerce_float(rec.get(use_field))
        if rabs is None:
            continue
        if rabs <= threshold_rabs:
            return rec
    return None


def _fmt(x: Optional[float]) -> str:
    if x is None or not math.isfinite(x):
        return "n/a"
    return f"{x:.6e}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Analyze UOM aeon history exports.")
    parser.add_argument(
        "--history",
        required=True,
        help="Path to aeon history file (JSON or CSV).",
    )
    parser.add_argument(
        "--final",
        action="store_true",
        help="Report the final record in the history (ignores threshold crossing).",
    )
    parser.add_argument(
        "--threshold-rabs",
        type=float,
        default=1e-120,
        help="Curvature magnitude threshold |R| to detect (default: 1e-120).",
    )
    parser.add_argument(
        "--field",
        choices=["R_abs_prev", "R_abs_next"],
        default="R_abs_next",
        help="Which history field to compare against the threshold.",
    )
    parser.add_argument(
        "--config",
        default=None,
        help="Optional config JSON path (used to compute d_sep if not present in the history).",
    )
    args = parser.parse_args()

    history_path = args.history
    if not os.path.exists(history_path):
        print(f"Error: history file not found: {history_path}", file=sys.stderr)
        return 2

    history = _load_history(history_path)
    if not history:
        print("Empty history.", file=sys.stderr)
        return 2

    # Sort by tick if present (CSV loads ticks as strings).
    def tick_key(rec: Dict[str, Any]) -> int:
        t = _coerce_float(rec.get("tick"))
        return int(t) if t is not None else 0

    history_sorted = sorted(history, key=tick_key)

    if args.final:
        rec = history_sorted[-1]
    else:
        rec = _first_crossing(history_sorted, args.threshold_rabs, args.field)
        if rec is None:
            print(f"No record with {args.field} <= {args.threshold_rabs:.3e}.")
            return 1

    tick_val = _coerce_float(rec.get("tick"))
    tick = int(tick_val) if tick_val is not None else 0

    r_prev = _coerce_float(rec.get("R_abs_prev"))
    r_next = _coerce_float(rec.get("R_abs_next"))
    lam = _coerce_float(rec.get("Lambda"))
    L4 = _coerce_float(rec.get("L4"))
    status = rec.get("status")

    d_sep_prev = _coerce_float(rec.get("d_sep_prev"))
    d_sep_next = _coerce_float(rec.get("d_sep_next"))

    if d_sep_prev is None and args.config is not None:
        cfg_path = args.config
        if not os.path.isabs(cfg_path):
            # try relative to history directory first
            cfg_alt = os.path.join(os.path.dirname(os.path.abspath(history_path)), cfg_path)
            if os.path.exists(cfg_alt):
                cfg_path = cfg_alt
        if not os.path.exists(cfg_path):
            print(f"Warning: config file not found for d_sep reconstruction: {args.config}", file=sys.stderr)
        else:
            d0, growth = _load_dsep_growth_from_config(cfg_path)
            d_sep_prev = _compute_dsep_at_tick(tick, d0, growth)
            d_sep_next = _compute_dsep_at_tick(tick + 1, d0, growth)

    # If L4 is missing, compute from R_abs_next (or prev) when possible.
    if L4 is None:
        r_for_L4 = r_next if r_next is not None else r_prev
        if r_for_L4 is not None and r_for_L4 > 0:
            L4 = math.sqrt(12.0 / r_for_L4)

    title = "=== Final record ===" if args.final else "=== Threshold crossing ==="
    print(title)
    if not args.final:
        print(f"threshold |R|:   {_fmt(args.threshold_rabs)}")
    print(f"tick:            {tick}")
    print(f"R_abs_prev:      {_fmt(r_prev)}")
    print(f"R_abs_next:      {_fmt(r_next)}")
    print(f"L4:              {_fmt(L4)}   (via |R|=12/L4^2 if computed)")
    print(f"Lambda:          {_fmt(lam)}")
    print(f"d_sep_prev:      {_fmt(d_sep_prev)}")
    print(f"d_sep_next:      {_fmt(d_sep_next)}")
    print(f"status:          {status}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
