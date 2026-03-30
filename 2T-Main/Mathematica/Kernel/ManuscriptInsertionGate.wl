If[!MemberQ[$Packages, "MainProof`UOMContractTraceability`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMContractTraceability.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`MockCosmologyContracts`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "MockCosmologyContracts.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundaryContractCompression`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundaryContractCompression.wl"}]];
];

BeginPackage["MainProof`ManuscriptInsertionGate`"]

Needs["MainProof`UOMContractTraceability`"]
Needs["MainProof`MockCosmologyContracts`"]
Needs["MainProof`BoundaryContractCompression`"]

AuditManuscriptInsertionGate::usage =
  "AuditManuscriptInsertionGate[] returns the current insertion gate for manuscript-facing statements.";
ManuscriptInsertionGateLedgerUpdates::usage =
  "ManuscriptInsertionGateLedgerUpdates[] returns theorem-ledger updates for the manuscript gating lane.";

Begin["`Private`"]

AuditManuscriptInsertionGate[] :=
  Module[{trace, interfaces, compression},
    trace = MainProof`UOMContractTraceability`AuditUOMContractTraceability[];
    interfaces = MainProof`MockCosmologyContracts`AuditMockCosmologyInterfaces[];
    compression = MainProof`BoundaryContractCompression`AuditBoundaryContractCompression[];
    <|
      "AllowedInsertionLevel" -> "UOM contract corollary only",
      "BlockedInsertionLevels" -> {
        "abstract Main theorem upgrade from this lane",
        "generic cosmology-interface theorem statement in manuscript form",
        "full microscopic completion-sector canonicality statement"
      },
      "Reasons" -> {
        "Boundary ingredients are now well traced with theorem-backed, reduced-theorem-backed, and conditional-theorem-backed statuses; the completion additions remain non-promoted, split across one bounded packaging theorem on explicit split data and one still-assumption-backed Gaussian layer.",
        "The minimal mock-tested boundary interface candidate is I0, but the stronger structural compression still sits inside the current exact WL family rather than a text-level generic theorem.",
        "The split-faithful completion result is improved and strong-safe, but it is still contract-level and does not close the full microscopic completion theorem."
      },
      "SupportingAudits" -> <|
        "Traceability" -> trace,
        "Interfaces" -> interfaces,
        "Compression" -> compression
      |>,
      "Claims" -> <|
        "Current manuscript insertion should stop at a UOM contract corollary" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" -> True
        |>,
        "A generic cosmology-interface manuscript theorem would still be premature" -> <|
          "Status" -> If[
            interfaces["BoundaryMinimalCandidate"] === "I0" &&
              trace["Claims", "Completion-specific additions remain non-promoted in the live note stack", "Certified"],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            interfaces["BoundaryMinimalCandidate"] === "I0" &&
              trace["Claims", "Completion-specific additions remain non-promoted in the live note stack", "Certified"]
        |>
      |>
    |>
  ];

ManuscriptInsertionGateLedgerUpdates[] :=
  Module[{audit = AuditManuscriptInsertionGate[]},
    <|
      "task:manuscript-insertion-gate" -> <|
        "Method" -> "Joint gate over contract traceability, interface compression, mock realizations, and completion-scope caveats.",
        "Status" -> If[And @@ Lookup[Values[audit["Claims"]], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "The current Mathematica lane supports insertion only as a UOM contract corollary and keeps generic-interface or microscopic-completion wording gated.",
        "RepresentativeModelFamily" -> "Traceability plus compact-interface search plus manuscript gate",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
