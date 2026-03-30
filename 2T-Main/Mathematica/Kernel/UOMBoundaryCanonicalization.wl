If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`CanonicalRepresentative`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CanonicalRepresentative.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`TransportedBoundaryAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "TransportedBoundaryAudit.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMPulseCharacterization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMPulseCharacterization.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMActionSelection`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMActionSelection.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedBoundaryAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedBoundaryAudit.wl"}]];
];

BeginPackage["MainProof`UOMBoundaryCanonicalization`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`CanonicalRepresentative`"]
Needs["MainProof`TransportedBoundaryAudit`"]
Needs["MainProof`UOMPulseCharacterization`"]
Needs["MainProof`UOMAcceptedChannel`"]
Needs["MainProof`UOMActionSelection`"]
Needs["MainProof`UOMWeldedBoundaryAudit`"]

CertifiedUOMBoundaryCanonicalizationModel::usage =
  "CertifiedUOMBoundaryCanonicalizationModel[] returns the exact preserved welded boundary model used for the compressed UOM contract-level boundary corollary.";
AuditUOMBoundaryCanonicalization::usage =
  "AuditUOMBoundaryCanonicalization[] certifies ambiguity annihilation, representative-independence, calibration invariance, and nontriviality on the preserved welded boundary image.";
UOMBoundaryCanonicalizationDecision::usage =
  "UOMBoundaryCanonicalizationDecision[] returns the compressed UOM contract-level welded boundary canonicalization statement.";
UOMBoundaryCanonicalizationLedgerUpdates::usage =
  "UOMBoundaryCanonicalizationLedgerUpdates[] returns theorem-ledger updates for the welded boundary canonicalization lane.";

Begin["`Private`"]

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

zeroLike[m_?MatrixQ] := ConstantArray[0, Dimensions[m]];

boundaryCommutator[j_?MatrixQ, x_?MatrixQ] := Expand[j . x - x . j];

calibrationWitnessData[channel_Association] :=
  Module[{transport, u, j0, b1, b2, rep1, rep2},
    transport = channel["TransportModel"];
    u = transport["Aminus"];
    j0 = transport["Jdesc"] + u . {1, -1};
    b1 = IdentityMatrix[Length[transport["Jdesc"]]];
    b2 = {{2, 0, 1}, {0, 3, 1}, {1, 1, 5}};
    rep1 =
      MainProof`CanonicalRepresentative`CanonicalRepresentativeData[
        u,
        b1,
        j0,
        "Chi" -> channel["Chi"],
        "Epsilon" -> channel["Epsilon"]
      ];
    rep2 =
      MainProof`CanonicalRepresentative`CanonicalRepresentativeData[
        u,
        b2,
        j0,
        "Chi" -> channel["Chi"],
        "Epsilon" -> channel["Epsilon"]
      ];
    <|
      "SeedRepresentative" -> j0,
      "Calibration1" -> rep1,
      "Calibration2" -> rep2,
      "CalibrationMatrices" -> <|"B1" -> b1, "B2" -> b2|>
    |>
  ];

CertifiedUOMBoundaryCanonicalizationModel[] :=
  Module[
    {
      boundaryAudit, channel, transport, basis, calibrationData,
      observableWitness, genericObservable, ambiguityImages, generator
    },
    boundaryAudit = MainProof`UOMWeldedBoundaryAudit`AuditUOMWeldedBoundaryModel[];
    channel = boundaryAudit["Model", "Channel"];
    transport = boundaryAudit["Model", "TransportModel"];
    basis = basisColumns[transport["Aminus"]];
    calibrationData = calibrationWitnessData[channel];
    observableWitness = {{0, 1}, {0, 0}};
    genericObservable = Array[x, {2, 2}];
    ambiguityImages = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, #] & /@ basis;
    generator = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, transport["Jdesc"]];
    <|
      "BoundaryAudit" -> boundaryAudit,
      "PulseAudit" -> MainProof`UOMPulseCharacterization`AuditUOMPulseCharacterization[],
      "AcceptedChannelAudit" -> MainProof`UOMAcceptedChannel`AuditUOMAcceptedChannel[],
      "ActionSelectionAudit" -> MainProof`UOMActionSelection`AuditUOMActionSelection[],
      "LegacyTransportedAudit" -> MainProof`TransportedBoundaryAudit`RunTransportedBoundaryAuditSuite[],
      "Channel" -> channel,
      "TransportModel" -> transport,
      "AminusBasisVectors" -> basis,
      "AminusBoundaryImages" -> ambiguityImages,
      "BoundaryGenerator" -> generator,
      "ObservableWitness" -> observableWitness,
      "GenericObservable" -> genericObservable,
      "CalibrationData" -> calibrationData
    |>
  ];

AuditUOMBoundaryCanonicalization[] :=
  Module[
    {
      model, channel, transport, generator, ambiguityZeroQ, genericConstancyQ,
      a1, a2, genericShiftedGenerator, classDefinedQ, calibrationData, calibrationQ,
      calibrationImages, nontrivialQ, observableAction, legacyVisibleQ
    },
    model = CertifiedUOMBoundaryCanonicalizationModel[];
    channel = model["Channel"];
    transport = model["TransportModel"];
    generator = model["BoundaryGenerator"];
    ambiguityZeroQ =
      AllTrue[
        model["AminusBoundaryImages"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[#, zeroLike[generator]] &
      ];
    genericConstancyQ =
      MainProof`CommonProofTools`AffineClassConstantQ[
        channel["Chi"],
        transport["Jdesc"],
        transport["Aminus"],
        channel["Epsilon"]
      ];
    genericShiftedGenerator =
      Expand[
        (channel["Chi"] . (transport["Jdesc"] + transport["Aminus"] . {a1, a2})) channel["ProfileProjectorB"]
      ];
    classDefinedQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        boundaryCommutator[genericShiftedGenerator, model["GenericObservable"]] -
          boundaryCommutator[generator, model["GenericObservable"]],
        zeroLike[generator]
      ];
    calibrationData = model["CalibrationData"];
    calibrationImages =
      MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, #["Jcan"]] & /@
        Values[KeyTake[calibrationData, {"Calibration1", "Calibration2"}]];
    calibrationQ =
      !MainProof`CommonProofTools`ExactVectorEqualQ[
        calibrationData["Calibration1", "Jcan"],
        calibrationData["Calibration2", "Jcan"]
      ] &&
        AllTrue[
          calibrationImages,
          MainProof`CommonProofTools`ExactMatrixEqualQ[#, generator] &
        ];
    observableAction = boundaryCommutator[generator, model["ObservableWitness"]];
    nontrivialQ = !MainProof`CommonProofTools`ExactMatrixEqualQ[observableAction, zeroLike[generator]];
    legacyVisibleQ =
      Length[
        model["LegacyTransportedAudit", "TransportedUnsafeWitness", "StateInvisibleAudit", "VisibleBasisIndices"]
      ] > 0;
    <|
      "Model" -> model,
      "GenericShiftedGenerator" -> genericShiftedGenerator,
      "CalibrationImages" -> calibrationImages,
      "ObservableAction" -> observableAction,
      "Claims" -> <|
        "Transported ambiguity is annihilated on the preserved welded boundary image" -> <|
          "Status" -> If[ambiguityZeroQ && genericConstancyQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityZeroQ && genericConstancyQ
        |>,
        "The induced welded boundary derivation is representative-independent" -> <|
          "Status" -> If[classDefinedQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> classDefinedQ
        |>,
        "Calibration changes are exact on the welded boundary image" -> <|
          "Status" -> If[calibrationQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> calibrationQ
        |>,
        "The welded boundary derivation acts nontrivially on a physical boundary observable" -> <|
          "Status" -> If[nontrivialQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> nontrivialQ
        |>,
        "Generic legacy countermodels are excluded precisely by the welded/fact-preserving contract" -> <|
          "Status" -> If[legacyVisibleQ && model["BoundaryAudit", "Claims", "Old visible ambiguity witness is excluded by UOM welded/fact-preserving constraints", "Certified"], "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> legacyVisibleQ && model["BoundaryAudit", "Claims", "Old visible ambiguity witness is excluded by UOM welded/fact-preserving constraints", "Certified"]
        |>
      |>
    |>
  ];

UOMBoundaryCanonicalizationDecision[] :=
  Module[{audit = AuditUOMBoundaryCanonicalization[], claims},
    claims = audit["Claims"];
    <|
      "Decision" -> If[
        And @@ Lookup[
          Values @ KeyTake[
            claims,
            {
              "Transported ambiguity is annihilated on the preserved welded boundary image",
              "The induced welded boundary derivation is representative-independent",
              "Calibration changes are exact on the welded boundary image",
              "The welded boundary derivation acts nontrivially on a physical boundary observable"
            }
          ],
          "Certified"
        ],
        "Compressed UOM contract-level boundary corollary certified",
        "Compressed UOM contract-level boundary corollary not yet certified"
      ],
      "Sentence" ->
        "Under the exact compressed welded-channel contract, transported ambiguity is annihilated on the preserved welded boundary image, the induced boundary derivation is representative-independent there, calibration changes are invisible after welded projection, and the surviving class line still acts nontrivially on the compiled physical boundary algebra.",
      "ResidualBoundary" -> {
        "The certificate is about the preserved compiled/welded boundary image only.",
        "The upstream welded/accepted-channel lane is still an exact finite-dimensional contract surrogate rather than a full pulse/export/uplift reconstruction.",
        "Extension to the full unreduced completion-sector operator algebra remains open and is treated separately in the exploratory and split-faithful completion lanes."
      }
    |>
  ];

UOMBoundaryCanonicalizationLedgerUpdates[] :=
  Module[{audit = AuditUOMBoundaryCanonicalization[], decision = UOMBoundaryCanonicalizationDecision[], claims},
    claims = audit["Claims"];
    <|
      "task:uom-welded-boundary-ambiguity-annihilation" -> <|
        "Method" -> "Exact contract-level audit of the accepted welded boundary map on the transported ambiguity basis and the full affine class.",
        "Status" -> claims["Transported ambiguity is annihilated on the preserved welded boundary image", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Under the compressed welded-channel contract, all transported ambiguity directions vanish exactly after the preserved welded boundary projection.",
        "RepresentativeModelFamily" -> "Certified active transport plus exact accepted welded boundary channel",
        "NoApproximationQ" -> True
      |>,
      "task:uom-welded-boundary-class-defined-derivation" -> <|
        "Method" -> "Exact contract-level derivation equality test on a symbolic welded boundary observable algebra.",
        "Status" -> claims["The induced welded boundary derivation is representative-independent", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Under the compressed welded-channel contract, the induced boundary derivation depends only on the transported class after welded projection.",
        "RepresentativeModelFamily" -> "Certified active transport plus exact accepted welded boundary channel",
        "NoApproximationQ" -> True
      |>,
      "task:uom-welded-boundary-calibration-invariance" -> <|
        "Method" -> "Exact contract-level comparison of distinct canonical representatives before and after welded projection.",
        "Status" -> claims["Calibration changes are exact on the welded boundary image", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Under the compressed welded-channel contract, distinct canonical representatives can project to the same exact welded boundary generator.",
        "RepresentativeModelFamily" -> "Two exact positive calibrations on one transported affine class",
        "NoApproximationQ" -> True
      |>,
      "task:uom-welded-boundary-nontriviality" -> <|
        "Method" -> "Exact contract-level commutator witness on the compiled welded boundary algebra.",
        "Status" -> claims["The welded boundary derivation acts nontrivially on a physical boundary observable", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Under the compressed welded-channel contract, at least one compiled welded boundary observable survives with nonzero induced action.",
        "RepresentativeModelFamily" -> "epsilon-weighted welded line acting on a compiled 2x2 boundary algebra witness",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
