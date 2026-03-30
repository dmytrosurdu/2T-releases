reportDir = "/home/kray-l8/work/2T/Main/Mathematica/Reports";
ledgerPath = FileNameJoin[{reportDir, "DelayedDescendantReentryAudit_Ledger.csv"}];
jsonOut = FileNameJoin[{reportDir, "Lane2NondegeneracyAudit_Report.json"}];
mdOut = FileNameJoin[{reportDir, "Lane2NondegeneracyAudit.md"}];

report = Catch[
  csv = Import[ledgerPath, "CSV"];
  If[! ListQ[csv] || Length[csv] < 2,
    Throw[Failure["ImportFailure", <|"Message" -> "Could not read delayed reentry ledger."|>]]
  ];

  header = First[csv];
  rows = Rest[csv];
  rowAssoc[row_List] := AssociationThread[header -> row];
  rowData = rowAssoc /@ rows;

  thresholdRow = SelectFirst[
    rowData,
    Lookup[#, "TheoremLabel", Missing["KeyAbsent", "TheoremLabel"]] ===
        "task:delayed-reentry-threshold-nonvanishing" &,
    Missing["ThresholdRowNotFound"]
  ];

  If[MissingQ[thresholdRow],
    Throw[Failure["MissingThresholdRow", <|"Message" -> "Threshold counterexample row not found in delayed reentry ledger."|>]]
  ];

  lowerBoundImpliesNonzeroQ = Resolve[
    ForAll[{ct, mu, kappa, cnorm},
      Element[{ct, mu, kappa, cnorm}, Reals] && mu > 0 && kappa > 0 && Abs[ct] >= mu &&
        cnorm Sqrt[kappa] == ct
        \[Implies] (ct != 0 && cnorm != 0)
    ],
    Reals
  ];

  lowerBoundCounterexample = FindInstance[
    Element[{ct, mu, kappa, cnorm}, Reals] && mu > 0 && kappa > 0 && Abs[ct] >= mu &&
      cnorm Sqrt[kappa] == ct && cnorm == 0,
    {ct, mu, kappa, cnorm},
    Reals
  ];

  pairingImpliesNonzeroQ = Resolve[
    ForAll[{ct, mu, obs},
      Element[{ct, mu, obs}, Reals] && mu > 0 && obs != 0 && Abs[ct] >= mu
        \[Implies] ct obs != 0
    ],
    Reals
  ];

  pairingCounterexample = FindInstance[
    Element[{ct, mu, obs}, Reals] && mu > 0 && obs != 0 && Abs[ct] >= mu && ct obs == 0,
    {ct, mu, obs},
    Reals
  ];

  signPreservedQ = Resolve[
    ForAll[{ct, kappa, cnorm},
      Element[{ct, kappa, cnorm}, Reals] && kappa > 0 && ct != 0 &&
        cnorm Sqrt[kappa] == ct
        \[Implies] Sign[cnorm] == Sign[ct]
    ],
    Reals
  ];

  signCounterexample = FindInstance[
    Element[{ct, kappa, cnorm}, Reals] && kappa > 0 && ct != 0 &&
      cnorm Sqrt[kappa] == ct && Sign[cnorm] != Sign[ct],
    {ct, kappa, cnorm},
    Reals
  ];

  claims = <|
    "Threshold alone forces c_Lambda != 0" -> <|
      "Status" -> thresholdRow["Status"],
      "ScopeClass" -> thresholdRow["ScopeClass"],
      "Acceptance" -> thresholdRow["Acceptance"],
      "CounterexampleArtifact" -> thresholdRow["CounterexampleArtifact"],
      "Source" -> thresholdRow["Source"]
    |>,
    "No-destructive-cancellation lower bound implies c_Lambda != 0" -> <|
      "Status" -> If[TrueQ[lowerBoundImpliesNonzeroQ] && lowerBoundCounterexample === {},
        "exact finite-dimensional certificate",
        "failed"
      ],
      "Assumptions" -> "Real ct, real mu > 0, real kappa > 0, and |ct| >= mu.",
      "Method" -> "Exact Resolve/FindInstance audit of the normalized relation cnorm Sqrt[kappa] == ct with kappa > 0.",
      "Counterexample" -> lowerBoundCounterexample,
      "Acceptance" -> "A positive lower bound on the raw unit-source overlap scalar forces nonvanishing of the normalized seam coefficient."
    |>,
    "Lower bound plus nonzero witness implies nonzero raw seam pairing" -> <|
      "Status" -> If[TrueQ[pairingImpliesNonzeroQ] && pairingCounterexample === {},
        "exact finite-dimensional certificate",
        "failed"
      ],
      "Assumptions" -> "Real ct, real mu > 0, real obs != 0, and |ct| >= mu.",
      "Method" -> "Exact Resolve/FindInstance audit of the factorized pairing ct * obs.",
      "Counterexample" -> pairingCounterexample,
      "Acceptance" -> "Under detector factorization, a positive lower bound on the unit-source overlap and a nonzero LS witness force nonzero seam pairing."
    |>,
    "Positive normalization preserves the sign of the raw overlap scalar" -> <|
      "Status" -> If[TrueQ[signPreservedQ] && signCounterexample === {},
        "exact finite-dimensional certificate",
        "failed"
      ],
      "Assumptions" -> "Real ct != 0 and real kappa > 0.",
      "Method" -> "Exact Resolve/FindInstance audit of Sign[cnorm] == Sign[ct] under cnorm Sqrt[kappa] == ct and kappa > 0.",
      "Counterexample" -> signCounterexample,
      "Acceptance" -> "The normalized seam coefficient has the same sign as the raw overlap scalar whenever the normalization factor is positive."
    |>
  |>;

  reportLocal = <|
    "Name" -> "Lane2NondegeneracyAudit",
    "Date" -> DateString[Now, {"Year", "-", "Month", "-", "Day"}],
    "Mission" -> "Separate nondegeneracy theorem lane for c_{Lambda_{k+1}} != 0, kept distinct from the split-threshold lane.",
    "SourceUpdate" -> "UOM/completion_sector_split_model_body.tex now contains a separate overlap-lower-bound theorem lane for c_Lambda != 0.",
    "Claims" -> claims,
    "TopLine" -> <|
      "ThresholdBoundary" -> thresholdRow["Acceptance"],
      "SeparateLaneVerdict" -> "A unit-source overlap lower bound is exactly sufficient for a separate honest nondegeneracy theorem; the split threshold is not."
    |>
  |>;

  markdown = StringRiffle[{
    "# Lane 2 Nondegeneracy Audit",
    "",
    "Date: `" <> reportLocal["Date"] <> "`",
    "",
    "This packet keeps the nondegeneracy lane for `c_Lambda != 0` separate from the split-threshold lane.",
    "",
    "## Imported threshold boundary",
    "",
    "- status: `" <> claims["Threshold alone forces c_Lambda != 0"]["Status"] <> "`",
    "- acceptance: " <> claims["Threshold alone forces c_Lambda != 0"]["Acceptance"],
    "- source: `" <> claims["Threshold alone forces c_Lambda != 0"]["Source"] <> "`",
    "",
    "## Exact lane-2 checks",
    "",
    "- no-destructive-cancellation lower bound implies `c_Lambda != 0`: `" <> claims["No-destructive-cancellation lower bound implies c_Lambda != 0"]["Status"] <> "`",
    "- lower bound plus nonzero witness implies nonzero raw seam pairing: `" <> claims["Lower bound plus nonzero witness implies nonzero raw seam pairing"]["Status"] <> "`",
    "- positive normalization preserves sign: `" <> claims["Positive normalization preserves the sign of the raw overlap scalar"]["Status"] <> "`",
    "",
    "## Reading",
    "",
    "- The existing delayed-reentry audit remains authoritative for the negative result: the effective split threshold does not itself force `c_Lambda != 0`.",
    "- The new lane-2 theorem shape is consistent with that counterexample because it replaces the threshold claim with a separate overlap lower bound on the unit welded odd source.",
    "- Exact symbolic checks certify that `|tilde c_Lambda| >= mu > 0` forces both `tilde c_Lambda != 0` and `c_Lambda != 0`, and that the normalized coefficient has the same sign as the raw overlap scalar.",
    "",
    "## Verdict",
    "",
    "- Best honest theorem lane: separate no-destructive-cancellation or overlap-lower-bound criterion.",
    "- Not allowed: any claim that the split threshold alone forces `c_Lambda != 0`."
  }, "\n"];

  Export[jsonOut, reportLocal, "JSON"];
  Export[mdOut, markdown, "Text"];

  reportLocal
];

report
