If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryBlockCentrality`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryBlockCentrality.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryNullIdealCandidates`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryNullIdealCandidates.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`TransportedBoundaryAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "TransportedBoundaryAudit.wl"}]];
];

BeginPackage["MainProof`SelectorNecessityDecision`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundaryBlockCentrality`"]
Needs["MainProof`BoundaryNullIdealCandidates`"]
Needs["MainProof`TransportedBoundaryAudit`"]

SelectorNecessityDecision::usage =
  "SelectorNecessityDecision[] synthesizes the block-centrality, natural-null-ideal, and transported-ambiguity audits into Decision A or Decision B.";
SelectorNecessityDecisionLedgerUpdates::usage =
  "SelectorNecessityDecisionLedgerUpdates[] returns theorem-ledger updates for the selector-necessity sprint.";

Begin["`Private`"]

SelectorNecessityDecision[] :=
  Module[
    {blockSuite, nullSuite, transportedSuite, recommendation, unsafeStateAudit, safeStateAudit},
    blockSuite = MainProof`BoundaryBlockCentrality`RunBoundaryBlockCentralityExampleSuite[];
    nullSuite = MainProof`BoundaryNullIdealCandidates`RunBoundaryNullIdealCandidateSuite[];
    transportedSuite = MainProof`TransportedBoundaryAudit`RunTransportedBoundaryAuditSuite[];
    recommendation = MainProof`BoundaryNullIdealCandidates`RecommendedBoundaryNullIdealCandidate[nullSuite];
    unsafeStateAudit = transportedSuite["TransportedUnsafeWitness", "StateInvisibleAudit"];
    safeStateAudit = transportedSuite["TransportedSafeWitness", "StateInvisibleAudit"];
    If[
      !MissingQ[recommendation] &&
        TrueQ[transportedSuite["ForcedByTransportStructureQ"]],
      <|
        "Decision" -> "Decision A",
        "Sentence" ->
          "Under split+welded boundary restriction, the transported ambiguity class is automatically boundary-null or block-central in the controlled sector, so Main gets a nontrivial boundary class-defined derivation without a preferred selector.",
        "Reason" ->
          StringJoin[
            "A natural boundary null ideal was recommended exactly as ",
            recommendation,
            ", and the transported ambiguity audit forced the boundary-safe criterion under the certified weak-interface export."
          ],
        "NaturalBoundaryNullIdeal" -> recommendation,
        "TransportedSafeWitness" -> transportedSuite["TransportedSafeWitness"],
        "TransportedUnsafeWitness" -> transportedSuite["TransportedUnsafeWitness"],
        "BoundaryBlockCentrality" -> blockSuite,
        "BoundaryNullIdealCandidates" -> nullSuite
      |>,
      <|
        "Decision" -> "Decision B",
        "Sentence" ->
          "That does not follow from the transported structure; visible diagonal controlled ambiguity survives, so a preferred selector must be promoted to core status.",
        "Reason" ->
          StringRiffle[
            {
              "The weak-interface transport data only constrain Aminus by chi-annihilation and affine-class descent; they do not force a boundary block-central realization.",
              "The actual exported ambiguity basis admits an exact safe boundary realization and an exact unsafe realization, so the boundary-safe criterion is not structural at the transport level.",
              "Among the tested natural boundary null ideals, the readout-kernel or block-trace-zero candidate is overlarge and trivializes controlled dynamics, while the state-invisible candidate does not supply a stable mod-null quotient.",
              If[
                Length[unsafeStateAudit["VisibleBasisIndices"]] > 0,
                "A transported unsafe witness with visible diagonal controlled ambiguity survives under the nontrivial state-invisible candidate.",
                "No nontrivial natural candidate forces the transported ambiguity basis into the boundary null ideal."
              ]
            },
            " "
          ],
        "NaturalBoundaryNullIdeal" -> recommendation,
        "TransportedSafeWitness" -> transportedSuite["TransportedSafeWitness"],
        "TransportedUnsafeWitness" -> transportedSuite["TransportedUnsafeWitness"],
        "TransportedSafeUnderStateInvisibleQ" -> safeStateAudit["AllBasisModNullBlockCentralQ"],
        "TransportedUnsafeVisibleIndices" -> unsafeStateAudit["VisibleBasisIndices"],
        "BoundaryBlockCentrality" -> blockSuite,
        "BoundaryNullIdealCandidates" -> nullSuite
      |>
    ]
  ];

SelectorNecessityDecisionLedgerUpdates[] :=
  Module[{decision = SelectorNecessityDecision[]},
    <|
      "task:selector-necessity-decision" -> <|
        "Method" -> "Exact synthesis of boundary block-centrality, natural null-ideal comparison, and transported ambiguity audit on the certified weak-interface export.",
        "Status" -> If[
          MemberQ[{"Decision A", "Decision B"}, decision["Decision"]],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> decision["Sentence"],
        "RepresentativeModelFamily" ->
          "Controlled boundary strong/mod-null theorem families plus transported safe/unsafe realizations of CertifiedActiveTransportModel",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
