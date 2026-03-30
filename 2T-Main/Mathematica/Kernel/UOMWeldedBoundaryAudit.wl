If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ActiveTransport`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ActiveTransport.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedChannel.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMFactPreservation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMFactPreservation.wl"}]];
];

BeginPackage["MainProof`UOMWeldedBoundaryAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`ActiveTransport`"]
Needs["MainProof`UOMWeldedChannel`"]
Needs["MainProof`UOMFactPreservation`"]

CertifiedUOMWeldedBoundaryModel::usage =
  "CertifiedUOMWeldedBoundaryModel[] returns the exact welded, fact-preserving boundary model induced by the certified weak-interface transport package.";
AuditUOMWeldedBoundaryModel::usage =
  "AuditUOMWeldedBoundaryModel[] reruns the transported ambiguity audit on the exact UOM welded/fact-preserving boundary channel.";
UOMWeldedBoundaryDecision::usage =
  "UOMWeldedBoundaryDecision[] returns the decision statement for the reworked UOM-faithful audit.";
UOMWeldedBoundaryLedgerUpdates::usage =
  "UOMWeldedBoundaryLedgerUpdates[] returns theorem-ledger updates for the reworked UOM boundary decision.";

Begin["`Private`"]

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

zeroLike[m_?MatrixQ] := ConstantArray[0, Dimensions[m]];

CertifiedUOMWeldedBoundaryModel[] :=
  Module[{channel, transport, basis, ambiguityImages, representativeImage, factAudit},
    channel = MainProof`UOMWeldedChannel`CertifiedWeldedChannelData[];
    transport = channel["TransportModel"];
    basis = basisColumns[transport["Aminus"]];
    ambiguityImages = MainProof`UOMWeldedChannel`WeldedScalarImage[channel, #] & /@ basis;
    representativeImage = MainProof`UOMWeldedChannel`WeldedScalarImage[channel, transport["Jdesc"]];
    factAudit = MainProof`UOMFactPreservation`AuditUOMFactPreservation[Length[transport["Jdesc"]]];
    <|
      "Channel" -> channel,
      "TransportModel" -> transport,
      "AminusBasisVectors" -> basis,
      "AminusBoundaryImages" -> ambiguityImages,
      "RepresentativeBoundaryImage" -> representativeImage,
      "FactPreservationAudit" -> factAudit
    |>
  ];

AuditUOMWeldedBoundaryModel[] :=
  Module[{model, channel, transport, ambiguityZeroQ, repQ, factQ},
    model = CertifiedUOMWeldedBoundaryModel[];
    channel = model["Channel"];
    transport = model["TransportModel"];
    ambiguityZeroQ =
      AllTrue[
        model["AminusBoundaryImages"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[#, zeroLike[channel["ProfileProjectorB"]]] &
      ];
    repQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        model["RepresentativeBoundaryImage"],
        channel["Epsilon"] channel["ProfileProjectorB"]
      ] &&
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        model["RepresentativeBoundaryImage"],
        zeroLike[channel["ProfileProjectorB"]]
      ];
    factQ = And @@ Lookup[Values[model["FactPreservationAudit", "Claims"]], "Certified"];
    <|
      "Model" -> model,
      "Claims" -> <|
        "Transported ambiguity vanishes on the exact welded boundary channel" -> <|
          "Status" -> If[ambiguityZeroQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityZeroQ
        |>,
        "Boundary image of the class representative is the nonzero epsilon-weighted welded LoG line" -> <|
          "Status" -> If[repQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> repQ
        |>,
        "Exact sub-cutoff fact preservation is enforced on the accepted record algebra" -> <|
          "Status" -> If[factQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> factQ
        |>,
        "Old visible ambiguity witness is excluded by UOM welded/fact-preserving constraints" -> <|
          "Status" -> If[
            model["Channel", "TransportModel", "Name"] === "certified_polynomial_branch" &&
              MainProof`UOMWeldedChannel`AuditUOMWeldedChannel[]["Claims", "Legacy unsafe surrogate witness is incompatible with the welded line", "Certified"],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            MainProof`UOMWeldedChannel`AuditUOMWeldedChannel[]["Claims", "Legacy unsafe surrogate witness is incompatible with the welded line", "Certified"]
        |>
      |>
    |>
  ];

UOMWeldedBoundaryDecision[] :=
  Module[{audit = AuditUOMWeldedBoundaryModel[], claims},
    claims = audit["Claims"];
    <|
      "Decision" -> If[
        And @@ Lookup[Values[claims], "Certified"],
        "UOM-welded boundary-safe",
        "UOM-welded boundary-not-yet-certified"
      ],
      "Sentence" -> If[
        And @@ Lookup[Values[claims], "Certified"],
        "On the exact co-centered, band-locked welded LoG boundary channel with exact accepted-record preservation, the transported ambiguity class is annihilated on the physical boundary image; the earlier visible ambiguity countermodels were artifacts of generic splitBlock and generic A⊗B realization choices.",
        "The exact UOM welded/fact-preserving boundary audit did not fully certify the annihilation of transported ambiguity on the physical boundary image."
      ],
      "ResidualBoundary" -> {
        "This reworked decision is about the preserved compiled/welded boundary image, not the full unreduced completion-sector operator algebra.",
        "A full operator-level reconstruction of the Gaussian completion-sector dynamics from the SK kernels remains downstream."
      }
    |>
  ];

UOMWeldedBoundaryLedgerUpdates[] :=
  Module[{audit = AuditUOMWeldedBoundaryModel[], decision = UOMWeldedBoundaryDecision[]},
    <|
      "task:uom-transported-welded-boundary-audit" -> <|
        "Method" -> "Exact re-audit using the descended dominant scalar, the one-dimensional compressed welded LoG channel, and exact accepted-record preservation below cutoff.",
        "Status" -> If[
          And @@ Lookup[Values[audit["Claims"]], "Certified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Transported ambiguity basis is annihilated on the exact welded/fact-preserving boundary image, while the class representative survives as the epsilon-weighted welded LoG line.",
        "RepresentativeModelFamily" -> "Certified active-transport export + exact compressed welded LoG line + exact accepted-record projection",
        "NoApproximationQ" -> True
      |>,
      "task:uom-welded-boundary-decision" -> <|
        "Method" -> "Exact comparison between the old generic split surrogate and the reworked UOM welded/fact-preserving boundary image.",
        "Status" -> If[
          decision["Decision"] === "UOM-welded boundary-safe",
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> decision["Sentence"],
        "RepresentativeModelFamily" -> "Reworked UOM welded boundary lane",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
