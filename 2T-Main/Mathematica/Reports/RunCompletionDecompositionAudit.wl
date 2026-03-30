rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMCompletionDecompositionAudit.wl"}]];

reportBaseName = "CompletionDecompositionAudit";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath =
  FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
summaryNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];

jsonKeyString[key_String] := key;
jsonKeyString[key_] := ToString[key, InputForm];

sanitizeForJSON[assoc_Association] :=
  Association @ KeyValueMap[jsonKeyString[#1] -> sanitizeForJSON[#2] &, assoc];
sanitizeForJSON[list_List] := sanitizeForJSON /@ list;
sanitizeForJSON[value_String] := value;
sanitizeForJSON[value_Integer] := value;
sanitizeForJSON[value_Real] := value;
sanitizeForJSON[True] := True;
sanitizeForJSON[False] := False;
sanitizeForJSON[Null] := Null;
sanitizeForJSON[value_Rational] := ToString[value, InputForm];
sanitizeForJSON[value_] := ToString[value, InputForm];

csvColumns = {
  "TheoremLabel",
  "Assumptions",
  "Method",
  "Status",
  "Classification",
  "ScopeClass",
  "SurrogateBlindSpots",
  "RepresentativeModelFamily",
  "NoApproximationQ",
  "Source",
  "Acceptance"
};

csvValue[row_Association, key_String] :=
  Module[{value = Lookup[row, key, ""]},
    Which[
      ListQ[value], StringRiffle[value, " | "],
      True, value
    ]
  ];

audit = MainProof`UOMCompletionDecompositionAudit`AuditUOMCompletionDecomposition[];
ledgerRows = MainProof`UOMCompletionDecompositionAudit`UOMCompletionDecompositionLedgerRows[];

certificateBundle = <|
  "Audit" -> audit,
  "LedgerRows" -> ledgerRows
|>;

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "BoundaryFreeze" -> audit["BoundaryFreeze"],
  "LegacyCompletionNegativeControl" -> audit["LegacyCompletionNegativeControl"],
  "SplitCoreCandidate" -> audit["SplitCoreCandidate"],
  "GaussianAugmentation" -> audit["GaussianAugmentation"],
  "Interaction" -> audit["Interaction"],
  "CoupledCompletionContract" -> audit["CoupledCompletionContract"],
  "Summary" -> audit["Summary"],
  "CompanionReports" -> {
    "/home/kray-l8/work/2T/Main/Mathematica/Reports/InterfaceRobustnessAudit.md",
    "/home/kray-l8/work/2T/Main/Mathematica/Reports/CompletionAssumptionDischarge.md"
  },
  "Ledger" -> ledgerRows
|>;

importedAssumptions = {
  "The five-piece boundary package remains an exact finite-dimensional welded-family certificate rather than a finished abstract theorem over all realizations.",
  "The split-controlled completion core is exact and strong-safe in the current WL family, but its theorem-backed text upgrade still requires the focused note/theorem extraction identified in CompletionAssumptionDischarge.",
  "The Gaussian completion layer remains assumption-backed in the live UOM note stack even though its finite-dimensional structural contract is exact in WL.",
  "The coupled split-plus-Gaussian completion result remains contract-level and does not close the full microscopic completion theorem."
};

summaryNote =
  StringRiffle[
    Join[
      {
        "# Completion Decomposition Audit",
        "",
        "Date: `2026-03-16`",
        "",
        "This packet freezes the boundary side around the explicit five-piece strong-safe package and decomposes the completion lane into a split-controlled core, a Gaussian augmentation layer, their interaction, and the retained unsafe regression lane. It does not reopen manuscript insertion; the gate remains `UOM contract corollary only`.",
        "",
        "## Executive Decision",
        "",
        "- boundary five-piece package: `strong-safe` baseline with preserved `mod-null-safe` / `visible-ambiguity` ablations",
        "- legacy exploratory completion lift: `visible-ambiguity` regression lane",
        StringJoin["- split-core completion candidate: `", audit["SplitCoreCandidate", "Classification"], "`"],
        "- Gaussian augmentation: exact structural augmentation only; not an independent ambiguity-class lane",
        StringJoin["- coupled split-plus-Gaussian contract: `", audit["CoupledCompletionContract", "Classification"], "`"],
        StringJoin["- interaction: `", audit["Interaction", "ClassChange"], "` class change; the coupled completion action ", If[audit["Interaction", "ClassChange"] === "none", "matches", "does not match"], " the split-core action exactly"],
        "",
        "## Boundary Freeze",
        "",
        "Strong-safe package:",
        ""
      },
      StringJoin["- ", #] & /@ audit["BoundaryFreeze", "MinimalStrongSafeHypothesisSet"],
      {
        "",
        "Ablation classes:",
        ""
      },
      KeyValueMap[
        StringJoin[
          "- `", #1, "` -> `", #2["Classification"], "`"
        ] &,
        audit["BoundaryFreeze", "AblationClassifications"]
      ],
      {
        "",
        "## Completion Decomposition",
        "",
        "### Split-Controlled Core",
        "",
        StringJoin["- Classification: `", audit["SplitCoreCandidate", "Classification"], "`"],
        StringJoin["- Meaningful distinct candidate: `", ToString[audit["SplitCoreCandidate", "MeaningfulDistinctCandidateQ"], InputForm], "`"],
        "- Why: the split-core witness already sees nontrivial representative action while all transported ambiguity actions vanish.",
        "",
        "### Gaussian Augmentation",
        "",
        "- Standalone ambiguity class: `not applicable`",
        "- Exact role: derived covariance tangent, symplectic/Hamiltonian package, and derived quadrature observables.",
        "- Text-status reminder: still assumption-backed in the live UOM note stack.",
        "",
        "### Interaction With Gaussian Augmentation",
        "",
        StringJoin["- Coupled classification: `", audit["CoupledCompletionContract", "Classification"], "`"],
        StringJoin["- Witness matches split core: `", ToString[audit["Interaction", "WitnessMatchesSplitCoreQ"], InputForm], "`"],
        StringJoin["- Representative action matches split core: `", ToString[audit["Interaction", "RepresentativeActionMatchesSplitCoreQ"], InputForm], "`"],
        StringJoin["- Ambiguity actions match split core: `", ToString[audit["Interaction", "AmbiguityActionsMatchSplitCoreQ"], InputForm], "`"],
        "- Interpretation: Gaussian augmentation does not perform the safety jump; it preserves the split-core class and enriches the completion observable package.",
        "",
        "### Legacy Regression Lane",
        "",
        "- Classification: `visible-ambiguity`",
        "- Purpose: retained exact negative control for completion lifts outside the split-faithful discipline.",
        "",
        "## Working Conclusion",
        "",
        StringJoin["- Recommended completion core: `", audit["Summary", "RecommendedCompletionCore"], "`"],
        StringJoin["- Split-core candidate distinct from Gaussian augmentation is meaningful: `", ToString[audit["Summary", "SplitCoreDistinctCandidateMeaningfulQ"], InputForm], "`"],
        "- Keep the five-piece boundary package frozen on the boundary side, and treat Gaussian completion as an augmentation layer rather than the exact safety core."
      }
    ],
    "\n"
  ];

Put[certificateBundle, certificatePath];
Export[jsonReportPath, sanitizeForJSON[report], "JSON"];
Export[
  ledgerCsvPath,
  Prepend[
    (csvValue[#, #2] & @@@ Tuples[{ledgerRows, csvColumns}]) //
      Partition[#, Length[csvColumns]] &,
    csvColumns
  ],
  "CSV"
];
Export[importedAssumptionsPath, StringRiffle[importedAssumptions, "\n\n"], "Text"];
Export[summaryNotePath, summaryNote, "Text"];

<|
  "ReportPath" -> summaryNotePath,
  "JSONPath" -> jsonReportPath,
  "LedgerPath" -> ledgerCsvPath,
  "CertificatePath" -> certificatePath,
  "ImportedAssumptionsPath" -> importedAssumptionsPath,
  "SplitCoreClassification" -> audit["SplitCoreCandidate", "Classification"],
  "CoupledClassification" -> audit["CoupledCompletionContract", "Classification"],
  "SplitCoreDistinctCandidateMeaningfulQ" -> audit["Summary", "SplitCoreDistinctCandidateMeaningfulQ"]
|>
