If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`ActiveTransport`"]

Needs["MainProof`CommonProofTools`"]

CertifiedActiveTransportModel::usage =
  "CertifiedActiveTransportModel[] returns an exact symbolic branch model satisfying the minimal transport contract.";
BrokenActiveTransportModels::usage =
  "BrokenActiveTransportModels[] returns exact models violating nonvanishing, continuity, or ambiguity-annihilation.";
DerivedChi::usage =
  "DerivedChi[model] computes chi = nu^-1 rho^dom.";
DominantScalar::usage =
  "DominantScalar[model] computes rho^dom . Jdesc on the branch.";
AcceptedBranchComponents::usage =
  "AcceptedBranchComponents[model] returns the exact connected components of the accepted branch.";
SignDefinedComponents::usage =
  "SignDefinedComponents[model] returns the exact components after removing zeros of rho^dom(Jdesc) and nu.";
AuditActiveTransportModel::usage =
  "AuditActiveTransportModel[model] returns exact transport certificates and failure witnesses for the branch model.";
RunActiveTransportExampleSuite::usage =
  "RunActiveTransportExampleSuite[] audits the certified and broken branch models.";
ActiveTransportLedgerUpdates::usage =
  "ActiveTransportLedgerUpdates[] returns theorem-ledger status updates derived from the example suite.";

Begin["`Private`"]

CertifiedActiveTransportModel[] :=
  Module[{lambda},
    <|
      "Name" -> "certified_polynomial_branch",
      "Parameter" -> lambda,
      "Assumptions" -> 1 <= lambda <= 3,
      "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
      "RhoDom" -> {0, 0, lambda + 1},
      "Nu" -> lambda + 1,
      "Jdesc" -> {0, 0, 1},
      "ContinuityWitnesses" -> {}
    |>
  ];

BrokenActiveTransportModels[] :=
  Module[{lambda},
    {
      <|
        "Name" -> "broken_zero_sign_undefined",
        "Parameter" -> lambda,
        "Assumptions" -> 1 <= lambda <= 3,
        "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
        "RhoDom" -> {0, 0, lambda - 2},
        "Nu" -> 1,
        "Jdesc" -> {0, 0, 1},
        "ContinuityWitnesses" -> {}
      |>,
      <|
        "Name" -> "broken_jump_discontinuity",
        "Parameter" -> lambda,
        "Assumptions" -> 1 <= lambda <= 3,
        "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
        "RhoDom" -> {0, 0, 1 + UnitStep[lambda - 2]},
        "Nu" -> 1,
        "Jdesc" -> {0, 0, 1},
        "ContinuityWitnesses" -> {2}
      |>,
      <|
        "Name" -> "broken_ambiguity_not_in_kernel",
        "Parameter" -> lambda,
        "Assumptions" -> 1 <= lambda <= 3,
        "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
        "RhoDom" -> {1, 0, 1},
        "Nu" -> 1,
        "Jdesc" -> {0, 0, 1},
        "ContinuityWitnesses" -> {}
      |>
    }
  ];

DerivedChi[model_Association] := Together[model["RhoDom"]/model["Nu"]];

DominantScalar[model_Association] := Expand[model["RhoDom"] . model["Jdesc"]];

epsilonExpression[model_Association] := Together[DominantScalar[model]/model["Nu"]];

AcceptedBranchComponents[model_Association] := ConnectedComponents1D[model["Assumptions"], model["Parameter"]];

SignDefinedComponents[model_Association] :=
  Module[{var = model["Parameter"], scalar = DominantScalar[model], nu = model["Nu"]},
    ConnectedComponents1D[model["Assumptions"] && scalar != 0 && nu != 0, var]
  ];

scalarContinuityQ[expr_, var_Symbol, assumptions_, witnesses_List] :=
  Module[{rationalQ, witnessChecks},
    rationalQ = RationalContinuousOnDomainQ[expr, var, assumptions];
    If[rationalQ,
      True,
      witnessChecks = Table[
        FullSimplify[
          Limit[expr, var -> point, Direction -> "FromBelow"] ==
            Limit[expr, var -> point, Direction -> "FromAbove"] ==
            (expr /. var -> point)
        ],
        {point, witnesses}
      ];
      If[witnessChecks === {}, False, And @@ TrueQ /@ witnessChecks]
    ]
  ];

continuityWitnessDetails[expr_, var_Symbol, witnesses_List] :=
  Association@Table[
    point -> <|
      "LeftLimit" -> Limit[expr, var -> point, Direction -> "FromBelow"],
      "RightLimit" -> Limit[expr, var -> point, Direction -> "FromAbove"],
      "Value" -> (expr /. var -> point)
    |>,
    {point, witnesses}
  ];

undefinedSignWitness[model_Association] :=
  Module[{var = model["Parameter"], scalar = DominantScalar[model], nu = model["Nu"]},
    FindInstance[model["Assumptions"] && (scalar == 0 || nu == 0), {var}, Reals]
  ];

componentSignCertificate[model_Association] :=
  Module[{var = model["Parameter"], epsExpr = epsilonExpression[model], components, signs},
    components = SignDefinedComponents[model];
    signs = ComponentSigns[epsExpr, var, components];
    <|
      "Components" -> components,
      "Signs" -> signs,
      "Certified" -> AllTrue[Values[signs], MemberQ[{1, -1}, #] &]
    |>
  ];

AuditActiveTransportModel[model_Association] :=
  Module[{var, assumptions, basis, rho, nu, jdesc, chi, scalar, epsExpr, annihilation, affineConstancy,
    normalization, nonvanishing, continuity, undefinedWitness, signComponents, constancyCounterexample,
    acceptedComponents},
    var = model["Parameter"];
    assumptions = model["Assumptions"];
    basis = model["Aminus"];
    rho = model["RhoDom"];
    nu = model["Nu"];
    jdesc = model["Jdesc"];
    chi = DerivedChi[model];
    scalar = DominantScalar[model];
    epsExpr = epsilonExpression[model];
    acceptedComponents = AcceptedBranchComponents[model];
    annihilation = AnnihilatesSubspaceQ[chi, basis, {var}, assumptions];
    affineConstancy = AffineClassConstantQ[chi, jdesc, basis, chi . jdesc, {var}, assumptions];
    normalization = ExactForAllTrue[{var}, assumptions, chi == Together[rho/nu]];
    nonvanishing = NonvanishingOnDomainQ[scalar, var, assumptions] && NonvanishingOnDomainQ[nu, var, assumptions];
    continuity = scalarContinuityQ[scalar, var, assumptions, Lookup[model, "ContinuityWitnesses", {}]];
    undefinedWitness = undefinedSignWitness[model];
    signComponents = componentSignCertificate[model];
    constancyCounterexample = If[TrueQ[affineConstancy],
      {},
      Module[{a1, a2},
        ExactCounterexampleSearch[
          assumptions,
          chi . (jdesc + basis . {a1, a2}) == chi . jdesc,
          {var, a1, a2}
        ]
      ]
    ];
    <|
      "Name" -> model["Name"],
      "AcceptedBranchComponents" -> acceptedComponents,
      "SignDefinedComponents" -> signComponents["Components"],
      "DerivedChi" -> chi,
      "DominantScalar" -> scalar,
      "EpsilonExpression" -> epsExpr,
      "Claims" -> <|
        "Annihilation of Aminus" -> <|
          "Status" -> If[annihilation, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> annihilation
        |>,
        "Constancy on affine class" -> <|
          "Status" -> If[affineConstancy, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> affineConstancy,
          "Counterexample" -> constancyCounterexample
        |>,
        "Normalization chi = nu^-1 rho" -> <|
          "Status" -> If[normalization, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> normalization
        |>,
        "Continuity of dominant scalar" -> <|
          "Status" -> If[continuity, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> continuity,
          "WitnessDetails" -> continuityWitnessDetails[scalar, var, Lookup[model, "ContinuityWitnesses", {}]]
        |>,
        "Sign defined on full branch" -> <|
          "Status" -> If[nonvanishing, "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> nonvanishing,
          "UndefinedWitness" -> undefinedWitness
        |>,
        "Local constancy of branch sign on sign-defined components" -> <|
          "Status" -> If[signComponents["Certified"], "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> signComponents["Certified"],
          "ComponentSigns" -> signComponents["Signs"]
        |>,
        "Sign changes only across zeros of rho or nu" -> <|
          "Status" -> If[signComponents["Certified"], "exact finite-dimensional certificate", "counterexample found"],
          "Certified" -> signComponents["Certified"],
          "ExcludedSetWitness" -> undefinedWitness
        |>
      |>
    |>
  ];

RunActiveTransportExampleSuite[] :=
  Module[{certified = AuditActiveTransportModel[CertifiedActiveTransportModel[]],
    broken = AuditActiveTransportModel /@ BrokenActiveTransportModels[]},
    <|"CertifiedModel" -> certified, "BrokenModels" -> broken|>
  ];

ActiveTransportLedgerUpdates[] :=
  Module[{suite = RunActiveTransportExampleSuite[], certifiedClaims},
    certifiedClaims = suite["CertifiedModel", "Claims"];
    <|
      "thm:active-response-transport-minimal" -> <|
        "Method" -> "Resolve/Reduce on an exact polynomial branch model, connected-component audit, and broken-model hypothesis drops.",
        "Status" -> If[
          And @@ TrueQ /@ Lookup[
            Values @ KeyTake[
              certifiedClaims,
              {
                "Annihilation of Aminus",
                "Constancy on affine class",
                "Normalization chi = nu^-1 rho",
                "Continuity of dominant scalar",
                "Sign defined on full branch",
                "Local constancy of branch sign on sign-defined components"
              }
            ],
            "Certified"
          ],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "Continuity is certified only for the chosen exact model family.",
          "The theorem is not universally proved for all admissible branches."
        },
        "RepresentativeModelFamily" -> "certified_polynomial_branch, broken_zero_sign_undefined, broken_jump_discontinuity, broken_ambiguity_not_in_kernel",
        "NoApproximationQ" -> True
      |>,
      "thm:char-weak-interface" -> <|
        "Method" -> "Exact export chi = nu^-1 rho^dom with affine constancy, sign-defined components, and ambiguity-leak counterexample.",
        "Status" -> If[
          certifiedClaims["Normalization chi = nu^-1 rho", "Certified"] &&
            certifiedClaims["Annihilation of Aminus", "Certified"] &&
            certifiedClaims["Constancy on affine class", "Certified"] &&
            certifiedClaims["Local constancy of branch sign on sign-defined components", "Certified"],
          "exact finite-dimensional certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "exact-model-certificate",
        "SurrogateBlindSpots" -> {
          "The weak export is checked on exact branch models rather than universally."
        },
        "RepresentativeModelFamily" -> "certified_polynomial_branch with explicit broken hypothesis models",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
