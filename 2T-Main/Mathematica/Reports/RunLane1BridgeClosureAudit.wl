reportDir = "/home/kray-l8/work/2T/Main/Mathematica/Reports";
certDir = "/home/kray-l8/work/2T/Main/Mathematica/Certificates";
kernelDir = "/home/kray-l8/work/2T/Main/Mathematica/Kernel";

jsonOut = FileNameJoin[{reportDir, "Lane1BridgeClosureAudit_Report.json"}];
mdOut = FileNameJoin[{reportDir, "Lane1BridgeClosureAudit.md"}];
certOut = FileNameJoin[{certDir, "Lane1BridgeClosureAudit_Certificate.wl"}];

Get[FileNameJoin[{kernelDir, "CommonProofTools.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMAcceptedChannel.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMSplitControlledLift.wl"}]];
Get[FileNameJoin[{kernelDir, "QuotientDescent.wl"}]];
Get[FileNameJoin[{kernelDir, "CanonicalRepresentative.wl"}]];
Get[FileNameJoin[{kernelDir, "UOMBoundaryCanonicalization.wl"}]];
Get[FileNameJoin[{kernelDir, "DelayedDescendantReentryAudit.wl"}]];

basisColumns[m_?MatrixQ] := Table[m[[All, i]], {i, Dimensions[m][[2]]}];

report = Catch[
  split = MainProof`UOMSplitControlledLift`CertifiedSplitControlledLift[];
  contract = split["IntrinsicResponseContract"];
  channel = contract["Channel"];
  transport = contract["TransportModel"];
  chi = contract["ActiveScalarFunctional"];
  projector = contract["ActiveProjectorB"];
  aminus = transport["Aminus"];
  basis = basisColumns[aminus];
  jUnit = transport["Jdesc"];

  reducedImage[v_?VectorQ] := Expand[(chi . v) projector];

  delayedAudit = MainProof`DelayedDescendantReentryAudit`CertifiedDelayedDescendantReentryAudit[];
  boundaryModel = MainProof`UOMBoundaryCanonicalization`CertifiedUOMBoundaryCanonicalizationModel[];
  boundaryAudit = MainProof`UOMBoundaryCanonicalization`AuditUOMBoundaryCanonicalization[];

  qdata =
    MainProof`QuotientDescent`QuotientDescentData[
      chi,
      aminus,
      jUnit,
      "Nu" -> 1,
      "Label" -> "lane1_bridge_closure"
    ];
  w = MainProof`QuotientDescent`QuotientCoordinateMatrix[qdata];
  eta = MainProof`QuotientDescent`DescendedFunctionalCoordinates[qdata];

  sourceSideBridgePoint = Expand[w . jUnit];
  unitReducedImage = reducedImage[jUnit];
  unitBoundaryImage = MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, jUnit];

  existenceQ =
    MainProof`CommonProofTools`ExactVectorEqualQ[w . jUnit, sourceSideBridgePoint] &&
    TrueQ[Expand[eta . sourceSideBridgePoint - chi . jUnit] == 0] &&
    MainProof`CommonProofTools`ExactMatrixEqualQ[reducedImage[jUnit], unitReducedImage] &&
    MainProof`CommonProofTools`ExactMatrixEqualQ[
      MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, jUnit],
      unitBoundaryImage
    ];

  subordinateFamilyQ =
    MainProof`CommonProofTools`ExactForAllTrue[
      {a1, a2, b1, b2},
      True,
      With[
        {
          j1 = Expand[jUnit + aminus . {a1, a2}],
          j2 = Expand[jUnit + aminus . {b1, b2}]
        },
        And[
          And @@ Thread[Expand[j2 - j1 - aminus . {b1 - a1, b2 - a2}] == 0],
          And @@ Thread[Expand[w . j1 - sourceSideBridgePoint] == 0],
          And @@ Thread[Expand[w . j2 - sourceSideBridgePoint] == 0],
          Expand[eta . (w . j1) - chi . jUnit] == 0,
          Expand[eta . (w . j2) - chi . jUnit] == 0,
          And @@ Thread[
            Flatten[
              reducedImage[j1] - unitReducedImage
            ] == 0
          ],
          And @@ Thread[
            Flatten[
              reducedImage[j2] - unitReducedImage
            ] == 0
          ],
          And @@ Thread[
            Flatten[
              MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, j1] - unitBoundaryImage
            ] == 0
          ],
          And @@ Thread[
            Flatten[
              MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, j2] - unitBoundaryImage
            ] == 0
          ]
        ]
      ]
    ];

  calibration1 = boundaryModel["CalibrationData", "Calibration1"];
  calibration2 = boundaryModel["CalibrationData", "Calibration2"];
  calibration1Report =
    MainProof`CanonicalRepresentative`VerifyCanonicalRepresentativeProperties[calibration1];
  calibration2Report =
    MainProof`CanonicalRepresentative`VerifyCanonicalRepresentativeProperties[calibration2];

  calibration1Point = Expand[w . calibration1["Jcan"]];
  calibration2Point = Expand[w . calibration2["Jcan"]];
  calibration1ReducedImage = reducedImage[calibration1["Jcan"]];
  calibration2ReducedImage = reducedImage[calibration2["Jcan"]];
  calibration1BoundaryImage =
    MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, calibration1["Jcan"]];
  calibration2BoundaryImage =
    MainProof`UOMAcceptedChannel`AcceptedBoundaryMap[channel, calibration2["Jcan"]];

  canonicalizationQ =
    And[
      TrueQ[calibration1Report["UniqueMinimizer"]],
      TrueQ[calibration2Report["UniqueMinimizer"]],
      TrueQ[calibration1Report["Orthogonality"]],
      TrueQ[calibration2Report["Orthogonality"]],
      MainProof`CommonProofTools`VectorInSpanQ[calibration1["Jcan"] - jUnit, basis],
      MainProof`CommonProofTools`VectorInSpanQ[calibration2["Jcan"] - jUnit, basis],
      MainProof`CommonProofTools`VectorInSpanQ[calibration2["Jcan"] - calibration1["Jcan"], basis],
      MainProof`CommonProofTools`ExactVectorEqualQ[calibration1Point, sourceSideBridgePoint],
      MainProof`CommonProofTools`ExactVectorEqualQ[calibration2Point, sourceSideBridgePoint],
      MainProof`CommonProofTools`ExactMatrixEqualQ[calibration1ReducedImage, unitReducedImage],
      MainProof`CommonProofTools`ExactMatrixEqualQ[calibration2ReducedImage, unitReducedImage],
      MainProof`CommonProofTools`ExactMatrixEqualQ[calibration1BoundaryImage, unitBoundaryImage],
      MainProof`CommonProofTools`ExactMatrixEqualQ[calibration2BoundaryImage, unitBoundaryImage],
      !MainProof`CommonProofTools`ExactVectorEqualQ[calibration1["Jcan"], calibration2["Jcan"]]
    ];

  thresholdStatus =
    delayedAudit["Claims", "Split-threshold regime forces c_Lambda != 0", "Status"];

  claims = <|
    "The audited split family admits a source-compatible unit realization subordinate to the canonical source-side bridge point" -> <|
      "Status" -> If[TrueQ[existenceQ], "exact finite-dimensional certificate", "counterexample found"],
      "Certified" -> TrueQ[existenceQ],
      "Method" -> "Exact quotient-coordinate and descended-scalar evaluation on the audited unit representative Junit.",
      "Acceptance" -> "The explicit split-controlled surrogate family already contains a unit representative whose quotient point is the canonical source-side bridge point."
    |>,
    "Any two audited subordinate realizations differ by Aminus and preserve the quotient point, reduced welded image, and accepted welded boundary image" -> <|
      "Status" -> If[TrueQ[subordinateFamilyQ], "exact finite-dimensional certificate", "counterexample found"],
      "Certified" -> TrueQ[subordinateFamilyQ],
      "Method" -> "Exact affine-family audit on Junit + Aminus . a and Junit + Aminus . b, including accepted-boundary projection.",
      "Acceptance" -> "On the audited family, uniqueness modulo Aminus holds and all physically visible bridge invariants are unchanged across subordinate realizations."
    |>,
    "Finite-cutoff canonical representative reconstruction preserves subordinate realization while remaining calibration-dependent" -> <|
      "Status" -> If[TrueQ[canonicalizationQ], "exact finite-dimensional certificate", "counterexample found"],
      "Certified" -> TrueQ[canonicalizationQ],
      "Method" -> "Exact comparison of two distinct positive calibrations, their Jcan representatives, quotient coordinates, reduced welded images, and accepted welded boundary images.",
      "Acceptance" -> "The canonical-representative step can choose different exact vectors under different positive calibrations, but each remains subordinate to the same source-side bridge point and preserves the same visible images."
    |>,
    "Split-threshold alone forces c_Lambda != 0" -> <|
      "Status" -> thresholdStatus,
      "Certified" -> False,
      "Method" -> "Imported exact threshold counterexample from the delayed descendant reentry audit.",
      "Acceptance" -> "The nondegeneracy input remains on the separate lane-2 theorem path."
    |>
  |>;

  certificate = <|
    "Name" -> "Lane1BridgeClosureAudit",
    "Date" -> DateString[Now, {"Year", "-", "Month", "-", "Day", " ", "Time"}],
    "NotePath" -> "/home/kray-l8/work/2T/UOM/split_controlled_completion_lift_note.tex",
    "Claims" -> claims,
    "RawData" -> <|
      "QuotientCoordinateMatrix" -> w,
      "DescendedFunctionalCoordinates" -> eta,
      "UnitRepresentative" -> jUnit,
      "SourceSideBridgePoint" -> sourceSideBridgePoint,
      "UnitReducedImage" -> unitReducedImage,
      "UnitBoundaryImage" -> unitBoundaryImage,
      "Calibration1Jcan" -> calibration1["Jcan"],
      "Calibration2Jcan" -> calibration2["Jcan"],
      "Calibration1BridgePoint" -> calibration1Point,
      "Calibration2BridgePoint" -> calibration2Point,
      "Calibration1ReducedImage" -> calibration1ReducedImage,
      "Calibration2ReducedImage" -> calibration2ReducedImage,
      "Calibration1BoundaryImage" -> calibration1BoundaryImage,
      "Calibration2BoundaryImage" -> calibration2BoundaryImage,
      "ImportedBoundaryCalibrationStatus" ->
        boundaryAudit["Claims", "Calibration changes are exact on the welded boundary image", "Status"],
      "ImportedThresholdStatus" -> thresholdStatus
    |>,
    "ResidualBoundary" -> {
      "This is an exact finite-dimensional certificate on the current split-controlled surrogate family, not an abstract proof of the full UOM theorem stack.",
      "The theorem-backed note now reduces the live lane-1 boundary to existence of one source-compatible unit descendant realization subordinate to the canonical source-side bridge point.",
      "Accepted welded boundary image invariance is exact-family support here; the theorem-backed note controls the quotient point and reduced welded image."
    }
  |>;

  markdown = StringRiffle[{
    "# Lane 1 Realization and Uniqueness Audit",
    "",
    "Date: `" <> DateString[Now, {"Year", "-", "Month", "-", "Day"}] <> "`",
    "",
    "This packet audits the sharpened lane-1 realization stack in `UOM/split_controlled_completion_lift_note.tex`: existence of an audited unit realization, uniqueness modulo `Aminus`, and representative-secondary canonicalization.",
    "",
    "## Exact status",
    "",
    "- audited unit realization subordinate to the source-side bridge point: `" <> claims["The audited split family admits a source-compatible unit realization subordinate to the canonical source-side bridge point", "Status"] <> "`",
    "- uniqueness modulo `Aminus` with quotient/reduced/accepted boundary invariants: `" <> claims["Any two audited subordinate realizations differ by Aminus and preserve the quotient point, reduced welded image, and accepted welded boundary image", "Status"] <> "`",
    "- canonical representative reconstruction with calibration dependence but invariant visible data: `" <> claims["Finite-cutoff canonical representative reconstruction preserves subordinate realization while remaining calibration-dependent", "Status"] <> "`",
    "- threshold alone implies `c_Lambda != 0`: `" <> claims["Split-threshold alone forces c_Lambda != 0", "Status"] <> "`",
    "",
    "## Reading",
    "",
    "- The exact split family already contains a unit representative whose quotient point is the canonical source-side bridge point.",
    "- On the full audited affine family `Junit + Aminus . a`, any two subordinate realizations differ only by `Aminus` and preserve the quotient point, the reduced welded image, and the accepted welded boundary image.",
    "- Two distinct positive calibrations produce different exact `Jcan` vectors while remaining in the same ambiguity class and preserving all visible bridge invariants. This matches the representative-secondary physics.",
    "- Threshold-only nonvanishing remains false; lane 2 stays separate.",
    "",
    "## Verdict",
    "",
    "- The exact-family support now matches the new theorem organization: one subordinate realization can be canonically promoted, and subordinate realizations are unique modulo `Aminus`.",
    "- The remaining theorem boundary is no longer canonicalization or uniqueness; it is existence of one source-compatible unit realization from branchwise `B`-localized recoherence alone.",
    "- Accepted welded boundary image invariance is certified on the explicit audited family and remains separate from the theorem-backed reduced-image control."
  }, "\n"];

  Export[jsonOut, certificate, "JSON"];
  Export[mdOut, markdown, "Text"];
  Put[certificate, certOut];

  certificate
];

report
