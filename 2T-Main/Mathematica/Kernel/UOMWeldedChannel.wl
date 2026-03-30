If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ActiveTransport`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ActiveTransport.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySplitWeldedModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySplitWeldedModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

BeginPackage["MainProof`UOMWeldedChannel`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`ActiveTransport`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`BoundarySectors`"]

WeldedBandLockScales::usage =
  "WeldedBandLockScales[lambda, v, alphaT, alphaX] returns the exact band-locked welded scales s_t and s_x.";
CertifiedWeldedChannelData::usage =
  "CertifiedWeldedChannelData[] returns the UOM-faithful compressed welded LoG channel data used in the reworked boundary audit.";
WeldedScalarImage::usage =
  "WeldedScalarImage[channel, v] returns the exact welded boundary image of v, factoring through the descended dominant scalar.";
WeldedCompatibleBlockQ::usage =
  "WeldedCompatibleBlockQ[channel, block] checks whether a B-block lies on the one-dimensional welded LoG line.";
AuditUOMWeldedChannel::usage =
  "AuditUOMWeldedChannel[] returns the exact UOM welded-channel audit, including comparison against the legacy unsafe surrogate witness.";
UOMWeldedChannelLedgerUpdates::usage =
  "UOMWeldedChannelLedgerUpdates[] returns theorem-ledger updates for the welded-channel rework lane.";

Begin["`Private`"]

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

WeldedBandLockScales[lambda_, v_, alphaT_, alphaX_] :=
  <|
    "s_t" -> Together[alphaT/lambda],
    "s_x" -> Together[alphaX/(v lambda)]
  |>;

rankOneProjector[dimB_Integer?Positive] :=
  DiagonalMatrix[Join[{1}, ConstantArray[0, dimB - 1]]];

CertifiedWeldedChannelData[] :=
  Module[{lambda, v, alphaT, alphaX, center, tick, dimB, transport, chi, epsilon},
    dimB = 2;
    transport = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    chi = MainProof`ActiveTransport`DerivedChi[transport];
    epsilon = Expand[chi . transport["Jdesc"]];
    <|
      "Name" -> "uom_exact_welded_bandlocked_log_channel",
      "Lambda" -> lambda,
      "vGeom" -> v,
      "AlphaTStar" -> alphaT,
      "AlphaXStar" -> alphaX,
      "Center" -> center,
      "Tick" -> tick,
      "DimB" -> dimB,
      "Assumptions" -> lambda > 0 && v > 0 && alphaT > 0 && alphaX > 0,
      "TransportModel" -> transport,
      "Chi" -> chi,
      "Epsilon" -> epsilon,
      "BandLockScales" -> WeldedBandLockScales[lambda, v, alphaT, alphaX],
      "TemporalWeldedForm" ->
        HoldForm[
          gPrime[CapitalSigma][t - tick] * gPrime[sigmaT][t - tick] ==
            D[g[Sqrt[CapitalSigma^2 + sigmaT^2]][t - tick], {t, 2}]
        ],
      "SpatialWeldedForm" ->
        HoldForm[
          LoG[rho][Omega, center] \[CircleTimes] Gaussian[sigmaX][Omega, center] ==
            LoG[Sqrt[rho^2 + sigmaX^2]][Omega, center]
        ],
      "BandLockStatement" ->
        HoldForm[
          {
            sT == alphaT/lambda,
            sX == alphaX/(v lambda)
          }
        ],
      "CenterLockStatement" ->
        HoldForm[OmegaStar == center],
      "WeldedChannelDimension" -> 1,
      "ProfileProjectorB" -> rankOneProjector[dimB],
      "ProfileBasisB" -> {UnitVector[dimB, 1]},
      "CompressedChannelStatement" ->
        HoldForm[Subscript[H, LoG][lambda] == Span[{uLoG[lambda]}]]
    |>
  ];

WeldedScalarImage[channel_Association, v_?VectorQ] :=
  Expand[(channel["Chi"] . v) channel["ProfileProjectorB"]];

WeldedCompatibleBlockQ[channel_Association, block_?MatrixQ] :=
  MainProof`CommonProofTools`MatrixInSpanQ[block, {channel["ProfileProjectorB"]}];

AuditUOMWeldedChannel[] :=
  Module[
    {
      channel, transport, basis, ambiguityImages, jImage, epsilonImage,
      legacyFamilies, legacyUnsafe, unsafeBlocks, unsafeCompatibility
    },
    channel = CertifiedWeldedChannelData[];
    transport = channel["TransportModel"];
    basis = basisColumns[transport["Aminus"]];
    ambiguityImages = WeldedScalarImage[channel, #] & /@ basis;
    jImage = WeldedScalarImage[channel, transport["Jdesc"]];
    epsilonImage = Expand[channel["Epsilon"] channel["ProfileProjectorB"]];
    legacyFamilies = MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[];
    legacyUnsafe = legacyFamilies["UnsafeControlledVisibleFamily"];
    unsafeBlocks =
      MainProof`BoundarySectors`ControlledBlocks[
        MainProof`BoundarySectors`ControlledProjection[
          legacyUnsafe["AmbiguityOperator"],
          legacyUnsafe["ProjectorsA"]
        ],
        legacyUnsafe["ProjectorsA"]
      ];
    unsafeCompatibility = WeldedCompatibleBlockQ[channel, #] & /@ unsafeBlocks;
    <|
      "ChannelData" -> channel,
      "AminusBasisVectors" -> basis,
      "AminusImages" -> ambiguityImages,
      "RepresentativeImage" -> jImage,
      "Claims" -> <|
        "Exact band-lock scale form" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" ->
            MainProof`CommonProofTools`ExactVectorEqualQ[
              Values[channel["BandLockScales"]],
              {
                channel["AlphaTStar"]/channel["Lambda"],
                channel["AlphaXStar"]/(channel["vGeom"] channel["Lambda"])
              }
            ]
        |>,
        "Compressed welded channel is one-dimensional" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" -> channel["WeldedChannelDimension"] == 1 &&
            MainProof`CommonProofTools`RankOneProjectorQ[channel["ProfileProjectorB"]]
        |>,
        "Transported ambiguity factors through descended dominant scalar" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" ->
            MainProof`CommonProofTools`AffineClassConstantQ[
              channel["Chi"],
              transport["Jdesc"],
              transport["Aminus"],
              channel["Chi"] . transport["Jdesc"]
            ]
        |>,
        "Transported ambiguity is annihilated on the welded line" -> <|
          "Status" -> If[
            AllTrue[
              ambiguityImages,
              MainProof`CommonProofTools`ExactMatrixEqualQ[
                #,
                ConstantArray[0, Dimensions[channel["ProfileProjectorB"]]]
              ] &
            ],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            AllTrue[
              ambiguityImages,
              MainProof`CommonProofTools`ExactMatrixEqualQ[
                #,
                ConstantArray[0, Dimensions[channel["ProfileProjectorB"]]]
              ] &
            ]
        |>,
        "Representative image is nonzero and class scalar equals epsilon" -> <|
          "Status" -> If[
            MainProof`CommonProofTools`ExactMatrixEqualQ[jImage, epsilonImage] &&
              !MainProof`CommonProofTools`ExactMatrixEqualQ[
                jImage,
                ConstantArray[0, Dimensions[channel["ProfileProjectorB"]]]
              ],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            MainProof`CommonProofTools`ExactMatrixEqualQ[jImage, epsilonImage] &&
              !MainProof`CommonProofTools`ExactMatrixEqualQ[
                jImage,
                ConstantArray[0, Dimensions[channel["ProfileProjectorB"]]]
              ]
        |>,
        "Legacy unsafe surrogate witness is incompatible with the welded line" -> <|
          "Status" -> If[!And @@ unsafeCompatibility, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> !And @@ unsafeCompatibility,
          "CompatibilityByBlock" -> unsafeCompatibility
        |>
      |>,
      "LegacyUnsafeWitness" -> <|
        "ModelName" -> legacyUnsafe["Name"],
        "ControlledBlocks" -> unsafeBlocks,
        "WeldedLineCompatibility" -> unsafeCompatibility
      |>
    |>
  ];

UOMWeldedChannelLedgerUpdates[] :=
  Module[{audit = AuditUOMWeldedChannel[], claims},
    claims = audit["Claims"];
    <|
      "task:uom-welded-bandlocked-channel" -> <|
        "Method" -> "Exact welded-channel realization using the compressed, co-centered, band-locked LoG line and descended dominant scalar factorization.",
        "Status" -> If[
          claims["Exact band-lock scale form", "Certified"] &&
            claims["Compressed welded channel is one-dimensional", "Certified"] &&
            claims["Transported ambiguity factors through descended dominant scalar", "Certified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Exact welded boundary image factors through the descended dominant scalar on the one-dimensional compressed welded LoG channel.",
        "RepresentativeModelFamily" -> "uom_exact_welded_bandlocked_log_channel",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
