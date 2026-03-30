<|"ReportDate" -> "2026-03-29 18:06:13", "TopLineVerdict" -> "The next \
discharge route is aligned with the exact WL lane familywise: on the audited \
borderline family, the chosen parity-stable mod-null subspace lies inside the \
kernel of the dominant-functional surrogate while the selected generator has \
nonzero value, so theorem-2 transversality is discharged automatically \
there.", "Audit" -> <|"UnderlyingDelayedReentryAudit" ->
    <|"Model" -> <|"TransportModel" ->
        <|"Name" -> "certified_polynomial_branch", "Parameter" ->
          MainProof`ActiveTransport`Private`lambda$135589,
         "Assumptions" -> 1 <=
           MainProof`ActiveTransport`Private`lambda$135589 <= 3,
         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
          {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$135589},
         "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$135589,
         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
       "SplitModel" -> <|"Name" -> "uom_split_controlled_lift_contract",
         "IntrinsicResponseContract" ->
          <|"Name" -> "uom_intrinsic_response_contract_from_welded_boundary",
           "BoundaryModel" -> <|"BoundaryAudit" -> <|"Model" ->
                <|"Channel" -> <|"Name" ->
                    "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135595,
                   "vGeom" -> MainProof`UOMWeldedChannel`Private`v$135595,
                   "AlphaTStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaT$135595,
                   "AlphaXStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaX$135595,
                   "Center" ->
                    MainProof`UOMWeldedChannel`Private`center$135595,
                   "Tick" -> MainProof`UOMWeldedChannel`Private`tick$135595,
                   "DimB" -> 2, "Assumptions" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135595 > 0 &&
                     MainProof`UOMWeldedChannel`Private`v$135595 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaT$135595 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaX$135595 > 0,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135596,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135596 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135596},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135596,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                    <|"s_t" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$135595/
                       MainProof`UOMWeldedChannel`Private`lambda$135595,
                     "s_x" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$135595/
                       (MainProof`UOMWeldedChannel`Private`lambda$135595*
                        MainProof`UOMWeldedChannel`Private`v$135595)|>,
                   "TemporalWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`CapitalSigma][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135595]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135595] ==
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135595],
                       {MainProof`UOMWeldedChannel`Private`t, 2}]],
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135595] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135595] ==
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega,
                       MainProof`UOMWeldedChannel`Private`center$135595]],
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT ==
                       MainProof`UOMWeldedChannel`Private`alphaT$135595/
                        MainProof`UOMWeldedChannel`Private`lambda$135595,
                      MainProof`UOMWeldedChannel`Private`sX ==
                       MainProof`UOMWeldedChannel`Private`alphaX$135595/
                        (MainProof`UOMWeldedChannel`Private`v$135595*
                         MainProof`UOMWeldedChannel`Private`lambda$135595)}],
                   "CenterLockStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar ==
                      MainProof`UOMWeldedChannel`Private`center$135595],
                   "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1,
                    0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                   "CompressedChannelStatement" -> HoldForm[
                     Subscript[MainProof`UOMWeldedChannel`Private`H,
                        MainProof`UOMWeldedChannel`Private`LoG][
                       MainProof`UOMWeldedChannel`Private`lambda$135595] ==
                      Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                         MainProof`UOMWeldedChannel`Private`lambda$135595]}]]\
|>, "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
                   "Parameter" ->
                    MainProof`ActiveTransport`Private`lambda$135596,
                   "Assumptions" -> 1 <=
                     MainProof`ActiveTransport`Private`lambda$135596 <= 3,
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                    {0, 0, 1 +
                      MainProof`ActiveTransport`Private`lambda$135596},
                   "Nu" -> 1 +
                     MainProof`ActiveTransport`Private`lambda$135596,
                   "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                 "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                 "AminusBoundaryImages" -> {{{0, 0}, {0, 0}}, {{0, 0},
                    {0, 0}}}, "RepresentativeBoundaryImage" -> {{1, 0},
                   {0, 0}}, "FactPreservationAudit" -> <|"Dimension" -> 3,
                   "SymbolicState" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1],
                      MainProof`UOMFactPreservation`Private`r[1, 2],
                      MainProof`UOMFactPreservation`Private`r[1, 3]},
                     {MainProof`UOMFactPreservation`Private`r[2, 1],
                      MainProof`UOMFactPreservation`Private`r[2, 2],
                      MainProof`UOMFactPreservation`Private`r[2, 3]},
                     {MainProof`UOMFactPreservation`Private`r[3, 1],
                      MainProof`UOMFactPreservation`Private`r[3, 2],
                      MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "QNDTickImage" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1],
                      MainProof`UOMFactPreservation`Private`kernel$135599[1,
                        2]*MainProof`UOMFactPreservation`Private`r[1, 2],
                      MainProof`UOMFactPreservation`Private`kernel$135599[1,
                        3]*MainProof`UOMFactPreservation`Private`r[1, 3]},
                     {MainProof`UOMFactPreservation`Private`kernel$135599[2,
                        1]*MainProof`UOMFactPreservation`Private`r[2, 1],
                      MainProof`UOMFactPreservation`Private`r[2, 2],
                      MainProof`UOMFactPreservation`Private`kernel$135599[2,
                        3]*MainProof`UOMFactPreservation`Private`r[2, 3]},
                     {MainProof`UOMFactPreservation`Private`kernel$135599[3,
                        1]*MainProof`UOMFactPreservation`Private`r[3, 1],
                      MainProof`UOMFactPreservation`Private`kernel$135599[3,
                        2]*MainProof`UOMFactPreservation`Private`r[3, 2],
                      MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "AcceptedRecordState" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1], 0, 0},
                     {0, MainProof`UOMFactPreservation`Private`r[2, 2], 0},
                     {0, 0, MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "Claims" -> <|"Accepted record projection preserves all \
record expectations exactly" -> <|"Status" ->
                        "exact finite-dimensional certificate",
                       "Certified" -> True|>,
                     "Commuting QND tick fixes the accepted record state" ->
                      <|"Status" -> "exact finite-dimensional certificate",
                       "Certified" -> True|>, "Accepted record projection is \
the exact conditional expectation onto the diagonal record algebra" ->
                      <|"Status" -> "exact finite-dimensional certificate",
                       "Certified" -> True|>|>|>|>, "Claims" ->
                <|"Transported ambiguity vanishes on the exact welded \
boundary channel" -> <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>, "Boundary image of the class \
representative is the nonzero epsilon-weighted welded LoG line" ->
                  <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>, "Exact sub-cutoff fact preservation \
is enforced on the accepted record algebra" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>, "Old visible ambiguity witness is excluded by UOM \
welded/fact-preserving constraints" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>|>|>, "PulseAudit" -> <|"Contract" ->
                <|"Name" -> "uom_exact_welded_pulse_contract",
                 "ChannelData" -> <|"Name" ->
                    "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135673,
                   "vGeom" -> MainProof`UOMWeldedChannel`Private`v$135673,
                   "AlphaTStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaT$135673,
                   "AlphaXStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaX$135673,
                   "Center" ->
                    MainProof`UOMWeldedChannel`Private`center$135673,
                   "Tick" -> MainProof`UOMWeldedChannel`Private`tick$135673,
                   "DimB" -> 2, "Assumptions" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135673 > 0 &&
                     MainProof`UOMWeldedChannel`Private`v$135673 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaT$135673 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaX$135673 > 0,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135674,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135674 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135674},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135674,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                    <|"s_t" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$135673/
                       MainProof`UOMWeldedChannel`Private`lambda$135673,
                     "s_x" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$135673/
                       (MainProof`UOMWeldedChannel`Private`lambda$135673*
                        MainProof`UOMWeldedChannel`Private`v$135673)|>,
                   "TemporalWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`CapitalSigma][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135673]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135673] ==
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135673],
                       {MainProof`UOMWeldedChannel`Private`t, 2}]],
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135673] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135673] ==
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega,
                       MainProof`UOMWeldedChannel`Private`center$135673]],
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT ==
                       MainProof`UOMWeldedChannel`Private`alphaT$135673/
                        MainProof`UOMWeldedChannel`Private`lambda$135673,
                      MainProof`UOMWeldedChannel`Private`sX ==
                       MainProof`UOMWeldedChannel`Private`alphaX$135673/
                        (MainProof`UOMWeldedChannel`Private`v$135673*
                         MainProof`UOMWeldedChannel`Private`lambda$135673)}],
                   "CenterLockStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar ==
                      MainProof`UOMWeldedChannel`Private`center$135673],
                   "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1,
                    0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                   "CompressedChannelStatement" -> HoldForm[
                     Subscript[MainProof`UOMWeldedChannel`Private`H,
                        MainProof`UOMWeldedChannel`Private`LoG][
                       MainProof`UOMWeldedChannel`Private`lambda$135673] ==
                      Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                         MainProof`UOMWeldedChannel`Private`lambda$135673]}]]\
|>, "TemporalMacroMicroCompilation" -> HoldForm[
                   MainProof`UOMPulseCharacterization`Private`DoGTemporal[
                      MainProof`UOMPulseCharacterization`Private`sigmaMacroT,
                      MainProof`UOMPulseCharacterization`Private`sigmaMicroT][
                     MainProof`UOMPulseCharacterization`Private`t -
                      MainProof`UOMPulseCharacterization`Private`tick] ==
                    MainProof`UOMPulseCharacterization`Private`LoG[
                      Sqrt[
                       MainProof`UOMPulseCharacterization`Private`sigmaMacroT^
                         2 + MainProof`UOMPulseCharacterization`Private`sigma\
MicroT^2]][MainProof`UOMPulseCharacterization`Private`t -
                      MainProof`UOMPulseCharacterization`Private`tick]],
                 "SpatialMacroMicroCompilation" -> HoldForm[
                   MainProof`UOMPulseCharacterization`Private`DoGSpatial[
                      MainProof`UOMPulseCharacterization`Private`rhoMacro,
                      MainProof`UOMPulseCharacterization`Private`rhoMicro][
                     MainProof`UOMPulseCharacterization`Private`Omega,
                     MainProof`UOMPulseCharacterization`Private`center] ==
                    MainProof`UOMPulseCharacterization`Private`LoG[
                      Sqrt[MainProof`UOMPulseCharacterization`Private`rhoMacr\
o^2 + MainProof`UOMPulseCharacterization`Private`rhoMicro^2]][
                     MainProof`UOMPulseCharacterization`Private`Omega,
                     MainProof`UOMPulseCharacterization`Private`center]],
                 "QuadratureWidthCombination" -> <|"Temporal" -> HoldForm[
                     MainProof`UOMPulseCharacterization`Private`sWeldT ==
                      Sqrt[
                       MainProof`UOMPulseCharacterization`Private`sigmaMacroT^
                         2 + MainProof`UOMPulseCharacterization`Private`sigma\
MicroT^2]], "Spatial" -> HoldForm[
                     MainProof`UOMPulseCharacterization`Private`rhoWeld ==
                      Sqrt[
                       MainProof`UOMPulseCharacterization`Private`rhoMacro^
                         2 +
                        MainProof`UOMPulseCharacterization`Private`rhoMicro^
                         2]]|>, "TemporalWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`CapitalSigma][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$135673]*
                     MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`sigmaT][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$135673] ==
                    D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                        MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                         MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$135673],
                     {MainProof`UOMWeldedChannel`Private`t, 2}]],
                 "SpatialWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`LoG[
                       MainProof`UOMWeldedChannel`Private`rho][
                      MainProof`UOMWeldedChannel`Private`Omega,
                      MainProof`UOMWeldedChannel`Private`center$135673] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                       MainProof`UOMWeldedChannel`Private`sigmaX][
                      MainProof`UOMWeldedChannel`Private`Omega,
                      MainProof`UOMWeldedChannel`Private`center$135673] ==
                    MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                       MainProof`UOMWeldedChannel`Private`rho^2 +
                        MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                     MainProof`UOMWeldedChannel`Private`Omega,
                     MainProof`UOMWeldedChannel`Private`center$135673]],
                 "CoCenteringStatement" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`OmegaStar ==
                    MainProof`UOMWeldedChannel`Private`center$135673],
                 "BandLockStatement" -> HoldForm[
                   {MainProof`UOMWeldedChannel`Private`sT ==
                     MainProof`UOMWeldedChannel`Private`alphaT$135673/
                      MainProof`UOMWeldedChannel`Private`lambda$135673,
                    MainProof`UOMWeldedChannel`Private`sX ==
                     MainProof`UOMWeldedChannel`Private`alphaX$135673/
                      (MainProof`UOMWeldedChannel`Private`v$135673*
                       MainProof`UOMWeldedChannel`Private`lambda$135673)}],
                 "BandLockScales" -> <|"s_t" ->
                    MainProof`UOMWeldedChannel`Private`alphaT$135673/
                     MainProof`UOMWeldedChannel`Private`lambda$135673,
                   "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$135673/
                     (MainProof`UOMWeldedChannel`Private`lambda$135673*
                      MainProof`UOMWeldedChannel`Private`v$135673)|>,
                 "CompressedLineProjector" -> {{1, 0}, {0, 0}},
                 "CompressedLineDimension" -> 1|>, "Claims" ->
                <|"Welded LoG shape is compiled exactly from macro/micro DoG \
data" -> <|"Status" -> "exact finite-dimensional certificate", "Certified" ->
                    True|>, "Welded pulse is exactly co-centered" ->
                  <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>,
                 "Receiver band-lock fixes the welded widths exactly" ->
                  <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>,
                 "Compressed welded image is rank-one" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>|>|>, "AcceptedChannelAudit" -> <|"Contract" ->
                <|"Name" -> "uom_exact_accepted_channel_contract",
                 "ChannelData" -> <|"Name" ->
                    "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135680,
                   "vGeom" -> MainProof`UOMWeldedChannel`Private`v$135680,
                   "AlphaTStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaT$135680,
                   "AlphaXStar" ->
                    MainProof`UOMWeldedChannel`Private`alphaX$135680,
                   "Center" ->
                    MainProof`UOMWeldedChannel`Private`center$135680,
                   "Tick" -> MainProof`UOMWeldedChannel`Private`tick$135680,
                   "DimB" -> 2, "Assumptions" ->
                    MainProof`UOMWeldedChannel`Private`lambda$135680 > 0 &&
                     MainProof`UOMWeldedChannel`Private`v$135680 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaT$135680 > 0 &&
                     MainProof`UOMWeldedChannel`Private`alphaX$135680 > 0,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135681,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135681 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135681},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135681,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                    <|"s_t" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$135680/
                       MainProof`UOMWeldedChannel`Private`lambda$135680,
                     "s_x" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$135680/
                       (MainProof`UOMWeldedChannel`Private`lambda$135680*
                        MainProof`UOMWeldedChannel`Private`v$135680)|>,
                   "TemporalWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`CapitalSigma][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135680]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135680] ==
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$135680],
                       {MainProof`UOMWeldedChannel`Private`t, 2}]],
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135680] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$135680] ==
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega,
                       MainProof`UOMWeldedChannel`Private`center$135680]],
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT ==
                       MainProof`UOMWeldedChannel`Private`alphaT$135680/
                        MainProof`UOMWeldedChannel`Private`lambda$135680,
                      MainProof`UOMWeldedChannel`Private`sX ==
                       MainProof`UOMWeldedChannel`Private`alphaX$135680/
                        (MainProof`UOMWeldedChannel`Private`v$135680*
                         MainProof`UOMWeldedChannel`Private`lambda$135680)}],
                   "CenterLockStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar ==
                      MainProof`UOMWeldedChannel`Private`center$135680],
                   "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1,
                    0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                   "CompressedChannelStatement" -> HoldForm[
                     Subscript[MainProof`UOMWeldedChannel`Private`H,
                        MainProof`UOMWeldedChannel`Private`LoG][
                       MainProof`UOMWeldedChannel`Private`lambda$135680] ==
                      Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                         MainProof`UOMWeldedChannel`Private`lambda$135680]}]]\
|>, "SourceWrite" -> HoldForm[MainProof`UOMAcceptedChannel`Private`Wsrc[
                     MainProof`UOMAcceptedChannel`Private`v] ==
                    MainProof`UOMAcceptedChannel`Private`v],
                 "RetardedTransport" -> HoldForm[
                   MainProof`UOMAcceptedChannel`Private`Gret[
                     MainProof`UOMAcceptedChannel`Private`v] ==
                    MainProof`UOMAcceptedChannel`Private`v],
                 "CompiledScalarMap" -> HoldForm[
                   MainProof`UOMAcceptedChannel`Private`Kcomp[
                     MainProof`UOMAcceptedChannel`Private`v] ==
                    MainProof`UOMAcceptedChannel`Private`chi .
                      MainProof`UOMAcceptedChannel`Private`v/
                     MainProof`UOMAcceptedChannel`Private`epsilon],
                 "WeylCompensator" -> HoldForm[
                   MainProof`UOMAcceptedChannel`Private`Mepsilon[
                     MainProof`UOMAcceptedChannel`Private`s] ==
                    MainProof`UOMAcceptedChannel`Private`epsilon*
                     MainProof`UOMAcceptedChannel`Private`s],
                 "ProfileProjection" -> HoldForm[
                   MainProof`UOMAcceptedChannel`Private`PiL[
                     MainProof`UOMAcceptedChannel`Private`s] ==
                    MainProof`UOMAcceptedChannel`Private`s*
                     MainProof`UOMAcceptedChannel`Private`PLoG],
                 "FactorizationStatement" -> HoldForm[
                   MainProof`UOMAcceptedChannel`Private`TLambda[
                     MainProof`UOMAcceptedChannel`Private`v] ==
                    MainProof`UOMAcceptedChannel`Private`PiL[
                     MainProof`UOMAcceptedChannel`Private`Mepsilon[
                      MainProof`UOMAcceptedChannel`Private`Kcomp[
                       MainProof`UOMAcceptedChannel`Private`Gret[
                        MainProof`UOMAcceptedChannel`Private`Wsrc[
                         MainProof`UOMAcceptedChannel`Private`v]]]]]],
                 "AcceptedTickKrausOperators" -> {{{1, 0, 0}, {0, 0, 0}, {0,
                   0, 0}}, {{0, 0, 0}, {0, 1, 0}, {0, 0, 0}}, {{0, 0, 0}, {0,
                   0, 0}, {0, 0, 1}}}, "UpliftIsometry" -> {{1, 0, 0}, {0, 0,
                  0}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}, {0, 0, 0}},
                 "AcceptedTickDimension" -> 3|>, "FactPreservationAudit" ->
                <|"Dimension" -> 3, "SymbolicState" ->
                  {{MainProof`UOMFactPreservation`Private`r[1, 1],
                    MainProof`UOMFactPreservation`Private`r[1, 2],
                    MainProof`UOMFactPreservation`Private`r[1, 3]},
                   {MainProof`UOMFactPreservation`Private`r[2, 1],
                    MainProof`UOMFactPreservation`Private`r[2, 2],
                    MainProof`UOMFactPreservation`Private`r[2, 3]},
                   {MainProof`UOMFactPreservation`Private`r[3, 1],
                    MainProof`UOMFactPreservation`Private`r[3, 2],
                    MainProof`UOMFactPreservation`Private`r[3, 3]}},
                 "QNDTickImage" -> {{MainProof`UOMFactPreservation`Private`r[
                     1, 1],
                    MainProof`UOMFactPreservation`Private`kernel$135687[1, 2]*
                     MainProof`UOMFactPreservation`Private`r[1, 2],
                    MainProof`UOMFactPreservation`Private`kernel$135687[1, 3]*
                     MainProof`UOMFactPreservation`Private`r[1, 3]},
                   {MainProof`UOMFactPreservation`Private`kernel$135687[2, 1]*
                     MainProof`UOMFactPreservation`Private`r[2, 1],
                    MainProof`UOMFactPreservation`Private`r[2, 2],
                    MainProof`UOMFactPreservation`Private`kernel$135687[2, 3]*
                     MainProof`UOMFactPreservation`Private`r[2, 3]},
                   {MainProof`UOMFactPreservation`Private`kernel$135687[3, 1]*
                     MainProof`UOMFactPreservation`Private`r[3, 1],
                    MainProof`UOMFactPreservation`Private`kernel$135687[3, 2]*
                     MainProof`UOMFactPreservation`Private`r[3, 2],
                    MainProof`UOMFactPreservation`Private`r[3, 3]}},
                 "AcceptedRecordState" ->
                  {{MainProof`UOMFactPreservation`Private`r[1, 1], 0, 0},
                   {0, MainProof`UOMFactPreservation`Private`r[2, 2], 0},
                   {0, 0, MainProof`UOMFactPreservation`Private`r[3, 3]}},
                 "Claims" -> <|"Accepted record projection preserves all \
record expectations exactly" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>,
                   "Commuting QND tick fixes the accepted record state" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>, "Accepted record projection is \
the exact conditional expectation onto the diagonal record algebra" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>|>|>, "RecordBreakingWitness" ->
                <|"InputState" -> {{1, 0}, {0, 0}}, "BrokenTickImage" -> {{0,
                  0}, {0, 1}}|>, "Claims" -> <|"Accepted welded channel \
factorizes exactly through the compiled descended scalar" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>,
                 "Accepted uplift surrogate is an exact isometry" ->
                  <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>,
                 "Accepted tick surrogate is exactly CPTP at finite cutoff" \
-> <|"Status" -> "exact finite-dimensional certificate", "Certified" ->
                    True|>, "Accepted record sector is preserved exactly and \
breaks under the intentional ablation" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>|>|>, "ActionSelectionAudit" -> <|"Contract" ->
                <|"Families" -> {<|"Name" -> "welded_rank1_selected",
                    "P3Action" -> 1/5, "SKInfluence" -> 1/7,
                    "CompressedRank" -> 1, "CoCenteredQ" -> True,
                    "BandLockedQ" -> True, "DescendedScalarFactorizationQ" ->
                     True, "AcceptedRecordPreservationQ" -> True,
                    "GaussianData" -> <|"DriveWidth" -> 1/3,
                      "SqueezeWidth" -> 1/4|>|>, <|"Name" ->
                     "higher_rank_candidate", "P3Action" -> 2/5,
                    "SKInfluence" -> 1/4, "CompressedRank" -> 2,
                    "CoCenteredQ" -> True, "BandLockedQ" -> True,
                    "DescendedScalarFactorizationQ" -> True,
                    "AcceptedRecordPreservationQ" -> True, "GaussianData" ->
                     <|"DriveWidth" -> 1/3, "SqueezeWidth" -> 1/2|>|>,
                   <|"Name" -> "generic_control_candidate", "P3Action" ->
                     3/5, "SKInfluence" -> 1/3, "CompressedRank" -> 2,
                    "CoCenteredQ" -> False, "BandLockedQ" -> False,
                    "DescendedScalarFactorizationQ" -> False,
                    "AcceptedRecordPreservationQ" -> False, "GaussianData" ->
                     <|"DriveWidth" -> 2/3, "SqueezeWidth" -> 1|>|>},
                 "AdmissibleFamilies" -> {<|"Name" ->
                     "welded_rank1_selected", "P3Action" -> 1/5,
                    "SKInfluence" -> 1/7, "CompressedRank" -> 1,
                    "CoCenteredQ" -> True, "BandLockedQ" -> True,
                    "DescendedScalarFactorizationQ" -> True,
                    "AcceptedRecordPreservationQ" -> True, "GaussianData" ->
                     <|"DriveWidth" -> 1/3, "SqueezeWidth" -> 1/4|>|>,
                   <|"Name" -> "higher_rank_candidate", "P3Action" -> 2/5,
                    "SKInfluence" -> 1/4, "CompressedRank" -> 2,
                    "CoCenteredQ" -> True, "BandLockedQ" -> True,
                    "DescendedScalarFactorizationQ" -> True,
                    "AcceptedRecordPreservationQ" -> True, "GaussianData" ->
                     <|"DriveWidth" -> 1/3, "SqueezeWidth" -> 1/2|>|>},
                 "SelectedFamily" -> <|"Name" -> "welded_rank1_selected",
                   "P3Action" -> 1/5, "SKInfluence" -> 1/7,
                   "CompressedRank" -> 1, "CoCenteredQ" -> True,
                   "BandLockedQ" -> True, "DescendedScalarFactorizationQ" ->
                    True, "AcceptedRecordPreservationQ" -> True,
                   "GaussianData" -> <|"DriveWidth" -> 1/3, "SqueezeWidth" ->
                      1/4|>|>, "MinimalP3Action" -> 1/5,
                 "MinimalSKInfluenceWithinP3" -> 1/7|>, "Claims" ->
                <|
                 "P3 least-action admissibility selects the welded family" -> \
<|"Status" -> "exact finite-dimensional certificate", "Certified" -> True|>,
                 "SK least-influence selection picks the admissible Gaussian \
welded family" -> <|"Status" -> "exact finite-dimensional certificate",
                   "Certified" -> True|>, "Selected welded family is rank-one \
and descended-scalar factorized" -> <|"Status" ->
                    "exact finite-dimensional certificate", "Certified" ->
                    True|>|>|>, "LegacyTransportedAudit" ->
              <|"WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                  <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                  {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                  <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                     {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                  {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1, 0},
                  {0, 0, 1}}, "Ochar" -> <|"Name" ->
                    "CertifiedTransportedWeakInterface", "SourceModel" ->
                    "certified_polynomial_branch"|>, "BranchSignRecord" ->
                  <|"Tick" -> 1, "Epsilon" -> 1|>|>, "Realizations" ->
                <|"TransportedSafeFamily" -> <|"Name" ->
                    "transported_safe_2x2", "DimA" -> 2, "DimB" -> 2,
                   "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}},
                   "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0, 1}, {0, 0}},
                     {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                   "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                     1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0, 0},
                    {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}}, "JOperator" ->
                    {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityOperator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, {0, 0,
                    0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> {{{1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0,
                     0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0,
                     0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}},
                     {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                     1}}}, "WitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                    <|"BoundarySectorType" -> "controlled",
                     "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                        <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                        {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                      "certified_polynomial_branch"|>, "WeakInterface" ->
                    <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                       "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                       {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0, 1},
                       "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" ->
                      {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                      <|"Name" -> "CertifiedTransportedWeakInterface",
                       "SourceModel" -> "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135705,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135705 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135705},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135705,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0, 1},
                     {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                     0}, {1, 0, 0, 0}, {0, 1, 0, 0}}}, "EminusBasisImages" ->
                    {{{0, 0, 1, 0}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0,
                     0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}, {0, 1,
                     0, 0}}, {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                     0, 0, 0}}}|>, "TransportedUnsafeFamily" ->
                  <|"Name" -> "transported_unsafe_2x2", "DimA" -> 2,
                   "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0},
                     {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0,
                     1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                   "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                     1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0, 0},
                    {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}}, "JOperator" ->
                    {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityOperator" -> {{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                    0, 0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> {{{1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0,
                     0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0,
                     0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}},
                     {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                     1}}}, "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                    <|"BoundarySectorType" -> "controlled",
                     "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                        <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                        {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                      "certified_polynomial_branch"|>, "WeakInterface" ->
                    <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                       "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                       {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0, 1},
                       "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" ->
                      {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                      <|"Name" -> "CertifiedTransportedWeakInterface",
                       "SourceModel" -> "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135713,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135713 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135713},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135713,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0,
                     0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}},
                   "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                     0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 0, 1},
                     {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, {1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>|>,
               "AuditsByCandidate" -> <|"readout-kernel" ->
                  <|"TransportedSafeFamily" -> <|"RealizationName" ->
                      "transported_safe_2x2", "CandidateName" ->
                      "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                          0}}}, "ControlledProjectionInNullIdealQ" -> True,
                        "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> True,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>,
                   "TransportedUnsafeFamily" -> <|"RealizationName" ->
                      "transported_unsafe_2x2", "CandidateName" ->
                      "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> False,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> True,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> False,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {1},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>|>,
                 "block-trace-zero" -> <|"TransportedSafeFamily" ->
                    <|"RealizationName" -> "transported_safe_2x2",
                     "CandidateName" -> "block-trace-zero",
                     "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                        <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                        {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                          0}}}, "ControlledProjectionInNullIdealQ" -> True,
                        "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> True,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>,
                   "TransportedUnsafeFamily" -> <|"RealizationName" ->
                      "transported_unsafe_2x2", "CandidateName" ->
                      "block-trace-zero", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> False,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> True,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> False,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {1},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>|>,
                 "state-invisible" -> <|"TransportedSafeFamily" ->
                    <|"RealizationName" -> "transported_safe_2x2",
                     "CandidateName" -> "state-invisible", "WeakInterface" ->
                      <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                         "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                         {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0,
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>,
                       "J0" -> {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                       "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                        <|"Name" -> "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                          0}}}, "ControlledProjectionInNullIdealQ" -> True,
                        "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> True,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>,
                   "TransportedUnsafeFamily" -> <|"RealizationName" ->
                      "transported_unsafe_2x2", "CandidateName" ->
                      "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         False, "StrongBlockCentralityQ" -> False,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> True,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> False,
                     "AllBasisStrongBlockCentralQ" -> False,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {1},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {2},
                     "ExpectationOnlyBasisIndices" -> {}|>|>|>,
               "TransportedSafeWitness" -> <|"Realization" ->
                  <|"Name" -> "transported_safe_2x2", "DimA" -> 2,
                   "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0},
                     {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0,
                     1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                   "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                     1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0, 0},
                    {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}}, "JOperator" ->
                    {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityOperator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, {0, 0,
                    0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> {{{1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0,
                     0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0,
                     0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}},
                     {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                     1}}}, "WitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                    <|"BoundarySectorType" -> "controlled",
                     "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                        <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                        {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                      "certified_polynomial_branch"|>, "WeakInterface" ->
                    <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                       "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                       {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0, 1},
                       "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" ->
                      {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                      <|"Name" -> "CertifiedTransportedWeakInterface",
                       "SourceModel" -> "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135705,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135705 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135705},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135705,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0, 1},
                     {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                     0}, {1, 0, 0, 0}, {0, 1, 0, 0}}}, "EminusBasisImages" ->
                    {{{0, 0, 1, 0}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0,
                     0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}, {0, 1,
                     0, 0}}, {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                     0, 0, 0}}}|>, "ReadoutKernelAudit" ->
                  <|"RealizationName" -> "transported_safe_2x2",
                   "CandidateName" -> "readout-kernel", "WeakInterface" ->
                    <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                       "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                       {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0, 1},
                       "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" ->
                      {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                      <|"Name" -> "CertifiedTransportedWeakInterface",
                       "SourceModel" -> "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "BasisOperatorAudits" -> {<|"ControlledProjection" -> {{0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>, <|"ControlledProjection" -> {{0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>}, "AllControlledProjectionsNullQ" -> True,
                   "AllBasisStrongBlockCentralQ" -> True,
                   "AllBasisModNullBlockCentralQ" -> True,
                   "VisibleBasisIndices" -> {}, "ModNullSafeBasisIndices" ->
                    {1, 2}, "NullProjectionBasisIndices" -> {1, 2},
                   "ExpectationOnlyBasisIndices" -> {}|>,
                 "StateInvisibleAudit" -> <|"RealizationName" ->
                    "transported_safe_2x2", "CandidateName" ->
                    "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                     "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                      <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                         {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                      {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                      0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                        "CertifiedTransportedWeakInterface", "SourceModel" ->
                        "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "BasisOperatorAudits" -> {<|"ControlledProjection" -> {{0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>, <|"ControlledProjection" -> {{0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>}, "AllControlledProjectionsNullQ" -> True,
                   "AllBasisStrongBlockCentralQ" -> True,
                   "AllBasisModNullBlockCentralQ" -> True,
                   "VisibleBasisIndices" -> {}, "ModNullSafeBasisIndices" ->
                    {1, 2}, "NullProjectionBasisIndices" -> {1, 2},
                   "ExpectationOnlyBasisIndices" -> {}|>|>,
               "TransportedUnsafeWitness" -> <|"Realization" ->
                  <|"Name" -> "transported_unsafe_2x2", "DimA" -> 2,
                   "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0},
                     {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0,
                     1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                   "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                     1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0, 0},
                    {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}}, "JOperator" ->
                    {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityOperator" -> {{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                    0, 0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> {{{1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0,
                     0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0,
                     0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}},
                     {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                     1}}}, "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                   "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                    0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                    <|"BoundarySectorType" -> "controlled",
                     "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                        <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                        {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                      "certified_polynomial_branch"|>, "WeakInterface" ->
                    <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                       "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                       {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0, 1},
                       "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" ->
                      {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                      <|"Name" -> "CertifiedTransportedWeakInterface",
                       "SourceModel" -> "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "TransportModel" -> <|"Name" ->
                      "certified_polynomial_branch", "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$135713,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$135713 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$135713},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$135713,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0,
                     0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}},
                   "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                     0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 0, 1},
                     {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, {1, 0, 0,
                     0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
                 "ReadoutKernelAudit" -> <|"RealizationName" ->
                    "transported_unsafe_2x2", "CandidateName" ->
                    "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                     "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                      <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                         {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                      {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                      0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                        "CertifiedTransportedWeakInterface", "SourceModel" ->
                        "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "BasisOperatorAudits" -> {<|"ControlledProjection" -> {{1,
                       0, 0, 0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> False,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> True,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>, <|"ControlledProjection" -> {{0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>}, "AllControlledProjectionsNullQ" -> True,
                   "AllBasisStrongBlockCentralQ" -> False,
                   "AllBasisModNullBlockCentralQ" -> True,
                   "VisibleBasisIndices" -> {1}, "ModNullSafeBasisIndices" ->
                    {1, 2}, "NullProjectionBasisIndices" -> {1, 2},
                   "ExpectationOnlyBasisIndices" -> {}|>,
                 "StateInvisibleAudit" -> <|"RealizationName" ->
                    "transported_unsafe_2x2", "CandidateName" ->
                    "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                     "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                      <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                         {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                      {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                      0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                        "CertifiedTransportedWeakInterface", "SourceModel" ->
                        "certified_polynomial_branch"|>,
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "BasisOperatorAudits" -> {<|"ControlledProjection" -> {{1,
                       0, 0, 0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> False,
                      "StrongBlockCentralityQ" -> False,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> True,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>, <|"ControlledProjection" -> {{0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                      "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                        0}}}, "ControlledProjectionInNullIdealQ" -> True,
                      "StrongBlockCentralityQ" -> True,
                      "ModNullBlockCentralityQ" -> True,
                      "OperatorLevelVisibleQ" -> False,
                      "ExpectationLevelInvisibleQ" -> True, "WitnessImage" ->
                       {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                       0}}|>}, "AllControlledProjectionsNullQ" -> False,
                   "AllBasisStrongBlockCentralQ" -> False,
                   "AllBasisModNullBlockCentralQ" -> True,
                   "VisibleBasisIndices" -> {1}, "ModNullSafeBasisIndices" ->
                    {1, 2}, "NullProjectionBasisIndices" -> {2},
                   "ExpectationOnlyBasisIndices" -> {}|>|>,
               "WeakestAdditionalHypothesis" -> "Each boundary realization of \
a transported ambiguity basis vector must have vanishing controlled \
projection, or block-central controlled B-blocks modulo a nontrivial boundary \
null ideal that remains stable and does not trivialize the controlled \
dynamics.", "ForcedByTransportStructureQ" -> False|>, "Channel" ->
              <|"Name" -> "uom_exact_welded_bandlocked_log_channel",
               "Lambda" -> MainProof`UOMWeldedChannel`Private`lambda$135595,
               "vGeom" -> MainProof`UOMWeldedChannel`Private`v$135595,
               "AlphaTStar" ->
                MainProof`UOMWeldedChannel`Private`alphaT$135595,
               "AlphaXStar" ->
                MainProof`UOMWeldedChannel`Private`alphaX$135595, "Center" ->
                MainProof`UOMWeldedChannel`Private`center$135595, "Tick" ->
                MainProof`UOMWeldedChannel`Private`tick$135595, "DimB" ->
                2, "Assumptions" ->
                MainProof`UOMWeldedChannel`Private`lambda$135595 > 0 &&
                 MainProof`UOMWeldedChannel`Private`v$135595 > 0 &&
                 MainProof`UOMWeldedChannel`Private`alphaT$135595 > 0 &&
                 MainProof`UOMWeldedChannel`Private`alphaX$135595 > 0,
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
                 "Parameter" ->
                  MainProof`ActiveTransport`Private`lambda$135596,
                 "Assumptions" -> 1 <=
                   MainProof`ActiveTransport`Private`lambda$135596 <= 3,
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                  {0, 0, 1 +
                    MainProof`ActiveTransport`Private`lambda$135596},
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$135596,
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
               "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$135595/
                   MainProof`UOMWeldedChannel`Private`lambda$135595,
                 "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$135595/
                   (MainProof`UOMWeldedChannel`Private`lambda$135595*
                    MainProof`UOMWeldedChannel`Private`v$135595)|>,
               "TemporalWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`CapitalSigma][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$135595]*
                   MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`sigmaT][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$135595] ==
                  D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                      MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                       MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$135595],
                   {MainProof`UOMWeldedChannel`Private`t, 2}]],
               "SpatialWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`LoG[
                     MainProof`UOMWeldedChannel`Private`rho][
                    MainProof`UOMWeldedChannel`Private`Omega,
                    MainProof`UOMWeldedChannel`Private`center$135595] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                     MainProof`UOMWeldedChannel`Private`sigmaX][
                    MainProof`UOMWeldedChannel`Private`Omega,
                    MainProof`UOMWeldedChannel`Private`center$135595] ==
                  MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                     MainProof`UOMWeldedChannel`Private`rho^2 +
                      MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                   MainProof`UOMWeldedChannel`Private`Omega,
                   MainProof`UOMWeldedChannel`Private`center$135595]],
               "BandLockStatement" -> HoldForm[
                 {MainProof`UOMWeldedChannel`Private`sT ==
                   MainProof`UOMWeldedChannel`Private`alphaT$135595/
                    MainProof`UOMWeldedChannel`Private`lambda$135595,
                  MainProof`UOMWeldedChannel`Private`sX ==
                   MainProof`UOMWeldedChannel`Private`alphaX$135595/
                    (MainProof`UOMWeldedChannel`Private`v$135595*
                     MainProof`UOMWeldedChannel`Private`lambda$135595)}],
               "CenterLockStatement" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`OmegaStar ==
                  MainProof`UOMWeldedChannel`Private`center$135595],
               "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 0},
                {0, 0}}, "ProfileBasisB" -> {{1, 0}},
               "CompressedChannelStatement" -> HoldForm[
                 Subscript[MainProof`UOMWeldedChannel`Private`H,
                    MainProof`UOMWeldedChannel`Private`LoG][
                   MainProof`UOMWeldedChannel`Private`lambda$135595] ==
                  Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                     MainProof`UOMWeldedChannel`Private`lambda$135595]}]]|>,
             "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
               "Parameter" ->
                MainProof`ActiveTransport`Private`lambda$135596,
               "Assumptions" -> 1 <=
                 MainProof`ActiveTransport`Private`lambda$135596 <= 3,
               "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$135596},
               "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$135596,
               "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
             "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
             "AminusBoundaryImages" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0, 0}}},
             "BoundaryGenerator" -> {{1, 0}, {0, 0}}, "ObservableWitness" ->
              {{0, 1}, {0, 0}}, "GenericObservable" ->
              {{MainProof`UOMBoundaryCanonicalization`Private`x[1, 1],
                MainProof`UOMBoundaryCanonicalization`Private`x[1, 2]}, {
                MainProof`UOMBoundaryCanonicalization`Private`x[2, 1],
                MainProof`UOMBoundaryCanonicalization`Private`x[2, 2]}},
             "CalibrationData" -> <|"SeedRepresentative" -> {1, -1, 1},
               "Calibration1" -> <|"U" -> {{1, 0}, {0, 1}, {0, 0}},
                 "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "J0" -> {1, -1,
                  1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "GA" -> {{1, 0},
                  {0, 1}}, "LinearTerm" -> {-1, 1}, "aStar" -> {-1, 1},
                 "Jcan" -> {0, 0, 1}, "Projector" -> {{1, 0, 0}, {0, 1, 0},
                  {0, 0, 0}}|>, "Calibration2" -> <|"U" -> {{1, 0}, {0, 1},
                   {0, 0}}, "B" -> {{2, 0, 1}, {0, 3, 1}, {1, 1, 5}},
                 "J0" -> {1, -1, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                 "GA" -> {{2, 0}, {0, 3}}, "LinearTerm" -> {-3, 2},
                 "aStar" -> {-3/2, 2/3}, "Jcan" -> {-1/2, -1/3, 1},
                 "Projector" -> {{1, 0, 1/2}, {0, 1, 1/3}, {0, 0, 0}}|>,
               "CalibrationMatrices" -> <|"B1" -> {{1, 0, 0}, {0, 1, 0}, {0,
                  0, 1}}, "B2" -> {{2, 0, 1}, {0, 3, 1}, {1, 1, 5}}|>|>|>,
           "Channel" -> <|"Name" ->
              "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
              MainProof`UOMWeldedChannel`Private`lambda$135595,
             "vGeom" -> MainProof`UOMWeldedChannel`Private`v$135595,
             "AlphaTStar" ->
              MainProof`UOMWeldedChannel`Private`alphaT$135595,
             "AlphaXStar" ->
              MainProof`UOMWeldedChannel`Private`alphaX$135595,
             "Center" -> MainProof`UOMWeldedChannel`Private`center$135595,
             "Tick" -> MainProof`UOMWeldedChannel`Private`tick$135595,
             "DimB" -> 2, "Assumptions" ->
              MainProof`UOMWeldedChannel`Private`lambda$135595 > 0 &&
               MainProof`UOMWeldedChannel`Private`v$135595 > 0 &&
               MainProof`UOMWeldedChannel`Private`alphaT$135595 > 0 &&
               MainProof`UOMWeldedChannel`Private`alphaX$135595 > 0,
             "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
               "Parameter" ->
                MainProof`ActiveTransport`Private`lambda$135596,
               "Assumptions" -> 1 <=
                 MainProof`ActiveTransport`Private`lambda$135596 <= 3,
               "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$135596},
               "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$135596,
               "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
             "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
              <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$135595/
                 MainProof`UOMWeldedChannel`Private`lambda$135595, "s_x" ->
                MainProof`UOMWeldedChannel`Private`alphaX$135595/
                 (MainProof`UOMWeldedChannel`Private`lambda$135595*
                  MainProof`UOMWeldedChannel`Private`v$135595)|>,
             "TemporalWeldedForm" -> HoldForm[
               MainProof`UOMWeldedChannel`Private`gPrime[
                   MainProof`UOMWeldedChannel`Private`CapitalSigma][
                  MainProof`UOMWeldedChannel`Private`t -
                   MainProof`UOMWeldedChannel`Private`tick$135595]*
                 MainProof`UOMWeldedChannel`Private`gPrime[
                   MainProof`UOMWeldedChannel`Private`sigmaT][
                  MainProof`UOMWeldedChannel`Private`t -
                   MainProof`UOMWeldedChannel`Private`tick$135595] ==
                D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                    MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                     MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                  MainProof`UOMWeldedChannel`Private`t -
                   MainProof`UOMWeldedChannel`Private`tick$135595],
                 {MainProof`UOMWeldedChannel`Private`t, 2}]],
             "SpatialWeldedForm" -> HoldForm[
               MainProof`UOMWeldedChannel`Private`LoG[
                   MainProof`UOMWeldedChannel`Private`rho][
                  MainProof`UOMWeldedChannel`Private`Omega,
                  MainProof`UOMWeldedChannel`Private`center$135595] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                   MainProof`UOMWeldedChannel`Private`sigmaX][
                  MainProof`UOMWeldedChannel`Private`Omega,
                  MainProof`UOMWeldedChannel`Private`center$135595] ==
                MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                   MainProof`UOMWeldedChannel`Private`rho^2 +
                    MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                 MainProof`UOMWeldedChannel`Private`Omega,
                 MainProof`UOMWeldedChannel`Private`center$135595]],
             "BandLockStatement" -> HoldForm[{
                MainProof`UOMWeldedChannel`Private`sT ==
                 MainProof`UOMWeldedChannel`Private`alphaT$135595/
                  MainProof`UOMWeldedChannel`Private`lambda$135595,
                MainProof`UOMWeldedChannel`Private`sX ==
                 MainProof`UOMWeldedChannel`Private`alphaX$135595/
                  (MainProof`UOMWeldedChannel`Private`v$135595*
                   MainProof`UOMWeldedChannel`Private`lambda$135595)}],
             "CenterLockStatement" -> HoldForm[
               MainProof`UOMWeldedChannel`Private`OmegaStar ==
                MainProof`UOMWeldedChannel`Private`center$135595],
             "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 0},
              {0, 0}}, "ProfileBasisB" -> {{1, 0}},
             "CompressedChannelStatement" -> HoldForm[Subscript[
                  MainProof`UOMWeldedChannel`Private`H,
                  MainProof`UOMWeldedChannel`Private`LoG][
                 MainProof`UOMWeldedChannel`Private`lambda$135595] ==
                Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                   MainProof`UOMWeldedChannel`Private`lambda$135595]}]]|>,
           "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
             "Parameter" -> MainProof`ActiveTransport`Private`lambda$135596,
             "Assumptions" -> 1 <=
               MainProof`ActiveTransport`Private`lambda$135596 <= 3,
             "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
              {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$135596},
             "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$135596,
             "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
           "ActiveProjectorB" -> {{1, 0}, {0, 0}},
           "ActiveScalarFunctional" -> {0, 0, 1}, "RepresentativeImage" ->
            {{1, 0}, {0, 0}}, "AmbiguityBasis" -> {{1, 0, 0}, {0, 1, 0}},
           "AmbiguityImages" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0, 0}}}|>,
         "LedgerProjectors" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}},
         "ControlledSplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1,
          0}, {0, 0, 0, -1}}, "RepresentativeLift" -> {{1, 0, 0, 0}, {0, 0,
          0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, "AmbiguityLifts" ->
          {{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0,
           0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
       "MainVisibleQuotientCoordinate" -> {{0, 0, 1}},
       "MainVisibleDescendedFunctional" -> {1}|>, "ThresholdAudit" ->
      <|"CounterexampleExistsQ" -> True, "Witness" ->
        {
         {
          MainProof`DelayedDescendantReentryAudit`Private`alphaPrime$138226 \
-> 1, MainProof`DelayedDescendantReentryAudit`Private`dLambda$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`stock$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`alpha$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`eta$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`gcl$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`dI$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`zeta$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`a0$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`lam$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`rabs$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`kappa$138226 -> 1,
          MainProof`DelayedDescendantReentryAudit`Private`c0$138226 -> 0}},
       "NamedWitness" -> <|"alphaPrime" -> 1, "dLambda" -> 1, "stock" -> 1,
         "alpha" -> 1, "eta" -> 1, "gcl" -> 1, "dI" -> 1, "zeta" -> 1,
         "a0" -> 1, "lam" -> 1, "rabs" -> 1, "kappa" -> 1, "c0" -> 0|>,
       "NamedWitnessVerifiedQ" -> True, "Interpretation" -> "The effective \
split-threshold inequality admits positive exact witnesses with c_Lambda = 0, \
so the threshold does not force nonvanishing of the seam coefficient by \
itself."|>, "CanonicalLiftAudit" -> <|"SplitModelName" ->
        "uom_split_controlled_lift_contract", "QuotientCoordinateMatrix" ->
        {{0, 0, 1}}, "DescendedFunctionalCoordinates" -> {1},
       "Claims" -> <|"Current exact split family admits a canonical scalar \
descendant representative modulo Aminus" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>, "Canonical scalar representative survives \
the descendant ambiguity quotient in the current exact family" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>, "Canonical scalar representative survives \
the current Main-visible scalar quotient in the exact family" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>|>, "ResidualBoundary" ->
        {"The scalar lift is a model-specific reconstruction on the exact \
one-dimensional split response line.", "This does not derive a microscopic \
completion-to-descendant lift theorem from the split note by itself.", "It \
certifies only that the present surrogate family admits a canonical scalar \
inverse modulo Aminus."}|>, "FurtherQuotientAudit" ->
      <|"PhysicalQuotientVisibleCountermodel" ->
        <|"AmbiguityImagesOnPhysicalBasis" -> {{{0, 0, 0, 0, 0}, {0, 0, 0, 1,
            0}}}, "OnTheNoseTriviality" -> False, "ActsIntoNullIdeal" ->
          False, "GenericShiftDifferenceInNullIdeal" -> False,
         "GenericShiftDifferenceCoordinates" -> {{}, {}},
         "ClassDefinedOnPhysicalQuotient" -> False,
         "VisibleFailureWitness" -> True|>, "BoundaryUnsafeCountermodel" ->
        <|"ModelName" -> "unsafe_visible_2x2", "Dimension" -> {2, 2},
         "ControlledCommutatorFormula" -> <|"Dimension" -> {2, 2},
           "ControlledReductionFormula" -> True,
           "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "For \
controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K on A \
\[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \[CircleTimes] \
[K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 0}, {0, -1, 0,
          0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "ControlledBlocks" ->
          {{{1, 0}, {0, -1}}, {{0, 0}, {0, 0}}}, "StrongBlockCentralityQ" ->
          False, "ModNullBlockCentralityQ" -> False, "StrongClassDefinedQ" ->
          False, "ModNullClassDefinedQ" -> False,
         "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" ->
          True, "StrongEquivalenceCertified" -> True,
         "ModNullEquivalenceCertified" -> True,
         "ExpectationInsufficiencyWitnessQ" -> True, "WitnessObservable" ->
          {{0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
         "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
          0, 0}}|>, "BoundaryBorderlineModel" ->
        <|"ModelName" -> "borderline_nullideal_2x3", "Dimension" -> {2, 3},
         "ControlledCommutatorFormula" -> <|"Dimension" -> {2, 3},
           "ControlledReductionFormula" -> True,
           "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "For \
controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K on A \
\[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \[CircleTimes] \
[K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 0, 0, 0}, {0, 1,
          0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
          0, 0}, {0, 0, 0, 0, 0, 0}}, "ControlledBlocks" ->
          {{{1, 0, 0}, {0, 1, 0}, {0, 0, 0}}, {{0, 0, 0}, {0, 0, 0}, {0, 0,
           0}}}, "StrongBlockCentralityQ" -> False,
         "ModNullBlockCentralityQ" -> True, "StrongClassDefinedQ" -> False,
         "ModNullClassDefinedQ" -> True, "ExpectationLevelInvisibleQ" ->
          True, "OperatorLevelVisibleQ" -> True,
         "StrongEquivalenceCertified" -> True,
         "ModNullEquivalenceCertified" -> True,
         "ExpectationInsufficiencyWitnessQ" -> True, "WitnessObservable" ->
          {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
          0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}},
         "WitnessImage" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0,
          0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
          0}}|>, "Claims" -> <|"Further post-Main-visible reentry is \
automatic from split-controlled localization alone" ->
          <|"Status" -> "counterexample found", "Certified" -> False|>,
         "A chosen mod-null boundary quotient can support conditional reentry \
on the audited borderline family" -> <|"Status" ->
            "exact finite-dimensional certificate", "Certified" -> True|>|>,
       "ResidualBoundary" -> {"The visible physical-sector example is not \
class-defined on the physical quotient.", "The unsafe controlled split-welded \
family is not mod-null class-defined, even though expectation-level \
invisibility holds there.", "So the current exact lane does not certify an \
automatic V^1-style or physical/null-ideal reentry theorem from \
split-controlled localization alone."}|>, "Claims" ->
      <|"Split-threshold regime forces c_Lambda != 0" ->
        <|"Status" -> "counterexample found", "Certified" -> False|>,
       "Current exact split family admits a canonical scalar descendant \
representative modulo Aminus" -> <|"Status" ->
          "exact finite-dimensional certificate", "Certified" -> True|>,
       "Canonical scalar representative survives the descendant ambiguity \
quotient in the current exact family" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True|>, "Canonical scalar representative survives the \
current Main-visible scalar quotient in the exact family" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True|>, "Further post-Main-visible reentry is \
automatic from split-controlled localization alone" ->
        <|"Status" -> "counterexample found", "Certified" -> False|>,
       "A chosen mod-null boundary quotient can support conditional reentry \
on the audited borderline family" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True|>|>, "ResidualBoundary" ->
      {"The effective split-threshold inequality admits positive exact \
witnesses with c_Lambda = 0, so the threshold does not force nonvanishing of \
the seam coefficient by itself.", "The scalar lift is a model-specific \
reconstruction on the exact one-dimensional split response line.", "This does \
not derive a microscopic completion-to-descendant lift theorem from the split \
note by itself.", "It certifies only that the present surrogate family admits \
a canonical scalar inverse modulo Aminus.", "The visible physical-sector \
example is not class-defined on the physical quotient.", "The unsafe \
controlled split-welded family is not mod-null class-defined, even though \
expectation-level invisibility holds there.", "So the current exact lane does \
not certify an automatic V^1-style or physical/null-ideal reentry theorem \
from split-controlled localization alone."}|>,
   "UnderlyingTransversalityAudit" -> <|"UnderlyingDelayedReentryAudit" ->
      <|"Model" -> <|"TransportModel" ->
          <|"Name" -> "certified_polynomial_branch", "Parameter" ->
            MainProof`ActiveTransport`Private`lambda$141957,
           "Assumptions" -> 1 <=
             MainProof`ActiveTransport`Private`lambda$141957 <= 3,
           "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
            {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$141957},
           "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$141957,
           "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
         "SplitModel" -> <|"Name" -> "uom_split_controlled_lift_contract",
           "IntrinsicResponseContract" -> <|"Name" ->
              "uom_intrinsic_response_contract_from_welded_boundary",
             "BoundaryModel" -> <|"BoundaryAudit" -> <|"Model" ->
                  <|"Channel" -> <|"Name" ->
                      "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                      MainProof`UOMWeldedChannel`Private`lambda$141963,
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$141963,
                     "AlphaTStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$141963,
                     "AlphaXStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$141963,
                     "Center" ->
                      MainProof`UOMWeldedChannel`Private`center$141963,
                     "Tick" ->
                      MainProof`UOMWeldedChannel`Private`tick$141963,
                     "DimB" -> 2, "Assumptions" ->
                      MainProof`UOMWeldedChannel`Private`lambda$141963 > 0 &&
                       MainProof`UOMWeldedChannel`Private`v$141963 > 0 &&
                       MainProof`UOMWeldedChannel`Private`alphaT$141963 >
                        0 &&
                       MainProof`UOMWeldedChannel`Private`alphaX$141963 > 0,
                     "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$141964,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$141964 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$141964},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$141964,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                      <|"s_t" ->
                        MainProof`UOMWeldedChannel`Private`alphaT$141963/
                         MainProof`UOMWeldedChannel`Private`lambda$141963,
                       "s_x" ->
                        MainProof`UOMWeldedChannel`Private`alphaX$141963/
                         (MainProof`UOMWeldedChannel`Private`lambda$141963*
                          MainProof`UOMWeldedChannel`Private`v$141963)|>,
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$141963]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$141963] ==
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$141963],
                         {MainProof`UOMWeldedChannel`Private`t, 2}]],
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$141963] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$141963] \
== MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega,
                         MainProof`UOMWeldedChannel`Private`center$141963]],
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT ==
                         MainProof`UOMWeldedChannel`Private`alphaT$141963/
                          MainProof`UOMWeldedChannel`Private`lambda$141963,
                        MainProof`UOMWeldedChannel`Private`sX ==
                         MainProof`UOMWeldedChannel`Private`alphaX$141963/
                          (MainProof`UOMWeldedChannel`Private`v$141963*
                          MainProof`UOMWeldedChannel`Private`lambda$141963)}]\
, "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar ==
                        MainProof`UOMWeldedChannel`Private`center$141963],
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" ->
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H,
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$141963] ==
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$141963]}]]\
|>, "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
                     "Parameter" ->
                      MainProof`ActiveTransport`Private`lambda$141964,
                     "Assumptions" -> 1 <=
                       MainProof`ActiveTransport`Private`lambda$141964 <= 3,
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                      {0, 0, 1 +
                        MainProof`ActiveTransport`Private`lambda$141964},
                     "Nu" -> 1 +
                       MainProof`ActiveTransport`Private`lambda$141964,
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                   "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                   "AminusBoundaryImages" -> {{{0, 0}, {0, 0}}, {{0, 0},
                      {0, 0}}}, "RepresentativeBoundaryImage" -> {{1, 0},
                     {0, 0}}, "FactPreservationAudit" -> <|"Dimension" -> 3,
                     "SymbolicState" ->
                      {{MainProof`UOMFactPreservation`Private`r[1, 1],
                        MainProof`UOMFactPreservation`Private`r[1, 2],
                        MainProof`UOMFactPreservation`Private`r[1, 3]},
                       {MainProof`UOMFactPreservation`Private`r[2, 1],
                        MainProof`UOMFactPreservation`Private`r[2, 2],
                        MainProof`UOMFactPreservation`Private`r[2, 3]},
                       {MainProof`UOMFactPreservation`Private`r[3, 1],
                        MainProof`UOMFactPreservation`Private`r[3, 2],
                        MainProof`UOMFactPreservation`Private`r[3, 3]}},
                     "QNDTickImage" ->
                      {{MainProof`UOMFactPreservation`Private`r[1, 1],
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          1, 2]*MainProof`UOMFactPreservation`Private`r[1,
                          2],
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          1, 3]*MainProof`UOMFactPreservation`Private`r[1,
                          3]}, {
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          2, 1]*MainProof`UOMFactPreservation`Private`r[2,
                          1], MainProof`UOMFactPreservation`Private`r[2, 2],
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          2, 3]*MainProof`UOMFactPreservation`Private`r[2,
                          3]}, {
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          3, 1]*MainProof`UOMFactPreservation`Private`r[3,
                          1],
                        MainProof`UOMFactPreservation`Private`kernel$141967[
                          3, 2]*MainProof`UOMFactPreservation`Private`r[3,
                          2], MainProof`UOMFactPreservation`Private`r[3,
                         3]}}, "AcceptedRecordState" ->
                      {{MainProof`UOMFactPreservation`Private`r[1, 1], 0, 0},
                       {0, MainProof`UOMFactPreservation`Private`r[2, 2], 0},
                       {0, 0, MainProof`UOMFactPreservation`Private`r[3,
                         3]}}, "Claims" -> <|"Accepted record projection \
preserves all record expectations exactly" -> <|"Status" ->
                          "exact finite-dimensional certificate",
                         "Certified" -> True|>,
                       "Commuting QND tick fixes the accepted record state" \
-> <|"Status" -> "exact finite-dimensional certificate", "Certified" ->
                          True|>, "Accepted record projection is the exact \
conditional expectation onto the diagonal record algebra" -> <|"Status" ->
                          "exact finite-dimensional certificate",
                         "Certified" -> True|>|>|>|>, "Claims" ->
                  <|"Transported ambiguity vanishes on the exact welded \
boundary channel" -> <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>, "Boundary image of the class \
representative is the nonzero epsilon-weighted welded LoG line" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>, "Exact sub-cutoff fact \
preservation is enforced on the accepted record algebra" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>, "Old visible ambiguity witness is excluded by \
UOM welded/fact-preserving constraints" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>|>|>, "PulseAudit" -> <|"Contract" ->
                  <|"Name" -> "uom_exact_welded_pulse_contract",
                   "ChannelData" -> <|"Name" ->
                      "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                      MainProof`UOMWeldedChannel`Private`lambda$142041,
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$142041,
                     "AlphaTStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$142041,
                     "AlphaXStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$142041,
                     "Center" ->
                      MainProof`UOMWeldedChannel`Private`center$142041,
                     "Tick" ->
                      MainProof`UOMWeldedChannel`Private`tick$142041,
                     "DimB" -> 2, "Assumptions" ->
                      MainProof`UOMWeldedChannel`Private`lambda$142041 > 0 &&
                       MainProof`UOMWeldedChannel`Private`v$142041 > 0 &&
                       MainProof`UOMWeldedChannel`Private`alphaT$142041 >
                        0 &&
                       MainProof`UOMWeldedChannel`Private`alphaX$142041 > 0,
                     "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142042,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142042 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142042},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142042,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                      <|"s_t" ->
                        MainProof`UOMWeldedChannel`Private`alphaT$142041/
                         MainProof`UOMWeldedChannel`Private`lambda$142041,
                       "s_x" ->
                        MainProof`UOMWeldedChannel`Private`alphaX$142041/
                         (MainProof`UOMWeldedChannel`Private`lambda$142041*
                          MainProof`UOMWeldedChannel`Private`v$142041)|>,
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142041]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142041] ==
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142041],
                         {MainProof`UOMWeldedChannel`Private`t, 2}]],
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$142041] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$142041] \
== MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega,
                         MainProof`UOMWeldedChannel`Private`center$142041]],
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT ==
                         MainProof`UOMWeldedChannel`Private`alphaT$142041/
                          MainProof`UOMWeldedChannel`Private`lambda$142041,
                        MainProof`UOMWeldedChannel`Private`sX ==
                         MainProof`UOMWeldedChannel`Private`alphaX$142041/
                          (MainProof`UOMWeldedChannel`Private`v$142041*
                          MainProof`UOMWeldedChannel`Private`lambda$142041)}]\
, "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar ==
                        MainProof`UOMWeldedChannel`Private`center$142041],
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" ->
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H,
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$142041] ==
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$142041]}]]\
|>, "TemporalMacroMicroCompilation" -> HoldForm[
                     MainProof`UOMPulseCharacterization`Private`DoGTemporal[
                        MainProof`UOMPulseCharacterization`Private`sigmaMacro\
T, MainProof`UOMPulseCharacterization`Private`sigmaMicroT][
                       MainProof`UOMPulseCharacterization`Private`t -
                        MainProof`UOMPulseCharacterization`Private`tick] ==
                      MainProof`UOMPulseCharacterization`Private`LoG[
                        Sqrt[MainProof`UOMPulseCharacterization`Private`sigma\
MacroT^2 + MainProof`UOMPulseCharacterization`Private`sigmaMicroT^2]][
                       MainProof`UOMPulseCharacterization`Private`t -
                        MainProof`UOMPulseCharacterization`Private`tick]],
                   "SpatialMacroMicroCompilation" -> HoldForm[
                     MainProof`UOMPulseCharacterization`Private`DoGSpatial[
                        MainProof`UOMPulseCharacterization`Private`rhoMacro,
                        MainProof`UOMPulseCharacterization`Private`rhoMicro][
                       MainProof`UOMPulseCharacterization`Private`Omega,
                       MainProof`UOMPulseCharacterization`Private`center] ==
                      MainProof`UOMPulseCharacterization`Private`LoG[
                        Sqrt[
                         MainProof`UOMPulseCharacterization`Private`rhoMacro^
                          2 +
                          MainProof`UOMPulseCharacterization`Private`rhoMicro^
                          2]][
                       MainProof`UOMPulseCharacterization`Private`Omega,
                       MainProof`UOMPulseCharacterization`Private`center]],
                   "QuadratureWidthCombination" -> <|"Temporal" -> HoldForm[
                       MainProof`UOMPulseCharacterization`Private`sWeldT ==
                        Sqrt[MainProof`UOMPulseCharacterization`Private`sigma\
MacroT^2 + MainProof`UOMPulseCharacterization`Private`sigmaMicroT^2]],
                     "Spatial" -> HoldForm[
                       MainProof`UOMPulseCharacterization`Private`rhoWeld ==
                        Sqrt[
                         MainProof`UOMPulseCharacterization`Private`rhoMacro^
                          2 +
                          MainProof`UOMPulseCharacterization`Private`rhoMicro^
                          2]]|>, "TemporalWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`CapitalSigma][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$142041]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$142041] ==
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t -
                         MainProof`UOMWeldedChannel`Private`tick$142041],
                       {MainProof`UOMWeldedChannel`Private`t, 2}]],
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$142041] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega,
                        MainProof`UOMWeldedChannel`Private`center$142041] ==
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega,
                       MainProof`UOMWeldedChannel`Private`center$142041]],
                   "CoCenteringStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar ==
                      MainProof`UOMWeldedChannel`Private`center$142041],
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT ==
                       MainProof`UOMWeldedChannel`Private`alphaT$142041/
                        MainProof`UOMWeldedChannel`Private`lambda$142041,
                      MainProof`UOMWeldedChannel`Private`sX ==
                       MainProof`UOMWeldedChannel`Private`alphaX$142041/
                        (MainProof`UOMWeldedChannel`Private`v$142041*
                         MainProof`UOMWeldedChannel`Private`lambda$142041)}],
                   "BandLockScales" -> <|"s_t" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$142041/
                       MainProof`UOMWeldedChannel`Private`lambda$142041,
                     "s_x" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$142041/
                       (MainProof`UOMWeldedChannel`Private`lambda$142041*
                        MainProof`UOMWeldedChannel`Private`v$142041)|>,
                   "CompressedLineProjector" -> {{1, 0}, {0, 0}},
                   "CompressedLineDimension" -> 1|>, "Claims" ->
                  <|"Welded LoG shape is compiled exactly from macro/micro \
DoG data" -> <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>,
                   "Welded pulse is exactly co-centered" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>,
                   "Receiver band-lock fixes the welded widths exactly" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>,
                   "Compressed welded image is rank-one" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>|>|>, "AcceptedChannelAudit" ->
                <|"Contract" -> <|"Name" ->
                    "uom_exact_accepted_channel_contract", "ChannelData" ->
                    <|"Name" -> "uom_exact_welded_bandlocked_log_channel",
                     "Lambda" ->
                      MainProof`UOMWeldedChannel`Private`lambda$142048,
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$142048,
                     "AlphaTStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaT$142048,
                     "AlphaXStar" ->
                      MainProof`UOMWeldedChannel`Private`alphaX$142048,
                     "Center" ->
                      MainProof`UOMWeldedChannel`Private`center$142048,
                     "Tick" ->
                      MainProof`UOMWeldedChannel`Private`tick$142048,
                     "DimB" -> 2, "Assumptions" ->
                      MainProof`UOMWeldedChannel`Private`lambda$142048 > 0 &&
                       MainProof`UOMWeldedChannel`Private`v$142048 > 0 &&
                       MainProof`UOMWeldedChannel`Private`alphaT$142048 >
                        0 &&
                       MainProof`UOMWeldedChannel`Private`alphaX$142048 > 0,
                     "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142049,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142049 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142049},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142049,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                      <|"s_t" ->
                        MainProof`UOMWeldedChannel`Private`alphaT$142048/
                         MainProof`UOMWeldedChannel`Private`lambda$142048,
                       "s_x" ->
                        MainProof`UOMWeldedChannel`Private`alphaX$142048/
                         (MainProof`UOMWeldedChannel`Private`lambda$142048*
                          MainProof`UOMWeldedChannel`Private`v$142048)|>,
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142048]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142048] ==
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t -
                          MainProof`UOMWeldedChannel`Private`tick$142048],
                         {MainProof`UOMWeldedChannel`Private`t, 2}]],
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$142048] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega,
                          MainProof`UOMWeldedChannel`Private`center$142048] \
== MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 +
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega,
                         MainProof`UOMWeldedChannel`Private`center$142048]],
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT ==
                         MainProof`UOMWeldedChannel`Private`alphaT$142048/
                          MainProof`UOMWeldedChannel`Private`lambda$142048,
                        MainProof`UOMWeldedChannel`Private`sX ==
                         MainProof`UOMWeldedChannel`Private`alphaX$142048/
                          (MainProof`UOMWeldedChannel`Private`v$142048*
                          MainProof`UOMWeldedChannel`Private`lambda$142048)}]\
, "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar ==
                        MainProof`UOMWeldedChannel`Private`center$142048],
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" ->
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H,
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$142048] ==
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$142048]}]]\
|>, "SourceWrite" -> HoldForm[MainProof`UOMAcceptedChannel`Private`Wsrc[
                       MainProof`UOMAcceptedChannel`Private`v] ==
                      MainProof`UOMAcceptedChannel`Private`v],
                   "RetardedTransport" -> HoldForm[
                     MainProof`UOMAcceptedChannel`Private`Gret[
                       MainProof`UOMAcceptedChannel`Private`v] ==
                      MainProof`UOMAcceptedChannel`Private`v],
                   "CompiledScalarMap" -> HoldForm[
                     MainProof`UOMAcceptedChannel`Private`Kcomp[
                       MainProof`UOMAcceptedChannel`Private`v] ==
                      MainProof`UOMAcceptedChannel`Private`chi .
                        MainProof`UOMAcceptedChannel`Private`v/
                       MainProof`UOMAcceptedChannel`Private`epsilon],
                   "WeylCompensator" -> HoldForm[
                     MainProof`UOMAcceptedChannel`Private`Mepsilon[
                       MainProof`UOMAcceptedChannel`Private`s] ==
                      MainProof`UOMAcceptedChannel`Private`epsilon*
                       MainProof`UOMAcceptedChannel`Private`s],
                   "ProfileProjection" -> HoldForm[
                     MainProof`UOMAcceptedChannel`Private`PiL[
                       MainProof`UOMAcceptedChannel`Private`s] ==
                      MainProof`UOMAcceptedChannel`Private`s*
                       MainProof`UOMAcceptedChannel`Private`PLoG],
                   "FactorizationStatement" -> HoldForm[
                     MainProof`UOMAcceptedChannel`Private`TLambda[
                       MainProof`UOMAcceptedChannel`Private`v] ==
                      MainProof`UOMAcceptedChannel`Private`PiL[
                       MainProof`UOMAcceptedChannel`Private`Mepsilon[
                        MainProof`UOMAcceptedChannel`Private`Kcomp[
                         MainProof`UOMAcceptedChannel`Private`Gret[
                          MainProof`UOMAcceptedChannel`Private`Wsrc[
                          MainProof`UOMAcceptedChannel`Private`v]]]]]],
                   "AcceptedTickKrausOperators" -> {{{1, 0, 0}, {0, 0, 0},
                     {0, 0, 0}}, {{0, 0, 0}, {0, 1, 0}, {0, 0, 0}}, {{0, 0,
                     0}, {0, 0, 0}, {0, 0, 1}}}, "UpliftIsometry" -> {{1, 0,
                    0}, {0, 0, 0}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}, {0, 0,
                    0}}, "AcceptedTickDimension" -> 3|>,
                 "FactPreservationAudit" -> <|"Dimension" -> 3,
                   "SymbolicState" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1],
                      MainProof`UOMFactPreservation`Private`r[1, 2],
                      MainProof`UOMFactPreservation`Private`r[1, 3]},
                     {MainProof`UOMFactPreservation`Private`r[2, 1],
                      MainProof`UOMFactPreservation`Private`r[2, 2],
                      MainProof`UOMFactPreservation`Private`r[2, 3]},
                     {MainProof`UOMFactPreservation`Private`r[3, 1],
                      MainProof`UOMFactPreservation`Private`r[3, 2],
                      MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "QNDTickImage" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1],
                      MainProof`UOMFactPreservation`Private`kernel$142055[1,
                        2]*MainProof`UOMFactPreservation`Private`r[1, 2],
                      MainProof`UOMFactPreservation`Private`kernel$142055[1,
                        3]*MainProof`UOMFactPreservation`Private`r[1, 3]},
                     {MainProof`UOMFactPreservation`Private`kernel$142055[2,
                        1]*MainProof`UOMFactPreservation`Private`r[2, 1],
                      MainProof`UOMFactPreservation`Private`r[2, 2],
                      MainProof`UOMFactPreservation`Private`kernel$142055[2,
                        3]*MainProof`UOMFactPreservation`Private`r[2, 3]},
                     {MainProof`UOMFactPreservation`Private`kernel$142055[3,
                        1]*MainProof`UOMFactPreservation`Private`r[3, 1],
                      MainProof`UOMFactPreservation`Private`kernel$142055[3,
                        2]*MainProof`UOMFactPreservation`Private`r[3, 2],
                      MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "AcceptedRecordState" ->
                    {{MainProof`UOMFactPreservation`Private`r[1, 1], 0, 0},
                     {0, MainProof`UOMFactPreservation`Private`r[2, 2], 0},
                     {0, 0, MainProof`UOMFactPreservation`Private`r[3, 3]}},
                   "Claims" -> <|"Accepted record projection preserves all \
record expectations exactly" -> <|"Status" ->
                        "exact finite-dimensional certificate",
                       "Certified" -> True|>,
                     "Commuting QND tick fixes the accepted record state" ->
                      <|"Status" -> "exact finite-dimensional certificate",
                       "Certified" -> True|>, "Accepted record projection is \
the exact conditional expectation onto the diagonal record algebra" ->
                      <|"Status" -> "exact finite-dimensional certificate",
                       "Certified" -> True|>|>|>, "RecordBreakingWitness" ->
                  <|"InputState" -> {{1, 0}, {0, 0}}, "BrokenTickImage" ->
                    {{0, 0}, {0, 1}}|>, "Claims" -> <|"Accepted welded \
channel factorizes exactly through the compiled descended scalar" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>,
                   "Accepted uplift surrogate is an exact isometry" ->
                    <|"Status" -> "exact finite-dimensional certificate",
                     "Certified" -> True|>, "Accepted tick surrogate is \
exactly CPTP at finite cutoff" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>, "Accepted record sector is preserved exactly \
and breaks under the intentional ablation" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>|>|>, "ActionSelectionAudit" ->
                <|"Contract" -> <|"Families" -> {<|"Name" ->
                       "welded_rank1_selected", "P3Action" -> 1/5,
                      "SKInfluence" -> 1/7, "CompressedRank" -> 1,
                      "CoCenteredQ" -> True, "BandLockedQ" -> True,
                      "DescendedScalarFactorizationQ" -> True,
                      "AcceptedRecordPreservationQ" -> True,
                      "GaussianData" -> <|"DriveWidth" -> 1/3,
                        "SqueezeWidth" -> 1/4|>|>, <|"Name" ->
                       "higher_rank_candidate", "P3Action" -> 2/5,
                      "SKInfluence" -> 1/4, "CompressedRank" -> 2,
                      "CoCenteredQ" -> True, "BandLockedQ" -> True,
                      "DescendedScalarFactorizationQ" -> True,
                      "AcceptedRecordPreservationQ" -> True,
                      "GaussianData" -> <|"DriveWidth" -> 1/3,
                        "SqueezeWidth" -> 1/2|>|>, <|"Name" ->
                       "generic_control_candidate", "P3Action" -> 3/5,
                      "SKInfluence" -> 1/3, "CompressedRank" -> 2,
                      "CoCenteredQ" -> False, "BandLockedQ" -> False,
                      "DescendedScalarFactorizationQ" -> False,
                      "AcceptedRecordPreservationQ" -> False,
                      "GaussianData" -> <|"DriveWidth" -> 2/3,
                        "SqueezeWidth" -> 1|>|>}, "AdmissibleFamilies" ->
                    {<|"Name" -> "welded_rank1_selected", "P3Action" -> 1/5,
                      "SKInfluence" -> 1/7, "CompressedRank" -> 1,
                      "CoCenteredQ" -> True, "BandLockedQ" -> True,
                      "DescendedScalarFactorizationQ" -> True,
                      "AcceptedRecordPreservationQ" -> True,
                      "GaussianData" -> <|"DriveWidth" -> 1/3,
                        "SqueezeWidth" -> 1/4|>|>, <|"Name" ->
                       "higher_rank_candidate", "P3Action" -> 2/5,
                      "SKInfluence" -> 1/4, "CompressedRank" -> 2,
                      "CoCenteredQ" -> True, "BandLockedQ" -> True,
                      "DescendedScalarFactorizationQ" -> True,
                      "AcceptedRecordPreservationQ" -> True,
                      "GaussianData" -> <|"DriveWidth" -> 1/3,
                        "SqueezeWidth" -> 1/2|>|>}, "SelectedFamily" ->
                    <|"Name" -> "welded_rank1_selected", "P3Action" -> 1/5,
                     "SKInfluence" -> 1/7, "CompressedRank" -> 1,
                     "CoCenteredQ" -> True, "BandLockedQ" -> True,
                     "DescendedScalarFactorizationQ" -> True,
                     "AcceptedRecordPreservationQ" -> True, "GaussianData" ->
                      <|"DriveWidth" -> 1/3, "SqueezeWidth" -> 1/4|>|>,
                   "MinimalP3Action" -> 1/5, "MinimalSKInfluenceWithinP3" ->
                    1/7|>, "Claims" -> <|
                   "P3 least-action admissibility selects the welded family" \
-> <|"Status" -> "exact finite-dimensional certificate", "Certified" ->
                      True|>, "SK least-influence selection picks the \
admissible Gaussian welded family" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>, "Selected welded family is rank-one and \
descended-scalar factorized" -> <|"Status" ->
                      "exact finite-dimensional certificate", "Certified" ->
                      True|>|>|>, "LegacyTransportedAudit" ->
                <|"WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                    <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" ->
                    {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                    <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                       {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                    {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1, 0},
                    {0, 0, 1}}, "Ochar" -> <|"Name" ->
                      "CertifiedTransportedWeakInterface", "SourceModel" ->
                      "certified_polynomial_branch"|>, "BranchSignRecord" ->
                    <|"Tick" -> 1, "Epsilon" -> 1|>|>, "Realizations" ->
                  <|"TransportedSafeFamily" -> <|"Name" ->
                      "transported_safe_2x2", "DimA" -> 2, "DimB" -> 2,
                     "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}},
                     "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0, 1}, {0,
                       0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                     "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                       1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0,
                      0}, {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}},
                     "JOperator" -> {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}}, "AmbiguityOperator" -> {{0, 0, 1,
                      0}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                     "ClassicalStates" -> {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                       0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}}},
                     "WitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                      0, 0, 0}, {0, 0, 0, 0}},
                     "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, {0, -1,
                      0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                      <|"BoundarySectorType" -> "controlled",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                        "certified_polynomial_branch"|>, "WeakInterface" ->
                      <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                         "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                         {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0,
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>,
                       "J0" -> {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                       "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                        <|"Name" -> "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142073,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142073 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142073},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142073,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                     "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0,
                       1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}},
                     "EminusBasisImages" -> {{{0, 0, 1, 0}, {0, 0, 0, 1}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0},
                       {1, 0, 0, 0}, {0, 1, 0, 0}}, {{0, 1, 0, 0}, {1, 0, 0,
                       0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
                   "TransportedUnsafeFamily" -> <|"Name" ->
                      "transported_unsafe_2x2", "DimA" -> 2, "DimB" -> 2,
                     "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}},
                     "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0, 1}, {0,
                       0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                     "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                       1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0,
                      0}, {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}},
                     "JOperator" -> {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}}, "AmbiguityOperator" -> {{1, 0, 0,
                      0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                     "ClassicalStates" -> {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                       0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}}},
                     "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0, 0}, {0,
                      0, 0, 0}, {0, 0, 0, 0}},
                     "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                      <|"BoundarySectorType" -> "controlled",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                        "certified_polynomial_branch"|>, "WeakInterface" ->
                      <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                         "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                         {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0,
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>,
                       "J0" -> {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                       "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                        <|"Name" -> "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142081,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142081 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142081},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142081,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                     "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 0,
                       0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0,
                       0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}},
                     "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 0,
                       1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, {1, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>|>,
                 "AuditsByCandidate" -> <|"readout-kernel" ->
                    <|"TransportedSafeFamily" -> <|"RealizationName" ->
                        "transported_safe_2x2", "CandidateName" ->
                        "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                         "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> True,
                       "AllBasisStrongBlockCentralQ" -> True,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {1, 2},
                       "ExpectationOnlyBasisIndices" -> {}|>,
                     "TransportedUnsafeFamily" -> <|"RealizationName" ->
                        "transported_unsafe_2x2", "CandidateName" ->
                        "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                         "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1,
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> False,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> True,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> True,
                       "AllBasisStrongBlockCentralQ" -> False,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {1},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {1, 2},
                       "ExpectationOnlyBasisIndices" -> {}|>|>,
                   "block-trace-zero" -> <|"TransportedSafeFamily" ->
                      <|"RealizationName" -> "transported_safe_2x2",
                       "CandidateName" -> "block-trace-zero",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> True,
                       "AllBasisStrongBlockCentralQ" -> True,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {1, 2},
                       "ExpectationOnlyBasisIndices" -> {}|>,
                     "TransportedUnsafeFamily" -> <|"RealizationName" ->
                        "transported_unsafe_2x2", "CandidateName" ->
                        "block-trace-zero", "WeakInterface" -> <|"Tick" -> 1,
                         "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1,
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> False,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> True,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> True,
                       "AllBasisStrongBlockCentralQ" -> False,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {1},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {1, 2},
                       "ExpectationOnlyBasisIndices" -> {}|>|>,
                   "state-invisible" -> <|"TransportedSafeFamily" ->
                      <|"RealizationName" -> "transported_safe_2x2",
                       "CandidateName" -> "state-invisible",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> True,
                       "AllBasisStrongBlockCentralQ" -> True,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {1, 2},
                       "ExpectationOnlyBasisIndices" -> {}|>,
                     "TransportedUnsafeFamily" -> <|"RealizationName" ->
                        "transported_unsafe_2x2", "CandidateName" ->
                        "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                         "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1,
                          0}}, "BasisOperatorAudits" ->
                        {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1,
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          False, "StrongBlockCentralityQ" -> False,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> True,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>, <|
                          "ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                          0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                          "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                          True, "StrongBlockCentralityQ" -> True,
                          "ModNullBlockCentralityQ" -> True,
                          "OperatorLevelVisibleQ" -> False,
                          "ExpectationLevelInvisibleQ" -> True,
                          "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0,
                          0, 0, 0}, {0, 0, 0, 0}}|>},
                       "AllControlledProjectionsNullQ" -> False,
                       "AllBasisStrongBlockCentralQ" -> False,
                       "AllBasisModNullBlockCentralQ" -> True,
                       "VisibleBasisIndices" -> {1},
                       "ModNullSafeBasisIndices" -> {1, 2},
                       "NullProjectionBasisIndices" -> {2},
                       "ExpectationOnlyBasisIndices" -> {}|>|>|>,
                 "TransportedSafeWitness" -> <|"Realization" ->
                    <|"Name" -> "transported_safe_2x2", "DimA" -> 2,
                     "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0,
                       0}, {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 0}},
                       {{0, 1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                     "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                       1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0,
                      0}, {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}},
                     "JOperator" -> {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}}, "AmbiguityOperator" -> {{0, 0, 1,
                      0}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                     "ClassicalStates" -> {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                       0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}}},
                     "WitnessObservable" -> {{1, 0, 0, 0}, {0, -1, 0, 0}, {0,
                      0, 0, 0}, {0, 0, 0, 0}},
                     "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, {0, -1,
                      0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                      <|"BoundarySectorType" -> "controlled",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                        "certified_polynomial_branch"|>, "WeakInterface" ->
                      <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                         "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                         {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0,
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>,
                       "J0" -> {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                       "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                        <|"Name" -> "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142073,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142073 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142073},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142073,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                     "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0,
                       1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}},
                     "EminusBasisImages" -> {{{0, 0, 1, 0}, {0, 0, 0, 1}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0},
                       {1, 0, 0, 0}, {0, 1, 0, 0}}, {{0, 1, 0, 0}, {1, 0, 0,
                       0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
                   "ReadoutKernelAudit" -> <|"RealizationName" ->
                      "transported_safe_2x2", "CandidateName" ->
                      "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                          0}}}, "ControlledProjectionInNullIdealQ" -> True,
                        "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> True,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>,
                   "StateInvisibleAudit" -> <|"RealizationName" ->
                      "transported_safe_2x2", "CandidateName" ->
                      "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0,
                          0}}}, "ControlledProjectionInNullIdealQ" -> True,
                        "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> True,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>|>,
                 "TransportedUnsafeWitness" -> <|"Realization" ->
                    <|"Name" -> "transported_unsafe_2x2", "DimA" -> 2,
                     "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0,
                       0}, {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 0}},
                       {{0, 1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}},
                     "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, {0,
                       1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 0, 0,
                      0}, {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}},
                     "JOperator" -> {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}}, "AmbiguityOperator" -> {{1, 0, 0,
                      0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                     "ClassicalStates" -> {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0,
                       0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0,
                       0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}}},
                     "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0, 0}, {0,
                      0, 0, 0}, {0, 0, 0, 0}},
                     "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0,
                      0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "Metadata" ->
                      <|"BoundarySectorType" -> "controlled",
                       "WeakInterface" -> <|"Tick" -> 1, "Eminus" ->
                          <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                         "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                          <|"Representative" -> {0, 0, 1}, "Basis" ->
                          {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1},
                         "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0,
                          0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                          "SourceModel" -> "certified_polynomial_branch"|>,
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModelName" ->
                        "certified_polynomial_branch"|>, "WeakInterface" ->
                      <|"Tick" -> 1, "Eminus" -> <|"Dimension" -> 3,
                         "Parity" -> "Odd"|>, "Aminus" -> {{1, 0}, {0, 1},
                         {0, 0}}, "XiClass" -> <|"Representative" -> {0, 0,
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>,
                       "J0" -> {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                       "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" ->
                        <|"Name" -> "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "TransportModel" -> <|"Name" ->
                        "certified_polynomial_branch", "Parameter" ->
                        MainProof`ActiveTransport`Private`lambda$142081,
                       "Assumptions" -> 1 <=
                         MainProof`ActiveTransport`Private`lambda$142081 <=
                         3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                        {0, 0, 1 +
                          MainProof`ActiveTransport`Private`lambda$142081},
                       "Nu" -> 1 +
                         MainProof`ActiveTransport`Private`lambda$142081,
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                     "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
                     "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 0,
                       0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0,
                       0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}},
                     "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0},
                       {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 0,
                       1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, {1, 0,
                       0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
                   "ReadoutKernelAudit" -> <|"RealizationName" ->
                      "transported_unsafe_2x2", "CandidateName" ->
                      "readout-kernel", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> False,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> True,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> True,
                     "AllBasisStrongBlockCentralQ" -> False,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {1},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {1, 2},
                     "ExpectationOnlyBasisIndices" -> {}|>,
                   "StateInvisibleAudit" -> <|"RealizationName" ->
                      "transported_unsafe_2x2", "CandidateName" ->
                      "state-invisible", "WeakInterface" -> <|"Tick" -> 1,
                       "Eminus" -> <|"Dimension" -> 3, "Parity" -> "Odd"|>,
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
                        <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0},
                          {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" ->
                        {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1,
                        0}, {0, 0, 1}}, "Ochar" -> <|"Name" ->
                          "CertifiedTransportedWeakInterface",
                         "SourceModel" -> "certified_polynomial_branch"|>,
                       "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" ->
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0},
                       {0, 1, 0}}, "BasisOperatorAudits" ->
                      {<|"ControlledProjection" -> {{1, 0, 0, 0}, {0, -1, 0,
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
                        "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0},
                          {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         False, "StrongBlockCentralityQ" -> False,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> True,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>, <|"ControlledProjection" ->
                         {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0,
                         0}}, "ControlledBlocks" -> {{{0, 0}, {0, 0}}, {{0,
                          0}, {0, 0}}}, "ControlledProjectionInNullIdealQ" ->
                         True, "StrongBlockCentralityQ" -> True,
                        "ModNullBlockCentralityQ" -> True,
                        "OperatorLevelVisibleQ" -> False,
                        "ExpectationLevelInvisibleQ" -> True,
                        "WitnessImage" -> {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0,
                         0, 0}, {0, 0, 0, 0}}|>},
                     "AllControlledProjectionsNullQ" -> False,
                     "AllBasisStrongBlockCentralQ" -> False,
                     "AllBasisModNullBlockCentralQ" -> True,
                     "VisibleBasisIndices" -> {1},
                     "ModNullSafeBasisIndices" -> {1, 2},
                     "NullProjectionBasisIndices" -> {2},
                     "ExpectationOnlyBasisIndices" -> {}|>|>,
                 "WeakestAdditionalHypothesis" -> "Each boundary realization \
of a transported ambiguity basis vector must have vanishing controlled \
projection, or block-central controlled B-blocks modulo a nontrivial boundary \
null ideal that remains stable and does not trivialize the controlled \
dynamics.", "ForcedByTransportStructureQ" -> False|>, "Channel" ->
                <|"Name" -> "uom_exact_welded_bandlocked_log_channel",
                 "Lambda" ->
                  MainProof`UOMWeldedChannel`Private`lambda$141963,
                 "vGeom" -> MainProof`UOMWeldedChannel`Private`v$141963,
                 "AlphaTStar" ->
                  MainProof`UOMWeldedChannel`Private`alphaT$141963,
                 "AlphaXStar" ->
                  MainProof`UOMWeldedChannel`Private`alphaX$141963,
                 "Center" ->
                  MainProof`UOMWeldedChannel`Private`center$141963,
                 "Tick" -> MainProof`UOMWeldedChannel`Private`tick$141963,
                 "DimB" -> 2, "Assumptions" ->
                  MainProof`UOMWeldedChannel`Private`lambda$141963 > 0 &&
                   MainProof`UOMWeldedChannel`Private`v$141963 > 0 &&
                   MainProof`UOMWeldedChannel`Private`alphaT$141963 > 0 &&
                   MainProof`UOMWeldedChannel`Private`alphaX$141963 > 0,
                 "TransportModel" -> <|"Name" ->
                    "certified_polynomial_branch", "Parameter" ->
                    MainProof`ActiveTransport`Private`lambda$141964,
                   "Assumptions" -> 1 <=
                     MainProof`ActiveTransport`Private`lambda$141964 <= 3,
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                    {0, 0, 1 +
                      MainProof`ActiveTransport`Private`lambda$141964},
                   "Nu" -> 1 +
                     MainProof`ActiveTransport`Private`lambda$141964,
                   "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
                 "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                  <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$141963/
                     MainProof`UOMWeldedChannel`Private`lambda$141963,
                   "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$141963/
                     (MainProof`UOMWeldedChannel`Private`lambda$141963*
                      MainProof`UOMWeldedChannel`Private`v$141963)|>,
                 "TemporalWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`CapitalSigma][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$141963]*
                     MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`sigmaT][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$141963] ==
                    D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                        MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                         MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                      MainProof`UOMWeldedChannel`Private`t -
                       MainProof`UOMWeldedChannel`Private`tick$141963],
                     {MainProof`UOMWeldedChannel`Private`t, 2}]],
                 "SpatialWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`LoG[
                       MainProof`UOMWeldedChannel`Private`rho][
                      MainProof`UOMWeldedChannel`Private`Omega,
                      MainProof`UOMWeldedChannel`Private`center$141963] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                       MainProof`UOMWeldedChannel`Private`sigmaX][
                      MainProof`UOMWeldedChannel`Private`Omega,
                      MainProof`UOMWeldedChannel`Private`center$141963] ==
                    MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                       MainProof`UOMWeldedChannel`Private`rho^2 +
                        MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                     MainProof`UOMWeldedChannel`Private`Omega,
                     MainProof`UOMWeldedChannel`Private`center$141963]],
                 "BandLockStatement" -> HoldForm[
                   {MainProof`UOMWeldedChannel`Private`sT ==
                     MainProof`UOMWeldedChannel`Private`alphaT$141963/
                      MainProof`UOMWeldedChannel`Private`lambda$141963,
                    MainProof`UOMWeldedChannel`Private`sX ==
                     MainProof`UOMWeldedChannel`Private`alphaX$141963/
                      (MainProof`UOMWeldedChannel`Private`v$141963*
                       MainProof`UOMWeldedChannel`Private`lambda$141963)}],
                 "CenterLockStatement" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`OmegaStar ==
                    MainProof`UOMWeldedChannel`Private`center$141963],
                 "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1,
                  0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}},
                 "CompressedChannelStatement" -> HoldForm[
                   Subscript[MainProof`UOMWeldedChannel`Private`H,
                      MainProof`UOMWeldedChannel`Private`LoG][
                     MainProof`UOMWeldedChannel`Private`lambda$141963] ==
                    Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                       MainProof`UOMWeldedChannel`Private`lambda$141963]}]]|>\
, "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
                 "Parameter" ->
                  MainProof`ActiveTransport`Private`lambda$141964,
                 "Assumptions" -> 1 <=
                   MainProof`ActiveTransport`Private`lambda$141964 <= 3,
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                  {0, 0, 1 +
                    MainProof`ActiveTransport`Private`lambda$141964},
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$141964,
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
               "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}},
               "AminusBoundaryImages" -> {{{0, 0}, {0, 0}}, {{0, 0},
                  {0, 0}}}, "BoundaryGenerator" -> {{1, 0}, {0, 0}},
               "ObservableWitness" -> {{0, 1}, {0, 0}},
               "GenericObservable" ->
                {{MainProof`UOMBoundaryCanonicalization`Private`x[1, 1],
                  MainProof`UOMBoundaryCanonicalization`Private`x[1, 2]},
                 {MainProof`UOMBoundaryCanonicalization`Private`x[2, 1],
                  MainProof`UOMBoundaryCanonicalization`Private`x[2, 2]}},
               "CalibrationData" -> <|"SeedRepresentative" -> {1, -1, 1},
                 "Calibration1" -> <|"U" -> {{1, 0}, {0, 1}, {0, 0}},
                   "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "J0" -> {1, -1,
                    1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "GA" -> {{1, 0},
                    {0, 1}}, "LinearTerm" -> {-1, 1}, "aStar" -> {-1, 1},
                   "Jcan" -> {0, 0, 1}, "Projector" -> {{1, 0, 0}, {0, 1, 0},
                    {0, 0, 0}}|>, "Calibration2" -> <|"U" -> {{1, 0}, {0, 1},
                     {0, 0}}, "B" -> {{2, 0, 1}, {0, 3, 1}, {1, 1, 5}},
                   "J0" -> {1, -1, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
                   "GA" -> {{2, 0}, {0, 3}}, "LinearTerm" -> {-3, 2},
                   "aStar" -> {-3/2, 2/3}, "Jcan" -> {-1/2, -1/3, 1},
                   "Projector" -> {{1, 0, 1/2}, {0, 1, 1/3}, {0, 0, 0}}|>,
                 "CalibrationMatrices" -> <|"B1" -> {{1, 0, 0}, {0, 1, 0},
                    {0, 0, 1}}, "B2" -> {{2, 0, 1}, {0, 3, 1}, {1, 1,
                      5}}|>|>|>, "Channel" -> <|"Name" ->
                "uom_exact_welded_bandlocked_log_channel", "Lambda" ->
                MainProof`UOMWeldedChannel`Private`lambda$141963, "vGeom" ->
                MainProof`UOMWeldedChannel`Private`v$141963, "AlphaTStar" ->
                MainProof`UOMWeldedChannel`Private`alphaT$141963,
               "AlphaXStar" ->
                MainProof`UOMWeldedChannel`Private`alphaX$141963, "Center" ->
                MainProof`UOMWeldedChannel`Private`center$141963, "Tick" ->
                MainProof`UOMWeldedChannel`Private`tick$141963, "DimB" ->
                2, "Assumptions" ->
                MainProof`UOMWeldedChannel`Private`lambda$141963 > 0 &&
                 MainProof`UOMWeldedChannel`Private`v$141963 > 0 &&
                 MainProof`UOMWeldedChannel`Private`alphaT$141963 > 0 &&
                 MainProof`UOMWeldedChannel`Private`alphaX$141963 > 0,
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
                 "Parameter" ->
                  MainProof`ActiveTransport`Private`lambda$141964,
                 "Assumptions" -> 1 <=
                   MainProof`ActiveTransport`Private`lambda$141964 <= 3,
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                  {0, 0, 1 +
                    MainProof`ActiveTransport`Private`lambda$141964},
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$141964,
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
               "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" ->
                <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$141963/
                   MainProof`UOMWeldedChannel`Private`lambda$141963,
                 "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$141963/
                   (MainProof`UOMWeldedChannel`Private`lambda$141963*
                    MainProof`UOMWeldedChannel`Private`v$141963)|>,
               "TemporalWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`CapitalSigma][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$141963]*
                   MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`sigmaT][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$141963] ==
                  D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                      MainProof`UOMWeldedChannel`Private`CapitalSigma^2 +
                       MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                    MainProof`UOMWeldedChannel`Private`t -
                     MainProof`UOMWeldedChannel`Private`tick$141963],
                   {MainProof`UOMWeldedChannel`Private`t, 2}]],
               "SpatialWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`LoG[
                     MainProof`UOMWeldedChannel`Private`rho][
                    MainProof`UOMWeldedChannel`Private`Omega,
                    MainProof`UOMWeldedChannel`Private`center$141963] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                     MainProof`UOMWeldedChannel`Private`sigmaX][
                    MainProof`UOMWeldedChannel`Private`Omega,
                    MainProof`UOMWeldedChannel`Private`center$141963] ==
                  MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                     MainProof`UOMWeldedChannel`Private`rho^2 +
                      MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                   MainProof`UOMWeldedChannel`Private`Omega,
                   MainProof`UOMWeldedChannel`Private`center$141963]],
               "BandLockStatement" -> HoldForm[
                 {MainProof`UOMWeldedChannel`Private`sT ==
                   MainProof`UOMWeldedChannel`Private`alphaT$141963/
                    MainProof`UOMWeldedChannel`Private`lambda$141963,
                  MainProof`UOMWeldedChannel`Private`sX ==
                   MainProof`UOMWeldedChannel`Private`alphaX$141963/
                    (MainProof`UOMWeldedChannel`Private`v$141963*
                     MainProof`UOMWeldedChannel`Private`lambda$141963)}],
               "CenterLockStatement" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`OmegaStar ==
                  MainProof`UOMWeldedChannel`Private`center$141963],
               "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 0},
                {0, 0}}, "ProfileBasisB" -> {{1, 0}},
               "CompressedChannelStatement" -> HoldForm[
                 Subscript[MainProof`UOMWeldedChannel`Private`H,
                    MainProof`UOMWeldedChannel`Private`LoG][
                   MainProof`UOMWeldedChannel`Private`lambda$141963] ==
                  Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                     MainProof`UOMWeldedChannel`Private`lambda$141963]}]]|>,
             "TransportModel" -> <|"Name" -> "certified_polynomial_branch",
               "Parameter" ->
                MainProof`ActiveTransport`Private`lambda$141964,
               "Assumptions" -> 1 <=
                 MainProof`ActiveTransport`Private`lambda$141964 <= 3,
               "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" ->
                {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$141964},
               "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$141964,
               "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
             "ActiveProjectorB" -> {{1, 0}, {0, 0}},
             "ActiveScalarFunctional" -> {0, 0, 1}, "RepresentativeImage" ->
              {{1, 0}, {0, 0}}, "AmbiguityBasis" -> {{1, 0, 0}, {0, 1, 0}},
             "AmbiguityImages" -> {{{0, 0}, {0, 0}}, {{0, 0}, {0, 0}}}|>,
           "LedgerProjectors" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}},
           "ControlledSplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1,
            0}, {0, 0, 0, -1}}, "RepresentativeLift" -> {{1, 0, 0, 0}, {0, 0,
            0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, "AmbiguityLifts" ->
            {{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0,
             0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>,
         "MainVisibleQuotientCoordinate" -> {{0, 0, 1}},
         "MainVisibleDescendedFunctional" -> {1}|>, "ThresholdAudit" ->
        <|"CounterexampleExistsQ" -> True, "Witness" ->
          {
           {
            MainProof`DelayedDescendantReentryAudit`Private`alphaPrime$144594 \
-> 1, MainProof`DelayedDescendantReentryAudit`Private`dLambda$144594 -> 1,
            MainProof`DelayedDescendantReentryAudit`Private`stock$144594 ->
             1,
            MainProof`DelayedDescendantReentryAudit`Private`alpha$144594 ->
             1, MainProof`DelayedDescendantReentryAudit`Private`eta$144594 ->
             1, MainProof`DelayedDescendantReentryAudit`Private`gcl$144594 ->
             1, MainProof`DelayedDescendantReentryAudit`Private`dI$144594 ->
             1,
            MainProof`DelayedDescendantReentryAudit`Private`zeta$144594 -> 1,
            MainProof`DelayedDescendantReentryAudit`Private`a0$144594 -> 1,
            MainProof`DelayedDescendantReentryAudit`Private`lam$144594 -> 1,
            MainProof`DelayedDescendantReentryAudit`Private`rabs$144594 -> 1,
            MainProof`DelayedDescendantReentryAudit`Private`kappa$144594 ->
             1, MainProof`DelayedDescendantReentryAudit`Private`c0$144594 ->
             0}}, "NamedWitness" -> <|"alphaPrime" -> 1, "dLambda" -> 1,
           "stock" -> 1, "alpha" -> 1, "eta" -> 1, "gcl" -> 1, "dI" -> 1,
           "zeta" -> 1, "a0" -> 1, "lam" -> 1, "rabs" -> 1, "kappa" -> 1,
           "c0" -> 0|>, "NamedWitnessVerifiedQ" -> True,
         "Interpretation" -> "The effective split-threshold inequality admits \
positive exact witnesses with c_Lambda = 0, so the threshold does not force \
nonvanishing of the seam coefficient by itself."|>, "CanonicalLiftAudit" ->
        <|"SplitModelName" -> "uom_split_controlled_lift_contract",
         "QuotientCoordinateMatrix" -> {{0, 0, 1}},
         "DescendedFunctionalCoordinates" -> {1}, "Claims" ->
          <|"Current exact split family admits a canonical scalar descendant \
representative modulo Aminus" -> <|"Status" ->
              "exact finite-dimensional certificate", "Certified" -> True|>,
           "Canonical scalar representative survives the descendant ambiguity \
quotient in the current exact family" -> <|"Status" ->
              "exact finite-dimensional certificate", "Certified" -> True|>,
           "Canonical scalar representative survives the current Main-visible \
scalar quotient in the exact family" -> <|"Status" ->
              "exact finite-dimensional certificate", "Certified" ->
              True|>|>, "ResidualBoundary" -> {"The scalar lift is a \
model-specific reconstruction on the exact one-dimensional split response \
line.", "This does not derive a microscopic completion-to-descendant lift \
theorem from the split note by itself.", "It certifies only that the present \
surrogate family admits a canonical scalar inverse modulo Aminus."}|>,
       "FurtherQuotientAudit" -> <|"PhysicalQuotientVisibleCountermodel" ->
          <|"AmbiguityImagesOnPhysicalBasis" -> {{{0, 0, 0, 0, 0}, {0, 0, 0,
              1, 0}}}, "OnTheNoseTriviality" -> False, "ActsIntoNullIdeal" ->
            False, "GenericShiftDifferenceInNullIdeal" -> False,
           "GenericShiftDifferenceCoordinates" -> {{}, {}},
           "ClassDefinedOnPhysicalQuotient" -> False,
           "VisibleFailureWitness" -> True|>, "BoundaryUnsafeCountermodel" ->
          <|"ModelName" -> "unsafe_visible_2x2", "Dimension" -> {2, 2},
           "ControlledCommutatorFormula" -> <|"Dimension" -> {2, 2},
             "ControlledReductionFormula" -> True,
             "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "Fo\
r controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K on \
A \[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \[CircleTimes] \
[K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 0}, {0, -1, 0,
            0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, "ControlledBlocks" ->
            {{{1, 0}, {0, -1}}, {{0, 0}, {0, 0}}},
           "StrongBlockCentralityQ" -> False, "ModNullBlockCentralityQ" ->
            False, "StrongClassDefinedQ" -> False, "ModNullClassDefinedQ" ->
            False, "ExpectationLevelInvisibleQ" -> True,
           "OperatorLevelVisibleQ" -> True, "StrongEquivalenceCertified" ->
            True, "ModNullEquivalenceCertified" -> True,
           "ExpectationInsufficiencyWitnessQ" -> True, "WitnessObservable" ->
            {{0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}},
           "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0,
            0, 0, 0}}|>, "BoundaryBorderlineModel" ->
          <|"ModelName" -> "borderline_nullideal_2x3", "Dimension" -> {2, 3},
           "ControlledCommutatorFormula" -> <|"Dimension" -> {2, 3},
             "ControlledReductionFormula" -> True,
             "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "Fo\
r controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K on \
A \[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \[CircleTimes] \
[K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 0, 0, 0}, {0, 1,
            0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
            0, 0}, {0, 0, 0, 0, 0, 0}}, "ControlledBlocks" ->
            {{{1, 0, 0}, {0, 1, 0}, {0, 0, 0}}, {{0, 0, 0}, {0, 0, 0}, {0, 0,
             0}}}, "StrongBlockCentralityQ" -> False,
           "ModNullBlockCentralityQ" -> True, "StrongClassDefinedQ" -> False,
           "ModNullClassDefinedQ" -> True, "ExpectationLevelInvisibleQ" ->
            True, "OperatorLevelVisibleQ" -> True,
           "StrongEquivalenceCertified" -> True,
           "ModNullEquivalenceCertified" -> True,
           "ExpectationInsufficiencyWitnessQ" -> True, "WitnessObservable" ->
            {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0,
            0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}},
           "WitnessImage" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
            0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
            0, 0}}|>, "Claims" -> <|"Further post-Main-visible reentry is \
automatic from split-controlled localization alone" ->
            <|"Status" -> "counterexample found", "Certified" -> False|>,
           "A chosen mod-null boundary quotient can support conditional \
reentry on the audited borderline family" -> <|"Status" ->
              "exact finite-dimensional certificate", "Certified" ->
              True|>|>, "ResidualBoundary" -> {"The visible physical-sector \
example is not class-defined on the physical quotient.", "The unsafe \
controlled split-welded family is not mod-null class-defined, even though \
expectation-level invisibility holds there.", "So the current exact lane does \
not certify an automatic V^1-style or physical/null-ideal reentry theorem \
from split-controlled localization alone."}|>, "Claims" ->
        <|"Split-threshold regime forces c_Lambda != 0" ->
          <|"Status" -> "counterexample found", "Certified" -> False|>,
         "Current exact split family admits a canonical scalar descendant \
representative modulo Aminus" -> <|"Status" ->
            "exact finite-dimensional certificate", "Certified" -> True|>,
         "Canonical scalar representative survives the descendant ambiguity \
quotient in the current exact family" -> <|"Status" ->
            "exact finite-dimensional certificate", "Certified" -> True|>,
         "Canonical scalar representative survives the current Main-visible \
scalar quotient in the exact family" -> <|"Status" ->
            "exact finite-dimensional certificate", "Certified" -> True|>,
         "Further post-Main-visible reentry is automatic from \
split-controlled localization alone" -> <|"Status" -> "counterexample found",
           "Certified" -> False|>, "A chosen mod-null boundary quotient can \
support conditional reentry on the audited borderline family" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>|>, "ResidualBoundary" ->
        {"The effective split-threshold inequality admits positive exact \
witnesses with c_Lambda = 0, so the threshold does not force nonvanishing of \
the seam coefficient by itself.", "The scalar lift is a model-specific \
reconstruction on the exact one-dimensional split response line.", "This does \
not derive a microscopic completion-to-descendant lift theorem from the split \
note by itself.", "It certifies only that the present surrogate family admits \
a canonical scalar inverse modulo Aminus.", "The visible physical-sector \
example is not class-defined on the physical quotient.", "The unsafe \
controlled split-welded family is not mod-null class-defined, even though \
expectation-level invisibility holds there.", "So the current exact lane does \
not certify an automatic V^1-style or physical/null-ideal reentry theorem \
from split-controlled localization alone."}|>, "SelectedLineAudit" ->
      <|"ModelName" -> "borderline_nullideal_2x3", "SelectedLineGenerator" ->
        {{0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
        0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}},
       "NullIdealBasis" -> {{{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
         0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0,
         0, 0, 0, 0}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
         0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
         0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 0,
         0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0}}, {{0, 0,
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
         0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 1, 0}}},
       "QuotientCoordinateMatrix" -> {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          1}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0,
          0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}},
       "SelectedQuotientImage" -> {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
       "Claims" -> <|"Selected scalar line is transverse to the chosen \
mod-null ideal in the audited borderline family" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>, "Parity-stable transversality gives a \
nonzero quotient class on the audited selected line" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>,
         "Odd parity descends on the audited quotient line by sign" ->
          <|"Status" -> "exact finite-dimensional certificate",
           "Certified" -> True|>|>, "ResidualBoundary" ->
        {"This is an exact controlled finite-dimensional mod-null certificate \
on the audited borderline family.", "It does not derive the abstract Main/UOM \
transversality hypothesis automatically for the scalar descendant line in \
D^-."}|>, "Claims" -> <|"The remaining mod-null step reduces to \
line/null-ideal transversality plus quotient construction" ->
        <|"Status" ->
          "exact finite-dimensional certificate for the reduction schema",
         "Certified" -> True|>|>, "TopLineReading" ->
      {"The exact WL lane supports the new intermediate reading: once a \
parity-stable mod-null subspace meets the selected line trivially, the \
quotient is injective on that line and the remaining step is only quotient \
construction plus descended odd parity.", "So the real unresolved content is \
exactly the transversality of the selected scalar line to the chosen mod-null \
ideal.", "This remains a finite-dimensional certificate for the reduction \
schema, not an automatic derivation of the abstract transversality hypothesis \
from split localization alone."}|>, "KernelRouteAudit" ->
    <|"ModelName" -> "borderline_nullideal_2x3",
     "DominantFunctionalSurrogate" -> {{0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0,
      0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0,
      0, 0, 0, 0}}, "SelectedLineGenerator" -> {{0, 1, 0, 0, 0, 0}, {0, 0, 0,
      0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0}}, "NullIdealBasis" -> {{{0, 0, 1, 0, 0, 0}, {0, 0,
       0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
       0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {1,
       0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
       0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0,
       0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
       0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0,
       0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0,
       0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0,
       1, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0,
       0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0}}, {{0,
       0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0,
       0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 1, 0}}},
     "SelectedScalar" -> 1, "Claims" -> <|"Chosen mod-null subspace lies in \
the kernel of the dominant functional surrogate on the audited borderline \
family" -> <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True|>, "Selected scalar generator has nonzero \
dominant functional surrogate value on the audited borderline family" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True|>, "Chosen mod-null subspace is parity-stable on \
the audited borderline family" -> <|"Status" ->
          "exact finite-dimensional certificate", "Certified" -> True|>|>,
     "ResidualBoundary" -> {"The functional is an exact finite-dimensional \
surrogate built from the audited borderline-family witness pairing.", "This \
does not identify the surrogate with the abstract descended dominant \
functional outside that model family."}|>,
   "Claims" -> <|"Kernel-subordinated parity-stable mod-null data discharge \
theorem-2 transversality on the audited family" ->
      <|"Status" ->
        "exact finite-dimensional certificate for the discharge schema",
       "Certified" -> True|>|>, "TopLineReading" ->
    {"On the audited borderline family, the dominant-functional-kernel route \
is exact: the chosen parity-stable mod-null subspace lies in the kernel of \
the functional surrogate, while the selected generator has nonzero value.", "\
Therefore the selected line is automatically transverse to that mod-null \
subspace on the audited family.", "This certifies the discharge schema \
familywise, but it does not yet construct a canonical dominant-null subspace \
in the abstract Main/UOM theorem stack."}|>,
 "UpdatedNote" ->
  "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex",
 "ResidualBoundary" -> {"This is an exact finite-dimensional certificate for \
the discharge schema on the audited family.", "It does not yet construct a \
canonical dominant-null parity-stable mod-null subspace in the abstract \
Main/UOM theorem stack.", "The scalar bridge assumptions from theorem 1 \
remain imported exactly as before, including the explicit c_Lambda != 0 gate \
and the model-specific scalar-lift datum."}|>
