# 42 V2 Alpha Factorization Diagnostics

Date: `2026-03-18`

This markdown fallback records the simulator-side `v2-alpha` diagnostics after separating unreduced split-state differences from accepted-record reduced receiver differences.

## Diagnostic Sweep

| Family | Unreduced status | Reduced classification | Reduced difference present | Leakage present |
| --- | --- | --- | --- | --- |
| `ledger-fixed-b-rephase` | `no-modeled-falsifier` | `killed by reduction` | `False` | `False` |
| `ledger-fixed-bridge-leak` | `modeled-falsifier-found` | `depends on explicit bridge leakage` | `False` | `True` |
| `ledger-fixed-band-drift` | `modeled-falsifier-found` | `killed by reduction` | `False` | `False` |
| `ledger-fixed-center-drift` | `modeled-falsifier-found` | `killed by reduction` | `False` | `False` |
| control: `ledger-fixed-b-rephase` + `filler_toggle = true` | `accepted-record-control-fail` | `still visible after reduction` | `True` | `False` |

## Reading Rule

- Unreduced stress cases are not automatically reduced theorem-facing counterexamples.
- `killed by reduction` means the modeled difference disappears when the readout is restricted to accepted-record reduced data.
- `depends on explicit bridge leakage` means the family only remains relevant if explicit leakage is treated as theorem-facing failure.
- The direct payload-defect control is not a falsifier; it is only a reduced-readout sanity check.

## Scope Boundary

- `v1` remains frozen and unsplit.
- `v2-alpha` remains a simulator scaffold only.
- Gaussian completion remains fenced off.
