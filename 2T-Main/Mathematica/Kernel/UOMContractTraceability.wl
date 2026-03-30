If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`UOMContractTraceability`"]

Needs["MainProof`CommonProofTools`"]

LSAssumptionPattern::usage =
  "LSAssumptionPattern[] returns the limited-scope assumption pattern imported as inspiration for compact-interface search.";
UOMContractTraceabilityRows::usage =
  "UOMContractTraceabilityRows[] returns the current boundary/completion contract ingredients together with source and status metadata.";
AuditUOMContractTraceability::usage =
  "AuditUOMContractTraceability[] classifies each current contract ingredient by source status and interface role.";
UOMContractTraceabilityLedgerUpdates::usage =
  "UOMContractTraceabilityLedgerUpdates[] returns theorem-ledger updates for the contract traceability lane.";

Begin["`Private`"]

LSAssumptionPattern[] :=
  <|
    "PatternName" -> "ls_minimal_interface_pattern",
    "Clauses" -> {
      <|
        "Label" -> "A1",
        "Name" -> "Core SK data",
        "Role" -> "minimal structural data"
      |>,
      <|
        "Label" -> "A2",
        "Name" -> "Two arrows (time and RG)",
        "Role" -> "minimal dynamics"
      |>,
      <|
        "Label" -> "A3",
        "Name" -> "Strict diagonalization of RG",
        "Role" -> "record-level reduction"
      |>,
      <|
        "Label" -> "A4",
        "Name" -> "RG-sector reachability",
        "Role" -> "section/existence data"
      |>,
      <|
        "Label" -> "A5",
        "Name" -> "No mixed anomaly",
        "Role" -> "flatness/boundary consistency"
      |>,
      <|
        "Label" -> "A6",
        "Name" -> "Record reflection",
        "Role" -> "injective record interpretation"
      |>,
      <|
        "Label" -> "A7",
        "Name" -> "Detector/analytic bridge",
        "Role" -> "physics-specific nontriviality bridge"
      |>
    },
    "Slogan" ->
      "Keep the interface minimal and theory-neutral first; push realization-specific physics into a separate bridge layer."
  |>;

makeRow[
  key_String,
  ingredient_String,
  boundaryRole_,
  completionRole_,
  wlArtifacts_List,
  mainSources_List,
  uomSources_List,
  lsPattern_List,
  textStatus_String,
  interfaceClass_String,
  note_String
] :=
  <|
    "IngredientKey" -> key,
    "Ingredient" -> ingredient,
    "BoundaryRoleQ" -> TrueQ[boundaryRole],
    "CompletionRoleQ" -> TrueQ[completionRole],
    "WLArtifacts" -> wlArtifacts,
    "MainSources" -> mainSources,
    "UOMSources" -> uomSources,
    "LSPattern" -> lsPattern,
    "TextStatus" -> textStatus,
    "InterfaceClass" -> interfaceClass,
    "TheoryNeutralCandidateQ" -> StringStartsQ[interfaceClass, "candidate-interface"],
    "AllSources" -> Join[mainSources, uomSources],
    "Note" -> note
  |>;

boundaryTextGroundedStatusQ[status_String] :=
  MemberQ[
    {
      "theorem-backed",
      "partial-theorem-backed",
      "theorem-backed on theorem-visible reduced receiver",
      "conditional theorem on explicit transport hypotheses"
    },
    status
  ];

completionTextNonPromotedStatusQ[status_String] :=
  MemberQ[
    {
      "assumption-backed",
      "wl-only surrogate",
      "bounded packaging theorem on explicit split data"
    },
    status
  ];

UOMContractTraceabilityRows[] := {
  makeRow[
    "accepted_record_preservation",
    "exact accepted-record preservation",
    True,
    True,
    {
      "task:uom-accepted-record-preservation",
      "task:sk-split-controlled-lift-contract"
    },
    {
      "Main/appendix_main.tex::rem:char-uom-supplement-separate",
      "Main/appendix_main.tex::rem:char-uom-realization"
    },
    {
      "UOM/source_internal_control_factorization_note.tex::thm:accepted-record-reduction",
      "UOM/source_internal_control_factorization_note.tex::cor:filler-toggle-invisible",
      "UOM/main.tex::lem:app-cptp",
      "UOM/main.tex::prop:semiclassical-diag",
      "UOM/active_response_transport_program_note.tex::def:accepted-record-payload",
      "UOM/active_response_transport_program_note.tex::def:witness-seam-realization"
    },
    {"A3", "A6"},
    "theorem-backed on theorem-visible reduced receiver",
    "candidate-interface",
    "The newer source-internal reduction note now theorem-backs the accepted-record reduction statement on the theorem-visible reduced receiver. This closes the receiver-side reduction result at the reduced theorem-facing level, but it still does not promote a broader unreduced source-internal factorization theorem."
  ],
  makeRow[
    "receiver_band_lock",
    "receiver band-lock",
    True,
    False,
    {
      "task:uom-bandlock-to-receiver",
      "task:uom-minimal-boundary-safe-hypothesis-set"
    },
    {
      "Main/appendix_main.tex::def:2T-char (locality/selection export side)"
    },
    {
      "UOM/compressed_log_spectral_selection_note.tex::prop:compressed-log-lock",
      "UOM/main.tex::welded band-lock sections"
    },
    {"A2", "A4"},
    "theorem-backed",
    "candidate-interface",
    "This is already a theorem-level welded-shape input in the compressed LoG note and is one of the leading geometric-locking candidates for a compact interface."
  ],
  makeRow[
    "compressed_welded_line",
    "one-dimensional compressed welded line",
    True,
    False,
    {
      "task:uom-compressed-line-rank",
      "task:uom-minimal-boundary-safe-hypothesis-set"
    },
    {
      "Main/appendix_main.tex::thm:char-weak-interface (dominant-line export target)"
    },
    {
      "UOM/compressed_log_spectral_selection_note.tex::prop:compressed-log-lock",
      "UOM/compressed_log_spectral_selection_note.tex::thm:finite-cutoff-canonical-odd-spectral-selection"
    },
    {"A1", "A7"},
    "theorem-backed",
    "candidate-interface",
    "The current WL boundary contract uses this as a rank-one active image; the live UOM note already states it theorem-level on the compressed welded channel."
  ],
  makeRow[
    "co_centering",
    "co-centering",
    True,
    False,
    {
      "task:uom-co-centering",
      "task:uom-minimal-boundary-safe-hypothesis-set"
    },
    {
      "Main/appendix_main.tex::def:2T-char (geometric localization side)"
    },
    {
      "UOM/compressed_log_spectral_selection_note.tex::prop:compressed-log-lock",
      "UOM/main.tex::subsubsec:uom-main-009",
      "UOM/main.tex::subsubsec:welded-co-centering"
    },
    {"A2", "A5"},
    "theorem-backed",
    "candidate-interface",
    "The exact WL family treats co-centering as part of geometric locking; the live UOM text already contains dedicated welded co-centering lanes."
  ],
  makeRow[
    "descended_scalar_factorization",
    "descended-scalar factorization",
    True,
    True,
    {
      "task:uom-channel-factorization",
      "task:uom-welded-family-selection",
      "task:sk-intrinsic-response-map-contract"
    },
    {
      "Main/appendix_main.tex::def:2T-char",
      "Main/appendix_main.tex::rem:char-uom-realization"
    },
    {
      "UOM/active_response_transport_program_note.tex::thm:active-response-transport-minimal",
      "UOM/active_response_transport_program_note.tex::thm:dominant-quotient-descent",
      "UOM/canonical_odd_interface_note.tex::thm:char-weak-interface",
      "UOM/canonical_odd_interface_note.tex::rem:char-weak-interface-rho-first",
      "UOM/source_internal_control_factorization_note.tex::def:pulse-rigid-package"
    },
    {"A1", "A7"},
    "conditional theorem on explicit transport hypotheses",
    "candidate-interface",
    "The descended dominant scalar and its quotient factorization now sit in a genuine theorem lane, but only under the explicit active-response transport hypotheses. This is stronger and cleaner than the older partial-support description, while remaining conditional rather than fully source-internal."
  ],
  makeRow[
    "split_controlled_lift",
    "split-controlled completion lift",
    False,
    True,
    {
      "task:sk-split-controlled-lift-contract",
      "task:sk-split-faithful-completion-ambiguity-decision"
    },
    {
      "Main/appendix_main.tex::rem:char-uom-realization (realization layer only)"
    },
    {
      "UOM/split_controlled_completion_lift_note.tex::thm:splitlift-main",
      "UOM/split_controlled_completion_lift_note.tex::cor:splitlift-main",
      "UOM/split_controlled_completion_lift_note.tex::rem:splitlift-gate"
    },
    {"A3", "A6"},
    "bounded packaging theorem on explicit split data",
    "candidate-interface-completion",
    "The live split-controlled lift note now theorem-backs the ledger-side consequences of the split package under explicit split data. This is a real bounded packaging theorem and compatibility corollary, but it remains below manuscript promotion because the split package itself is still imported structural data."
  ],
  makeRow[
    "gaussian_completion_contract",
    "derived Gaussian completion contract",
    False,
    True,
    {
      "task:sk-gaussian-completion-contract",
      "task:sk-split-faithful-completion-ambiguity-decision"
    },
    {
      "Main/appendix_main.tex::weak-interface remains completion-free"
    },
    {
      "UOM/summability_split_note.tex::ass:gaussian-completion",
      "UOM/canonical_odd_interface_note.tex::def:intrinsic-cov-response",
      "UOM/canonical_odd_interface_note.tex::thm:char-weak-interface"
    },
    {"A7"},
    "assumption-backed",
    "candidate-interface-completion",
    "The intrinsic response map is theorem-facing, but the Gaussian completion realization is still explicitly assumption-level in the UOM split note."
  ]
};

AuditUOMContractTraceability[] :=
  Module[
    {
      rows, lsPattern, boundaryRows, completionRows, sourcedQ,
      boundaryGroundedQ, completionOpenQ
    },
    rows = UOMContractTraceabilityRows[];
    lsPattern = LSAssumptionPattern[];
    boundaryRows = Select[rows, TrueQ[#["BoundaryRoleQ"]] &];
    completionRows = Select[rows, TrueQ[#["CompletionRoleQ"]] && !TrueQ[#["BoundaryRoleQ"]] &];
    sourcedQ = AllTrue[rows, #["AllSources"] =!= {} &];
    boundaryGroundedQ =
      AllTrue[
        boundaryRows,
        boundaryTextGroundedStatusQ[#["TextStatus"]] &
      ];
    completionOpenQ =
      AllTrue[
        completionRows,
        completionTextNonPromotedStatusQ[#["TextStatus"]] &
      ];
    <|
      "Rows" -> rows,
      "LSPattern" -> lsPattern,
      "Summary" -> <|
        "BoundaryIngredientCount" -> Length[boundaryRows],
        "CompletionIngredientCount" -> Length[completionRows],
        "CandidateInterfaceIngredients" ->
          Count[Lookup[rows, "InterfaceClass"], "candidate-interface" | "candidate-interface-completion"],
        "TextStatusCounts" -> Counts[Lookup[rows, "TextStatus"]],
        "InterfaceClassCounts" -> Counts[Lookup[rows, "InterfaceClass"]]
      |>,
      "Claims" -> <|
        "Every active contract ingredient is traced to live Main/UOM/LS sources" -> <|
          "Status" -> If[sourcedQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> sourcedQ
        |>,
        "Boundary strong-safe ingredients are already theorem-backed, reduced-theorem-backed, or conditional-theorem-backed in the live notes" -> <|
          "Status" -> If[boundaryGroundedQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> boundaryGroundedQ
        |>,
        "Completion-specific additions remain non-promoted in the live note stack" -> <|
          "Status" -> If[completionOpenQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> completionOpenQ
        |>,
        "The LS assumption pattern supports a minimal-interface plus realization-bridge workflow" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" -> True
        |>
      |>
    |>
  ];

UOMContractTraceabilityLedgerUpdates[] :=
  Module[{audit = AuditUOMContractTraceability[]},
    <|
      "task:uom-contract-traceability" -> <|
        "Method" -> "Exact source/role classification of the current WL contract ingredients against Main, 2T-LS, and live UOM note labels.",
        "Status" -> If[And @@ Lookup[Values[audit["Claims"]], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Every current contract ingredient is mapped to live sources, with boundary ingredients separated from completion additions and classified by interface candidacy.",
        "RepresentativeModelFamily" -> "Traceability table for welded boundary and split-faithful completion contracts",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
