If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`Calibration`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "Calibration.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`CanonicalRepresentative`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CanonicalRepresentative.wl"}]];
];

BeginPackage["MainProof`CalibrationComparison`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`Calibration`"]
Needs["MainProof`CanonicalRepresentative`"]

CalibrationComparisonData::usage =
  "CalibrationComparisonData[U, J0, B1, B2, opts] constructs exact data for comparing two admissible calibrations.";
VerifyCalibrationComparison::usage =
  "VerifyCalibrationComparison[data] proves the exact projector-difference formula, equality criterion, and quotient-visible invariants.";
CalibrationComparisonExampleSuite::usage =
  "CalibrationComparisonExampleSuite[] returns exact equal/non-equal admissible-calibration examples.";
RunCalibrationComparisonExampleSuite::usage =
  "RunCalibrationComparisonExampleSuite[] audits the calibration-comparison examples.";
CalibrationComparisonLedgerUpdates::usage =
  "CalibrationComparisonLedgerUpdates[] returns theorem-ledger updates for calibration dependence of Jcan.";

Begin["`Private`"]

Options[CalibrationComparisonData] = {
  "Chi" -> Automatic,
  "Epsilon" -> Automatic,
  "VisibilityMap" -> Automatic,
  "Label" -> Automatic
};

zeroMatrix[rows_Integer?NonNegative, cols_Integer?NonNegative] := ConstantArray[0, {rows, cols}];

canonicalData[data_Association, key_String] :=
  MainProof`CanonicalRepresentative`CanonicalRepresentativeData[
    data["U"],
    data[key],
    data["J0"],
    "Chi" -> data["Chi"],
    "Epsilon" -> data["Epsilon"]
  ];

CalibrationComparisonData[u_, j0_?VectorQ, b1_?MatrixQ, b2_?MatrixQ, OptionsPattern[]] :=
  Module[{dim = Length[j0], basis},
    basis = NormalizeBasis[u, dim];
    <|
      "U" -> basis,
      "J0" -> j0,
      "B1" -> b1,
      "B2" -> b2,
      "Chi" -> OptionValue["Chi"],
      "Epsilon" -> OptionValue["Epsilon"],
      "VisibilityMap" -> OptionValue["VisibilityMap"],
      "Label" -> OptionValue["Label"]
    |>
  ];

visibilityInvariantQ[visibility_, j1_, j2_] :=
  If[visibility === Automatic,
    Missing["NotProvided"],
    ExactVectorEqualQ[visibility . j1, visibility . j2]
  ];

visibilityKillsAminusQ[visibility_, basis_] :=
  Module[{rows},
    If[visibility === Automatic,
      Missing["NotProvided"],
      rows = Dimensions[visibility][[1]];
      ExactMatrixEqualQ[visibility . basis, zeroMatrix[rows, Dimensions[basis][[2]]]]
    ]
  ];

VerifyCalibrationComparison[data_Association] :=
  Module[
    {
      comparison1, comparison2, j1, j2, p1, p2, deltaJ, deltaCoords, dim,
      chi, visibility, sameJcanQ, projectorZeroQ
    },
    comparison1 = canonicalData[data, "B1"];
    comparison2 = canonicalData[data, "B2"];
    {j1, j2, p1, p2, dim, chi, visibility} =
      {
        comparison1["Jcan"],
        comparison2["Jcan"],
        comparison1["Projector"],
        comparison2["Projector"],
        Length[data["J0"]],
        data["Chi"],
        data["VisibilityMap"]
      };
    deltaJ = j1 - j2;
    deltaCoords = If[Dimensions[data["U"]][[2]] == 0, {}, comparison1["aStar"] - comparison2["aStar"]];
    sameJcanQ = ExactVectorEqualQ[j1, j2];
    projectorZeroQ = ExactVectorEqualQ[(p2 - p1).data["J0"], ZeroVector[dim]];
    <|
      "Calibration1" -> comparison1,
      "Calibration2" -> comparison2,
      "Jcan1" -> j1,
      "Jcan2" -> j2,
      "Projector1" -> p1,
      "Projector2" -> p2,
      "DeltaJ" -> deltaJ,
      "DeltaCoordinates" -> deltaCoords,
      "DifferenceFormula" -> ExactVectorEqualQ[deltaJ, (p2 - p1).data["J0"]],
      "DifferenceInAminus" -> If[
        Dimensions[data["U"]][[2]] == 0,
        ExactVectorEqualQ[deltaJ, ZeroVector[dim]],
        ExactVectorEqualQ[deltaJ, data["U"].deltaCoords]
      ],
      "SameJcanQ" -> sameJcanQ,
      "EqualityCriterion_ProjectorDifferenceKillsJ0" -> TrueQ[sameJcanQ === projectorZeroQ],
      "QuotientScalarInvariant" -> If[
        chi === Automatic,
        Missing["NotProvided"],
        TrueQ[
          AnnihilatesSubspaceQ[chi, data["U"]] &&
          chi . j1 == chi . j2 &&
          If[data["Epsilon"] === Automatic, True, chi . j1 == data["Epsilon"] == chi . j2]
        ]
      ],
      "VisibilityMapKillsAminus" -> visibilityKillsAminusQ[visibility, data["U"]],
      "VisibleOutputInvariant" -> visibilityInvariantQ[visibility, j1, j2],
      "VisibilityCriterionImpliesInvariant" -> If[
        visibility === Automatic,
        Missing["NotProvided"],
        TrueQ[visibilityKillsAminusQ[visibility, data["U"]] \[Implies] visibilityInvariantQ[visibility, j1, j2]]
      ],
      "NonInvarianceWitness" -> Not[sameJcanQ]
    |>
  ];

CalibrationComparisonExampleSuite[] :=
  Module[
    {
      chi, jSharp, kernelBasis, beta, q1, q2, q3, aminus, j0, visibility,
      b1, b2, b3
    },
    chi = {1, 0, 0};
    jSharp = {1, 0, 0};
    kernelBasis = {{0, 0}, {1, 0}, {0, 1}};
    beta = 3;
    q1 = IdentityMatrix[2];
    q2 = {{2, 1}, {1, 1}};
    q3 = {{3, 0}, {0, 5}};
    aminus = {{0}, {1}, {0}};
    j0 = {1, 1, 1};
    visibility = {{1, 0, 0}, {0, 0, 1}};
    b1 = MainProof`Calibration`CalibrationMatrix[
      MainProof`Calibration`CalibrationData[
        chi,
        jSharp,
        beta,
        q1,
        "KernelBasis" -> kernelBasis,
        "Aminus" -> aminus
      ]
    ];
    b2 = MainProof`Calibration`CalibrationMatrix[
      MainProof`Calibration`CalibrationData[
        chi,
        jSharp,
        beta,
        q2,
        "KernelBasis" -> kernelBasis,
        "Aminus" -> aminus
      ]
    ];
    b3 = MainProof`Calibration`CalibrationMatrix[
      MainProof`Calibration`CalibrationData[
        chi,
        jSharp,
        beta,
        q3,
        "KernelBasis" -> kernelBasis,
        "Aminus" -> aminus
      ]
    ];
    <|
      "NonInvariantExample" -> CalibrationComparisonData[
        aminus,
        j0,
        b1,
        b2,
        "Chi" -> chi,
        "Epsilon" -> 1,
        "VisibilityMap" -> visibility,
        "Label" -> "calibration_noninvariance"
      ],
      "EqualExample" -> CalibrationComparisonData[
        aminus,
        j0,
        b1,
        b3,
        "Chi" -> chi,
        "Epsilon" -> 1,
        "VisibilityMap" -> visibility,
        "Label" -> "calibration_equal_projector_action"
      ]
    |>
  ];

RunCalibrationComparisonExampleSuite[] :=
  Module[{suite = CalibrationComparisonExampleSuite[]},
    <|
      "NonInvariantExample" -> VerifyCalibrationComparison[suite["NonInvariantExample"]],
      "EqualExample" -> VerifyCalibrationComparison[suite["EqualExample"]]
    |>
  ];

CalibrationComparisonLedgerUpdates[] :=
  Module[{suite = RunCalibrationComparisonExampleSuite[], nonInvariant, equalCase, statusQ},
    nonInvariant = suite["NonInvariantExample"];
    equalCase = suite["EqualExample"];
    statusQ =
      And @@ TrueQ /@ {
        nonInvariant["DifferenceFormula"],
        nonInvariant["DifferenceInAminus"],
        nonInvariant["EqualityCriterion_ProjectorDifferenceKillsJ0"],
        nonInvariant["QuotientScalarInvariant"],
        nonInvariant["VisibilityCriterionImpliesInvariant"],
        nonInvariant["NonInvarianceWitness"],
        equalCase["DifferenceFormula"],
        equalCase["DifferenceInAminus"],
        equalCase["EqualityCriterion_ProjectorDifferenceKillsJ0"],
        equalCase["SameJcanQ"]
      };
    <|
      "task:calibration-comparison" -> <|
        "Method" ->
          "Exact projector comparison Jcan_B = (I - P_A^B) J0, with DeltaJ in Aminus and visibility-map invariance when the visible map kills Aminus.",
        "Status" -> If[statusQ, "finite-dimensional-theorem-certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Only fixed-cutoff exact matrix calibrations are compared.",
          "Physical invisibility is represented by explicit visible maps that kill Aminus, not by AQFT/HLS semantics."
        },
        "RepresentativeModelFamily" ->
          "Exact admissible-calibration pairs with one non-invariant and one projector-equal comparison family",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
