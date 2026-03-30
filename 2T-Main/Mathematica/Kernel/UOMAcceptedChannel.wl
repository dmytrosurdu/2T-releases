If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedChannel.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMFactPreservation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMFactPreservation.wl"}]];
];

BeginPackage["MainProof`UOMAcceptedChannel`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMWeldedChannel`"]
Needs["MainProof`UOMFactPreservation`"]

AcceptedChannelContract::usage =
  "AcceptedChannelContract[] returns the exact finite-cutoff accepted-channel contract used by the welded boundary lane.";
AcceptedBoundaryMap::usage =
  "AcceptedBoundaryMap[channel, v] applies the exact finite-cutoff accepted-channel factorization to v.";
AcceptedTickKrausOperators::usage =
  "AcceptedTickKrausOperators[dim] returns the exact commuting Kraus operators for the accepted tick surrogate.";
AcceptedTickMap::usage =
  "AcceptedTickMap[rho] applies the exact accepted tick surrogate.";
BrokenAcceptedTickMap::usage =
  "BrokenAcceptedTickMap[rho] applies an intentional record-breaking CPTP surrogate used as an ablation witness.";
AuditUOMAcceptedChannel::usage =
  "AuditUOMAcceptedChannel[] certifies the accepted-channel factorization, uplift isometry surrogate, CPTP surrogate, and exact accepted-record preservation.";
UOMAcceptedChannelLedgerUpdates::usage =
  "UOMAcceptedChannelLedgerUpdates[] returns theorem-ledger updates for the accepted-channel contract lane.";

Begin["`Private`"]

matrixUnit[dim_Integer?Positive, i_Integer?Positive, j_Integer?Positive] :=
  Normal @ SparseArray[{{i, j} -> 1}, {dim, dim}];

AcceptedTickKrausOperators[dim_Integer?Positive] :=
  Table[matrixUnit[dim, i, i], {i, dim}];

AcceptedTickMap[rho_?MatrixQ] :=
  Total[(# . rho . Transpose[#]) & /@ AcceptedTickKrausOperators[Length[rho]]];

BrokenAcceptedTickMap[rho_?MatrixQ] :=
  Module[{swap = Reverse[IdentityMatrix[Length[rho]]]},
    swap . rho . Transpose[swap]
  ];

upliftIsometry[dim_Integer?Positive] :=
  KroneckerProduct[IdentityMatrix[dim], {{1}, {0}}];

sourceWrite[v_?VectorQ] := v;
retardedTransport[v_?VectorQ] := v;
compiledScalar[channel_Association, v_?VectorQ] := Together[(channel["Chi"] . v)/channel["Epsilon"]];
weylCompensate[channel_Association, scalar_] := Expand[channel["Epsilon"] scalar];
profileProject[channel_Association, scalar_] := Expand[scalar channel["ProfileProjectorB"]];

AcceptedBoundaryMap[channel_Association, v_?VectorQ] :=
  profileProject[
    channel,
    weylCompensate[channel, compiledScalar[channel, retardedTransport[sourceWrite[v]]]]
  ];

AcceptedChannelContract[] :=
  Module[{channel, transport, dim},
    channel = MainProof`UOMWeldedChannel`CertifiedWeldedChannelData[];
    transport = channel["TransportModel"];
    dim = Length[transport["Jdesc"]];
    <|
      "Name" -> "uom_exact_accepted_channel_contract",
      "ChannelData" -> channel,
      "SourceWrite" -> HoldForm[Wsrc[v] == v],
      "RetardedTransport" -> HoldForm[Gret[v] == v],
      "CompiledScalarMap" -> HoldForm[Kcomp[v] == (chi . v)/epsilon],
      "WeylCompensator" -> HoldForm[Mepsilon[s] == epsilon s],
      "ProfileProjection" -> HoldForm[PiL[s] == s PLoG],
      "FactorizationStatement" ->
        HoldForm[TLambda[v] == PiL[Mepsilon[Kcomp[Gret[Wsrc[v]]]]]],
      "AcceptedTickKrausOperators" -> AcceptedTickKrausOperators[dim],
      "UpliftIsometry" -> upliftIsometry[dim],
      "AcceptedTickDimension" -> dim
    |>
  ];

AuditUOMAcceptedChannel[] :=
  Module[
    {
      contract, channel, transport, basis, factorizationQ, upliftQ, cptpQ,
      factAudit, preservationQ, ablationWitness, ablationFailsQ
    },
    contract = AcceptedChannelContract[];
    channel = contract["ChannelData"];
    transport = channel["TransportModel"];
    basis = Append[
      Table[transport["Aminus"][[All, i]], {i, Dimensions[transport["Aminus"]][[2]]}],
      transport["Jdesc"]
    ];
    factorizationQ =
      AllTrue[
        basis,
        MainProof`CommonProofTools`ExactMatrixEqualQ[
          AcceptedBoundaryMap[channel, #],
          MainProof`UOMWeldedChannel`WeldedScalarImage[channel, #]
        ] &
      ];
    upliftQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        Transpose[contract["UpliftIsometry"]] . contract["UpliftIsometry"],
        IdentityMatrix[contract["AcceptedTickDimension"]]
      ];
    cptpQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        Total[Transpose[#] . # & /@ contract["AcceptedTickKrausOperators"]],
        IdentityMatrix[contract["AcceptedTickDimension"]]
      ];
    factAudit = MainProof`UOMFactPreservation`AuditUOMFactPreservation[contract["AcceptedTickDimension"]];
    preservationQ = And @@ Lookup[Values[factAudit["Claims"]], "Certified"];
    ablationWitness = matrixUnit[2, 1, 1];
    ablationFailsQ =
      !MainProof`CommonProofTools`ExactMatrixEqualQ[
        MainProof`UOMFactPreservation`AcceptedRecordProjection[BrokenAcceptedTickMap[ablationWitness]],
        MainProof`UOMFactPreservation`AcceptedRecordProjection[ablationWitness]
      ];
    <|
      "Contract" -> contract,
      "FactPreservationAudit" -> factAudit,
      "RecordBreakingWitness" -> <|
        "InputState" -> ablationWitness,
        "BrokenTickImage" -> BrokenAcceptedTickMap[ablationWitness]
      |>,
      "Claims" -> <|
        "Accepted welded channel factorizes exactly through the compiled descended scalar" -> <|
          "Status" -> If[factorizationQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> factorizationQ
        |>,
        "Accepted uplift surrogate is an exact isometry" -> <|
          "Status" -> If[upliftQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> upliftQ
        |>,
        "Accepted tick surrogate is exactly CPTP at finite cutoff" -> <|
          "Status" -> If[cptpQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> cptpQ
        |>,
        "Accepted record sector is preserved exactly and breaks under the intentional ablation" -> <|
          "Status" -> If[preservationQ && ablationFailsQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> preservationQ && ablationFailsQ
        |>
      |>
    |>
  ];

UOMAcceptedChannelLedgerUpdates[] :=
  Module[{audit = AuditUOMAcceptedChannel[], claims},
    claims = audit["Claims"];
    <|
      "task:uom-channel-factorization" -> <|
        "Method" -> "Exact factorization audit of TLambda = Pi_L o M_epsilon o K_comp o G_ret o W_src against the welded boundary map.",
        "Status" -> claims["Accepted welded channel factorizes exactly through the compiled descended scalar", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "The accepted welded boundary map factors exactly through the descended dominant scalar and the welded profile projector.",
        "RepresentativeModelFamily" -> "uom_exact_accepted_channel_contract",
        "NoApproximationQ" -> True
      |>,
      "task:uom-uplift-isometry-surrogate" -> <|
        "Method" -> "Exact isometry audit on the finite-dimensional uplift/Stinespring surrogate.",
        "Status" -> claims["Accepted uplift surrogate is an exact isometry", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "The chosen uplift map is an exact isometry on the accepted finite-cutoff sector.",
        "RepresentativeModelFamily" -> "uom_exact_accepted_channel_contract",
        "NoApproximationQ" -> True
      |>,
      "task:uom-app-cptp-surrogate" -> <|
        "Method" -> "Exact Kraus-completeness audit on the commuting accepted tick surrogate.",
        "Status" -> claims["Accepted tick surrogate is exactly CPTP at finite cutoff", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "The accepted tick surrogate is exactly CPTP on the chosen finite pointer sector.",
        "RepresentativeModelFamily" -> "uom_exact_accepted_channel_contract",
        "NoApproximationQ" -> True
      |>,
      "task:uom-accepted-record-preservation" -> <|
        "Method" -> "Exact accepted-record preservation audit with a record-breaking ablation witness.",
        "Status" -> claims["Accepted record sector is preserved exactly and breaks under the intentional ablation", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Accepted record expectations are preserved exactly, and the intentional ablation fails that test.",
        "RepresentativeModelFamily" -> "uom_exact_accepted_channel_contract with exact record-breaking witness",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
