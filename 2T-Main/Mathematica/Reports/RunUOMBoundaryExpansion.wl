rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "UOMBoundaryExpansion";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
summaryNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];
hypothesisNotePath = FileNameJoin[{reportsDir, "MinimalUOMBoundarySafeHypotheses.md"}];
boundaryCorollaryPath = FileNameJoin[{reportsDir, "UOMWeldedBoundaryCanonicalizationCorollary.tex"}];
boundaryRemarkPath = FileNameJoin[{reportsDir, "MainAbstractVsUOMBoundaryRemark.tex"}];

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

trackAAudit = MainProof`UOMBoundaryCanonicalization`AuditUOMBoundaryCanonicalization[];
trackADecision = MainProof`UOMBoundaryCanonicalization`UOMBoundaryCanonicalizationDecision[];
trackB1Audit = MainProof`UOMPulseCharacterization`AuditUOMPulseCharacterization[];
trackB2Audit = MainProof`UOMAcceptedChannel`AuditUOMAcceptedChannel[];
trackB3Audit = MainProof`UOMActionSelection`AuditUOMActionSelection[];
trackCAudit = MainProof`UOMWeldedAblation`AuditUOMWeldedAblation[];
trackDAudit = MainProof`LegacyBoundaryNegativeControls`LegacyBoundaryNegativeControlAudit[];
trackEAudit = MainProof`SKCompletionSectorReconstruction`AuditSKCompletionSectorReconstruction[];
trackF1Audit = MainProof`UOMIntrinsicResponseMap`AuditUOMIntrinsicResponseMap[];
trackF2Audit = MainProof`UOMSplitControlledLift`AuditUOMSplitControlledLift[];
trackF3Audit = MainProof`UOMSKGaussianCompletion`AuditUOMSKGaussianCompletion[];
trackF4Audit = MainProof`UOMCompletionAmbiguityAudit`AuditUOMCompletionAmbiguity[];
trackFDecision = MainProof`UOMCompletionAmbiguityAudit`SplitFaithfulCompletionDecision[];
legacySelectorDecision = MainProof`SelectorNecessityDecision`SelectorNecessityDecision[];

artifactDecorations = <|
  "task:uom-welded-boundary-ambiguity-annihilation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackA"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TrackD"}]
  |>,
  "task:uom-welded-boundary-class-defined-derivation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackA"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"LegacySelectorDecision"}]
  |>,
  "task:uom-welded-boundary-calibration-invariance" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackA", "Model", "CalibrationData"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"LegacySelectorDecision"}]
  |>,
  "task:uom-welded-boundary-nontriviality" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackA", "ObservableAction"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-welded-log-shape" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB1"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-co-centering" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB1"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-bandlock-to-receiver" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB1"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-compressed-line-rank" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB1"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-channel-factorization" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB2"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TrackB2", "RecordBreakingWitness"}]
  |>,
  "task:uom-uplift-isometry-surrogate" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB2"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-app-cptp-surrogate" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB2"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-accepted-record-preservation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB2"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TrackB2", "RecordBreakingWitness"}]
  |>,
  "task:uom-p3-admissibility" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB3"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-sk-gaussian-selection" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB3"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-welded-family-selection" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackB3"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-ablation-fact-preservation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "Cases", "RemoveFactPreservation"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-ablation-bandlock" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "Cases", "RelaxBandLock"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-ablation-compressed-rank" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "Cases", "RaiseCompressedRank"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-ablation-co-centering" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "Cases", "RelaxCoCentering"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:uom-ablation-descended-scalar-factorization" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "Cases", "ReplaceDescendedScalarFactorization"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TrackD"}]
  |>,
  "task:uom-minimal-boundary-safe-hypothesis-set" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackC", "MinimalStrongSafeHypothesisSet"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:legacy-generic-visible-ambiguity" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackD"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:legacy-generic-splitblock-countermodels" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackD"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-minimal-gaussian-completion-reconstruction" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackE"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-completion-ambiguity-visibility" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackE"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-completion-boundary-lift" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackE"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-intrinsic-response-map-contract" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackF1"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-split-controlled-lift-contract" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackF2"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-gaussian-completion-contract" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackF3"}],
    "CounterexampleArtifact" -> "None"
  |>,
  "task:sk-split-faithful-completion-ambiguity-decision" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"TrackF4"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"TrackE"}]
  |>
|>;

ledgerUpdates = mergeUpdates[
  MainProof`UOMWeldedChannel`UOMWeldedChannelLedgerUpdates[],
  MainProof`UOMFactPreservation`UOMFactPreservationLedgerUpdates[],
  MainProof`UOMWeldedBoundaryAudit`UOMWeldedBoundaryLedgerUpdates[],
  MainProof`UOMPulseCharacterization`UOMPulseCharacterizationLedgerUpdates[],
  MainProof`UOMAcceptedChannel`UOMAcceptedChannelLedgerUpdates[],
  MainProof`UOMActionSelection`UOMActionSelectionLedgerUpdates[],
  MainProof`UOMBoundaryCanonicalization`UOMBoundaryCanonicalizationLedgerUpdates[],
  MainProof`UOMWeldedAblation`UOMWeldedAblationLedgerUpdates[],
  MainProof`LegacyBoundaryNegativeControls`LegacyBoundaryNegativeControlLedgerUpdates[],
  MainProof`SKCompletionSectorReconstruction`SKCompletionSectorLedgerUpdates[],
  MainProof`UOMIntrinsicResponseMap`UOMIntrinsicResponseMapLedgerUpdates[],
  MainProof`UOMSplitControlledLift`UOMSplitControlledLiftLedgerUpdates[],
  MainProof`UOMSKGaussianCompletion`UOMSKGaussianCompletionLedgerUpdates[],
  MainProof`UOMCompletionAmbiguityAudit`UOMCompletionAmbiguityLedgerUpdates[],
  artifactDecorations
];

ledger =
  Map[
    normalizeArtifactFields,
    MainProof`TheoremLedger`MergeTheoremStatuses[
      MainProof`TheoremLedger`BaseTheoremLedger[],
      ledgerUpdates
    ]
  ];

newTaskLabels = {
  "task:uom-welded-boundary-ambiguity-annihilation",
  "task:uom-welded-boundary-class-defined-derivation",
  "task:uom-welded-boundary-calibration-invariance",
  "task:uom-welded-boundary-nontriviality",
  "task:uom-welded-log-shape",
  "task:uom-co-centering",
  "task:uom-bandlock-to-receiver",
  "task:uom-compressed-line-rank",
  "task:uom-channel-factorization",
  "task:uom-uplift-isometry-surrogate",
  "task:uom-app-cptp-surrogate",
  "task:uom-accepted-record-preservation",
  "task:uom-p3-admissibility",
  "task:uom-sk-gaussian-selection",
  "task:uom-welded-family-selection",
  "task:uom-ablation-fact-preservation",
  "task:uom-ablation-bandlock",
  "task:uom-ablation-compressed-rank",
  "task:uom-ablation-co-centering",
  "task:uom-ablation-descended-scalar-factorization",
  "task:uom-minimal-boundary-safe-hypothesis-set",
  "task:legacy-generic-visible-ambiguity",
  "task:legacy-generic-splitblock-countermodels",
  "task:sk-minimal-gaussian-completion-reconstruction",
  "task:sk-completion-ambiguity-visibility",
  "task:sk-completion-boundary-lift",
  "task:sk-intrinsic-response-map-contract",
  "task:sk-split-controlled-lift-contract",
  "task:sk-gaussian-completion-contract",
  "task:sk-split-faithful-completion-ambiguity-decision"
};

newLedgerRows = Select[ledger, MemberQ[newTaskLabels, #["TheoremLabel"]] &];

importedAssumptions = {
  "The welded-safe boundary corollary is certified only as a compressed welded-channel contract result on the exact preserved compiled/welded boundary image and not yet on the full unreduced completion-sector operator algebra.",
  "The grounded UOM contract lane uses exact finite-dimensional surrogates for welded pulse shape, accepted-record preservation, uplift, and SK family selection; it is not yet a full reconstruction of the underlying pulse/export/uplift machinery.",
  "The ablation audit is minimal only relative to the exact one-at-a-time finite-dimensional family encoded in WL.",
  "The exploratory completion-sector lift is an honest exact algebraic negative probe but not yet a theorem about all completion-sector reconstructions compatible with the SK data.",
  "The split-faithful completion lane added here is also contract-level: it rebuilds the completion audit from intrinsic response, controlled split, derived Gaussian completion, and lifted fact preservation, but it is not yet the full microscopic SK completion theorem."
};

summaryNote =
  StringRiffle[
    {
      "# UOM Boundary Expansion",
      "",
      "## Previous audit state",
      "",
      legacySelectorDecision["Sentence"],
      "",
      "## Current welded-safe state",
      "",
      trackADecision["Sentence"],
      "",
      "## Layered conclusion",
      "",
      "- Main remains meaningful as an abstract interface/calibration/class-definedness layer.",
      "- The physically canonical boundary statement is now certified only as a compressed welded-channel contract corollary on the exact UOM welded and fact-preserving boundary image.",
      "- The old completion result remains only an exploratory exact algebraic negative probe: some appended completion lifts can make ambiguity visible again.",
      "- The new split-faithful completion contract keeps ambiguity dead in the exact contract model, but the full microscopic completion-sector theorem remains open.",
      "",
      "## Immediate implementation outcome",
      "",
      "- Track A is green: ambiguity annihilation, class-defined derivation, calibration invariance, and nontriviality are exact on the preserved welded boundary image.",
      "- Track B is grounded by exact WL contracts for welded pulse structure, accepted-channel factorization, uplift/CPTP surrogates, and admissible welded family selection.",
      "- Track C identifies the strong-safe package used by the current exact family and shows which single ablations downgrade to mod-null safety or visible ambiguity.",
      "- Track D preserves the old unsafe generic lane as negative control.",
      "- Track E now records the exploratory algebraic completion lift, classified as visible-again.",
      "- Track F rebuilds the completion audit from intrinsic response, split control, derived Gaussian completion, and lifted fact preservation; in that exact contract lane the completion ambiguity decision is strong-safe."
    },
    "\n"
  ];

hypothesisNote =
  StringRiffle[
    Join[
      {
        "# Minimal UOM Boundary Safe Hypotheses",
        "",
        "## Exact strong-safe package in the current WL ablation family",
        ""
      },
      StringJoin["- ", #] & /@ trackCAudit["MinimalStrongSafeHypothesisSet", "Hypotheses"],
      {
        "",
        "## Exact one-at-a-time ablation outcomes",
        "",
        StringJoin["- remove exact accepted-record preservation: ", trackCAudit["Cases", "RemoveFactPreservation", "Classification"]],
        StringJoin["- relax receiver band-lock: ", trackCAudit["Cases", "RelaxBandLock", "Classification"]],
        StringJoin["- raise compressed rank: ", trackCAudit["Cases", "RaiseCompressedRank", "Classification"]],
        StringJoin["- relax co-centering: ", trackCAudit["Cases", "RelaxCoCentering", "Classification"]],
        StringJoin["- replace descended-scalar factorization: ", trackCAudit["Cases", "ReplaceDescendedScalarFactorization", "Classification"]],
        "",
        "## Interpretation",
        "",
        trackCAudit["MinimalStrongSafeHypothesisSet", "Reason"]
      }
    ],
    "\n"
  ];

boundaryCorollarySnippet =
  StringRiffle[
    {
      "\\begin{corollary}[UOM welded boundary canonicalization under the compressed contract]",
      "Under the exact compressed welded-channel contract, the transported ambiguity directions are annihilated exactly on the preserved welded boundary image, the induced boundary derivation is representative-independent on the compiled welded boundary algebra, and calibration changes become invisible after welded projection. Moreover, the surviving class representative acts nontrivially on a compiled welded boundary observable. This statement is certified only on the preserved welded boundary image and does not yet identify the full unreduced completion-sector operator algebra.",
      "\\end{corollary}"
    },
    "\n"
  ];

boundaryRemarkSnippet =
  StringRiffle[
    {
      "\\begin{remark}[Main-abstract versus UOM boundary canonicality]",
      "The abstract Main interface, ambiguity criterion, and calibration-comparison machinery remain meaningful independently of the UOM welded realization. What is currently UOM-instantiated is a compressed welded-channel contract corollary: on the exact welded and fact-preserving boundary image, the transported ambiguity class is annihilated and the induced boundary derivation is canonical there. The completion-sector extension beyond that preserved welded image remains open, and the current split-faithful completion lane should still be read as contract-level rather than as the final microscopic theorem.",
      "\\end{remark}"
    },
    "\n"
  ];

Export[summaryNotePath, summaryNote, "Text"];
Export[importedAssumptionsPath, StringRiffle[importedAssumptions, "\n\n"], "Text"];
Export[hypothesisNotePath, hypothesisNote, "Text"];
Export[boundaryCorollaryPath, boundaryCorollarySnippet, "Text"];
Export[boundaryRemarkPath, boundaryRemarkSnippet, "Text"];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" -> "Honest reclassification of the welded-safe boundary theorem as a compressed contract corollary, plus exploratory and split-faithful completion-sector audits.",
  "MilestoneStatus" -> If[
    AllTrue[newLedgerRows, #["Status"] === "exact finite-dimensional certificate" &],
    "green",
    "mixed"
  ],
  "PreviousSelectorDecision" -> legacySelectorDecision,
  "CurrentBoundaryDecision" -> trackADecision,
  "TrackA" -> trackAAudit,
  "TrackB1" -> trackB1Audit,
  "TrackB2" -> trackB2Audit,
  "TrackB3" -> trackB3Audit,
  "TrackC" -> trackCAudit,
  "TrackD" -> trackDAudit,
  "TrackE" -> trackEAudit,
  "TrackF1" -> trackF1Audit,
  "TrackF2" -> trackF2Audit,
  "TrackF3" -> trackF3Audit,
  "TrackF4" -> trackF4Audit,
  "TrackFDecision" -> trackFDecision,
  "Ledger" -> ledger,
  "SummaryNote" -> summaryNotePath,
  "MinimalHypothesisNote" -> hypothesisNotePath,
  "BoundaryCorollarySnippet" -> boundaryCorollaryPath,
  "BoundaryRemarkSnippet" -> boundaryRemarkPath,
  "ImportedAssumptions" -> importedAssumptions,
  "QuestionsAnswered" -> <|
    "ExactFiniteCutoffTheoremOnWeldedBoundaryImage" -> trackADecision["Sentence"],
    "EssentialUOMAssumptionsInExactAblationFamily" -> trackCAudit["MinimalStrongSafeHypothesisSet"],
    "ExploratoryCompletionLiftOutcome" -> <|
      "Classification" -> trackEAudit["Classification"],
      "Sentence" -> "In the exploratory exact algebraic completion lift, ambiguity is visible again while the certified welded boundary image is still recovered by boundary projection."
    |>,
    "SplitFaithfulCompletionContractOutcome" -> <|
      "Classification" -> trackF4Audit["Classification"],
      "Decision" -> trackFDecision["Decision"],
      "Sentence" -> trackFDecision["Sentence"]
    |>
  |>
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "PreviousSelectorDecision" -> legacySelectorDecision,
  "CurrentBoundaryDecision" -> trackADecision,
  "QuestionsAnswered" -> report["QuestionsAnswered"],
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
