If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ActiveTransport`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ActiveTransport.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`CharData`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CharData.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySplitWeldedModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySplitWeldedModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryBlockCentrality`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryBlockCentrality.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryNullIdealCandidates`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryNullIdealCandidates.wl"}]];
];

BeginPackage["MainProof`TransportedBoundaryAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`ActiveTransport`"]
Needs["MainProof`CharData`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`BoundaryBlockCentrality`"]
Needs["MainProof`BoundaryNullIdealCandidates`"]

CertifiedTransportedWeakInterface::usage =
  "CertifiedTransportedWeakInterface[] returns the exact weak-interface export built from the certified active-transport model.";
TransportedBoundaryRealizationFamily::usage =
  "TransportedBoundaryRealizationFamily[] returns exact safe and unsafe boundary realizations of the actual transported ambiguity basis.";
AuditTransportedBoundaryRealization::usage =
  "AuditTransportedBoundaryRealization[realization, candidateName] audits the transported ambiguity basis against one natural boundary null ideal candidate.";
RunTransportedBoundaryAuditSuite::usage =
  "RunTransportedBoundaryAuditSuite[] audits the actual transported ambiguity basis under safe and unsafe boundary realizations.";
TransportedBoundaryAuditLedgerUpdates::usage =
  "TransportedBoundaryAuditLedgerUpdates[] returns theorem-ledger updates for the transported-boundary audit lane.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

sigmaX = {{0, 1}, {1, 0}};
sigmaZ = {{1, 0}, {0, -1}};

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

CertifiedTransportedWeakInterface[] :=
  Module[{model, chi, epsilon},
    model = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    chi = MainProof`ActiveTransport`DerivedChi[model];
    epsilon = chi . model["Jdesc"];
    MainProof`CharData`TickData[
      1,
      <|
        "Eminus" -> Length[model["Jdesc"]],
        "Aminus" -> model["Aminus"],
        "XiClass" -> <|"Representative" -> model["Jdesc"], "Basis" -> model["Aminus"]|>,
        "J0" -> model["Jdesc"],
        "Chi" -> chi,
        "Epsilon" -> epsilon,
        "B" -> IdentityMatrix[Length[model["Jdesc"]]],
        "Ochar" -> <|"Name" -> "CertifiedTransportedWeakInterface", "SourceModel" -> model["Name"]|>,
        "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> epsilon|>
      |>
    ]
  ];

realizationFromTransport[
  name_String,
  dimA_Integer?Positive,
  dimB_Integer?Positive,
  eminusImages_List,
  splitBlocks_List,
  witnessObservable_?MatrixQ,
  ambiguityWitnessObservable_?MatrixQ
] :=
  Module[
    {
      transport, weak, projA, basisCols, linearImage, jImage, ambiguityImages,
      baseModel
    },
    transport = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    weak = CertifiedTransportedWeakInterface[];
    projA = MainProof`BoundarySectors`LedgerProjectors[dimA];
    basisCols = basisColumns[transport["Aminus"]];
    linearImage[v_?VectorQ] :=
      Total[MapThread[#1 #2 &, {v, eminusImages}]];
    ambiguityImages = linearImage /@ basisCols;
    jImage = linearImage[transport["Jdesc"]];
    baseModel = MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelData[
      name,
      dimA,
      dimB,
      jImage,
      First[ambiguityImages],
      {},
      splitBlocks,
      "WitnessObservable" -> witnessObservable,
      "AmbiguityWitnessObservable" -> ambiguityWitnessObservable,
      "Metadata" -> <|
        "BoundarySectorType" -> "controlled",
        "WeakInterface" -> weak,
        "TransportModelName" -> transport["Name"]
      |>
    ];
    Join[
      baseModel,
      <|
        "WeakInterface" -> weak,
        "TransportModel" -> transport,
        "AminusBasisVectors" -> basisCols,
        "AmbiguityBasisOperators" -> ambiguityImages,
        "EminusBasisImages" -> eminusImages,
        "JOperator" -> jImage
      |>
    ]
  ];

TransportedBoundaryRealizationFamily[] :=
  Module[
    {
      proj2, id2, e12A, e21A, safeWitness, unsafeWitness
    },
    proj2 = MainProof`BoundarySectors`LedgerProjectors[2];
    id2 = IdentityMatrix[2];
    e12A = matrixUnit[2, 1, 2];
    e21A = matrixUnit[2, 2, 1];
    safeWitness = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaZ, ConstantArray[0, {2, 2}]}, proj2];
    unsafeWitness = MainProof`BoundarySectors`ControlledOperatorFromBlocks[{matrixUnit[2, 1, 2], ConstantArray[0, {2, 2}]}, proj2];
    <|
      "TransportedSafeFamily" -> realizationFromTransport[
        "transported_safe_2x2",
        2,
        2,
        {
          KroneckerProduct[e12A, id2],
          KroneckerProduct[e21A, id2],
          MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaX, ConstantArray[0, {2, 2}]}, proj2]
        },
        {id2, sigmaX},
        safeWitness,
        safeWitness
      ],
      "TransportedUnsafeFamily" -> realizationFromTransport[
        "transported_unsafe_2x2",
        2,
        2,
        {
          MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaZ, ConstantArray[0, {2, 2}]}, proj2],
          KroneckerProduct[e12A, id2],
          MainProof`BoundarySectors`ControlledOperatorFromBlocks[{sigmaX, ConstantArray[0, {2, 2}]}, proj2]
        },
        {id2, sigmaX},
        unsafeWitness,
        unsafeWitness
      ]
    |>
  ];

auditBasisOperator[op_?MatrixQ, realization_Association, candidateBasisB_List] :=
  Module[{model, audit, projA},
    model = Join[KeyDrop[realization, {"AmbiguityBasisOperators"}], <|"AmbiguityOperator" -> op, "NullIdealBasisB" -> candidateBasisB|>];
    audit = MainProof`BoundaryBlockCentrality`BoundaryBlockCentralityAudit[model];
    projA = realization["ProjectorsA"];
    <|
      "ControlledProjection" -> MainProof`BoundarySectors`ControlledProjection[op, projA],
      "ControlledBlocks" -> audit["ControlledBlocks"],
      "ControlledProjectionInNullIdealQ" ->
        MainProof`BoundarySectors`BoundaryNullIdealQ[op, projA, candidateBasisB],
      "StrongBlockCentralityQ" -> audit["StrongBlockCentralityQ"],
      "ModNullBlockCentralityQ" -> audit["ModNullBlockCentralityQ"],
      "OperatorLevelVisibleQ" -> audit["OperatorLevelVisibleQ"],
      "ExpectationLevelInvisibleQ" -> audit["ExpectationLevelInvisibleQ"],
      "WitnessImage" -> audit["WitnessImage"]
    |>
  ];

AuditTransportedBoundaryRealization[realization_Association, candidateName_String] :=
  Module[
    {
      candidateBasisB, basisAudits, visibleIndices, modNullIndices, nullProjectionIndices,
      expectationOnlyIndices
    },
    candidateBasisB =
      MainProof`BoundaryNullIdealCandidates`BoundaryNullIdealBasisB[candidateName, realization["DimB"]];
    basisAudits = auditBasisOperator[#, realization, candidateBasisB] & /@ realization["AmbiguityBasisOperators"];
    visibleIndices = Flatten @ Position[Lookup[basisAudits, "OperatorLevelVisibleQ"], True];
    modNullIndices = Flatten @ Position[Lookup[basisAudits, "ModNullBlockCentralityQ"], True];
    nullProjectionIndices = Flatten @ Position[Lookup[basisAudits, "ControlledProjectionInNullIdealQ"], True];
    expectationOnlyIndices = Flatten @ Position[
      MapThread[
        TrueQ[#1] && !TrueQ[#2] &,
        {Lookup[basisAudits, "ExpectationLevelInvisibleQ"], Lookup[basisAudits, "ModNullBlockCentralityQ"]}
      ],
      True
    ];
    <|
      "RealizationName" -> realization["Name"],
      "CandidateName" -> candidateName,
      "WeakInterface" -> realization["WeakInterface"],
      "AminusBasisVectors" -> realization["AminusBasisVectors"],
      "BasisOperatorAudits" -> basisAudits,
      "AllControlledProjectionsNullQ" -> And @@ Lookup[basisAudits, "ControlledProjectionInNullIdealQ"],
      "AllBasisStrongBlockCentralQ" -> And @@ Lookup[basisAudits, "StrongBlockCentralityQ"],
      "AllBasisModNullBlockCentralQ" -> And @@ Lookup[basisAudits, "ModNullBlockCentralityQ"],
      "VisibleBasisIndices" -> visibleIndices,
      "ModNullSafeBasisIndices" -> modNullIndices,
      "NullProjectionBasisIndices" -> nullProjectionIndices,
      "ExpectationOnlyBasisIndices" -> expectationOnlyIndices
    |>
  ];

RunTransportedBoundaryAuditSuite[] :=
  Module[
    {
      realizations, candidateNames, audits, safeReadout, safeState, unsafeReadout, unsafeState,
      safeWitness, unsafeWitness
    },
    realizations = TransportedBoundaryRealizationFamily[];
    candidateNames = MainProof`BoundaryNullIdealCandidates`BoundaryNullIdealCandidateNames[];
    audits = Association@Table[
      name -> Association @ KeyValueMap[#1 -> AuditTransportedBoundaryRealization[#2, name] &, realizations],
      {name, candidateNames}
    ];
    safeReadout = audits["readout-kernel", "TransportedSafeFamily"];
    safeState = audits["state-invisible", "TransportedSafeFamily"];
    unsafeReadout = audits["readout-kernel", "TransportedUnsafeFamily"];
    unsafeState = audits["state-invisible", "TransportedUnsafeFamily"];
    safeWitness = <|
      "Realization" -> realizations["TransportedSafeFamily"],
      "ReadoutKernelAudit" -> safeReadout,
      "StateInvisibleAudit" -> safeState
    |>;
    unsafeWitness = <|
      "Realization" -> realizations["TransportedUnsafeFamily"],
      "ReadoutKernelAudit" -> unsafeReadout,
      "StateInvisibleAudit" -> unsafeState
    |>;
    <|
      "WeakInterface" -> CertifiedTransportedWeakInterface[],
      "Realizations" -> realizations,
      "AuditsByCandidate" -> audits,
      "TransportedSafeWitness" -> safeWitness,
      "TransportedUnsafeWitness" -> unsafeWitness,
      "WeakestAdditionalHypothesis" ->
        "Each boundary realization of a transported ambiguity basis vector must have vanishing controlled projection, or block-central controlled B-blocks modulo a nontrivial boundary null ideal that remains stable and does not trivialize the controlled dynamics.",
      "ForcedByTransportStructureQ" ->
        False
    |>
  ];

TransportedBoundaryAuditLedgerUpdates[] :=
  Module[{suite = RunTransportedBoundaryAuditSuite[], safeAudit, unsafeAudit},
    safeAudit = suite["TransportedSafeWitness", "StateInvisibleAudit"];
    unsafeAudit = suite["TransportedUnsafeWitness", "StateInvisibleAudit"];
    <|
      "task:transported-boundary-ambiguity-audit" -> <|
        "Method" -> "Exact audit of the actual exported Aminus basis under safe and unsafe split+welded boundary realizations derived from the certified weak-interface transport model.",
        "Status" -> If[
          TrueQ[safeAudit["AllBasisModNullBlockCentralQ"]] &&
            Length[unsafeAudit["VisibleBasisIndices"]] > 0 &&
            !TrueQ[suite["ForcedByTransportStructureQ"]],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "The same exported transported ambiguity basis admits exact safe and unsafe boundary realizations, so boundary safety is not forced by the weak-interface transport structure alone.",
        "RepresentativeModelFamily" -> "TransportedSafeFamily, TransportedUnsafeFamily built from CertifiedActiveTransportModel weak-interface export",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
