If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

BeginPackage["MainProof`BoundarySplitWeldedModels`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]

SplitControlledUnitary::usage =
  "SplitControlledUnitary[projA, splitBlocks] builds U_split = Sum_i Pi^(A) ⊗ U_i^(B).";
BoundarySplitWeldedModelData::usage =
  "BoundarySplitWeldedModelData[name, dimA, dimB, jOp, ambiguityOp, nullBasisB, splitBlocks, opts] builds an exact split+welded boundary model.";
VerifyBoundarySplitWeldedModel::usage =
  "VerifyBoundarySplitWeldedModel[model] checks exact controlled-unitary properties and basic boundary metadata.";
BoundaryClassicalStateFamily::usage =
  "BoundaryClassicalStateFamily[projA, dimB] returns the pure diagonal boundary-classical states.";
BoundarySplitWeldedModelFamily::usage =
  "BoundarySplitWeldedModelFamily[] returns exact safe, unsafe, and borderline split+welded model families.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

zeroMatrix[rows_Integer?NonNegative, cols_Integer?NonNegative] := ConstantArray[0, {rows, cols}];

SplitControlledUnitary[projA_List, splitBlocks_List] :=
  Total[Table[KroneckerProduct[projA[[i]], splitBlocks[[i]]], {i, Length[projA]}]];

BoundaryClassicalStateFamily[projA_List, dimB_Integer?Positive] :=
  Module[{diagB = MainProof`BoundarySectors`BoundaryDiagonalBasis[dimB]},
    Flatten[
      Table[KroneckerProduct[projA[[i]], diagB[[j]]], {i, Length[projA]}, {j, dimB}],
      1
    ]
  ];

Options[BoundarySplitWeldedModelData] = {
  "ControlledBasisB" -> Automatic,
  "WitnessObservable" -> Automatic,
  "AmbiguityWitnessObservable" -> Automatic,
  "Metadata" -> <||>
};

BoundarySplitWeldedModelData[
  name_String,
  dimA_Integer?Positive,
  dimB_Integer?Positive,
  jOp_?MatrixQ,
  ambiguityOp_?MatrixQ,
  nullBasisB_List,
  splitBlocks_List,
  OptionsPattern[]
] :=
  Module[{projA, controlledBasisB, splitUnitary},
    projA = MainProof`BoundarySectors`LedgerProjectors[dimA];
    controlledBasisB = Replace[OptionValue["ControlledBasisB"], Automatic :> MainProof`BoundarySectors`BoundaryMatrixUnits[dimB]];
    splitUnitary = SplitControlledUnitary[projA, splitBlocks];
    <|
      "Name" -> name,
      "DimA" -> dimA,
      "DimB" -> dimB,
      "ProjectorsA" -> projA,
      "ControlledBasisB" -> controlledBasisB,
      "NullIdealBasisB" -> nullBasisB,
      "SplitBlocks" -> splitBlocks,
      "SplitUnitary" -> splitUnitary,
      "JOperator" -> jOp,
      "AmbiguityOperator" -> ambiguityOp,
      "ClassicalStates" -> BoundaryClassicalStateFamily[projA, dimB],
      "WitnessObservable" -> OptionValue["WitnessObservable"],
      "AmbiguityWitnessObservable" -> OptionValue["AmbiguityWitnessObservable"],
      "Metadata" -> OptionValue["Metadata"]
    |>
  ];

VerifyBoundarySplitWeldedModel[model_Association] :=
  Module[{projA, dimB, split, identityB},
    projA = model["ProjectorsA"];
    dimB = model["DimB"];
    split = model["SplitUnitary"];
    identityB = IdentityMatrix[dimB];
    <|
      "ControlledSplitForm" -> ExactMatrixEqualQ[
        split,
        SplitControlledUnitary[projA, model["SplitBlocks"]]
      ],
      "SplitUnitaryQ" -> ExactMatrixEqualQ[
        Transpose[split].split,
        IdentityMatrix[Length[projA] dimB]
      ],
      "LedgerQND" -> And @@ Table[
        ExactMatrixEqualQ[
          split.KroneckerProduct[projA[[i]], identityB],
          KroneckerProduct[projA[[i]], identityB].split
        ],
        {i, Length[projA]}
      ],
      "AmbiguityControlledQ" ->
        MainProof`BoundarySectors`DiagSectorQ[
          MainProof`BoundarySectors`ControlledProjection[model["AmbiguityOperator"], projA],
          projA
        ],
      "WitnessDefinedQ" -> MatrixQ[model["WitnessObservable"]],
      "AmbiguityWitnessDefinedQ" -> MatrixQ[model["AmbiguityWitnessObservable"]]
    |>
  ];

BoundarySplitWeldedModelFamily[] :=
  Module[
    {
      proj2, proj3, id2, id3, swap2, sign2, perm3, sigmaX, sigmaZ,
      e12, e21, e13, e31, e23, e32,
      safeJ, safeK, safeWitness, unsafeJ, unsafeK, unsafeWitness,
      borderlineJ, borderlineK, borderlineWitness, borderlineAmbiguityWitness
    },
    proj2 = MainProof`BoundarySectors`LedgerProjectors[2];
    proj3 = MainProof`BoundarySectors`LedgerProjectors[3];
    id2 = IdentityMatrix[2];
    id3 = IdentityMatrix[3];
    swap2 = {{0, 1}, {1, 0}};
    sign2 = {{1, 0}, {0, -1}};
    perm3 = {{0, 1, 0}, {0, 0, 1}, {1, 0, 0}};
    sigmaX = {{0, 1}, {1, 0}};
    sigmaZ = {{1, 0}, {0, -1}};
    e12 = matrixUnit[3, 1, 2];
    e21 = matrixUnit[3, 2, 1];
    e13 = matrixUnit[3, 1, 3];
    e31 = matrixUnit[3, 3, 1];
    e23 = matrixUnit[3, 2, 3];
    e32 = matrixUnit[3, 3, 2];

    safeJ = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaX, zeroMatrix[2, 2], zeroMatrix[2, 2]}, proj3];
    safeK =
      KroneckerProduct[matrixUnit[3, 1, 2] + matrixUnit[3, 2, 1], id2];
    safeWitness =
      MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaZ, zeroMatrix[2, 2], zeroMatrix[2, 2]}, proj3];

    unsafeJ = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaX, zeroMatrix[2, 2]}, proj2];
    unsafeK = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaZ, zeroMatrix[2, 2]}, proj2];
    unsafeWitness =
      MainProof`BoundarySectors`ControlledOperatorFromBlocks[{matrixUnit[2, 1, 2], zeroMatrix[2, 2]}, proj2];

    borderlineJ = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{e12, zeroMatrix[3, 3]}, proj2];
    borderlineK = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{DiagonalMatrix[{1, 1, 0}], zeroMatrix[3, 3]}, proj2];
    borderlineWitness = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{e21, zeroMatrix[3, 3]}, proj2];
    borderlineAmbiguityWitness = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{e13, zeroMatrix[3, 3]}, proj2];

    <|
      "SafeOffDiagonalFamily" -> BoundarySplitWeldedModelData[
        "safe_offdiagonal_3x2",
        3,
        2,
        safeJ,
        safeK,
        {},
        {id2, swap2, sign2},
        "WitnessObservable" -> safeWitness,
        "AmbiguityWitnessObservable" -> safeWitness,
        "Metadata" -> <|
          "BoundarySectorType" -> "controlled",
          "HypothesisH" -> "ambiguity is purely off-diagonal in the inherited ledger sector A"
        |>
      ],
      "UnsafeControlledVisibleFamily" -> BoundarySplitWeldedModelData[
        "unsafe_visible_2x2",
        2,
        2,
        unsafeJ,
        unsafeK,
        {},
        {id2, swap2},
        "WitnessObservable" -> unsafeWitness,
        "AmbiguityWitnessObservable" -> unsafeWitness,
        "Metadata" -> <|
          "BoundarySectorType" -> "controlled",
          "HypothesisH" -> "ambiguity has a diagonal controlled B-component that remains visible"
        |>
      ],
      "BorderlineNullIdealFamily" -> BoundarySplitWeldedModelData[
        "borderline_nullideal_2x3",
        2,
        3,
        borderlineJ,
        borderlineK,
        {e13, e31, e23, e32},
        {id3, perm3},
        "WitnessObservable" -> borderlineWitness,
        "AmbiguityWitnessObservable" -> borderlineAmbiguityWitness,
        "Metadata" -> <|
          "BoundarySectorType" -> "controlled",
          "HypothesisH" -> "diagonal controlled ambiguity acts only into the chosen boundary null ideal"
        |>
      ]
    |>
  ];

End[]

EndPackage[]
