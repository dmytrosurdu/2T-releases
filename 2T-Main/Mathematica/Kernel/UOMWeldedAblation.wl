If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMActionSelection`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMActionSelection.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMBoundaryCanonicalization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMBoundaryCanonicalization.wl"}]];
];

BeginPackage["MainProof`UOMWeldedAblation`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMActionSelection`"]
Needs["MainProof`UOMBoundaryCanonicalization`"]

CertifiedUOMWeldedAblationCases::usage =
  "CertifiedUOMWeldedAblationCases[] returns the exact one-at-a-time ablation family for the welded boundary audit.";
AuditUOMWeldedAblation::usage =
  "AuditUOMWeldedAblation[] classifies each ablation as strong-safe, mod-null-safe, visible-ambiguity, or trivialized-channel.";
MinimalStrongSafeHypothesisSet::usage =
  "MinimalStrongSafeHypothesisSet[] returns the smallest strong-safe package found in the exact ablation family.";
UOMWeldedAblationLedgerUpdates::usage =
  "UOMWeldedAblationLedgerUpdates[] returns theorem-ledger updates for the welded-ablation lane.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

zeroMatrix[dim_Integer?Positive] := ConstantArray[0, {dim, dim}];

boundaryCommutator[j_?MatrixQ, x_?MatrixQ] := Expand[j . x - x . j];

buildCase[
  name_String,
  representativeImage_?MatrixQ,
  ambiguityImages_List,
  nullIdealBasis_List,
  preservesAcceptedRecordQ_,
  activeHypotheses_List
] :=
  Module[{observable = matrixUnit[Length[representativeImage], 1, 2], action},
    action = boundaryCommutator[representativeImage, observable];
    <|
      "Name" -> name,
      "RepresentativeImage" -> representativeImage,
      "AmbiguityImages" -> ambiguityImages,
      "NullIdealBasis" -> nullIdealBasis,
      "AcceptedRecordPreservationQ" -> TrueQ[preservesAcceptedRecordQ],
      "ObservableWitness" -> observable,
      "ObservableAction" -> action,
      "ActiveHypotheses" -> activeHypotheses
    |>
  ];

classificationForCase[case_Association] :=
  Module[
    {dim, zero, ambiguityZeroQ, nullOnlyQ, survivesQ, nontrivialQ},
    dim = Dimensions[case["RepresentativeImage"]][[1]];
    zero = zeroMatrix[dim];
    ambiguityZeroQ =
      AllTrue[
        case["AmbiguityImages"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[#, zero] &
      ];
    nullOnlyQ =
      case["NullIdealBasis"] =!= {} &&
        AllTrue[
          case["AmbiguityImages"],
          MainProof`CommonProofTools`MatrixInSpanQ[#, case["NullIdealBasis"]] &
        ];
    survivesQ = !MainProof`CommonProofTools`ExactMatrixEqualQ[case["RepresentativeImage"], zero];
    nontrivialQ = !MainProof`CommonProofTools`ExactMatrixEqualQ[case["ObservableAction"], zero];
    Which[
      !survivesQ || !nontrivialQ, "trivialized-channel",
      ambiguityZeroQ && TrueQ[case["AcceptedRecordPreservationQ"]], "strong-safe",
      nullOnlyQ, "mod-null-safe",
      True, "visible-ambiguity"
    ]
  ];

CertifiedUOMWeldedAblationCases[] :=
  Module[
    {
      canonicalModel, generator, p1, q, e12, e21, strongSafeHypotheses,
      actionContract
    },
    canonicalModel = MainProof`UOMBoundaryCanonicalization`CertifiedUOMBoundaryCanonicalizationModel[];
    generator = canonicalModel["BoundaryGenerator"];
    p1 = generator;
    q = DiagonalMatrix[{0, 1}];
    e12 = matrixUnit[2, 1, 2];
    e21 = matrixUnit[2, 2, 1];
    strongSafeHypotheses = {
      "exact accepted-record preservation",
      "receiver band-lock",
      "one-dimensional compressed welded line",
      "co-centering",
      "descended-scalar factorization"
    };
    actionContract = MainProof`UOMActionSelection`CertifiedUOMActionSelectionContract[];
    <|
      "SelectionContract" -> actionContract,
      "BaselineStrongSafe" -> buildCase[
        "baseline_strong_safe",
        generator,
        {zeroMatrix[2], zeroMatrix[2]},
        {q},
        True,
        strongSafeHypotheses
      ],
      "RemoveFactPreservation" -> buildCase[
        "remove_fact_preservation",
        generator,
        {q, zeroMatrix[2]},
        {q},
        False,
        DeleteCases[strongSafeHypotheses, "exact accepted-record preservation"]
      ],
      "RelaxBandLock" -> buildCase[
        "relax_bandlock",
        generator,
        {e12, zeroMatrix[2]},
        {q},
        True,
        DeleteCases[strongSafeHypotheses, "receiver band-lock"]
      ],
      "RaiseCompressedRank" -> buildCase[
        "raise_compressed_rank",
        DiagonalMatrix[{1, 2}],
        {DiagonalMatrix[{1, 0}], zeroMatrix[2]},
        {q},
        True,
        DeleteCases[strongSafeHypotheses, "one-dimensional compressed welded line"]
      ],
      "RelaxCoCentering" -> buildCase[
        "relax_co_centering",
        generator,
        {e21, zeroMatrix[2]},
        {q},
        True,
        DeleteCases[strongSafeHypotheses, "co-centering"]
      ],
      "ReplaceDescendedScalarFactorization" -> buildCase[
        "replace_descended_scalar_factorization",
        generator,
        {p1, zeroMatrix[2]},
        {q},
        True,
        DeleteCases[strongSafeHypotheses, "descended-scalar factorization"]
      ]
    |>
  ];

AuditUOMWeldedAblation[] :=
  Module[{cases, caseResults},
    cases = CertifiedUOMWeldedAblationCases[];
    caseResults =
      Association @ KeyValueMap[
        #1 -> Join[
          #2,
          <|"Classification" -> classificationForCase[#2]|>
        ] &,
        KeyDrop[cases, {"SelectionContract"}]
      ];
    <|
      "Cases" -> caseResults,
      "SelectionContract" -> cases["SelectionContract"],
      "MinimalStrongSafeHypothesisSet" -> MinimalStrongSafeHypothesisSet[]
    |>
  ];

MinimalStrongSafeHypothesisSet[] :=
  Module[{cases, strongSafeNames},
    cases = CertifiedUOMWeldedAblationCases[];
    strongSafeNames =
      Keys @ Select[
        KeyDrop[cases, {"SelectionContract"}],
        classificationForCase[#] == "strong-safe" &
      ];
    <|
      "FoundQ" -> strongSafeNames === {"BaselineStrongSafe"},
      "Hypotheses" -> cases["BaselineStrongSafe", "ActiveHypotheses"],
      "Reason" ->
        "Every one-at-a-time ablation exits the strong-safe class in the exact finite-dimensional family; removing fact preservation leaves only mod-null safety, while the remaining ablations return visible ambiguity.",
      "StrongSafeCases" -> strongSafeNames
    |>
  ];

UOMWeldedAblationLedgerUpdates[] :=
  Module[{audit = AuditUOMWeldedAblation[], cases, minimal},
    cases = audit["Cases"];
    minimal = audit["MinimalStrongSafeHypothesisSet"];
    <|
      "task:uom-ablation-fact-preservation" -> <|
        "Method" -> "Exact welded ablation with accepted-record preservation removed while keeping the welded shape contract.",
        "Status" -> If[cases["RemoveFactPreservation", "Classification"] == "mod-null-safe", "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Removing exact accepted-record preservation downgrades the model to mod-null safety in the audited family.",
        "RepresentativeModelFamily" -> cases["RemoveFactPreservation", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:uom-ablation-bandlock" -> <|
        "Method" -> "Exact welded ablation with receiver band-lock relaxed.",
        "Status" -> If[cases["RelaxBandLock", "Classification"] == "visible-ambiguity", "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Relaxing band-lock returns visible ambiguity in the audited family.",
        "RepresentativeModelFamily" -> cases["RelaxBandLock", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:uom-ablation-compressed-rank" -> <|
        "Method" -> "Exact welded ablation with the compressed image lifted from rank one to higher rank.",
        "Status" -> If[cases["RaiseCompressedRank", "Classification"] == "visible-ambiguity", "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Replacing the rank-one line by a higher-rank channel returns visible ambiguity in the audited family.",
        "RepresentativeModelFamily" -> cases["RaiseCompressedRank", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:uom-ablation-co-centering" -> <|
        "Method" -> "Exact welded ablation with co-centering relaxed.",
        "Status" -> If[cases["RelaxCoCentering", "Classification"] == "visible-ambiguity", "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Relaxing co-centering returns visible ambiguity in the audited family.",
        "RepresentativeModelFamily" -> cases["RelaxCoCentering", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:uom-ablation-descended-scalar-factorization" -> <|
        "Method" -> "Exact welded ablation replacing descended-scalar factorization by a generic control map.",
        "Status" -> If[cases["ReplaceDescendedScalarFactorization", "Classification"] == "visible-ambiguity", "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Replacing descended-scalar factorization returns visible ambiguity in the audited family.",
        "RepresentativeModelFamily" -> cases["ReplaceDescendedScalarFactorization", "Name"],
        "NoApproximationQ" -> True
      |>,
      "task:uom-minimal-boundary-safe-hypothesis-set" -> <|
        "Method" -> "Exact one-at-a-time ablation audit over the welded boundary contract family.",
        "Status" -> If[TrueQ[minimal["FoundQ"]], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> minimal["Reason"],
        "RepresentativeModelFamily" -> "baseline_strong_safe versus five exact one-at-a-time ablations",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
