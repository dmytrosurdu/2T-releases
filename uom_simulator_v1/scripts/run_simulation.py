# scripts/run_simulation.py

import argparse
import csv
import json
import os
import sys

# Add project root to the Python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.aeon_driver import run_aeon, plot_aeon_history


def main():
    parser = argparse.ArgumentParser(description="Run the UOM Aeon Simulator.")
    parser.add_argument(
        '--config',
        type=str,
        default='configs/benchmark_params.json',
        help='Path to the simulation configuration JSON file.'
    )
    parser.add_argument(
        '--outdir',
        type=str,
        default='outputs',
        help='Directory to write outputs (history/summary). Created if missing.'
    )
    parser.add_argument(
        '--save-json',
        action='store_true',
        help='Write aeon history + summary to JSON files in outdir.'
    )
    parser.add_argument(
        '--save-csv',
        action='store_true',
        help='Write aeon history to a CSV file in outdir.'
    )
    parser.add_argument(
        '--no-plot',
        action='store_true',
        help='Skip interactive plotting.'
    )
    parser.add_argument(
        '--debug-ticks',
        type=int,
        default=25,
        help='Number of initial ticks to print debug diagnostics for (default: 25).'
    )
    args = parser.parse_args()

    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    config_path = args.config
    if not os.path.isabs(config_path) and not os.path.exists(config_path):
        alt = os.path.join(project_root, config_path)
        if os.path.exists(alt):
            config_path = alt

    if not os.path.exists(config_path):
        print(f"Error: Config file not found at '{args.config}' (also tried '{config_path}')")
        sys.exit(1)

    try:
        sim_config = load_config(config_path)
        sim_config.scenario.aeon.initial_R0_abs = 12.0 / (sim_config.scenario.receiver.L4_init ** 2)
        aeon_history, aeon_summary = run_aeon(sim_config, debug_ticks=int(args.debug_ticks))

        print("\n--- Aeon Simulation Summary ---")
        print(json.dumps(aeon_summary, indent=2, sort_keys=True))

        if aeon_history:
            last = aeon_history[-1]
            d_sep_prev = last.get("d_sep_prev")
            d_sep_next = last.get("d_sep_next")
            tick = last.get("tick")
            if d_sep_next is not None:
                try:
                    d_prev_f = float(d_sep_prev) if d_sep_prev is not None else float("nan")
                    d_next_f = float(d_sep_next)
                    print(f"\n--- Final proper separation ---")
                    print(f"tick={tick}  d_sep_prev={d_prev_f:.6e}  d_sep_next={d_next_f:.6e}")
                except (TypeError, ValueError):
                    pass

        if (args.save_json or args.save_csv) and aeon_history is not None:
            outdir = args.outdir
            if not os.path.isabs(outdir):
                outdir = os.path.join(project_root, outdir)
            os.makedirs(outdir, exist_ok=True)

            if args.save_json:
                history_path = os.path.join(outdir, "aeon_history.json")
                summary_path = os.path.join(outdir, "aeon_summary.json")
                with open(history_path, "w", encoding="utf-8") as f:
                    json.dump(aeon_history, f, indent=2, sort_keys=True)
                with open(summary_path, "w", encoding="utf-8") as f:
                    json.dump(aeon_summary, f, indent=2, sort_keys=True)
                print(f"\n[Saved] {history_path}")
                print(f"[Saved] {summary_path}")

            if args.save_csv:
                csv_path = os.path.join(outdir, "aeon_history.csv")
                fieldnames: list[str] = []
                seen: set[str] = set()
                for rec in aeon_history:
                    for key in rec.keys():
                        if key not in seen:
                            seen.add(key)
                            fieldnames.append(key)
                with open(csv_path, "w", encoding="utf-8", newline="") as f:
                    writer = csv.DictWriter(f, fieldnames=fieldnames)
                    writer.writeheader()
                    writer.writerows(aeon_history)
                print(f"[Saved] {csv_path}")

        if aeon_history and not args.no_plot:
            plot_aeon_history(aeon_history, sim_config)

    except Exception as e:
        print(f"\n--- Simulation failed with an error ---")
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
