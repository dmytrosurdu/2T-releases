# UOM Simulator

This project contains the Minimal Viable Simulator (MVS) for the Universe-Originating Measurement (UOM) physical theory.

## Project Structure

- `configs/`: JSON files for simulation parameters.
- `outputs/`: Stores generated plots and data.
- `scripts/`: Main executable scripts.
- `tests/`: Unit tests for the core logic.
- `uom_simulator/`: The core Python source package.

## Setup

1.  Create a virtual environment:
    ```bash
    python -m venv venv
    source venv/bin/activate
    ```

2.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Usage

Run the main simulation script:
```bash
python scripts/run_simulation.py --config configs/default_params.json
```
