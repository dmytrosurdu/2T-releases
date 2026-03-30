If[!MemberQ[$Packages, "MainProof`SplitWeldedBoundaryTests`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "SplitWeldedBoundaryTests.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`TransportedBoundaryAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "TransportedBoundaryAudit.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMWeldedChannel`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedChannel.wl"}]];
];

BeginPackage["MainProof`LegacyBoundaryNegativeControls`"]

LegacyBoundaryNegativeControlAudit::usage =
  "LegacyBoundaryNegativeControlAudit[] returns the exact unsafe generic surrogate witnesses preserved as negative controls.";
LegacyBoundaryNegativeControlLedgerUpdates::usage =
  "LegacyBoundaryNegativeControlLedgerUpdates[] returns theorem-ledger updates for the legacy negative-control lane.";

Begin["`Private`"]

LegacyBoundaryNegativeControlAudit[] :=
  Module[{splitSuite, transportedSuite, weldedAudit},
    splitSuite = MainProof`SplitWeldedBoundaryTests`RunSplitWeldedBoundaryExampleSuite[];
    transportedSuite = MainProof`TransportedBoundaryAudit`RunTransportedBoundaryAuditSuite[];
    weldedAudit = MainProof`UOMWeldedChannel`AuditUOMWeldedChannel[];
    <|
      "SplitWeldedUnsafeFamily" -> splitSuite["UnsafeFamily"],
      "TransportedUnsafeWitness" -> transportedSuite["TransportedUnsafeWitness"],
      "LegacyUnsafeWeldedWitness" -> weldedAudit["LegacyUnsafeWitness"],
      "Claims" -> <|
        "Generic visible ambiguity witness persists" -> <|
          "Status" -> If[TrueQ[splitSuite["UnsafeFamily", "AmbiguityVisibleAtOperatorLevelQ"]], "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> TrueQ[splitSuite["UnsafeFamily", "AmbiguityVisibleAtOperatorLevelQ"]]
        |>,
        "Legacy splitBlock countermodels remain reproducible under weakened assumptions" -> <|
          "Status" -> If[
            Length[transportedSuite["TransportedUnsafeWitness", "StateInvisibleAudit", "VisibleBasisIndices"]] > 0 &&
              AnyTrue[weldedAudit["LegacyUnsafeWitness", "WeldedLineCompatibility"], TrueQ[# === False] &],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            Length[transportedSuite["TransportedUnsafeWitness", "StateInvisibleAudit", "VisibleBasisIndices"]] > 0 &&
              AnyTrue[weldedAudit["LegacyUnsafeWitness", "WeldedLineCompatibility"], TrueQ[# === False] &]
        |>
      |>
    |>
  ];

LegacyBoundaryNegativeControlLedgerUpdates[] :=
  Module[{audit = LegacyBoundaryNegativeControlAudit[], claims},
    claims = audit["Claims"];
    <|
      "task:legacy-generic-visible-ambiguity" -> <|
        "Method" -> "Exact regression audit on the unsafe generic split+welded surrogate family.",
        "Status" -> claims["Generic visible ambiguity witness persists", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "At least one exact generic surrogate witness still exhibits visible ambiguity after removing the welded UOM constraints.",
        "RepresentativeModelFamily" -> "UnsafeControlledVisibleFamily",
        "NoApproximationQ" -> True
      |>,
      "task:legacy-generic-splitblock-countermodels" -> <|
        "Method" -> "Exact regression audit on the transported unsafe witness and the legacy splitBlock-compatible countermodel blocks.",
        "Status" -> claims["Legacy splitBlock countermodels remain reproducible under weakened assumptions", "Status"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "At least two exact legacy countermodel lanes remain reproducible and are preserved as negative controls.",
        "RepresentativeModelFamily" -> "TransportedUnsafeWitness plus legacy splitBlock-compatible unsafe blocks",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
