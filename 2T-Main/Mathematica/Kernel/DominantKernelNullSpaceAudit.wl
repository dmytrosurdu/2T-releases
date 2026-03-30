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

If[!MemberQ[$Packages, "MainProof`TransverseModNullReductionAudit`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "TransverseModNullReductionAudit.wl"}]];
];

BeginPackage["MainProof`DominantKernelNullSpaceAudit`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`BoundarySectors`"]
Needs["MainProof`BoundarySplitWeldedModels`"]
Needs["MainProof`DelayedDescendantReentryAudit`"]
Needs["MainProof`TransverseModNullReductionAudit`"]

CertifiedDominantKernelNullSpaceAudit::usage =
  "CertifiedDominantKernelNullSpaceAudit[] audits the dominant-functional-kernel route to discharging theorem-2 transversality on the exact borderline family.";

Begin["`Private`"]

kernelRouteAudit[] :=
  Module[
    {
      model, projA, nullBasis, witness, selected, functionalRow,
      nullBasisMatrix, selectedScalar, nullInKernelQ, selectedNonzeroQ, parityStableQ
    },
    model = MainProof`BoundarySplitWeldedModels`BoundarySplitWeldedModelFamily[]["BorderlineNullIdealFamily"];
    projA = model["ProjectorsA"];
    nullBasis = MainProof`BoundarySectors`BoundaryNullIdealBasis[projA, model["NullIdealBasisB"]];
    witness = model["WitnessObservable"];
    selected = model["JOperator"];
    functionalRow = Flatten[Transpose[witness]];
    nullBasisMatrix =
      If[nullBasis === {} || nullBasis === {{}},
        ConstantArray[0, {Length[functionalRow], 0}],
        Transpose[Flatten /@ nullBasis]
      ];
    selectedScalar = Expand[functionalRow . Flatten[selected]];
    nullInKernelQ =
      MainProof`CommonProofTools`AnnihilatesSubspaceQ[
        functionalRow,
        nullBasisMatrix
      ];
    selectedNonzeroQ = TrueQ[Together[selectedScalar] != 0];
    parityStableQ =
      AllTrue[
        nullBasis,
        MainProof`CommonProofTools`MatrixInSpanQ[-#, nullBasis] &
      ];
    <|
      "ModelName" -> model["Name"],
      "DominantFunctionalSurrogate" -> witness,
      "SelectedLineGenerator" -> selected,
      "NullIdealBasis" -> nullBasis,
      "SelectedScalar" -> selectedScalar,
      "Claims" -> <|
        "Chosen mod-null subspace lies in the kernel of the dominant functional surrogate on the audited borderline family" -> <|
          "Status" -> If[nullInKernelQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> nullInKernelQ
        |>,
        "Selected scalar generator has nonzero dominant functional surrogate value on the audited borderline family" -> <|
          "Status" -> If[selectedNonzeroQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> selectedNonzeroQ
        |>,
        "Chosen mod-null subspace is parity-stable on the audited borderline family" -> <|
          "Status" -> If[parityStableQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> parityStableQ
        |>
      |>,
      "ResidualBoundary" -> {
        "The functional is an exact finite-dimensional surrogate built from the audited borderline-family witness pairing.",
        "This does not identify the surrogate with the abstract descended dominant functional outside that model family."
      }
    |>
  ];

CertifiedDominantKernelNullSpaceAudit[] :=
  Module[{reentryAudit, transAudit, kernelAudit},
    reentryAudit = MainProof`DelayedDescendantReentryAudit`CertifiedDelayedDescendantReentryAudit[];
    transAudit = MainProof`TransverseModNullReductionAudit`CertifiedTransverseModNullReductionAudit[];
    kernelAudit = kernelRouteAudit[];
    <|
      "UnderlyingDelayedReentryAudit" -> reentryAudit,
      "UnderlyingTransversalityAudit" -> transAudit,
      "KernelRouteAudit" -> kernelAudit,
      "Claims" -> <|
        "Kernel-subordinated parity-stable mod-null data discharge theorem-2 transversality on the audited family" -> <|
          "Status" -> If[
            reentryAudit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Chosen mod-null subspace lies in the kernel of the dominant functional surrogate on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Selected scalar generator has nonzero dominant functional surrogate value on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Chosen mod-null subspace is parity-stable on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              transAudit["SelectedLineAudit", "Claims", "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family", "Status"] === "exact finite-dimensional certificate",
            "exact finite-dimensional certificate for the discharge schema",
            "deferred"
          ],
          "Certified" -> (
            reentryAudit["Claims", "Current exact split family admits a canonical scalar descendant representative modulo Aminus", "Status"] === "exact finite-dimensional certificate" &&
              reentryAudit["Claims", "Canonical scalar representative survives the descendant ambiguity quotient in the current exact family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Chosen mod-null subspace lies in the kernel of the dominant functional surrogate on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Selected scalar generator has nonzero dominant functional surrogate value on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              kernelAudit["Claims", "Chosen mod-null subspace is parity-stable on the audited borderline family", "Status"] === "exact finite-dimensional certificate" &&
              transAudit["SelectedLineAudit", "Claims", "Selected scalar line is transverse to the chosen mod-null ideal in the audited borderline family", "Status"] === "exact finite-dimensional certificate"
          )
        |>
      |>,
      "TopLineReading" -> {
        "On the audited borderline family, the dominant-functional-kernel route is exact: the chosen parity-stable mod-null subspace lies in the kernel of the functional surrogate, while the selected generator has nonzero value.",
        "Therefore the selected line is automatically transverse to that mod-null subspace on the audited family.",
        "This certifies the discharge schema familywise, but it does not yet construct a canonical dominant-null subspace in the abstract Main/UOM theorem stack."
      }
    |>
  ];

End[]

EndPackage[]
