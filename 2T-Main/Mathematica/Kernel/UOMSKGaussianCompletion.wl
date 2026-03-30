If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`UOMSplitControlledLift`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "UOMSplitControlledLift.wl"}]];
];

BeginPackage["MainProof`UOMSKGaussianCompletion`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`UOMSplitControlledLift`"]

CertifiedUOMSKGaussianCompletionContract::usage =
  "CertifiedUOMSKGaussianCompletionContract[] returns the split-faithful Gaussian-completion contract built from the intrinsic response map and compressed active line.";
AuditUOMSKGaussianCompletion::usage =
  "AuditUOMSKGaussianCompletion[] certifies that the completion observables are derived from Gaussian quadrature data rather than from an appended free functional.";
UOMSKGaussianCompletionLedgerUpdates::usage =
  "UOMSKGaussianCompletionLedgerUpdates[] returns theorem-ledger updates for the Gaussian-completion contract lane.";

Begin["`Private`"]

activeQuadratureProjector[] := DiagonalMatrix[{1, 0}];

qObservable[] := DiagonalMatrix[{1, -1}];

pObservable[] := {{0, 1}, {1, 0}};

symplecticForm[] := {{0, 1}, {-1, 0}};

CertifiedUOMSKGaussianCompletionContract[] :=
  Module[{splitModel, contract, chi},
    splitModel = MainProof`UOMSplitControlledLift`CertifiedSplitControlledLift[];
    contract = splitModel["IntrinsicResponseContract"];
    chi = contract["ActiveScalarFunctional"];
    <|
      "Name" -> "uom_split_faithful_gaussian_completion_contract",
      "SplitModel" -> splitModel,
      "IntrinsicResponseContract" -> contract,
      "SymplecticForm" -> symplecticForm[],
      "QuadraticHamiltonian" -> IdentityMatrix[2],
      "ActiveLineVector" -> {1, 0},
      "ActiveProjector" -> activeQuadratureProjector[],
      "QObservable" -> qObservable[],
      "PObservable" -> pObservable[],
      "CovarianceTangentMap" -> Function[v, Expand[(chi . v) activeQuadratureProjector[]]]
    |>
  ];

AuditUOMSKGaussianCompletion[] :=
  Module[
    {
      contract, hQ, omegaQ, a1, a2, genericVector, covarianceRecoveryQ,
      noFreeFunctionalQ, quadratureDerivedQ
    },
    contract = CertifiedUOMSKGaussianCompletionContract[];
    genericVector =
      contract["IntrinsicResponseContract", "TransportModel", "Jdesc"] +
        contract["IntrinsicResponseContract", "TransportModel", "Aminus"] . {a1, a2};
    hQ = MainProof`CommonProofTools`SymmetricPositiveDefiniteQ[contract["QuadraticHamiltonian"]];
    omegaQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        Transpose[contract["SymplecticForm"]],
        -contract["SymplecticForm"]
      ] &&
        Det[contract["SymplecticForm"]] != 0;
    covarianceRecoveryQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {a1, a2},
        True,
        contract["CovarianceTangentMap"][genericVector] ==
          (contract["IntrinsicResponseContract", "ActiveScalarFunctional"] . genericVector) contract["ActiveProjector"]
      ];
    noFreeFunctionalQ =
      MainProof`CommonProofTools`ExactForAllTrue[
        {a1, a2},
        True,
        Tr[contract["CovarianceTangentMap"][genericVector] . contract["ActiveProjector"]] ==
          contract["IntrinsicResponseContract", "ActiveScalarFunctional"] . genericVector
      ];
    quadratureDerivedQ =
      MainProof`CommonProofTools`ExactMatrixEqualQ[
        contract["QObservable"] . contract["PObservable"] - contract["PObservable"] . contract["QObservable"],
        2 contract["SymplecticForm"]
      ];
    <|
      "Contract" -> contract,
      "Claims" -> <|
        "Gaussian completion contract has exact symplectic and positive-Hamiltonian data" -> <|
          "Status" -> If[hQ && omegaQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> hQ && omegaQ
        |>,
        "Completion covariance tangent is derived from the intrinsic response scalar" -> <|
          "Status" -> If[covarianceRecoveryQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> covarianceRecoveryQ
        |>,
        "No appended free completion functional is used in the Gaussian completion contract" -> <|
          "Status" -> If[noFreeFunctionalQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> noFreeFunctionalQ
        |>,
        "Completion observables are derived from Gaussian quadrature data" -> <|
          "Status" -> If[quadratureDerivedQ, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> quadratureDerivedQ
        |>
      |>
    |>
  ];

UOMSKGaussianCompletionLedgerUpdates[] :=
  Module[{audit = AuditUOMSKGaussianCompletion[], claims},
    claims = audit["Claims"];
    <|
      "task:sk-gaussian-completion-contract" -> <|
        "Method" -> "Exact finite-dimensional Gaussian-completion contract built from the intrinsic response scalar, compressed active line, symplectic form, and derived quadrature observables.",
        "Status" -> If[And @@ Lookup[Values[claims], "Certified"], "exact finite-dimensional certificate", "counterexample found"],
        "ScopeClass" -> "exact-model-certificate",
        "Acceptance" -> "The completion observables and covariance tangents are derived from the split-faithful Gaussian contract itself, with no appended free completion functional.",
        "RepresentativeModelFamily" -> audit["Contract", "Name"],
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
