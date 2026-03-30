If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

BeginPackage["MainProof`BoundaryAmbiguityReduction`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]

StrictBoundaryRecordAudit::usage =
  "StrictBoundaryRecordAudit[dimA, dimB] proves exact boundary-readout annihilation on the strict record sector.";
ControlledBoundaryReductionAudit::usage =
  "ControlledBoundaryReductionAudit[dimA, dimB] proves exact controlled-sector reduction formulas.";
BoundaryControlledDerivationData::usage =
  "BoundaryControlledDerivationData[model] constructs exact controlled-boundary derivation data for a split+welded model.";
VerifyBoundaryControlledDerivation::usage =
  "VerifyBoundaryControlledDerivation[data] checks strong/mod-null/operator/expectation-level ambiguity invisibility on the controlled sector.";

Begin["`Private`"]

zeroMatrix[rows_Integer?NonNegative, cols_Integer?NonNegative] := ConstantArray[0, {rows, cols}];

commutator[x_?MatrixQ, y_?MatrixQ] := Expand[x.y - y.x];

symbolicFullOperator[dim_Integer?Positive] := Array[x, {dim, dim}];

symbolicControlledBlocks[dimA_Integer?Positive, dimB_Integer?Positive, head_Symbol] :=
  Table[Array[head[i], {dimB, dimB}], {i, dimA}];

genericRecordObservable[projA_List, dimB_Integer?Positive] :=
  Total[Table[\[Lambda][i] KroneckerProduct[projA[[i]], IdentityMatrix[dimB]], {i, Length[projA]}]];

genericControlledObservable[projA_List, dimB_Integer?Positive] :=
  MainProof`BoundarySectors`ControlledOperatorFromBlocks[
    symbolicControlledBlocks[Length[projA], dimB, o],
    projA
  ];

StrictBoundaryRecordAudit[dimA_Integer?Positive, dimB_Integer?Positive] :=
  Module[{projA, x, oRec, readoutComm, explicitX, explicitRecordObservable, explicitWitness},
    projA = MainProof`BoundarySectors`LedgerProjectors[dimA];
    x = symbolicFullOperator[dimA dimB];
    oRec = genericRecordObservable[projA, dimB];
    readoutComm = MainProof`BoundarySectors`BoundaryReadout[commutator[x, oRec], projA];
    explicitX = KroneckerProduct[
      Normal @ SparseArray[{{1, Min[2, dimA]} -> 1, {Min[2, dimA], 1} -> 1}, {dimA, dimA}],
      IdentityMatrix[dimB]
    ];
    explicitRecordObservable = Sum[i KroneckerProduct[projA[[i]], IdentityMatrix[dimB]], {i, dimA}];
    explicitWitness = commutator[explicitX, explicitRecordObservable];
    <|
      "Dimension" -> {dimA, dimB},
      "ReadoutAnnihilatesCommutator" -> ExactMatrixEqualQ[readoutComm, zeroMatrix[dimA, dimA]],
      "InducedDerivationZeroOnStrictRecordSector" -> ExactMatrixEqualQ[readoutComm, zeroMatrix[dimA, dimA]],
      "NonzeroOperatorLevelWitness" -> !ExactMatrixEqualQ[explicitWitness, zeroMatrix[dimA dimB, dimA dimB]],
      "TrivializationRisk" -> True,
      "TrivializationWitnessOperator" -> explicitX,
      "TrivializationWitnessObservable" -> explicitRecordObservable,
      "TrivializationWitnessCommutator" -> explicitWitness
    |>
  ];

ControlledBoundaryReductionAudit[dimA_Integer?Positive, dimB_Integer?Positive] :=
  Module[
    {projA, k, oCtrl, offDiag, kCtrl, lhs, rhs, kBlocks, oBlocks},
    projA = MainProof`BoundarySectors`LedgerProjectors[dimA];
    k = symbolicFullOperator[dimA dimB];
    oCtrl = genericControlledObservable[projA, dimB];
    offDiag = MainProof`BoundarySectors`OffDiagPart[k, projA];
    kCtrl = MainProof`BoundarySectors`ControlledProjection[k, projA];
    lhs = MainProof`BoundarySectors`ControlledProjection[commutator[k, oCtrl], projA];
    kBlocks = MainProof`BoundarySectors`ControlledBlocks[kCtrl, projA];
    oBlocks = MainProof`BoundarySectors`ControlledBlocks[oCtrl, projA];
    rhs = MainProof`BoundarySectors`ControlledOperatorFromBlocks[
      Table[commutator[kBlocks[[i]], oBlocks[[i]]], {i, dimA}],
      projA
    ];
    <|
      "Dimension" -> {dimA, dimB},
      "ControlledObservableQ" -> MainProof`BoundarySectors`DiagSectorQ[oCtrl, projA],
      "OffDiagonalLedgerPartKilled" -> ExactMatrixEqualQ[
        MainProof`BoundarySectors`ControlledProjection[commutator[offDiag, oCtrl], projA],
        zeroMatrix[dimA dimB, dimA dimB]
      ],
      "ControlledReductionFormula" -> ExactMatrixEqualQ[lhs, rhs],
      "ControlledBlocksFormula" -> rhs
    |>
  ];

BoundaryControlledDerivationData[model_Association] := model;

VerifyBoundaryControlledDerivation[data_Association] :=
  Module[
    {
      model = data, projA, basisB, basisCtrl, classicalStates, nullBasisB, k, j,
      imagesK, imagesJ, strongQ, modNullQ, expectationQ, witness, ambiguityWitness,
      witnessImageJ, witnessImageK
    },
    projA = model["ProjectorsA"];
    basisB = model["ControlledBasisB"];
    basisCtrl = MainProof`BoundarySectors`BoundaryControlledSector[projA, basisB];
    classicalStates = model["ClassicalStates"];
    nullBasisB = model["NullIdealBasisB"];
    k = model["AmbiguityOperator"];
    j = model["JOperator"];
    imagesK = MainProof`BoundarySectors`ControlledProjection[commutator[k, #], projA] & /@ basisCtrl;
    imagesJ = MainProof`BoundarySectors`ControlledProjection[commutator[j, #], projA] & /@ basisCtrl;
    strongQ = AllTrue[imagesK, ExactMatrixEqualQ[#, zeroMatrix[Length[First[imagesK]], Length[First[imagesK]]]] &];
    modNullQ = AllTrue[imagesK, MainProof`BoundarySectors`BoundaryNullIdealQ[#, projA, nullBasisB] &];
    expectationQ = AllTrue[
      Flatten@Table[
        MainProof`BoundarySectors`BoundaryExpectation[\[Rho], img] == 0,
        {\[Rho], classicalStates},
        {img, imagesK}
      ],
      TrueQ
    ];
    witness = model["WitnessObservable"];
    ambiguityWitness = model["AmbiguityWitnessObservable"];
    witnessImageJ = MainProof`BoundarySectors`ControlledProjection[commutator[j, witness], projA];
    witnessImageK = MainProof`BoundarySectors`ControlledProjection[commutator[k, ambiguityWitness], projA];
    <|
      "ModelChecks" -> Lookup[model, "ModelChecks", Missing["NotProvided"]],
      "StrongClassDefinedQ" -> strongQ,
      "ModNullClassDefinedQ" -> modNullQ,
      "ExpectationLevelInvisibleQ" -> expectationQ,
      "OperatorLevelVisibleQ" -> AnyTrue[imagesK, Function[img, !ExactMatrixEqualQ[img, zeroMatrix[Length[img], Length[img]]]]],
      "WitnessImage_J" -> witnessImageJ,
      "WitnessImage_K" -> witnessImageK,
      "NontrivialControlledDerivationQ" -> !MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageJ, projA, nullBasisB] &&
        !ExactMatrixEqualQ[witnessImageJ, zeroMatrix[Length[witnessImageJ], Length[witnessImageJ]]],
      "AmbiguityInvisibleModNullQ" -> MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageK, projA, nullBasisB],
      "AmbiguityVisibleAtOperatorLevelQ" ->
        !ExactMatrixEqualQ[witnessImageK, zeroMatrix[Length[witnessImageK], Length[witnessImageK]]] &&
        !MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageK, projA, nullBasisB]
    |>
  ];

End[]

EndPackage[]
