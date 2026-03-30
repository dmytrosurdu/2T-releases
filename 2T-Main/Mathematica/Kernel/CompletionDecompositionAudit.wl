If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMBoundaryCanonicalization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMBoundaryCanonicalization.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedAblation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedAblation.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSplitControlledLift`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSplitControlledLift.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSKGaussianCompletion`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSKGaussianCompletion.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMCompletionAmbiguityAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMCompletionAmbiguityAudit.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`LegacyBoundaryNegativeControls`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "LegacyBoundaryNegativeControls.wl"}]];
];

BeginPackage["MainProof`CompletionDecompositionAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMBoundaryCanonicalization`"]
Needs["MainProof`UOMWeldedAblation`"]
Needs["MainProof`UOMSplitControlledLift`"]
Needs["MainProof`UOMAcceptedChannel`"]
Needs["MainProof`UOMSKGaussianCompletion`"]
Needs["MainProof`UOMCompletionAmbiguityAudit`"]
Needs["MainProof`LegacyBoundaryNegativeControls`"]

AuditCompletionDecomposition::usage =
  "AuditCompletionDecomposition[] compares boundary-only, split-only, Gaussian-only, and full completion surrogate lanes.";
CompletionDecompositionReportRows::usage =
  "CompletionDecompositionReportRows[audit] returns the case rows used by the decomposition report.";

Begin["`Private`"]

zeroMatrixLike[m_?MatrixQ] := ConstantArray[0, Dimensions[m]];

allZeroMatricesQ[mats_List] :=
  AllTrue[mats, MainProof`CommonProofTools`ExactMatrixEqualQ[#, zeroMatrixLike[#]] &];

matrixCommutator[a_?MatrixQ, b_?MatrixQ] := Expand[a . b - b . a];

directSumGaussianLift[gaussContract_Association, v_?VectorQ] :=
  Module[{intrinsic, response, scalar},
    intrinsic = gaussContract["IntrinsicResponseContract"];
    response = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[intrinsic["Channel"], v];
    scalar = intrinsic["ActiveScalarFunctional"] . v;
    ArrayFlatten[
      {
        {response, ConstantArray[0, {2, 2}]},
        {ConstantArray[0, {2, 2}], scalar gaussContract["ActiveProjector"]}
      }
    ]
  ];

gaussianOnlyCase[] :=
  Module[
    {
      gaussContract, intrinsic, ambiguityBasis, representativeLift, ambiguityLifts,
      witness, ambiguityVisibleQ, representativeNonzeroQ, boundaryCompatQ,
      gaussianQ, completionSafeQ
    },
    gaussContract = MainProof`UOMSKGaussianCompletion`CertifiedUOMSKGaussianCompletionContract[];
    intrinsic = gaussContract["IntrinsicResponseContract"];
    ambiguityBasis = Table[
      intrinsic["TransportModel", "Aminus"][[All, i]],
      {i, Dimensions[intrinsic["TransportModel", "Aminus"]][[2]]}
    ];
    representativeLift = directSumGaussianLift[gaussContract, intrinsic["TransportModel", "Jdesc"]];
    ambiguityLifts = directSumGaussianLift[gaussContract, #] & /@ ambiguityBasis;
    witness = ArrayFlatten[
      {
        {ConstantArray[0, {2, 2}], ConstantArray[0, {2, 2}]},
        {ConstantArray[0, {2, 2}], gaussContract["PObservable"]}
      }
    ];
    ambiguityVisibleQ =
      AnyTrue[
        ambiguityLifts,
        !MainProof`CommonProofTools`ExactMatrixEqualQ[
          matrixCommutator[#, witness],
          zeroMatrixLike[matrixCommutator[#, witness]]
        ] &
      ];
    representativeNonzeroQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        matrixCommutator[representativeLift, witness],
        zeroMatrixLike[matrixCommutator[representativeLift, witness]]
      ];
    boundaryCompatQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        representativeLift[[1 ;; 2, 1 ;; 2]],
        intrinsic["RepresentativeImage"]
      ] &&
        AllTrue[
          MapThread[
            MainProof`CommonProofTools`ExactMatrixEqualQ[#1[[1 ;; 2, 1 ;; 2]], #2] &,
            {ambiguityLifts, intrinsic["AmbiguityImages"]}
          ],
          TrueQ
        ];
    gaussianQ = And @@ Lookup[Values[MainProof`UOMSKGaussianCompletion`AuditUOMSKGaussianCompletion[]["Claims"]], "Certified"];
    completionSafeQ = allZeroMatricesQ[ambiguityLifts] && representativeNonzeroQ && boundaryCompatQ;
    <|
      "Name" -> "I2_gauss",
      "CaseType" -> "gaussian-only-augmentation",
      "Classification" -> If[completionSafeQ && gaussianQ, "augmentation-only", "visible-ambiguity"],
      "BoundaryCompatibleQ" -> boundaryCompatQ,
      "GaussianCertifiedQ" -> gaussianQ,
      "AlgebraicallyBenignQ" -> completionSafeQ && gaussianQ && !ambiguityVisibleQ,
      "AmbiguityVisibleQ" -> ambiguityVisibleQ,
      "AmbiguityLiftsZeroQ" -> allZeroMatricesQ[ambiguityLifts],
      "RepresentativeNonzeroQ" -> representativeNonzeroQ,
      "RepresentativeLift" -> representativeLift,
      "AmbiguityLifts" -> ambiguityLifts
    |>
  ];

splitOnlyCase[] :=
  Module[
    {
      splitAudit, model, witness, ambiguityVisibleQ, ambiguityZeroQ,
      representativeNonzeroQ, certifiedCoreQ
    },
    splitAudit = MainProof`UOMSplitControlledLift`AuditUOMSplitControlledLift[];
    model = splitAudit["Model"];
    witness = KroneckerProduct[{{0, 0}, {0, 1}}, {{0, 1}, {1, 0}}];
    ambiguityVisibleQ =
      AnyTrue[
        model["AmbiguityLifts"],
        !MainProof`CommonProofTools`ExactMatrixEqualQ[
          matrixCommutator[#, witness],
          zeroMatrixLike[matrixCommutator[#, witness]]
        ] &
      ];
    ambiguityZeroQ = allZeroMatricesQ[model["AmbiguityLifts"]];
    representativeNonzeroQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        matrixCommutator[model["RepresentativeLift"], witness],
        zeroMatrixLike[matrixCommutator[model["RepresentativeLift"], witness]]
      ];
    certifiedCoreQ = And @@ Lookup[Values[splitAudit["Claims"]], "Certified"];
    <|
      "Name" -> "I2_split",
      "CaseType" -> "split-core",
      "Classification" -> If[certifiedCoreQ && ambiguityZeroQ && representativeNonzeroQ && !ambiguityVisibleQ, "split-core-safe", "visible-ambiguity"],
      "CertifiedCoreQ" -> certifiedCoreQ,
      "AmbiguityVisibleQ" -> ambiguityVisibleQ,
      "AmbiguityLiftsZeroQ" -> ambiguityZeroQ,
      "RepresentativeNonzeroQ" -> representativeNonzeroQ,
      "Audit" -> splitAudit
    |>
  ];

AuditCompletionDecomposition[] :=
  Module[
    {
      boundaryAudit, ablationAudit, splitCase, gaussCase, fullAudit,
      negativeAudit, meaningQ, gaussianNecessaryQ
    },
    boundaryAudit = MainProof`UOMBoundaryCanonicalization`AuditUOMBoundaryCanonicalization[];
    ablationAudit = MainProof`UOMWeldedAblation`AuditUOMWeldedAblation[];
    splitCase = splitOnlyCase[];
    gaussCase = gaussianOnlyCase[];
    fullAudit = MainProof`UOMCompletionAmbiguityAudit`AuditUOMCompletionAmbiguity[];
    negativeAudit = MainProof`LegacyBoundaryNegativeControls`LegacyBoundaryNegativeControlAudit[];
    meaningQ =
      splitCase["Classification"] === "split-core-safe" &&
        gaussCase["Classification"] =!= "strong-safe";
    gaussianNecessaryQ =
      fullAudit["Classification"] === "strong-safe" &&
        splitCase["Classification"] =!= "split-core-safe";
    <|
      "BoundaryPackage" -> ablationAudit["MinimalStrongSafeHypothesisSet"],
      "Cases" -> <|
        "BoundaryOnlyBaseline" -> <|
          "Classification" -> "boundary-only",
          "BoundaryCertifiedQ" -> And @@ Lookup[Values[boundaryAudit["Claims"]], "Certified"],
          "CompletionCertifiedQ" -> False
        |>,
        "SplitOnlyCore" -> splitCase,
        "GaussianOnlyAugmentation" -> gaussCase,
        "SplitPlusBoundaryPackage" -> <|
          "Classification" ->
            If[
              splitCase["Classification"] === "split-core-safe" &&
                ablationAudit["Cases", "BaselineStrongSafe", "Classification"] === "strong-safe",
              "split-core-safe",
              "visible-ambiguity"
            ],
          "BoundaryPackageClassification" -> ablationAudit["Cases", "BaselineStrongSafe", "Classification"],
          "SplitCoreClassification" -> splitCase["Classification"]
        |>,
        "FullCurrentI2" -> <|
          "Classification" -> fullAudit["Classification"],
          "CertifiedQ" -> And @@ Lookup[Values[fullAudit["Claims"]], "Certified"]
        |>,
        "NegativeControlUnsafeLane" -> <|
          "Classification" ->
            If[negativeAudit["Claims", "Generic visible ambiguity witness persists", "Certified"], "visible-ambiguity", "not-certified"],
          "CertifiedQ" -> negativeAudit["Claims", "Generic visible ambiguity witness persists", "Certified"]
        |>
      |>,
      "Claims" -> <|
        "Boundary side remains controlled by the explicit five-piece package" -> <|
          "Status" -> If[
            ablationAudit["MinimalStrongSafeHypothesisSet", "Hypotheses"] === {
              "exact accepted-record preservation",
              "receiver band-lock",
              "one-dimensional compressed welded line",
              "co-centering",
              "descended-scalar factorization"
            },
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            ablationAudit["MinimalStrongSafeHypothesisSet", "Hypotheses"] === {
              "exact accepted-record preservation",
              "receiver band-lock",
              "one-dimensional compressed welded line",
              "co-centering",
              "descended-scalar factorization"
            }
        |>,
        "A meaningful split-core completion candidate distinct from Gaussian augmentation exists in the current surrogate lane" -> <|
          "Status" -> If[meaningQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> meaningQ
        |>,
        "Gaussian augmentation is structurally necessary for the current strong-safe completion verdict" -> <|
          "Status" -> If[gaussianNecessaryQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> gaussianNecessaryQ
        |>
      |>
    |>
  ];

CompletionDecompositionReportRows[audit_Association] :=
  {
    <|
      "Case" -> "BoundaryOnlyBaseline",
      "InternalName" -> "boundary-only",
      "Classification" -> audit["Cases", "BoundaryOnlyBaseline", "Classification"],
      "StructuralWork" -> "Boundary safe lane only; no completion witness lane claimed."
    |>,
    <|
      "Case" -> "SplitWithoutGaussian",
      "InternalName" -> audit["Cases", "SplitOnlyCore", "Name"],
      "Classification" -> audit["Cases", "SplitOnlyCore", "Classification"],
      "StructuralWork" -> "Controlled lift, QND ledger invariance, and lifted accepted-record structure without Gaussian augmentation."
    |>,
    <|
      "Case" -> "GaussianWithoutSplit",
      "InternalName" -> audit["Cases", "GaussianOnlyAugmentation", "Name"],
      "Classification" -> audit["Cases", "GaussianOnlyAugmentation", "Classification"],
      "StructuralWork" -> "Derived quadrature/covariance layer without a split-controlled ledger theorem."
    |>,
    <|
      "Case" -> "SplitPlusBoundaryPackage",
      "InternalName" -> "boundary-plus-split-core",
      "Classification" -> audit["Cases", "SplitPlusBoundaryPackage", "Classification"],
      "StructuralWork" -> "Boundary five-piece package plus split-core lift."
    |>,
    <|
      "Case" -> "FullCurrentI2",
      "InternalName" -> "I2",
      "Classification" -> audit["Cases", "FullCurrentI2", "Classification"],
      "StructuralWork" -> "Split core plus Gaussian augmentation and lifted fact-preservation checks."
    |>,
    <|
      "Case" -> "NegativeControlUnsafeLane",
      "InternalName" -> "legacy-unsafe-negative-control",
      "Classification" -> audit["Cases", "NegativeControlUnsafeLane", "Classification"],
      "StructuralWork" -> "Regression witness that visible ambiguity still persists when the contract is weakened."
    |>
  };

End[]

EndPackage[]
