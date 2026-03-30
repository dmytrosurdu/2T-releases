rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "CosmologyInterfaceResearch";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
traceabilityPath = FileNameJoin[{reportsDir, "UOMContractTraceability.md"}];
interfacePath = FileNameJoin[{reportsDir, "CosmologyBoundaryInterfaceCandidates.md"}];
gatePath = FileNameJoin[{reportsDir, "ManuscriptInsertionGate.md"}];

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

csvColumns = {
  "TheoremLabel",
  "Assumptions",
  "Method",
  "Status",
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

traceAudit = MainProof`UOMContractTraceability`AuditUOMContractTraceability[];
interfaceAudit = MainProof`MockCosmologyContracts`AuditMockCosmologyInterfaces[];
compressionAudit = MainProof`BoundaryContractCompression`AuditBoundaryContractCompression[];
gateAudit = MainProof`ManuscriptInsertionGate`AuditManuscriptInsertionGate[];

ledgerUpdates = mergeUpdates[
  MainProof`UOMContractTraceability`UOMContractTraceabilityLedgerUpdates[],
  MainProof`MockCosmologyContracts`MockCosmologyContractsLedgerUpdates[],
  MainProof`BoundaryContractCompression`BoundaryContractCompressionLedgerUpdates[],
  MainProof`ManuscriptInsertionGate`ManuscriptInsertionGateLedgerUpdates[]
];

selectedLabels = {
  "task:uom-contract-traceability",
  "task:mock-cosmology-interface-realizations",
  "task:cosmology-interface-boundary-minimality",
  "task:cosmology-interface-completion-minimality",
  "task:boundary-contract-compression",
  "task:manuscript-insertion-gate"
};

ledger =
  Select[
    MainProof`TheoremLedger`MergeTheoremStatuses[
      MainProof`TheoremLedger`BaseTheoremLedger[],
      ledgerUpdates
    ],
    MemberQ[selectedLabels, #["TheoremLabel"]] &
  ];

certificateBundle = <|
  "Traceability" -> traceAudit,
  "Interfaces" -> interfaceAudit,
  "Compression" -> compressionAudit,
  "Gate" -> gateAudit
|>;

report = <|
  "ReportDate" -> DateString[{"ISODate", " ", "Time"}],
  "BoundaryMinimalCandidate" -> interfaceAudit["BoundaryMinimalCandidate"],
  "CompletionMinimalCandidate" -> interfaceAudit["CompletionMinimalCandidate"],
  "AllowedInsertionLevel" -> gateAudit["AllowedInsertionLevel"],
  "TraceabilitySummary" -> traceAudit["Summary"],
  "CandidateSummary" ->
    Association @ KeyValueMap[
      #1 -> <|
        "SatisfyingRealizations" -> #2["SatisfyingRealizations"],
        "NonUOMSatisfyingRealizations" -> #2["NonUOMSatisfyingRealizations"],
        "BoundaryTheoremFollowsQ" -> #2["BoundaryTheoremFollowsQ"],
        "CompletionTheoremFollowsQ" -> #2["CompletionTheoremFollowsQ"]
      |>&,
      interfaceAudit["Candidates"]
    ],
  "CompressionClaims" -> compressionAudit["Claims"],
  "GateReasons" -> gateAudit["Reasons"],
  "Ledger" -> ledger
|>;

Put[certificateBundle, certificatePath];
Export[jsonReportPath, sanitizeForJSON[report], "JSON"];

Export[
  ledgerCsvPath,
  Prepend[
    (csvValue[#, #2] & @@@ Tuples[{ledger, csvColumns}]) //
      Partition[#, Length[csvColumns]] &,
    csvColumns
  ],
  "CSV"
];

traceabilityMarkdown =
  Module[
    {
      rows, boundaryRows, completionRows, boundaryIngredients,
      statusCounts, boundaryStatusSummary, completionStatusSummary
    },
    rows = traceAudit["Rows"];
    boundaryRows = Select[rows, TrueQ[#["BoundaryRoleQ"]] &];
    completionRows = Select[rows, TrueQ[#["CompletionRoleQ"]] && !TrueQ[#["BoundaryRoleQ"]] &];
    boundaryIngredients = Lookup[boundaryRows, "Ingredient"];
    statusCounts =
      KeyValueMap[
        StringJoin["`", #1, "`: `", ToString[#2], "`"] &,
        traceAudit["Summary", "TextStatusCounts"]
      ];
    boundaryStatusSummary =
      StringRiffle[
        Map[
          StringJoin["`", #["Ingredient"], "` -> `", #["TextStatus"], "`"] &,
          boundaryRows
        ],
        "; "
      ];
    completionStatusSummary =
      StringRiffle[
        Map[
          StringJoin["`", #["Ingredient"], "` -> `", #["TextStatus"], "`"] &,
          completionRows
        ],
        "; "
      ];
    StringRiffle[
      Join[
        {
          "# UOM Contract Traceability",
          "",
          "This report maps the current exact WL contract ingredients back to live `Main`, `UOM`, and `2T-LS` sources before any manuscript promotion.",
          "",
          "## LS Pattern",
          "",
          StringJoin[
            "The imported LS pattern remains: ",
            StringRiffle[
              Map[
                Function[row, StringJoin["`", row["Label"], "` ", row["Name"]]],
                traceAudit["LSPattern", "Clauses"]
              ],
              ", "
            ],
            "."
          ],
          "",
          "## Frozen Theorem-Facing Boundary Control Package",
          ""
        },
        StringJoin["- ", #] & /@ boundaryIngredients,
        {
          "",
          "This traceability packet keeps `receiver band-lock` and `co-centering` separate in theorem-facing language and treats the completion additions as extra non-promoted layers rather than part of the frozen boundary package.",
          "",
          "## Ingredient Table",
          ""
        },
        Flatten @ Map[
          Function[row,
            {
              StringJoin["### ", row["Ingredient"]],
              "",
              StringJoin["- Interface class: `", row["InterfaceClass"], "`"],
              StringJoin["- Text status: `", row["TextStatus"], "`"],
              StringJoin["- Boundary role: `", ToString[row["BoundaryRoleQ"], InputForm], "`"],
              StringJoin["- Completion role: `", ToString[row["CompletionRoleQ"], InputForm], "`"],
              StringJoin["- WL artifacts: ", StringRiffle[Map[StringJoin["`", #, "`"] &, row["WLArtifacts"]], ", "]],
              StringJoin["- Main sources: ", StringRiffle[row["MainSources"], "; "]],
              StringJoin["- UOM sources: ", StringRiffle[row["UOMSources"], "; "]],
              StringJoin["- LS pattern echo: ", StringRiffle[Map[StringJoin["`", #, "`"] &, row["LSPattern"]], ", "]],
              StringJoin["- Note: ", row["Note"]],
              ""
            }
          ],
          rows
        ],
        {
          "## Summary",
          "",
          StringJoin["- Boundary ingredients counted here: `", ToString[traceAudit["Summary", "BoundaryIngredientCount"]], "`"],
          StringJoin["- Completion-specific additions counted here: `", ToString[traceAudit["Summary", "CompletionIngredientCount"]], "`"],
          StringJoin["- Candidate-interface ingredients: `", ToString[traceAudit["Summary", "CandidateInterfaceIngredients"]], "`"],
          StringJoin["- Text-status counts: ", StringRiffle[statusCounts, ", "]],
          "",
          StringJoin["- Boundary status split: ", boundaryStatusSummary],
          StringJoin["- Completion status split: ", completionStatusSummary],
          "",
          "Boundary ingredients are now source-traced with theorem-backed, reduced-theorem-backed, and conditional-theorem-backed statuses. The completion additions remain non-promoted: one bounded packaging theorem on explicit split data, one assumption-backed Gaussian layer."
        }
      ],
      "\n"
    ]
  ];

interfaceMarkdown =
  StringRiffle[
    Join[
      {
        "# Cosmology Boundary Interface Candidates",
        "",
        "This report searches for the smallest honest `cosmology theory -> 2T-Main` interface, keeping the LS minimal-interface pattern in view.",
        "",
        "## Candidate Results",
        ""
      },
      Flatten @ KeyValueMap[
        Function[{key, candidate},
          {
            StringJoin["### ", key, " - ", candidate["Name"]],
            "",
            StringJoin["- Purpose: ", candidate["Purpose"]],
            StringJoin["- Required properties: ", StringRiffle[Map[StringJoin["`", #, "`"] &, candidate["RequiredProperties"]], ", "]],
            StringJoin["- Satisfying realizations: ", StringRiffle[candidate["SatisfyingRealizations"], ", "]],
            StringJoin["- Non-UOM satisfying realizations: ", StringRiffle[candidate["NonUOMSatisfyingRealizations"], ", "]],
            StringJoin["- Boundary theorem follows on all satisfying mocks: `", ToString[candidate["BoundaryTheoremFollowsQ"], InputForm], "`"],
            StringJoin["- Completion theorem follows on all satisfying mocks: `", ToString[candidate["CompletionTheoremFollowsQ"], InputForm], "`"],
            StringJoin["- Comment: ", candidate["Comment"]],
            ""
          }
        ],
        interfaceAudit["Candidates"]
      ],
      {
        "## Minimal Winners",
        "",
        StringJoin["- Minimal boundary candidate: `", interfaceAudit["BoundaryMinimalCandidate"], "`"],
        StringJoin["- Minimal completion-aware candidate: `", interfaceAudit["CompletionMinimalCandidate"], "`"],
        "",
        "Interpretation: `I0` is the smallest theory-neutral boundary interface in the mock-tested family, while `I2` is the smallest candidate that still supports completion-aware safety."
      }
    ],
    "\n"
  ];

gateMarkdown =
  StringRiffle[
    Join[
      {
        "# Manuscript Insertion Gate",
        "",
        StringJoin["Allowed insertion level: `", gateAudit["AllowedInsertionLevel"], "`"],
        "",
        "## Why the gate stays here",
        ""
      },
      Map[StringJoin["- ", #] &, gateAudit["Reasons"]],
      {
        "",
        "## Blocked insertion levels",
        ""
      },
      Map[StringJoin["- `", #, "`"] &, gateAudit["BlockedInsertionLevels"]],
      {
        "",
        "Current implication: keep the manuscript-facing statement at the level of a UOM contract corollary; do not yet write a generic cosmology-interface theorem or a microscopic completion theorem from this lane."
      }
    ],
    "\n"
  ];

Export[traceabilityPath, traceabilityMarkdown, "Text"];
Export[interfacePath, interfaceMarkdown, "Text"];
Export[gatePath, gateMarkdown, "Text"];

<|
  "MilestoneStatus" -> If[
    And @@ (Lookup[Values[Join[traceAudit["Claims"], interfaceAudit["Claims"], compressionAudit["Claims"], gateAudit["Claims"]]], "Certified"]),
    "green",
    "check"
  ],
  "BoundaryMinimalCandidate" -> interfaceAudit["BoundaryMinimalCandidate"],
  "CompletionMinimalCandidate" -> interfaceAudit["CompletionMinimalCandidate"],
  "AllowedInsertionLevel" -> gateAudit["AllowedInsertionLevel"]
|>
