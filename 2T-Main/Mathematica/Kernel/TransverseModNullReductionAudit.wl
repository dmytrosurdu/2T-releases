If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySectors`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySectors.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`BoundarySplitWeldedModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "BoundarySplitWeldedModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`DelayedDescendantReentryAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "DelayedDescendantReentryAudit.wl"}]];
];

BeginPackage["MainProof`TransverseModNullReductionAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`DelayedDescendantReentryAudit`"]

CertifiedTransverseModNullReductionAudit::usage =
  "CertifiedTransverseModNullReductionAudit[] audits the transversality-reduction lemma for the conditional mod-null reentry lane.";

Begin["`Private`"]

zeroVector[n_Integer?NonNegative] := ConstantArray[0, n];

selectedLineAudit[] :=
  Module[
    {
      model, projA, nullBasisB, nullBasis, selected, selectedVec,
      quotientRows, selectedImage, transverseQ, parityStableQ, parityDescendsQ
    },
    model = MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[]["BorderlineNullIdealFamily"];
    projA = model["ProjectorsA"];
    nullBasisB = model["NullIdealBasisB"];
    nullBasis = MainProof`BoundarySectors`BoundaryNullIdealBasis[projA, nullBasisB];
    selected = model["JOperator"];
    selectedVec = Flatten[selected];
    quotientRows =
      NullSpace[
        Transpose[
          If[nullBasis === {} || nullBasis === {{}},
            ConstantArray[0, {Length[selectedVec], 0}],
            Transpose[Flatten /@ nullBasis]
          ]
        ]
      ];
    selectedImage = quotientRows . selectedVec;
    transverseQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        Implies[
          MainProof`CommonProofTools`MatrixInSpanQ[s selected, nullBasis],
          s == 0
        ]
      ];
    parityStableQ =
      AllTrue[
        nullBasis,
        MainProof`CommonProofTools`MatrixInSpanQ[-#, nullBasis] &
      ];
    parityDescendsQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {s},
        True,
        quotientRows . Flatten[-s selected] == -(quotientRows . Flatten[s selected])
      ];
    <|
      "ModelName" -> model["Name"],
      "SelectedLineGenerator" -> selected,
      "NullIdealBasis" -> nullBasis,
      "QuotientCoordinateMatrix" -> quotientRows,
      "SelectedQuotientImage" -> selectedImage,
      "Claims" -> <|
        "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family" -> <|
          "Status" -> If[transverseQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> transverseQ
        |>,
        "Parity-stable transversality gives a nonzero quotient class on the audited selected line" -> <|
          "Status" -> If[
            transverseQ &&
              !MainProof`CommonProofTools`ExactVectorEqualQ[selectedImage, zeroVector[Length[selectedImage]]],
            "exact finite-dimensional certificate",
            "counterexample found"
          ],
          "Certified" ->
            transverseQ &&
              !MainProof`CommonProofTools`ExactVectorEqualQ[selectedImage, zeroVector[Length[selectedImage]]]
        |>,
        "Odd parity descends on the audited quotient line by sign" -> <|
          "Status" -> If[parityStableQ && parityDescendsQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> parityStableQ && parityDescendsQ
        |>
      |>,
      "ResidualBoundary" -> {
        "This is an exact controlled finite-dimensional mod-null certificate on the audited borderline family.",
        "It does not derive the abstract Main/UOM transversality hypothesis automatically for the scalar descendant line in D^-."
      }
    |>
  ];

CertifiedTransverseModNullReductionAudit[] :=
  Module[{reentryAudit, lineAudit},
    reentryAudit = MainProof`DelayedDescendantReentryAudit`CertifiedDelayedDescendantReentryAudit[];
    lineAudit = selectedLineAudit[];
    <|
      "UnderlyingDelayedReentryAudit" -> reentryAudit,
      "SelectedLineAudit" -> lineAudit,
      "Claims" -> <|
        "The remaining mod-null step reduces to line/null-ideal transversality plus quotient construction" -> <|
          "Status" -> If[
            reentryAudit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Parity-stable transversality gives a nonzero quotient class on the audited selected line", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Odd parity descends on the audited quotient line by sign", "Status"] === "exact finite-dimensional certificate",
            "exact finite-dimensional certificate for the reduction schema",
            "deferred"
          ],
          "Certified" -> (
            reentryAudit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "A chosen mod-null boundary quotient can support conditional reentry on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Parity-stable transversality gives a nonzero quotient class on the audited selected line", "Status"] === "exact finite-dimensional certificate" &&
              lineAudit["Claims", "Odd parity descends on the audited quotient line by sign", "Status"] === "exact finite-dimensional certificate"
          )
        |>
      |>,
      "TopLineReading" -> {
        "The exact WL lane supports the new intermediate reading: once a parity-stable mod-null subspace meets the selected line trivially, the quotient is injective on that line and the remaining step is only quotient construction plus descended odd parity.",
        "So the real unresolved content is exactly the transversality of the selected scalar line to the chosen mod-null ideal.",
        "This remains a finite-dimensional certificate for the reduction schema, not an automatic derivation of the abstract transversality hypothesis from split localization alone."
      }
    |>
  ];

End[]

EndPackage[]
