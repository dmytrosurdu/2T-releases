If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`TheoremLedger`"]

Needs["MainProof`CommonProofTools`"]

RequestedTheoremLabels::usage =
  "RequestedTheoremLabels[] returns the ordered theorem labels for the current sprint.";
BaseTheoremLedger::usage =
  "BaseTheoremLedger[] returns the sprint ledger with deferred statuses.";
MergeTheoremStatuses::usage =
  "MergeTheoremStatuses[ledger, updates] merges theorem-status updates by label.";
TheoremLedgerDataset::usage =
  "TheoremLedgerDataset[updates] returns a Dataset view of the merged theorem ledger.";

Begin["`Private`"]

RequestedTheoremLabels[] := {
  "def:2T-char",
  "thm:active-response-transport-minimal",
  "thm:char-weak-interface",
  "prop:minimal-transport-calibration",
  "thm:finite-cutoff-Jcan",
  "prop:Jcan-orth",
  "thm:dominant-quotient-descent",
  "cor:dominant-quotient-constancy",
  "task:source-insertion-representability",
  "task:witness-comparison-reduction",
  "task:Jcan-branch-regularity",
  "task:calibration-comparison",
  "task:ambiguity-trivial-on-physical-sector",
  "task:ambiguity-trivial-mod-null-ideal",
  "task:ambiguity-physically-visible",
  "task:class-defined-physical-derivation",
  "task:strict-boundary-record-invariance",
  "task:controlled-boundary-reduction",
  "task:boundary-class-defined-derivation-strong",
  "task:boundary-class-defined-derivation-mod-null",
  "task:boundary-expectation-vs-operator-invisibility",
  "task:boundary-nontriviality-test",
  "task:boundary-calibration-decision",
  "thm:controlled-boundary-block-centrality-strong",
  "thm:controlled-boundary-block-centrality-mod-null",
  "rem:expectation-invisibility-insufficient",
  "task:boundary-null-ideal-candidates",
  "task:transported-boundary-ambiguity-audit",
  "task:selector-necessity-decision",
  "task:uom-welded-bandlocked-channel",
  "task:uom-subcutoff-fact-preservation",
  "task:uom-transported-welded-boundary-audit",
  "task:uom-welded-boundary-decision",
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
  "task:sk-split-faithful-completion-ambiguity-decision",
  "task:uom-contract-traceability",
  "task:mock-cosmology-interface-realizations",
  "task:cosmology-interface-boundary-minimality",
  "task:cosmology-interface-completion-minimality",
  "task:boundary-contract-compression",
  "task:manuscript-insertion-gate",
  "task:Peierls-odd-derivation",
  "task:delta-calibration-sensitivity",
  "thm:finite-cutoff-canonical-odd-spectral-selection",
  "thm:Main-Peierls-Hamiltonization"
};

BaseTheoremLedger[] := {
  StatusRecord[
    "def:2T-char",
    "Finite-dimensional surrogate for the seven Main-facing interface clauses.",
    "Association schema + exact structural checks.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:535-586",
      "ScopeClass" -> "schema-validator",
      "SurrogateBlindSpots" -> {
        "Closedness is automatic/invisible at finite dimension.",
        "Continuity of chi is automatic for finite-dimensional linear maps.",
        "Hilbertizability is reduced to positive-definite matrix data, not the abstract completion statement."
      },
      "RepresentativeModelFamily" -> "Synthetic finite-dimensional TickData examples",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:active-response-transport-minimal",
    "Branchwise rho^dom, nu, Aminus, and Jdesc family on an accepted interval.",
    "Resolve/Reduce on exact branch models.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1821-1907",
      "ScopeClass" -> "exact-model-certificate",
      "SurrogateBlindSpots" -> {
        "Continuity is only audited for the chosen model family.",
        "No abstract functional-analytic topology is represented beyond exact branch conditions."
      },
      "RepresentativeModelFamily" -> "Exact one-parameter branch models for rho^dom, nu, Aminus, Jdesc",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:char-weak-interface",
    "Transport theorem discharged; chi = nu^-1 rho^dom defines the weak Main export.",
    "Exact export checks on symbolic branch models.",
    "deferred",
    <|
      "Source" -> "UOM/canonical_odd_interface_note.tex:699-744",
      "ScopeClass" -> "exact-model-certificate",
      "SurrogateBlindSpots" -> {
        "Weak-interface export is checked on exact branch models, not universally for all admissible UOM branches."
      },
      "RepresentativeModelFamily" -> "Exact one-parameter branch export models",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "prop:minimal-transport-calibration",
    "chi, Jsharp, beta > 0, and a coercive form on ker chi.",
    "Exact matrix decomposition and positivity certificates.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1987-2056",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Coercivity is represented by a positive-definite kernel matrix Q.",
        "Abstract Hilbertizability remains an imported interpretation."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:finite-cutoff-Jcan",
    "Weak 2T_char interface and a positive symmetric ambient bilinear form B on E^- whose restriction is minimized on the affine class.",
    "Exact linear algebra + projection formula.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:1787-1811",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Closed affine subspace is automatic in the finite-dimensional surrogate.",
        "Hilbert projection theorem is realized by matrix algebra rather than abstract analysis."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "prop:Jcan-orth",
    "Finite-dimensional affine class and positive B.",
    "Exact orthogonality/minimality equivalence.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:1838-1870 (working sprint label)",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The finite-dimensional proof does not reprove the abstract Hilbert projection theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:dominant-quotient-descent",
    "Dominant-response functional and ambiguity subspace on the finite-cutoff odd layer.",
    "Exact quotient descent and coset-constancy checks.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:504-525",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Quotient continuity is represented by finite-dimensional linear algebra.",
        "Closure of the ambiguity space is still only represented by the finite-dimensional surrogate."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "cor:dominant-quotient-constancy",
    "Descended dominant functional on the ambiguity quotient and the affine descendant class.",
    "Exact affine-class constancy via quotient coordinates.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:444-468",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The quotient point [![Xi^(1)]!] is represented only in finite-dimensional coordinates."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:source-insertion-representability",
    "Fixed-cutoff image-membership problem Pi_phys R(F_tau) = Pi_phys T[tau].",
    "Exact linear solver with obstruction and gauge analysis.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1260-1310",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Sufficient locality remains imported and is not identified with algebraic image membership."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:witness-comparison-reduction",
    "Representative search on J0 + Aminus versus scalar compatibility of dominant pairings.",
    "Exact affine representative-search reduction and obstruction hunting.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1323-1371",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The reduction is audited at fixed cutoff and may still require a normalization hypothesis."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:Jcan-branch-regularity",
    "Rational or polynomial branch data U(lambda), B(lambda), J0(lambda) with invertible Gram block.",
    "Exact rational-function regularity audit for the projector formula.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:1837-1870 plus finite-dimensional projector formula remark",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Only rational/polynomial finite-cutoff branch data are audited."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:calibration-comparison",
    "Two admissible positive calibrations B1, B2 on the same affine class J0 + im(U).",
    "Exact projector comparison and visibility-map invariance tests.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:1787-1917 plus WL calibration-comparison lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Physical invisibility is represented by exact finite-dimensional visible maps killing Aminus.",
        "No infinite-dimensional physical-sector semantics are built here."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:ambiguity-trivial-on-physical-sector",
    "Odd generator shift J -> J + A with A in Aminus on an explicit bracket model.",
    "Exact proof that ad_A vanishes on the physical sector.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Only explicit finite-dimensional bracket models are audited."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:ambiguity-trivial-mod-null-ideal",
    "Odd generator shift J -> J + A with A in Aminus on an explicit bracket model with a physical null ideal.",
    "Exact proof that ad_A lands in the physical null ideal while remaining nonzero.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The physical null ideal is represented by an explicit finite-dimensional subspace."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:ambiguity-physically-visible",
    "Odd generator shift J -> J + A with A in Aminus on an explicit bracket model.",
    "Exact countermodel where ad_A survives on the physical sector outside the null ideal.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Physical visibility is shown only on explicit bracket models."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:class-defined-physical-derivation",
    "Physical sector, physical null ideal, and ambiguity directions on an explicit bracket model.",
    "Exact quotient test for representative-independence modulo the null ideal.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2055-2140 plus WL class-defined-derivation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The physical quotient is represented by an explicit finite-dimensional null-ideal quotient.",
        "No abstract AQFT/HLS quotient construction is attempted."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:strict-boundary-record-invariance",
    "Boundary readout on the strict record sector D_A ⊗ 1_B with classical ledger projectors on A.",
    "Exact symbolic proof that BoundaryReadout([X,O]) vanishes on the strict record sector.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The readout is the exact finite-dimensional pinch_A after partial trace over B.",
        "Approximate end-of-aeon classicality is idealized as exact ledger diagonality."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:controlled-boundary-reduction",
    "Controlled boundary observables Sum_i Pi^(A) ⊗ O_i^(B) and a general ambiguity operator K on A ⊗ B.",
    "Exact symbolic reduction of controlled-projected commutators to diagonal controlled B-block commutators.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:743-792 plus WL boundary-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The theorem is proved on explicit finite matrix algebras with rank-one ledger projectors.",
        "No infinite-dimensional completion or AQFT/HLS controlled sector is constructed."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-class-defined-derivation-strong",
    "Controlled boundary sector and ambiguity directions on split+welded boundary models.",
    "Exact operator-level criterion for literal ambiguity triviality on the controlled sector.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Strong class-definedness is tested only on explicit split+welded toy models."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-class-defined-derivation-mod-null",
    "Controlled boundary sector and a chosen boundary null ideal on the completion sector B.",
    "Exact representative-independence criterion modulo the boundary null ideal.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The boundary null ideal is model data rather than a derived AQFT/HLS object."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-expectation-vs-operator-invisibility",
    "Controlled boundary sector together with diagonal boundary-classical states.",
    "Exact comparison of operator-level invisibility and expectation-level invisibility.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Expectation-level invisibility is tested only against the chosen diagonal boundary-classical state family."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-nontriviality-test",
    "Controlled boundary sector, boundary null ideal, and a candidate boundary generator J.",
    "Exact search for a nonzero induced boundary derivation with ambiguity invisibility modulo the boundary null ideal.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:743-856 plus WL split+welded boundary lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Nontriviality is shown on explicit exact split+welded toy models rather than the transported full UOM ambiguity class."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-calibration-decision",
    "Strict record sector, controlled boundary sector, and split+welded safe/unsafe/borderline ambiguity families.",
    "Exact finite-cutoff decision between strict trivial invariance, nontrivial controlled invariance, and visible failure.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:743-856 plus WL split+welded boundary lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The decision is conditional on the chosen split+welded toy families and is not yet a theorem of the full Main/UOM stack."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:controlled-boundary-block-centrality-strong",
    "Controlled boundary observables Sum_i Pi^(A) ⊗ O_i^(B) and a controlled ambiguity operator with diagonal B-blocks K_i^(B).",
    "Exact blockwise commutator reduction and centrality equivalence on full matrix blocks.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:743-856 plus WL controlled-boundary block-centrality lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The theorem is proved on exact finite matrix blocks rather than an infinite-dimensional boundary algebra."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:controlled-boundary-block-centrality-mod-null",
    "Controlled boundary observables together with a chosen boundary null ideal on each B-block.",
    "Exact blockwise commutator reduction and mod-null centrality equivalence.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:743-856 plus WL controlled-boundary block-centrality lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The boundary null ideal is still represented by an explicit finite-dimensional block subspace."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "rem:expectation-invisibility-insufficient",
    "Controlled boundary observables and boundary-classical state families on the split+welded sector.",
    "Exact comparison of expectation-level invisibility against operator-level and mod-null class-definedness.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:643-856 plus WL controlled-boundary block-centrality lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Expectation-level invisibility is only checked on the explicit boundary-classical state family."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-null-ideal-candidates",
    "Natural split+welded boundary null-ideal candidates such as the readout kernel, block-trace-zero blocks, and state-invisible operators.",
    "Exact model-by-model comparison of stability, nontriviality, and borderline-family absorption.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex:643-856 plus WL boundary-null-ideal comparison lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The candidate list is finite and tied to explicit split+welded finite-cutoff semantics."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:transported-boundary-ambiguity-audit",
    "Actual weak-interface transport export (Eminus, Aminus, XiClass, Chi, Epsilon) together with exact split+welded boundary realizations.",
    "Exact audit of the exported ambiguity basis under controlled boundary projection and natural null-ideal candidates.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1821-1960 plus WL transported-boundary audit lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Boundary realizations of the transported ambiguity basis are explicit finite-dimensional models rather than a theorem of the abstract transport semantics."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:selector-necessity-decision",
    "Boundary block-centrality theorems, natural null-ideal comparison, and the transported ambiguity audit.",
    "Exact binary decision between structural boundary safety and selector necessity.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2140-2177 plus WL selector-necessity decision lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The decision is finite-cutoff and does not yet incorporate AQFT/HLS or LoG selector data."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-bandlocked-channel",
    "Exact co-centered, band-locked compressed welded LoG channel at one accepted tick.",
    "Exact welded-line realization factoring through the descended dominant scalar.",
    "deferred",
    <|
      "Source" -> "UOM/main.tex:458-488, 6503-6525; UOM/compressed_log_spectral_selection_note.tex:18-95",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The line/channel structure is imported from the proved UOM welded-shape and band-lock analysis rather than rederived from convolution integrals inside WL."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-subcutoff-fact-preservation",
    "Accepted record algebra under commuting QND/CPTP evolution below cutoff.",
    "Exact symbolic diagonal-record projection and commuting dephasing audit.",
    "deferred",
    <|
      "Source" -> "UOM/main.tex:5076-5093, 7280-7298, 9070-9086",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The full infinite-dimensional band-limited Hilbert space is represented by exact finite-dimensional symbolic pointer models."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-transported-welded-boundary-audit",
    "Actual weak-interface transport export composed with the exact welded/fact-preserving boundary image.",
    "Exact ambiguity audit after factorization through the descended dominant scalar on the welded LoG line.",
    "deferred",
    <|
      "Source" -> "UOM/active_response_transport_program_note.tex:1821-1960 together with UOM welded/accepted-record structure",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "This certifies the preserved compiled/welded boundary image, not the full unreduced completion-sector operator algebra."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-boundary-decision",
    "Comparison between the old generic splitBlock boundary realization and the reworked UOM welded/fact-preserving realization.",
    "Exact finite-cutoff decision on whether the prior unsafe witnesses survive the UOM welded constraints.",
    "deferred",
    <|
      "Source" -> "Main Mathematica rework lane grounded in UOM welded/fact-preserving structure",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The decision is about the exact welded preserved channel and leaves the unreduced Gaussian completion-sector operator reconstruction open."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-boundary-ambiguity-annihilation",
    "Transported ambiguity directions on the exact preserved welded boundary image.",
    "Exact matrix audit of the compiled welded boundary image after descended-scalar factorization.",
    "deferred",
    <|
      "Source" -> "Main Mathematica welded-boundary canonicalization lane built on UOM welded/fact-preserving data",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The certificate is for the exact preserved welded boundary image, not the full completion-sector operator algebra."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-boundary-class-defined-derivation",
    "Boundary derivation induced by any representative in the transported affine class after compiled welded projection.",
    "Exact derivation equality test on the preserved welded boundary algebra.",
    "deferred",
    <|
      "Source" -> "Main Mathematica welded-boundary canonicalization lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Representative-independence is certified on the finite-dimensional compiled welded algebra only."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-boundary-calibration-invariance",
    "Two admissible canonical representatives in the same transported affine class viewed after compiled welded projection.",
    "Exact calibration comparison after UOM welded boundary projection.",
    "deferred",
    <|
      "Source" -> "Main Mathematica welded-boundary canonicalization lane plus WL canonical-representative machinery",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Calibration invariance is certified only after projection to the preserved welded boundary image."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-boundary-nontriviality",
    "The surviving class representative line on the exact preserved welded boundary image.",
    "Exact nonvanishing commutator audit on a compiled welded boundary observable.",
    "deferred",
    <|
      "Source" -> "Main Mathematica welded-boundary canonicalization lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Nontriviality is shown on an exact compiled welded boundary algebra witness, not on the unreduced microscopic completion sector."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-log-shape",
    "Macro/micro welded pulse formulas on the accepted UOM branch.",
    "Exact contract audit of temporal and spatial welded LoG shape formulas.",
    "deferred",
    <|
      "Source" -> "UOM/compressed_log_spectral_selection_note.tex and UOM welded pulse notes",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The WL lane certifies the exact algebraic contract, not the full continuum convolution derivation."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-co-centering",
    "Accepted welded pulse center alignment across the compiled macro/micro channel.",
    "Exact co-centering contract audit on the welded pulse data.",
    "deferred",
    <|
      "Source" -> "UOM welded pulse notes and compressed welded LoG lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Co-centering is represented by the exact finite-cutoff contract rather than by a continuum transport proof."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-bandlock-to-receiver",
    "Receiver-cutoff locking of the welded pulse widths.",
    "Exact band-lock contract audit for the welded temporal and spatial scales.",
    "deferred",
    <|
      "Source" -> "UOM welded band-lock lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Band-lock is certified as an exact algebraic contract at fixed cutoff."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-compressed-line-rank",
    "Compressed welded boundary image at one accepted cutoff.",
    "Exact rank-one projector audit for the welded LoG line.",
    "deferred",
    <|
      "Source" -> "UOM/compressed_log_spectral_selection_note.tex:259-288 plus WL welded channel lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The line rank is certified for the exact finite-dimensional compiled image only."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-channel-factorization",
    "Accepted finite-cutoff boundary channel written as projected Weyl-compensated compiled transport.",
    "Exact contract audit of T_Lambda = Pi_L o M_epsilon o K_comp o G_ret o W_src.",
    "deferred",
    <|
      "Source" -> "UOM/main.tex and Main Mathematica accepted-channel contract lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The WL lane certifies an exact finite-dimensional factorization surrogate rather than the full SK-to-boundary reconstruction."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-uplift-isometry-surrogate",
    "Finite-cutoff uplift/Stinespring realization compatible with the accepted welded channel contract.",
    "Exact isometry audit for the chosen uplift surrogate.",
    "deferred",
    <|
      "Source" -> "UOM accepted-channel lane plus WL uplift surrogate",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Only the selected finite-dimensional uplift surrogate is certified."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-app-cptp-surrogate",
    "Accepted tick map on the finite pointer sector below cutoff.",
    "Exact Kraus-completeness and CPTP surrogate audit.",
    "deferred",
    <|
      "Source" -> "UOM/main.tex accepted-tick lane plus WL Kraus surrogate",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The CPTP certificate is for the exact finite-dimensional surrogate only."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-accepted-record-preservation",
    "Accepted record algebra below cutoff under the exact accepted channel surrogate.",
    "Exact preservation audit against an intentional ablation witness.",
    "deferred",
    <|
      "Source" -> "UOM/main.tex accepted-record lane plus WL accepted-channel contract lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Preservation is certified on finite-dimensional pointer models only."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-p3-admissibility",
    "Finite-cutoff P3 least-action admissibility on the welded candidate family.",
    "Exact contract audit over finitely many candidate welded channel families.",
    "deferred",
    <|
      "Source" -> "UOM active-response transport and descendant-note admissibility lanes",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Only exact symbolic contract families are compared; no continuum variational theorem is reproved."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-sk-gaussian-selection",
    "Least-influence SK Gaussian selection on admissible finite-cutoff welded families.",
    "Exact ranking audit of Gaussian drive/squeeze contracts.",
    "deferred",
    <|
      "Source" -> "UOM SK least-influence selection notes",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The lane certifies symbolic contract data rather than the full continuum Gaussian optimization problem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-welded-family-selection",
    "Selected admissible welded channel family at finite cutoff.",
    "Exact admissibility contract reducing to the welded rank-one factorized channel.",
    "deferred",
    <|
      "Source" -> "UOM welded family-selection contract lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The selected family is finite-dimensional contract data, not a universal theorem over all boundary channels."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-ablation-fact-preservation",
    "Exact welded boundary audit with accepted-record preservation removed.",
    "Finite-dimensional ablation classification on the preserved welded boundary image.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The ablation outcome is model-exact and does not by itself settle all microscopic realizations."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-ablation-bandlock",
    "Exact welded boundary audit with receiver band-lock relaxed.",
    "Finite-dimensional ablation classification on the compiled boundary image.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The ablation outcome is an exact channel-family witness, not a universal no-go theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-ablation-compressed-rank",
    "Exact welded boundary audit with the rank-one compressed line replaced by a higher-rank channel.",
    "Finite-dimensional ablation classification on the compiled boundary image.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The higher-rank witness is exact but model-specific."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-ablation-co-centering",
    "Exact welded boundary audit with co-centering relaxed.",
    "Finite-dimensional ablation classification on the compiled boundary image.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The co-centering witness is exact but model-specific."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-ablation-descended-scalar-factorization",
    "Exact welded boundary audit with the descended-scalar factorization replaced by a generic control map.",
    "Finite-dimensional ablation classification against the legacy unsafe lane.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane plus legacy generic surrogate lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The certificate compares exact finite-dimensional channel families rather than the full continuum reconstruction."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-minimal-boundary-safe-hypothesis-set",
    "Minimal exact welded-boundary hypothesis package found by the ablation audit.",
    "Exact implication audit H_min => W_Lambda(A^-_Lambda) = 0 on the preserved welded boundary image.",
    "deferred",
    <|
      "Source" -> "Main Mathematica UOM welded ablation lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Minimality is relative to the exact ablation family encoded in WL."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:legacy-generic-visible-ambiguity",
    "Legacy generic boundary surrogates without the UOM welded contract.",
    "Exact regression audit reproducing visible ambiguity witnesses.",
    "deferred",
    <|
      "Source" -> "Legacy split+welded/generic-boundary surrogate lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "These are deliberately negative-control models, not physical channel claims."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:legacy-generic-splitblock-countermodels",
    "Legacy generic splitBlock countermodels retained as negative controls.",
    "Exact unsafe-family regression audit on transported and generic surrogate realizations.",
    "deferred",
    <|
      "Source" -> "Legacy splitBlock negative-control lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The lane preserves countermodels on purpose and does not claim physical admissibility."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-minimal-gaussian-completion-reconstruction",
    "Exploratory exact algebraic completion lift compatible with the welded boundary block.",
    "Exact finite-dimensional audit of an appended algebraic completion lift.",
    "deferred",
    <|
      "Source" -> "Main Mathematica completion-sector reconstruction lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "This is an exploratory exact algebraic extension of the welded boundary block.",
        "It is not yet a faithful UOM split/completion reconstruction."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-completion-ambiguity-visibility",
    "Transported ambiguity evaluated on the exploratory exact algebraic completion lift.",
    "Exact classification as strong-safe, mod-null-safe, or visible-again on the exploratory algebraic completion model.",
    "deferred",
    <|
      "Source" -> "Main Mathematica completion-sector reconstruction lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The classification is for the encoded exploratory algebraic model only.",
        "It is not a selector-necessity decision and not yet a verdict on the UOM split model."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-completion-boundary-lift",
    "Boundary projection of the exploratory algebraic completion lift back to the welded boundary image.",
    "Exact boundary-compatibility audit for the exploratory completion-sector lift.",
    "deferred",
    <|
      "Source" -> "Main Mathematica completion-sector reconstruction lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Compatibility is certified only for the chosen exploratory exact model."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-intrinsic-response-map-contract",
    "Intrinsic response-map contract derived from the compressed welded boundary image without appended free completion functionals.",
    "Exact contract extraction from chi and the accepted welded response map.",
    "deferred",
    <|
      "Source" -> "UOM/canonical_odd_interface_note.tex plus Main Mathematica intrinsic-response contract lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "This certifies a finite-dimensional contract realization of the intrinsic response map, not the full continuum response theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-split-controlled-lift-contract",
    "Split-faithful A|B lift with classical-control/QND ledger sector and completion sector built from the intrinsic response contract.",
    "Exact tensor-product controlled-lift audit and ledger-projector commutation checks.",
    "deferred",
    <|
      "Source" -> "UOM/summability_split_note.tex plus Main Mathematica split-controlled lift lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The lift is a contract-level finite-dimensional surrogate for the split structure, not a full microscopic split theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-gaussian-completion-contract",
    "Gaussian completion contract derived from the intrinsic response map and compressed active line, with no appended free functional.",
    "Exact finite-dimensional quadrature/covariance contract audit.",
    "deferred",
    <|
      "Source" -> "UOM/canonical_odd_interface_note.tex and UOM/compressed_log_spectral_selection_note.tex plus Main Mathematica Gaussian-completion contract lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "This is a contract-level Gaussian realization surrogate, not the full SK kernel reconstruction."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:sk-split-faithful-completion-ambiguity-decision",
    "Split-faithful completion decision combining intrinsic response, controlled split, derived Gaussian completion, and lifted fact preservation.",
    "Exact ambiguity audit on the split-faithful completion contract.",
    "deferred",
    <|
      "Source" -> "Main Mathematica split-faithful completion audit lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The decision is contract-level and does not yet settle the full microscopic completion-sector theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:uom-contract-traceability",
    "Current WL contract ingredients for welded boundary safety and split-faithful completion.",
    "Exact source/role classification against Main, UOM, and 2T-LS labels.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex, UOM live notes, and latex/limited_scope_theorem_PRL_Supplementary.tex",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "The traceability table is only as fine-grained as the current live theorem/assumption labels.",
        "The completion entries are still non-promoted: one is a bounded packaging theorem on explicit split data, while the Gaussian completion layer remains assumption-backed."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:mock-cosmology-interface-realizations",
    "UOM realization, synthetic non-UOM realizations, and a visible-ambiguity negative control.",
    "Exact mock-realization audit for interface candidacy.",
    "deferred",
    <|
      "Source" -> "Main Mathematica interface-search lane plus UOM welded/completion contracts",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Synthetic realizations certify interface shape, not microscopic physics."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:cosmology-interface-boundary-minimality",
    "Nested boundary-interface candidates I0, I1, I2.",
    "Exact minimality search on mock realizations.",
    "deferred",
    <|
      "Source" -> "Main abstract interface lane cross-checked against UOM contract realizations",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Minimality is certified only in the current exact mock family."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:cosmology-interface-completion-minimality",
    "Nested completion-aware interface candidates I0, I1, I2.",
    "Exact minimality search on completion-aware mock realizations.",
    "deferred",
    <|
      "Source" -> "Main Mathematica completion-interface search lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Completion-aware minimality remains contract-level and does not close the microscopic SK theorem."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:boundary-contract-compression",
    "Five-part strong-safe welded package versus a three-axiom conceptual compression.",
    "Exact equivalence audit on the welded ablation family.",
    "deferred",
    <|
      "Source" -> "Main Mathematica welded ablation lane plus UOM compressed welded notes",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Compression is certified only inside the present exact ablation family."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:manuscript-insertion-gate",
    "Current traceability, compact-interface search, and completion-scope caveats.",
    "Joint manuscript gating decision.",
    "deferred",
    <|
      "Source" -> "Main Mathematica report lane plus UOM contract/completion reports",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "This gate is about what the current exact lane honestly licenses, not about the final theorem program."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:Peierls-odd-derivation",
    "Explicit associative bracket model with parity involution and odd generator J.",
    "Exact basis-level derivation and Gamma-odd checks.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2055-2130",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Only explicit finite-dimensional bracket models are audited.",
        "Locality and AQFT/HLS remain imported."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "task:delta-calibration-sensitivity",
    "Two canonical representatives Jcan_B1 and Jcan_B2 in an explicit bracket model.",
    "Exact derivation-difference formula plus ambiguity-triviality tests on the physical sector.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2072-2084 plus WL calibration-sensitivity lane",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Physical invisibility is represented by explicit bracket-trivial ambiguity directions.",
        "No AQFT/HLS physical-sector reconstruction is performed."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:finite-cutoff-canonical-odd-spectral-selection",
    "Certified compressed spectral regime and rank-one LoG operator.",
    "Exact eigenvalue/projector certificates.",
    "deferred",
    <|
      "Source" -> "UOM/compressed_log_spectral_selection_note.tex:259-288",
      "ScopeClass" -> "deferred",
      "SurrogateBlindSpots" -> {
        "Branchwise smooth transport of the projector may remain an imported input."
      },
      "RepresentativeModelFamily" -> "To be assigned",
      "NoApproximationQ" -> True
    |>
  ],
  StatusRecord[
    "thm:Main-Peierls-Hamiltonization",
    "Canonical representative plus imported bracket axioms on a concrete model.",
    "Formal rewrite + exact model checks.",
    "deferred",
    <|
      "Source" -> "Main/appendix_main.tex:2072-2084",
      "ScopeClass" -> "abstract-imported-assumptions",
      "SurrogateBlindSpots" -> {
        "Bracket locality and AQFT/HLS semantics stay imported.",
        "Only explicit concrete models can be machine-audited here."
      },
      "RepresentativeModelFamily" -> "Explicit bracket models only",
      "NoApproximationQ" -> True
    |>
  ]
};

MergeTheoremStatuses[ledger_List, updates_Association : <||>] :=
  Map[
    Function[row,
      With[{label = row["TheoremLabel"]},
        If[KeyExistsQ[updates, label],
          Join[row, updates[label]],
          row
        ]
      ]
    ],
    ledger
  ];

TheoremLedgerDataset[updates_Association : <||>] := Dataset @ MergeTheoremStatuses[BaseTheoremLedger[], updates];

End[]

EndPackage[]
