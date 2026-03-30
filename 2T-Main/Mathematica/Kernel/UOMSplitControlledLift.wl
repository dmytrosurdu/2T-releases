If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMIntrinsicResponseMap`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMIntrinsicResponseMap.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

BeginPackage["MainProof`UOMSplitControlledLift`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMIntrinsicResponseMap`"]
Needs["MainProof`UOMAcceptedChannel`"]

CertifiedSplitControlledLift::usage =
  "CertifiedSplitControlledLift[] returns the exact finite-dimensional A|B split-controlled lift built from the intrinsic response contract.";
AuditUOMSplitControlledLift::usage =
  "AuditUOMSplitControlledLift[] certifies the ledger-control/QND structure and exact boundary compatibility of the split-faithful lift.";
UOMSplitControlledLiftLedgerUpdates::usage =
  "UOMSplitControlledLiftLedgerUpdates[] returns theorem-ledger updates for the split-controlled lift lane.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

ledgerProjectors[] := {matrixUnit[2, 1, 1], matrixUnit[2, 2, 2]};

controlledSplitUnitary[] :=
  Module[{pi1, pi2, u1, u2},
    {pi1, pi2} = ledgerProjectors[];
    u1 = IdentityMatrix[2];
    u2 = DiagonalMatrix[{1, -1}];
    KroneckerProduct[pi1, u1] + KroneckerProduct[pi2, u2]
  ];

boundaryBlock[lift_?MatrixQ] := lift[[1 ;; 2, 1 ;; 2]];

completionBlock[lift_?MatrixQ] := lift[[3 ;; 4, 3 ;; 4]];

acceptedRecordProjection[lift_?MatrixQ] :=
  DiagonalMatrix[{Tr[boundaryBlock[lift]], Tr[completionBlock[lift]]}];

splitFaithfulLift[contract_Association, v_?VectorQ] :=
  Module[{response, scalar, projector, pi1, pi2},
    response = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[contract["Channel"], v];
    scalar = contract["ActiveScalarFunctional"] . v;
    projector = contract["ActiveProjectorB"];
    {pi1, pi2} = ledgerProjectors[];
    KroneckerProduct[pi1, response] + KroneckerProduct[pi2, scalar projector]
  ];

CertifiedSplitControlledLift[] :=
  Module[{contract, ambiguityBasis, ambiguityLifts},
    contract = MainProof`UOMIntrinsicResponseMap`CertifiedIntrinsicResponseContract[];
    ambiguityBasis = contract["AmbiguityBasis"];
    ambiguityLifts = (splitFaithfulLift[contract, #] &) /@ ambiguityBasis;
    <|
      "Name" -> "uom_split_controlled_lift_contract",
      "IntrinsicResponseContract" -> contract,
      "LedgerProjectors" -> ledgerProjectors[],
      "ControlledSplitUnitary" -> controlledSplitUnitary[],
      "RepresentativeLift" -> splitFaithfulLift[contract, contract["TransportModel", "Jdesc"]],
      "AmbiguityLifts" -> ambiguityLifts
    |>
  ];

AuditUOMSplitControlledLift[] :=
  Module[
    {
      model, contract, pi1, pi2, unitary, qndQ, boundaryCompatQ,
      ambiguityRecordQ, representativeNonzeroQ, a1, a2, genericLift, recordConstancyQ
    },
    model = CertifiedSplitControlledLift[];
    contract = model["IntrinsicResponseContract"];
    {pi1, pi2} = model["LedgerProjectors"];
    unitary = model["ControlledSplitUnitary"];
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
    boundaryCompatQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        boundaryBlock[model["RepresentativeLift"]],
        contract["RepresentativeImage"]
      ] &&
        AllTrue[
          MapThread[
            MainProof`CommonProofTools`ExactMatrixEqualQ[boundaryBlock[#1], #2] &,
            {model["AmbiguityLifts"], contract["AmbiguityImages"]}
          ],
          TrueQ
        ];
    ambiguityRecordQ =
      AllTrue[
        model["AmbiguityLifts"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          acceptedRecordProjection[#],
          ConstantArray[0, {2, 2}]
        ] &
      ];
    genericLift =
      splitFaithfulLift[
        contract,
        contract["TransportModel", "Jdesc"] + contract["TransportModel", "Aminus"] . {a1, a2}
      ];
    recordConstancyQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {a1, a2},
        True,
        And @@ Thread[
          Flatten[
            acceptedRecordProjection[genericLift] -
              acceptedRecordProjection[model["RepresentativeLift"]]
          ] == 0
        ]
      ];
    representativeNonzeroQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        model["RepresentativeLift"],
        ConstantArray[0, {4, 4}]
      ];
    <|
      "Model" -> model,
      "GenericLift" -> genericLift,
      "Claims" -> <|
        "Controlled split unitary is QND on the inherited ledger projectors" -> <|
          "Status" -> If[qndQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> qndQ
        |>,
        "Split-faithful lift recovers the intrinsic welded response on the boundary block" -> <|
          "Status" -> If[boundaryCompatQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> boundaryCompatQ
        |>,
        "Accepted record projection is invariant under transported ambiguity on the split-faithful lift" -> <|
          "Status" -> If[ambiguityRecordQ && recordConstancyQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityRecordQ && recordConstancyQ
        |>,
        "Representative lift is nontrivial on the split-faithful space" -> <|
          "Status" -> If[representativeNonzeroQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> representativeNonzeroQ
        |>
      |>
    |>
  ];

UOMSplitControlledLiftLedgerUpdates[] :=
  Module[{audit = AuditUOMSplitControlledLift[], claims},
    claims = audit["Claims"];
    <|
      "task:sk-split-controlled-lift-contract" -> <|
        "Method" -> "Exact tensor-product A|B lift built from the intrinsic response contract, together with QND commutation and accepted-record invariance checks.",
        "Status" -> If[And @@ Lookup[Values[claims], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "The split-faithful completion lift carries an explicit classical-control/QND ledger structure while preserving the accepted record under transported ambiguity.",
        "RepresentativeModelFamily" -> audit["Model", "Name"],
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
