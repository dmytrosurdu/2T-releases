If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMBoundaryCanonicalization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMBoundaryCanonicalization.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

BeginPackage["MainProof`UOMIntrinsicResponseMap`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMBoundaryCanonicalization`"]
Needs["MainProof`UOMAcceptedChannel`"]

CertifiedIntrinsicResponseContract::usage =
  "CertifiedIntrinsicResponseContract[] returns the exact finite-dimensional intrinsic-response contract inherited from the compressed welded boundary image.";
AuditUOMIntrinsicResponseMap::usage =
  "AuditUOMIntrinsicResponseMap[] certifies that the active response coordinate is derived from the welded response image itself and not from an appended free functional.";
UOMIntrinsicResponseMapLedgerUpdates::usage =
  "UOMIntrinsicResponseMapLedgerUpdates[] returns theorem-ledger updates for the intrinsic-response contract lane.";

Begin["`Private`"]

responseScalar[channel_Association, block_?MatrixQ] :=
  Together[Tr[block . channel["ProfileProjectorB"]]/Tr[channel["ProfileProjectorB"]]];

CertifiedIntrinsicResponseContract[] :=
  Module[{boundaryModel, channel, transport, ambiguityBasis, ambiguityImages},
    boundaryModel = MainProof`UOMBoundaryCanonicalization`CertifiedUOMBoundaryCanonicalizationModel[];
    channel = boundaryModel["Channel"];
    transport = boundaryModel["TransportModel"];
    ambiguityBasis =
      Table[
        transport["Aminus"][[All, i]],
        {i, Dimensions[transport["Aminus"]][[2]]}
      ];
    ambiguityImages =
      (MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, #] &) /@ ambiguityBasis;
    <|
      "Name" -> "uom_intrinsic_response_contract_from_welded_boundary",
      "BoundaryModel" -> boundaryModel,
      "Channel" -> channel,
      "TransportModel" -> transport,
      "ActiveProjectorB" -> channel["ProfileProjectorB"],
      "ActiveScalarFunctional" -> channel["Chi"],
      "RepresentativeImage" -> MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, transport["Jdesc"]],
      "AmbiguityBasis" -> ambiguityBasis,
      "AmbiguityImages" -> ambiguityImages
    |>
  ];

AuditUOMIntrinsicResponseMap[] :=
  Module[
    {
      contract, channel, transport, responseMap, a1, a2, genericVector, genericImage,
      scalarRecoveryQ, ambiguityDeadQ, representativeNonzeroQ, lineDerivedQ
    },
    contract = CertifiedIntrinsicResponseContract[];
    channel = contract["Channel"];
    transport = contract["TransportModel"];
    responseMap = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, #] &;
    genericVector = transport["Jdesc"] + transport["Aminus"] . {a1, a2};
    genericImage = responseMap[genericVector];
    scalarRecoveryQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {a1, a2},
        True,
        responseScalar[channel, genericImage] == channel["Chi"] . genericVector
      ];
    ambiguityDeadQ =
      AllTrue[
        contract["AmbiguityImages"],
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          #,
          ConstantArray[0, Dimensions[contract["ActiveProjectorB"]]]
        ] &
      ];
    representativeNonzeroQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        contract["RepresentativeImage"],
        ConstantArray[0, Dimensions[contract["RepresentativeImage"]]]
      ];
    lineDerivedQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        contract["RepresentativeImage"],
        (channel["Chi"] . transport["Jdesc"]) contract["ActiveProjectorB"]
      ];
    <|
      "Contract" -> contract,
      "GenericImage" -> genericImage,
      "Claims" -> <|
        "Intrinsic response coordinate is recovered from the welded response image" -> <|
          "Status" -> If[scalarRecoveryQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> scalarRecoveryQ
        |>,
        "Ambiguity directions are annihilated already in the intrinsic response contract" -> <|
          "Status" -> If[ambiguityDeadQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> ambiguityDeadQ
        |>,
        "Active response line is derived from the compressed welded projector" -> <|
          "Status" -> If[lineDerivedQ && representativeNonzeroQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> lineDerivedQ && representativeNonzeroQ
        |>
      |>
    |>
  ];

UOMIntrinsicResponseMapLedgerUpdates[] :=
  Module[{audit = AuditUOMIntrinsicResponseMap[], claims},
    claims = audit["Claims"];
    <|
      "task:sk-intrinsic-response-map-contract" -> <|
        "Method" -> "Exact contract extraction from chi and the accepted welded response image, with scalar recovery performed from the response block itself.",
        "Status" -> If[And @@ Lookup[Values[claims], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "The active response coordinate is fixed by the intrinsic welded response image itself and not by an appended free completion functional.",
        "RepresentativeModelFamily" -> audit["Contract", "Name"],
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
