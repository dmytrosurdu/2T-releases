# scripts/run_simulation.py

import argparse
import copy
import os
import sys
from datetime import datetime

# Add project root to the Python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from uom_simulator.config import load_config
from uom_simulator.aeon_driver import (
    run_aeon,
    plot_aeon_history,
    save_aeon_history,
    save_aeon_summary,
)
from uom_simulator.multi_aeon_driver import (
    run_multi_aeon,
    save_multi_aeon_history,
    save_multi_aeon_summary,
    plot_multi_aeon_summary,
)
from uom_simulator.shadow_sector import build_shadow_stack_from_config
import json


def main():
    parser = argparse.ArgumentParser(description="Run the UOM Aeon Simulator.")
    parser.add_argument(
        '--config',
        type=str,
        default='configs/benchmark_params.json',
        help='Path to the simulation configuration JSON file.'
    )
    parser.add_argument(
        '--multi-aeon',
        type=int,
        default=None,
        help='Override number of aeons to run (multi-aeon mode).'
    )
    parser.add_argument(
        '--output-dir',
        type=str,
        default=None,
        help='Output directory for run artifacts.'
    )
    args = parser.parse_args()

    if not os.path.exists(args.config):
        print(f"Error: Config file not found at '{args.config}'")
        sys.exit(1)

    try:
        sim_config = load_config(args.config)
        sim_config.scenario.aeon.initial_R0_abs=12.0/(sim_config.scenario.receiver.L4_init**2)
        if args.multi_aeon is not None:
            sim_config.multi_aeon.n_aeons = args.multi_aeon
        run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
        if sim_config.multi_aeon.n_aeons > 1:
            histories, summaries, multi_summary = run_multi_aeon(sim_config)
            print("\n--- Multi-Aeon Simulation Summary ---")
            print(json.dumps(multi_summary, indent=2))

            if histories and sim_config.multi_aeon.save_per_aeon_histories:
                for idx, history in enumerate(histories):
                    aeon_id = f"{run_id}_aeon{idx}"
                    summary = summaries[idx] if idx < len(summaries) else {}
                    save_aeon_summary(summary, run_id=aeon_id, output_dir=args.output_dir)
                    save_aeon_history(history, run_id=aeon_id, output_dir=args.output_dir)
                    plot_config = copy.deepcopy(sim_config)
                    if "initial_R0_abs" in summary:
                        plot_config.scenario.aeon.initial_R0_abs = summary["initial_R0_abs"]
                    plot_aeon_history(history, plot_config, run_id=aeon_id, output_dir=args.output_dir)

            if histories and sim_config.multi_aeon.save_aggregate_history:
                save_multi_aeon_history(histories, run_id=run_id, output_dir=args.output_dir)
            save_multi_aeon_summary(multi_summary, run_id=run_id, output_dir=args.output_dir)
            plot_multi_aeon_summary(multi_summary, run_id=run_id, output_dir=args.output_dir)
        else:
            shadow_stack = build_shadow_stack_from_config(sim_config)
            aeon_history, aeon_summary, _ = run_aeon(sim_config, shadow_stack=shadow_stack)

            print("\n--- Aeon Simulation Summary ---")
            print(json.dumps(aeon_summary, indent=2))

            if aeon_history:
                save_aeon_summary(aeon_summary, run_id=run_id, output_dir=args.output_dir)
                save_aeon_history(aeon_history, run_id=run_id, output_dir=args.output_dir)
                plot_aeon_history(aeon_history, sim_config, run_id=run_id, output_dir=args.output_dir)

    except Exception as e:
        print(f"\n--- Simulation failed with an error ---")
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
