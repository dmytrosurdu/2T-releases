If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

If[!MemberQ[$Packages, "MainProof`PeierlsModels`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "PeierlsModels.wl"}]];
];

BeginPackage["MainProof`Hamiltonization`"]

Needs["MainProof`CommonProofTools`"]
Needs["MainProof`PeierlsModels`"]

DerivationOperator::usage =
  "DerivationOperator[model, J] returns the exact operator matrix for delta_J(A) = {J, A}.";
VerifyOddDerivation::usage =
  "VerifyOddDerivation[model, J] certifies the derivation and Gamma-odd identities.";
CalibrationSensitivityData::usage =
  "CalibrationSensitivityData[model, J1, J2] constructs exact derivation-comparison data.";
VerifyCalibrationSensitivity::usage =
  "VerifyCalibrationSensitivity[data] compares delta_J1 and delta_J2 and tests physical-sector invariance criteria.";
HamiltonizationExampleSuite::usage =
  "HamiltonizationExampleSuite[] returns exact odd-derivation and calibration-sensitivity examples.";
RunHamiltonizationExampleSuite::usage =
  "RunHamiltonizationExampleSuite[] audits the bracket-model lane.";
HamiltonizationLedgerUpdates::usage =
  "HamiltonizationLedgerUpdates[] returns theorem-ledger updates for the Peierls odd-derivation lane.";

Begin["`Private`"]

vectorInSpanQ[vec_?VectorQ, basis_?MatrixQ] :=
  Module[{cols = Dimensions[basis][[2]], coeffs},
    If[cols == 0,
      ExactVectorEqualQ[vec, ZeroVector[Length[vec]]],
      coeffs = Array[Unique["c"], cols];
      ExactExistsWitness[coeffs, True, And @@ Thread[vec == basis.coeffs]]
    ]
  ];

DerivationOperator[model_Association, j_?VectorQ] :=
  Module[{n = Length[model["BasisNames"]]},
    Transpose@Table[
      MainProof`PeierlsModels`PeierlsBracket[model, j, UnitVector[n, i]],
      {i, n}
    ]
  ];

VerifyOddDerivation[model_Association, j_?VectorQ] :=
  Module[{n = Length[model["BasisNames"]], basisVectors},
    basisVectors = IdentityMatrix[n];
    <|
      "ModelChecks" -> MainProof`PeierlsModels`VerifyPeierlsModel[model],
      "JOdd" -> ExactVectorEqualQ[MainProof`PeierlsModels`GammaAction[model, j], -j],
      "GammaOddDerivation" -> And @@ Table[
        ExactVectorEqualQ[
          MainProof`PeierlsModels`GammaAction[model, MainProof`PeierlsModels`PeierlsBracket[model, j, basisVectors[[i]]]],
          -MainProof`PeierlsModels`PeierlsBracket[model, j, MainProof`PeierlsModels`GammaAction[model, basisVectors[[i]]]]
        ],
        {i, n}
      ],
      "DerivationOnBasis" -> And @@ Flatten@Table[
        ExactVectorEqualQ[
          MainProof`PeierlsModels`PeierlsBracket[
            model,
            j,
            MainProof`PeierlsModels`ModelProduct[model, basisVectors[[i]], basisVectors[[k]]]
          ],
          MainProof`PeierlsModels`ModelProduct[
            model,
            MainProof`PeierlsModels`PeierlsBracket[model, j, basisVectors[[i]]],
            basisVectors[[k]]
          ] +
          MainProof`PeierlsModels`ModelProduct[
            model,
            basisVectors[[i]],
            MainProof`PeierlsModels`PeierlsBracket[model, j, basisVectors[[k]]]
          ]
        ],
        {i, n}, {k, n}
      ],
      "NontrivialOnPhysicalSector" -> Module[{physicalBasis = NormalizeBasis[model["PhysicalSectorBasis"], n]},
        Or @@ Table[
          !ExactVectorEqualQ[
            MainProof`PeierlsModels`PeierlsBracket[model, j, physicalBasis[[All, i]]],
            ZeroVector[n]
          ],
          {i, Dimensions[physicalBasis][[2]]}
        ]
      ]
    |>
  ];

CalibrationSensitivityData[model_Association, j1_?VectorQ, j2_?VectorQ] :=
  <|"Model" -> model, "J1" -> j1, "J2" -> j2|>;

VerifyCalibrationSensitivity[data_Association] :=
  Module[
    {
      model = data["Model"], j1 = data["J1"], j2 = data["J2"], deltaJ,
      d1, d2, dDelta, physicalBasis, ambiguityBasis, n
    },
    n = Length[model["BasisNames"]];
    physicalBasis = NormalizeBasis[model["PhysicalSectorBasis"], n];
    ambiguityBasis = NormalizeBasis[model["AmbiguityBasis"], n];
    deltaJ = j1 - j2;
    d1 = DerivationOperator[model, j1];
    d2 = DerivationOperator[model, j2];
    dDelta = DerivationOperator[model, deltaJ];
    <|
      "DeltaJ" -> deltaJ,
      "DifferenceFormula" -> ExactMatrixEqualQ[d1 - d2, dDelta],
      "DeltaJOdd" -> ExactVectorEqualQ[MainProof`PeierlsModels`GammaAction[model, deltaJ], -deltaJ],
      "DeltaJInAmbiguity" -> vectorInSpanQ[deltaJ, ambiguityBasis],
      "AmbiguityBracketTrivialOnPhysicalSector" -> And @@ Flatten@Table[
        ExactVectorEqualQ[
          MainProof`PeierlsModels`PeierlsBracket[model, ambiguityBasis[[All, i]], physicalBasis[[All, j]]],
          ZeroVector[n]
        ],
        {i, Dimensions[ambiguityBasis][[2]]},
        {j, Dimensions[physicalBasis][[2]]}
      ],
      "PhysicalSectorInvariantUnderDifference" -> And @@ Table[
        ExactVectorEqualQ[(d1 - d2).physicalBasis[[All, j]], ZeroVector[n]],
        {j, Dimensions[physicalBasis][[2]]}
      ],
      "PhysicalSectorNonInvariantWitness" -> Or @@ Table[
        !ExactVectorEqualQ[(d1 - d2).physicalBasis[[All, j]], ZeroVector[n]],
        {j, Dimensions[physicalBasis][[2]]}
      ]
    |>
  ];

HamiltonizationExampleSuite[] :=
  Module[{models, invisible, visible, b, shifted},
    models = MainProof`PeierlsModels`PeierlsModelExampleSuite[];
    invisible = models["InvisibleAmbiguityModel"];
    visible = models["VisibleAmbiguityModel"];
    b = invisible["Metadata", "VisibleOddGenerator"];
    shifted = invisible["Metadata", "ShiftedGenerator"];
    <|
      "OddDerivationExample" -> <|"Model" -> invisible, "J" -> b|>,
      "InvisibleSensitivityExample" -> CalibrationSensitivityData[invisible, b, shifted],
      "VisibleSensitivityExample" -> CalibrationSensitivityData[visible, b, shifted]
    |>
  ];

RunHamiltonizationExampleSuite[] :=
  Module[{suite = HamiltonizationExampleSuite[]},
    <|
      "OddDerivationExample" ->
        VerifyOddDerivation[suite["OddDerivationExample", "Model"], suite["OddDerivationExample", "J"]],
      "InvisibleSensitivityExample" -> VerifyCalibrationSensitivity[suite["InvisibleSensitivityExample"]],
      "VisibleSensitivityExample" -> VerifyCalibrationSensitivity[suite["VisibleSensitivityExample"]]
    |>
  ];

HamiltonizationLedgerUpdates[] :=
  Module[{suite = RunHamiltonizationExampleSuite[], derivation, invisible, visible, statusQ},
    derivation = suite["OddDerivationExample"];
    invisible = suite["InvisibleSensitivityExample"];
    visible = suite["VisibleSensitivityExample"];
    statusQ =
      And @@ TrueQ /@ {
        derivation["JOdd"],
        derivation["GammaOddDerivation"],
        derivation["DerivationOnBasis"],
        derivation["NontrivialOnPhysicalSector"],
        invisible["DifferenceFormula"],
        invisible["DeltaJInAmbiguity"],
        invisible["AmbiguityBracketTrivialOnPhysicalSector"],
        invisible["PhysicalSectorInvariantUnderDifference"],
        visible["DifferenceFormula"],
        visible["DeltaJInAmbiguity"],
        visible["PhysicalSectorNonInvariantWitness"]
      };
    <|
      "task:Peierls-odd-derivation" -> <|
        "Method" ->
          "Exact associative-model commutator bracket with parity involution; delta_J(A) = {J, A} checked on basis products.",
        "Status" -> If[
          And @@ TrueQ /@ {
            derivation["JOdd"],
            derivation["GammaOddDerivation"],
            derivation["DerivationOnBasis"],
            derivation["NontrivialOnPhysicalSector"]
          },
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "The bracket lane is audited only on explicit associative models.",
          "Locality/AQFT/HLS semantics remain imported metadata."
        },
        "RepresentativeModelFamily" -> "Exact four-basis associative commutator models with parity involution",
        "NoApproximationQ" -> True
      |>,
      "task:delta-calibration-sensitivity" -> <|
        "Method" ->
          "Exact derivation-difference formula delta_B1 - delta_B2 = ad_{Jcan_B1 - Jcan_B2}, plus ambiguity-trivial and ambiguity-visible bracket models.",
        "Status" -> If[statusQ, "finite-dimensional-theorem-certificate", "counterexample found"],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Physical invisibility is represented by explicit bracket-trivial ambiguity models.",
          "No AQFT/HLS observable-sector completion is attempted."
        },
        "RepresentativeModelFamily" -> "Exact ambiguity-trivial and ambiguity-visible commutator models",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
