If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ActiveTransport`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ActiveTransport.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

BeginPackage["MainProof`DelayedSelectedLinePromotionAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`ActiveTransport`"]
Needs["MainProof`UOMAcceptedChannel`"]

CertifiedDelayedSelectedLinePromotionAudit::usage =
  "CertifiedDelayedSelectedLinePromotionAudit[] certifies the packet-level microscopic-to-seam extractor, the trivial quotient-kernel claim, and the universal microscopic selected-survival claim on the exact branch family, and records raw microscopic nonuniqueness before quotient.";
DelayedSelectedLinePromotionLedgerRows::usage =
  "DelayedSelectedLinePromotionLedgerRows[] returns report rows for the delayed selected-line promotion audit.";

Begin["`Private`"]

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

sigmaFill["diag"] = 1;
sigmaFill["bridge"] = -1;

detectorFactorizedSource[transport_Association, fill_String, obs_] :=
  Expand[sigmaFill[fill] obs transport["Jdesc"]];

microscopicVariationSource[transport_Association, fill_String, obs_, coeffs_List] :=
  Expand[sigmaFill[fill] obs (transport["Jdesc"] + transport["Aminus"].coeffs)];

delayedCoordinate[channel_Association, v_?VectorQ] :=
  {Together[(channel["Chi"] . v)/channel["Epsilon"]]};

CertifiedDelayedSelectedLinePromotionAudit[] :=
  Module[
    {
      transport, contract, channel, projector, unit, basis,
      s, a1, a2, diagSource, bridgeSource, variedDiagSource, variedBridgeSource,
      diagCoordinate, bridgeCoordinate, variedDiagCoordinate, variedBridgeCoordinate,
      detectorFactorizedQ, weldedImageQ, fillerToggleDelayedVisibleQ, ambiguityShiftQ,
      packetExtractorQ, quotientKernelTrivialQ, universalSelectedSurvivalQ,
      promotedSelectedSurvivalQ,
      rawCounterexampleSource, rawCounterexampleShifted, rawCounterexampleImage,
      rawCounterexampleShiftedImage, rawNonuniquenessQ
    },
    transport = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    contract = MainProof`UOMAcceptedChannel`AcceptedChannelContract[];
    channel = contract["ChannelData"];
    projector = channel["ProfileProjectorB"];
    unit = transport["Jdesc"];
    basis = basisColumns[transport["Aminus"]];

    diagSource = detectorFactorizedSource[transport, "diag", s];
    bridgeSource = detectorFactorizedSource[transport, "bridge", s];
    variedDiagSource = microscopicVariationSource[transport, "diag", s, {a1, a2}];
    variedBridgeSource = microscopicVariationSource[transport, "bridge", s, {a1, a2}];

    diagCoordinate = delayedCoordinate[channel, diagSource];
    bridgeCoordinate = delayedCoordinate[channel, bridgeSource];
    variedDiagCoordinate = delayedCoordinate[channel, variedDiagSource];
    variedBridgeCoordinate = delayedCoordinate[channel, variedBridgeSource];

    detectorFactorizedQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        And[
          diagSource == s unit,
          bridgeSource == -s unit,
          diagCoordinate == {s},
          bridgeCoordinate == {-s}
        ]
      ];

    weldedImageQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        And @@ Thread[
          Flatten[MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, diagSource] - s projector] == 0
        ] &&
          And @@ Thread[
            Flatten[MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, bridgeSource] + s projector] == 0
          ]
      ];

    fillerToggleDelayedVisibleQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        s != 0,
        And[
          diagCoordinate != bridgeCoordinate,
          !MainProof`CommonProofTools`ExactMatrixEqualQ[
            MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, diagSource],
            MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, bridgeSource]
          ]
        ]
      ];

    ambiguityShiftQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s, a1, a2},
        True,
        And[
          variedDiagCoordinate == diagCoordinate,
          variedBridgeCoordinate == bridgeCoordinate,
          And @@ Thread[
            Flatten[
              MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, variedDiagSource] -
                MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, diagSource]
            ] == 0
          ],
          And @@ Thread[
            Flatten[
              MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, variedBridgeSource] -
                MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, bridgeSource]
            ] == 0
          ]
        ]
      ];

    quotientKernelTrivialQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s, a1, a2},
        True,
        Implies[
          And[
            variedDiagCoordinate == {0},
            And @@ Thread[
              Flatten[MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, variedDiagSource]] == 0
            ]
          ],
          s == 0
        ] &&
          Implies[
            And[
              variedBridgeCoordinate == {0},
              And @@ Thread[
                Flatten[MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, variedBridgeSource]] == 0
              ]
            ],
            s == 0
          ]
      ];

    universalSelectedSurvivalQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        s != 0,
        diagCoordinate != {0} &&
          bridgeCoordinate != {0} &&
          MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, diagSource][[1, 1]] != 0 &&
          MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, bridgeSource][[1, 1]] != 0
      ];

    rawCounterexampleSource = unit;
    rawCounterexampleShifted = Expand[unit + basis[[1]]];
    rawCounterexampleImage =
      MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, rawCounterexampleSource];
    rawCounterexampleShiftedImage =
      MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, rawCounterexampleShifted];
    rawNonuniquenessQ =
      !MainProof`CommonProofTools`ExactVectorEqualQ[
        rawCounterexampleSource,
        rawCounterexampleShifted
      ] &&
        MainProof`CommonProofTools`ExactVectorEqualQ[
          delayedCoordinate[channel, rawCounterexampleSource],
          delayedCoordinate[channel, rawCounterexampleShifted]
        ] &&
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          rawCounterexampleImage,
          rawCounterexampleShiftedImage
        ];

    packetExtractorQ =
      detectorFactorizedQ &&
        weldedImageQ &&
        ambiguityShiftQ &&
        rawNonuniquenessQ;

    promotedSelectedSurvivalQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        s != 0,
        diagCoordinate != {0} &&
          MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, diagSource][[1, 1]] != 0
      ];

    <|
      "Model" -> <|
        "TransportModel" -> transport,
        "AcceptedChannelContract" -> contract,
        "SelectedGenerator" -> unit,
        "AmbiguityBasis" -> basis,
        "ProfileProjectorB" -> projector
      |>,
      "SymbolicFamily" -> <|
        "DetectorFactorizedDiagSource" -> diagSource,
        "DetectorFactorizedBridgeSource" -> bridgeSource,
        "VariedDiagSource" -> variedDiagSource,
        "VariedBridgeSource" -> variedBridgeSource,
        "DiagCoordinate" -> diagCoordinate,
        "BridgeCoordinate" -> bridgeCoordinate
      |>,
      "RawNonuniquenessCounterexample" -> <|
        "SelectedSource" -> rawCounterexampleSource,
        "ShiftedRawSource" -> rawCounterexampleShifted,
        "SelectedCoordinate" -> delayedCoordinate[channel, rawCounterexampleSource],
        "ShiftedCoordinate" -> delayedCoordinate[channel, rawCounterexampleShifted],
        "SelectedImage" -> rawCounterexampleImage,
        "ShiftedImage" -> rawCounterexampleShiftedImage
      |>,
      "Claims" -> <|
        "Canonical microscopic-to-seam packet extractor is well-defined on the exact family" -> <|
          "Status" -> If[packetExtractorQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> packetExtractorQ
        |>,
        "Microscopic-to-seam extractor kernel is trivial after quotient on the exact family" -> <|
          "Status" -> If[quotientKernelTrivialQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> quotientKernelTrivialQ
        |>,
        "Every nonzero microscopic delayed quotient class has nonzero extracted seam image on the exact family" -> <|
          "Status" -> If[universalSelectedSurvivalQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> universalSelectedSurvivalQ
        |>,
        "Selected-witness microscopic class survives with nonzero delayed coordinate and welded image on the exact family" -> <|
          "Status" -> If[promotedSelectedSurvivalQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> promotedSelectedSurvivalQ
        |>,
        "Detector-factorized seam family lies on one delayed selected line" -> <|
          "Status" -> If[detectorFactorizedQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> detectorFactorizedQ
        |>,
        "Delayed welded image is exactly the delayed coordinate times the LoG projector" -> <|
          "Status" -> If[weldedImageQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> weldedImageQ
        |>,
        "Accepted-record-preserving filler toggles remain distinct on the delayed seam readout in the exact family" -> <|
          "Status" -> If[fillerToggleDelayedVisibleQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> fillerToggleDelayedVisibleQ
        |>,
        "Pulse-rigid ambiguity directions are invisible to the delayed seam extractor in the exact family" -> <|
          "Status" -> If[ambiguityShiftQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityShiftQ
        |>,
        "Nonzero raw seam-invisible shifts exist before quotient" -> <|
          "Status" -> If[rawNonuniquenessQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> rawNonuniquenessQ
        |>
      |>,
      "ResidualBoundary" -> {
        "This exact audit certifies the packet-level microscopic-to-seam extractor only on the current polynomial branch family.",
        "It also certifies trivial quotient-kernel and universal microscopic selected-survival only on that exact branch family.",
        "It separately certifies selected-witness promoted delayed selected-line survival for the exact selected microscopic witness family.",
        "It separates three microscopic generator roles only at exact branch-family level: retained filler-toggle sign data, pulse-rigid ambiguity invisibility, and raw seam-invisible shifts before quotient.",
        "It does not replace the manuscript proof of the microscopic delayed equivalence relation or the packet-level extractor theorem.",
        "It does not theorem-back the downstream post-HLS physical-transfer theorem or the post-HLS Z2 rigidity theorem."
      }
    |>
  ];

DelayedSelectedLinePromotionLedgerRows[] :=
  Module[{audit, claims},
    audit = CertifiedDelayedSelectedLinePromotionAudit[];
    claims = audit["Claims"];
    {
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-packet-extractor-exact",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit of the packet-level microscopic-to-seam extractor on the detector-factorized branch family.",
        claims["Canonical microscopic-to-seam packet extractor is well-defined on the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_selected_line_promotion_note.tex::thm:micro-to-seam-extractor",
          "Acceptance" -> "Detector-admissible raw representatives induce one common detector-factorized seam packet after quotienting pulse-rigid ambiguity directions and seam-invisible shifts, while retained filler-toggle sign data can still persist upstairs."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-quotient-kernel-trivial",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit that zero extracted delayed seam image implies zero quotient scalar after ambiguity and seam-invisible shifts are factored out.",
        claims["Microscopic-to-seam extractor kernel is trivial after quotient on the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_selected_line_promotion_note.tex::prop:extractor-kernel-characterization",
          "Acceptance" -> "After quotienting pulse-rigid ambiguity directions and seam-invisible shifts, the detector-factorized branch family has trivial extractor kernel."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-universal-selected-survival",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit that every nonzero quotient scalar in the detector-factorized branch family has nonzero extracted delayed seam image.",
        claims["Every nonzero microscopic delayed quotient class has nonzero extracted seam image on the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_selected_line_promotion_note.tex::thm:universal-promoted-selected-survival",
          "Acceptance" -> "Every nonzero microscopic delayed quotient class on the certified branch family survives to a nonzero extracted delayed seam image."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-selected-witness-survival",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit that the selected microscopic branch representative survives through the packet extractor with nonzero delayed coordinate and nonzero delayed welded image.",
        claims["Selected-witness microscopic class survives with nonzero delayed coordinate and welded image on the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_selected_line_promotion_note.tex::thm:promoted-selected-line-survival",
          "Acceptance" -> "For the exact selected microscopic witness family, the promoted selected datum has nonzero delayed coordinate and nonzero delayed welded image after packet extraction."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-detector-factorized-line",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic detector-factorized seam family audit on the delayed quotient coordinate.",
        claims["Detector-factorized seam family lies on one delayed selected line", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_odd_control_note.tex::thm:delayed-selected-line",
          "Acceptance" -> "Every detector-factorized seam source is an exact scalar multiple of the selected generator on the delayed one-dimensional line."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-delayed-image-factorization",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit of AcceptedBoundaryMap on the detector-factorized delayed seam family.",
        claims["Delayed welded image is exactly the delayed coordinate times the LoG projector", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_odd_control_note.tex::prop:delayed-realization-formula",
          "Acceptance" -> "The delayed welded image is exactly the delayed selected coordinate times the canonical LoG projector."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-ambiguity-collapse-exact",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit showing that accepted-record-preserving filler toggles remain distinct on the delayed seam coordinate and delayed welded image.",
        claims["Accepted-record-preserving filler toggles remain distinct on the delayed seam readout in the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/active_response_transport_program_note.tex::def:witness-seam-realization and ::prop:seam-scalar-signs",
          "Acceptance" -> "Filler toggles are accepted-record-preserving but still change the delayed seam coordinate and welded image in the certified family."
        |>
      ],
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-pulse-rigid-ambiguity-invisibility",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact symbolic audit of pulse-rigid ambiguity-shift invariance for delayed coordinates and delayed welded images.",
        claims["Pulse-rigid ambiguity directions are invisible to the delayed seam extractor in the exact family", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/delayed_selected_line_promotion_note.tex::thm:micro-to-seam-extractor",
          "Acceptance" -> "Transport ambiguity directions do not change the delayed seam coordinate or its welded image in the certified family."
        |>
      ]
      ,
      MainProof`CommonProofTools`StatusRecord[
        "task:delay-promotion-raw-seam-invisible-shift",
        "Certified polynomial branch model plus accepted-channel contract",
        "Exact counterexample witness before quotient using a nonzero raw shift of the selected source with unchanged delayed seam image.",
        claims["Nonzero raw seam-invisible shifts exist before quotient", "Status"],
        <|
          "ScopeClass" -> "exact-model-certificate",
          "RepresentativeModelFamily" -> audit["Model", "TransportModel", "Name"],
          "NoApproximationQ" -> True,
          "Source" -> "UOM/odd_selector_note.tex::rem:selector-handoff and UOM/uom_descendant_note.tex::rem:uomdesc-downstream",
          "Acceptance" -> "A nonzero raw shift can preserve the delayed seam coordinate and welded image exactly, so raw microscopic uniqueness fails before quotient."
        |>
      ]
    }
  ];

End[]

EndPackage[]
