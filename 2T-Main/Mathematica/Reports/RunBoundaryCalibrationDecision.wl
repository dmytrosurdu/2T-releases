rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "BoundaryCalibrationDecision";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
boundaryDeltaPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "BoundaryDelta.txt"]}];
decisionNotePath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, ".md"]}];
mainSnippetPath = FileNameJoin[{reportsDir, "BoundaryRecordRestrictionRemark.tex"}];
splitSnippetPath = FileNameJoin[{reportsDir, "SplitNoteControlledBoundaryRemark.tex"}];

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

decisionNoteText[decision_Association] :=
  StringRiffle[
    {
      "# Boundary Calibration Decision",
      "",
      decision["Sentence"],
      "",
      "## Exact boundary-sector split",
      "",
      "- The strict record sector D_A ⊗ 1_B is automatically invariant under the boundary readout, but the induced derivation there collapses.",
      "- The controlled sector Sum_i Pi^(A) ⊗ O_i^(B) is the nontrivial boundary algebra.",
      "- Under controlled projection, only the diagonal controlled ambiguity component survives; ledger-off-diagonal pieces are killed exactly.",
      "- Operator-level invisibility and expectation-level invisibility are not the same. The unsafe model is expectation-invisible on diagonal boundary states while remaining operator-visible.",
      "",
      "## Boundary conclusion for Main",
      "",
      decision["Reason"]
    },
    "\n"
  ];

mainSnippetText =
  StringRiffle[
    {
      "\\begin{remark}[Boundary record restriction versus controlled boundary dynamics]",
      "Restricting to the strict boundary record algebra \\(\\mathcal O_{\\partial,\\mathrm{rec}}=\\mathcal D_A\\otimes \\mathbf 1_B\\) can make representative-independence automatic after boundary readout, but this may trivialize the induced derivation itself. The nontrivial boundary question is therefore the controlled ledger sector \\(\\mathcal O_{\\partial,\\mathrm{ctrl}}=\\{\\sum_i \\Pi_i^{(A)}\\otimes O_i^{(B)}\\}\\), where only the diagonal controlled ambiguity component can survive after controlled projection.",
      "\\end{remark}"
    },
    "\n"
  ];

splitSnippetText =
  StringRiffle[
    {
      "\\begin{remark}[Boundary record and controlled ambiguity sectors]",
      "On the commutative end-of-aeon ledger algebra, commutators are invisible under diagonal boundary readout: \\(\\Phi_\\partial([X,O])=0\\) for every \\(O\\in \\mathcal D_A\\otimes \\mathbf 1_B\\). On the classically controlled completion sector \\(\\mathcal O_{\\partial,\\mathrm{ctrl}}=\\{\\sum_i \\Pi_i^{(A)}\\otimes O_i^{(B)}\\}\\), the controlled projection kills the ledger-off-diagonal ambiguity part, and only the diagonal controlled ambiguity component \\(\\sum_i \\Pi_i^{(A)}\\otimes K_i^{(B)}\\) can affect the induced derivation.",
      "\\end{remark}"
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
boundarySuite = MainProof`SplitWeldedBoundaryTests`RunSplitWeldedBoundaryExampleSuite[];
boundaryDecision = MainProof`SplitWeldedBoundaryTests`BoundaryCalibrationDecision[boundarySuite];

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
  "task:strict-boundary-record-invariance" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task16StrictBoundaryRecord", "{2, 2}"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task16StrictBoundaryRecord", "{2, 2}", "TrivializationWitnessCommutator"}]
  |>,
  "task:controlled-boundary-reduction" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task17ControlledBoundarySector", "{2, 2}"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "UnsafeFamily"}]
  |>,
  "task:boundary-class-defined-derivation-strong" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "SafeFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "UnsafeFamily"}]
  |>,
  "task:boundary-class-defined-derivation-mod-null" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "BorderlineFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "UnsafeFamily"}]
  |>,
  "task:boundary-expectation-vs-operator-invisibility" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "UnsafeFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "FalseOverreachModel"}]
  |>,
  "task:boundary-nontriviality-test" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "BorderlineFamily"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task16StrictBoundaryRecord", "{2, 2}", "TrivializationWitnessCommutator"}]
  |>,
  "task:boundary-calibration-decision" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task19BoundaryCalibrationDecision"}],
    "CounterexampleArtifact" -> artifactPointer[certificatePath, {"Task18SplitWeldedBoundaryInvariance", "UnsafeFamily"}]
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
  MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[],
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
  "Source representability is still split into an exact algebraic image-membership problem and a still-imported sufficient-locality condition.",
  "The boundary null ideal and the controlled boundary sector are modeled exactly but remain explicit finite-dimensional data rather than derived AQFT/HLS structures.",
  "Decision A is conditional: the sprint isolates the diagonal controlled ambiguity criterion but does not derive it from the full transported Main/UOM assumptions.",
  "LoG spectral selection and the abstract AQFT/HLS Hamiltonization tail remain outside the Mathematica core."
};

boundaryDelta = {
  "Strict boundary record invariance is exact but trivial: the induced derivation collapses after the boundary readout.",
  "Controlled projection isolates the exact source of boundary calibration dependence: only the diagonal controlled ambiguity component can survive; ledger-off-diagonal pieces are killed.",
  "Operator-level invisibility and expectation-level invisibility are now sharply separated. The unsafe controlled model is expectation-invisible on boundary-classical states while remaining operator-visible.",
  "A nontrivial mod-null invisible controlled family exists exactly at finite cutoff, so the boundary split+welded lane supports a conditional Path A rather than only trivial record-level invariance."
};

Export[decisionNotePath, decisionNoteText[boundaryDecision], "Text"];
Export[mainSnippetPath, mainSnippetText, "Text"];
Export[splitSnippetPath, splitSnippetText, "Text"];

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" -> "Boundary calibration invariance under split+welded restriction at exact finite cutoff.",
  "DecisionQuestion" -> "Can the split+welded boundary restriction make calibration dependence invisible to the extent Main actually needs?",
  "MilestoneStatus" -> If[
    MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:strict-boundary-record-invariance", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:controlled-boundary-reduction", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:boundary-class-defined-derivation-strong", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:boundary-class-defined-derivation-mod-null", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:boundary-expectation-vs-operator-invisibility", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:boundary-nontriviality-test", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`SplitWeldedBoundaryTests`SplitWeldedBoundaryLedgerUpdates[]["task:boundary-calibration-decision", "Status"] === "finite-dimensional-theorem-certificate",
    "green",
    "mixed"
  ],
  "BoundaryDecision" -> boundaryDecision,
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
  "Task16StrictBoundaryRecord" -> boundarySuite["StrictRecordTheorems"],
  "Task17ControlledBoundarySector" -> boundarySuite["ControlledReductionTheorems"],
  "Task18SplitWeldedBoundaryInvariance" -> <|
    "SafeFamily" -> boundarySuite["SafeFamily"],
    "UnsafeFamily" -> boundarySuite["UnsafeFamily"],
    "BorderlineFamily" -> boundarySuite["BorderlineFamily"],
    "FalseOverreachModel" -> boundarySuite["FalseOverreachModel"]
  |>,
  "Task19BoundaryCalibrationDecision" -> boundaryDecision,
  "EndToEnd_WeakInterface_to_Jcan" -> endToEnd,
  "DecisionNote" -> decisionNotePath,
  "MainSnippet" -> mainSnippetPath,
  "SplitSnippet" -> splitSnippetPath,
  "ImportedAssumptions" -> importedAssumptions,
  "BoundaryDelta" -> boundaryDelta
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "DecisionQuestion" -> report["DecisionQuestion"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "BoundaryDecision" -> report["BoundaryDecision"],
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
