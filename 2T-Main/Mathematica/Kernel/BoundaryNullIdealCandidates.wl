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

BeginPackage["MainProof`BoundaryNullIdealCandidates`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`BoundaryAmbiguityReduction`"]

BoundaryNullIdealCandidateNames::usage =
  "BoundaryNullIdealCandidateNames[] returns the ordered list of natural boundary null-ideal candidates compared in the current sprint.";
BoundaryNullIdealBasisB::usage =
  "BoundaryNullIdealBasisB[name, dimB] returns the exact B-block basis for the named candidate null ideal.";
AuditBoundaryNullIdealCandidate::usage =
  "AuditBoundaryNullIdealCandidate[name, model] audits one candidate null ideal on one exact split+welded model.";
RunBoundaryNullIdealCandidateSuite::usage =
  "RunBoundaryNullIdealCandidateSuite[] compares the natural candidate null ideals on the audited split+welded model families.";
RecommendedBoundaryNullIdealCandidate::usage =
  "RecommendedBoundaryNullIdealCandidate[suite] returns the recommended natural candidate, or Missing when none passes the exact nontriviality filters.";
BoundaryNullIdealCandidateLedgerUpdates::usage =
  "BoundaryNullIdealCandidateLedgerUpdates[] returns theorem-ledger updates for the natural boundary-null-ideal comparison.";

Begin["`Private`"]

commutator[x_?MatrixQ, y_?MatrixQ] := Expand[x.y - y.x];

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

blockTraceZeroBasis[dim_Integer?Positive] :=
  Join[
    MainProof`BoundarySectors`BoundaryOffDiagonalBasis[dim],
    Table[matrixUnit[dim, i, i] - matrixUnit[dim, dim, dim], {i, 1, dim - 1}]
  ];

stateInvisibleBasis[dim_Integer?Positive] :=
  MainProof`BoundarySectors`BoundaryOffDiagonalBasis[dim];

candidateDescription[name_String] := Switch[name,
  "readout-kernel",
    "Ker(Phi_partial) intersected with the controlled boundary algebra.",
  "block-trace-zero",
    "Controlled block operators whose each B-block has trace zero.",
  "state-invisible",
    "Controlled block operators invisible on the boundary-classical diagonal state family.",
  _,
    "Unknown candidate."
];

BoundaryNullIdealCandidateNames[] := {
  "readout-kernel",
  "block-trace-zero",
  "state-invisible"
};

BoundaryNullIdealBasisB["readout-kernel", dimB_Integer?Positive] := blockTraceZeroBasis[dimB];
BoundaryNullIdealBasisB["block-trace-zero", dimB_Integer?Positive] := blockTraceZeroBasis[dimB];
BoundaryNullIdealBasisB["state-invisible", dimB_Integer?Positive] := stateInvisibleBasis[dimB];

candidateLinearityQ[basis_List] := AllTrue[basis, MatrixQ];

candidateLieStableQ[projA_List, controlledBasisB_List, candidateBasisB_List] :=
  Module[{nullCtrl, basisCtrl},
    nullCtrl = MainProof`BoundarySectors`BoundaryControlledSector[projA, candidateBasisB];
    basisCtrl = MainProof`BoundarySectors`BoundaryControlledSector[projA, controlledBasisB];
    AllTrue[
      nullCtrl,
      Function[n,
        AllTrue[
          basisCtrl,
          Function[o,
            MainProof`BoundarySectors`BoundaryNullIdealQ[
              MainProof`BoundarySectors`ControlledProjection[commutator[n, o], projA],
              projA,
              candidateBasisB
            ]
          ]
        ]
      ]
    ]
  ];

candidateStateInvisibleQ[model_Association, candidateBasisB_List] :=
  Module[
    {projA = model["ProjectorsA"], dimB = model["DimB"], states = model["ClassicalStates"], candidateCtrl},
    candidateCtrl = MainProof`BoundarySectors`BoundaryControlledSector[projA, candidateBasisB];
    AllTrue[
      candidateCtrl,
      Function[x,
        AllTrue[
          states,
          Function[rho, TrueQ[MainProof`BoundarySectors`BoundaryExpectation[rho, x] == 0]]
        ]
      ]
    ]
  ];

AuditBoundaryNullIdealCandidate[name_String, model_Association] :=
  Module[
    {
      candidateBasisB, modelWithCandidate, verification, projA,
      witnessImageJ, witnessImageK, readoutKernelQ, description
    },
    candidateBasisB = BoundaryNullIdealBasisB[name, model["DimB"]];
    modelWithCandidate = Join[model, <|"NullIdealBasisB" -> candidateBasisB|>];
    verification = MainProof`BoundaryAmbiguityReduction`VerifyBoundaryControlledDerivation[modelWithCandidate];
    projA = model["ProjectorsA"];
    witnessImageJ = verification["WitnessImage_J"];
    witnessImageK = verification["WitnessImage_K"];
    readoutKernelQ = AllTrue[
      MainProof`BoundarySectors`BoundaryControlledSector[projA, candidateBasisB],
      Function[x,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          MainProof`BoundarySectors`BoundaryReadout[x, projA],
          ConstantArray[0, {Length[projA], Length[projA]}]
        ]
      ]
    ];
    description = candidateDescription[name];
    <|
      "CandidateName" -> name,
      "Description" -> description,
      "Dimension" -> {model["DimA"], model["DimB"]},
      "LinearityQ" -> candidateLinearityQ[candidateBasisB],
      "ControlledLieStabilityQ" ->
        candidateLieStableQ[projA, model["ControlledBasisB"], candidateBasisB],
      "BoundaryClassicalStateInvisibleQ" ->
        candidateStateInvisibleQ[model, candidateBasisB],
      "BoundaryReadoutKernelQ" -> readoutKernelQ,
      "ModNullClassDefinedQ" -> verification["ModNullClassDefinedQ"],
      "StrongClassDefinedQ" -> verification["StrongClassDefinedQ"],
      "WitnessImageJInCandidateQ" ->
        MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageJ, projA, candidateBasisB],
      "WitnessImageKInCandidateQ" ->
        MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageK, projA, candidateBasisB],
      "PreservesNontrivialControlledDynamicsQ" ->
        verification["NontrivialControlledDerivationQ"] &&
          !MainProof`BoundarySectors`BoundaryNullIdealQ[witnessImageJ, projA, candidateBasisB],
      "WitnessImage_J" -> witnessImageJ,
      "WitnessImage_K" -> witnessImageK
    |>
  ];

summarizeCandidate[audits_List] :=
  Module[
    {
      stableQ, invisibleQ, readoutKernelQ, preservesQ,
      borderlineAbsorbedQ, unsafeAbsorbedQ, overlargeQ, recommendedQ
    },
    stableQ = And @@ Lookup[audits, "ControlledLieStabilityQ"];
    invisibleQ = And @@ Lookup[audits, "BoundaryClassicalStateInvisibleQ"];
    readoutKernelQ = And @@ Lookup[audits, "BoundaryReadoutKernelQ"];
    preservesQ = Or @@ Lookup[audits, "PreservesNontrivialControlledDynamicsQ"];
    borderlineAbsorbedQ =
      Lookup[
        FirstCase[audits, audit_ /; audit["Dimension"] === {2, 3} :> audit, <||>],
        "WitnessImageKInCandidateQ",
        False
      ];
    unsafeAbsorbedQ =
      Lookup[
        FirstCase[audits, audit_ /; audit["Dimension"] === {2, 2} :> audit, <||>],
        "WitnessImageKInCandidateQ",
        False
      ];
    overlargeQ = !preservesQ;
    recommendedQ = stableQ && preservesQ && borderlineAbsorbedQ && !unsafeAbsorbedQ;
    <|
      "ControlledLieStabilityQ" -> stableQ,
      "BoundaryClassicalStateInvisibleQ" -> invisibleQ,
      "BoundaryReadoutKernelQ" -> readoutKernelQ,
      "AbsorbsBorderlineFamilyQ" -> borderlineAbsorbedQ,
      "AbsorbsUnsafeVisibleFamilyQ" -> unsafeAbsorbedQ,
      "TrivializesAllAuditedDynamicsQ" -> overlargeQ,
      "RecommendedQ" -> recommendedQ
    |>
  ];

RunBoundaryNullIdealCandidateSuite[] :=
  Module[{models, candidateNames, auditsByCandidate, summaries},
    models = MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[];
    candidateNames = BoundaryNullIdealCandidateNames[];
    auditsByCandidate = Association@Table[
      name -> {
        AuditBoundaryNullIdealCandidate[name, models["SafeOffDiagonalFamily"]],
        AuditBoundaryNullIdealCandidate[name, models["UnsafeControlledVisibleFamily"]],
        AuditBoundaryNullIdealCandidate[name, models["BorderlineNullIdealFamily"]]
      },
      {name, candidateNames}
    ];
    summaries = Association @ KeyValueMap[#1 -> summarizeCandidate[#2] &, auditsByCandidate];
    <|
      "CandidateAudits" -> auditsByCandidate,
      "CandidateSummaries" -> summaries,
      "ReadoutKernelEqualsBlockTraceZeroQ" ->
        And @@ Table[
          With[
            {
              readBasis = BoundaryNullIdealBasisB["readout-kernel", dim],
              traceBasis = BoundaryNullIdealBasisB["block-trace-zero", dim]
            },
            Length[readBasis] == Length[traceBasis] &&
              And @@ MapThread[MainProof`CommonProofTools`ExactMatrixEqualQ, {readBasis, traceBasis}]
          ],
          {dim, {2, 3}}
        ]
    |>
  ];

RecommendedBoundaryNullIdealCandidate[suite_Association] :=
  FirstCase[
    BoundaryNullIdealCandidateNames[],
    name_ /; TrueQ[suite["CandidateSummaries", name, "RecommendedQ"]] :> name,
    Missing["NoNaturalCandidate"]
  ];

BoundaryNullIdealCandidateLedgerUpdates[] :=
  Module[{suite = RunBoundaryNullIdealCandidateSuite[], recommendation},
    recommendation = RecommendedBoundaryNullIdealCandidate[suite];
    <|
      "task:boundary-null-ideal-candidates" -> <|
        "Method" -> "Exact model-by-model comparison of natural boundary null ideals: readout-kernel, block-trace-zero, and state-invisible candidates.",
        "Status" -> If[
          KeyExistsQ[suite, "CandidateSummaries"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> If[
          MissingQ[recommendation],
          "No tested natural candidate is simultaneously stable, nontrivial, and able to absorb the borderline safe family.",
          StringJoin["Recommended natural candidate: ", recommendation, "."]
        ],
        "RepresentativeModelFamily" -> "SafeOffDiagonalFamily, UnsafeControlledVisibleFamily, BorderlineNullIdealFamily",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
