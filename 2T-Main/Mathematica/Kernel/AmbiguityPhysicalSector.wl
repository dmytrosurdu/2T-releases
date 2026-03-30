If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`PeierlsModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "PeierlsModels.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`Hamiltonization`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "Hamiltonization.wl"}]];
];

BeginPackage["MainProof`AmbiguityPhysicalSector`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`PeierlsModels`"]
Needs["MainProof`Hamiltonization`"]

AmbiguityPhysicalSectorData::usage =
  "AmbiguityPhysicalSectorData[model, J, A] constructs exact data for the ambiguity shift J -> J + A.";
VerifyAmbiguityPhysicalSector::usage =
  "VerifyAmbiguityPhysicalSector[data] classifies ambiguity action on the physical sector.";
AmbiguityPhysicalSectorModelFamily::usage =
  "AmbiguityPhysicalSectorModelFamily[] returns exact invisible, null-ideal, and visible models in one common basis.";
AmbiguityPhysicalSectorExampleSuite::usage =
  "AmbiguityPhysicalSectorExampleSuite[] returns example data for the physical-sector ambiguity lane.";
RunAmbiguityPhysicalSectorExampleSuite::usage =
  "RunAmbiguityPhysicalSectorExampleSuite[] audits the ambiguity-physical-sector models and the even-J broken example.";
AmbiguityPhysicalSectorLedgerUpdates::usage =
  "AmbiguityPhysicalSectorLedgerUpdates[] returns theorem-ledger updates for the three ambiguity-action levels.";

Begin["`Private`"]

vectorInSpanQ[vec_?VectorQ, basis_?MatrixQ] :=
  Module[{cols = Dimensions[basis][[2]], coeffs},
    If[cols == 0,
      ExactVectorEqualQ[vec, ZeroVector[Length[vec]]],
      coeffs = Array[Unique["c"], cols];
      ExactExistsWitness[coeffs, True, And @@ Thread[vec == basis.coeffs]]
    ]
  ];

commonNames[] := {"1", "x", "n", "a", "b"};

commonIdentityRules[] :=
  Join[
    Table[{"1", name} -> name, {name, commonNames[]}],
    Table[{name, "1"} -> name, {name, commonNames[]}]
  ];

commonModelRules[kind_String] :=
  Join[
    commonIdentityRules[],
    {
      {"x", "x"} -> "x",
      {"b", "x"} -> "b",
      {"x", "b"} -> 0,
      {"x", "n"} -> 0
    },
    Switch[
      kind,
      "Invisible",
        {
          {"a", "x"} -> 0,
          {"x", "a"} -> 0,
          {"n", "x"} -> 0
        },
      "NullIdeal",
        {
          {"a", "x"} -> "n",
          {"x", "a"} -> 0,
          {"n", "x"} -> "n"
        },
      "Visible",
        {
          {"a", "x"} -> "a",
          {"x", "a"} -> 0,
          {"n", "x"} -> 0
        }
    ]
  ];

commonModel[kind_String] :=
  MainProof`PeierlsModels`PeierlsModelData[
    commonNames[],
    commonModelRules[kind],
    {1, 1, -1, -1, -1},
    "PhysicalSectorBasis" -> Transpose[{UnitVector[5, 1], UnitVector[5, 2]}],
    "AmbiguityBasis" -> Transpose[{UnitVector[5, 4]}],
    "NullIdealBasis" -> If[kind === "NullIdeal", Transpose[{UnitVector[5, 3]}], ConstantArray[0, {5, 0}]],
    "Label" -> StringJoin[ToLowerCase[kind], "_ambiguity_physical_sector_model"],
    "Metadata" -> <|
      "VisibleOddGenerator" -> UnitVector[5, 5],
      "AmbiguityGenerator" -> UnitVector[5, 4],
      "EvenGenerator" -> UnitVector[5, 2]
    |>
  ];

AmbiguityPhysicalSectorModelFamily[] :=
  <|
    "InvisibleModel" -> commonModel["Invisible"],
    "NullIdealModel" -> commonModel["NullIdeal"],
    "VisibleModel" -> commonModel["Visible"]
  |>;

AmbiguityPhysicalSectorData[model_Association, j_?VectorQ, a_?VectorQ] :=
  <|"Model" -> model, "J" -> j, "A" -> a|>;

classifyPhysicalAction[images_List, nullBasis_?MatrixQ] :=
  Which[
    AllTrue[images, ExactVectorEqualQ[#, ZeroVector[Length[#]]] &], "bracket-trivial on the nose",
    AllTrue[images, vectorInSpanQ[#, nullBasis] &], "trivial modulo physical null ideal",
    True, "physically visible"
  ];

VerifyAmbiguityPhysicalSector[data_Association] :=
  Module[
    {
      model = data["Model"], j = data["J"], a = data["A"], shifted,
      dJ, dShifted, dA, physicalBasis, nullBasis, n, images, class
    },
    n = Length[model["BasisNames"]];
    physicalBasis = NormalizeBasis[model["PhysicalSectorBasis"], n];
    nullBasis = NormalizeBasis[model["NullIdealBasis"], n];
    shifted = j + a;
    dJ = MainProof`Hamiltonization`DerivationOperator[model, j];
    dShifted = MainProof`Hamiltonization`DerivationOperator[model, shifted];
    dA = MainProof`Hamiltonization`DerivationOperator[model, a];
    images = Table[dA . physicalBasis[[All, i]], {i, Dimensions[physicalBasis][[2]]}];
    class = classifyPhysicalAction[images, nullBasis];
    <|
      "ModelChecks" -> MainProof`PeierlsModels`VerifyPeierlsModel[model],
      "DifferenceFormula" -> ExactMatrixEqualQ[dShifted - dJ, dA],
      "PhysicalImagesOfAmbiguity" -> images,
      "BracketTrivialOnTheNose" -> AllTrue[images, ExactVectorEqualQ[#, ZeroVector[n]] &],
      "ActsIntoNullIdeal" -> AllTrue[images, vectorInSpanQ[#, nullBasis] &],
      "PhysicallyVisible" -> AnyTrue[images, Function[img, Not[vectorInSpanQ[img, nullBasis]]]],
      "Classification" -> class
    |>
  ];

AmbiguityPhysicalSectorExampleSuite[] :=
  Module[{models, invisible, nullIdeal, visible},
    models = AmbiguityPhysicalSectorModelFamily[];
    invisible = models["InvisibleModel"];
    nullIdeal = models["NullIdealModel"];
    visible = models["VisibleModel"];
    <|
      "InvisibleExample" -> AmbiguityPhysicalSectorData[
        invisible,
        invisible["Metadata", "VisibleOddGenerator"],
        invisible["Metadata", "AmbiguityGenerator"]
      ],
      "NullIdealExample" -> AmbiguityPhysicalSectorData[
        nullIdeal,
        nullIdeal["Metadata", "VisibleOddGenerator"],
        nullIdeal["Metadata", "AmbiguityGenerator"]
      ],
      "VisibleExample" -> AmbiguityPhysicalSectorData[
        visible,
        visible["Metadata", "VisibleOddGenerator"],
        visible["Metadata", "AmbiguityGenerator"]
      ],
      "EvenJBrokenExample" -> <|
        "Model" -> invisible,
        "J" -> invisible["Metadata", "EvenGenerator"]
      |>
    |>
  ];

RunAmbiguityPhysicalSectorExampleSuite[] :=
  Module[{suite = AmbiguityPhysicalSectorExampleSuite[]},
    <|
      "InvisibleExample" -> VerifyAmbiguityPhysicalSector[suite["InvisibleExample"]],
      "NullIdealExample" -> VerifyAmbiguityPhysicalSector[suite["NullIdealExample"]],
      "VisibleExample" -> VerifyAmbiguityPhysicalSector[suite["VisibleExample"]],
      "EvenJBrokenExample" ->
        MainProof`Hamiltonization`VerifyOddDerivation[suite["EvenJBrokenExample", "Model"], suite["EvenJBrokenExample", "J"]]
    |>
  ];

AmbiguityPhysicalSectorLedgerUpdates[] :=
  Module[{suite = RunAmbiguityPhysicalSectorExampleSuite[], invisible, nullIdeal, visible},
    invisible = suite["InvisibleExample"];
    nullIdeal = suite["NullIdealExample"];
    visible = suite["VisibleExample"];
    <|
      "task:ambiguity-trivial-on-physical-sector" -> <|
        "Method" ->
          "Exact proof that delta_{J + A} - delta_J = ad_A and that ad_A vanishes on the physical sector.",
        "Status" -> If[
          TrueQ[invisible["DifferenceFormula"]] &&
            TrueQ[invisible["BracketTrivialOnTheNose"]] &&
            invisible["Classification"] === "bracket-trivial on the nose",
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Only explicit finite-dimensional bracket models are audited."
        },
        "RepresentativeModelFamily" -> "Exact five-basis invisible-ambiguity commutator model",
        "NoApproximationQ" -> True
      |>,
      "task:ambiguity-trivial-mod-null-ideal" -> <|
        "Method" ->
          "Exact proof that ad_A on the physical sector lands in the physical null ideal while remaining nonzero.",
        "Status" -> If[
          TrueQ[nullIdeal["DifferenceFormula"]] &&
            TrueQ[nullIdeal["ActsIntoNullIdeal"]] &&
            !TrueQ[nullIdeal["BracketTrivialOnTheNose"]] &&
            nullIdeal["Classification"] === "trivial modulo physical null ideal",
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The physical null ideal is represented by an explicit finite-dimensional subspace."
        },
        "RepresentativeModelFamily" -> "Exact five-basis null-ideal ambiguity model",
        "NoApproximationQ" -> True
      |>,
      "task:ambiguity-physically-visible" -> <|
        "Method" ->
          "Exact visible countermodel where ad_A acts nontrivially on the physical sector outside the null ideal.",
        "Status" -> If[
          TrueQ[visible["DifferenceFormula"]] &&
            TrueQ[visible["PhysicallyVisible"]] &&
            visible["Classification"] === "physically visible",
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Physical visibility is shown only on explicit bracket models."
        },
        "RepresentativeModelFamily" -> "Exact five-basis visible-ambiguity commutator model",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
