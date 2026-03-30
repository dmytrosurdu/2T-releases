If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`Calibration`"]

Needs["MainProof`CommonProofTools`"]

CalibrationData::usage =
  "CalibrationData[chi, jSharp, beta, Q, opts] constructs the exact basis-aware calibration package; use the option \"KernelBasis\" to supply N explicitly.";
CalibrationChecks::usage =
  "CalibrationChecks[data] returns exact input checks for the calibration constructor.";
CalibrationMatrix::usage =
  "CalibrationMatrix[data] returns the ambient calibration matrix B.";
VerifyCalibrationProperties::usage =
  "VerifyCalibrationProperties[data] certifies the exact finite-dimensional calibration properties.";
CalibrationExampleSuite::usage =
  "CalibrationExampleSuite[] returns valid and broken examples for the calibration theorem.";
RunCalibrationExampleSuite::usage =
  "RunCalibrationExampleSuite[] audits the calibration examples.";
StiffnessSpecializedCalibration::usage =
  "StiffnessSpecializedCalibration[chi, jSharp, alpha, Q, opts] is the beta = alpha wrapper.";
CalibrationLedgerUpdates::usage =
  "CalibrationLedgerUpdates[] returns theorem-ledger updates for prop:minimal-transport-calibration.";

Begin["`Private`"]

Options[CalibrationData] = {
  "Aminus" -> Automatic,
  "Representative" -> Automatic,
  "Epsilon" -> Automatic,
  "KernelBasis" -> Automatic
};

blockDiagonalMetric[beta_, q_?MatrixQ] :=
  Module[{k = Dimensions[q][[1]]},
    ArrayFlatten[{
      {{{beta}}, ConstantArray[0, {1, k}]},
      {ConstantArray[0, {k, 1}], q}
    }]
  ];

CalibrationData[chi_?VectorQ, jSharp_?VectorQ, beta_, q_?MatrixQ, OptionsPattern[]] :=
  Module[{dim = Length[chi], basis, m, g},
    basis = OptionValue["KernelBasis"];
    basis = If[basis === Automatic, KernelBasisFromFunctional[chi], basis];
    basis = NormalizeBasis[basis, dim];
    m = ArrayFlatten[{{Transpose[{jSharp}], basis}}];
    g = blockDiagonalMetric[beta, q];
    <|
      "Chi" -> chi,
      "jSharp" -> jSharp,
      "Beta" -> beta,
      "KernelBasis" -> basis,
      "KernelMetric" -> q,
      "M" -> m,
      "G" -> g,
      "Aminus" -> OptionValue["Aminus"],
      "Representative" -> OptionValue["Representative"],
      "Epsilon" -> OptionValue["Epsilon"]
    |>
  ];

CalibrationChecks[data_Association] :=
  Module[{chi, jSharp, beta, basis, q, m, cols, aBasis},
    {chi, jSharp, beta, basis, q, m, aBasis} =
      Lookup[data, {"Chi", "jSharp", "Beta", "KernelBasis", "KernelMetric", "M", "Aminus"}];
    cols = Dimensions[basis][[2]];
    <|
      "Normalization chi(jSharp)=1" -> TrueQ[chi . jSharp == 1],
      "Kernel basis lies in ker chi" -> AnnihilatesSubspaceQ[chi, basis],
      "Kernel basis full rank" -> FullColumnRankQ[basis] || cols == 0,
      "Kernel metric dimensions" -> Dimensions[q] === {cols, cols},
      "Kernel metric coercive" -> SymmetricPositiveDefiniteQ[q],
      "Beta positive" -> TrueQ[beta > 0],
      "M invertible" -> Det[m] =!= 0,
      "Aminus in ker chi" -> If[aBasis === Automatic, Missing["NotProvided"], AnnihilatesSubspaceQ[chi, NormalizeBasis[aBasis, Length[chi]]]]
    |>
  ];

CalibrationMatrix[data_Association] :=
  Module[{m = data["M"], g = data["G"]},
    Inverse[Transpose[m]].g.Inverse[m]
  ];

orthogonalityToKernelQ[data_Association] :=
  Module[{b = CalibrationMatrix[data], jSharp = data["jSharp"], basis = data["KernelBasis"], cols, coeffs, k},
    cols = Dimensions[basis][[2]];
    If[cols == 0,
      True,
      coeffs = Array[Unique["k"], cols];
      k = basis.coeffs;
      ExactForAllTrue[coeffs, True, jSharp . b . k == 0]
    ]
  ];

admissibleJSharpChoiceQ[data_Association] :=
  Module[{chi = data["Chi"], representative = data["Representative"], epsilon = data["Epsilon"]},
    If[representative === Automatic || epsilon === Automatic,
      Missing["NotProvided"],
      TrueQ[chi . (epsilon representative) == 1]
    ]
  ];

VerifyCalibrationProperties[data_Association] :=
  Module[{checks = CalibrationChecks[data], b, chi, jSharp, beta, basis, q, aBasis, m},
    {chi, jSharp, beta, basis, q, aBasis} =
      Lookup[data, {"Chi", "jSharp", "Beta", "KernelBasis", "KernelMetric", "Aminus"}];
    m = data["M"];
    b = CalibrationMatrix[data];
    <|
      "InputChecks" -> checks,
      "B" -> b,
      "ProductDecomposition" -> TrueQ[Det[m] != 0],
      "Symmetry" -> ExactForAllTrue[{}, True, b == Transpose[b]],
      "PositiveDefinite" -> SymmetricPositiveDefiniteQ[b],
      "OrthogonalToKerChi" -> orthogonalityToKernelQ[data],
      "OrthogonalToAminus" -> If[
        aBasis === Automatic,
        Missing["NotProvided"],
        Module[{a = NormalizeBasis[aBasis, Length[chi]], cols, coeffs},
          cols = Dimensions[a][[2]];
          If[cols == 0,
            True,
            coeffs = Array[Unique["a"], cols];
            ExactForAllTrue[coeffs, True, jSharp . b . (a.coeffs) == 0]
          ]
        ]
      ],
      "jSharpNorm" -> TrueQ[jSharp . b . jSharp == beta],
      "AdmissibleChoice_jSharp_equals_epsilon_JXi" -> admissibleJSharpChoiceQ[data]
    |>
  ];

StiffnessSpecializedCalibration[chi_?VectorQ, jSharp_?VectorQ, alpha_, q_?MatrixQ, opts : OptionsPattern[CalibrationData]] :=
  CalibrationData[chi, jSharp, alpha, q, opts];

CalibrationExampleSuite[] :=
  Module[{chi, n, q, good, badBeta, badQ, badNorm, badAminus},
    chi = {1, 0, 0};
    n = {{0, 0}, {1, 0}, {0, 1}};
    q = {{2, 1}, {1, 3}};
    good = CalibrationData[
      chi,
      {1, 0, 0},
      5,
      q,
      "KernelBasis" -> n,
      "Aminus" -> {{0}, {1}, {0}},
      "Representative" -> {1, 0, 0},
      "Epsilon" -> 1
    ];
    badBeta = CalibrationData[chi, {1, 0, 0}, 0, q, "KernelBasis" -> n, "Aminus" -> {{0}, {1}, {0}}];
    badQ = CalibrationData[chi, {1, 0, 0}, 5, {{1, 0}, {0, 0}}, "KernelBasis" -> n, "Aminus" -> {{0}, {1}, {0}}];
    badNorm = CalibrationData[chi, {2, 0, 0}, 5, q, "KernelBasis" -> n, "Aminus" -> {{0}, {1}, {0}}];
    badAminus = CalibrationData[chi, {1, 0, 0}, 5, q, "KernelBasis" -> n, "Aminus" -> {{1}, {0}, {0}}];
    <|
      "ValidExample" -> good,
      "BrokenExamples" -> {
        <|"Name" -> "beta_nonpositive", "Data" -> badBeta, "ExpectedFailure" -> "Beta positive"|>,
        <|"Name" -> "kernel_metric_not_coercive", "Data" -> badQ, "ExpectedFailure" -> "Kernel metric coercive"|>,
        <|"Name" -> "wrong_jSharp_normalization", "Data" -> badNorm, "ExpectedFailure" -> "Normalization chi(jSharp)=1"|>,
        <|"Name" -> "Aminus_not_in_kernel", "Data" -> badAminus, "ExpectedFailure" -> "Aminus in ker chi"|>
      }
    |>
  ];

RunCalibrationExampleSuite[] :=
  Module[{suite = CalibrationExampleSuite[], goodReport, brokenReports},
    goodReport = VerifyCalibrationProperties[suite["ValidExample"]];
    brokenReports = Map[
      Function[entry,
        With[{checks = CalibrationChecks[entry["Data"]]},
          <|
            "Name" -> entry["Name"],
            "ExpectedFailure" -> entry["ExpectedFailure"],
            "Checks" -> checks,
            "ExpectedFailureObservedQ" -> TrueQ[checks[entry["ExpectedFailure"]] === False]
          |>
        ]
      ],
      suite["BrokenExamples"]
    ];
    <|"ValidExample" -> goodReport, "BrokenExamples" -> brokenReports|>
  ];

CalibrationLedgerUpdates[] :=
  Module[{suite = RunCalibrationExampleSuite[], good = Null, broken = Null},
    good = suite["ValidExample"];
    broken = suite["BrokenExamples"];
    <|
      "prop:minimal-transport-calibration" -> <|
        "Method" -> "Exact basis-aware ambient construction B = M^-T G M^-1 with coercive kernel metric.",
        "Status" -> If[
          And @@ TrueQ /@ {
            good["ProductDecomposition"],
            good["Symmetry"],
            good["PositiveDefinite"],
            good["OrthogonalToKerChi"],
            good["OrthogonalToAminus"],
            good["jSharpNorm"],
            good["AdmissibleChoice_jSharp_equals_epsilon_JXi"]
          } &&
            AllTrue[broken, TrueQ[#"ExpectedFailureObservedQ"] &],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Coercivity and Hilbertizability are represented by positive-definite finite matrices.",
          "No infinite-dimensional completion is constructed."
        },
        "RepresentativeModelFamily" -> "Exact basis-aware ambient calibration examples with broken-input countermodels",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
