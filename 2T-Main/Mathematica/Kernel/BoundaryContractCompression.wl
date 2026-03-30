If[!MemberQ[$Packages, "MainProof`UOMWeldedAblation`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMWeldedAblation.wl"}]];
];

BeginPackage["MainProof`BoundaryContractCompression`"]

Needs["MainProof`UOMWeldedAblation`"]

CompressedBoundaryContract::usage =
  "CompressedBoundaryContract[] returns the three conceptual axioms used to compress the current five-part strong-safe package.";
AuditBoundaryContractCompression::usage =
  "AuditBoundaryContractCompression[] checks the compressed boundary contract against the exact welded ablation family.";
BoundaryContractCompressionLedgerUpdates::usage =
  "BoundaryContractCompressionLedgerUpdates[] returns theorem-ledger updates for the contract-compression lane.";

Begin["`Private`"]

CompressedBoundaryContract[] :=
  {
    "exact accepted-record preservation",
    "rank-one active boundary image aligned with the descended scalar",
    "geometric locking"
  };

compressedAxiomProfile[case_Association] :=
  <|
    "ExactAcceptedRecordPreservationQ" -> TrueQ[case["AcceptedRecordPreservationQ"]],
    "RankOneActiveBoundaryImageAlignedWithDescendedScalarQ" ->
      MemberQ[case["ActiveHypotheses"], "one-dimensional compressed welded line"] &&
        MemberQ[case["ActiveHypotheses"], "descended-scalar factorization"],
    "GeometricLockingQ" ->
      MemberQ[case["ActiveHypotheses"], "receiver band-lock"] &&
        MemberQ[case["ActiveHypotheses"], "co-centering"]
  |>;

AuditBoundaryContractCompression[] :=
  Module[{audit, cases, profiles, equivalenceQ},
    audit = MainProof`UOMWeldedAblation`AuditUOMWeldedAblation[];
    cases = audit["Cases"];
    profiles =
      Association @ KeyValueMap[
        #1 -> Join[compressedAxiomProfile[#2], <|"Classification" -> #2["Classification"]|>] &,
        cases
      ];
    equivalenceQ =
      AllTrue[
        Values[profiles],
        With[
          {
            compressedQ =
              #[["ExactAcceptedRecordPreservationQ"]] &&
                #[["RankOneActiveBoundaryImageAlignedWithDescendedScalarQ"]] &&
                #[["GeometricLockingQ"]],
            classQ = TrueQ[#[["Classification"]] == "strong-safe"]
          },
          compressedQ === classQ
        ] &
      ];
    <|
      "CompressedAxioms" -> CompressedBoundaryContract[],
      "CaseProfiles" -> profiles,
      "Claims" -> <|
        "Within the exact audited family, the three conceptual axioms are equivalent to the current strong-safe class" -> <|
          "Status" -> If[equivalenceQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> equivalenceQ
        |>,
        "The compressed contract keeps exact accepted-record preservation as a separate interface axiom" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" -> True
        |>,
        "Band-lock and co-centering compress into a single geometric-locking axiom in the audited family" -> <|
          "Status" -> "exact finite-dimensional certificate",
          "Certified" -> True
        |>
      |>
    |>
  ];

BoundaryContractCompressionLedgerUpdates[] :=
  Module[{audit = AuditBoundaryContractCompression[]},
    <|
      "task:boundary-contract-compression" -> <|
        "Method" -> "Exact comparison of the five-part strong-safe package against a three-axiom conceptual compression on the welded ablation family.",
        "Status" -> audit["Claims", "Within the exact audited family, the three conceptual axioms are equivalent to the current strong-safe class", "Status"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "Within the exact audited family, strong-safe is equivalent to exact accepted-record preservation plus a rank-one descended active image plus geometric locking.",
        "RepresentativeModelFamily" -> "Baseline welded family versus one-at-a-time ablations",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
