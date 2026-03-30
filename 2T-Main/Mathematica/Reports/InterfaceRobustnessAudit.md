# Interface Robustness Audit

Date: `2026-03-14`

This packet re-runs the current interface decisions with the Research Lead's requested refinement: `geometric locking` is split into its two theorem-facing ingredients, `receiver band-lock` and `co-centering`, before classification. The goal is not broader interface discovery. The goal is to decide which current candidates are genuinely stable and which are only compressed summaries inside the exact audited WL family.

## Executive Decision

| Candidate or package | Classification | Reason |
| --- | --- | --- |
| `I0` boundary interface | `stable working minimum in current candidate family` | It is the smallest mock-tested boundary interface in the current candidate family that still proves the current boundary canonicalization theorem and has non-UOM realizations. |
| `I1` with fused `GeometricLockingQ` | `overcompressed` | The live text stack and exact ablations both show that band-lock and co-centering matter separately. |
| decomposed structural boundary package `{accepted-record preservation, band-lock, rank-one line, co-centering, descended-scalar factorization}` | `family-relative minimum` | Every one-at-a-time ablation exits `strong-safe`, but this exact minimality is only certified inside the current WL family. |
| three-axiom compression `{accepted-record preservation, rank-one descended image, geometric locking}` | `family-relative minimum` | It works only because `geometric locking` compresses two separate ingredients inside the current encoded family. |
| `I2` completion-aware interface | `family-relative minimum` | It is the smallest mock-tested completion-aware candidate in the current candidate family, but its completion additions remain non-promoted: one is a bounded packaging theorem on explicit split data and the other is still assumption-backed. |
| legacy generic visible-ambiguity lane | negative control retained | It remains the required unsafe baseline. |

## Packet Rule

Every decision below separates:

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| live manuscript and note ingredients that already exist as theorems, propositions, definitions, or remarks | current exact finite-dimensional audit results and mock-family classifications | assumptions, family boundaries, and surrogate limitations that still block abstract or microscopic promotion |

## Exact One-At-A-Time Ablation Results

### Decomposed strong-safe package

The exact current welded-family `strong-safe` package is:

- `exact accepted-record preservation`
- `receiver band-lock`
- `one-dimensional compressed welded line`
- `co-centering`
- `descended-scalar factorization`

### Exact ablation outcomes

| ablation | outcome |
| --- | --- |
| remove exact accepted-record preservation | `mod-null-safe` |
| relax receiver band-lock | `visible-ambiguity` |
| raise compressed rank above one | `visible-ambiguity` |
| relax co-centering | `visible-ambiguity` |
| replace descended-scalar factorization | `visible-ambiguity` |

Interpretation: every one-at-a-time ablation exits the `strong-safe` class. Accepted-record preservation is special only in that its removal leaves a weaker `mod-null-safe` lane rather than immediate visible ambiguity.

## Candidate-by-Candidate Audit

### Candidate `I0`

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| `Main/appendix_main.tex::def:2T-char` and `Main/appendix_main.tex::thm:finite-cutoff-Jcan` say that Main consumes an abstract seven-slot interface and produces `Jcan` from that interface, without requiring microscopic completion data. | `Main/Mathematica/Reports/CosmologyBoundaryInterfaceCandidates.md` certifies that `I0` is the minimal mock-tested boundary candidate, with UOM and non-UOM realizations, and that the boundary theorem follows while the completion theorem does not. | This is still mock-tested and exact finite-dimensional, not an abstract necessity theorem over all admissible cosmology theories. |

Verdict: `stable working minimum in current candidate family`

Reason: within the current exact candidate family, nothing smaller still proves the boundary theorem, and the interface is theory-neutral enough to admit non-UOM realizations.

### Candidate `I1` With Fused `GeometricLockingQ`

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| The live UOM text already treats band-lock and co-centering as distinct theorem-level ingredients. `prop:compressed-log-lock` packages both, but not as a claim that they are one indivisible primitive. | The original interface mock family allowed `GeometricLockingQ` as a single predicate, and `I1` passed boundary tests there. The new ablation split shows that relaxing band-lock and relaxing co-centering independently both destroy `strong-safe`. | The fused predicate is therefore only a family-level compression. It is not yet an honest theorem-facing primitive. |

Verdict: `overcompressed`

Reason: the current theorem text and current exact ablations both refuse to treat geometric locking as one already-discharged axiom.

### Decomposed Structural Boundary Package

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| `receiver band-lock`, `one-dimensional compressed welded line`, and `co-centering` are theorem-backed. `exact accepted-record preservation` is now theorem-backed on the theorem-visible reduced receiver, and `descended-scalar factorization` is now packaged as a conditional theorem under explicit transport hypotheses. | `Main/Mathematica/Reports/MinimalUOMBoundarySafeHypotheses.md` and the exact welded ablation lane certify that the five-piece package is exactly the current `strong-safe` package and that every one-at-a-time ablation exits `strong-safe`. | The minimality statement is still relative to the current exact welded family; it is not yet a text-level theorem over all realizations or perturbations. |

Verdict: `family-relative minimum`

Reason: this is the strongest honest form of the current safe package. It should be treated as exact family-relative minimality, not as a finished abstract theorem.

### Three-Axiom Compression

Compressed form:

- `exact accepted-record preservation`
- `rank-one descended active image`
- `geometric locking`

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| The live text does not yet state or prove that the separate band-lock and co-centering theorems collapse into one primitive `geometric locking` axiom. | `Main/Mathematica/Reports/CosmologyInterfaceResearch_Report.json` certifies that this compression is equivalent to the five-piece strong-safe package only inside the current exact audited family. | Because the compression currently relies on family-internal relations, it should not yet be exported as the theorem-facing interface. |

Verdict: `family-relative minimum`

Reason: useful for interface search and report compression, but not yet a stable theorem-facing minimal package.

### Candidate `I2`

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| The boundary-facing pieces remain as above. The completion additions are now split honestly: `split-controlled completion lift` is a bounded packaging theorem on explicit split data, while `derived Gaussian completion contract` remains assumption-backed. | `Main/Mathematica/Reports/CosmologyBoundaryInterfaceCandidates.md` certifies that `I2` is the smallest mock-tested completion-aware interface and that both the boundary and completion theorems follow on the satisfying completion-aware mocks. | The completion-aware result still lives at contract level, and the two extra completion ingredients are not yet promoted to a source-internal theorem package. |

Verdict: `family-relative minimum`

Reason: `I2` is the right current working completion-aware candidate, but it is not yet stable enough for theorem promotion.

## Completion Decomposition Refinement

The exact completion decomposition lane separates the current completion surrogate into a split-core piece and a Gaussian augmentation piece:

| case | exact WL classification | interpretation |
| --- | --- | --- |
| `I2_split` | `strong-safe` | the split-controlled completion core is already a meaningful exact finite-dimensional completion certificate distinct from Gaussian augmentation |
| `I2_gauss` | `not-a-standalone-class-lane` | the Gaussian layer contributes derived structure, but it is not an independent ambiguity-classification lane or the theorem-facing structural core |
| `I2` | `strong-safe` | full current completion-aware contract lane inside the audited exact family |

Implications:

- there is a meaningful split-core completion candidate distinct from Gaussian augmentation inside the current exact audited family;
- Gaussian augmentation is **not** the class-changing ingredient for the current `strong-safe` verdict inside that family;
- this does **not** upgrade the text-level status of either completion addition into manuscript-ready theorem promotion, because the split note remains a bounded packaging theorem on explicit split data and the Gaussian completion layer remains assumption-backed.

This is why `I2` stays only a family-relative working candidate even though `I2_split` is now a useful internal decomposition result.

## Legacy Negative Control

| theorem-backed text | exact WL certificate | imported analytic assumptions |
| --- | --- | --- |
| There is no text-level theorem claiming that a generic boundary or generic completion lift should be safe. | The old generic split-block / exploratory completion lanes remain `visible-ambiguity` and are preserved as exact negative controls. | They remain essential regression tests: if they stop being unsafe without a principled reason, the lane has probably been over-constrained. |

## Final Decision

- Treat `I0` as the current working boundary candidate in the present mock-tested family.
- Treat `I2` as the current working completion-aware candidate in the present mock-tested family.
- Keep the five-piece strong-safe package explicit and frozen in all technical decision documents.
- Do not collapse band-lock and co-centering into a single theorem-facing axiom yet.
- Keep the generic unsafe lane in CI as a permanent negative control.
