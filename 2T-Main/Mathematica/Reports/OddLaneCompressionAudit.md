# Odd-Lane Compression Audit

Date: `2026-03-18`

This audit answers the secondary quotient question:

Can the corrected full Main-visible readout be compressed further to the smaller odd-lane tuple

`(([Xi^{(1)}_{Lambda_k}], bar{rho}^{dom}_{Lambda_k}, epsilon_{Lambda_k}))`

without loss?

## Scope

This lane audits only the theorem-facing reduced welded image in the current exact audited family.
It does **not** claim a source theorem for the full accepted-record history.

The audit uses:

- [MainVisibleEquivalence_ReceiverClosureAudit.md](/home/kray-l8/work/2T/Main/Mathematica/Reports/MainVisibleEquivalence_ReceiverClosureAudit.md)
- [UOMWeldedBoundaryAudit.md](/home/kray-l8/work/2T/Main/Mathematica/Reports/UOMWeldedBoundaryAudit.md)
- [UOMBoundaryExpansion_Ledger.csv](/home/kray-l8/work/2T/Main/Mathematica/Reports/UOMBoundaryExpansion_Ledger.csv)

## Exact Current-Family Data

The current-family reduced readout data are:

- `chi = {0,0,1}`
- `Aminus = ker chi`
- `J0 = {0,0,1}`
- `epsilon = 1`
- `ProfileProjectorB = {{1,0},{0,0}}`

and the reduced image formula is

`R_main(v) = (chi . v) ProfileProjectorB`.

So the reduced theorem-facing image depends only on the odd scalar coordinate `chi . v`.

## Exact Verdict

In the current exact audited family:

- same odd scalar `iff` same reduced welded image,
- no reduced exact falsifier was found,
- and the reduced theorem-facing image is rank-one/scalar.

Equivalently:

the smaller odd-lane tuple is sufficient to recover the theorem-facing reduced welded image in the
current family once the common reduced welded projection is imposed.

## What This Does Not Prove

- It does not prove that the full accepted-record history is recoverable from the odd-lane tuple.
- It does not prove a source theorem outside the current exact audited family.
- It does not identify the global fiber as `Z2`.

## Operational Conclusion

The current exact lane supports the projected compression target:

`odd-lane tuple -> reduced welded image`

but not the stronger history-level compression target:

`odd-lane tuple -> full accepted-record history`.
