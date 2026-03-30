rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "CommonProofTools.wl"}]];
Get[FileNameJoin[{kernelDir, "TheoremLedger.wl"}]];
Get[FileNameJoin[{kernelDir, "ActiveTransport.wl"}]];
Get[FileNameJoin[{kernelDir, "BoundarySectors.wl"}]];
Get[FileNameJoin[{kernelDir, "BoundarySplitWeldedModels.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMWeldedChannel.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMFactPreservation.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMWeldedBoundaryAudit.wl"}]];

reportBaseName = "UOMWeldedBoundaryAudit";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
summaryNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];

artifactPointer[path_String, key_String] := StringJoin[path, "::", key];
artifactPointer[path_String, keys_List] := artifactPointer[path, StringRiffle[keys, "."]];

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

mergeUpdates[parts__Association] := Merge[{parts}, Apply[Join]];

normalizeArtifactFields[row_Association] :=
  Join[
    row,
    <|
      "CertificateArtifact" -> Replace[row["CertificateArtifact"], _Missing -> "Deferred"],
      "CounterexampleArtifact" -> Replace[row["CounterexampleArtifact"], _Missing -> "Deferred"]
    |>
  ];

csvColumns = {
  "TheoremLabel",
  "Assumptions",
  "Method",
  "Status",
  "ScopeClass",
  "SurrogateBlindSpots",
  "CertificateArtifact",
  "CounterexampleArtifact",
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

weldedChannelAudit = MainProof`UOMWeldedChannel`AuditUOMWeldedChannel[];
factAudit = MainProof`UOMFactPreservation`AuditUOMFactPreservation[];
boundaryAudit = MainProof`UOMWeldedBoundaryAudit`AuditUOMWeldedBoundaryModel[];
decision = MainProof`UOMWeldedBoundaryAudit`UOMWeldedBoundaryDecision[];

artifactUpdates = <|
  "task:uom-welded-bandlocked-channel" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedChannel"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedChannel", "LegacyUnsafeWitness"}]
  |>,
  "task:uom-subcutoff-fact-preservation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TaskUOMFactPreservation"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-transported-welded-boundary-audit" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedBoundaryAudit"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedBoundaryAudit", "Model", "Channel"}]
  |>,
  "task:uom-welded-boundary-decision" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedBoundaryDecision"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TaskUOMWeldedChannel", "LegacyUnsafeWitness"}]
  |>
|>;

ledgerUpdates = mergeUpdates[
  MainProof`UOMWeldedChannel`UOMWeldedChannelLedgerUpdates[],
  MainProof`UOMFactPreservation`UOMFactPreservationLedgerUpdates[],
  MainProof`UOMWeldedBoundaryAudit`UOMWeldedBoundaryLedgerUpdates[],
  artifactUpdates
];

ledger = Map[
  normalizeArtifactFields,
  MainProof`TheoremLedger`MergeTheoremStatuses[
    MainProof`TheoremLedger`BaseTheoremLedger[],
    ledgerUpdates
  ]
];

importedAssumptions = {
  "The welded-channel lane uses the exact compressed welded LoG line and exact accepted-record projection as the physical boundary image; it does not yet reconstruct the full unreduced completion-sector operator algebra from the Gaussian SK kernels.",
  "Band-lock, co-centering, and one-dimensional compressed-channel structure are imported from the proved UOM welded-shape/locking notes and then used exactly in the finite-dimensional boundary realization.",
  "The reworked boundary decision supersedes the generic splitBlock-based unsafe witness only on the exact welded/fact-preserving channel; it does not by itself settle full microscopic selector-independence away from that channel."
};

summaryNote =
  StringRiffle[
    {
      "# UOM Welded Boundary Audit",
      "",
      decision["Sentence"],
      "",
      "## What changed",
      "",
      "- The old audit realized transported ambiguity by arbitrary exact images in A ⊗ B.",
      "- The reworked audit factors the boundary image through the descended dominant scalar on the exact co-centered, band-locked welded LoG line.",
      "- Exact accepted-record preservation below cutoff is enforced in the finite-dimensional surrogate of the QND/CPTP lane.",
      "",
      "## Consequence",
      "",
      "The previous visible boundary ambiguity countermodels are not compatible with the UOM welded/fact-preserving realization. The remaining open boundary is the full unreduced completion-sector operator reconstruction from the SK Gaussian data."
    },
    "\n"
  ];

Export[summaryNotePath, summaryNote, "Text"];
Export[importedAssumptionsPath, StringRiffle[importedAssumptions, "\n\n"], "Text"];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" -> "UOM-faithful rework of the welded boundary audit with exact band-locked LoG channel and exact sub-cutoff fact preservation.",
  "MilestoneStatus" -> If[
    decision["Decision"] === "UOM-welded boundary-safe",
    "green",
    "mixed"
  ],
  "Decision" -> decision,
  "Ledger" -> ledger,
  "TaskUOMWeldedChannel" -> weldedChannelAudit,
  "TaskUOMFactPreservation" -> factAudit,
  "TaskUOMWeldedBoundaryAudit" -> boundaryAudit,
  "TaskUOMWeldedBoundaryDecision" -> decision,
  "ImportedAssumptions" -> importedAssumptions,
  "SummaryNote" -> summaryNotePath
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "Decision" -> report["Decision"],
  "Ledger" -> ledger
|>;

Export[jsonReportPath, sanitizeForJSON @ summaryReport, "JSON"];
Export[
  ledgerCsvPath,
  Prepend[
    Map[Function[row, csvValue[row, #] & /@ csvColumns], ledger],
    csvColumns
  ],
  "CSV"
];
Put[report, certificatePath];

report
