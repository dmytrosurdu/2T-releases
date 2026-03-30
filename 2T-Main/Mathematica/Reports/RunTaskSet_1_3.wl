rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

charSuite = MainProof`CharData`RunCharDataExampleSuite[];
transportSuite = MainProof`ActiveTransport`RunActiveTransportExampleSuite[];
transportUpdates = MainProof`ActiveTransport`ActiveTransportLedgerUpdates[];

allCharExamplesPassQ =
  AllTrue[Lookup[charSuite["ValidExamples"], "ValidQ"], TrueQ] &&
  AllTrue[Lookup[charSuite["InvalidExamples"], "ValidQ"], Function[value, value === False]] &&
  AllTrue[
    Join[charSuite["ValidExamples"], charSuite["InvalidExamples"]],
    Function[entry, entry["Status"] === "exact finite-dimensional certificate"]
  ];

ledgerUpdates = Join[
  <|
    "def:2T-char" -> <|
      "Method" -> "Exact association validation plus 3 valid and 3 invalid synthetic examples.",
      "Status" -> If[allCharExamplesPassQ, "exact finite-dimensional certificate", "counterexample found"],
      "Acceptance" -> "3 valid accepted; 3 invalid rejected for the expected reason."
    |>
  |>,
  transportUpdates
];

ledger = MainProof`TheoremLedger`MergeTheoremStatuses[
  MainProof`TheoremLedger`BaseTheoremLedger[],
  ledgerUpdates
];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" -> "Tasks 1-3 only: theorem ledger, TickData/ValidCharDataQ, and active transport audit.",
  "Ledger" -> ledger,
  "Task2Examples" -> charSuite,
  "Task3ActiveTransport" -> transportSuite
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "Ledger" -> (Lookup[#, {"TheoremLabel", "Assumptions", "Method", "Status"}] &) /@ ledger
|>;

Export[
  FileNameJoin[{reportsDir, "TaskSet_1_3_Report.json"}],
  Normal[summaryReport],
  "JSON"
];

Export[
  FileNameJoin[{reportsDir, "TaskSet_1_3_Ledger.csv"}],
  summaryReport["Ledger"],
  "CSV"
];

Put[
  report,
  FileNameJoin[{certificatesDir, "TaskSet_1_3_Certificates.wl"}]
];

report
