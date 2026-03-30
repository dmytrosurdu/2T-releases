rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "DelayedDescendantReentryAudit.wl"}]];

reportBaseName = "DelayedDescendantReentryAudit";
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

artifactPointer[path_String, key_String] := StringJoin[path, "::", key];
artifactPointer[path_String, keys_List] := artifactPointer[path, StringRiffle[keys, "."]];

audit = MainProof`DelayedDescendantReentryAudit`CertifiedDelayedDescendantReentryAudit[];
ledgerRows = MainProof`DelayedDescendantReentryAudit`DelayedDescendantReentryLedgerRows[];

ledgerRowsWithArtifacts = {
  Join[
    ledgerRows[[1]],
    <|
      "CertificateArtifact" -> "Deferred",
      "CounterexampleArtifact" ->
        artifactPointer[certificatePath, {"Audit", "ThresholdAudit", "Witness"}]
    |>
  ],
  Join[
    ledgerRows[[2]],
    <|
      "CertificateArtifact" ->
        artifactPointer[certificatePath, {"Audit", "CanonicalLiftAudit"}],
      "CounterexampleArtifact" -> "Deferred"
    |>
  ],
  Join[
    ledgerRows[[3]],
    <|
      "CertificateArtifact" ->
        artifactPointer[certificatePath, {"Audit", "CanonicalLiftAudit"}],
      "CounterexampleArtifact" -> "Deferred"
    |>
  ],
  Join[
    ledgerRows[[4]],
    <|
      "CertificateArtifact" ->
        artifactPointer[certificatePath, {"Audit", "FurtherQuotientAudit", "BoundaryBorderlineModel"}],
      "CounterexampleArtifact" ->
        artifactPointer[certificatePath, {"Audit", "FurtherQuotientAudit", "BoundaryUnsafeCountermodel"}]
    |>
  ],
  Join[
    ledgerRows[[5]],
    <|
      "CertificateArtifact" ->
        artifactPointer[certificatePath, {"Audit", "FurtherQuotientAudit", "BoundaryBorderlineModel"}],
      "CounterexampleArtifact" ->
        artifactPointer[certificatePath, {"Audit", "FurtherQuotientAudit", "BoundaryUnsafeCountermodel"}]
    |>
  ]
};

certificateBundle = <|
  "Audit" -> audit,
  "LedgerRows" -> ledgerRowsWithArtifacts
|>;

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "Model" -> audit["Model"],
  "ThresholdAudit" -> audit["ThresholdAudit"],
  "CanonicalLiftAudit" -> audit["CanonicalLiftAudit"],
  "FurtherQuotientAudit" -> audit["FurtherQuotientAudit"],
  "Claims" -> audit["Claims"],
  "ResidualBoundary" -> audit["ResidualBoundary"],
  "Ledger" -> ledgerRowsWithArtifacts
|>;

importedAssumptions = {
  "This report stays at exact finite-dimensional certificate level and does not promote the delayed-to-descendant route to an abstract theorem.",
  "The split-threshold check uses the explicit effective inequality from UOM/completion_sector_split_model_body.tex as written, with exact positive symbolic surrogate parameters.",
  "The split-to-descendant bridge is represented here by a model-specific scalar inverse on the exact one-dimensional split response line of the current WL contract.",
  "That scalar inverse should not be confused with a derived microscopic completion-to-descendant lift theorem from the split note.",
  "The current Main-visible quotient is the scalar welded quotient already audited in the Mathematica lane; no distinct V^1 or AQFT/HLS physical quotient object is constructed in this report.",
  "The post-Main-visible obstruction lane is represented by the existing exact physical/null-ideal and controlled boundary countermodels, so it shows conditionality rather than a theorem about the exact delayed witness family itself."
};

summaryNote =
  StringRiffle[
    Join[
      {
        "# Delayed-to-Descendant Reentry Audit",
        "",
        "Date: `2026-03-29`",
        "",
        "This packet audits the proposed delayed-to-descendant reentry route in the current Mathematica lane without promoting it to a theorem. It separates what the exact branch model can certify from what still depends on a new bridge theorem or an added null-ideal / selector hypothesis.",
        "",
        "## Executive Decision",
        "",
        StringJoin[
          "- split threshold forces `c_\\Lambda != 0`: `",
          audit["Claims", "Split-threshold regime forces c_Lambda != 0", "Status"],
          "`"
        ],
        StringJoin[
          "- exact scalar split-to-descendant lift surrogate exists: `",
          audit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"],
          "`"
        ],
        StringJoin[
          "- lifted scalar class survives current Main-visible quotient: `",
          audit["Claims", "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- automatic further post-Main-visible reentry from split localization alone: `",
          audit["Claims", "Further post-Main-visible reentry is automatic from split-controlled localization alone", "Status"],
          "`"
        ],
        StringJoin[
          "- conditional mod-null reentry lane on audited borderline family: `",
          audit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"],
          "`"
        ],
        "",
        "## Exact Witnesses",
        "",
        StringJoin[
          "- split-threshold witness with `c_\\Lambda = 0`: `",
          ToString[audit["ThresholdAudit", "NamedWitness"], InputForm],
          "`"
        ],
        StringJoin[
          "- Main-visible quotient coordinate matrix: `",
          ToString[audit["Model", "MainVisibleQuotientCoordinate"], InputForm],
          "`"
        ],
        StringJoin[
          "- descended scalar functional on that quotient: `",
          ToString[audit["Model", "MainVisibleDescendedFunctional"], InputForm],
          "`"
        ],
        "",
        "## Route Reading",
        "",
        "- The threshold check shows that the effective split threshold does not itself force seam-coefficient nonvanishing; `c_\\Lambda != 0` remains an extra assumption in this lane.",
        "- The certified split contract does admit an exact scalar inverse from the completion block to a descendant representative modulo `A^-`, but that is a model-specific surrogate and not a derived bridge theorem from the note stack.",
        "- On that surrogate scalar line there is no extra collapse on the current Main-visible quotient: nonzero scalar means nonzero quotient class and nonzero accepted welded image.",
        "- The downstream obstruction is real: existing exact physical/null-ideal and controlled boundary countermodels show that split-controlled localization alone does not force automatic further reentry on every post-Main-visible quotient.",
        "- A conditional mod-null lane does exist on the audited borderline family, matching the conditional theorem reading rather than an unconditional end-to-end closure.",
        "",
        "## Residual Boundary",
        ""
      },
      StringJoin["- ", #] & /@ audit["ResidualBoundary"]
    ],
    "\n"
  ];

Put[certificateBundle, certificatePath];
Export[jsonReportPath, sanitizeForJSON[report], "JSON"];
Export[
  ledgerCsvPath,
  Prepend[
    (csvValue[#, #2] & @@@ Tuples[{ledgerRowsWithArtifacts, csvColumns}]) //
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
  "ThresholdStatus" ->
    audit["Claims", "Split-threshold regime forces c_Lambda != 0", "Status"],
  "ScalarLiftStatus" ->
    audit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"],
  "MainVisibleStatus" ->
    audit["Claims", "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family", "Status"],
  "FurtherReentryStatus" ->
    audit["Claims", "Further post-Main-visible reentry is automatic from split-controlled localization alone", "Status"],
  "ConditionalModNullStatus" ->
    audit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"]
|>
