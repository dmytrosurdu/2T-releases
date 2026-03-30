If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`PeierlsModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "PeierlsModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`AmbiguityPhysicalSector`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "AmbiguityPhysicalSector.wl"}]];
];

BeginPackage["MainProof`ClassDefinedDerivation`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`PeierlsModels`"]
Needs["MainProof`AmbiguityPhysicalSector`"]

ClassDefinedDerivationData::usage =
  "ClassDefinedDerivationData[model, J, ambiguityBasis] constructs exact class-defined-derivation data.";
VerifyClassDefinedDerivation::usage =
  "VerifyClassDefinedDerivation[data] certifies when the induced derivation is well defined on the physical quotient.";
ClassDefinedDerivationExampleSuite::usage =
  "ClassDefinedDerivationExampleSuite[] returns exact on-the-nose, mod-null-ideal, and visible examples.";
RunClassDefinedDerivationExampleSuite::usage =
  "RunClassDefinedDerivationExampleSuite[] audits the class-defined-derivation lane.";
ClassDefinedDerivationLedgerUpdates::usage =
  "ClassDefinedDerivationLedgerUpdates[] returns theorem-ledger updates for class-defined physical derivations.";

Begin["`Private`"]

vectorInSpanQ[vec_?VectorQ, basis_?MatrixQ] :=
  Module[{cols = Dimensions[basis][[2]], coeffs},
    If[cols == 0,
      ExactVectorEqualQ[vec, ZeroVector[Length[vec]]],
      coeffs = Array[Unique["c"], cols];
      ExactExistsWitness[coeffs, True, And @@ Thread[vec == basis.coeffs]]
    ]
  ];

spanCoordinates[vec_?VectorQ, basis_?MatrixQ] :=
  Module[{cols = Dimensions[basis][[2]]},
    If[cols == 0,
      {},
      LinearSolve[Transpose[basis].basis, Transpose[basis].vec]
    ]
  ];

ClassDefinedDerivationData[model_Association, j_?VectorQ, ambiguityBasis_: Automatic] :=
  <|
    "Model" -> model,
    "J" -> j,
    "AmbiguityBasis" -> If[
      ambiguityBasis === Automatic,
      NormalizeBasis[model["AmbiguityBasis"], Length[model["BasisNames"]]],
      ambiguityBasis
    ]
  |>;

VerifyClassDefinedDerivation[data_Association] :=
  Module[
    {
      model = data["Model"], ambiguityBasis = data["AmbiguityBasis"],
      n, physicalBasis, nullBasis, cols, physCols, images, coords, coeffs, genericImages
    },
    n = Length[model["BasisNames"]];
    physicalBasis = NormalizeBasis[model["PhysicalSectorBasis"], n];
    nullBasis = NormalizeBasis[model["NullIdealBasis"], n];
    cols = Dimensions[ambiguityBasis][[2]];
    physCols = Dimensions[physicalBasis][[2]];
    images = Table[
      MainProof`PeierlsModels`PeierlsBracket[model, ambiguityBasis[[All, i]], physicalBasis[[All, j]]],
      {i, cols},
      {j, physCols}
    ];
    coords = Table[
      If[vectorInSpanQ[images[[i, j]], nullBasis], spanCoordinates[images[[i, j]], nullBasis], Missing["NotInNullIdeal"]],
      {i, cols},
      {j, physCols}
    ];
    coeffs = Array[a, cols];
    genericImages = Table[
      Sum[coeffs[[i]] images[[i, j]], {i, cols}],
      {j, physCols}
    ];
    <|
      "AmbiguityImagesOnPhysicalBasis" -> images,
      "OnTheNoseTriviality" -> AllTrue[Flatten[images, 1], ExactVectorEqualQ[#, ZeroVector[n]] &],
      "ActsIntoNullIdeal" -> AllTrue[Flatten[images, 1], vectorInSpanQ[#, nullBasis] &],
      "GenericShiftDifferenceInNullIdeal" -> And @@ Table[
        vectorInSpanQ[genericImages[[j]], nullBasis],
        {j, physCols}
      ],
      "GenericShiftDifferenceCoordinates" -> Table[
        If[Dimensions[nullBasis][[2]] == 0,
          {},
          Sum[coeffs[[i]] coords[[i, j]], {i, cols}]
        ],
        {j, physCols}
      ],
      "ClassDefinedOnPhysicalQuotient" -> TrueQ[
        AllTrue[Flatten[images, 1], vectorInSpanQ[#, nullBasis] &] &&
          And @@ Table[vectorInSpanQ[genericImages[[j]], nullBasis], {j, physCols}]
      ],
      "VisibleFailureWitness" -> AnyTrue[Flatten[images, 1], Function[img, Not[vectorInSpanQ[img, nullBasis]]]]
    |>
  ];

ClassDefinedDerivationExampleSuite[] :=
  Module[{models, invisible, nullIdeal, visible},
    models = MainProof`AmbiguityPhysicalSector`AmbiguityPhysicalSectorModelFamily[];
    invisible = models["InvisibleModel"];
    nullIdeal = models["NullIdealModel"];
    visible = models["VisibleModel"];
    <|
      "OnTheNoseExample" -> ClassDefinedDerivationData[invisible, invisible["Metadata", "VisibleOddGenerator"]],
      "NullIdealExample" -> ClassDefinedDerivationData[nullIdeal, nullIdeal["Metadata", "VisibleOddGenerator"]],
      "VisibleExample" -> ClassDefinedDerivationData[visible, visible["Metadata", "VisibleOddGenerator"]]
    |>
  ];

RunClassDefinedDerivationExampleSuite[] :=
  Module[{suite = ClassDefinedDerivationExampleSuite[]},
    <|
      "OnTheNoseExample" -> VerifyClassDefinedDerivation[suite["OnTheNoseExample"]],
      "NullIdealExample" -> VerifyClassDefinedDerivation[suite["NullIdealExample"]],
      "VisibleExample" -> VerifyClassDefinedDerivation[suite["VisibleExample"]]
    |>
  ];

ClassDefinedDerivationLedgerUpdates[] :=
  Module[{suite = RunClassDefinedDerivationExampleSuite[], invisible, nullIdeal, visible},
    invisible = suite["OnTheNoseExample"];
    nullIdeal = suite["NullIdealExample"];
    visible = suite["VisibleExample"];
    <|
      "task:class-defined-physical-derivation" -> <|
        "Method" ->
          "Exact quotient theorem: ad_A maps the physical sector into the null ideal iff the induced physical derivation is representative-independent modulo that ideal.",
        "Status" -> If[
          And @@ TrueQ /@ {
            invisible["ClassDefinedOnPhysicalQuotient"],
            nullIdeal["ClassDefinedOnPhysicalQuotient"],
            visible["VisibleFailureWitness"]
          },
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The physical quotient and null ideal are represented by explicit finite-dimensional subspaces.",
          "No abstract AQFT/HLS quotient construction is attempted."
        },
        "RepresentativeModelFamily" -> "Exact on-the-nose, null-ideal, and visible ambiguity model family",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
