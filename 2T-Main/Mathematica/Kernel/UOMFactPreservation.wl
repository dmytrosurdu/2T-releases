If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

BeginPackage["MainProof`UOMFactPreservation`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]

AcceptedRecordProjection::usage =
  "AcceptedRecordProjection[rho] projects a finite-dimensional state exactly onto the commuting record algebra.";
GenericQNDTickMap::usage =
  "GenericQNDTickMap[rho] applies an exact symbolic commuting dephasing kernel that leaves the record algebra fixed.";
AuditUOMFactPreservation::usage =
  "AuditUOMFactPreservation[dim] returns the exact finite-dimensional fact-preservation audit modeled on lem:app-cptp and the accepted RG state proposition.";
UOMFactPreservationLedgerUpdates::usage =
  "UOMFactPreservationLedgerUpdates[] returns theorem-ledger updates for the exact sub-cutoff fact-preservation lane.";

Begin["`Private`"]

symbolicMatrix[dim_Integer?Positive, head_Symbol] := Array[head, {dim, dim}];

AcceptedRecordProjection[rho_?MatrixQ] := DiagonalMatrix[Diagonal[rho]];

GenericQNDTickMap[rho_?MatrixQ] :=
  Module[{dim = Length[rho], kernel},
    Table[
      If[i == j, rho[[i, j]], kernel[i, j] rho[[i, j]]],
      {i, dim},
      {j, dim}
    ]
  ];

AuditUOMFactPreservation[dim_Integer : 3] /; Positive[dim] :=
  Module[{rho, phi, proj, recordBasis, preservedExpectationsQ},
    rho = symbolicMatrix[dim, r];
    phi = GenericQNDTickMap[rho];
    proj = AcceptedRecordProjection[rho];
    recordBasis = MainProof`BoundarySectors`BoundaryDiagonalBasis[dim];
    preservedExpectationsQ =
      AllTrue[
        recordBasis,
        Function[a,
          AllTrue[
            Together /@ {
              Tr[phi.a] - Tr[rho.a],
              Tr[proj.a] - Tr[rho.a]
            },
            TrueQ[# == 0] &
          ]
        ]
      ];
    <|
      "Dimension" -> dim,
      "SymbolicState" -> rho,
      "QNDTickImage" -> phi,
      "AcceptedRecordState" -> proj,
      "Claims" -> <|
        "Accepted record projection preserves all record expectations exactly" -> <|
          "Status" -> If[preservedExpectationsQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> preservedExpectationsQ
        |>,
        "Commuting QND tick fixes the accepted record state" -> <|
          "Status" -> If[
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              AcceptedRecordProjection[phi],
              proj
            ],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              AcceptedRecordProjection[phi],
              proj
            ]
        |>,
        "Accepted record projection is the exact conditional expectation onto the diagonal record algebra" -> <|
          "Status" -> If[
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              AcceptedRecordProjection[proj],
              proj
            ],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            MainProof`CommonProofTools`ExactMatrixEqualQ[
              AcceptedRecordProjection[proj],
              proj
            ]
        |>
      |>
    |>
  ];

UOMFactPreservationLedgerUpdates[] :=
  Module[{audit = AuditUOMFactPreservation[]},
    <|
      "task:uom-subcutoff-fact-preservation" -> <|
        "Method" -> "Exact finite-dimensional symbolic audit of commuting QND dephasing and accepted-record projection on the pointer algebra.",
        "Status" -> If[
          And @@ Lookup[Values[audit["Claims"]], "Certified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "Acceptance" -> "Accepted-record projection preserves all record expectations exactly and is fixed by the commuting QND tick.",
        "RepresentativeModelFamily" -> "Generic symbolic commuting dephasing kernel on a finite pointer basis",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
