If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedAblation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedAblation.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`SKCompletionSectorReconstruction`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "SKCompletionSectorReconstruction.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSplitControlledLift`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSplitControlledLift.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSKGaussianCompletion`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSKGaussianCompletion.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMCompletionAmbiguityAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMCompletionAmbiguityAudit.wl"}]];
];

BeginPackage["MainProof`UOMCompletionDecompositionAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMWeldedAblation`"]
Needs["MainProof`SKCompletionSectorReconstruction`"]
Needs["MainProof`UOMSplitControlledLift`"]
Needs["MainProof`UOMSKGaussianCompletion`"]
Needs["MainProof`UOMCompletionAmbiguityAudit`"]

AuditUOMCompletionDecomposition::usage =
  "AuditUOMCompletionDecomposition[] freezes the five-piece boundary package and decomposes the completion lane into split-core, Gaussian augmentation, coupled interaction, and retained negative control.";
UOMCompletionDecompositionLedgerRows::usage =
  "UOMCompletionDecompositionLedgerRows[] returns report-local ledger rows for the completion decomposition audit.";

Begin["`Private`"]

matrixCommutator[a_?MatrixQ, b_?MatrixQ] := Expand[a . b - b . a];

zeroMatrixQ[m_?MatrixQ] :=
  MainProof`CommonProofTools`ExactMatrixEqualQ[
    m,
    ConstantArray[0, Dimensions[m]]
  ];

allCertifiedQ[claims_Association] := And @@ Lookup[Values[claims], "Certified"];

statusFromQ[q_] := If[TrueQ[q], "exact finite-dimensional certificate", "counterexample found"];

classificationBucket[class_String] :=
  If[class === "visible-again", "visible-ambiguity", class];

splitCoreWitnessObservable[] :=
  KroneckerProduct[{{0, 0}, {0, 1}}, {{0, 1}, {1, 0}}];

completionLedgerRows[audit_Association] :=
  Module[
    {
      boundaryFreeze,
      legacyLane,
      splitLane,
      gaussianLane,
      interactionLane,
      coupledLane
    },
    boundaryFreeze = audit["BoundaryFreeze"];
    legacyLane = audit["LegacyCompletionNegativeControl"];
    splitLane = audit["SplitCoreCandidate"];
    gaussianLane = audit["GaussianAugmentation"];
    interactionLane = audit["Interaction"];
    coupledLane = audit["CoupledCompletionContract"];
    {
      <|
        "TheoremLabel" -> "task:completion-decomposition-boundary-freeze",
        "Assumptions" -> "Exact welded one-at-a-time ablation family with the five-piece boundary package retained as the baseline.",
        "Method" -> "Exact reuse of the welded ablation audit to freeze the boundary-side strong-safe package and preserve the mod-null-safe and visible-ambiguity ablations.",
        "Status" -> statusFromQ[boundaryFreeze["FrozenQ"]],
        "Classification" -> "strong-safe",
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "Boundary minimality remains family-relative to the exact audited welded family."
        },
        "RepresentativeModelFamily" -> "baseline_strong_safe welded boundary ablation family",
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Reports/MinimalUOMBoundarySafeHypotheses.md",
          "Main/Mathematica/Reports/InterfaceRobustnessAudit.md"
        },
        "Acceptance" -> boundaryFreeze["Reason"]
      |>,
      <|
        "TheoremLabel" -> "task:completion-decomposition-legacy-negative-control",
        "Assumptions" -> "Exploratory appended completion-sector lift beyond the preserved welded boundary image.",
        "Method" -> "Exact commutator audit on the preexisting exploratory completion reconstruction lane.",
        "Status" -> legacyLane["Status"],
        "Classification" -> legacyLane["Classification"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "This remains a regression lane rather than a theorem-facing completion model."
        },
        "RepresentativeModelFamily" -> legacyLane["RepresentativeModelFamily"],
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Kernel/SKCompletionSectorReconstruction.wl",
          "Main/Mathematica/Reports/UOMBoundaryExpansion.md"
        },
        "Acceptance" -> legacyLane["Acceptance"]
      |>,
      <|
        "TheoremLabel" -> "task:completion-decomposition-split-core",
        "Assumptions" -> "Intrinsic response contract plus split-controlled A|B lift with exact accepted-record invariance on the split-faithful space.",
        "Method" -> "Exact split-core witness audit using the split-controlled lift alone, without importing Gaussian quadrature data into the classification step.",
        "Status" -> splitLane["Status"],
        "Classification" -> splitLane["Classification"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "This is an exact finite-dimensional completion-core certificate, not yet the full microscopic completion theorem."
        },
        "RepresentativeModelFamily" -> splitLane["RepresentativeModelFamily"],
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Kernel/UOMSplitControlledLift.wl",
          "Main/Mathematica/Reports/CompletionAssumptionDischarge.md"
        },
        "Acceptance" -> splitLane["Acceptance"]
      |>,
      <|
        "TheoremLabel" -> "task:completion-decomposition-gaussian-augmentation",
        "Assumptions" -> "Split-faithful Gaussian completion contract built from the intrinsic response scalar and derived quadrature data.",
        "Method" -> "Exact structural audit of the Gaussian augmentation layer, tracking symplectic/Hamiltonian data and derived covariance/observable structure.",
        "Status" -> gaussianLane["Status"],
        "Classification" -> gaussianLane["Classification"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The Gaussian realization remains assumption-backed in the live UOM note stack.",
          "This row is a structure audit rather than a standalone ambiguity-classification lane."
        },
        "RepresentativeModelFamily" -> gaussianLane["RepresentativeModelFamily"],
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Kernel/UOMSKGaussianCompletion.wl",
          "Main/Mathematica/Reports/CompletionAssumptionDischarge.md"
        },
        "Acceptance" -> gaussianLane["Acceptance"]
      |>,
      <|
        "TheoremLabel" -> "task:completion-decomposition-interaction",
        "Assumptions" -> "Current split-faithful completion contract with Gaussian augmentation attached to the split core.",
        "Method" -> "Exact comparison between split-core and coupled split-plus-Gaussian completion actions.",
        "Status" -> interactionLane["Status"],
        "Classification" -> interactionLane["Classification"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The no-class-change conclusion is exact only in the current finite-dimensional audited family."
        },
        "RepresentativeModelFamily" -> interactionLane["RepresentativeModelFamily"],
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Kernel/UOMCompletionAmbiguityAudit.wl",
          "Main/Mathematica/Kernel/UOMSplitControlledLift.wl"
        },
        "Acceptance" -> interactionLane["Acceptance"]
      |>,
      <|
        "TheoremLabel" -> "task:completion-decomposition-coupled-contract",
        "Assumptions" -> "Current split-faithful completion contract built from intrinsic response, split control, derived Gaussian completion, and lifted fact preservation.",
        "Method" -> "Exact completion ambiguity audit on the coupled split-plus-Gaussian contract.",
        "Status" -> coupledLane["Status"],
        "Classification" -> coupledLane["Classification"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The coupled completion result remains contract-level and does not close the full microscopic completion theorem."
        },
        "RepresentativeModelFamily" -> coupledLane["RepresentativeModelFamily"],
        "NoApproximationQ" -> True,
        "Source" -> {
          "Main/Mathematica/Kernel/UOMCompletionAmbiguityAudit.wl",
          "Main/Mathematica/Reports/UOMBoundaryExpansion.md"
        },
        "Acceptance" -> coupledLane["Acceptance"]
      |>
    }
  ];

AuditUOMCompletionDecomposition[] :=
  Module[
    {
      boundaryAudit,
      splitAudit,
      gaussianAudit,
      completionAudit,
      coupledDecision,
      legacyAudit,
      splitModel,
      splitWitness,
      splitRepresentativeAction,
      splitAmbiguityActions,
      splitQNDQ,
      splitBoundaryCompatQ,
      splitRecordInvariantQ,
      splitRepresentativeNonzeroQ,
      splitAmbiguityDeadQ,
      splitClassification,
      gaussianCertifiedQ,
      interactionWitnessMatchQ,
      interactionRepresentativeMatchQ,
      interactionAmbiguityMatchQ,
      interactionNoClassChangeQ,
      splitCoreMeaningfulQ,
      boundaryCases
    },
    boundaryAudit = MainProof`UOMWeldedAblation`AuditUOMWeldedAblation[];
    splitAudit = MainProof`UOMSplitControlledLift`AuditUOMSplitControlledLift[];
    gaussianAudit = MainProof`UOMSKGaussianCompletion`AuditUOMSKGaussianCompletion[];
    completionAudit = MainProof`UOMCompletionAmbiguityAudit`AuditUOMCompletionAmbiguity[];
    coupledDecision = MainProof`UOMCompletionAmbiguityAudit`SplitFaithfulCompletionDecision[];
    legacyAudit = MainProof`SKCompletionSectorReconstruction`AuditSKCompletionSectorReconstruction[];
    splitModel = splitAudit["Model"];
    splitWitness = splitCoreWitnessObservable[];
    splitRepresentativeAction =
      matrixCommutator[splitModel["RepresentativeLift"], splitWitness];
    splitAmbiguityActions =
      matrixCommutator[#, splitWitness] & /@ splitModel["AmbiguityLifts"];
    splitQNDQ =
      splitAudit["Claims", "Controlled split unitary is QND on the inherited ledger projectors", "Certified"];
    splitBoundaryCompatQ =
      splitAudit["Claims", "Split-faithful lift recovers the intrinsic welded response on the boundary block", "Certified"];
    splitRecordInvariantQ =
      splitAudit["Claims", "Accepted record projection is invariant under transported ambiguity on the split-faithful lift", "Certified"];
    splitRepresentativeNonzeroQ = !zeroMatrixQ[splitRepresentativeAction];
    splitAmbiguityDeadQ = AllTrue[splitAmbiguityActions, zeroMatrixQ];
    splitClassification =
      If[
        splitQNDQ && splitBoundaryCompatQ && splitRecordInvariantQ &&
          splitRepresentativeNonzeroQ && splitAmbiguityDeadQ,
        "strong-safe",
        "visible-ambiguity"
      ];
    gaussianCertifiedQ = allCertifiedQ[gaussianAudit["Claims"]];
    interactionWitnessMatchQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        splitWitness,
        completionAudit["CompletionWitnessObservable"]
      ];
    interactionRepresentativeMatchQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        splitRepresentativeAction,
        completionAudit["RepresentativeAction"]
      ];
    interactionAmbiguityMatchQ =
      AllTrue[
        splitAmbiguityActions,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          #,
          completionAudit["AmbiguityAction"]
        ] &
      ];
    interactionNoClassChangeQ =
      splitClassification === completionAudit["Classification"] &&
        interactionWitnessMatchQ &&
        interactionRepresentativeMatchQ &&
        interactionAmbiguityMatchQ;
    splitCoreMeaningfulQ =
      splitClassification === "strong-safe" &&
        splitRepresentativeNonzeroQ &&
        interactionNoClassChangeQ;
    boundaryCases =
      Association @ KeyValueMap[
        #1 -> <|
          "Classification" -> #2["Classification"],
          "ActiveHypotheses" -> #2["ActiveHypotheses"]
        |>&,
        boundaryAudit["Cases"]
      ];
    <|
      "BoundaryFreeze" -> <|
        "FrozenQ" ->
          TrueQ[boundaryAudit["MinimalStrongSafeHypothesisSet", "FoundQ"]] &&
            boundaryAudit["Cases", "BaselineStrongSafe", "Classification"] === "strong-safe",
        "MinimalStrongSafeHypothesisSet" ->
          boundaryAudit["MinimalStrongSafeHypothesisSet", "Hypotheses"],
        "AblationClassifications" -> boundaryCases,
        "Reason" -> boundaryAudit["MinimalStrongSafeHypothesisSet", "Reason"]
      |>,
      "LegacyCompletionNegativeControl" -> <|
        "Status" -> statusFromQ[allCertifiedQ[legacyAudit["Claims"]]],
        "Classification" -> classificationBucket[legacyAudit["Classification"]],
        "ExactClassification" -> legacyAudit["Classification"],
        "RepresentativeModelFamily" -> legacyAudit["Model", "Name"],
        "Acceptance" ->
          "The retained exploratory appended completion lift remains the exact unsafe regression lane: ambiguity becomes visible again off the preserved welded boundary image."
      |>,
      "SplitCoreCandidate" -> <|
        "Status" -> statusFromQ[splitClassification === "strong-safe"],
        "Classification" -> splitClassification,
        "MeaningfulDistinctCandidateQ" -> splitCoreMeaningfulQ,
        "WitnessObservable" -> splitWitness,
        "RepresentativeAction" -> splitRepresentativeAction,
        "AmbiguityActions" -> splitAmbiguityActions,
        "Claims" -> <|
          "QND" -> splitQNDQ,
          "BoundaryCompatibleQ" -> splitBoundaryCompatQ,
          "AcceptedRecordInvariantQ" -> splitRecordInvariantQ,
          "RepresentativeNontrivialQ" -> splitRepresentativeNonzeroQ,
          "AmbiguityDeadQ" -> splitAmbiguityDeadQ
        |>,
        "RepresentativeModelFamily" -> splitModel["Name"],
        "Acceptance" ->
          "The split-controlled lift already supports a nontrivial completion witness while keeping all transported ambiguity actions zero, so it is a meaningful strong-safe completion core distinct from Gaussian augmentation."
      |>,
      "GaussianAugmentation" -> <|
        "Status" -> statusFromQ[gaussianCertifiedQ],
        "Classification" -> "not-a-standalone-class-lane",
        "StandaloneLiftQ" -> False,
        "Claims" -> gaussianAudit["Claims"],
        "RepresentativeModelFamily" ->
          gaussianAudit["Contract", "Name"],
        "Acceptance" ->
          "The Gaussian layer contributes derived covariance, symplectic/Hamiltonian, and quadrature-observable structure, but it is not an independent ambiguity-classification lane in the present exact audit."
      |>,
      "Interaction" -> <|
        "Status" -> statusFromQ[interactionNoClassChangeQ],
        "Classification" -> If[interactionNoClassChangeQ, completionAudit["Classification"], "changed"],
        "WitnessMatchesSplitCoreQ" -> interactionWitnessMatchQ,
        "RepresentativeActionMatchesSplitCoreQ" -> interactionRepresentativeMatchQ,
        "AmbiguityActionsMatchSplitCoreQ" -> interactionAmbiguityMatchQ,
        "ClassChange" -> If[interactionNoClassChangeQ, "none", "changed"],
        "RepresentativeModelFamily" -> completionAudit["Contract", "Name"],
        "Acceptance" ->
          "In the current exact family, Gaussian augmentation does not change the split-core ambiguity class: the coupled completion action reuses the same witness and the same zero ambiguity action."
      |>,
      "CoupledCompletionContract" -> <|
        "Status" -> statusFromQ[allCertifiedQ[completionAudit["Claims"]]],
        "Classification" -> completionAudit["Classification"],
        "Decision" -> coupledDecision["Decision"],
        "ResidualBoundary" -> coupledDecision["ResidualBoundary"],
        "RepresentativeModelFamily" -> completionAudit["Contract", "Name"],
        "Acceptance" ->
          "The current split-plus-Gaussian contract remains strong-safe as an exact finite-dimensional completion-aware lane."
      |>,
      "Summary" -> <|
        "SplitCoreDistinctCandidateMeaningfulQ" -> splitCoreMeaningfulQ,
        "GaussianAugmentationChangesClassQ" -> !interactionNoClassChangeQ,
        "RecommendedCompletionCore" ->
          If[
            splitCoreMeaningfulQ,
            "split-controlled core distinct from Gaussian augmentation",
            "coupled split-plus-Gaussian contract only"
          ]
      |>
    |>
  ];

UOMCompletionDecompositionLedgerRows[] :=
  completionLedgerRows[AuditUOMCompletionDecomposition[]];

End[]

EndPackage[]
