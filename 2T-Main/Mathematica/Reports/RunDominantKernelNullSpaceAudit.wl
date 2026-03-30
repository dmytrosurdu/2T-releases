rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];
Get[FileNameJoin[{kernelDir, "DominantKernelNullSpaceAudit.wl"}]];

reportBaseName = "DominantKernelNullSpaceAudit";
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

audit = MainProof`DominantKernelNullSpaceAudit`CertifiedDominantKernelNullSpaceAudit[];

dischargeStatus =
  audit["Claims", "Kernel-subordinated parity-stable mod-null data discharge theorem-2 transversality on the audited family", "Status"];
kernelStatus =
  audit["KernelRouteAudit", "Claims", "Chosen mod-null subspace lies in the kernel of the dominant functional surrogate on the audited borderline family", "Status"];
selectedStatus =
  audit["KernelRouteAudit", "Claims", "Selected scalar generator has nonzero dominant functional surrogate value on the audited borderline family", "Status"];
parityStatus =
  audit["KernelRouteAudit", "Claims", "Chosen mod-null subspace is parity-stable on the audited borderline family", "Status"];

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "TopLineVerdict" ->
    "The next discharge route is aligned with the exact WL lane familywise: on the audited borderline family, the chosen parity-stable mod-null subspace lies inside the kernel of the dominant-functional surrogate while the selected generator has nonzero value, so theorem-2 transversality is discharged automatically there.",
  "Audit" -> audit,
  "UpdatedNote" -> "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex",
  "ResidualBoundary" -> {
    "This is an exact finite-dimensional certificate for the discharge schema on the audited family.",
    "It does not yet construct a canonical dominant-null parity-stable mod-null subspace in the abstract Main/UOM theorem stack.",
    "The scalar bridge assumptions from theorem 1 remain imported exactly as before, including the explicit c_Lambda != 0 gate and the model-specific scalar-lift datum."
  }
|>;

summaryNote =
  StringRiffle[
    {
      "# Dominant-Kernel Null-Space Audit",
      "",
      "Date: `2026-03-29`",
      "",
      report["TopLineVerdict"],
      "",
      "## Exact status",
      "",
      StringJoin["- discharge schema: `", dischargeStatus, "`"],
      StringJoin["- mod-null subspace in dominant-functional kernel: `", kernelStatus, "`"],
      StringJoin["- selected generator nonzero under dominant-functional surrogate: `", selectedStatus, "`"],
      StringJoin["- parity stability of the chosen mod-null subspace: `", parityStatus, "`"],
      "",
      "## Reading",
      "",
      "- The new note-level step is now explicit: if a parity-stable mod-null subspace is subordinate to the descended dominant-functional kernel, then the selected scalar line is automatically transverse to it.",
      "- On the audited borderline family, that route is exact and discharges the transversality clause familywise.",
      "- This still does not prove a canonical abstract construction of such a subspace from the current UOM/Main notes.",
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
  "DischargeStatus" -> dischargeStatus,
  "KernelStatus" -> kernelStatus,
  "SelectedStatus" -> selectedStatus,
  "ParityStatus" -> parityStatus
|>
