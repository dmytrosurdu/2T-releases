rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "TransverseModNullReductionAudit.wl"}]];

reportBaseName = "TransverseModNullReductionAudit";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
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

audit = MainProof`TransverseModNullReductionAudit`CertifiedTransverseModNullReductionAudit[];

reductionStatus =
  audit["Claims", "The remaining mod-null step reduces to line/null-ideal transversality plus quotient construction", "Status"];
transversalityStatus =
  audit["SelectedLineAudit", "Claims", "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family", "Status"];
quotientStatus =
  audit["SelectedLineAudit", "Claims", "Parity-stable transversality gives a nonzero quotient class on the audited selected line", "Status"];
parityStatus =
  audit["SelectedLineAudit", "Claims", "Odd parity descends on the audited quotient line by sign", "Status"];

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "TopLineVerdict" ->
    "The clean intermediate theorem target is aligned with the exact WL lane in the right scope: once a parity-stable mod-null subspace is transverse to the selected one-dimensional odd line, the quotient is injective on that line and the remaining mod-null step is only quotient construction plus descended odd parity.",
  "Audit" -> audit,
  "UpdatedNote" -> "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex",
  "ResidualBoundary" -> {
    "This is still only a finite-dimensional certificate for the reduction schema.",
    "The unresolved abstract problem is to construct a parity-stable mod-null subspace for the Main scalar descendant line in D^- and prove the required transversality there.",
    "Nothing in the present WL lane upgrades that transversality hypothesis to an automatic consequence of split-controlled localization alone."
  }
|>;

summaryNote =
  StringRiffle[
    {
      "# Transverse Mod-Null Reduction Audit",
      "",
      "Date: `2026-03-29`",
      "",
      report["TopLineVerdict"],
      "",
      "## Exact status",
      "",
      StringJoin["- reduction schema: `", reductionStatus, "`"],
      StringJoin["- selected-line transversality: `", transversalityStatus, "`"],
      StringJoin["- nonzero quotient image on the line: `", quotientStatus, "`"],
      StringJoin["- descended odd parity on the quotient line: `", parityStatus, "`"],
      "",
      "## Reading",
      "",
      "- The new intermediate lemma is the right theorem to try next: it isolates the remaining content to one statement, namely that the selected scalar line meets the chosen mod-null ideal trivially.",
      "- In the audited finite-dimensional borderline family, that transversality condition exactly gives the injective quotient step on the selected line, and odd parity then descends by sign.",
      "- The report does not certify the abstract Main/UOM transversality hypothesis automatically; it only certifies that once that hypothesis is supplied, theorem 2 no longer needs a hidden extra kernel argument.",
      "",
      "## Note location",
      "",
      StringJoin["- `", report["UpdatedNote"], "`"]
    },
    "\n"
  ];

Put[report, certificatePath];
Export[jsonReportPath, sanitizeForJSON[report], "JSON"];
Export[summaryNotePath, summaryNote, "Text"];

<|
  "ReportPath" -> summaryNotePath,
  "JSONPath" -> jsonReportPath,
  "CertificatePath" -> certificatePath,
  "ReductionStatus" -> reductionStatus,
  "TransversalityStatus" -> transversalityStatus,
  "QuotientStatus" -> quotientStatus,
  "ParityStatus" -> parityStatus
|>
