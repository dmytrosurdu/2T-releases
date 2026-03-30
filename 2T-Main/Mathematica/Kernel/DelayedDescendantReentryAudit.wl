If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ActiveTransport`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ActiveTransport.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMAcceptedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMAcceptedChannel.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSplitControlledLift`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSplitControlledLift.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`QuotientDescent`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "QuotientDescent.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`ClassDefinedDerivation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "ClassDefinedDerivation.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryBlockCentrality`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryBlockCentrality.wl"}]];
];

BeginPackage["MainProof`DelayedDescendantReentryAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`ActiveTransport`"]
Needs["MainProof`UOMAcceptedChannel`"]
Needs["MainProof`UOMSplitControlledLift`"]
Needs["MainProof`QuotientDescent`"]
Needs["MainProof`ClassDefinedDerivation`"]
Needs["MainProof`BoundaryBlockCentrality`"]

CertifiedDelayedDescendantReentryAudit::usage =
  "CertifiedDelayedDescendantReentryAudit[] audits the delayed-to-descendant reentry route in the current exact finite-dimensional Mathematica lane.";
DelayedDescendantReentryLedgerRows::usage =
  "DelayedDescendantReentryLedgerRows[] returns ledger-style rows for the delayed-to-descendant reentry audit.";

Begin["`Private`"]

zeroMatrix[rows_Integer?NonNegative, cols_Integer?NonNegative] := ConstantArray[0, {rows, cols}];

boundaryBlock[lift_?MatrixQ] := lift[[1 ;; 2, 1 ;; 2]];
completionBlock[lift_?MatrixQ] := lift[[3 ;; 4, 3 ;; 4]];

splitLift[split_Association, v_?VectorQ] :=
  Module[
    {contract, channel, chi, projector, pi1, pi2},
    contract = split["IntrinsicResponseContract"];
    channel = contract["Channel"];
    chi = contract["ActiveScalarFunctional"];
    projector = contract["ActiveProjectorB"];
    {pi1, pi2} = split["LedgerProjectors"];
    KroneckerProduct[pi1, MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, v]] +
      KroneckerProduct[pi2, Expand[(chi . v) projector]]
  ];

completionScalar[split_Association, lift_?MatrixQ] :=
  Module[{projector = split["IntrinsicResponseContract", "ActiveProjectorB"]},
    Together[Tr[completionBlock[lift]]/Tr[projector]]
  ];

canonicalRepresentativeFromLift[split_Association, lift_?MatrixQ] :=
  Module[{jdesc = split["IntrinsicResponseContract", "TransportModel", "Jdesc"]},
    Expand[completionScalar[split, lift] jdesc]
  ];

splitThresholdCounterexample[] :=
  Module[
    {
      alphaPrime, dLambda, stock, alpha, eta, gcl, dI, zeta,
      a0, lam, rabs, kappa, c0, witness, existsQ, exampleRules, namedWitness, exampleVerifiedQ
    },
    witness =
      Quiet[
        FindInstance[
          alphaPrime dLambda stock + alpha eta gcl dI >=
            (zeta (a0 + c0 lam^2)/(2 Sqrt[12 rabs])) kappa dI &&
            alphaPrime > 0 && dLambda > 0 && stock > 0 &&
            alpha > 0 && eta > 0 && gcl > 0 && dI > 0 &&
            zeta > 0 && a0 > 0 && lam > 0 && rabs > 0 &&
            kappa > 0 && c0 == 0,
          {alphaPrime, dLambda, stock, alpha, eta, gcl, dI, zeta, a0, lam, rabs, kappa, c0},
          Reals
        ],
        {Power::infy, Infinity::indet}
      ];
    existsQ = witness =!= {};
    exampleRules = {
      alphaPrime -> 1, dLambda -> 1, stock -> 1, alpha -> 1, eta -> 1, gcl -> 1,
      dI -> 1, zeta -> 1, a0 -> 1, lam -> 1, rabs -> 1, kappa -> 1, c0 -> 0
    };
    exampleVerifiedQ =
      TrueQ @ FullSimplify[
        (
          alphaPrime dLambda stock + alpha eta gcl dI >=
            (zeta (a0 + c0 lam^2)/(2 Sqrt[12 rabs])) kappa dI &&
            alphaPrime > 0 && dLambda > 0 && stock > 0 &&
            alpha > 0 && eta > 0 && gcl > 0 && dI > 0 &&
            zeta > 0 && a0 > 0 && lam > 0 && rabs > 0 &&
            kappa > 0 && c0 == 0
        ) /. exampleRules
      ];
    namedWitness =
      <|
        "alphaPrime" -> 1,
        "dLambda" -> 1,
        "stock" -> 1,
        "alpha" -> 1,
        "eta" -> 1,
        "gcl" -> 1,
        "dI" -> 1,
        "zeta" -> 1,
        "a0" -> 1,
        "lam" -> 1,
        "rabs" -> 1,
        "kappa" -> 1,
        "c0" -> 0
      |>;
    <|
      "CounterexampleExistsQ" -> existsQ,
      "Witness" -> witness,
      "NamedWitness" -> namedWitness,
      "NamedWitnessVerifiedQ" -> exampleVerifiedQ,
      "Interpretation" ->
        "The effective split-threshold inequality admits positive exact witnesses with c_Lambda = 0, so the threshold does not force nonvanishing of the seam coefficient by itself."
    |>
  ];

canonicalLiftAudit[] :=
  Module[
    {
      split, contract, channel, transport, chi, qdata, w, eta,
      s, a1, a2, genericRepresentative, genericLift,
      canonicalLiftQ, quotientNoncollapseQ, mainVisibleNoncollapseQ
    },
    split = MainProof`UOMSplitControlledLift`CertifiedSplitControlledLift[];
    contract = split["IntrinsicResponseContract"];
    channel = contract["Channel"];
    transport = contract["TransportModel"];
    chi = contract["ActiveScalarFunctional"];
    genericRepresentative =
      Expand[s transport["Jdesc"] + transport["Aminus"] . {a1, a2}];
    genericLift = splitLift[split, genericRepresentative];
    canonicalLiftQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s, a1, a2},
        True,
        And[
          completionScalar[split, genericLift] == s,
          canonicalRepresentativeFromLift[split, genericLift] == s transport["Jdesc"],
          genericRepresentative - canonicalRepresentativeFromLift[split, genericLift] ==
            transport["Aminus"] . {a1, a2},
          splitLift[split, genericRepresentative] ==
            splitLift[split, canonicalRepresentativeFromLift[split, genericLift]],
          MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[
            channel,
            canonicalRepresentativeFromLift[split, genericLift]
          ] == boundaryBlock[genericLift]
        ]
      ];
    qdata =
      MainProof`QuotientDescent`QuotientDescentData[
        chi,
        transport["Aminus"],
        s transport["Jdesc"],
        "Nu" -> 1,
        "Label" -> "delayed_descendant_reentry_scalar_line"
      ];
    w = MainProof`QuotientDescent`QuotientCoordinateMatrix[qdata];
    eta = MainProof`QuotientDescent`DescendedFunctionalCoordinates[qdata];
    quotientNoncollapseQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        Implies[w . (s transport["Jdesc"]) == {0}, s == 0]
      ];
    mainVisibleNoncollapseQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        And[
          MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, s transport["Jdesc"]] ==
            s contract["ActiveProjectorB"],
          Implies[
            MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, s transport["Jdesc"]] ==
              zeroMatrix @@ Dimensions[contract["ActiveProjectorB"]],
            s == 0
          ]
        ]
      ];
    <|
      "SplitModelName" -> split["Name"],
      "QuotientCoordinateMatrix" -> w,
      "DescendedFunctionalCoordinates" -> eta,
      "Claims" -> <|
        "Current exact split family admits a canonical scalar descendant representative modulo Aminus" -> <|
          "Status" -> If[canonicalLiftQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> canonicalLiftQ
        |>,
        "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family" -> <|
          "Status" -> If[quotientNoncollapseQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> quotientNoncollapseQ
        |>,
        "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family" -> <|
          "Status" -> If[mainVisibleNoncollapseQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> mainVisibleNoncollapseQ
        |>
      |>,
      "ResidualBoundary" -> {
        "The scalar lift is a model-specific reconstruction on the exact one-dimensional split response line.",
        "This does not derive a microscopic completion-to-descendant lift theorem from the split note by itself.",
        "It certifies only that the present surrogate family admits a canonical scalar inverse modulo Aminus."
      }
    |>
  ];

furtherQuotientAudit[] :=
  Module[{classSuite, blockSuite, physicalAutomaticQ, boundaryAutomaticQ, conditionalBoundaryQ},
    classSuite = MainProof`ClassDefinedDerivation`RunClassDefinedDerivationExampleSuite[];
    blockSuite = MainProof`BoundaryBlockCentrality`RunBoundaryBlockCentralityExampleSuite[];
    physicalAutomaticQ = classSuite["VisibleExample", "ClassDefinedOnPhysicalQuotient"];
    boundaryAutomaticQ = blockSuite["UnsafeFamily", "ModNullClassDefinedQ"];
    conditionalBoundaryQ = blockSuite["BorderlineFamily", "ModNullClassDefinedQ"];
    <|
      "PhysicalQuotientVisibleCountermodel" -> classSuite["VisibleExample"],
      "BoundaryUnsafeCountermodel" -> blockSuite["UnsafeFamily"],
      "BoundaryBorderlineModel" -> blockSuite["BorderlineFamily"],
      "Claims" -> <|
        "Further post-Main-visible reentry is automatic from split-controlled localization alone" -> <|
          "Status" -> If[physicalAutomaticQ || boundaryAutomaticQ, "deferred", "counterexample found"],
          "Certified" -> False
        |>,
        "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family" -> <|
          "Status" -> If[conditionalBoundaryQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> conditionalBoundaryQ
        |>
      |>,
      "ResidualBoundary" -> {
        "The visible physical-sector example is not class-defined on the physical quotient.",
        "The unsafe controlled split-welded family is not mod-null class-defined, even though expectation-level invisibility holds there.",
        "So the current exact lane does not certify an automatic V^1-style or physical/null-ideal reentry theorem from split-controlled localization alone."
      }
    |>
  ];

CertifiedDelayedDescendantReentryAudit[] :=
  Module[{transport, split, thresholdAudit, liftAudit, quotientAudit},
    transport = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    split = MainProof`UOMSplitControlledLift`CertifiedSplitControlledLift[];
    thresholdAudit = splitThresholdCounterexample[];
    liftAudit = canonicalLiftAudit[];
    quotientAudit = furtherQuotientAudit[];
    <|
      "Model" -> <|
        "TransportModel" -> transport,
        "SplitModel" -> split,
        "MainVisibleQuotientCoordinate" -> liftAudit["QuotientCoordinateMatrix"],
        "MainVisibleDescendedFunctional" -> liftAudit["DescendedFunctionalCoordinates"]
      |>,
      "ThresholdAudit" -> thresholdAudit,
      "CanonicalLiftAudit" -> liftAudit,
      "FurtherQuotientAudit" -> quotientAudit,
      "Claims" -> <|
        "Split-threshold regime forces c_Lambda != 0" -> <|
          "Status" -> If[thresholdAudit["CounterexampleExistsQ"], "counterexample found", "exact finite-dimensional certificate"],
          "Certified" -> !thresholdAudit["CounterexampleExistsQ"]
        |>,
        "Current exact split family admits a canonical scalar descendant representative modulo Aminus" ->
          liftAudit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus"],
        "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family" ->
          liftAudit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family"],
        "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family" ->
          liftAudit["Claims", "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family"],
        "Further post-Main-visible reentry is automatic from split-controlled localization alone" ->
          quotientAudit["Claims", "Further post-Main-visible reentry is automatic from split-controlled localization alone"],
        "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family" ->
          quotientAudit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family"]
      |>,
      "ResidualBoundary" -> Join[
        {
          thresholdAudit["Interpretation"]
        },
        liftAudit["ResidualBoundary"],
        quotientAudit["ResidualBoundary"]
      ]
    |>
  ];

DelayedDescendantReentryLedgerRows[] :=
  Module[{audit = CertifiedDelayedDescendantReentryAudit[]},
    {
      <|
        "TheoremLabel" -> "task:delayed-reentry-threshold-nonvanishing",
        "Assumptions" -> "Exact surrogate split-threshold inequality with positive split/geometry parameters.",
        "Method" -> "Exact FindInstance search for positive witnesses satisfying the threshold while c_Lambda = 0.",
        "Status" -> audit["Claims", "Split-threshold regime forces c_Lambda != 0", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The threshold is checked as the explicit effective inequality from the note, not as a derived microscopic theorem."
        },
        "CertificateArtifact" -> Missing["GeneratedByRunFile"],
        "CounterexampleArtifact" -> Missing["GeneratedByRunFile"],
        "RepresentativeModelFamily" -> "effective split-threshold symbolic surrogate",
        "NoApproximationQ" -> True,
        "Source" -> "UOM/completion_sector_split_model_body.tex:430-478",
        "Acceptance" ->
          "The effective split threshold does not force c_Lambda != 0; nonvanishing remains an extra assumption."
      |>,
      <|
        "TheoremLabel" -> "task:delayed-reentry-scalar-lift-surrogate",
        "Assumptions" -> "Current certified transport model, accepted welded channel, and split-controlled A|B lift contract.",
        "Method" -> "Exact scalar extraction from the split completion block, followed by exact reconstruction of the canonical descendant representative modulo Aminus.",
        "Status" -> audit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "This is a model-specific scalar inverse on the exact one-dimensional response line, not a theorem that the split note itself provides the microscopic bridge."
        },
        "CertificateArtifact" -> Missing["GeneratedByRunFile"],
        "CounterexampleArtifact" -> Missing["GeneratedByRunFile"],
        "RepresentativeModelFamily" -> audit["CanonicalLiftAudit", "SplitModelName"],
        "NoApproximationQ" -> True,
        "Source" -> "Main/Mathematica split-controlled lift lane plus UOM/split_controlled_completion_lift_note.tex",
        "Acceptance" ->
          "The current exact branch family supports a canonical scalar lift surrogate from branchwise split completion data to a descendant representative modulo Aminus."
      |>,
      <|
        "TheoremLabel" -> "task:delayed-reentry-main-visible-noncollapse",
        "Assumptions" -> "Canonical scalar descendant representative on the certified branch family.",
        "Method" -> "Exact quotient-coordinate and accepted-channel checks on the one-dimensional Main-visible scalar quotient.",
        "Status" -> audit["Claims", "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "This certifies the current Main-visible scalar quotient only; it does not identify that quotient with a distinct V^1 or AQFT/HLS physical sector."
        },
        "CertificateArtifact" -> Missing["GeneratedByRunFile"],
        "CounterexampleArtifact" -> Missing["GeneratedByRunFile"],
        "RepresentativeModelFamily" -> "certified_polynomial_branch with scalar Main-visible quotient W = {{0,0,1}}",
        "NoApproximationQ" -> True,
        "Source" -> "Main/Mathematica Main-visible quotient lane and UOM/source_internal_control_factorization_note.tex",
        "Acceptance" ->
          "Once the scalar lift surrogate is fixed, the selected representative survives both the descendant ambiguity quotient and the current Main-visible scalar quotient."
      |>,
      <|
        "TheoremLabel" -> "task:delayed-reentry-post-main-visible-automatic",
        "Assumptions" -> "Only split-controlled localization plus the current exact controlled boundary and physical quotient lanes.",
        "Method" -> "Reuse exact visible and unsafe countermodels from the class-defined-derivation and controlled boundary block-centrality suites.",
        "Status" -> audit["Claims", "Further post-Main-visible reentry is automatic from split-controlled localization alone", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The countermodels live on explicit finite-dimensional physical or controlled-boundary quotients rather than an abstract V^1 object."
        },
        "CertificateArtifact" -> Missing["GeneratedByRunFile"],
        "CounterexampleArtifact" -> Missing["GeneratedByRunFile"],
        "RepresentativeModelFamily" -> "Visible physical quotient example and UnsafeControlledVisibleFamily",
        "NoApproximationQ" -> True,
        "Source" -> "Main/Mathematica class-defined-derivation and boundary block-centrality lanes",
        "Acceptance" ->
          "Further post-Main-visible reentry is not automatic from split-controlled localization alone; extra null-ideal or selector structure is still needed."
      |>,
      <|
        "TheoremLabel" -> "task:delayed-reentry-conditional-mod-null-lane",
        "Assumptions" -> "Chosen boundary null ideal on the audited borderline controlled split-welded family.",
        "Method" -> "Exact mod-null block-centrality audit on the borderline family.",
        "Status" -> audit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The null ideal is explicit model data; no abstract AQFT/HLS derivation is attempted."
        },
        "CertificateArtifact" -> Missing["GeneratedByRunFile"],
        "CounterexampleArtifact" -> Missing["GeneratedByRunFile"],
        "RepresentativeModelFamily" -> "BorderlineNullIdealFamily",
        "NoApproximationQ" -> True,
        "Source" -> "Main/Mathematica controlled boundary mod-null lane",
        "Acceptance" ->
          "A conditional mod-null reentry lane exists on the audited borderline family, matching the conditional theorem reading rather than a full unconditional closure."
      |>
    }
  ];

End[]

EndPackage[]
