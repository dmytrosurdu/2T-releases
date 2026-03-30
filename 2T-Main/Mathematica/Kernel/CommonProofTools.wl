BeginPackage["MainProof`CommonProofTools`"]

$AllowedProofStatuses::usage =
  "$AllowedProofStatuses is the ordered list of permitted theorem statuses.";
$AllowedScopeClasses::usage =
  "$AllowedScopeClasses is the ordered list of permitted scope classes.";
StatusRecord::usage =
  "StatusRecord[label, assumptions, method, status, details] builds a normalized report row.";
NormalizeBasis::usage =
  "NormalizeBasis[basis, dim] normalizes a basis matrix, allowing empty and one-vector inputs.";
IndependentColumnBasis::usage =
  "IndependentColumnBasis[m] keeps a maximal independent set of columns of m.";
ZeroVector::usage =
  "ZeroVector[n] returns the zero vector of length n.";
ExactForAllTrue::usage =
  "ExactForAllTrue[vars, assumptions, expr] proves expr for all real vars under assumptions using Resolve.";
ExactExistsWitness::usage =
  "ExactExistsWitness[vars, assumptions, expr] searches for an exact real witness with Resolve.";
SymmetricPositiveDefiniteQ::usage =
  "SymmetricPositiveDefiniteQ[m, assumptions] certifies exact positive definiteness via principal minors when needed.";
AnnihilatesSubspaceQ::usage =
  "AnnihilatesSubspaceQ[functional, basis, vars, assumptions] certifies that the functional vanishes on the basis span.";
AffineClassConstantQ::usage =
  "AffineClassConstantQ[functional, representative, basis, value, vars, assumptions] certifies constancy on an affine class.";
IdempotentProjectorQ::usage =
  "IdempotentProjectorQ[p, assumptions] certifies p.p == p.";
RankOneProjectorQ::usage =
  "RankOneProjectorQ[p, assumptions] checks idempotence and rank one.";
FullColumnRankQ::usage =
  "FullColumnRankQ[m] checks exact full column rank.";
FullRowRankQ::usage =
  "FullRowRankQ[m] checks exact full row rank.";
KernelBasisFromFunctional::usage =
  "KernelBasisFromFunctional[chi] returns a basis matrix for ker chi.";
ExactVectorEqualQ::usage =
  "ExactVectorEqualQ[v1, v2] checks exact symbolic equality of two vectors entrywise after Together.";
ExactMatrixEqualQ::usage =
  "ExactMatrixEqualQ[m1, m2] checks exact symbolic equality of two matrices entrywise after Together.";
VectorInSpanQ::usage =
  "VectorInSpanQ[v, basis] checks exact membership of v in the span of basis vectors.";
MatrixInSpanQ::usage =
  "MatrixInSpanQ[m, basis] checks exact membership of m in the span of basis matrices.";
ConnectedComponents1D::usage =
  "ConnectedComponents1D[condition, var] returns exact one-dimensional connected components as Reduce conditions.";
ComponentSigns::usage =
  "ComponentSigns[expr, var, components] returns the exact sign on each component when provable.";
NonvanishingOnDomainQ::usage =
  "NonvanishingOnDomainQ[expr, var, assumptions] proves expr != 0 on the real domain.";
ConstantSignOnDomain::usage =
  "ConstantSignOnDomain[expr, var, assumptions] returns 1, -1, or Missing if no exact constant sign is proved.";
RationalContinuousOnDomainQ::usage =
  "RationalContinuousOnDomainQ[expr, var, assumptions] certifies continuity for rational expressions on the domain.";
ExactCounterexampleSearch::usage =
  "ExactCounterexampleSearch[assumptions, expr, vars] searches for an exact counterexample to expr.";

Begin["`Private`"]

$AllowedProofStatuses = {
  "proved",
  "exact finite-dimensional certificate",
  "numerical evidence only",
  "counterexample found",
  "deferred"
};

$AllowedScopeClasses = {
  "schema-validator",
  "exact-model-certificate",
  "finite-dimensional-theorem-certificate",
  "abstract-imported-assumptions",
  "deferred"
};

validStatusQ[status_String] := MemberQ[$AllowedProofStatuses, status];
validScopeClassQ[scope_String] := MemberQ[$AllowedScopeClasses, scope];

StatusRecord[label_String, assumptions_, method_String, status_String, details_: <||>] :=
  Module[{base, scopeClass, noApproximation},
    scopeClass = Lookup[details, "ScopeClass", "deferred"];
    noApproximation = Lookup[details, "NoApproximationQ", False];
    base = <|
      "TheoremLabel" -> label,
      "Assumptions" -> assumptions,
      "Method" -> method,
      "Status" -> If[validStatusQ[status], status, "deferred"],
      "ScopeClass" -> If[validScopeClassQ[scopeClass], scopeClass, "deferred"],
      "SurrogateBlindSpots" -> Lookup[details, "SurrogateBlindSpots", {}],
      "CertificateArtifact" -> Lookup[details, "CertificateArtifact", Missing["NotAssigned"]],
      "CounterexampleArtifact" -> Lookup[details, "CounterexampleArtifact", Missing["NotAssigned"]],
      "RepresentativeModelFamily" -> Lookup[details, "RepresentativeModelFamily", Missing["NotAssigned"]],
      "NoApproximationQ" -> TrueQ[noApproximation]
    |>;
    Join[
      base,
      KeyDrop[details, Keys[base]],
      If[validStatusQ[status], <||>, <|"Note" -> StringJoin["Invalid status requested: ", status]|>],
      If[validScopeClassQ[scopeClass], <||>, <|"ScopeClassNote" -> StringJoin["Invalid scope class requested: ", ToString[scopeClass]]|>]
    ]
  ];

NormalizeBasis[basis_, dim_: Automatic] := Which[
  basis === {} || basis === {{}},
    ConstantArray[0, {Replace[dim, Automatic :> 0], 0}],
  MatrixQ[basis],
    basis,
  VectorQ[basis] && IntegerQ[dim] && Length[basis] == dim,
    Transpose[{basis}],
  True,
    basis
];

IndependentColumnBasis[m_?MatrixQ] := Module[{cols = Dimensions[m][[2]], rr, pivots},
  If[cols == 0,
    m,
    rr = RowReduce[m];
    pivots = DeleteDuplicates @ DeleteMissing @ Map[
      FirstCase[Unitize[#], 1, Missing["NoPivot"]] &,
      rr
    ];
    m[[All, pivots]]
  ]
];

ZeroVector[n_Integer?NonNegative] := ConstantArray[0, n];

ExactForAllTrue[vars_List, assumptions_, expr_] :=
  TrueQ @ Resolve[ForAll[vars, assumptions \[Implies] expr], Reals];

ExactExistsWitness[vars_List, assumptions_, expr_] :=
  TrueQ @ Resolve[Exists[vars, assumptions && expr], Reals];

principalMinorCertificate[m_?MatrixQ, assumptions_] :=
  Module[{n = Length[m], minors},
    minors = Table[Det[m[[;; i, ;; i]]], {i, n}];
    ExactForAllTrue[{}, assumptions, SymmetricMatrixQ[m] && And @@ Thread[minors > 0]]
  ];

SymmetricPositiveDefiniteQ[m_?MatrixQ, assumptions_: True] :=
  Module[{direct = Quiet[PositiveDefiniteMatrixQ[m]]},
    If[BooleanQ[direct],
      direct && SymmetricMatrixQ[m],
      principalMinorCertificate[m, assumptions]
    ]
  ];

AnnihilatesSubspaceQ[functional_?VectorQ, basis_?MatrixQ, vars_List : {}, assumptions_: True] :=
  Module[{cols = Dimensions[basis][[2]], expr},
    If[cols == 0,
      True,
      expr = Thread[functional . basis == ZeroVector[cols]];
      ExactForAllTrue[vars, assumptions, And @@ expr]
    ]
  ];

AffineClassConstantQ[
  functional_?VectorQ,
  representative_?VectorQ,
  basis_?MatrixQ,
  value_,
  vars_List : {},
  assumptions_: True
] :=
  Module[{cols = Dimensions[basis][[2]], coeffs, affineExpr, fullVars},
    coeffs = Array[Unique["a"], cols];
    affineExpr = functional . (representative + basis.coeffs);
    fullVars = Join[vars, coeffs];
    ExactForAllTrue[fullVars, assumptions, affineExpr == value]
  ];

IdempotentProjectorQ[p_?MatrixQ, assumptions_: True] :=
  ExactForAllTrue[{}, assumptions, p . p == p];

RankOneProjectorQ[p_?MatrixQ, assumptions_: True] :=
  IdempotentProjectorQ[p, assumptions] && MatrixRank[p] == 1;

FullColumnRankQ[m_?MatrixQ] := MatrixRank[m] == Dimensions[m][[2]];

FullRowRankQ[m_?MatrixQ] := MatrixRank[m] == Dimensions[m][[1]];

KernelBasisFromFunctional[chi_?VectorQ] :=
  Module[{dim = Length[chi], ns},
    ns = NullSpace[{chi}];
    If[ns === {},
      ConstantArray[0, {dim, 0}],
      Transpose[ns]
    ]
  ];

ExactVectorEqualQ[v1_?VectorQ, v2_?VectorQ] /; Length[v1] == Length[v2] :=
  AllTrue[Together /@ (v1 - v2), TrueQ[# == 0] &];

ExactMatrixEqualQ[m1_?MatrixQ, m2_?MatrixQ] /; Dimensions[m1] == Dimensions[m2] :=
  AllTrue[Flatten[Together /@ (m1 - m2)], TrueQ[# == 0] &];

VectorInSpanQ[v_?VectorQ, basis_List] :=
  Module[{basisMat, coeffs},
    If[basis === {} || basis === {{}},
      ExactVectorEqualQ[v, ZeroVector[Length[v]]],
      basisMat = Transpose[basis];
      coeffs = Array[Unique["c"], Length[basis]];
      ExactExistsWitness[coeffs, True, And @@ Thread[v == basisMat.coeffs]]
    ]
  ];

MatrixInSpanQ[m_?MatrixQ, basis_List] :=
  Module[{target, basisMat, coeffs},
    target = Flatten[m];
    If[basis === {} || basis === {{}},
      ExactVectorEqualQ[target, ZeroVector[Length[target]]],
      basisMat = Transpose[Flatten /@ basis];
      coeffs = Array[Unique["c"], Length[basis]];
      ExactExistsWitness[coeffs, True, And @@ Thread[target == basisMat.coeffs]]
    ]
  ];

ConnectedComponents1D[condition_, var_Symbol] :=
  Module[{reduced = LogicalExpand @ Reduce[condition, var, Reals]},
    Which[
      reduced === False, {},
      reduced === True, {True},
      Head[reduced] === Or, List @@ reduced,
      True, {reduced}
    ]
  ];

ComponentSigns[expr_, var_Symbol, components_List] :=
  Association@Table[
    component -> ConstantSignOnDomain[expr, var, component],
    {component, components}
  ];

NonvanishingOnDomainQ[expr_, var_Symbol, assumptions_: True] :=
  ExactForAllTrue[{var}, assumptions, expr != 0];

ConstantSignOnDomain[expr_, var_Symbol, assumptions_: True] :=
  Which[
    ExactForAllTrue[{var}, assumptions, expr > 0], 1,
    ExactForAllTrue[{var}, assumptions, expr < 0], -1,
    True, Missing["NotConstantSign"]
  ];

RationalContinuousOnDomainQ[expr_, var_Symbol, assumptions_: True] :=
  Module[{together = Together[expr], denom},
    denom = Denominator[together];
    If[PolynomialQ[Numerator[together], var] && PolynomialQ[denom, var],
      ExactForAllTrue[{var}, assumptions, denom != 0],
      False
    ]
  ];

ExactCounterexampleSearch[assumptions_, expr_, vars_List] :=
  Quiet@FindInstance[assumptions && Not[expr], vars, Reals];

End[]

EndPackage[]
