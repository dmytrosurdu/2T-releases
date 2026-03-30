rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "TransportedBoundarySelectorDecision";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
boundaryDeltaPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "BoundaryDelta.txt"]}];
decisionNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];
snippetPath = FileNameJoin[{reportsDir, "BoundaryBlockCentralityCriterionRemark.tex"}];

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

decisionNoteText[decision_Association] :=
  StringRiffle[
    {
      "# Transported Boundary Selector Decision",
      "",
      decision["Sentence"],
      "",
      "## Decision basis",
      "",
      "- Only the diagonal controlled ambiguity blocks matter on the controlled boundary algebra.",
      "- No tested natural boundary null ideal is both stable and nontrivial: the readout-kernel/block-trace-zero candidate trivializes all audited controlled dynamics, while the state-invisible candidate is not stable under the controlled derivation action.",
      "- The actual exported transported ambiguity basis admits both an exact safe realization and an exact unsafe realization under split+welded boundary restriction.",
      "- Therefore boundary safety is not forced by the weak-interface transport structure itself.",
      "",
      "## Main consequence",
      "",
      "The boundary criterion is now structural only if an additional selector or theorem-level split hypothesis is supplied. In the present finite-cutoff exact audit, the selector lane must be promoted if Main needs a nontrivial canonical boundary derivation without extra assumptions."
    },
    "\n"
  ];

snippetText[decision_Association] :=
  StringRiffle[
    {
      "\\begin{remark}[Controlled boundary block-centrality criterion]",
      "On the controlled boundary algebra \\(\\mathcal O_{\\partial,\\mathrm{ctrl}}=\\{\\sum_i \\Pi_i^{(A)}\\otimes O_i^{(B)}\\}\\), only the diagonal controlled ambiguity blocks contribute after controlled projection: \\(P_{\\mathrm{ctrl}}([K,O])=\\sum_i \\Pi_i^{(A)}\\otimes [K_i^{(B)},O_i^{(B)}]\\). Hence representative-independence reduces to block-centrality of the surviving ambiguity blocks, either on the nose or modulo the chosen boundary null ideal. In the present finite-cutoff audit, the transported weak-interface ambiguity basis does not force this criterion structurally; visible diagonal controlled ambiguity survives in an exact transported witness, so a preferred selector is required unless an additional split+welded boundary hypothesis is imposed.",
      "\\end{remark}"
    },
    "\n"
  ];

charSuite = MainProof`CharData`RunCharDataExampleSuite[];
blockSuite = MainProof`BoundaryBlockCentrality`RunBoundaryBlockCentralityExampleSuite[];
nullSuite = MainProof`BoundaryNullIdealCandidates`RunBoundaryNullIdealCandidateSuite[];
transportedSuite = MainProof`TransportedBoundaryAudit`RunTransportedBoundaryAuditSuite[];
selectorDecision = MainProof`SelectorNecessityDecision`SelectorNecessityDecision[];

allCharExamplesPassQ =
  AllTrue[Lookup[charSuite["ValidExamples"], "ValidQ"], TrueQ] &&
  AllTrue[Lookup[charSuite["InvalidExamples"], "ValidQ"], Function[value, value === False]] &&
  AllTrue[
    Join[charSuite["ValidExamples"], charSuite["InvalidExamples"]],
    Function[entry, entry["Status"] === "exact finite-dimensional certificate"]
  ];

schemaUpdate = <|
  "def:2T-char" -> <|
    "Method" -> "Exact association validation plus 3 valid and 3 invalid synthetic examples.",
    "Status" -> If[allCharExamplesPassQ, "exact finite-dimensional certificate", "counterexample found"],
    "ScopeClass" -> "schema-validator",
    "Acceptance" -> "3 valid accepted; 3 invalid rejected for the expected reason.",
    "RepresentativeModelFamily" ->
      "valid_basic_identity, valid_nontrivial_gram, valid_zero_ambiguity; invalid_parity_tag, invalid_chi_on_ambiguity, invalid_positive_form",
    "NoApproximationQ" -> True
  |>
|>;

artifactDecorations = <|
  "def:2T-char" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task2Schema", "ValidExamples"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task2Schema", "InvalidExamples"}]
  |>,
  "thm:controlled-boundary-block-centrality-strong" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "StrongTheorem_2x2"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "UnsafeFamily", "WitnessImage"}]
  |>,
  "thm:controlled-boundary-block-centrality-mod-null" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "BorderlineFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "UnsafeFamily", "WitnessImage"}]
  |>,
  "rem:expectation-invisibility-insufficient" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "UnsafeFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task20BoundaryBlockCentrality", "UnsafeFamily", "WitnessImage"}]
  |>,
  "task:boundary-null-ideal-candidates" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task21BoundaryNullIdealCandidates"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task21BoundaryNullIdealCandidates", "CandidateAudits", "readout-kernel"}]
  |>,
  "task:transported-boundary-ambiguity-audit" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task22TransportedBoundaryAudit"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task22TransportedBoundaryAudit", "TransportedUnsafeWitness"}]
  |>,
  "task:selector-necessity-decision" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task23SelectorNecessityDecision"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task22TransportedBoundaryAudit", "TransportedUnsafeWitness"}]
  |>
|>;

ledgerUpdates = mergeUpdates[
  schemaUpdate,
  MainProof`ActiveTransport`ActiveTransportLedgerUpdates[],
  MainProof`Calibration`CalibrationLedgerUpdates[],
  MainProof`CanonicalRepresentative`CanonicalRepresentativeLedgerUpdates[],
  MainProof`QuotientDescent`QuotientDescentLedgerUpdates[],
  MainProof`Representability`RepresentabilityLedgerUpdates[],
  MainProof`JcanRegularity`JcanRegularityLedgerUpdates[],
  MainProof`CalibrationComparison`CalibrationComparisonLedgerUpdates[],
  MainProof`Hamiltonization`HamiltonizationLedgerUpdates[],
  MainProof`AmbiguityPhysicalSector`AmbiguityPhysicalSectorLedgerUpdates[],
  MainProof`ClassDefinedDerivation`ClassDefinedDerivationLedgerUpdates[],
  MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[],
  MainProof`BoundaryBlockCentrality`BoundaryBlockCentralityLedgerUpdates[],
  MainProof`BoundaryNullIdealCandidates`BoundaryNullIdealCandidateLedgerUpdates[],
  MainProof`TransportedBoundaryAudit`TransportedBoundaryAuditLedgerUpdates[],
  MainProof`SelectorNecessityDecision`SelectorNecessityDecisionLedgerUpdates[],
  artifactDecorations
];

ledger = Map[
  normalizeArtifactFields,
  MainProof`TheoremLedger`MergeTheoremStatuses[
    MainProof`TheoremLedger`BaseTheoremLedger[],
    ledgerUpdates
  ]
];

importedAssumptions = {
  "Closedness of Aminus, continuity of branch data, and Hilbertizability are still represented only by finite-dimensional surrogates rather than independent infinite-dimensional constructions.",
  "The transported ambiguity audit uses exact split+welded boundary realizations of the exported weak-interface data; it does not derive a unique boundary operator realization from the abstract transport theorem alone.",
  "No tested natural boundary null ideal yields a nontrivial, stable quotient that simultaneously absorbs the transported unsafe witness.",
  "Expectation-level invisibility on boundary-classical states remains weaker than operator-level or mod-null class-definedness.",
  "LoG selector data and the AQFT/HLS tail remain outside the Mathematica core, so the selector-necessity decision is finite-cutoff and boundary-restricted."
};

boundaryDelta = {
  "The controlled boundary theorem has been sharpened to block-centrality: only the surviving diagonal controlled ambiguity blocks matter after controlled projection.",
  "Natural boundary null ideals were compared exactly. The readout-kernel and block-trace-zero candidates are stable but overlarge and trivialize the audited controlled dynamics; the state-invisible candidate is nontrivial but not stable.",
  "The actual transported ambiguity basis from the certified weak-interface export now has exact safe and unsafe split+welded boundary realizations.",
  "Because visible diagonal controlled ambiguity survives in an exact transported witness, boundary safety is not forced structurally by the current transport stack, and the selector lane must be promoted if Main needs a canonical nontrivial boundary derivation."
};

Export[decisionNotePath, decisionNoteText[selectorDecision], "Text"];
Export[snippetPath, snippetText[selectorDecision], "Text"];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" -> "Transported boundary ambiguity criterion / selector-necessity decision at exact finite cutoff.",
  "DecisionQuestion" -> "Does the actual transported ambiguity class satisfy the boundary-safe criterion for structural reasons under split+welded restriction, or must a preferred selector be promoted?",
  "MilestoneStatus" -> If[
    MainProof`BoundaryBlockCentrality`BoundaryBlockCentralityLedgerUpdates[]["thm:controlled-boundary-block-centrality-strong", "Status"] === "exact finite-dimensional certificate" &&
      MainProof`BoundaryBlockCentrality`BoundaryBlockCentralityLedgerUpdates[]["thm:controlled-boundary-block-centrality-mod-null", "Status"] === "exact finite-dimensional certificate" &&
      MainProof`BoundaryNullIdealCandidates`BoundaryNullIdealCandidateLedgerUpdates[]["task:boundary-null-ideal-candidates", "Status"] === "exact finite-dimensional certificate" &&
      MainProof`TransportedBoundaryAudit`TransportedBoundaryAuditLedgerUpdates[]["task:transported-boundary-ambiguity-audit", "Status"] === "exact finite-dimensional certificate" &&
      MainProof`SelectorNecessityDecision`SelectorNecessityDecisionLedgerUpdates[]["task:selector-necessity-decision", "Status"] === "exact finite-dimensional certificate",
    "green",
    "mixed"
  ],
  "SelectorDecision" -> selectorDecision,
  "Ledger" -> ledger,
  "Task2Schema" -> charSuite,
  "Task20BoundaryBlockCentrality" -> blockSuite,
  "Task21BoundaryNullIdealCandidates" -> nullSuite,
  "Task22TransportedBoundaryAudit" -> transportedSuite,
  "Task23SelectorNecessityDecision" -> selectorDecision,
  "TheoremStatements" -> MainProof`BoundaryBlockCentrality`BoundaryBlockCentralityTheoremStatements[],
  "DecisionNote" -> decisionNotePath,
  "BoundaryBlockCentralitySnippet" -> snippetPath,
  "ImportedAssumptions" -> importedAssumptions,
  "BoundaryDelta" -> boundaryDelta
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "DecisionQuestion" -> report["DecisionQuestion"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "SelectorDecision" -> report["SelectorDecision"],
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
Export[importedAssumptionsPath, StringRiffle[importedAssumptions, "\n\n"], "Text"];
Export[boundaryDeltaPath, StringRiffle[boundaryDelta, "\n\n"], "Text"];
Put[report, certificatePath];

report
