rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "DelayedSelectedLinePromotionAudit.wl"}]];

reportBaseName = "DelayedSelectedLinePromotionAudit";
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

audit = MainProof`DelayedSelectedLinePromotionAudit`CertifiedDelayedSelectedLinePromotionAudit[];
ledgerRows = MainProof`DelayedSelectedLinePromotionAudit`DelayedSelectedLinePromotionLedgerRows[];

certificateBundle = <|
  "Audit" -> audit,
  "LedgerRows" -> ledgerRows
|>;

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "Model" -> audit["Model"],
  "SymbolicFamily" -> audit["SymbolicFamily"],
  "RawNonuniquenessCounterexample" -> audit["RawNonuniquenessCounterexample"],
  "Claims" -> audit["Claims"],
  "ResidualBoundary" -> audit["ResidualBoundary"],
  "Ledger" -> ledgerRows
|>;

importedAssumptions = {
  "This audit uses the certified polynomial branch model and the exact accepted-channel contract already present in the Main/UOM Mathematica lane.",
  "The detector-factorized seam family is treated here as the exact finite-dimensional surrogate of the theorem-visible delayed seam packet.",
  "Accepted-record-preserving filler toggles are retained upstairs in the microscopic quotient; the exact report separately checks that they remain visible on delayed seam data even though they are current-record invisible.",
  "The packet-level extractor theorem is proved in the manuscript note; this exact report checks it only on the certified branch family.",
  "The quotient-kernel triviality and universal microscopic selected-survival theorems are proved in the manuscript note; this exact report checks them only on the certified branch family.",
  "The selected-witness promoted survival theorem is proved in the manuscript note; this exact report checks it only for the certified selected microscopic witness family.",
  "The downstream post-HLS physical-transfer theorem and the post-HLS Z2 rigidity theorem remain open and are not derived by this report."
};

summaryNote =
  StringRiffle[
    Join[
      {
        "# Delayed Selected-Line Promotion Audit",
        "",
        "Date: `2026-03-21`",
        "",
        "This packet does not claim the downstream post-HLS transfer or Z2 rigidity theorems. It certifies the exact packet-level microscopic-to-seam extractor on the current branch family, certifies trivial extractor kernel and universal microscopic selected-survival on that quotient family, certifies selected-witness promoted survival for the selected microscopic witness family, and records the raw nonuniqueness counterexample that forces the theorem to stay quotient-first.",
        "",
        "## Executive Decision",
        "",
        StringJoin[
          "- packet-level microscopic-to-seam extractor: `",
          audit["Claims", "Canonical microscopic-to-seam packet extractor is well-defined on the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- quotient-kernel triviality after ambiguity/seam-invisible quotienting: `",
          audit["Claims", "Microscopic-to-seam extractor kernel is trivial after quotient on the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- universal microscopic selected-survival on the delayed quotient: `",
          audit["Claims", "Every nonzero microscopic delayed quotient class has nonzero extracted seam image on the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- selected-witness promoted delayed selected-line survival: `",
          audit["Claims", "Selected-witness microscopic class survives with nonzero delayed coordinate and welded image on the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- detector-factorized delayed selected line: `",
          audit["Claims", "Detector-factorized seam family lies on one delayed selected line", "Status"],
          "`"
        ],
        StringJoin[
          "- delayed welded image factorization: `",
          audit["Claims", "Delayed welded image is exactly the delayed coordinate times the LoG projector", "Status"],
          "`"
        ],
        StringJoin[
          "- filler-toggle delayed seam obstruction: `",
          audit["Claims", "Accepted-record-preserving filler toggles remain distinct on the delayed seam readout in the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- pulse-rigid ambiguity invisibility at seam level: `",
          audit["Claims", "Pulse-rigid ambiguity directions are invisible to the delayed seam extractor in the exact family", "Status"],
          "`"
        ],
        StringJoin[
          "- raw seam-invisible shift before quotient: `",
          audit["Claims", "Nonzero raw seam-invisible shifts exist before quotient", "Status"],
          "`"
        ],
        "",
        "## Exact Counterexample That Forces Quotient-First Formulation",
        "",
        StringJoin[
          "- selected source: `",
          ToString[audit["RawNonuniquenessCounterexample", "SelectedSource"], InputForm],
          "`"
        ],
        StringJoin[
          "- shifted raw source: `",
          ToString[audit["RawNonuniquenessCounterexample", "ShiftedRawSource"], InputForm],
          "`"
        ],
        StringJoin[
          "- common delayed coordinate: `",
          ToString[audit["RawNonuniquenessCounterexample", "SelectedCoordinate"], InputForm],
          "`"
        ],
        StringJoin[
          "- common delayed welded image: `",
          ToString[audit["RawNonuniquenessCounterexample", "SelectedImage"], InputForm],
          "`"
        ],
        "",
        "## Scope Boundary",
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
  "PacketExtractorStatus" ->
    audit["Claims", "Canonical microscopic-to-seam packet extractor is well-defined on the exact family", "Status"],
  "QuotientKernelStatus" ->
    audit["Claims", "Microscopic-to-seam extractor kernel is trivial after quotient on the exact family", "Status"],
  "UniversalSelectedSurvivalStatus" ->
    audit["Claims", "Every nonzero microscopic delayed quotient class has nonzero extracted seam image on the exact family", "Status"],
  "SelectedWitnessSurvivalStatus" ->
    audit["Claims", "Selected-witness microscopic class survives with nonzero delayed coordinate and welded image on the exact family", "Status"],
  "DetectorFactorizedLineStatus" ->
    audit["Claims", "Detector-factorized seam family lies on one delayed selected line", "Status"],
  "RawSeamInvisibleShiftStatus" ->
    audit["Claims", "Nonzero raw seam-invisible shifts exist before quotient", "Status"]
|>
