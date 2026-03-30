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

BeginPackage["MainProof`BoundaryBlockCentrality`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`BoundaryAmbiguityReduction`"]

ControlledBoundaryCommutatorFormulaAudit::usage =
  "ControlledBoundaryCommutatorFormulaAudit[dimA, dimB] proves the exact blockwise controlled commutator formula.";
BoundaryBlockCentralityAudit::usage =
  "BoundaryBlockCentralityAudit[model] checks strong and mod-null class-definedness against block centrality on the controlled boundary sector.";
BoundaryBlockCentralityExampleSuite::usage =
  "BoundaryBlockCentralityExampleSuite[] audits the standard safe, unsafe, and borderline split+welded families.";
RunBoundaryBlockCentralityExampleSuite::usage =
  "RunBoundaryBlockCentralityExampleSuite[] returns the exact theorem/counterexample bundle for the block-centrality lane.";
BoundaryBlockCentralityTheoremStatements::usage =
  "BoundaryBlockCentralityTheoremStatements[] returns manuscript-ready theorem statements for the strong, mod-null, and expectation-insufficiency results.";
BoundaryBlockCentralityLedgerUpdates::usage =
  "BoundaryBlockCentralityLedgerUpdates[] returns theorem-ledger updates for the block-centrality sprint items.";

Begin["`Private`"]

zeroMatrix[rows_Integer?NonNegative, cols_Integer?NonNegative] := ConstantArray[0, {rows, cols}];

commutator[x_?MatrixQ, y_?MatrixQ] := Expand[x.y - y.x];

zeroLike[m_?MatrixQ] := zeroMatrix @@ Dimensions[m];

blockCentralQ[block_?MatrixQ, basisB_List] :=
  AllTrue[basisB, Function[obs, MainProof`CommonProofTools`ExactMatrixEqualQ[commutator[block, obs], zeroLike[block]]]];

blockCentralModNullQ[block_?MatrixQ, basisB_List, nullBasisB_List] :=
  AllTrue[
    basisB,
    Function[obs, MainProof`CommonProofTools`MatrixInSpanQ[commutator[block, obs], nullBasisB]]
  ];

controlledBasisImages[model_Association] :=
  Module[{projA = model["ProjectorsA"], basisB = model["ControlledBasisB"], basisCtrl},
    basisCtrl = MainProof`BoundarySectors`BoundaryControlledSector[projA, basisB];
    MainProof`BoundarySectors`ControlledProjection[
        commutator[model["AmbiguityOperator"], #],
        projA
      ] & /@ basisCtrl
  ];

ControlledBoundaryCommutatorFormulaAudit[dimA_Integer?Positive, dimB_Integer?Positive] :=
  Module[{audit = MainProof`BoundaryAmbiguityReduction`ControlledBoundaryReductionAudit[dimA, dimB]},
    <|
      "Dimension" -> {dimA, dimB},
      "ControlledReductionFormula" -> audit["ControlledReductionFormula"],
      "OffDiagonalLedgerPartKilled" -> audit["OffDiagonalLedgerPartKilled"],
      "TheoremStatement" ->
        "For controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K on A \[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \[CircleTimes] [K_i^(B), O_i^(B)]."
    |>
  ];

BoundaryBlockCentralityAudit[model_Association] :=
  Module[
    {
      projA, basisB, nullBasisB, blockAudit, verification,
      kCtrl, kBlocks, strongBlocksQ, modNullBlocksQ, expectationGapQ
    },
    projA = model["ProjectorsA"];
    basisB = model["ControlledBasisB"];
    nullBasisB = model["NullIdealBasisB"];
    blockAudit = ControlledBoundaryCommutatorFormulaAudit[model["DimA"], model["DimB"]];
    verification = MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[model];
    kCtrl = MainProof`BoundarySectors`ControlledProjection[model["AmbiguityOperator"], projA];
    kBlocks = MainProof`BoundarySectors`ControlledBlocks[kCtrl, projA];
    strongBlocksQ = AllTrue[kBlocks, blockCentralQ[#, basisB] &];
    modNullBlocksQ = AllTrue[kBlocks, blockCentralModNullQ[#, basisB, nullBasisB] &];
    expectationGapQ =
      TrueQ[verification["ExpectationLevelInvisibleQ"]] &&
      (!TrueQ[verification["StrongClassDefinedQ"]] || !TrueQ[verification["ModNullClassDefinedQ"]]);
    <|
      "ModelName" -> model["Name"],
      "Dimension" -> {model["DimA"], model["DimB"]},
      "ControlledCommutatorFormula" -> blockAudit,
      "ControlledAmbiguity" -> kCtrl,
      "ControlledBlocks" -> kBlocks,
      "StrongBlockCentralityQ" -> strongBlocksQ,
      "ModNullBlockCentralityQ" -> modNullBlocksQ,
      "StrongClassDefinedQ" -> verification["StrongClassDefinedQ"],
      "ModNullClassDefinedQ" -> verification["ModNullClassDefinedQ"],
      "ExpectationLevelInvisibleQ" -> verification["ExpectationLevelInvisibleQ"],
      "OperatorLevelVisibleQ" -> verification["OperatorLevelVisibleQ"],
      "StrongEquivalenceCertified" ->
        TrueQ[verification["StrongClassDefinedQ"] === strongBlocksQ],
      "ModNullEquivalenceCertified" ->
        TrueQ[verification["ModNullClassDefinedQ"] === modNullBlocksQ],
      "ExpectationInsufficiencyWitnessQ" -> expectationGapQ,
      "WitnessObservable" -> model["AmbiguityWitnessObservable"],
      "WitnessImage" -> verification["WitnessImage_K"]
    |>
  ];

BoundaryBlockCentralityExampleSuite[] :=
  MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[];

RunBoundaryBlockCentralityExampleSuite[] :=
  Module[{models = BoundaryBlockCentralityExampleSuite[]},
    <|
      "StrongTheorem_2x2" -> ControlledBoundaryCommutatorFormulaAudit[2, 2],
      "StrongTheorem_2x3" -> ControlledBoundaryCommutatorFormulaAudit[2, 3],
      "StrongTheorem_3x2" -> ControlledBoundaryCommutatorFormulaAudit[3, 2],
      "SafeFamily" -> BoundaryBlockCentralityAudit[models["SafeOffDiagonalFamily"]],
      "UnsafeFamily" -> BoundaryBlockCentralityAudit[models["UnsafeControlledVisibleFamily"]],
      "BorderlineFamily" -> BoundaryBlockCentralityAudit[models["BorderlineNullIdealFamily"]]
    |>
  ];

BoundaryBlockCentralityTheoremStatements[] :=
  <|
    "thm:controlled-boundary-block-centrality-strong" ->
      "On the controlled boundary algebra, the induced derivation is representative-independent on the nose iff every surviving ambiguity block K_i^(B) is central on its B-block.",
    "thm:controlled-boundary-block-centrality-mod-null" ->
      "On the controlled boundary algebra modulo a boundary null ideal, the induced derivation is representative-independent iff every surviving ambiguity block K_i^(B) is central modulo that null ideal on its B-block.",
    "rem:expectation-invisibility-insufficient" ->
      "Expectation-level invisibility on boundary-classical states does not imply operator-level class-definedness, nor mod-null class-definedness, on the controlled boundary algebra."
  |>;

BoundaryBlockCentralityLedgerUpdates[] :=
  Module[{suite = RunBoundaryBlockCentralityExampleSuite[], safe, unsafe, borderline},
    safe = suite["SafeFamily"];
    unsafe = suite["UnsafeFamily"];
    borderline = suite["BorderlineFamily"];
    <|
      "thm:controlled-boundary-block-centrality-strong" -> <|
        "Method" -> "Exact controlled commutator reduction plus blockwise commutator checks against the full B-block basis.",
        "Status" -> If[
          suite["StrongTheorem_2x2", "ControlledReductionFormula"] &&
            suite["StrongTheorem_2x3", "ControlledReductionFormula"] &&
            safe["StrongEquivalenceCertified"] &&
            unsafe["StrongEquivalenceCertified"] &&
            borderline["StrongEquivalenceCertified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Controlled operator-level class-definedness is equivalent to blockwise centrality on the surviving B-blocks.",
        "RepresentativeModelFamily" -> "SafeOffDiagonalFamily, UnsafeControlledVisibleFamily, BorderlineNullIdealFamily",
        "NoApproximationQ" -> True
      |>,
      "thm:controlled-boundary-block-centrality-mod-null" -> <|
        "Method" -> "Exact controlled commutator reduction plus blockwise commutator membership tests in the boundary null ideal.",
        "Status" -> If[
          safe["ModNullEquivalenceCertified"] &&
            unsafe["ModNullEquivalenceCertified"] &&
            borderline["ModNullEquivalenceCertified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Controlled mod-null class-definedness is equivalent to block-centrality modulo the chosen boundary null ideal.",
        "RepresentativeModelFamily" -> "SafeOffDiagonalFamily, UnsafeControlledVisibleFamily, BorderlineNullIdealFamily",
        "NoApproximationQ" -> True
      |>,
      "rem:expectation-invisibility-insufficient" -> <|
        "Method" -> "Exact unsafe-family witness with vanishing expectations on boundary-classical states but nonzero operator-level controlled commutator.",
        "Status" -> If[
          TrueQ[unsafe["ExpectationInsufficiencyWitnessQ"]],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Expectation-level invisibility is shown insufficient by an exact controlled-sector witness.",
        "RepresentativeModelFamily" -> "UnsafeControlledVisibleFamily",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
