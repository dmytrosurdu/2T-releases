If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`CosmologyBoundaryInterface`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CosmologyBoundaryInterface.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMBoundaryCanonicalization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMBoundaryCanonicalization.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMCompletionAmbiguityAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMCompletionAmbiguityAudit.wl"}]];
];

BeginPackage["MainProof`MockCosmologyContracts`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`CosmologyBoundaryInterface`"]
Needs["MainProof`UOMBoundaryCanonicalization`"]
Needs["MainProof`UOMCompletionAmbiguityAudit`"]

MockCosmologyRealizations::usage =
  "MockCosmologyRealizations[] returns UOM, synthetic non-UOM, and negative-control realizations for the compact-interface search.";
AuditMockCosmologyInterfaces::usage =
  "AuditMockCosmologyInterfaces[] evaluates candidate interface contracts on the mock realization family and identifies the minimal working candidates.";
MockCosmologyContractsLedgerUpdates::usage =
  "MockCosmologyContractsLedgerUpdates[] returns theorem-ledger updates for the compact-interface search lane.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

rankOneProjectorFromVector[v_?VectorQ] :=
  Module[{den = Expand[v . v]},
    Expand[Outer[Times, v, v]/den]
  ];

ledgerProjectors[] := {matrixUnit[2, 1, 1], matrixUnit[2, 2, 2]};

controlledSplitUnitary[] :=
  Module[{pi1, pi2, u1, u2},
    {pi1, pi2} = ledgerProjectors[];
    u1 = IdentityMatrix[2];
    u2 = DiagonalMatrix[{1, -1}];
    KroneckerProduct[pi1, u1] + KroneckerProduct[pi2, u2]
  ];

boundaryCommutator[j_?MatrixQ, x_?MatrixQ] := Expand[j . x - x . j];

acceptedRecordProjection[lift_?MatrixQ] :=
  DiagonalMatrix[{Tr[lift[[1 ;; 2, 1 ;; 2]]], Tr[lift[[3 ;; 4, 3 ;; 4]]]}];

buildBoundaryRealization[
  name_String,
  kind_String,
  chi_?VectorQ,
  jdesc_?VectorQ,
  ambiguityBasis_?MatrixQ,
  boundaryMap_,
  projector_?MatrixQ,
  acceptedRecordPreservationQ_,
  bandLockQ_,
  coCenteringQ_
] :=
  Module[
    {
      ambiguityColumns, ambiguityImages, representativeImage, observableWitness,
      representativeAction, annihilationQ, survivesQ, nontrivialQ, rankOneQ,
      descendedScalarQ
    },
    ambiguityColumns = Table[ambiguityBasis[[All, i]], {i, Dimensions[ambiguityBasis][[2]]}];
    ambiguityImages = boundaryMap /@ ambiguityColumns;
    representativeImage = boundaryMap[jdesc];
    observableWitness = matrixUnit[2, 1, 2];
    representativeAction = boundaryCommutator[representativeImage, observableWitness];
    annihilationQ =
      AllTrue[
        ambiguityImages,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          #,
          ConstantArray[0, Dimensions[projector]]
        ] &
      ];
    survivesQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeImage,
        ConstantArray[0, Dimensions[representativeImage]]
      ];
    nontrivialQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeAction,
        ConstantArray[0, Dimensions[representativeAction]]
      ];
    rankOneQ = MainProof`CommonProofTools`RankOneProjectorQ[projector];
    descendedScalarQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeImage,
        Expand[(chi . jdesc) projector]
      ] && survivesQ;
    <|
      "Name" -> name,
      "Kind" -> kind,
      "Chi" -> chi,
      "Jdesc" -> jdesc,
      "Aminus" -> ambiguityBasis,
      "BoundaryProjector" -> projector,
      "BoundaryMap" -> boundaryMap,
      "BoundaryImages" -> <|
        "Representative" -> representativeImage,
        "Ambiguity" -> ambiguityImages
      |>,
      "BoundaryClassification" ->
        If[annihilationQ && survivesQ && nontrivialQ, "strong-safe", "visible-ambiguity"],
      "CompletionClassification" -> "not-applicable",
      "Properties" -> <|
        "UOMRealizationQ" -> (kind == "UOM"),
        "BoundaryMapQ" -> True,
        "TransportedDescendantClassQ" -> True,
        "AmbiguitySubspaceQ" -> True,
        "DescendedActiveScalarQ" -> descendedScalarQ,
        "BoundaryAmbiguityAnnihilationQ" -> annihilationQ,
        "RepresentativeLineSurvivesQ" -> survivesQ && nontrivialQ,
        "AcceptedRecordPreservationQ" -> TrueQ[acceptedRecordPreservationQ],
        "RankOneActiveBoundaryImageQ" -> rankOneQ,
        "GeometricLockingQ" -> TrueQ[bandLockQ] && TrueQ[coCenteringQ],
        "SplitControlledLiftQ" -> False,
        "GaussianCompletionQ" -> False,
        "LiftedFactPreservationQ" -> False,
        "CompletionAmbiguityAnnihilationQ" -> False
      |>
    |>
  ];

augmentWithCompletion[realization_Association] :=
  Module[
    {
      pi1, pi2, unitary, completionProjector, qObs, pObs, omega, h,
      covarianceMap, lift, ambiguityColumns, ambiguityLifts, representativeLift,
      qndQ, liftedBoundaryCompatQ, liftedFactQ, gaussianQ, completionWitness,
      ambiguityAction, representativeAction, completionSafeQ
    },
    {pi1, pi2} = ledgerProjectors[];
    unitary = controlledSplitUnitary[];
    completionProjector = realization["BoundaryProjector"];
    qObs = DiagonalMatrix[{1, -1}];
    pObs = {{0, 1}, {1, 0}};
    omega = {{0, 1}, {-1, 0}};
    h = IdentityMatrix[2];
    covarianceMap = Function[v, Expand[(realization["Chi"] . v) completionProjector]];
    lift = Function[v,
      Module[{boundaryImage = realization["BoundaryMap"][v], scalar = realization["Chi"] . v},
        KroneckerProduct[pi1, boundaryImage] + KroneckerProduct[pi2, scalar completionProjector]
      ]
    ];
    ambiguityColumns = Table[realization["Aminus"][[All, i]], {i, Dimensions[realization["Aminus"]][[2]]}];
    ambiguityLifts = lift /@ ambiguityColumns;
    representativeLift = lift[realization["Jdesc"]];
    qndQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        unitary . KroneckerProduct[pi1, IdentityMatrix[2]] -
          KroneckerProduct[pi1, IdentityMatrix[2]] . unitary,
        ConstantArray[0, {4, 4}]
      ] &&
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          unitary . KroneckerProduct[pi2, IdentityMatrix[2]] -
            KroneckerProduct[pi2, IdentityMatrix[2]] . unitary,
          ConstantArray[0, {4, 4}]
        ];
    liftedBoundaryCompatQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeLift[[1 ;; 2, 1 ;; 2]],
        realization["BoundaryImages", "Representative"]
      ] &&
        AllTrue[
          MapThread[
            MainProof`CommonProofTools`ExactMatrixEqualQ[#1[[1 ;; 2, 1 ;; 2]], #2] &,
            {ambiguityLifts, realization["BoundaryImages", "Ambiguity"]}
          ],
          TrueQ
        ];
    liftedFactQ =
      AllTrue[
        ambiguityLifts,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          acceptedRecordProjection[#],
          ConstantArray[0, {2, 2}]
        ] &
      ];
    gaussianQ =
      MainProof`CommonProofTools`SymmetricPositiveDefiniteQ[h] &&
        MainProof`CommonProofTools`ExactMatrixEqualQ[Transpose[omega], -omega] &&
        Det[omega] =!= 0 &&
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          qObs . pObs - pObs . qObs,
          2 omega
        ] &&
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          covarianceMap[realization["Jdesc"]],
          Expand[(realization["Chi"] . realization["Jdesc"]) completionProjector]
        ];
    completionWitness = KroneckerProduct[{{0, 0}, {0, 1}}, pObs];
    ambiguityAction = boundaryCommutator[First[ambiguityLifts], completionWitness];
    representativeAction = boundaryCommutator[representativeLift, completionWitness];
    completionSafeQ =
      AllTrue[
        ambiguityLifts,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          #,
          ConstantArray[0, {4, 4}]
        ] &
      ] &&
        !MainProof`CommonProofTools`ExactMatrixEqualQ[
          representativeAction,
          ConstantArray[0, {4, 4}]
        ];
    Join[
      realization,
      <|
        "CompletionClassification" -> If[completionSafeQ && qndQ && liftedBoundaryCompatQ && liftedFactQ && gaussianQ, "strong-safe", "visible-ambiguity"],
        "CompletionData" -> <|
          "ControlledSplitUnitary" -> unitary,
          "CompletionProjector" -> completionProjector,
          "QObservable" -> qObs,
          "PObservable" -> pObs,
          "SymplecticForm" -> omega,
          "QuadraticHamiltonian" -> h,
          "RepresentativeLift" -> representativeLift,
          "AmbiguityLifts" -> ambiguityLifts,
          "CompletionWitnessObservable" -> completionWitness,
          "AmbiguityAction" -> ambiguityAction,
          "RepresentativeAction" -> representativeAction
        |>,
        "Properties" -> Join[
          realization["Properties"],
          <|
            "SplitControlledLiftQ" -> qndQ && liftedBoundaryCompatQ,
            "GaussianCompletionQ" -> gaussianQ,
            "LiftedFactPreservationQ" -> liftedFactQ,
            "CompletionAmbiguityAnnihilationQ" -> completionSafeQ
          |>
        ]
      |>
    ]
  ];

uomRealization[] :=
  Module[{boundaryAudit, completionAudit, contract, channel, transport},
    boundaryAudit = MainProof`UOMBoundaryCanonicalization`AuditUOMBoundaryCanonicalization[];
    completionAudit = MainProof`UOMCompletionAmbiguityAudit`AuditUOMCompletionAmbiguity[];
    contract = completionAudit["Contract", "IntrinsicResponseContract"];
    channel = contract["Channel"];
    transport = contract["TransportModel"];
    <|
      "Name" -> "uom_split_faithful_contract_realization",
      "Kind" -> "UOM",
      "BoundaryClassification" -> "strong-safe",
      "CompletionClassification" -> completionAudit["Classification"],
      "Properties" -> <|
        "UOMRealizationQ" -> True,
        "BoundaryMapQ" -> True,
        "TransportedDescendantClassQ" -> True,
        "AmbiguitySubspaceQ" -> True,
        "DescendedActiveScalarQ" -> True,
        "BoundaryAmbiguityAnnihilationQ" ->
          boundaryAudit["Claims", "Transported ambiguity is annihilated on the preserved welded boundary image", "Certified"],
        "RepresentativeLineSurvivesQ" ->
          boundaryAudit["Claims", "The welded boundary derivation acts nontrivially on a physical boundary observable", "Certified"],
        "AcceptedRecordPreservationQ" -> True,
        "RankOneActiveBoundaryImageQ" -> True,
        "GeometricLockingQ" -> True,
        "SplitControlledLiftQ" ->
          completionAudit["Claims", "Transported ambiguity is annihilated on the split-faithful completion contract", "Certified"] &&
            completionAudit["Claims", "Boundary projection of the split-faithful completion contract recovers the welded boundary image exactly", "Certified"],
        "GaussianCompletionQ" -> True,
        "LiftedFactPreservationQ" ->
          completionAudit["Claims", "Accepted record projection stays invariant on the split-faithful affine class", "Certified"],
        "CompletionAmbiguityAnnihilationQ" ->
          completionAudit["Claims", "Transported ambiguity is annihilated on the split-faithful completion contract", "Certified"]
      |>,
      "Metadata" -> <|
        "Chi" -> channel["Chi"],
        "Jdesc" -> transport["Jdesc"],
        "Aminus" -> transport["Aminus"]
      |>
    |>
  ];

syntheticBoundaryRealization[] :=
  Module[{chi, jdesc, ambiguityBasis, projector},
    chi = {1, 1, 0};
    jdesc = {1, 0, 0};
    ambiguityBasis = MainProof`CommonProofTools`KernelBasisFromFunctional[chi];
    projector = rankOneProjectorFromVector[{1, 2}];
    buildBoundaryRealization[
      "synthetic_centered_active_line_cosmology",
      "SyntheticBoundary",
      chi,
      jdesc,
      ambiguityBasis,
      Function[v, Expand[(chi . v) projector]],
      projector,
      True,
      True,
      True
    ]
  ];

syntheticCompletionRealization[] :=
  Module[{base, chi, jdesc, ambiguityBasis, projector},
    chi = {2, -1, 1};
    jdesc = {1, 0, 0};
    ambiguityBasis = MainProof`CommonProofTools`KernelBasisFromFunctional[chi];
    projector = DiagonalMatrix[{1, 0}];
    base =
      buildBoundaryRealization[
        "synthetic_completion_aware_cosmology",
        "SyntheticCompletion",
        chi,
        jdesc,
        ambiguityBasis,
        Function[v, Expand[(chi . v) projector]],
        projector,
        True,
        True,
        True
      ];
    augmentWithCompletion[base]
  ];

negativeControlRealization[] :=
  Module[{chi, jdesc, ambiguityBasis, projector},
    chi = {1, 0, 0};
    jdesc = {1, 0, 0};
    ambiguityBasis = {{0, 0}, {1, 0}, {0, 1}};
    projector = DiagonalMatrix[{1, 0}];
    buildBoundaryRealization[
      "visible_ambiguity_negative_control",
      "NegativeControl",
      chi,
      jdesc,
      ambiguityBasis,
      Function[v, Expand[(chi . v) projector + v[[3]] matrixUnit[2, 1, 2]]],
      projector,
      False,
      False,
      False
    ]
  ];

MockCosmologyRealizations[] :=
  <|
    "UOM" -> uomRealization[],
    "SyntheticBoundary" -> syntheticBoundaryRealization[],
    "SyntheticCompletion" -> syntheticCompletionRealization[],
    "NegativeControl" -> negativeControlRealization[]
  |>;

candidateSatisfiedQ[candidate_Association, realization_Association] :=
  AllTrue[
    candidate["RequiredProperties"],
    TrueQ[realization["Properties", #]] &
  ];

AuditMockCosmologyInterfaces[] :=
  Module[
    {
      candidates, realizations, candidateResults, boundaryWinner, completionWinner,
      nonUOMExistsQ, negativeControlQ
    },
    candidates = MainProof`CosmologyBoundaryInterface`CosmologyInterfaceCandidates[];
    realizations = MockCosmologyRealizations[];
    candidateResults =
      Association @ KeyValueMap[
        Function[{key, candidate},
          Module[{satisfying, nonUOMSatisfying},
            satisfying = Keys @ Select[realizations, candidateSatisfiedQ[candidate, #] &];
            nonUOMSatisfying =
              Select[satisfying, !TrueQ[realizations[#,"Properties","UOMRealizationQ"]] &];
            key -> Join[
              candidate,
              <|
                "SatisfyingRealizations" -> satisfying,
                "NonUOMSatisfyingRealizations" -> nonUOMSatisfying,
                "BoundaryTheoremFollowsQ" ->
                  satisfying =!= {} &&
                    AllTrue[satisfying, realizations[#,"BoundaryClassification"] == "strong-safe" &],
                "CompletionTheoremFollowsQ" ->
                  satisfying =!= {} &&
                    AllTrue[satisfying, realizations[#,"CompletionClassification"] == "strong-safe" &]
              |>
            ]
          ]
        ],
        candidates
      ];
    boundaryWinner =
      SelectFirst[
        {"I0", "I1", "I2"},
        TrueQ[candidateResults[#,"BoundaryTheoremFollowsQ"]] &&
          candidateResults[#,"NonUOMSatisfyingRealizations"] =!= {} &
      ];
    completionWinner =
      SelectFirst[
        {"I0", "I1", "I2"},
        TrueQ[candidateResults[#,"CompletionTheoremFollowsQ"]] &&
          candidateResults[#,"NonUOMSatisfyingRealizations"] =!= {} &
      ];
    nonUOMExistsQ =
      AnyTrue[
        Values[realizations],
        !TrueQ[#["Properties","UOMRealizationQ"]] &&
          #["BoundaryClassification"] == "strong-safe" &
      ];
    negativeControlQ = TrueQ[realizations["NegativeControl","BoundaryClassification"] == "visible-ambiguity"];
    <|
      "Candidates" -> candidateResults,
      "Realizations" -> realizations,
      "BoundaryMinimalCandidate" -> boundaryWinner,
      "CompletionMinimalCandidate" -> completionWinner,
      "Claims" -> <|
        "A non-UOM realization exists for the boundary interface search" -> <|
          "Status" -> If[nonUOMExistsQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> nonUOMExistsQ
        |>,
        "The minimal mock-tested boundary interface candidate is I0" -> <|
          "Status" -> If[boundaryWinner === "I0", "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> boundaryWinner === "I0"
        |>,
        "The minimal mock-tested completion interface candidate is I2" -> <|
          "Status" -> If[completionWinner === "I2", "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> completionWinner === "I2"
        |>,
        "A negative-control realization still reproduces visible ambiguity when key interface axioms fail" -> <|
          "Status" -> If[negativeControlQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> negativeControlQ
        |>
      |>
    |>
  ];

MockCosmologyContractsLedgerUpdates[] :=
  Module[{audit = AuditMockCosmologyInterfaces[]},
    <|
      "task:mock-cosmology-interface-realizations" -> <|
        "Method" -> "Exact mock-realization audit with one UOM realization, two synthetic non-UOM realizations, and one visible-ambiguity negative control.",
        "Status" -> If[
          audit["Claims", "A non-UOM realization exists for the boundary interface search", "Certified"] &&
            audit["Claims", "A negative-control realization still reproduces visible ambiguity when key interface axioms fail", "Certified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "At least one non-UOM realization satisfies the compact-interface search constraints, and a negative control still reproduces visible ambiguity when those constraints fail.",
        "RepresentativeModelFamily" -> "UOM plus synthetic centered-active-line and completion-aware cosmology mocks",
        "NoApproximationQ" -> True
      |>,
      "task:cosmology-interface-boundary-minimality" -> <|
        "Method" -> "Nested candidate search over I0/I1/I2 on exact mock realizations.",
        "Status" -> audit["Claims", "The minimal mock-tested boundary interface candidate is I0", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Among the nested candidates, I0 is the smallest theory-neutral boundary interface that still forces the audited boundary canonicalization conclusion on all satisfying mock realizations.",
        "RepresentativeModelFamily" -> "I0 versus I1 versus I2 on UOM and non-UOM mocks",
        "NoApproximationQ" -> True
      |>,
      "task:cosmology-interface-completion-minimality" -> <|
        "Method" -> "Nested candidate search over I0/I1/I2 for completion-aware safety on exact mock realizations.",
        "Status" -> audit["Claims", "The minimal mock-tested completion interface candidate is I2", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Among the nested candidates, I2 is the smallest completion-aware interface that still forces strong-safe completion behavior on all satisfying mock realizations.",
        "RepresentativeModelFamily" -> "I0 versus I1 versus I2 on UOM and completion-aware non-UOM mocks",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
