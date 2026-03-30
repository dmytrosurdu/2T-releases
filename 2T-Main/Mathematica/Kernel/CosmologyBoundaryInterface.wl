BeginPackage["MainProof`CosmologyBoundaryInterface`"]

CosmologyInterfaceCandidates::usage =
  "CosmologyInterfaceCandidates[] returns the nested candidate contracts for a generic cosmology-theory to 2T-Main interface.";
CandidatePropertyDescriptions::usage =
  "CandidatePropertyDescriptions[] returns short descriptions of the abstract interface properties used in the candidate search.";

Begin["`Private`"]

CandidatePropertyDescriptions[] :=
  <|
    "BoundaryMapQ" -> "A boundary map on the transported odd class is defined.",
    "TransportedDescendantClassQ" -> "A transported odd descendant class exists.",
    "AmbiguitySubspaceQ" -> "A transported ambiguity subspace is defined.",
    "DescendedActiveScalarQ" -> "A descended active scalar/orientation functional is defined on the transported class.",
    "BoundaryAmbiguityAnnihilationQ" -> "Transported ambiguity is annihilated after boundary projection.",
    "RepresentativeLineSurvivesQ" -> "The representative active line survives nontrivially after boundary projection.",
    "AcceptedRecordPreservationQ" -> "Accepted records are preserved exactly under the contract.",
    "RankOneActiveBoundaryImageQ" -> "The active boundary image is rank one.",
    "GeometricLockingQ" -> "The active channel is geometrically locked by band-lock/co-centering type data.",
    "SplitControlledLiftQ" -> "A split-controlled A|B lift exists with QND ledger control.",
    "GaussianCompletionQ" -> "A Gaussian/covariance-tangent completion realization exists.",
    "LiftedFactPreservationQ" -> "Accepted-record preservation extends to the lifted completion contract.",
    "CompletionAmbiguityAnnihilationQ" -> "Transported ambiguity remains dead on the lifted completion contract."
  |>;

CosmologyInterfaceCandidates[] :=
  <|
    "I0" -> <|
      "Name" -> "boundary_canonicalization_interface",
      "ShortName" -> "I0",
      "Purpose" -> "Minimal theory-neutral boundary interface",
      "RequiredProperties" -> {
        "BoundaryMapQ",
        "TransportedDescendantClassQ",
        "AmbiguitySubspaceQ",
        "DescendedActiveScalarQ",
        "BoundaryAmbiguityAnnihilationQ",
        "RepresentativeLineSurvivesQ"
      },
      "Comment" ->
        "This is the most abstract candidate: it asks only for the data Main directly consumes to state representative-independent nontrivial boundary action."
    |>,
    "I1" -> <|
      "Name" -> "fact_preserving_active_line_interface",
      "ShortName" -> "I1",
      "Purpose" -> "Compressed structural boundary interface",
      "RequiredProperties" -> {
        "AcceptedRecordPreservationQ",
        "DescendedActiveScalarQ",
        "BoundaryAmbiguityAnnihilationQ",
        "RepresentativeLineSurvivesQ",
        "RankOneActiveBoundaryImageQ",
        "GeometricLockingQ"
      },
      "Comment" ->
        "This keeps the same boundary conclusion but packages it in the current UOM-style structural terms: fact preservation, active-line rank one, and geometric locking."
    |>,
    "I2" -> <|
      "Name" -> "completion_aware_interface",
      "ShortName" -> "I2",
      "Purpose" -> "Completion-aware cosmology interface",
      "RequiredProperties" -> {
        "AcceptedRecordPreservationQ",
        "DescendedActiveScalarQ",
        "BoundaryAmbiguityAnnihilationQ",
        "RepresentativeLineSurvivesQ",
        "RankOneActiveBoundaryImageQ",
        "GeometricLockingQ",
        "SplitControlledLiftQ",
        "GaussianCompletionQ",
        "LiftedFactPreservationQ",
        "CompletionAmbiguityAnnihilationQ"
      },
      "Comment" ->
        "This is the smallest candidate that can reasonably support a completion-aware safety theorem, because it adds an explicit lift and a derived Gaussian completion layer."
    |>
  |>;

End[]

EndPackage[]
