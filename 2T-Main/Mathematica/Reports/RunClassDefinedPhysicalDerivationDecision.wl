rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "ClassDefinedPhysicalDerivationDecision";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
boundaryDeltaPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "BoundaryDelta.txt"]}];
decisionNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];
propositionSnippetPath =
  FileNameJoin[{reportsDir, "PhysicalInvarianceUnderAmbiguityTriviality_Proposition.tex"}];
correctionNotePath = FileNameJoin[{reportsDir, "CorrectedDominantScalarReduction.md"}];

compileArtifacts = <|
  "Main" -> FileNameJoin[{reportsDir, "Compile_Main_main_theorem.log"}],
  "UOMParent" -> FileNameJoin[{reportsDir, "Compile_UOM_summability_split_note.log"}],
  "FragmentParentingNote" -> FileNameJoin[{reportsDir, "Compile_UOM_fragment_parenting.txt"}]
|>;

artifactPointer[path_String, key_String] := StringJoin[path, "::", key];
artifactPointer[path_String, keys_List] := artifactPointer[path, StringRiffle[keys, "."]];

jsonReady[expr_] := expr /. missing_Missing :> ToString[missing, InputForm];

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

buildEndToEndCertificate[] :=
  Module[
    {
      model, transportAudit, chi, epsilon, u, shift, j0, nBasis, q, beta,
      calData, calReport, b, tick, tickValidation, canonData, canonReport, milestoneClaims
    },
    model = MainProof`ActiveTransport`CertifiedActiveTransportModel[];
    transportAudit = MainProof`ActiveTransport`AuditActiveTransportModel[model];
    chi = MainProof`ActiveTransport`DerivedChi[model];
    epsilon = chi . model["Jdesc"];
    u = model["Aminus"];
    shift = {2, -1};
    j0 = Expand[model["Jdesc"] + u.shift];
    nBasis = MainProof`CommonProofTools`KernelBasisFromFunctional[chi];
    q = {{2, 1}, {1, 3}};
    beta = 5;
    calData = MainProof`Calibration`CalibrationData[
      chi,
      epsilon model["Jdesc"],
      beta,
      q,
      "KernelBasis" -> nBasis,
      "Aminus" -> u,
      "Representative" -> model["Jdesc"],
      "Epsilon" -> epsilon
    ];
    calReport = MainProof`Calibration`VerifyCalibrationProperties[calData];
    b = calReport["B"];
    tick = MainProof`CharData`TickData[
      1,
      <|
        "Eminus" -> Length[model["Jdesc"]],
        "Aminus" -> u,
        "XiClass" -> <|"Representative" -> j0, "Basis" -> u|>,
        "J0" -> j0,
        "Chi" -> chi,
        "Epsilon" -> epsilon,
        "B" -> b,
        "Ochar" -> <|"Name" -> "TransportExportedChar", "SourceModel" -> model["Name"]|>,
        "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> epsilon|>
      |>
    ];
    tickValidation = MainProof`CharData`ValidateCharData[tick];
    canonData = MainProof`CanonicalRepresentative`CanonicalRepresentativeData[
      u,
      b,
      j0,
      "Chi" -> chi,
      "Epsilon" -> epsilon
    ];
    canonReport = MainProof`CanonicalRepresentative`VerifyCanonicalRepresentativeProperties[canonData];
    milestoneClaims = <|
      "TransportCertified" -> And @@ TrueQ /@ Lookup[
        transportAudit["Claims"] /@ {
          "Annihilation of Aminus",
          "Constancy on affine class",
          "Normalization chi = nu^-1 rho",
          "Continuity of dominant scalar",
          "Sign defined on full branch",
          "Local constancy of branch sign on sign-defined components"
        },
        "Certified"
      ],
      "CalibrationCertified" -> And @@ TrueQ /@ {
        calReport["ProductDecomposition"],
        calReport["Symmetry"],
        calReport["PositiveDefinite"],
        calReport["OrthogonalToKerChi"],
        calReport["OrthogonalToAminus"],
        calReport["jSharpNorm"],
        calReport["AdmissibleChoice_jSharp_equals_epsilon_JXi"]
      },
      "TickDataValid" -> TrueQ[tickValidation["Valid"]],
      "JcanCertified" -> And @@ TrueQ /@ {
        canonReport["UFullColumnRank"],
        canonReport["GA_PositiveDefinite"],
        canonReport["ChiAnnihilatesAminus"],
        canonReport["JcanInAffineClass"],
        canonReport["ChiJcanEqualsEpsilon"],
        canonReport["Orthogonality"],
        canonReport["UniqueMinimizer"],
        canonReport["ProjectorFormula"],
        canonReport["RepresentativeShiftInvariant"]
      }
    |>;
    <|
      "TransportAudit" -> transportAudit,
      "CalibrationReport" -> calReport,
      "TickValidation" -> tickValidation,
      "CanonicalRepresentativeReport" -> canonReport,
      "MilestoneClaims" -> milestoneClaims,
      "MilestoneStatus" -> If[And @@ TrueQ /@ Values[milestoneClaims], "green", "blocked"]
    |>
  ];

buildDecisionConclusion[ambiguitySuite_Association, classSuite_Association] :=
  Module[
    {
      invisible = ambiguitySuite["InvisibleExample"],
      nullIdeal = ambiguitySuite["NullIdealExample"],
      visible = ambiguitySuite["VisibleExample"],
      classNullIdeal = classSuite["NullIdealExample"],
      classVisible = classSuite["VisibleExample"]
    },
    If[
      And @@ TrueQ /@ {
        invisible["BracketTrivialOnTheNose"],
        invisible["DifferenceFormula"],
        nullIdeal["ActsIntoNullIdeal"],
        classNullIdeal["ClassDefinedOnPhysicalQuotient"],
        visible["PhysicallyVisible"],
        classVisible["VisibleFailureWitness"]
      },
      "Main gets a physically class-defined derivation exactly under ambiguity-triviality on the physical sector or, more generally, modulo the physical null ideal. This is not automatic: exact visible countermodels exist. The current proof stack has not yet derived that hypothesis from the Main/UOM assumptions, so selector necessity remains unresolved.",
      "The ambiguity-triviality decision lane is incomplete or inconsistent."
    ]
  ];

decisionNoteText[decision_String] :=
  StringRiffle[
    {
      "# Class-Defined Physical Derivation Decision",
      "",
      decision,
      "",
      "## Finite-cutoff criterion",
      "",
      "- For every ambiguity shift A in Aminus, delta_(J + A) - delta_J = ad_A exactly.",
      "- The induced physical derivation is representative-independent on the nose when ambiguity directions bracket-trivially on the physical sector.",
      "- More generally, it is representative-independent on the physical quotient when ambiguity directions act into the physical null ideal.",
      "- Exact visible countermodels show that this criterion is genuinely needed and is not automatic from the weak 2T_char interface alone.",
      "",
      "## Consequence for Main",
      "",
      "- Path A remains available under a clean ambiguity-triviality or null-ideal-triviality hypothesis.",
      "- Path B remains live if that hypothesis cannot be derived from Main/UOM inputs: a preferred selector or calibration may still be needed, which would promote the LoG lane."
    },
    "\n"
  ];

propositionSnippetText =
  StringRiffle[
    {
      "\\begin{proposition}[Physical invariance under ambiguity-triviality]",
      "\\label{prop:Main-physical-invariance-ambiguity}",
      "Fix an accepted tick \\(k\\), and let \\(J_1,J_2\\in[\\Xi^{(1)}_{\\Lambda_k}]\\), so",
      "\\(J_2-J_1\\in\\mathcal A^-_{\\Lambda_k}\\). Define",
      "\\[",
      "\\delta^{(i)}_{\\Lambda_k}:=\\{J_i,-\\}_{\\mathrm P,\\Lambda_k}",
      "\\qquad (i=1,2).",
      "\\]",
      "If every ambiguity direction \\(A\\in\\mathcal A^-_{\\Lambda_k}\\) acts trivially on the",
      "physical observable sector, then \\(\\delta^{(1)}_{\\Lambda_k}\\) and",
      "\\(\\delta^{(2)}_{\\Lambda_k}\\) agree there. More generally, if for every",
      "\\(A\\in\\mathcal A^-_{\\Lambda_k}\\) and every physical local observable \\(F\\) the",
      "Peierls bracket \\(\\{A,F\\}_{\\mathrm P,\\Lambda_k}\\) vanishes in the physical quotient",
      "\\textnormal{(equivalently: belongs to the physical null ideal)}, then the induced",
      "physical Peierls derivation is independent of the chosen representative in",
      "\\([\\Xi^{(1)}_{\\Lambda_k}]\\).",
      "\\end{proposition}",
      "",
      "\\begin{proof}",
      "Since \\(J_2-J_1\\in\\mathcal A^-_{\\Lambda_k}\\), bilinearity of the Peierls bracket gives",
      "\\[",
      "\\delta^{(2)}_{\\Lambda_k}(F)-\\delta^{(1)}_{\\Lambda_k}(F)",
      "=\\{J_2-J_1,F\\}_{\\mathrm P,\\Lambda_k}.",
      "\\]",
      "If every ambiguity direction acts trivially on the physical observable sector, the",
      "right-hand side vanishes there, so the two derivations agree on physical observables.",
      "Under the weaker null-ideal hypothesis, the same identity shows that the difference",
      "vanishes after passage to the physical quotient, hence the induced physical derivation",
      "depends only on the class \\([\\Xi^{(1)}_{\\Lambda_k}]\\).",
      "\\end{proof}"
    },
    "\n"
  ];

charSuite = MainProof`CharData`RunCharDataExampleSuite[];
transportSuite = MainProof`ActiveTransport`RunActiveTransportExampleSuite[];
calibrationSuite = MainProof`Calibration`RunCalibrationExampleSuite[];
canonicalSuite = MainProof`CanonicalRepresentative`RunCanonicalRepresentativeExampleSuite[];
endToEnd = buildEndToEndCertificate[];
quotientSuite = MainProof`QuotientDescent`RunQuotientDescentExampleSuite[];
representabilitySuite = MainProof`Representability`RunRepresentabilityExampleSuite[];
regularitySuite = MainProof`JcanRegularity`RunJcanRegularityExampleSuite[];
comparisonSuite = MainProof`CalibrationComparison`RunCalibrationComparisonExampleSuite[];
hamSuite = MainProof`Hamiltonization`RunHamiltonizationExampleSuite[];
ambiguitySuite = MainProof`AmbiguityPhysicalSector`RunAmbiguityPhysicalSectorExampleSuite[];
classDefinedSuite = MainProof`ClassDefinedDerivation`RunClassDefinedDerivationExampleSuite[];

decision = buildDecisionConclusion[ambiguitySuite, classDefinedSuite];

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
  "thm:active-response-transport-minimal" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task3_5ActiveTransport", "CertifiedModel"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task3_5ActiveTransport", "BrokenModels"}]
  |>,
  "thm:char-weak-interface" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task3_5ActiveTransport", "CertifiedModel"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task3_5ActiveTransport", "BrokenModels"}]
  |>,
  "prop:minimal-transport-calibration" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task4Calibration", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task4Calibration", "BrokenExamples"}]
  |>,
  "thm:finite-cutoff-Jcan" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task5CanonicalRepresentative", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task5CanonicalRepresentative", "BrokenExamples"}]
  |>,
  "prop:Jcan-orth" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task5CanonicalRepresentative", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task5CanonicalRepresentative", "BrokenExamples"}]
  |>,
  "thm:dominant-quotient-descent" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task6QuotientDescent", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task6QuotientDescent", "BrokenExamples"}]
  |>,
  "cor:dominant-quotient-constancy" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task6QuotientDescent", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task6QuotientDescent", "BrokenExamples"}]
  |>,
  "task:source-insertion-representability" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task7Representability", "ValidExamples"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task7Representability", "BrokenExamples"}]
  |>,
  "task:witness-comparison-reduction" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task8WitnessComparison"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task8WitnessComparison", "UnscaledChiCompatibilityWitness"}]
  |>,
  "task:Jcan-branch-regularity" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task9JcanBranchRegularity", "ValidExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task9JcanBranchRegularity", "DegenerateExample"}]
  |>,
  "task:calibration-comparison" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task11CalibrationComparison", "NonInvariantExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task11CalibrationComparison", "NonInvariantExample", "DeltaJ"}]
  |>,
  "task:ambiguity-trivial-on-physical-sector" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "InvisibleExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "VisibleExample"}]
  |>,
  "task:ambiguity-trivial-mod-null-ideal" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "NullIdealExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "VisibleExample"}]
  |>,
  "task:ambiguity-physically-visible" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "VisibleExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "InvisibleExample"}]
  |>,
  "task:class-defined-physical-derivation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task15ClassDefinedPhysicalDerivation", "NullIdealExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task15ClassDefinedPhysicalDerivation", "VisibleExample"}]
  |>,
  "task:Peierls-odd-derivation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task12PeierlsOddDerivation"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task14AmbiguityPhysicalSector", "EvenJBrokenExample"}]
  |>,
  "task:delta-calibration-sensitivity" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task13CalibrationSensitivity", "InvisibleSensitivityExample"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task13CalibrationSensitivity", "VisibleSensitivityExample"}]
  |>,
  "thm:finite-cutoff-canonical-odd-spectral-selection" -> <|
    "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred"
  |>,
  "thm:Main-Peierls-Hamiltonization" -> <|
    "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred"
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
  "Closedness of Aminus, continuity of branch data, and Hilbertizability are still represented by finite-dimensional surrogates rather than independent infinite-dimensional constructions.",
  "Source representability is split into an exact algebraic image-membership problem and a still-imported sufficient-locality condition.",
  "The physical quotient and the physical null ideal are represented only by explicit finite-dimensional subspaces in bracket models; no abstract AQFT/HLS construction is attempted.",
  "The new class-defined-derivation lane identifies the exact ambiguity-triviality criterion, but it does not yet derive that criterion from the current Main/UOM hypotheses.",
  "LoG spectral certification and the abstract Main Peierls/AQFT tail remain outside the Mathematica core."
};

boundaryDelta = {
  "The physical representative-independence question is now reduced to the exact identity delta_(J + A) - delta_J = ad_A on explicit bracket models.",
  "The null-ideal refinement is now machine-audited: ambiguity directions need not vanish on the nose if they act into the physical null ideal.",
  "Visible and invisible countermodels are both explicit, so the ambiguity-triviality criterion is sharp rather than heuristic.",
  "The remaining finite-cutoff boundary is no longer the criterion itself, but whether current Main/UOM hypotheses imply ambiguity-triviality or null-ideal triviality on the physical sector."
};

Export[decisionNotePath, decisionNoteText[decision], "Text"];
Export[propositionSnippetPath, propositionSnippetText, "Text"];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" ->
    "Ambiguity-triviality and class-defined physical derivation decision lane on explicit finite-cutoff bracket models.",
  "DecisionQuestion" -> "Does Main get a physically class-defined derivation, or does it need a preferred selector?",
  "MilestoneStatus" -> If[
    MainProof`AmbiguityPhysicalSector`AmbiguityPhysicalSectorLedgerUpdates[]["task:ambiguity-trivial-on-physical-sector", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`AmbiguityPhysicalSector`AmbiguityPhysicalSectorLedgerUpdates[]["task:ambiguity-trivial-mod-null-ideal", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`AmbiguityPhysicalSector`AmbiguityPhysicalSectorLedgerUpdates[]["task:ambiguity-physically-visible", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`ClassDefinedDerivation`ClassDefinedDerivationLedgerUpdates[]["task:class-defined-physical-derivation", "Status"] === "finite-dimensional-theorem-certificate" &&
      And @@ (FileExistsQ /@ Values[compileArtifacts]),
    "green",
    "mixed"
  ],
  "Decision" -> decision,
  "Ledger" -> ledger,
  "Task2Schema" -> charSuite,
  "Task3_5ActiveTransport" -> transportSuite,
  "Task4Calibration" -> calibrationSuite,
  "Task5CanonicalRepresentative" -> canonicalSuite,
  "Task6QuotientDescent" -> quotientSuite,
  "Task7Representability" -> representabilitySuite,
  "Task9JcanBranchRegularity" -> regularitySuite,
  "Task11CalibrationComparison" -> comparisonSuite,
  "Task12PeierlsOddDerivation" -> hamSuite["OddDerivationExample"],
  "Task13CalibrationSensitivity" -> <|
    "InvisibleSensitivityExample" -> hamSuite["InvisibleSensitivityExample"],
    "VisibleSensitivityExample" -> hamSuite["VisibleSensitivityExample"]
  |>,
  "Task14AmbiguityPhysicalSector" -> ambiguitySuite,
  "Task15ClassDefinedPhysicalDerivation" -> classDefinedSuite,
  "EndToEnd_WeakInterface_to_Jcan" -> endToEnd,
  "CompileArtifacts" -> compileArtifacts,
  "CorrectionNote" -> correctionNotePath,
  "DecisionNote" -> decisionNotePath,
  "PropositionSnippet" -> propositionSnippetPath,
  "ImportedAssumptions" -> importedAssumptions,
  "BoundaryDelta" -> boundaryDelta
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "DecisionQuestion" -> report["DecisionQuestion"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "Decision" -> report["Decision"],
  "Ledger" -> ledger
|>;

Export[jsonReportPath, jsonReady @ Normal[summaryReport], "JSON"];
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
