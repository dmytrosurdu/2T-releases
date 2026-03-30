rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "DelayedDescendantReentryAudit.wl"}]];

reportBaseName = "TwoBridgeTheoremsPlanAudit";
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

audit = MainProof`DelayedDescendantReentryAudit`CertifiedDelayedDescendantReentryAudit[];

theorem1 = <|
  "Name" -> "Split-controlled scalar descendant lift",
  "Status" -> If[
    audit["Claims", "Split-threshold regime forces c_Lambda != 0", "Status"] === "counterexample found" &&
      audit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"] === "exact finite-dimensional certificate" &&
      audit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family", "Status"] === "exact finite-dimensional certificate" &&
      audit["Claims", "Canonical scalar representative survives the current Main-visible scalar quotient in the exact family", "Status"] === "exact finite-dimensional certificate",
    "exact finite-dimensional certificate for the conditional theorem schema",
    "deferred"
  ],
  "Reading" -> {
    "The split threshold does not force c_Lambda != 0, so the theorem must keep that as an explicit hypothesis.",
    "The exact scalar split-to-descendant lift surrogate exists on the audited one-dimensional split response line.",
    "The lifted scalar class survives both the descendant ambiguity quotient and the current Main-visible scalar quotient in the current exact family."
  },
  "NoteLocation" -> "/home/kray-l8/work/2T/UOM/split_controlled_completion_lift_note.tex",
  "Boundaries" -> {
    "The scalar lift remains model-specific and should not be read as a derived microscopic bridge theorem from split data alone.",
    "The theorem is honest only as a bridge into D^- plus the current Main-visible quotient."
  }
|>;

theorem2 = <|
  "Name" -> "Conditional mod-null reentry",
  "Status" -> If[
    audit["Claims", "Further post-Main-visible reentry is automatic from split-controlled localization alone", "Status"] === "counterexample found" &&
      audit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"] === "exact finite-dimensional certificate",
    "exact finite-dimensional certificate for the conditional theorem schema",
    "deferred"
  ],
  "Reading" -> {
    "Automatic further reentry is false in the audited exact countermodel suites.",
    "A conditional mod-null lane does exist on the certified borderline family.",
    "So the strongest honest second bridge is conditional reentry on a selected scalar line in a mod-null quotient."
  },
  "NoteLocation" -> "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex",
  "Boundaries" -> {
    "No unconditional V^1 or physical/null-ideal reentry theorem is supported by the present exact lane.",
    "The mod-null quotient must stay explicit theorem data, not a hidden consequence of split localization."
  }
|>;

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "TopLineVerdict" ->
    "The newly inserted bridge theorems are aligned with the Mathematica lane provided they remain conditional exactly as written: theorem 1 is a scalar D^- bridge with c_Lambda != 0 explicit, and theorem 2 is a conditional mod-null reentry theorem rather than an unconditional V^1 closure.",
  "UnderlyingAudit" -> audit,
  "Theorem1" -> theorem1,
  "Theorem2" -> theorem2,
  "UpdatedNotes" -> {
    "/home/kray-l8/work/2T/UOM/split_controlled_completion_lift_note.tex",
    "/home/kray-l8/work/2T/UOM/delayed_odd_control_note.tex",
    "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex"
  },
  "ResidualBoundary" -> {
    "The LaTeX note edits do not change the exact WL status boundary: theorem 1 is still conditional on c_Lambda != 0 and on scalar lift data, while theorem 2 is still conditional on an explicit mod-null quotient datum.",
    "No new Mathematica evidence was found for proving c_Lambda != 0 from the split threshold or for deriving unconditional further reentry."
  }
|>;

summaryNote =
  StringRiffle[
    {
      "# Two Bridge Theorems Plan Audit",
      "",
      "Date: `2026-03-29`",
      "",
      report["TopLineVerdict"],
      "",
      "## Theorem 1",
      "",
      StringJoin["- status: `", theorem1["Status"], "`"],
      "- required reading: keep `c_\\Lambda \\neq 0` explicit; the scalar split-to-descendant lift is supported only as the audited one-dimensional surrogate into `\\mathfrak D^-` and the current Main-visible quotient.",
      StringJoin["- note location: `", theorem1["NoteLocation"], "`"],
      "",
      "## Theorem 2",
      "",
      StringJoin["- status: `", theorem2["Status"], "`"],
      "- required reading: keep the mod-null quotient and selector data explicit; automatic further reentry remains ruled out by the exact countermodel lane.",
      StringJoin["- note location: `", theorem2["NoteLocation"], "`"],
      "",
      "## Residual Boundary",
      "",
      "- theorem 1 should not be paraphrased as a derived microscopic split-to-descendant theorem without the added scalar lift datum.",
      "- theorem 2 should not be paraphrased as an unconditional `\\mathcal V^1` or physical/null-ideal reentry theorem.",
      "- the current exact lane still supports only the conditional theorem program, not a single end-to-end closure theorem."
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
  "Theorem1Status" -> theorem1["Status"],
  "Theorem2Status" -> theorem2["Status"]
|>
