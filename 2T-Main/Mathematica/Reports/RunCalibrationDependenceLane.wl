rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "CalibrationDependenceLane";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
boundaryDeltaPath = FileNameJoin[{reportsDir, "CalibrationDependenceBoundaryDelta.txt"}];
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

buildCalibrationDependenceConclusion[comparisonSuite_Association, hamSuite_Association] :=
  Module[
    {
      nonInvariant = comparisonSuite["NonInvariantExample"],
      invisible = hamSuite["InvisibleSensitivityExample"],
      visible = hamSuite["VisibleSensitivityExample"]
    },
    If[
      TrueQ[nonInvariant["NonInvarianceWitness"]] &&
        TrueQ[invisible["PhysicalSectorInvariantUnderDifference"]] &&
        TrueQ[visible["PhysicalSectorNonInvariantWitness"]],
      "Jcan depends on the admissible calibration in general. The dependence is always quotient-level invisible because DeltaJ lies in Aminus, and it is representational on the physical sector when ambiguity directions bracket trivially there. It is not harmless automatically: the exact visible-ambiguity model gives a physical-sector counterexample.",
      "The calibration-dependence lane is incomplete or mixed."
    ]
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
  "task:Peierls-odd-derivation" -> <|
    "CertificateArtifact" -> artifactPointer[certificatePath, {"Task12PeierlsOddDerivation"}],
    "CounterexampleArtifact" -> "Deferred"
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
  "The calibration-comparison and bracket lanes certify exact finite-dimensional formulas and conditions, but they do not construct the AQFT/HLS observable sector.",
  "LoG spectral certification and the abstract Main Peierls/AQFT tail remain outside the Mathematica core."
};

boundaryDelta = {
  "Transport correction propagated: quotient and representative-search statements now use the descended rho^dom scalar as the general form, while chi-form statements are marked as normalized special cases.",
  "Calibration dependence sharpened: Jcan depends on B in general, but the exact comparison formula shows DeltaJ always lies in Aminus.",
  "Physical consequence sharpened: exact bracket models show that calibration dependence is representational on the physical sector when ambiguity directions are bracket-trivial there, and physically visible otherwise.",
  "Full parent-document compile logs are now part of the handoff artifact set."
};

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" ->
    "Repo-wide transport correction propagation plus exact calibration-comparison and narrow Peierls odd-derivation lane.",
  "Milestone" -> "determine whether admissible calibration dependence is representational or physically visible",
  "MilestoneStatus" -> If[
    MainProof`CalibrationComparison`CalibrationComparisonLedgerUpdates[]["task:calibration-comparison", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`Hamiltonization`HamiltonizationLedgerUpdates[]["task:Peierls-odd-derivation", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`Hamiltonization`HamiltonizationLedgerUpdates[]["task:delta-calibration-sensitivity", "Status"] === "finite-dimensional-theorem-certificate" &&
      And @@ (FileExistsQ /@ Values[compileArtifacts]),
    "green",
    "mixed"
  ],
  "CalibrationDependenceConclusion" -> buildCalibrationDependenceConclusion[comparisonSuite, hamSuite],
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
  "EndToEnd_WeakInterface_to_Jcan" -> endToEnd,
  "CompileArtifacts" -> compileArtifacts,
  "CorrectionNote" -> correctionNotePath,
  "ImportedAssumptions" -> importedAssumptions,
  "BoundaryDelta" -> boundaryDelta
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "Milestone" -> report["Milestone"],
  "MilestoneStatus" -> report["MilestoneStatus"],
  "CalibrationDependenceConclusion" -> report["CalibrationDependenceConclusion"],
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
