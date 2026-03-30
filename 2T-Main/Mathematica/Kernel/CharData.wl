If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`CharData`"]

Needs["MainProof`CommonProofTools`"]

TickData::usage =
  "TickData[k, assoc] builds the canonical per-tick weak-interface association.";
ValidateCharData::usage =
  "ValidateCharData[data] returns a named exact validation report for the Main-facing surrogate data.";
ValidCharDataQ::usage =
  "ValidCharDataQ[data] returns True when all finite-dimensional surrogate checks pass.";
CharDataFailureReasons::usage =
  "CharDataFailureReasons[] maps failed checks to short human-readable reasons.";
CharDataExampleSuite::usage =
  "CharDataExampleSuite[] returns valid and invalid synthetic examples for task 2.";
RunCharDataExampleSuite::usage =
  "RunCharDataExampleSuite[] validates the synthetic examples and records whether they pass or fail for the expected reason.";

Begin["`Private`"]

canonicalEminus[espace_] := Which[
  AssociationQ[espace] && KeyExistsQ[espace, "Dimension"],
    Join[<|"Parity" -> "Odd"|>, espace],
  IntegerQ[espace],
    <|"Dimension" -> espace, "Parity" -> "Odd"|>,
  True,
    <|"Dimension" -> Missing["Dimension"], "Parity" -> Missing["Parity"]|>
];

TickData[k_Integer, assoc_Association] :=
  Module[{espace, dim, j0, basis, xiClass, chi, epsilon, bilinear, ochar, branchRecord},
    espace = canonicalEminus @ Lookup[assoc, "Eminus", Missing["Eminus"]];
    dim = espace["Dimension"];
    j0 = Lookup[assoc, "J0", Missing["J0"]];
    basis = NormalizeBasis[Lookup[assoc, "Aminus", {}], dim];
    xiClass = Lookup[
      assoc,
      "XiClass",
      <|"Representative" -> j0, "Basis" -> basis|>
    ];
    chi = Lookup[assoc, "Chi", Missing["Chi"]];
    epsilon = Lookup[assoc, "Epsilon", Missing["Epsilon"]];
    bilinear = Lookup[assoc, "B", Missing["B"]];
    ochar = Lookup[assoc, "Ochar", Missing["NotProvided"]];
    branchRecord = Lookup[
      assoc,
      "BranchSignRecord",
      <|"Tick" -> k, "Epsilon" -> epsilon|>
    ];
    <|
      "Tick" -> k,
      "Eminus" -> espace,
      "Aminus" -> basis,
      "XiClass" -> <|
        "Representative" -> Lookup[xiClass, "Representative", j0],
        "Basis" -> NormalizeBasis[Lookup[xiClass, "Basis", basis], dim]
      |>,
      "J0" -> j0,
      "Chi" -> chi,
      "Epsilon" -> epsilon,
      "B" -> bilinear,
      "Ochar" -> ochar,
      "BranchSignRecord" -> branchRecord
    |>
  ];

charDataChecks[data_Association] :=
  Module[{espace, dim, basis, xiClass, j0, chi, epsilon, bilinear, branchRecord, zeroVec},
    espace = data["Eminus"];
    dim = espace["Dimension"];
    basis = data["Aminus"];
    xiClass = data["XiClass"];
    j0 = data["J0"];
    chi = data["Chi"];
    epsilon = data["Epsilon"];
    bilinear = data["B"];
    branchRecord = data["BranchSignRecord"];
    zeroVec = If[IntegerQ[dim] && dim >= 0, ZeroVector[dim], {}];
    <|
      "Odd space" ->
        IntegerQ[dim] &&
        dim > 0 &&
        Lookup[espace, "Parity", Missing["Parity"]] === "Odd",
      "Closed ambiguity subspace" ->
        MatrixQ[basis] &&
        IntegerQ[dim] &&
        Dimensions[basis][[1]] === dim,
      "Affine class bookkeeping" ->
        AssociationQ[xiClass] &&
        Lookup[xiClass, "Representative", Missing["Representative"]] === j0 &&
        Lookup[xiClass, "Basis", Missing["Basis"]] === basis,
      "Nonzero chi" ->
        VectorQ[chi] &&
        IntegerQ[dim] &&
        Length[chi] === dim &&
        chi =!= zeroVec,
      "Chi annihilates Aminus" ->
        VectorQ[chi] &&
        MatrixQ[basis] &&
        AnnihilatesSubspaceQ[chi, basis],
      "Class constancy of chi" ->
        VectorQ[chi] &&
        VectorQ[j0] &&
        MatrixQ[basis] &&
        AffineClassConstantQ[chi, j0, basis, epsilon],
      "Positive symmetric B" ->
        MatrixQ[bilinear] &&
        IntegerQ[dim] &&
        Dimensions[bilinear] === {dim, dim} &&
        SymmetricPositiveDefiniteQ[bilinear],
      "Branch-sign bookkeeping" ->
        MemberQ[{-1, 1}, epsilon] &&
        AssociationQ[branchRecord] &&
        Lookup[branchRecord, "Tick", Missing["Tick"]] === data["Tick"] &&
        Lookup[branchRecord, "Epsilon", Missing["Epsilon"]] === epsilon &&
        TrueQ[chi . j0 == epsilon]
    |>
  ];

CharDataFailureReasons[] := <|
  "Odd space" -> "Eminus must be a positive-dimensional odd-tagged finite-dimensional space.",
  "Closed ambiguity subspace" -> "Aminus must be a basis matrix with row count equal to dim(Eminus).",
  "Affine class bookkeeping" -> "XiClass must reuse the declared J0 and Aminus basis.",
  "Nonzero chi" -> "Chi must be a nonzero covector on Eminus.",
  "Chi annihilates Aminus" -> "Chi must vanish on every ambiguity direction.",
  "Class constancy of chi" -> "Chi must be constant with value epsilon on J0 + Aminus.",
  "Positive symmetric B" -> "B must be symmetric and positive definite.",
  "Branch-sign bookkeeping" -> "Epsilon must be +-1 and consistent with the recorded branch sign."
|>;

ValidateCharData[data_Association] :=
  Module[{checks = charDataChecks[data], failed},
    failed = Keys @ Select[checks, Not @* TrueQ];
    <|
      "Valid" -> failed === {},
      "Checks" -> checks,
      "FailedChecks" -> failed,
      "Reasons" -> KeyTake[CharDataFailureReasons[], failed]
    |>
  ];

ValidCharDataQ[data_Association] := ValidateCharData[data]["Valid"];

CharDataExampleSuite[] :=
  Module[{valid1, valid2, valid3, invalid1, invalid2, invalid3},
    valid1 = TickData[1, <|
      "Eminus" -> 3,
      "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
      "J0" -> {0, 0, 1},
      "Chi" -> {0, 0, 1},
      "Epsilon" -> 1,
      "B" -> IdentityMatrix[3],
      "Ochar" -> <|"Name" -> "ToyCharAlgebra1"|>
    |>];
    valid2 = TickData[2, <|
      "Eminus" -> <|"Dimension" -> 4, "Parity" -> "Odd", "Name" -> "OddSector2"|>,
      "Aminus" -> {{1}, {1}, {0}, {0}},
      "J0" -> {1, 0, 0, 0},
      "Chi" -> {1, -1, 1, 0},
      "Epsilon" -> 1,
      "B" -> {{5, 1, 0, 0}, {1, 4, 0, 0}, {0, 0, 3, 0}, {0, 0, 0, 2}},
      "BranchSignRecord" -> <|"Tick" -> 2, "Epsilon" -> 1|>
    |>];
    valid3 = TickData[3, <|
      "Eminus" -> 2,
      "Aminus" -> {},
      "J0" -> {1, 0},
      "Chi" -> {1, 0},
      "Epsilon" -> 1,
      "B" -> {{2, 0}, {0, 3}}
    |>];
    invalid1 = TickData[11, <|
      "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Even"|>,
      "Aminus" -> {{1}, {0}, {0}},
      "J0" -> {0, 1, 1},
      "Chi" -> {0, 1, 0},
      "Epsilon" -> 1,
      "B" -> IdentityMatrix[3]
    |>];
    invalid2 = TickData[12, <|
      "Eminus" -> 3,
      "Aminus" -> {{1}, {0}, {0}},
      "J0" -> {0, 1, 0},
      "Chi" -> {1, 1, 0},
      "Epsilon" -> 1,
      "B" -> IdentityMatrix[3]
    |>];
    invalid3 = TickData[13, <|
      "Eminus" -> 2,
      "Aminus" -> {},
      "J0" -> {1, 0},
      "Chi" -> {1, 0},
      "Epsilon" -> 1,
      "B" -> {{0, 0}, {0, 1}}
    |>];
    <|
      "ValidExamples" -> {
        <|"Name" -> "valid_basic_identity", "Data" -> valid1|>,
        <|"Name" -> "valid_nontrivial_gram", "Data" -> valid2|>,
        <|"Name" -> "valid_zero_ambiguity", "Data" -> valid3|>
      },
      "InvalidExamples" -> {
        <|"Name" -> "invalid_parity_tag", "Data" -> invalid1, "ExpectedFailure" -> "Odd space"|>,
        <|"Name" -> "invalid_chi_on_ambiguity", "Data" -> invalid2, "ExpectedFailure" -> "Chi annihilates Aminus"|>,
        <|"Name" -> "invalid_positive_form", "Data" -> invalid3, "ExpectedFailure" -> "Positive symmetric B"|>
      }
    |>
  ];

RunCharDataExampleSuite[] :=
  Module[{suite = CharDataExampleSuite[], validReport, invalidReport},
    validReport = Map[
      Function[entry,
        With[{report = ValidateCharData[entry["Data"]]},
          <|
            "Name" -> entry["Name"],
            "Status" -> If[TrueQ[report["Valid"]], "exact finite-dimensional certificate", "counterexample found"],
            "ValidQ" -> report["Valid"],
            "FailedChecks" -> report["FailedChecks"]
          |>
        ]
      ],
      suite["ValidExamples"]
    ];
    invalidReport = Map[
      Function[entry,
        With[{report = ValidateCharData[entry["Data"]], expected = entry["ExpectedFailure"]},
          <|
            "Name" -> entry["Name"],
            "Status" -> If[
              !TrueQ[report["Valid"]] && MemberQ[report["FailedChecks"], expected],
              "exact finite-dimensional certificate",
              "counterexample found"
            ],
            "ValidQ" -> report["Valid"],
            "ExpectedFailure" -> expected,
            "FailedChecks" -> report["FailedChecks"]
          |>
        ]
      ],
      suite["InvalidExamples"]
    ];
    <|"ValidExamples" -> validReport, "InvalidExamples" -> invalidReport|>
  ];

End[]

EndPackage[]
