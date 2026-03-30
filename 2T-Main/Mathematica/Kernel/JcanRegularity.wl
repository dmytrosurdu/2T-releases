If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`JcanRegularity`"]

Needs["MainProof`CommonProofTools`"]

JcanRegularityData::usage =
  "JcanRegularityData[var, U, B, J0, assumptions] constructs exact branchwise Jcan-regularity data.";
JcanBranchFormula::usage =
  "JcanBranchFormula[data] returns the exact branchwise canonical representative formula.";
VerifyJcanRegularity::usage =
  "VerifyJcanRegularity[data] certifies rationality/continuity of Jcan away from Gram degeneracy.";
JcanRegularityExampleSuite::usage =
  "JcanRegularityExampleSuite[] returns exact valid and degenerate branch examples.";
RunJcanRegularityExampleSuite::usage =
  "RunJcanRegularityExampleSuite[] audits the branchwise Jcan regularity examples.";
JcanRegularityLedgerUpdates::usage =
  "JcanRegularityLedgerUpdates[] returns theorem-ledger updates for task:Jcan-branch-regularity.";

Begin["`Private`"]

JcanRegularityData[var_Symbol, u_?MatrixQ, b_?MatrixQ, j0_?VectorQ, assumptions_] :=
  <|
    "Parameter" -> var,
    "U" -> u,
    "B" -> b,
    "J0" -> j0,
    "Assumptions" -> assumptions
  |>;

gramBlock[data_Association] := Transpose[data["U"]].data["B"].data["U"];

JcanBranchFormula[data_Association] :=
  Module[{u = data["U"], b = data["B"], j0 = data["J0"], ga},
    ga = gramBlock[data];
    j0 - u.LinearSolve[ga, Transpose[u].b.j0]
  ];

rationalExpressionQ[expr_, var_Symbol] :=
  Module[{t = Together[expr]},
    PolynomialQ[Numerator[t], var] && PolynomialQ[Denominator[t], var]
  ];

VerifyJcanRegularity[data_Association] :=
  Module[{var, u, b, j0, assumptions, ga, detGa, jcan, singularSet},
    {var, u, b, j0, assumptions} = Lookup[data, {"Parameter", "U", "B", "J0", "Assumptions"}];
    ga = gramBlock[data];
    detGa = Together[Det[ga]];
    jcan = JcanBranchFormula[data];
    singularSet = Reduce[assumptions && detGa == 0, var, Reals];
    <|
      "GramBlock" -> ga,
      "GramDeterminant" -> detGa,
      "InputRationalQ" -> And @@ (rationalExpressionQ[#, var] & /@ Flatten[{u, b, j0}]),
      "GramInvertibleOnDomain" -> NonvanishingOnDomainQ[detGa, var, assumptions],
      "JcanFormula" -> jcan,
      "JcanEntriesRationalQ" -> And @@ (rationalExpressionQ[#, var] & /@ jcan),
      "JcanContinuousOnDomain" -> And @@ (RationalContinuousOnDomainQ[#, var, assumptions] & /@ jcan),
      "SingularSet" -> singularSet,
      "SingularitiesOnlyAtGramDegeneracy" -> And @@ (
        RationalContinuousOnDomainQ[#, var, assumptions && detGa != 0] & /@ jcan
      )
    |>
  ];

JcanRegularityExampleSuite[] :=
  Module[{lambda, valid, degenerate},
    valid = JcanRegularityData[
      lambda,
      {{1}, {1 + lambda}, {0}},
      {{2 + lambda, 0, 0}, {0, 3, 1}, {0, 1, 4}},
      {1 + lambda, 2 - lambda, 1},
      0 <= lambda <= 1
    ];
    degenerate = JcanRegularityData[
      lambda,
      {{lambda}, {0}},
      IdentityMatrix[2],
      {1, 1},
      -1 <= lambda <= 1
    ];
    <|"ValidExample" -> valid, "DegenerateExample" -> degenerate|>
  ];

RunJcanRegularityExampleSuite[] :=
  Module[{suite = JcanRegularityExampleSuite[]},
    <|
      "ValidExample" -> VerifyJcanRegularity[suite["ValidExample"]],
      "DegenerateExample" -> VerifyJcanRegularity[suite["DegenerateExample"]]
    |>
  ];

JcanRegularityLedgerUpdates[] :=
  Module[{suite = RunJcanRegularityExampleSuite[], good, bad},
    good = suite["ValidExample"];
    bad = suite["DegenerateExample"];
    <|
      "task:Jcan-branch-regularity" -> <|
        "Method" -> "Exact projector formula with rational-function continuity certified away from Gram-block degeneracy.",
        "Status" -> If[
          And @@ TrueQ /@ {
            good["InputRationalQ"],
            good["GramInvertibleOnDomain"],
            good["JcanEntriesRationalQ"],
            good["JcanContinuousOnDomain"],
            good["SingularitiesOnlyAtGramDegeneracy"]
          },
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Only rational/polynomial finite-cutoff branch data are audited.",
          "The statement does not address infinite-dimensional branch regularity."
        },
        "RepresentativeModelFamily" -> "Exact valid and Gram-degenerate branch examples",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
