rootDir = DirectoryName[DirectoryName[$InputFileName]];
kernelDir = FileNameJoin[{rootDir, "Kernel"}];
reportsDir = DirectoryName[$InputFileName];
certificatesDir = FileNameJoin[{rootDir, "Certificates"}];

Get[FileNameJoin[{kernelDir, "Init.wl"}]];

reportBaseName = "TransportBoundaryReduction";
jsonReportPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Report.json"]}];
ledgerCsvPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_Ledger.csv"]}];
certificatePath = FileNameJoin[{certificatesDir, StringJoin[reportBaseName, "_Certificates.wl"]}];
importedAssumptionsPath = FileNameJoin[{reportsDir, StringJoin[reportBaseName, "_ImportedAssumptions.txt"]}];
boundaryDeltaPath = FileNameJoin[{reportsDir, "TransportBoundaryDelta.txt"}];

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
      },
      "JcanMatchesCalibratingRepresentative" -> TrueQ[canonData["Jcan"] == epsilon model["Jdesc"]]
    |>;
    <|
      "Model" -> model,
      "TransportAudit" -> transportAudit,
      "CalibrationInput" -> calData,
      "CalibrationReport" -> calReport,
      "ShiftCoordinates" -> shift,
      "ShiftedRepresentative" -> j0,
      "IntegratedTickData" -> tick,
      "TickValidation" -> tickValidation,
      "CanonicalRepresentativeData" -> canonData,
      "CanonicalRepresentativeReport" -> canonReport,
      "MilestoneClaims" -> milestoneClaims,
      "MilestoneStatus" -> If[And @@ TrueQ /@ Values[milestoneClaims], "green", "blocked"]
    |>
  ];

buildWitnessComparisonReport[quotientSuite_Association] :=
  Module[{good = quotientSuite["ValidExample"], witness},
    witness = good["UnscaledChiCompatibilityWitness"];
    <|
      "RhoLevelRepresentativeSearchReduction" -> good["RhoLevelRepresentativeSearchReduction"],
      "ChiLevelRepresentativeSearchReduction" -> good["ChiLevelRepresentativeSearchReduction"],
      "UnscaledChiCompatibilityWitness" -> witness,
      "Conclusion" -> If[
        witness === {},
        "The unscaled chi-level compatibility claim is exact in this model family.",
        "At fixed cutoff the representative search reduces exactly to rho(J0) = target, equivalently chi(J0) = target/nu. The unscaled claim chi(J0) = target fails unless an extra normalization such as nu = 1 is imposed."
      ]
    |>
  ];

charSuite = MainProof`CharData`RunCharDataExampleSuite[];
transportSuite = MainProof`ActiveTransport`RunActiveTransportExampleSuite[];
calibrationSuite = MainProof`Calibration`RunCalibrationExampleSuite[];
canonicalSuite = MainProof`CanonicalRepresentative`RunCanonicalRepresentativeExampleSuite[];
endToEnd = buildEndToEndCertificate[];
quotientSuite = MainProof`QuotientDescent`RunQuotientDescentExampleSuite[];
representabilitySuite = MainProof`Representability`RunRepresentabilityExampleSuite[];
regularitySuite = MainProof`JcanRegularity`RunJcanRegularityExampleSuite[];
witnessComparisonReport = buildWitnessComparisonReport[quotientSuite];

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
  "Source representability is now split into an exact algebraic image-membership problem and a still-imported sufficient-locality condition.",
  "Witness-to-descendant comparison has been reduced to a rho-level scalar compatibility statement at fixed cutoff; the unscaled chi-level version remains obstructed unless an extra normalization such as nu = 1 is added.",
  "AQFT/HLS semantics, LoG spectral certification, and the Peierls bracket lane remain outside the Mathematica core in this sprint."
};

boundaryDelta = {
  "Eliminated import: the ambiguity-kernel / quotient-descent closure is now machine-audited exactly at finite cutoff through thm:dominant-quotient-descent and cor:dominant-quotient-constancy.",
  "Reduced import: source-insertion representability is now decomposed into an exact algebraic solver with obstruction and gauge-space reports; only sufficient locality remains imported.",
  "Clarified obstruction: representative-search statements collapse to rho-level scalar compatibility on the affine class. The stronger unscaled chi-level reduction is false in general and requires an extra normalization hypothesis.",
  "Added bonus control: branchwise rational regularity of Jcan is now certified for rational/polynomial finite-cutoff data away from Gram-block degeneracy."
};

report = <|
  "GeneratedAt" -> DateString[{"ISODate", " ", "Time"}],
  "SprintScope" ->
    "Boundary-reduction sprint: manuscript cleanup, quotient descent, source representability, witness-comparison reduction, and branchwise Jcan regularity.",
  "Milestone" -> "shrink imported transport boundary",
  "MilestoneStatus" -> If[
    endToEnd["MilestoneStatus"] === "green" &&
      MainProof`QuotientDescent`QuotientDescentLedgerUpdates[]["thm:dominant-quotient-descent", "Status"] === "finite-dimensional-theorem-certificate" &&
      MainProof`Representability`RepresentabilityLedgerUpdates[]["task:source-insertion-representability", "Status"] === "finite-dimensional-theorem-certificate",
    "green",
    "mixed"
  ],
  "Ledger" -> ledger,
  "Task2Schema" -> charSuite,
  "Task3_5ActiveTransport" -> transportSuite,
  "Task4Calibration" -> calibrationSuite,
  "Task5CanonicalRepresentative" -> canonicalSuite,
  "Task6QuotientDescent" -> quotientSuite,
  "Task7Representability" -> representabilitySuite,
  "Task8WitnessComparison" -> witnessComparisonReport,
  "Task9JcanBranchRegularity" -> regularitySuite,
  "EndToEnd" -> endToEnd,
  "ImportedAssumptions" -> importedAssumptions,
  "TransportBoundaryDelta" -> boundaryDelta,
  "AppendixMainStatus" -> "The theorem title cleanup and projector-formula remark have been applied directly in Main/appendix_main.tex."
|>;

summaryReport = <|
  "GeneratedAt" -> report["GeneratedAt"],
  "SprintScope" -> report["SprintScope"],
  "Milestone" -> report["Milestone"],
  "MilestoneStatus" -> report["MilestoneStatus"],
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
