# Main-Visible Equivalence Receiver-Closure Audit

Date: `2026-03-18`

This packet audits the candidate quotient defined by equality after accepted-record reduction plus
the common reduced welded projection. It reuses the reduced-receiver semantics fixed in the prior
closure audit and checks whether the Main-visible quotient remains compatible with the same reduced
receiver object and the same five closure clauses in the current exact audited family.

## Scope And Source Lock

This lane uses only:

- `UOM/source_internal_control_factorization_note.tex`
- `Main/appendix_main.tex::def:2T-char`
- `UOM/canonical_odd_interface_note.tex::thm:char-weak-interface`
- `UOM/canonical_odd_interface_note.tex::rem:char-weak-interface-rho-first`
- `UOM/canonical_odd_interface_note.tex::rem:Main-abstract`
- the prior reduced receiver packet in `Main/Mathematica/Reports/SourceInternalClosureAudit.md`

The result is an `exact finite-dimensional certificate` for the current audited family only. It is
not source-theorem promotion.

## Main-Visible Quotient Target

The Main-visible data consumed at weak-interface level are the abstract characterization data

`(E^-_Lambda, A^-_Lambda, [Xi^(1)_Lambda], chi_Lambda, epsilon_Lambda, B_Lambda)`

with the scalar readout carried by the weak exported functional

`chi_Lambda = nu_Lambda^(-1) rho^dom_Lambda`.

In the current exact audited family, the reduced receiver side already fixes one common welded
projector

`ProfileProjectorB = {{1,0},{0,0}}`.

So the candidate exact quotient is:

`v ~ w` iff the accepted-record reduction agrees and the reduced Main-visible readout agrees after the common welded projection.

At the exact current-family level this becomes:

`v ~ w` iff `(chi . v) ProfileProjectorB = (chi . w) ProfileProjectorB`.

## Exact Current-Family Data

The certified current-family transport/welded package gives:

- `chi = {0,0,1}`
- `Aminus = {{1,0},{0,1},{0,0}}`, stored as a basis matrix with columns spanning `ker chi`
- `J0 = {0,0,1}`
- `epsilon = chi . J0 = 1`
- `ProfileProjectorB = {{1,0},{0,0}}`

So:

- `Aminus = ker chi` in the current exact family,
- the quotient dimension is exactly `1`,
- and the reduced Main-visible readout has the explicit form
  `R_main(v) = (chi . v) ProfileProjectorB`.

This means the quotient is exactly the one-dimensional scalar quotient already seen through the
reduced welded line.

## Core Exact Equivalence

The exact lane certifies:

`same reduced Main-visible image` if and only if `same quotient coordinate`.

In the current family this reduces to:

- same reduced image `iff x3 = y3`,
- same quotient coordinate `iff x3 = y3`,
- no exact witness exists with different quotient coordinate but the same reduced Main-visible image,
- and no exact witness exists with the same quotient coordinate but a different reduced Main-visible image.

So there is no residual exact orbit structure beyond the one-dimensional scalar coordinate on the
reduced welded line.

## Answer To A: Receiver-Closure Compatibility

Yes. In the current exact audited family, the quotient remains compatible with the same reduced
receiver object and the same five closure clauses isolated in the previous sprint.

| closure clause | exact answer on the quotient target | reason |
| --- | --- | --- |
| bookkeeping closure | `Yes` | quotient representatives determine the same reduced receiver image on the same welded line, so the theorem-facing bookkeeping still refers to the same reduced object |
| bridge-target closure | `Yes` | the quotient readout already lands on the same reduced welded projector, so the theorem-facing object is unchanged |
| one-boundary covariance | `Yes` | all quotient images lie on one common rank-one welded line |
| RP/OS control | `Yes` | the reduced receiver object is the same one-dimensional welded line used in the previous reduced packet |
| single-cutoff geometry | `Yes` | the quotient does not introduce a second theorem-facing receiver object or a second theorem-facing cutoff structure |

So the Main-visible quotient does not force a new receiver semantics. It factors through the same
reduced receiver object already certified in the prior packet.

## Answer To B: Remaining Exact Countermodels

No exact reduced countermodel was found in the current audited family that distinguishes quotient
representatives while leaving all reduced Main-visible data unchanged.

The exact searches returned:

- `different quotient, same reduced image` -> no witness,
- `same quotient, different reduced image` -> no witness.

So the current family does not exhibit hidden reduced Main-visible distinctions inside a single
quotient fiber.

## Answer To C: Orbit Structure

The reduced Main-visible fibers look:

`rank-one/scalar with separate branch-orientation sign, not richer in the current audited family`.

More precisely:

- the quotient dimension is `1`,
- the reduced Main-visible image is `(chi . v) ProfileProjectorB`,
- the only surviving reduced degree of freedom is the scalar `chi . v`,
- and the sign/orientation datum is the separate branchwise `epsilon` channel, not a richer reduced
  orbit family.

So the exact lane does not see a richer reduced orbit structure in the current family. It sees a
one-dimensional scalar quotient together with the separate orientation sign.

## Answer To D: Collapse Of Broad Unreduced Differences

Yes, at exact current-family level and with the corrected reduced semantics.

The exact lane supports the statement that broad unreduced seam differences collapse to the same
reduced Main-visible readout whenever:

- the accepted-record reduction agrees,
- the common reduced welded projection is used,
- and no explicit accepted-record failure or explicit leakage branch is introduced.

Any remaining unreduced seam/source/tangent differences are theorem-invisible to the Main-visible
quotient as formulated here. That is fully consistent with the source note's corrected distinction
between theorem-visible reduced data and stronger unreduced source/tangent factorization targets.

## Top-Line Verdict

`Main-visible quotient survives exact receiver-closure audit in the current family`

with the sharper exact reading:

`No reduced exact falsifier was found; the quotient fibers are rank-one/scalar in the current audited family, not richer.`

## Non-Claims

- This is not source-internal theorem promotion.
- This does not prove full unreduced seam/source/tangent agreement.
- This does not enlarge Main beyond the abstract weak-interface data it already consumes.
- This does not discharge leakage or accepted-record failure cases; those remain explicit exceptions.
