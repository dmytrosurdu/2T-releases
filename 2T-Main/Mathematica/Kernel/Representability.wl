If[!MemberQ[$Packages, "MainProof`CommonProofTools`"],
  Get[FileNameJoin[{DirectoryName[$InputFileName], "CommonProofTools.wl"}]];
];

BeginPackage["MainProof`Representability`"]

Needs["MainProof`CommonProofTools`"]

RepresentabilityData::usage =
  "RepresentabilityData[R, target, opts] constructs exact finite-dimensional source-representability data.";
ObstructionSpaceBasis::usage =
  "ObstructionSpaceBasis[data] returns a basis for the left-kernel obstruction space.";
GaugeSpaceBasis::usage =
  "GaugeSpaceBasis[data] returns a basis for the nullspace of the response matrix.";
SolveRepresentability::usage =
  "SolveRepresentability[data] returns exact solvability, a solution family, and obstruction information.";
VerifyRepresentabilityProperties::usage =
  "VerifyRepresentabilityProperties[data] certifies exact representability/image-membership properties.";
RepresentabilityExampleSuite::usage =
  "RepresentabilityExampleSuite[] returns exact representable and non-representable source examples.";
RunRepresentabilityExampleSuite::usage =
  "RunRepresentabilityExampleSuite[] audits the representability examples.";
RepresentabilityLedgerUpdates::usage =
  "RepresentabilityLedgerUpdates[] returns theorem-ledger updates for source-insertion representability.";

Begin["`Private`"]

Options[RepresentabilityData] = {"Label" -> Automatic, "LocalityStatus" -> "imported"};

RepresentabilityData[r_?MatrixQ, target_?VectorQ, OptionsPattern[]] :=
  Module[{vars},
    vars = Array[Unique["f"], Dimensions[r][[2]]];
    <|
      "ResponseMatrix" -> r,
      "Target" -> target,
      "Variables" -> vars,
      "Label" -> OptionValue["Label"],
      "LocalityStatus" -> OptionValue["LocalityStatus"]
    |>
  ];

ObstructionSpaceBasis[data_Association] := NullSpace[Transpose[data["ResponseMatrix"]]];

GaugeSpaceBasis[data_Association] := NullSpace[data["ResponseMatrix"]];

representableQ[data_Association] :=
  Module[{obs = ObstructionSpaceBasis[data], target = data["Target"]},
    AllTrue[obs, TrueQ[# . target == 0] &]
  ];

solutionFamily[data_Association] :=
  Module[{r = data["ResponseMatrix"], target = data["Target"], vars, solutions},
    vars = data["Variables"];
    solutions = Quiet[Solve[Thread[r.vars == target], vars, Reals]];
    If[solutions === {}, Missing["NoSolution"], solutions]
  ];

oneExactSolution[data_Association] :=
  Module[{r = data["ResponseMatrix"], target = data["Target"]},
    If[!TrueQ[representableQ[data]],
      Missing["NoSolution"],
      LinearSolve[r, target]
    ]
  ];

imageMembershipCriterionQ[data_Association] :=
  TrueQ[representableQ[data] === Not[MissingQ[solutionFamily[data]]]];

gaugeFamilyQ[data_Association] :=
  Module[{r = data["ResponseMatrix"], gauge = GaugeSpaceBasis[data], sol},
    sol = oneExactSolution[data];
    If[MissingQ[sol],
      Missing["NoSolution"],
      If[gauge === {},
        True,
        Module[{coeffs = Array[Unique["g"], Length[gauge]], gaugeShift},
          gaugeShift = sol + Transpose[gauge].coeffs;
          ExactForAllTrue[
            coeffs,
            True,
            ExactVectorEqualQ[r.gaugeShift, data["Target"]]
          ]
        ]
      ]
    ]
  ];

minimalObstructionWitness[data_Association] :=
  Module[{obs = ObstructionSpaceBasis[data], target = data["Target"]},
    FirstCase[
      obs,
      vec_ /; !TrueQ[vec . target == 0] :> <|"ObstructionVector" -> vec, "ObstructionValue" -> vec . target|>,
      Missing["NoObstruction"]
    ]
  ];

VerifyRepresentabilityProperties[data_Association] :=
  Module[{r = data["ResponseMatrix"], target = data["Target"], gauge, obs, family, oneSol},
    gauge = GaugeSpaceBasis[data];
    obs = ObstructionSpaceBasis[data];
    family = solutionFamily[data];
    oneSol = oneExactSolution[data];
    <|
      "RepresentableQ" -> representableQ[data],
      "ImageMembershipCriterion" -> imageMembershipCriterionQ[data],
      "ObstructionSpaceBasis" -> obs,
      "GaugeSpaceBasis" -> gauge,
      "SolutionFamily" -> family,
      "OneExactSolution" -> oneSol,
      "ExactSolutionCheck" -> If[MissingQ[oneSol], False, ExactVectorEqualQ[r.oneSol, target]],
      "GaugeFamilyCheck" -> gaugeFamilyQ[data],
      "ObstructionWitness" -> minimalObstructionWitness[data],
      "LocalityStatus" -> data["LocalityStatus"]
    |>
  ];

RepresentabilityExampleSuite[] :=
  Module[{validFamily, validUnique, broken},
    validFamily = RepresentabilityData[
      {{1, 0, 1}, {0, 1, 1}},
      {2, 3},
      "Label" -> "representable_family"
    ];
    validUnique = RepresentabilityData[
      IdentityMatrix[2],
      {1, -1},
      "Label" -> "representable_unique"
    ];
    broken = RepresentabilityData[
      {{1, 0, 1}, {0, 0, 0}},
      {1, 1},
      "Label" -> "nonrepresentable_obstructed"
    ];
    <|
      "ValidExamples" -> {validFamily, validUnique},
      "BrokenExamples" -> {
        <|
          "Name" -> "physical_target_outside_image",
          "Data" -> broken,
          "ExpectedFailure" -> "RepresentableQ"
        |>
      }
    |>
  ];

RunRepresentabilityExampleSuite[] :=
  Module[{suite = RepresentabilityExampleSuite[], good, broken},
    good = VerifyRepresentabilityProperties /@ suite["ValidExamples"];
    broken = Map[
      Function[entry,
        With[{report = VerifyRepresentabilityProperties[entry["Data"]]},
          <|
            "Name" -> entry["Name"],
            "ExpectedFailure" -> entry["ExpectedFailure"],
            "ObservedValue" -> report[entry["ExpectedFailure"]],
            "ExpectedFailureObservedQ" -> TrueQ[report[entry["ExpectedFailure"]] === False],
            "ObstructionWitness" -> report["ObstructionWitness"]
          |>
        ]
      ],
      suite["BrokenExamples"]
    ];
    <|"ValidExamples" -> good, "BrokenExamples" -> broken|>
  ];

RepresentabilityLedgerUpdates[] :=
  Module[{suite = RunRepresentabilityExampleSuite[], good, broken, validStatusQ},
    good = suite["ValidExamples"];
    broken = suite["BrokenExamples"];
    validStatusQ = AllTrue[
      good,
      TrueQ[
        #["RepresentableQ"] &&
        #["ImageMembershipCriterion"] &&
        #["ExactSolutionCheck"] &&
        #["GaugeFamilyCheck"]
      ] &
    ];
    <|
      "task:source-insertion-representability" -> <|
        "Method" -> "Exact image-membership solver for Pi_phys R(F_tau) = Pi_phys T[tau], with obstruction and gauge-space extraction.",
        "Status" -> If[
          validStatusQ && AllTrue[broken, TrueQ[#"ExpectedFailureObservedQ"] &],
          "finite-dimensional-theorem-certificate",
          "counterexample found"
        ],
        "ScopeClass" -> "finite-dimensional-theorem-certificate",
        "SurrogateBlindSpots" -> {
          "Sufficient locality remains imported and is not identified with algebraic image membership.",
          "Only fixed-cutoff linear realizability is audited here."
        },
        "RepresentativeModelFamily" -> "Exact representable unique/family examples plus an explicit obstruction example",
        "NoApproximationQ" -> True
      |>
    |>
  ];

End[]

EndPackage[]
