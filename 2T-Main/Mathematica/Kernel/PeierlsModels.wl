If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`PeierlsModels`"]

Needs["MainProof`CommonProofTools`"]

PeierlsModelData::usage =
  "PeierlsModelData[names, productRules, gammaSigns, opts] constructs an exact associative algebra model with a parity involution.";
ModelBasisVector::usage =
  "ModelBasisVector[data, name] returns the coordinate vector of the named basis element.";
ModelProduct::usage =
  "ModelProduct[data, x, y] multiplies two coefficient vectors in the exact model.";
GammaAction::usage =
  "GammaAction[data, x] applies the parity involution.";
PeierlsBracket::usage =
  "PeierlsBracket[data, x, y] returns the exact bracket, taken here as the commutator of the associative product.";
VerifyPeierlsModel::usage =
  "VerifyPeierlsModel[data] certifies associativity and parity compatibility.";
PeierlsModelExampleSuite::usage =
  "PeierlsModelExampleSuite[] returns exact invisible-ambiguity and visible-ambiguity bracket models.";

Begin["`Private`"]

Options[PeierlsModelData] = {
  "PhysicalSectorBasis" -> Automatic,
  "AmbiguityBasis" -> Automatic,
  "NullIdealBasis" -> Automatic,
  "Label" -> Automatic,
  "LocalityTags" -> <||>,
  "Metadata" -> <||>
};

outputVector[out_, names_List, index_Association] :=
  Module[{n = Length[names], vec},
    Which[
      out === 0 || out === {} || out === <||>,
        ConstantArray[0, n],
      StringQ[out],
        UnitVector[n, index[out]],
      VectorQ[out] && Length[out] == n,
        out,
      AssociationQ[out],
        vec = ConstantArray[0, n];
        KeyValueMap[(vec[[index[#1]]] = #2) &, out];
        vec,
      True,
        out
    ]
  ];

productTensorFromRules[names_List, rules_List] :=
  Module[{n = Length[names], index = AssociationThread[names -> Range[Length[names]]], tensor, i, j, vec},
    tensor = ConstantArray[0, {n, n, n}];
    Do[
      i = index[rule[[1, 1]]];
      j = index[rule[[1, 2]]];
      vec = outputVector[rule[[2]], names, index];
      tensor[[i, j, All]] = vec,
      {rule, rules}
    ];
    tensor
  ];

PeierlsModelData[names_List, productRules_List, gammaSigns_List, OptionsPattern[]] :=
  Module[{n = Length[names], tensor, index},
    tensor = productTensorFromRules[names, productRules];
    index = AssociationThread[names -> Range[n]];
    <|
      "BasisNames" -> names,
      "NameIndex" -> index,
      "ProductTensor" -> tensor,
      "GammaSigns" -> gammaSigns,
      "PhysicalSectorBasis" -> OptionValue["PhysicalSectorBasis"],
      "AmbiguityBasis" -> OptionValue["AmbiguityBasis"],
      "NullIdealBasis" -> OptionValue["NullIdealBasis"],
      "Label" -> OptionValue["Label"],
      "LocalityTags" -> OptionValue["LocalityTags"],
      "Metadata" -> OptionValue["Metadata"]
    |>
  ];

ModelBasisVector[data_Association, name_String] :=
  UnitVector[Length[data["BasisNames"]], data["NameIndex"][name]];

ModelProduct[data_Association, x_?VectorQ, y_?VectorQ] :=
  Module[{n = Length[data["BasisNames"]]},
    Sum[
      x[[i]] y[[j]] data["ProductTensor"][[i, j, All]],
      {i, n},
      {j, n}
    ]
  ];

GammaAction[data_Association, x_?VectorQ] := data["GammaSigns"] * x;

PeierlsBracket[data_Association, x_?VectorQ, y_?VectorQ] :=
  ModelProduct[data, x, y] - ModelProduct[data, y, x];

VerifyPeierlsModel[data_Association] :=
  Module[{n = Length[data["BasisNames"]], basisVectors, physicalBasis, ambiguityBasis, nullIdealBasis},
    basisVectors = IdentityMatrix[n];
    physicalBasis = NormalizeBasis[data["PhysicalSectorBasis"], n];
    ambiguityBasis = NormalizeBasis[data["AmbiguityBasis"], n];
    nullIdealBasis = NormalizeBasis[data["NullIdealBasis"], n];
    <|
      "AssociativeProduct" -> And @@ Flatten@Table[
        ExactVectorEqualQ[
          ModelProduct[data, ModelProduct[data, basisVectors[[i]], basisVectors[[j]]], basisVectors[[k]]],
          ModelProduct[data, basisVectors[[i]], ModelProduct[data, basisVectors[[j]], basisVectors[[k]]]]
        ],
        {i, n}, {j, n}, {k, n}
      ],
      "GammaInvolution" -> And @@ Table[
        ExactVectorEqualQ[GammaAction[data, GammaAction[data, basisVectors[[i]]]], basisVectors[[i]]],
        {i, n}
      ],
      "GammaProductAutomorphism" -> And @@ Flatten@Table[
        ExactVectorEqualQ[
          GammaAction[data, ModelProduct[data, basisVectors[[i]], basisVectors[[j]]]],
          ModelProduct[data, GammaAction[data, basisVectors[[i]]], GammaAction[data, basisVectors[[j]]]]
        ],
        {i, n}, {j, n}
      ],
      "GammaBracketCompatibility" -> And @@ Flatten@Table[
        ExactVectorEqualQ[
          GammaAction[data, PeierlsBracket[data, basisVectors[[i]], basisVectors[[j]]]],
          PeierlsBracket[data, GammaAction[data, basisVectors[[i]]], GammaAction[data, basisVectors[[j]]]]
        ],
        {i, n}, {j, n}
      ],
      "PhysicalSectorBasis" -> physicalBasis,
      "AmbiguityBasis" -> ambiguityBasis,
      "NullIdealBasis" -> nullIdealBasis
    |>
  ];

identityRules[names_List] :=
  Join[
    Table[{"1", name} -> name, {name, names}],
    Table[{name, "1"} -> name, {name, names}]
  ];

commonRules[] := {
  {"x", "x"} -> "x",
  {"b", "x"} -> "b"
};

invisibleRules[] := Join[
  identityRules[{"1", "x", "a", "b"}],
  commonRules[],
  {
    {"x", "b"} -> 0,
    {"a", "x"} -> 0,
    {"x", "a"} -> 0
  }
];

visibleRules[] := Join[
  identityRules[{"1", "x", "a", "b"}],
  commonRules[],
  {
    {"x", "b"} -> 0,
    {"a", "x"} -> "a",
    {"x", "a"} -> 0
  }
];

PeierlsModelExampleSuite[] :=
  Module[{names, gammaSigns, invisible, visible, physicalBasis, ambiguityBasis, b, a},
    names = {"1", "x", "a", "b"};
    gammaSigns = {1, 1, -1, -1};
    physicalBasis = Transpose[{UnitVector[4, 1], UnitVector[4, 2]}];
    ambiguityBasis = Transpose[{UnitVector[4, 3]}];
    a = UnitVector[4, 3];
    b = UnitVector[4, 4];
    invisible = PeierlsModelData[
      names,
      invisibleRules[],
      gammaSigns,
      "PhysicalSectorBasis" -> physicalBasis,
      "AmbiguityBasis" -> ambiguityBasis,
      "Label" -> "invisible_ambiguity_model",
      "Metadata" -> <|"VisibleOddGenerator" -> b, "ShiftedGenerator" -> b + a|>
    ];
    visible = PeierlsModelData[
      names,
      visibleRules[],
      gammaSigns,
      "PhysicalSectorBasis" -> physicalBasis,
      "AmbiguityBasis" -> ambiguityBasis,
      "Label" -> "visible_ambiguity_model",
      "Metadata" -> <|"VisibleOddGenerator" -> b, "ShiftedGenerator" -> b + a|>
    ];
    <|"InvisibleAmbiguityModel" -> invisible, "VisibleAmbiguityModel" -> visible|>
  ];

End[]

EndPackage[]
