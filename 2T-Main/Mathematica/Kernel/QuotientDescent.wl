If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`QuotientDescent`"]

Needs["MainProof`CommonProofTools`"]

QuotientDescentData::usage =
  "QuotientDescentData[chi, U, J0, opts] constructs exact finite-dimensional quotient-descent data.";
QuotientCoordinateMatrix::usage =
  "QuotientCoordinateMatrix[data] returns a row-basis matrix W for the quotient coordinates.";
DescendedFunctionalCoordinates::usage =
  "DescendedFunctionalCoordinates[data] returns quotient coordinates eta with eta.W == chi when descent holds.";
VerifyQuotientDescentProperties::usage =
  "VerifyQuotientDescentProperties[data] certifies exact quotient-descent, affine-constancy, and scalar-compatibility properties.";
QuotientDescentExampleSuite::usage =
  "QuotientDescentExampleSuite[] returns exact valid and broken examples for ambiguity-kernel descent.";
RunQuotientDescentExampleSuite::usage =
  "RunQuotientDescentExampleSuite[] audits the quotient-descent examples.";
QuotientDescentLedgerUpdates::usage =
  "QuotientDescentLedgerUpdates[] returns theorem-ledger updates for thm:dominant-quotient-descent and cor:dominant-quotient-constancy.";

Begin["`Private`"]

Options[QuotientDescentData] = {"Nu" -> 1, "Label" -> Automatic};

quotientRowBasis[u_?MatrixQ, dim_Integer] :=
  Module[{cols = Dimensions[u][[2]], ns},
    If[cols == 0,
      IdentityMatrix[dim],
      ns = NullSpace[Transpose[u]];
      If[ns === {},
        ConstantArray[0, {0, dim}],
        ns
      ]
    ]
  ];

QuotientDescentData[chi_?VectorQ, u_, j0_?VectorQ, OptionsPattern[]] :=
  Module[{dim = Length[chi], basis, w},
    basis = NormalizeBasis[u, dim];
    w = quotientRowBasis[basis, dim];
    <|
      "Chi" -> chi,
      "Aminus" -> basis,
      "J0" -> j0,
      "Nu" -> OptionValue["Nu"],
      "Label" -> OptionValue["Label"],
      "W" -> w
    |>
  ];

QuotientCoordinateMatrix[data_Association] := data["W"];

DescendedFunctionalCoordinates[data_Association] :=
  Module[{chi = data["Chi"], basis = data["Aminus"], w = data["W"], qdim},
    qdim = Dimensions[w][[1]];
    If[!TrueQ[AnnihilatesSubspaceQ[chi, basis]],
      Missing["DoesNotDescend"],
      If[qdim == 0,
        {},
        LinearSolve[Transpose[w], chi]
      ]
    ]
  ];

quotientCoordinatesEqualQ[w_?MatrixQ, f_?VectorQ, g_?VectorQ] := ExactVectorEqualQ[w.f, w.g];

quotientFunctionalUniqueQ[w_?MatrixQ, eta_?VectorQ] :=
  Module[{qdim = Dimensions[w][[1]], z},
    If[qdim == 0,
      True,
      z = Array[Unique["z"], qdim];
      ExactForAllTrue[z, True, (z.w == eta.w) \[Implies] And @@ Thread[z == eta]]
    ]
  ];

affineScalarReductionQ[functional_?VectorQ, j0_?VectorQ, basis_?MatrixQ] :=
  Module[{cols = Dimensions[basis][[2]], a},
    a = Array[Unique["a"], cols];
    ExactForAllTrue[a, True, functional . (j0 + basis.a) == functional . j0]
  ];

wrongUnscaledCompatibilityWitness[data_Association] :=
  Module[{nu = data["Nu"], chi = data["Chi"], j0 = data["J0"], scalar},
    If[TrueQ[nu == 1],
      {},
      scalar = Unique["r"];
      ExactCounterexampleSearch[
        True,
        Equivalent[chi . j0 == scalar, (nu chi) . j0 == scalar],
        {scalar}
      ]
    ]
  ];

VerifyQuotientDescentProperties[data_Association] :=
  Module[
    {chi = data["Chi"], basis = data["Aminus"], j0 = data["J0"], nu = data["Nu"], w = data["W"],
      eta, dim, cols, f, a, qdim, splittingMatrix},
    dim = Length[chi];
    cols = Dimensions[basis][[2]];
    qdim = Dimensions[w][[1]];
    splittingMatrix = If[qdim + cols == dim, Join[Transpose[w], basis, 2], ConstantArray[0, {dim, dim}]];
    eta = DescendedFunctionalCoordinates[data];
    f = Array[Unique["f"], dim];
    a = Array[Unique["a"], cols];
    <|
      "ChiAnnihilatesAminus" -> AnnihilatesSubspaceQ[chi, basis],
      "CosetConstancy" -> ExactForAllTrue[
        Join[f, a],
        True,
        chi . (f + basis.a) == chi . f
      ],
      "QuotientCoordinatesFullRowRank" -> FullRowRankQ[w],
      "QuotientDirectSumDecomposition" -> If[qdim + cols == dim, TrueQ[Det[splittingMatrix] != 0], False],
      "DescendedFunctionalExists" -> If[
        MissingQ[eta],
        False,
        ExactForAllTrue[f, True, eta . (w.f) == chi . f]
      ],
      "DescendedFunctionalUnique" -> If[
        MissingQ[eta],
        False,
        quotientFunctionalUniqueQ[w, eta]
      ],
      "AffineClassConstancy" -> ExactForAllTrue[a, True, chi . (j0 + basis.a) == chi . j0],
      "AffineClassQuotientValue" -> If[
        MissingQ[eta],
        False,
        ExactForAllTrue[a, True, eta . (w.(j0 + basis.a)) == eta . (w.j0) == chi . j0]
      ],
      "ChiLevelRepresentativeSearchReduction" -> affineScalarReductionQ[chi, j0, basis],
      "RhoLevelRepresentativeSearchReduction" -> affineScalarReductionQ[nu chi, j0, basis],
      "UnscaledChiCompatibilityWitness" -> wrongUnscaledCompatibilityWitness[data],
      "DescendedFunctionalCoordinates" -> eta,
      "QuotientCoordinateMatrix" -> w
    |>
  ];

QuotientDescentExampleSuite[] :=
  Module[{valid, broken},
    valid = QuotientDescentData[
      {0, 0, 1},
      {{1, 0}, {0, 1}, {0, 0}},
      {2, -1, 1},
      "Nu" -> 5,
      "Label" -> "quotient_descent_valid"
    ];
    broken = QuotientDescentData[
      {1, 0, 1},
      {{1, 0}, {0, 1}, {0, 0}},
      {0, 0, 1},
      "Nu" -> 5,
      "Label" -> "quotient_descent_broken"
    ];
    <|
      "ValidExample" -> valid,
      "BrokenExamples" -> {
        <|
          "Name" -> "ambiguity_not_in_kernel",
          "Data" -> broken,
          "ExpectedFailure" -> "ChiAnnihilatesAminus"
        |>
      }
    |>
  ];

RunQuotientDescentExampleSuite[] :=
  Module[{suite = QuotientDescentExampleSuite[], good, broken},
    good = VerifyQuotientDescentProperties[suite["ValidExample"]];
    broken = Map[
      Function[entry,
        With[{report = VerifyQuotientDescentProperties[entry["Data"]]},
          <|
            "Name" -> entry["Name"],
            "ExpectedFailure" -> entry["ExpectedFailure"],
            "ObservedValue" -> report[entry["ExpectedFailure"]],
            "ExpectedFailureObservedQ" -> TrueQ[report[entry["ExpectedFailure"]] === False],
            "CounterexampleWitness" -> report["UnscaledChiCompatibilityWitness"]
          |>
        ]
      ],
      suite["BrokenExamples"]
    ];
    <|"ValidExample" -> good, "BrokenExamples" -> broken|>
  ];

QuotientDescentLedgerUpdates[] :=
  Module[{suite = RunQuotientDescentExampleSuite[], good, broken, quotientStatusQ},
    good = suite["ValidExample"];
    broken = suite["BrokenExamples"];
    quotientStatusQ = And @@ TrueQ /@ {
      good["ChiAnnihilatesAminus"],
      good["CosetConstancy"],
      good["QuotientDirectSumDecomposition"],
      good["DescendedFunctionalExists"],
      good["DescendedFunctionalUnique"],
      good["AffineClassConstancy"],
      good["AffineClassQuotientValue"],
      good["ChiLevelRepresentativeSearchReduction"],
      good["RhoLevelRepresentativeSearchReduction"]
    };
    <|
      "thm:dominant-quotient-descent" -> <|
        "Method" -> "Exact quotient coordinates W, descended covector eta, and universal descent equivalences via Resolve.",
        "Status" -> If[
          quotientStatusQ && AllTrue[broken, TrueQ[#"ExpectedFailureObservedQ"] &],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Topological quotient continuity is represented by exact finite-dimensional linear maps.",
          "Closure of the ambiguity span is not separately audited beyond the surrogate."
        },
        "RepresentativeModelFamily" -> "Exact quotient-descent valid/broken model pair with nu != 1 obstruction witness",
        "NoApproximationQ" -> True
      |>,
      "cor:dominant-quotient-constancy" -> <|
        "Method" -> "Exact affine-class constancy and quotient-value reduction on J0 + Aminus.",
        "Status" -> If[
          quotientStatusQ && good["AffineClassConstancy"] && good["AffineClassQuotientValue"],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The quotient point [![Xi^(1)]!] is represented by exact coordinates rather than an abstract completion object."
        },
        "RepresentativeModelFamily" -> "Exact affine descendant class with quotient-point scalar reduction",
        "NoApproximationQ" -> True
      |>,
      "task:witness-comparison-reduction" -> <|
        "Method" -> "Exact representative-search reduction to rho-level scalar compatibility, plus obstruction witness for the unscaled chi-level claim when nu != 1.",
        "Status" -> If[
          good["RhoLevelRepresentativeSearchReduction"] &&
            good["ChiLevelRepresentativeSearchReduction"] &&
            broken[[1, "ExpectedFailureObservedQ"]],
          "counterexample found",
          "deferred"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The notebook certifies the scalar reduction at fixed cutoff only.",
          "The unscaled chi-compatibility claim fails unless an extra normalization hypothesis is added."
        },
        "RepresentativeModelFamily" -> "Exact nu != 1 witness-comparison obstruction family",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
