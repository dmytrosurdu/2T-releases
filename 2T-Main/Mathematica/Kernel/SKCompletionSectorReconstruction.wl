If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMBoundaryCanonicalization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMBoundaryCanonicalization.wl"}]];
];

BeginPackage["MainProof`SKCompletionSectorReconstruction`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMBoundaryCanonicalization`"]

CertifiedMinimalCompletionModel::usage =
  "CertifiedMinimalCompletionModel[] returns the exploratory exact algebraic completion lift compatible with the welded boundary block.";
AuditSKCompletionSectorReconstruction::usage =
  "AuditSKCompletionSectorReconstruction[] classifies ambiguity on the exploratory exact algebraic completion lift.";
SKCompletionSectorLedgerUpdates::usage =
  "SKCompletionSectorLedgerUpdates[] returns theorem-ledger updates for the exploratory completion-sector lane.";

Begin["`Private`"]

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

boundaryProjection[x_?MatrixQ] := x[[1 ;; 2, 1 ;; 2]];

embedBoundaryBlock[block_?MatrixQ] :=
  ArrayFlatten[{{block, ConstantArray[0, {2, 1}]}, {ConstantArray[0, {1, 2}], {{0}}}}];

liftedImage[channel_Association, vector_?VectorQ, extraFunctional_?VectorQ] :=
  Module[{boundary = channel["BoundaryGenerator"], scalarBoundary, scalarCompletion},
    scalarBoundary = channel["Channel", "Chi"] . vector;
    scalarCompletion = extraFunctional . vector;
    ArrayFlatten[
      {
        {scalarBoundary channel["Channel", "ProfileProjectorB"], ConstantArray[0, {2, 1}]},
        {ConstantArray[0, {1, 2}], {{scalarCompletion}}}
      }
    ]
  ];

completionCommutator[j_?MatrixQ, x_?MatrixQ] := Expand[j . x - x . j];

CertifiedMinimalCompletionModel[] :=
  Module[{canonicalModel, channel, transport, basis, extraFunctional, representativeLift, ambiguityLifts},
    canonicalModel = MainProof`UOMBoundaryCanonicalization`CertifiedUOMBoundaryCanonicalizationModel[];
    channel = canonicalModel;
    transport = canonicalModel["TransportModel"];
    basis = basisColumns[transport["Aminus"]];
    extraFunctional = {1, 0, 0};
    representativeLift = liftedImage[channel, transport["Jdesc"], extraFunctional];
    ambiguityLifts = liftedImage[channel, #, extraFunctional] & /@ basis;
    <|
      "Name" -> "exploratory_algebraic_completion_visible_again_model",
      "CanonicalBoundaryModel" -> canonicalModel,
      "TransportModel" -> transport,
      "ExtraCompletionFunctional" -> extraFunctional,
      "RepresentativeLift" -> representativeLift,
      "AmbiguityLifts" -> ambiguityLifts,
      "BoundaryGeneratorLift" -> representativeLift,
      "CompletionWitnessObservable" -> matrixUnit[3, 1, 3]
    |>
  ];

AuditSKCompletionSectorReconstruction[] :=
  Module[{model, ambiguityVisibleQ, completionAction, boundaryLiftQ, reconstructionQ},
    model = CertifiedMinimalCompletionModel[];
    completionAction =
      completionCommutator[
        First[model["AmbiguityLifts"]],
        model["CompletionWitnessObservable"]
      ];
    ambiguityVisibleQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        completionAction,
        ConstantArray[0, {3, 3}]
      ];
    boundaryLiftQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        boundaryProjection[model["RepresentativeLift"]],
        model["CanonicalBoundaryModel", "BoundaryGenerator"]
      ] &&
        AllTrue[
          MapThread[
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              boundaryProjection[#1],
              #2
            ] &,
            {model["AmbiguityLifts"], model["CanonicalBoundaryModel", "AminusBoundaryImages"]}
          ],
          TrueQ
        ];
    reconstructionQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        boundaryProjection[model["RepresentativeLift"]],
        model["CanonicalBoundaryModel", "BoundaryGenerator"]
      ] &&
        Length[model["AmbiguityLifts"]] == Dimensions[model["TransportModel", "Aminus"]][[2]];
    <|
      "Model" -> model,
      "CompletionActionWitness" -> completionAction,
      "Classification" -> If[ambiguityVisibleQ, "visible-again", "strong-safe"],
      "Claims" -> <|
        "Exploratory exact algebraic completion lift is reconstructed" -> <|
          "Status" -> If[reconstructionQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> reconstructionQ
        |>,
        "Ambiguity becomes visible again on the exploratory algebraic completion lift" -> <|
          "Status" -> If[ambiguityVisibleQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityVisibleQ
        |>,
        "Boundary projection of the completion lift recovers the welded boundary image exactly" -> <|
          "Status" -> If[boundaryLiftQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> boundaryLiftQ
        |>
      |>
    |>
  ];

SKCompletionSectorLedgerUpdates[] :=
  Module[{audit = AuditSKCompletionSectorReconstruction[], claims},
    claims = audit["Claims"];
    <|
      "task:sk-minimal-gaussian-completion-reconstruction" -> <|
        "Method" -> "Exact exploratory algebraic lift of the welded boundary block by a single appended completion-sector mode.",
        "Status" -> claims["Exploratory exact algebraic completion lift is reconstructed", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "An exploratory exact algebraic completion lift of the welded boundary block is reconstructed.",
        "RepresentativeModelFamily" -> audit["Model", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:sk-completion-ambiguity-visibility" -> <|
        "Method" -> "Exact commutator audit of transported ambiguity on the exploratory algebraic completion lift.",
        "Status" -> claims["Ambiguity becomes visible again on the exploratory algebraic completion lift", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "In the exploratory exact algebraic completion lift, ambiguity is classified as visible-again; this is not yet a split-faithful completion verdict.",
        "RepresentativeModelFamily" -> audit["Model", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:sk-completion-boundary-lift" -> <|
        "Method" -> "Exact boundary-projection compatibility audit for the exploratory completion-sector lift.",
        "Status" -> claims["Boundary projection of the completion lift recovers the welded boundary image exactly", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Projecting the exploratory completion model back to the boundary recovers the certified welded boundary image exactly.",
        "RepresentativeModelFamily" -> audit["Model", "Name"],
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
