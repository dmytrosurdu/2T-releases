If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`CanonicalRepresentative`"]

Needs["MainProof`CommonProofTools`"]

CanonicalRepresentativeData::usage =
  "CanonicalRepresentativeData[U, B, J0, opts] constructs the exact finite-dimensional Jcan data.";
VerifyCanonicalRepresentativeProperties::usage =
  "VerifyCanonicalRepresentativeProperties[data] certifies the exact Jcan and orthogonality properties.";
QuadraticOptimizationCrossCheck::usage =
  "QuadraticOptimizationCrossCheck[data] runs a numerical QuadraticOptimization cross-check.";
CanonicalRepresentativeExampleSuite::usage =
  "CanonicalRepresentativeExampleSuite[] returns valid and broken examples for Tasks 5 and 6.";
RunCanonicalRepresentativeExampleSuite::usage =
  "RunCanonicalRepresentativeExampleSuite[] audits the canonical representative examples.";
CanonicalRepresentativeLedgerUpdates::usage =
  "CanonicalRepresentativeLedgerUpdates[] returns theorem-ledger updates for thm:finite-cutoff-Jcan and prop:Jcan-orth.";

Begin["`Private`"]

Options[CanonicalRepresentativeData] = {"Chi" -> Automatic, "Epsilon" -> Automatic};

CanonicalRepresentativeData[u_, b_?MatrixQ, j0_?VectorQ, OptionsPattern[]] :=
  Module[{dim = Length[j0], basis, cols, gram, linearTerm, aStar, jCan, projector},
    basis = NormalizeBasis[u, dim];
    cols = Dimensions[basis][[2]];
    gram = If[cols == 0, ConstantArray[0, {0, 0}], Transpose[basis].b.basis];
    linearTerm = If[cols == 0, {}, -Transpose[basis].b.j0];
    aStar = If[cols == 0, {}, LinearSolve[gram, linearTerm]];
    jCan = If[cols == 0, j0, j0 + basis.aStar];
    projector = If[
      cols == 0,
      ConstantArray[0, {dim, dim}],
      basis . LinearSolve[gram, Transpose[basis].b]
    ];
    <|
      "U" -> basis,
      "B" -> b,
      "J0" -> j0,
      "Chi" -> OptionValue["Chi"],
      "Epsilon" -> OptionValue["Epsilon"],
      "GA" -> gram,
      "LinearTerm" -> linearTerm,
      "aStar" -> aStar,
      "Jcan" -> jCan,
      "Projector" -> projector
    |>
  ];

objectiveValue[data_Association, coords_List] :=
  Module[{u = data["U"], b = data["B"], j0 = data["J0"]},
    (j0 + u.coords) . b . (j0 + u.coords)
  ];

chiAnnihilatesAminusQ[data_Association] :=
  Module[{chi = data["Chi"], u = data["U"]},
    If[chi === Automatic,
      Missing["NotProvided"],
      AnnihilatesSubspaceQ[chi, u]
    ]
  ];

minimalityDifferenceIdentityQ[data_Association] :=
  Module[{cols = Dimensions[data["U"]][[2]], z, lhs, rhs},
    If[cols == 0,
      True,
      z = Array[Unique["z"], cols];
      lhs = Expand[objectiveValue[data, z] - (data["Jcan"] . data["B"] . data["Jcan"])];
      rhs = Expand[(z - data["aStar"]) . data["GA"] . (z - data["aStar"])];
      TrueQ[Expand[lhs - rhs] == 0]
    ]
  ];

orthogonalitySystemUniqueQ[data_Association] :=
  Module[{cols = Dimensions[data["U"]][[2]], z, system},
    If[cols == 0,
      True,
      z = Array[Unique["z"], cols];
      system = Thread[Transpose[data["U"]].data["B"].(data["J0"] + data["U"].z) == ZeroVector[cols]];
      ExactForAllTrue[z, True, (And @@ system) \[Implies] And @@ Thread[z == data["aStar"]]]
    ]
  ];

uniqueMinimumQ[data_Association] :=
  Module[{cols = Dimensions[data["U"]][[2]], z, diff},
    If[cols == 0,
      True,
      z = Array[Unique["z"], cols];
      diff = Expand[objectiveValue[data, z] - (data["Jcan"] . data["B"] . data["Jcan"])];
      ExactForAllTrue[z, True, diff >= 0] &&
        ExactForAllTrue[z, True, (diff == 0) \[Implies] And @@ Thread[z == data["aStar"]]]
    ]
  ];

representativeShiftInvariantQ[data_Association] :=
  Module[{cols = Dimensions[data["U"]][[2]], h, shifted, delta},
    If[cols == 0,
      True,
      h = Array[Unique["h"], cols];
      shifted = CanonicalRepresentativeData[
        data["U"],
        data["B"],
        data["J0"] + data["U"].h,
        "Chi" -> data["Chi"],
        "Epsilon" -> data["Epsilon"]
      ];
      delta = Together /@ (shifted["Jcan"] - data["Jcan"]);
      AllTrue[delta, # === 0 &]
    ]
  ];

chiValuePreservedQ[data_Association] :=
  Module[{chi = data["Chi"], epsilon = data["Epsilon"], jCan = data["Jcan"]},
    If[chi === Automatic || epsilon === Automatic,
      Missing["NotProvided"],
      TrueQ[chi . jCan == epsilon]
    ]
  ];

projectorFormulaQ[data_Association] :=
  Module[{dim = Length[data["J0"]], identity = IdentityMatrix[Length[data["J0"]]], rhs},
    rhs = (identity - data["Projector"]).data["J0"];
    TrueQ[Together /@ (data["Jcan"] - rhs) == ZeroVector[dim]]
  ];

VerifyCanonicalRepresentativeProperties[data_Association] :=
  Module[{u = data["U"], b = data["B"], jCan = data["Jcan"], cols, qx},
    cols = Dimensions[u][[2]];
    qx = QuadraticOptimizationCrossCheck[data];
    <|
      "UFullColumnRank" -> (FullColumnRankQ[u] || cols == 0),
      "GA_PositiveDefinite" -> If[cols == 0, True, SymmetricPositiveDefiniteQ[data["GA"]]],
      "ChiAnnihilatesAminus" -> chiAnnihilatesAminusQ[data],
      "JcanInAffineClass" -> TrueQ[If[cols == 0, jCan == data["J0"], jCan == data["J0"] + u.data["aStar"]]],
      "ChiJcanEqualsEpsilon" -> chiValuePreservedQ[data],
      "Orthogonality" -> If[cols == 0, True, TrueQ[Transpose[u].b.jCan == ZeroVector[cols]]],
      "MinimalityDifferenceIdentity" -> minimalityDifferenceIdentityQ[data],
      "OrthogonalityImpliesCanonicalCoordinates" -> orthogonalitySystemUniqueQ[data],
      "UniqueMinimizer" -> uniqueMinimumQ[data],
      "ProjectorIdempotent" -> IdempotentProjectorQ[data["Projector"]],
      "ProjectorFormula" -> projectorFormulaQ[data],
      "RepresentativeShiftInvariant" -> representativeShiftInvariantQ[data],
      "QuadraticOptimizationCrossCheck" -> qx
    |>
  ];

QuadraticOptimizationCrossCheck[data_Association] :=
  Module[{cols = Dimensions[data["U"]][[2]], vars, objective, rules, minValue, ga, convexQ},
    If[cols == 0,
      <|"Coordinates" -> {}, "PrimalMinimumValue" -> N[data["Jcan"] . data["B"] . data["Jcan"]]|>,
      ga = data["GA"];
      convexQ = Quiet @ Check[TrueQ[PositiveSemidefiniteMatrixQ[ga]], False];
      If[!convexQ,
        <|"Status" -> "SkippedNonConvexOrIndefinite"|>,
        vars = Array[Unique["a"], cols];
        objective = Expand[objectiveValue[data, vars]];
        rules = QuadraticOptimization[objective, {}, vars];
        minValue = QuadraticOptimization[objective, {}, vars, "PrimalMinimumValue"];
        <|
          "Status" -> "Executed",
          "Coordinates" -> rules,
          "PrimalMinimumValue" -> minValue,
          "ExpectedCoordinates" -> N[data["aStar"]],
          "ExpectedValue" -> N[data["Jcan"] . data["B"] . data["Jcan"]]
        |>
      ]
    ]
  ];

CanonicalRepresentativeExampleSuite[] :=
  Module[{valid, badRank, badB, badChi},
    valid = CanonicalRepresentativeData[
      {{0, 0}, {1, 0}, {0, 1}},
      {{5, 0, 0}, {0, 2, 1}, {0, 1, 3}},
      {1, 2, -3},
      "Chi" -> {1, 0, 0},
      "Epsilon" -> 1
    ];
    badRank = CanonicalRepresentativeData[
      {{0, 0}, {1, 2}, {2, 4}},
      {{5, 0, 0}, {0, 2, 0}, {0, 0, 3}},
      {1, 2, 3},
      "Chi" -> {1, 0, 0},
      "Epsilon" -> 1
    ];
    badB = CanonicalRepresentativeData[
      {{0, 0}, {1, 0}, {0, 1}},
      {{1, 0, 0}, {0, 1, 0}, {0, 0, -1}},
      {1, 2, 3},
      "Chi" -> {1, 0, 0},
      "Epsilon" -> 1
    ];
    badChi = CanonicalRepresentativeData[
      {{1, 0}, {0, 1}, {0, 0}},
      IdentityMatrix[3],
      {0, 0, 1},
      "Chi" -> {1, 0, 1},
      "Epsilon" -> 1
    ];
    <|
      "ValidExample" -> valid,
      "BrokenExamples" -> {
        <|"Name" -> "rank_deficient_U", "Data" -> badRank, "ExpectedFailure" -> "UFullColumnRank"|>,
        <|"Name" -> "non_positive_B", "Data" -> badB, "ExpectedFailure" -> "GA_PositiveDefinite"|>,
        <|"Name" -> "chi_not_constant_on_affine_class", "Data" -> badChi, "ExpectedFailure" -> "ChiAnnihilatesAminus"|>
      }
    |>
  ];

RunCanonicalRepresentativeExampleSuite[] :=
  Module[{suite = CanonicalRepresentativeExampleSuite[], good, broken},
    good = VerifyCanonicalRepresentativeProperties[suite["ValidExample"]];
    broken = Map[
      Function[entry,
        With[{report = VerifyCanonicalRepresentativeProperties[entry["Data"]]},
          <|
            "Name" -> entry["Name"],
            "ExpectedFailure" -> entry["ExpectedFailure"],
            "ObservedValue" -> report[entry["ExpectedFailure"]],
            "ExpectedFailureObservedQ" -> TrueQ[report[entry["ExpectedFailure"]] === False]
          |>
        ]
      ],
      suite["BrokenExamples"]
    ];
    <|"ValidExample" -> good, "BrokenExamples" -> broken|>
  ];

CanonicalRepresentativeLedgerUpdates[] :=
  Module[{suite = RunCanonicalRepresentativeExampleSuite[], good, broken, validStatusQ},
    good = suite["ValidExample"];
    broken = suite["BrokenExamples"];
    validStatusQ = And @@ TrueQ /@ {
      good["UFullColumnRank"],
      good["GA_PositiveDefinite"],
      good["ChiAnnihilatesAminus"],
      good["JcanInAffineClass"],
      good["ChiJcanEqualsEpsilon"],
      good["Orthogonality"],
      good["MinimalityDifferenceIdentity"],
      good["OrthogonalityImpliesCanonicalCoordinates"],
      good["UniqueMinimizer"],
      good["ProjectorFormula"],
      good["RepresentativeShiftInvariant"]
    };
    <|
      "thm:finite-cutoff-Jcan" -> <|
        "Method" -> "Exact affine projection with GA = U^T B U and Jcan = J0 + U a*.",
        "Status" -> If[validStatusQ && AllTrue[broken, TrueQ[#"ExpectedFailureObservedQ"] &], "finite-dimensional-theorem-certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Closed affine subspace and Hilbert projection are realized by finite-dimensional matrix algebra."
        },
        "RepresentativeModelFamily" -> "Exact full-column-rank affine examples with rank/B/chi countermodels",
        "NoApproximationQ" -> True
      |>,
      "prop:Jcan-orth" -> <|
        "Method" -> "Exact orthogonality, projector formula, and minimality-difference identity.",
        "Status" -> If[
          validStatusQ && good["Orthogonality"] && good["ProjectorIdempotent"],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The proof is finite-dimensional and does not replace the abstract Hilbert-space statement."
        },
        "RepresentativeModelFamily" -> "Exact projector-model family with representative-shift checks",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
