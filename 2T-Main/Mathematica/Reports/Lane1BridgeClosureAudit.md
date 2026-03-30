# Lane 1 Realization and Uniqueness Audit

Date: `2026-03-29`

This packet audits the sharpened lane-1 realization stack in `UOM/split_controlled_completion_lift_note.tex`: existence of an audited unit realization, uniqueness modulo `Aminus`, and representative-secondary canonicalization.

## Exact status

- audited unit realization subordinate to the source-side bridge point: `exact finite-dimensional certificate`
- uniqueness modulo `Aminus` with quotient/reduced/accepted boundary invariants: `exact finite-dimensional certificate`
- canonical representative reconstruction with calibration dependence but invariant visible data: `exact finite-dimensional certificate`
- threshold alone implies `c_Lambda != 0`: `counterexample found`

## Reading

- The exact split family already contains a unit representative whose quotient point is the canonical source-side bridge point.
- On the full audited affine family `Junit + Aminus . a`, any two subordinate realizations differ only by `Aminus` and preserve the quotient point, the reduced welded image, and the accepted welded boundary image.
- Two distinct positive calibrations produce different exact `Jcan` vectors while remaining in the same ambiguity class and preserving all visible bridge invariants. This matches the representative-secondary physics.
- Threshold-only nonvanishing remains false; lane 2 stays separate.

## Verdict

- The exact-family support now matches the new theorem organization: one subordinate realization can be canonically promoted, and subordinate realizations are unique modulo `Aminus`.
- The remaining theorem boundary is no longer canonicalization or uniqueness; it is existence of one source-compatible unit realization from branchwise `B`-localized recoherence alone.
- Accepted welded boundary image invariance is certified on the explicit audited family and remains separate from the theorem-backed reduced-image control.