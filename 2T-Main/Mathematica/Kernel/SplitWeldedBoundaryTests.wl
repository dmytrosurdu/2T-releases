If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySplitWeldedModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySplitWeldedModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryAmbiguityReduction`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryAmbiguityReduction.wl"}]];
];

BeginPackage["MainProof`SplitWeldedBoundaryTests`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`BoundaryAmbiguityReduction`"]

SplitWeldedBoundaryExampleSuite::usage =
  "SplitWeldedBoundaryExampleSuite[] returns exact strict-record, controlled-reduction, and split+welded boundary models.";
RunSplitWeldedBoundaryExampleSuite::usage =
  "RunSplitWeldedBoundaryExampleSuite[] runs the full boundary calibration-invariance sprint at finite cutoff.";
BoundaryCalibrationDecision::usage =
  "BoundaryCalibrationDecision[results] returns Decision A, B, or C together with the exact reason.";
SplitWeldedBoundaryLedgerUpdates::usage =
  "SplitWeldedBoundaryLedgerUpdates[] returns theorem-ledger updates for the boundary split+welded sprint.";

Begin["`Private`"]

theoremDimensions[] := {{2, 2}, {2, 3}, {3, 2}};

strictRecordResults[] :=
  Association@Table[
    ToString[dims, InputForm] -> MainProof`BoundaryAmbiguityReduction`StrictBoundaryRecordAudit[dims[[1]], dims[[2]]],
    {dims, theoremDimensions[]}
  ];

controlledReductionResults[] :=
  Association@Table[
    ToString[dims, InputForm] -> MainProof`BoundaryAmbiguityReduction`ControlledBoundaryReductionAudit[dims[[1]], dims[[2]]],
    {dims, theoremDimensions[]}
  ];

SplitWeldedBoundaryExampleSuite[] :=
  <|
    "StrictRecordTheorems" -> strictRecordResults[],
    "ControlledReductionTheorems" -> controlledReductionResults[],
    "Models" -> MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[]
  |>;

RunSplitWeldedBoundaryExampleSuite[] :=
  Module[{suite = SplitWeldedBoundaryExampleSuite[], models},
    models = suite["Models"];
    <|
      "StrictRecordTheorems" -> suite["StrictRecordTheorems"],
      "ControlledReductionTheorems" -> suite["ControlledReductionTheorems"],
      "SafeFamily" -> Join[
        <|"ModelChecks" -> MainProof`BoundarySplitWeldedModels`VerifyBoundarySplitWeldedModel[models["SafeOffDiagonalFamily"]]|>,
        MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[
          MainProof`BoundaryAmbiguityReduction`BoundaryControlledDerivationData[models["SafeOffDiagonalFamily"]]
        ]
      ],
      "UnsafeFamily" -> Join[
        <|"ModelChecks" -> MainProof`BoundarySplitWeldedModels`VerifyBoundarySplitWeldedModel[models["UnsafeControlledVisibleFamily"]]|>,
        MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[
          MainProof`BoundaryAmbiguityReduction`BoundaryControlledDerivationData[models["UnsafeControlledVisibleFamily"]]
        ]
      ],
      "BorderlineFamily" -> Join[
        <|"ModelChecks" -> MainProof`BoundarySplitWeldedModels`VerifyBoundarySplitWeldedModel[models["BorderlineNullIdealFamily"]]|>,
        MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[
          MainProof`BoundaryAmbiguityReduction`BoundaryControlledDerivationData[models["BorderlineNullIdealFamily"]]
        ]
      ],
      "FalseOverreachModel" -> Join[
        <|"ModelChecks" -> MainProof`BoundarySplitWeldedModels`VerifyBoundarySplitWeldedModel[models["UnsafeControlledVisibleFamily"]]|>,
        MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[
          MainProof`BoundaryAmbiguityReduction`BoundaryControlledDerivationData[models["UnsafeControlledVisibleFamily"]]
        ]
      ]
    |>
  ];

BoundaryCalibrationDecision[results_Association] :=
  Module[
    {strictResults, safe, unsafe, borderline},
    strictResults = Values[results["StrictRecordTheorems"]];
    safe = results["SafeFamily"];
    unsafe = results["UnsafeFamily"];
    borderline = results["BorderlineFamily"];
    Which[
      And @@ TrueQ /@ {
        borderline["ModNullClassDefinedQ"],
        borderline["AmbiguityInvisibleModNullQ"],
        borderline["NontrivialControlledDerivationQ"],
        unsafe["AmbiguityVisibleAtOperatorLevelQ"]
      },
      <|
        "Decision" -> "Decision A",
        "Sentence" ->
          "Boundary class-defined derivation is recovered on the controlled split+welded sector under the hypothesis that the diagonal controlled ambiguity component acts trivially modulo the chosen boundary null ideal; visible controlled countermodels remain outside that hypothesis.",
        "Reason" ->
          "The strict record sector is automatically invariant but trivial, the borderline model is nontrivial and mod-null invisible, and the unsafe model shows the criterion is genuinely needed."
      |>,
      And @@ TrueQ /@ Join[
        Lookup[strictResults, "InducedDerivationZeroOnStrictRecordSector"],
        {unsafe["AmbiguityVisibleAtOperatorLevelQ"]}
      ],
      <|
        "Decision" -> "Decision C",
        "Sentence" ->
          "Boundary restriction only yields trivial record-level invariance; a preferred selector is still needed for nontrivial dynamics on the controlled sector.",
        "Reason" ->
          "Strict record invariance holds, but no nontrivial controlled-sector class-defined derivation survives the chosen quotient."
      |>,
      True,
      <|
        "Decision" -> "Decision B",
        "Sentence" ->
          "Boundary restriction restores only strict record-level invariance, and the controlled-sector evidence is inconclusive in the current exact family.",
        "Reason" ->
          "The theorem lanes did not isolate a stable nontrivial controlled-sector invariant family."
      |>
    ]
  ];

SplitWeldedBoundaryLedgerUpdates[] :=
  Module[{results = RunSplitWeldedBoundaryExampleSuite[], decision, strictAllQ, controlledAllQ, safe, unsafe, borderline},
    decision = BoundaryCalibrationDecision[results];
    strictAllQ = AllTrue[Values[results["StrictRecordTheorems"]], TrueQ[#"ReadoutAnnihilatesCommutator"] && TrueQ[#"InducedDerivationZeroOnStrictRecordSector"] &];
    controlledAllQ = AllTrue[
      Values[results["ControlledReductionTheorems"]],
      TrueQ[#"OffDiagonalLedgerPartKilled"] && TrueQ[#"ControlledReductionFormula"] &
    ];
    safe = results["SafeFamily"];
    unsafe = results["UnsafeFamily"];
    borderline = results["BorderlineFamily"];
    <|
      "task:strict-boundary-record-invariance" -> <|
        "Method" ->
          "Exact symbolic proof that BoundaryReadout([X,O]) = 0 for all strict-record observables O in D_A ⊗ 1_B.",
        "Status" -> If[strictAllQ, "finite-dimensional-theorem-certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The proof is finite-dimensional and exact for the tested dimensions only.",
          "The induced strict-record derivation is collapsed by the readout map itself."
        },
        "RepresentativeModelFamily" -> "Generic symbolic strict-record sectors on dimensions (2,2), (2,3), and (3,2)",
        "NoApproximationQ" -> True
      |>,
      "task:controlled-boundary-reduction" -> <|
        "Method" ->
          "Exact symbolic reduction under controlled projection: off-diagonal ledger ambiguity is killed and only diagonal controlled B-block commutators survive.",
        "Status" -> If[controlledAllQ, "finite-dimensional-theorem-certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The reduction is proved on finite matrix algebras with rank-one ledger projectors."
        },
        "RepresentativeModelFamily" -> "Generic symbolic controlled sectors on dimensions (2,2), (2,3), and (3,2)",
        "NoApproximationQ" -> True
      |>,
      "task:boundary-class-defined-derivation-strong" -> <|
        "Method" ->
          "Exact controlled-sector criterion with literal operator-level ambiguity triviality.",
        "Status" -> If[
          TrueQ[safe["StrongClassDefinedQ"]] &&
            !TrueQ[unsafe["StrongClassDefinedQ"]] &&
            !TrueQ[borderline["StrongClassDefinedQ"]],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Strong class-definedness is tested only on explicit split+welded toy families."
        },
        "RepresentativeModelFamily" -> "Safe off-diagonal, unsafe visible, and borderline null-ideal families",
        "NoApproximationQ" -> True
      |>,
      "task:boundary-class-defined-derivation-mod-null" -> <|
        "Method" ->
          "Exact controlled-sector criterion modulo the chosen boundary null ideal.",
        "Status" -> If[
          TrueQ[safe["ModNullClassDefinedQ"]] &&
            !TrueQ[unsafe["ModNullClassDefinedQ"]] &&
            TrueQ[borderline["ModNullClassDefinedQ"]],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The boundary null ideal is model data, not yet derived from an abstract AQFT/HLS construction."
        },
        "RepresentativeModelFamily" -> "Safe off-diagonal, unsafe visible, and borderline null-ideal families",
        "NoApproximationQ" -> True
      |>,
      "task:boundary-expectation-vs-operator-invisibility" -> <|
        "Method" ->
          "Side-by-side exact comparison of operator-level and boundary-classical expectation-level invisibility.",
        "Status" -> If[
          TrueQ[unsafe["ExpectationLevelInvisibleQ"]] &&
            TrueQ[unsafe["AmbiguityVisibleAtOperatorLevelQ"]],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Expectation-level invisibility is tested only against the chosen diagonal boundary-classical states."
        },
        "RepresentativeModelFamily" -> "Unsafe 2x2 controlled-visible family",
        "NoApproximationQ" -> True
      |>,
      "task:boundary-nontriviality-test" -> <|
        "Method" ->
          "Exact search for a controlled-sector family with nonzero induced derivation and ambiguity invisibility modulo the boundary null ideal.",
        "Status" -> If[
          TrueQ[borderline["ModNullClassDefinedQ"]] &&
            TrueQ[borderline["NontrivialControlledDerivationQ"]] &&
            TrueQ[borderline["AmbiguityInvisibleModNullQ"]],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The nontriviality test is established on explicit split+welded toy families rather than a full transported ambiguity class."
        },
        "RepresentativeModelFamily" -> "Borderline 2x3 split+welded null-ideal family",
        "NoApproximationQ" -> True
      |>,
      "task:boundary-calibration-decision" -> <|
        "Method" ->
          "Decision extracted from exact strict-record theorems plus safe/unsafe/borderline split+welded model families.",
        "Status" -> If[
          strictAllQ &&
            controlledAllQ &&
            MemberQ[{"Decision A", "Decision B", "Decision C"}, decision["Decision"]],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Decision A is conditional on the diagonal controlled ambiguity criterion and is not yet derived from the full Main/UOM assumptions."
        },
        "RepresentativeModelFamily" -> "Strict-record theorem family plus split+welded safe/unsafe/borderline families",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
