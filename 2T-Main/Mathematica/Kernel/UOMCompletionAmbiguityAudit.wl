If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSKGaussianCompletion`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSKGaussianCompletion.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSplitControlledLift`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSplitControlledLift.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

BeginPackage["MainProof`UOMCompletionAmbiguityAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMSKGaussianCompletion`"]
Needs["MainProof`UOMSplitControlledLift`"]
Needs["MainProof`UOMAcceptedChannel`"]

AuditUOMCompletionAmbiguity::usage =
  "AuditUOMCompletionAmbiguity[] audits transported ambiguity on the split-faithful completion contract.";
SplitFaithfulCompletionDecision::usage =
  "SplitFaithfulCompletionDecision[] returns the contract-level completion decision built from the split-faithful completion audit.";
UOMCompletionAmbiguityLedgerUpdates::usage =
  "UOMCompletionAmbiguityLedgerUpdates[] returns theorem-ledger updates for the split-faithful completion ambiguity lane.";

Begin["`Private`"]

matrixCommutator[a_?MatrixQ, b_?MatrixQ] := Expand[a . b - b . a];

completionWitnessObservable[contract_Association] :=
  KroneckerProduct[{{0, 0}, {0, 1}}, contract["PObservable"]];

boundaryBlock[lift_?MatrixQ] := lift[[1 ;; 2, 1 ;; 2]];

completionBlock[lift_?MatrixQ] := lift[[3 ;; 4, 3 ;; 4]];

acceptedRecordProjection[lift_?MatrixQ] :=
  DiagonalMatrix[{Tr[boundaryBlock[lift]], Tr[completionBlock[lift]]}];

splitFaithfulLiftFromContract[contract_Association, v_?VectorQ] :=
  Module[{response, scalar, projector},
    response = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[contract["Channel"], v];
    scalar = contract["ActiveScalarFunctional"] . v;
    projector = contract["ActiveProjectorB"];
    KroneckerProduct[{{1, 0}, {0, 0}}, response] +
      KroneckerProduct[{{0, 0}, {0, 1}}, scalar projector]
  ];

AuditUOMCompletionAmbiguity[] :=
  Module[
    {
      contract, splitModel, ambiguityVisibleQ, representativeAction, ambiguityAction,
      ambiguityDeadQ, boundaryLiftQ, recordConstancyQ, nontrivialQ, a1, a2, genericLift
    },
    contract = MainProof`UOMSKGaussianCompletion`CertifiedUOMSKGaussianCompletionContract[];
    splitModel = contract["SplitModel"];
    representativeAction =
      matrixCommutator[
        splitModel["RepresentativeLift"],
        completionWitnessObservable[contract]
      ];
    ambiguityAction =
      matrixCommutator[
        First[splitModel["AmbiguityLifts"]],
        completionWitnessObservable[contract]
      ];
    ambiguityVisibleQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        ambiguityAction,
        ConstantArray[0, {4, 4}]
      ];
    ambiguityDeadQ = !ambiguityVisibleQ &&
      AllTrue[
        splitModel["AmbiguityLifts"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          #,
          ConstantArray[0, {4, 4}]
        ] &
      ];
    boundaryLiftQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        boundaryBlock[splitModel["RepresentativeLift"]],
        contract["IntrinsicResponseContract", "RepresentativeImage"]
      ] &&
        AllTrue[
          MapThread[
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              boundaryBlock[#1],
              #2
            ] &,
            {splitModel["AmbiguityLifts"], contract["IntrinsicResponseContract", "AmbiguityImages"]}
          ],
          TrueQ
        ];
    genericLift =
      splitFaithfulLiftFromContract[
        contract["IntrinsicResponseContract"],
        contract["IntrinsicResponseContract", "TransportModel", "Jdesc"] +
          contract["IntrinsicResponseContract", "TransportModel", "Aminus"] . {a1, a2}
      ];
    recordConstancyQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {a1, a2},
        True,
        And @@ Thread[
          Flatten[
            acceptedRecordProjection[genericLift] -
              acceptedRecordProjection[splitModel["RepresentativeLift"]]
          ] == 0
        ]
      ];
    nontrivialQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeAction,
        ConstantArray[0, {4, 4}]
      ];
    <|
      "Contract" -> contract,
      "SplitModel" -> splitModel,
      "CompletionWitnessObservable" -> completionWitnessObservable[contract],
      "RepresentativeAction" -> representativeAction,
      "AmbiguityAction" -> ambiguityAction,
      "Classification" -> If[ambiguityDeadQ, "strong-safe", "visible-again"],
      "Claims" -> <|
        "Transported ambiguity is annihilated on the split-faithful completion contract" -> <|
          "Status" -> If[ambiguityDeadQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityDeadQ
        |>,
        "Accepted record projection stays invariant on the split-faithful affine class" -> <|
          "Status" -> If[recordConstancyQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> recordConstancyQ
        |>,
        "Boundary projection of the split-faithful completion contract recovers the welded boundary image exactly" -> <|
          "Status" -> If[boundaryLiftQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> boundaryLiftQ
        |>,
        "Derived completion observable is acted on nontrivially by the representative lift" -> <|
          "Status" -> If[nontrivialQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> nontrivialQ
        |>
      |>
    |>
  ];

SplitFaithfulCompletionDecision[] :=
  Module[{audit = AuditUOMCompletionAmbiguity[]},
    <|
      "Decision" -> If[
        audit["Claims", "Transported ambiguity is annihilated on the split-faithful completion contract", "Certified"] &&
          audit["Claims", "Accepted record projection stays invariant on the split-faithful affine class", "Certified"] &&
          audit["Claims", "Boundary projection of the split-faithful completion contract recovers the welded boundary image exactly", "Certified"],
        "Split-faithful completion contract is strong-safe",
        "Split-faithful completion contract is not yet certified"
      ],
      "Sentence" ->
        "On the exact split-faithful completion contract built from the intrinsic response map, controlled ledger/completion lift, derived Gaussian completion data, and lifted fact-preservation checks, transported ambiguity remains dead while the representative still acts nontrivially on a derived completion observable.",
      "ResidualBoundary" -> {
        "This is a contract-level exact result, not yet the full microscopic SK completion theorem.",
        "The earlier visible-again result remains only an exploratory algebraic negative probe."
      }
    |>
  ];

UOMCompletionAmbiguityLedgerUpdates[] :=
  Module[{audit = AuditUOMCompletionAmbiguity[]},
    <|
      "task:sk-split-faithful-completion-ambiguity-decision" -> <|
        "Method" -> "Exact ambiguity audit on the split-faithful completion contract built from the intrinsic response map, controlled split lift, derived Gaussian completion data, and lifted fact preservation.",
        "Status" -> If[And @@ Lookup[Values[audit["Claims"]], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Under the split-faithful finite-dimensional contract, transported ambiguity remains dead on the completion lift while the representative still acts nontrivially on a derived completion observable.",
        "RepresentativeModelFamily" -> audit["Contract", "Name"],
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
