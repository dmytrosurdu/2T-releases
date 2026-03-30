# Cosmology Boundary Interface Candidates

This report searches for the smallest honest `cosmology theory -> 2T-Main` interface, keeping the LS minimal-interface pattern in view.

## Candidate Results

### I0 - boundary_canonicalization_interface

- Purpose: Minimal theory-neutral boundary interface
- Required properties: `BoundaryMapQ`, `TransportedDescendantClassQ`, `AmbiguitySubspaceQ`, `DescendedActiveScalarQ`, `BoundaryAmbiguityAnnihilationQ`, `RepresentativeLineSurvivesQ`
- Satisfying realizations: UOM, SyntheticBoundary, SyntheticCompletion
- Non-UOM satisfying realizations: SyntheticBoundary, SyntheticCompletion
- Boundary theorem follows on all satisfying mocks: `True`
- Completion theorem follows on all satisfying mocks: `False`
- Comment: This is the most abstract candidate: it asks only for the data Main directly consumes to state representative-independent nontrivial boundary action.

### I1 - fact_preserving_active_line_interface

- Purpose: Compressed structural boundary interface
- Required properties: `AcceptedRecordPreservationQ`, `DescendedActiveScalarQ`, `BoundaryAmbiguityAnnihilationQ`, `RepresentativeLineSurvivesQ`, `RankOneActiveBoundaryImageQ`, `GeometricLockingQ`
- Satisfying realizations: UOM, SyntheticBoundary, SyntheticCompletion
- Non-UOM satisfying realizations: SyntheticBoundary, SyntheticCompletion
- Boundary theorem follows on all satisfying mocks: `True`
- Completion theorem follows on all satisfying mocks: `False`
- Comment: This keeps the same boundary conclusion but packages it in the current UOM-style structural terms: fact preservation, active-line rank one, and geometric locking.

### I2 - completion_aware_interface

- Purpose: Completion-aware cosmology interface
- Required properties: `AcceptedRecordPreservationQ`, `DescendedActiveScalarQ`, `BoundaryAmbiguityAnnihilationQ`, `RepresentativeLineSurvivesQ`, `RankOneActiveBoundaryImageQ`, `GeometricLockingQ`, `SplitControlledLiftQ`, `GaussianCompletionQ`, `LiftedFactPreservationQ`, `CompletionAmbiguityAnnihilationQ`
- Satisfying realizations: UOM, SyntheticCompletion
- Non-UOM satisfying realizations: SyntheticCompletion
- Boundary theorem follows on all satisfying mocks: `True`
- Completion theorem follows on all satisfying mocks: `True`
- Comment: This is the smallest candidate that can reasonably support a completion-aware safety theorem, because it adds an explicit lift and a derived Gaussian completion layer.

## Minimal Winners

- Minimal boundary candidate: `I0`
- Minimal completion-aware candidate: `I2`

Interpretation: `I0` is the smallest theory-neutral boundary interface in the mock-tested family, while `I2` is the smallest candidate that still supports completion-aware safety.