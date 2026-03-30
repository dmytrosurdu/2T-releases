<|"ReportDate" -> "2026-03-29 12:08:04", 
 "Status" -> "exact finite-dimensional certificate", 
 "CandidateChoice" -> "plain dominant kernel", 
 "TopLineVerdict" -> "On the audited borderline family, the plain \
dominant-kernel candidate N^{dom-null} = ker(overline rho^{dom}) already \
gives the right lane-3 discharge: parity stability, automatic selected-line \
transversality, and the quotient-construction reduction all hold without \
adding a stricter reduced-welded kernel.", 
 "NotePath" -> 
  "/home/kray-l8/work/2T/UOM/active_response_transport_program_note.tex", 
 "DominantKernelAudit" -> <|"DischargeStatus" -> 
    "exact finite-dimensional certificate for the discharge schema", 
   "KernelStatus" -> "exact finite-dimensional certificate", 
   "SelectedStatus" -> "exact finite-dimensional certificate", 
   "ParityStatus" -> "exact finite-dimensional certificate"|>, 
 "TransverseReductionAudit" -> 
  <|"ReductionStatus" -> 
    "exact finite-dimensional certificate for the reduction schema", 
   "TransversalityStatus" -> "exact finite-dimensional certificate", 
   "QuotientStatus" -> "exact finite-dimensional certificate", 
   "ParityStatus" -> "exact finite-dimensional certificate"|>, 
 "ResidualBoundary" -> {"This remains an exact finite-dimensional \
certificate, not an abstract proof of the full UOM/Main theorem lane.", "The \
scalar bridge assumptions from theorem 1 remain imported, including the \
explicit c_Lambda != 0 gate.", "No later physical or reduced-welded quotient \
is certified automatically by this audit bundle."}, 
 "RawAudits" -> <|"DominantKernel" -> <|"UnderlyingDelayedReentryAudit" -> 
      <|"Model" -> <|"TransportModel" -> 
          <|"Name" -> "certified_polynomial_branch", "Parameter" -> 
            MainProof`ActiveTransport`Private`lambda$20596, 
           "Assumptions" -> 1 <= 
             MainProof`ActiveTransport`Private`lambda$20596 <= 3, 
           "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
            {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$20596}, 
           "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$20596, 
           "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
         "SplitModel" -> <|"Name" -> "uom_split_controlled_lift_contract", 
           "IntrinsicResponseContract" -> <|"Name" -> 
              "uom_intrinsic_response_contract_from_welded_boundary", 
             "BoundaryModel" -> <|"BoundaryAudit" -> <|"Model" -> 
                  <|"Channel" -> <|"Name" -> 
                      "uom_exact_welded_bandlocked_log_channel", "Lambda" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$20602, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$20602, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$20602, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$20602, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$20602, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$20602, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$20602 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$20602 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$20602 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$20602 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$20603, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20603}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20603, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$20602/
                         MainProof`UOMWeldedChannel`Private`lambda$20602, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$20602/
                         (MainProof`UOMWeldedChannel`Private`lambda$20602*
                          MainProof`UOMWeldedChannel`Private`v$20602)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20602]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20602] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20602], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20602] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20602] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$20602]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$20602/
                          MainProof`UOMWeldedChannel`Private`lambda$20602, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$20602/
                          (MainProof`UOMWeldedChannel`Private`v$20602*
                          MainProof`UOMWeldedChannel`Private`lambda$20602)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$20602], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$20602] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$20602]}]]\
|>, "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                     "Parameter" -> 
                      MainProof`ActiveTransport`Private`lambda$20603, 
                     "Assumptions" -> 1 <= 
                       MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                      {0, 0, 1 + 
                        MainProof`ActiveTransport`Private`lambda$20603}, 
                     "Nu" -> 1 + 
                       MainProof`ActiveTransport`Private`lambda$20603, 
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
                        MainProof`UOMFactPreservation`Private`kernel$20608[1, 
                          2]*MainProof`UOMFactPreservation`Private`r[1, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$20608[1, 
                          3]*MainProof`UOMFactPreservation`Private`r[1, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$20608[2, 
                          1]*MainProof`UOMFactPreservation`Private`r[2, 1], 
                        MainProof`UOMFactPreservation`Private`r[2, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$20608[2, 
                          3]*MainProof`UOMFactPreservation`Private`r[2, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$20608[3, 
                          1]*MainProof`UOMFactPreservation`Private`r[3, 1], 
                        MainProof`UOMFactPreservation`Private`kernel$20608[3, 
                          2]*MainProof`UOMFactPreservation`Private`r[3, 2], 
                        MainProof`UOMFactPreservation`Private`r[3, 3]}}, 
                     "AcceptedRecordState" -> 
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
                      MainProof`UOMWeldedChannel`Private`lambda$20715, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$20715, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$20715, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$20715, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$20715, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$20715, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$20715 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$20715 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$20715 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$20715 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$20716, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20716 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20716}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20716, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$20715/
                         MainProof`UOMWeldedChannel`Private`lambda$20715, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$20715/
                         (MainProof`UOMWeldedChannel`Private`lambda$20715*
                          MainProof`UOMWeldedChannel`Private`v$20715)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20715]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20715] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20715], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20715] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20715] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$20715]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$20715/
                          MainProof`UOMWeldedChannel`Private`lambda$20715, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$20715/
                          (MainProof`UOMWeldedChannel`Private`v$20715*
                          MainProof`UOMWeldedChannel`Private`lambda$20715)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$20715], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$20715] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$20715]}]]\
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
                         MainProof`UOMWeldedChannel`Private`tick$20715]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$20715] == 
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$20715], 
                       {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$20715] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$20715] == 
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega, 
                       MainProof`UOMWeldedChannel`Private`center$20715]], 
                   "CoCenteringStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar == 
                      MainProof`UOMWeldedChannel`Private`center$20715], 
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT == 
                       MainProof`UOMWeldedChannel`Private`alphaT$20715/
                        MainProof`UOMWeldedChannel`Private`lambda$20715, 
                      MainProof`UOMWeldedChannel`Private`sX == 
                       MainProof`UOMWeldedChannel`Private`alphaX$20715/
                        (MainProof`UOMWeldedChannel`Private`v$20715*
                         MainProof`UOMWeldedChannel`Private`lambda$20715)}], 
                   "BandLockScales" -> <|"s_t" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$20715/
                       MainProof`UOMWeldedChannel`Private`lambda$20715, 
                     "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$20715/
                       (MainProof`UOMWeldedChannel`Private`lambda$20715*
                        MainProof`UOMWeldedChannel`Private`v$20715)|>, 
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
                      MainProof`UOMWeldedChannel`Private`lambda$20722, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$20722, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$20722, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$20722, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$20722, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$20722, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$20722 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$20722 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$20722 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$20722 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$20723, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20723 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20723}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20723, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$20722/
                         MainProof`UOMWeldedChannel`Private`lambda$20722, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$20722/
                         (MainProof`UOMWeldedChannel`Private`lambda$20722*
                          MainProof`UOMWeldedChannel`Private`v$20722)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20722]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20722] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$20722], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20722] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$20722] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$20722]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$20722/
                          MainProof`UOMWeldedChannel`Private`lambda$20722, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$20722/
                          (MainProof`UOMWeldedChannel`Private`v$20722*
                          MainProof`UOMWeldedChannel`Private`lambda$20722)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$20722], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$20722] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$20722]}]]\
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
                      MainProof`UOMFactPreservation`Private`kernel$20729[1, 
                        2]*MainProof`UOMFactPreservation`Private`r[1, 2], 
                      MainProof`UOMFactPreservation`Private`kernel$20729[1, 
                        3]*MainProof`UOMFactPreservation`Private`r[1, 3]}, 
                     {MainProof`UOMFactPreservation`Private`kernel$20729[2, 
                        1]*MainProof`UOMFactPreservation`Private`r[2, 1], 
                      MainProof`UOMFactPreservation`Private`r[2, 2], 
                      MainProof`UOMFactPreservation`Private`kernel$20729[2, 
                        3]*MainProof`UOMFactPreservation`Private`r[2, 3]}, 
                     {MainProof`UOMFactPreservation`Private`kernel$20729[3, 
                        1]*MainProof`UOMFactPreservation`Private`r[3, 1], 
                      MainProof`UOMFactPreservation`Private`kernel$20729[3, 
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
                        MainProof`ActiveTransport`Private`lambda$20747, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20747 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20747}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20747, 
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
                        MainProof`ActiveTransport`Private`lambda$20755, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20755 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20755}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20755, 
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
                        MainProof`ActiveTransport`Private`lambda$20747, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20747 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20747}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20747, 
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
                        MainProof`ActiveTransport`Private`lambda$20755, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$20755 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$20755}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$20755, 
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
                 "Lambda" -> MainProof`UOMWeldedChannel`Private`lambda$20602, 
                 "vGeom" -> MainProof`UOMWeldedChannel`Private`v$20602, 
                 "AlphaTStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaT$20602, 
                 "AlphaXStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaX$20602, 
                 "Center" -> MainProof`UOMWeldedChannel`Private`center$20602, 
                 "Tick" -> MainProof`UOMWeldedChannel`Private`tick$20602, 
                 "DimB" -> 2, "Assumptions" -> 
                  MainProof`UOMWeldedChannel`Private`lambda$20602 > 0 && 
                   MainProof`UOMWeldedChannel`Private`v$20602 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaT$20602 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaX$20602 > 0, 
                 "TransportModel" -> <|"Name" -> 
                    "certified_polynomial_branch", "Parameter" -> 
                    MainProof`ActiveTransport`Private`lambda$20603, 
                   "Assumptions" -> 1 <= 
                     MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                    {0, 0, 1 + 
                      MainProof`ActiveTransport`Private`lambda$20603}, 
                   "Nu" -> 1 + 
                     MainProof`ActiveTransport`Private`lambda$20603, 
                   "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                 "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                  <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$20602/
                     MainProof`UOMWeldedChannel`Private`lambda$20602, 
                   "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$20602/
                     (MainProof`UOMWeldedChannel`Private`lambda$20602*
                      MainProof`UOMWeldedChannel`Private`v$20602)|>, 
                 "TemporalWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`CapitalSigma][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$20602]*
                     MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`sigmaT][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$20602] == 
                    D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                        MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                         MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$20602], 
                     {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                 "SpatialWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`LoG[
                       MainProof`UOMWeldedChannel`Private`rho][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$20602] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                       MainProof`UOMWeldedChannel`Private`sigmaX][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$20602] == 
                    MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                       MainProof`UOMWeldedChannel`Private`rho^2 + 
                        MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                     MainProof`UOMWeldedChannel`Private`Omega, 
                     MainProof`UOMWeldedChannel`Private`center$20602]], 
                 "BandLockStatement" -> HoldForm[
                   {MainProof`UOMWeldedChannel`Private`sT == 
                     MainProof`UOMWeldedChannel`Private`alphaT$20602/
                      MainProof`UOMWeldedChannel`Private`lambda$20602, 
                    MainProof`UOMWeldedChannel`Private`sX == 
                     MainProof`UOMWeldedChannel`Private`alphaX$20602/
                      (MainProof`UOMWeldedChannel`Private`v$20602*
                       MainProof`UOMWeldedChannel`Private`lambda$20602)}], 
                 "CenterLockStatement" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`OmegaStar == 
                    MainProof`UOMWeldedChannel`Private`center$20602], 
                 "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 
                  0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                 "CompressedChannelStatement" -> HoldForm[
                   Subscript[MainProof`UOMWeldedChannel`Private`H, 
                      MainProof`UOMWeldedChannel`Private`LoG][
                     MainProof`UOMWeldedChannel`Private`lambda$20602] == 
                    Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                       MainProof`UOMWeldedChannel`Private`lambda$20602]}]]|>, 
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                 "Parameter" -> 
                  MainProof`ActiveTransport`Private`lambda$20603, 
                 "Assumptions" -> 1 <= 
                   MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                  {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$20603}, 
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$20603, 
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
                MainProof`UOMWeldedChannel`Private`lambda$20602, "vGeom" -> 
                MainProof`UOMWeldedChannel`Private`v$20602, "AlphaTStar" -> 
                MainProof`UOMWeldedChannel`Private`alphaT$20602, 
               "AlphaXStar" -> 
                MainProof`UOMWeldedChannel`Private`alphaX$20602, "Center" -> 
                MainProof`UOMWeldedChannel`Private`center$20602, "Tick" -> 
                MainProof`UOMWeldedChannel`Private`tick$20602, "DimB" -> 
                2, "Assumptions" -> 
                MainProof`UOMWeldedChannel`Private`lambda$20602 > 0 && 
                 MainProof`UOMWeldedChannel`Private`v$20602 > 0 && 
                 MainProof`UOMWeldedChannel`Private`alphaT$20602 > 0 && 
                 MainProof`UOMWeldedChannel`Private`alphaX$20602 > 0, 
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                 "Parameter" -> 
                  MainProof`ActiveTransport`Private`lambda$20603, 
                 "Assumptions" -> 1 <= 
                   MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                  {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$20603}, 
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$20603, 
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
               "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$20602/
                   MainProof`UOMWeldedChannel`Private`lambda$20602, 
                 "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$20602/
                   (MainProof`UOMWeldedChannel`Private`lambda$20602*
                    MainProof`UOMWeldedChannel`Private`v$20602)|>, 
               "TemporalWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`CapitalSigma][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$20602]*
                   MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`sigmaT][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$20602] == 
                  D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                      MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                       MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$20602], 
                   {MainProof`UOMWeldedChannel`Private`t, 2}]], 
               "SpatialWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`LoG[
                     MainProof`UOMWeldedChannel`Private`rho][
                    MainProof`UOMWeldedChannel`Private`Omega, 
                    MainProof`UOMWeldedChannel`Private`center$20602] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                     MainProof`UOMWeldedChannel`Private`sigmaX][
                    MainProof`UOMWeldedChannel`Private`Omega, 
                    MainProof`UOMWeldedChannel`Private`center$20602] == 
                  MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                     MainProof`UOMWeldedChannel`Private`rho^2 + 
                      MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                   MainProof`UOMWeldedChannel`Private`Omega, 
                   MainProof`UOMWeldedChannel`Private`center$20602]], 
               "BandLockStatement" -> HoldForm[
                 {MainProof`UOMWeldedChannel`Private`sT == 
                   MainProof`UOMWeldedChannel`Private`alphaT$20602/
                    MainProof`UOMWeldedChannel`Private`lambda$20602, 
                  MainProof`UOMWeldedChannel`Private`sX == 
                   MainProof`UOMWeldedChannel`Private`alphaX$20602/
                    (MainProof`UOMWeldedChannel`Private`v$20602*
                     MainProof`UOMWeldedChannel`Private`lambda$20602)}], 
               "CenterLockStatement" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`OmegaStar == 
                  MainProof`UOMWeldedChannel`Private`center$20602], 
               "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 0}, 
                {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
               "CompressedChannelStatement" -> HoldForm[
                 Subscript[MainProof`UOMWeldedChannel`Private`H, 
                    MainProof`UOMWeldedChannel`Private`LoG][
                   MainProof`UOMWeldedChannel`Private`lambda$20602] == 
                  Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                     MainProof`UOMWeldedChannel`Private`lambda$20602]}]]|>, 
             "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
               "Parameter" -> MainProof`ActiveTransport`Private`lambda$20603, 
               "Assumptions" -> 1 <= 
                 MainProof`ActiveTransport`Private`lambda$20603 <= 3, 
               "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$20603}, 
               "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$20603, 
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
            MainProof`DelayedDescendantReentryAudit`Private`alphaPrime$23278 \
-> 1, MainProof`DelayedDescendantReentryAudit`Private`dLambda$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`stock$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`alpha$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`eta$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`gcl$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`dI$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`zeta$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`a0$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`lam$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`rabs$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`kappa$23278 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`c0$23278 -> 0}}, 
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
descendant representative modulo Aminus" -> <|"Status" -> 
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
from split-controlled localization alone."}|>, 
     "UnderlyingTransversalityAudit" -> <|"UnderlyingDelayedReentryAudit" -> 
        <|"Model" -> <|"TransportModel" -> <|"Name" -> 
              "certified_polynomial_branch", "Parameter" -> 
              MainProof`ActiveTransport`Private`lambda$27010, 
             "Assumptions" -> 1 <= 
               MainProof`ActiveTransport`Private`lambda$27010 <= 3, 
             "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
              {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$27010}, 
             "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$27010, 
             "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
           "SplitModel" -> <|"Name" -> "uom_split_controlled_lift_contract", 
             "IntrinsicResponseContract" -> <|"Name" -> 
                "uom_intrinsic_response_contract_from_welded_boundary", 
               "BoundaryModel" -> <|"BoundaryAudit" -> <|"Model" -> 
                    <|"Channel" -> <|"Name" -> 
                        "uom_exact_welded_bandlocked_log_channel", 
                       "Lambda" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27016, 
                       "vGeom" -> MainProof`UOMWeldedChannel`Private`v$27016, 
                       "AlphaTStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$27016, 
                       "AlphaXStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$27016, 
                       "Center" -> 
                        MainProof`UOMWeldedChannel`Private`center$27016, 
                       "Tick" -> 
                        MainProof`UOMWeldedChannel`Private`tick$27016, 
                       "DimB" -> 2, "Assumptions" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27016 > 
                          0 && MainProof`UOMWeldedChannel`Private`v$27016 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaT$27016 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaX$27016 > 0, 
                       "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27017, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27017 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27017}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27017, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                       "BandLockScales" -> <|"s_t" -> 
                          MainProof`UOMWeldedChannel`Private`alphaT$27016/
                          MainProof`UOMWeldedChannel`Private`lambda$27016, 
                         "s_x" -> 
                          MainProof`UOMWeldedChannel`Private`alphaX$27016/
                          (MainProof`UOMWeldedChannel`Private`lambda$27016*
                          MainProof`UOMWeldedChannel`Private`v$27016)|>, 
                       "TemporalWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27016]*
                          MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27016] == 
                          D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27016], 
                          {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                       "SpatialWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27016] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27016] == 
                          MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27016]], 
                       "BandLockStatement" -> HoldForm[
                         {MainProof`UOMWeldedChannel`Private`sT == 
                          MainProof`UOMWeldedChannel`Private`alphaT$27016/
                          MainProof`UOMWeldedChannel`Private`lambda$27016, 
                          MainProof`UOMWeldedChannel`Private`sX == 
                          MainProof`UOMWeldedChannel`Private`alphaX$27016/
                          (MainProof`UOMWeldedChannel`Private`v$27016*
                          MainProof`UOMWeldedChannel`Private`lambda$27016)}], 
                       "CenterLockStatement" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`OmegaStar == 
                          MainProof`UOMWeldedChannel`Private`center$27016], 
                       "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                        {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                       "CompressedChannelStatement" -> HoldForm[
                         Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                          MainProof`UOMWeldedChannel`Private`lambda$27016] == 
                          Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$27016]}]]\
|>, "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                       "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$27017, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$27017 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27017}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$27017, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}}, 
                     "AminusBoundaryImages" -> {{{0, 0}, {0, 0}}, {{0, 0}, 
                        {0, 0}}}, "RepresentativeBoundaryImage" -> {{1, 0}, 
                       {0, 0}}, "FactPreservationAudit" -> <|"Dimension" -> 
                        3, "SymbolicState" -> 
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
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          1, 2]*MainProof`UOMFactPreservation`Private`r[1, 
                          2], 
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          1, 3]*MainProof`UOMFactPreservation`Private`r[1, 
                          3]}, {
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          2, 1]*MainProof`UOMFactPreservation`Private`r[2, 
                          1], MainProof`UOMFactPreservation`Private`r[2, 2], 
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          2, 3]*MainProof`UOMFactPreservation`Private`r[2, 
                          3]}, {
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          3, 1]*MainProof`UOMFactPreservation`Private`r[3, 
                          1], 
                          MainProof`UOMFactPreservation`Private`kernel$27020[
                          3, 2]*MainProof`UOMFactPreservation`Private`r[3, 
                          2], MainProof`UOMFactPreservation`Private`r[3, 
                          3]}}, "AcceptedRecordState" -> 
                        {{MainProof`UOMFactPreservation`Private`r[1, 1], 0, 
                          0}, {0, MainProof`UOMFactPreservation`Private`r[2, 
                          2], 0}, {0, 0, 
                          MainProof`UOMFactPreservation`Private`r[3, 3]}}, 
                       "Claims" -> <|"Accepted record projection preserves \
all record expectations exactly" -> <|"Status" -> 
                          "exact finite-dimensional certificate", 
                          "Certified" -> True|>, "Commuting QND tick fixes \
the accepted record state" -> <|"Status" -> 
                          "exact finite-dimensional certificate", 
                          "Certified" -> True|>, "Accepted record projection \
is the exact conditional expectation onto the diagonal record algebra" -> 
                          <|"Status" -> 
                          "exact finite-dimensional certificate", 
                          "Certified" -> True|>|>|>|>, "Claims" -> 
                    <|"Transported ambiguity vanishes on the exact welded \
boundary channel" -> <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Boundary image of the class \
representative is the nonzero epsilon-weighted welded LoG line" -> 
                      <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Exact sub-cutoff fact \
preservation is enforced on the accepted record algebra" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Old visible ambiguity witness \
is excluded by UOM welded/fact-preserving constraints" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>|>|>, "PulseAudit" -> 
                  <|"Contract" -> <|"Name" -> 
                      "uom_exact_welded_pulse_contract", "ChannelData" -> 
                      <|"Name" -> "uom_exact_welded_bandlocked_log_channel", 
                       "Lambda" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27094, 
                       "vGeom" -> MainProof`UOMWeldedChannel`Private`v$27094, 
                       "AlphaTStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$27094, 
                       "AlphaXStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$27094, 
                       "Center" -> 
                        MainProof`UOMWeldedChannel`Private`center$27094, 
                       "Tick" -> 
                        MainProof`UOMWeldedChannel`Private`tick$27094, 
                       "DimB" -> 2, "Assumptions" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27094 > 
                          0 && MainProof`UOMWeldedChannel`Private`v$27094 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaT$27094 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaX$27094 > 0, 
                       "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27095, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27095 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27095}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27095, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                       "BandLockScales" -> <|"s_t" -> 
                          MainProof`UOMWeldedChannel`Private`alphaT$27094/
                          MainProof`UOMWeldedChannel`Private`lambda$27094, 
                         "s_x" -> 
                          MainProof`UOMWeldedChannel`Private`alphaX$27094/
                          (MainProof`UOMWeldedChannel`Private`lambda$27094*
                          MainProof`UOMWeldedChannel`Private`v$27094)|>, 
                       "TemporalWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094]*
                          MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094] == 
                          D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094], 
                          {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                       "SpatialWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27094] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27094] == 
                          MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27094]], 
                       "BandLockStatement" -> HoldForm[
                         {MainProof`UOMWeldedChannel`Private`sT == 
                          MainProof`UOMWeldedChannel`Private`alphaT$27094/
                          MainProof`UOMWeldedChannel`Private`lambda$27094, 
                          MainProof`UOMWeldedChannel`Private`sX == 
                          MainProof`UOMWeldedChannel`Private`alphaX$27094/
                          (MainProof`UOMWeldedChannel`Private`v$27094*
                          MainProof`UOMWeldedChannel`Private`lambda$27094)}], 
                       "CenterLockStatement" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`OmegaStar == 
                          MainProof`UOMWeldedChannel`Private`center$27094], 
                       "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                        {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                       "CompressedChannelStatement" -> HoldForm[
                         Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                          MainProof`UOMWeldedChannel`Private`lambda$27094] == 
                          Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$27094]}]]\
|>, "TemporalMacroMicroCompilation" -> HoldForm[
                       MainProof`UOMPulseCharacterization`Private`DoGTemporal[
                          MainProof`UOMPulseCharacterization`Private`sigmaMac\
roT, MainProof`UOMPulseCharacterization`Private`sigmaMicroT][
                         MainProof`UOMPulseCharacterization`Private`t - 
                          MainProof`UOMPulseCharacterization`Private`tick] == 
                        MainProof`UOMPulseCharacterization`Private`LoG[
                          Sqrt[MainProof`UOMPulseCharacterization`Private`sig\
maMacroT^2 + MainProof`UOMPulseCharacterization`Private`sigmaMicroT^2]][
                         MainProof`UOMPulseCharacterization`Private`t - 
                          MainProof`UOMPulseCharacterization`Private`tick]], 
                     "SpatialMacroMicroCompilation" -> HoldForm[
                       MainProof`UOMPulseCharacterization`Private`DoGSpatial[
                          MainProof`UOMPulseCharacterization`Private`rhoMacro\
, MainProof`UOMPulseCharacterization`Private`rhoMicro][
                         MainProof`UOMPulseCharacterization`Private`Omega, 
                         MainProof`UOMPulseCharacterization`Private`center] \
== MainProof`UOMPulseCharacterization`Private`LoG[Sqrt[
                          MainProof`UOMPulseCharacterization`Private`rhoMacro^
                          2 + 
                          MainProof`UOMPulseCharacterization`Private`rhoMicro^
                          2]][
                         MainProof`UOMPulseCharacterization`Private`Omega, 
                         MainProof`UOMPulseCharacterization`Private`center]], 
                     "QuadratureWidthCombination" -> <|"Temporal" -> HoldForm[
                         MainProof`UOMPulseCharacterization`Private`sWeldT == 
                          Sqrt[MainProof`UOMPulseCharacterization`Private`sig\
maMacroT^2 + MainProof`UOMPulseCharacterization`Private`sigmaMicroT^2]], 
                       "Spatial" -> HoldForm[
                         MainProof`UOMPulseCharacterization`Private`rhoWeld \
== Sqrt[MainProof`UOMPulseCharacterization`Private`rhoMacro^2 + 
                          MainProof`UOMPulseCharacterization`Private`rhoMicro^
                          2]]|>, "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27094], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27094] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27094] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$27094]], 
                     "CoCenteringStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$27094], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$27094/
                          MainProof`UOMWeldedChannel`Private`lambda$27094, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$27094/
                          (MainProof`UOMWeldedChannel`Private`v$27094*
                          MainProof`UOMWeldedChannel`Private`lambda$27094)}], 
                     "BandLockScales" -> <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$27094/
                         MainProof`UOMWeldedChannel`Private`lambda$27094, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$27094/
                         (MainProof`UOMWeldedChannel`Private`lambda$27094*
                          MainProof`UOMWeldedChannel`Private`v$27094)|>, 
                     "CompressedLineProjector" -> {{1, 0}, {0, 0}}, 
                     "CompressedLineDimension" -> 1|>, "Claims" -> 
                    <|"Welded LoG shape is compiled exactly from macro/micro \
DoG data" -> <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, 
                     "Welded pulse is exactly co-centered" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>, 
                     "Receiver band-lock fixes the welded widths exactly" -> 
                      <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, 
                     "Compressed welded image is rank-one" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>|>|>, "AcceptedChannelAudit" -> 
                  <|"Contract" -> <|"Name" -> 
                      "uom_exact_accepted_channel_contract", "ChannelData" -> 
                      <|"Name" -> "uom_exact_welded_bandlocked_log_channel", 
                       "Lambda" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27101, 
                       "vGeom" -> MainProof`UOMWeldedChannel`Private`v$27101, 
                       "AlphaTStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$27101, 
                       "AlphaXStar" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$27101, 
                       "Center" -> 
                        MainProof`UOMWeldedChannel`Private`center$27101, 
                       "Tick" -> 
                        MainProof`UOMWeldedChannel`Private`tick$27101, 
                       "DimB" -> 2, "Assumptions" -> 
                        MainProof`UOMWeldedChannel`Private`lambda$27101 > 
                          0 && MainProof`UOMWeldedChannel`Private`v$27101 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaT$27101 > 
                          0 && 
                         MainProof`UOMWeldedChannel`Private`alphaX$27101 > 0, 
                       "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27102, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27102 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27102}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27102, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                       "BandLockScales" -> <|"s_t" -> 
                          MainProof`UOMWeldedChannel`Private`alphaT$27101/
                          MainProof`UOMWeldedChannel`Private`lambda$27101, 
                         "s_x" -> 
                          MainProof`UOMWeldedChannel`Private`alphaX$27101/
                          (MainProof`UOMWeldedChannel`Private`lambda$27101*
                          MainProof`UOMWeldedChannel`Private`v$27101)|>, 
                       "TemporalWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27101]*
                          MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27101] == 
                          D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$27101], 
                          {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                       "SpatialWeldedForm" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27101] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27101] == 
                          MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$27101]], 
                       "BandLockStatement" -> HoldForm[
                         {MainProof`UOMWeldedChannel`Private`sT == 
                          MainProof`UOMWeldedChannel`Private`alphaT$27101/
                          MainProof`UOMWeldedChannel`Private`lambda$27101, 
                          MainProof`UOMWeldedChannel`Private`sX == 
                          MainProof`UOMWeldedChannel`Private`alphaX$27101/
                          (MainProof`UOMWeldedChannel`Private`v$27101*
                          MainProof`UOMWeldedChannel`Private`lambda$27101)}], 
                       "CenterLockStatement" -> HoldForm[
                         MainProof`UOMWeldedChannel`Private`OmegaStar == 
                          MainProof`UOMWeldedChannel`Private`center$27101], 
                       "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                        {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                       "CompressedChannelStatement" -> HoldForm[
                         Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                          MainProof`UOMWeldedChannel`Private`lambda$27101] == 
                          Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$27101]}]]\
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
                       0}, {0, 0, 0}, {0, 0, 1}}}, "UpliftIsometry" -> {{1, 
                      0, 0}, {0, 0, 0}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}, {0, 
                      0, 0}}, "AcceptedTickDimension" -> 3|>, 
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
                        MainProof`UOMFactPreservation`Private`kernel$27108[1, 
                          2]*MainProof`UOMFactPreservation`Private`r[1, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$27108[1, 
                          3]*MainProof`UOMFactPreservation`Private`r[1, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$27108[2, 
                          1]*MainProof`UOMFactPreservation`Private`r[2, 1], 
                        MainProof`UOMFactPreservation`Private`r[2, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$27108[2, 
                          3]*MainProof`UOMFactPreservation`Private`r[2, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$27108[3, 
                          1]*MainProof`UOMFactPreservation`Private`r[3, 1], 
                        MainProof`UOMFactPreservation`Private`kernel$27108[3, 
                          2]*MainProof`UOMFactPreservation`Private`r[3, 2], 
                        MainProof`UOMFactPreservation`Private`r[3, 3]}}, 
                     "AcceptedRecordState" -> 
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
                         "Certified" -> True|>|>|>, 
                   "RecordBreakingWitness" -> <|"InputState" -> {{1, 0}, {0, 
                      0}}, "BrokenTickImage" -> {{0, 0}, {0, 1}}|>, 
                   "Claims" -> <|"Accepted welded channel factorizes exactly \
through the compiled descended scalar" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>, 
                     "Accepted uplift surrogate is an exact isometry" -> 
                      <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Accepted tick surrogate is \
exactly CPTP at finite cutoff" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Accepted record sector is \
preserved exactly and breaks under the intentional ablation" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>|>|>, "ActionSelectionAudit" -> 
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
                      {<|"Name" -> "welded_rank1_selected", "P3Action" -> 
                         1/5, "SKInfluence" -> 1/7, "CompressedRank" -> 1, 
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
                       "AcceptedRecordPreservationQ" -> True, 
                       "GaussianData" -> <|"DriveWidth" -> 1/3, 
                         "SqueezeWidth" -> 1/4|>|>, "MinimalP3Action" -> 1/5, 
                     "MinimalSKInfluenceWithinP3" -> 1/7|>, "Claims" -> 
                    <|
                     "P3 least-action admissibility selects the welded \
family" -> <|"Status" -> "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "SK least-influence selection \
picks the admissible Gaussian welded family" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>, "Selected welded family is \
rank-one and descended-scalar factorized" -> <|"Status" -> 
                        "exact finite-dimensional certificate", 
                       "Certified" -> True|>|>|>, "LegacyTransportedAudit" -> 
                  <|"WeakInterface" -> <|"Tick" -> 1, "Eminus" -> 
                      <|"Dimension" -> 3, "Parity" -> "Odd"|>, "Aminus" -> 
                      {{1, 0}, {0, 1}, {0, 0}}, "XiClass" -> 
                      <|"Representative" -> {0, 0, 1}, "Basis" -> {{1, 0}, 
                         {0, 1}, {0, 0}}|>, "J0" -> {0, 0, 1}, "Chi" -> 
                      {0, 0, 1}, "Epsilon" -> 1, "B" -> {{1, 0, 0}, {0, 1, 
                      0}, {0, 0, 1}}, "Ochar" -> <|"Name" -> 
                        "CertifiedTransportedWeakInterface", "SourceModel" -> 
                        "certified_polynomial_branch"|>, 
                     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>, 
                   "Realizations" -> <|"TransportedSafeFamily" -> 
                      <|"Name" -> "transported_safe_2x2", "DimA" -> 2, 
                       "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 
                         0}, {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 
                         0}}, {{0, 1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, 
                         {0, 1}}}, "NullIdealBasisB" -> {}, "SplitBlocks" -> 
                        {{{1, 0}, {0, 1}}, {{0, 1}, {1, 0}}}, 
                       "SplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 
                        0, 1}, {0, 0, 1, 0}}, "JOperator" -> {{0, 1, 0, 0}, 
                        {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "AmbiguityOperator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, 
                        {0, 0, 0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> 
                        {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                         0}}, {{0, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 
                         0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}, {0, 0, 0, 1}}}, "WitnessObservable" -> 
                        {{1, 0, 0, 0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                        0}}, "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, 
                        {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "Metadata" -> <|"BoundarySectorType" -> "controlled", 
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
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                         "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> 
                          <|"Name" -> "CertifiedTransportedWeakInterface", 
                          "SourceModel" -> "certified_polynomial_branch"|>, 
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 
                          1|>|>, "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27126, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27126 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27126}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27126, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}}, 
                       "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0, 
                         1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 
                         0, 0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}}, 
                       "EminusBasisImages" -> {{{0, 0, 1, 0}, {0, 0, 0, 1}, 
                         {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 
                         0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}, {{0, 1, 0, 0}, 
                         {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>, 
                     "TransportedUnsafeFamily" -> <|"Name" -> 
                        "transported_unsafe_2x2", "DimA" -> 2, "DimB" -> 2, 
                       "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}}, 
                       "ControlledBasisB" -> {{{1, 0}, {0, 0}}, {{0, 1}, {0, 
                         0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}}, 
                       "NullIdealBasisB" -> {}, "SplitBlocks" -> {{{1, 0}, 
                         {0, 1}}, {{0, 1}, {1, 0}}}, "SplitUnitary" -> {{1, 
                        0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}}, 
                       "JOperator" -> {{0, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 
                        0}, {0, 0, 0, 0}}, "AmbiguityOperator" -> {{1, 0, 0, 
                        0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "ClassicalStates" -> {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 1, 0, 
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 
                         0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 
                         0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}}}, 
                       "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0, 0}, 
                        {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 
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
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                         "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> 
                          <|"Name" -> "CertifiedTransportedWeakInterface", 
                          "SourceModel" -> "certified_polynomial_branch"|>, 
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 
                          1|>|>, "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27134, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27134 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27134}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27134, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}}, 
                       "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 
                         0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, 
                         {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}}, 
                       "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0}, 
                         {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 
                         0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, 
                         {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>|>, 
                   "AuditsByCandidate" -> <|"readout-kernel" -> 
                      <|"TransportedSafeFamily" -> <|"RealizationName" -> 
                          "transported_safe_2x2", "CandidateName" -> 
                          "readout-kernel", "WeakInterface" -> <|"Tick" -> 1, 
                          "Eminus" -> <|"Dimension" -> 3, "Parity" -> 
                          "Odd"|>, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                          "XiClass" -> <|"Representative" -> {0, 0, 1}, 
                          "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                          "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, 
                          "Ochar" -> <|"Name" -> 
                          "CertifiedTransportedWeakInterface", 
                          "SourceModel" -> "certified_polynomial_branch"|>, 
                          "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 
                          1|>|>, "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 
                          0}}, "BasisOperatorAudits" -> 
                          {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
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
                          "Eminus" -> <|"Dimension" -> 3, "Parity" -> 
                          "Odd"|>, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                          "XiClass" -> <|"Representative" -> {0, 0, 1}, 
                          "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                          "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, 
                          "Ochar" -> <|"Name" -> 
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
                          {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
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
                          "block-trace-zero", "WeakInterface" -> <|"Tick" -> 
                          1, "Eminus" -> <|"Dimension" -> 3, "Parity" -> 
                          "Odd"|>, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                          "XiClass" -> <|"Representative" -> {0, 0, 1}, 
                          "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                          "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, 
                          "Ochar" -> <|"Name" -> 
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
                          {<|"ControlledProjection" -> {{0, 0, 0, 0}, {0, 0, 
                          0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
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
                          "state-invisible", "WeakInterface" -> <|"Tick" -> 
                          1, "Eminus" -> <|"Dimension" -> 3, "Parity" -> 
                          "Odd"|>, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                          "XiClass" -> <|"Representative" -> {0, 0, 1}, 
                          "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                          "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, 
                          "Ochar" -> <|"Name" -> 
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
                         0}, {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 
                         0}}, {{0, 1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, 
                         {0, 1}}}, "NullIdealBasisB" -> {}, "SplitBlocks" -> 
                        {{{1, 0}, {0, 1}}, {{0, 1}, {1, 0}}}, 
                       "SplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 
                        0, 1}, {0, 0, 1, 0}}, "JOperator" -> {{0, 1, 0, 0}, 
                        {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "AmbiguityOperator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, 
                        {0, 0, 0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> 
                        {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                         0}}, {{0, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 
                         0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}, {0, 0, 0, 1}}}, "WitnessObservable" -> 
                        {{1, 0, 0, 0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                        0}}, "AmbiguityWitnessObservable" -> {{1, 0, 0, 0}, 
                        {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "Metadata" -> <|"BoundarySectorType" -> "controlled", 
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
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                         "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> 
                          <|"Name" -> "CertifiedTransportedWeakInterface", 
                          "SourceModel" -> "certified_polynomial_branch"|>, 
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 
                          1|>|>, "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27126, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27126 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27126}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27126, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}}, 
                       "AmbiguityBasisOperators" -> {{{0, 0, 1, 0}, {0, 0, 0, 
                         1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 
                         0, 0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}}, 
                       "EminusBasisImages" -> {{{0, 0, 1, 0}, {0, 0, 0, 1}, 
                         {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 
                         0, 0}, {1, 0, 0, 0}, {0, 1, 0, 0}}, {{0, 1, 0, 0}, 
                         {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>, 
                     "ReadoutKernelAudit" -> <|"RealizationName" -> 
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
                     "StateInvisibleAudit" -> <|"RealizationName" -> 
                        "transported_safe_2x2", "CandidateName" -> 
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
                       "ExpectationOnlyBasisIndices" -> {}|>|>, 
                   "TransportedUnsafeWitness" -> <|"Realization" -> 
                      <|"Name" -> "transported_unsafe_2x2", "DimA" -> 2, 
                       "DimB" -> 2, "ProjectorsA" -> {{{1, 0}, {0, 0}}, {{0, 
                         0}, {0, 1}}}, "ControlledBasisB" -> {{{1, 0}, {0, 
                         0}}, {{0, 1}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, 
                         {0, 1}}}, "NullIdealBasisB" -> {}, "SplitBlocks" -> 
                        {{{1, 0}, {0, 1}}, {{0, 1}, {1, 0}}}, 
                       "SplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 
                        0, 1}, {0, 0, 1, 0}}, "JOperator" -> {{0, 1, 0, 0}, 
                        {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "AmbiguityOperator" -> {{1, 0, 0, 0}, {0, -1, 0, 0}, 
                        {0, 0, 0, 0}, {0, 0, 0, 0}}, "ClassicalStates" -> 
                        {{{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                         0}}, {{0, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 1, 
                         0}, {0, 0, 0, 0}}, {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 
                         0, 0, 0}, {0, 0, 0, 1}}}, "WitnessObservable" -> 
                        {{0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
                        0}}, "AmbiguityWitnessObservable" -> {{0, 1, 0, 0}, 
                        {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
                       "Metadata" -> <|"BoundarySectorType" -> "controlled", 
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
                          1}, "Basis" -> {{1, 0}, {0, 1}, {0, 0}}|>, "J0" -> 
                          {0, 0, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, 
                         "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "Ochar" -> 
                          <|"Name" -> "CertifiedTransportedWeakInterface", 
                          "SourceModel" -> "certified_polynomial_branch"|>, 
                         "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 
                          1|>|>, "TransportModel" -> <|"Name" -> 
                          "certified_polynomial_branch", "Parameter" -> 
                          MainProof`ActiveTransport`Private`lambda$27134, 
                         "Assumptions" -> 1 <= 
                          MainProof`ActiveTransport`Private`lambda$27134 <= 
                          3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, 
                         "RhoDom" -> {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$27134}, 
                         "Nu" -> 1 + 
                          MainProof`ActiveTransport`Private`lambda$27134, 
                         "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                       "AminusBasisVectors" -> {{1, 0, 0}, {0, 1, 0}}, 
                       "AmbiguityBasisOperators" -> {{{1, 0, 0, 0}, {0, -1, 
                         0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, 
                         {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}}, 
                       "EminusBasisImages" -> {{{1, 0, 0, 0}, {0, -1, 0, 0}, 
                         {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 0, 1, 0}, {0, 0, 
                         0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{0, 1, 0, 0}, 
                         {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>, 
                     "ReadoutKernelAudit" -> <|"RealizationName" -> 
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
                       "ExpectationOnlyBasisIndices" -> {}|>, 
                     "StateInvisibleAudit" -> <|"RealizationName" -> 
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
                       "ExpectationOnlyBasisIndices" -> {}|>|>, 
                   "WeakestAdditionalHypothesis" -> "Each boundary \
realization of a transported ambiguity basis vector must have vanishing \
controlled projection, or block-central controlled B-blocks modulo a \
nontrivial boundary null ideal that remains stable and does not trivialize \
the controlled dynamics.", "ForcedByTransportStructureQ" -> False|>, 
                 "Channel" -> <|"Name" -> 
                    "uom_exact_welded_bandlocked_log_channel", "Lambda" -> 
                    MainProof`UOMWeldedChannel`Private`lambda$27016, 
                   "vGeom" -> MainProof`UOMWeldedChannel`Private`v$27016, 
                   "AlphaTStar" -> 
                    MainProof`UOMWeldedChannel`Private`alphaT$27016, 
                   "AlphaXStar" -> 
                    MainProof`UOMWeldedChannel`Private`alphaX$27016, 
                   "Center" -> 
                    MainProof`UOMWeldedChannel`Private`center$27016, 
                   "Tick" -> MainProof`UOMWeldedChannel`Private`tick$27016, 
                   "DimB" -> 2, "Assumptions" -> 
                    MainProof`UOMWeldedChannel`Private`lambda$27016 > 0 && 
                     MainProof`UOMWeldedChannel`Private`v$27016 > 0 && 
                     MainProof`UOMWeldedChannel`Private`alphaT$27016 > 0 && 
                     MainProof`UOMWeldedChannel`Private`alphaX$27016 > 0, 
                   "TransportModel" -> <|"Name" -> 
                      "certified_polynomial_branch", "Parameter" -> 
                      MainProof`ActiveTransport`Private`lambda$27017, 
                     "Assumptions" -> 1 <= 
                       MainProof`ActiveTransport`Private`lambda$27017 <= 3, 
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                      {0, 0, 1 + 
                        MainProof`ActiveTransport`Private`lambda$27017}, 
                     "Nu" -> 1 + 
                       MainProof`ActiveTransport`Private`lambda$27017, 
                     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                   "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                    <|"s_t" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$27016/
                       MainProof`UOMWeldedChannel`Private`lambda$27016, 
                     "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$27016/
                       (MainProof`UOMWeldedChannel`Private`lambda$27016*
                        MainProof`UOMWeldedChannel`Private`v$27016)|>, 
                   "TemporalWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`CapitalSigma][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$27016]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$27016] == 
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$27016], 
                       {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$27016] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$27016] == 
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega, 
                       MainProof`UOMWeldedChannel`Private`center$27016]], 
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT == 
                       MainProof`UOMWeldedChannel`Private`alphaT$27016/
                        MainProof`UOMWeldedChannel`Private`lambda$27016, 
                      MainProof`UOMWeldedChannel`Private`sX == 
                       MainProof`UOMWeldedChannel`Private`alphaX$27016/
                        (MainProof`UOMWeldedChannel`Private`v$27016*
                         MainProof`UOMWeldedChannel`Private`lambda$27016)}], 
                   "CenterLockStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar == 
                      MainProof`UOMWeldedChannel`Private`center$27016], 
                   "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 
                    0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                   "CompressedChannelStatement" -> HoldForm[
                     Subscript[MainProof`UOMWeldedChannel`Private`H, 
                        MainProof`UOMWeldedChannel`Private`LoG][
                       MainProof`UOMWeldedChannel`Private`lambda$27016] == 
                      Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                         MainProof`UOMWeldedChannel`Private`lambda$27016]}]]|>\
, "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                   "Parameter" -> 
                    MainProof`ActiveTransport`Private`lambda$27017, 
                   "Assumptions" -> 1 <= 
                     MainProof`ActiveTransport`Private`lambda$27017 <= 3, 
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                    {0, 0, 1 + 
                      MainProof`ActiveTransport`Private`lambda$27017}, 
                   "Nu" -> 1 + 
                     MainProof`ActiveTransport`Private`lambda$27017, 
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
                     "B" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "J0" -> {1, 
                      -1, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "GA" -> 
                      {{1, 0}, {0, 1}}, "LinearTerm" -> {-1, 1}, "aStar" -> 
                      {-1, 1}, "Jcan" -> {0, 0, 1}, "Projector" -> {{1, 0, 
                      0}, {0, 1, 0}, {0, 0, 0}}|>, "Calibration2" -> 
                    <|"U" -> {{1, 0}, {0, 1}, {0, 0}}, "B" -> {{2, 0, 1}, 
                       {0, 3, 1}, {1, 1, 5}}, "J0" -> {1, -1, 1}, "Chi" -> 
                      {0, 0, 1}, "Epsilon" -> 1, "GA" -> {{2, 0}, {0, 3}}, 
                     "LinearTerm" -> {-3, 2}, "aStar" -> {-3/2, 2/3}, 
                     "Jcan" -> {-1/2, -1/3, 1}, "Projector" -> {{1, 0, 1/2}, 
                       {0, 1, 1/3}, {0, 0, 0}}|>, "CalibrationMatrices" -> 
                    <|"B1" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "B2" -> 
                      {{2, 0, 1}, {0, 3, 1}, {1, 1, 5}}|>|>|>, "Channel" -> 
                <|"Name" -> "uom_exact_welded_bandlocked_log_channel", 
                 "Lambda" -> MainProof`UOMWeldedChannel`Private`lambda$27016, 
                 "vGeom" -> MainProof`UOMWeldedChannel`Private`v$27016, 
                 "AlphaTStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaT$27016, 
                 "AlphaXStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaX$27016, 
                 "Center" -> MainProof`UOMWeldedChannel`Private`center$27016, 
                 "Tick" -> MainProof`UOMWeldedChannel`Private`tick$27016, 
                 "DimB" -> 2, "Assumptions" -> 
                  MainProof`UOMWeldedChannel`Private`lambda$27016 > 0 && 
                   MainProof`UOMWeldedChannel`Private`v$27016 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaT$27016 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaX$27016 > 0, 
                 "TransportModel" -> <|"Name" -> 
                    "certified_polynomial_branch", "Parameter" -> 
                    MainProof`ActiveTransport`Private`lambda$27017, 
                   "Assumptions" -> 1 <= 
                     MainProof`ActiveTransport`Private`lambda$27017 <= 3, 
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                    {0, 0, 1 + 
                      MainProof`ActiveTransport`Private`lambda$27017}, 
                   "Nu" -> 1 + 
                     MainProof`ActiveTransport`Private`lambda$27017, 
                   "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                 "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                  <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$27016/
                     MainProof`UOMWeldedChannel`Private`lambda$27016, 
                   "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$27016/
                     (MainProof`UOMWeldedChannel`Private`lambda$27016*
                      MainProof`UOMWeldedChannel`Private`v$27016)|>, 
                 "TemporalWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`CapitalSigma][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$27016]*
                     MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`sigmaT][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$27016] == 
                    D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                        MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                         MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$27016], 
                     {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                 "SpatialWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`LoG[
                       MainProof`UOMWeldedChannel`Private`rho][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$27016] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                       MainProof`UOMWeldedChannel`Private`sigmaX][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$27016] == 
                    MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                       MainProof`UOMWeldedChannel`Private`rho^2 + 
                        MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                     MainProof`UOMWeldedChannel`Private`Omega, 
                     MainProof`UOMWeldedChannel`Private`center$27016]], 
                 "BandLockStatement" -> HoldForm[
                   {MainProof`UOMWeldedChannel`Private`sT == 
                     MainProof`UOMWeldedChannel`Private`alphaT$27016/
                      MainProof`UOMWeldedChannel`Private`lambda$27016, 
                    MainProof`UOMWeldedChannel`Private`sX == 
                     MainProof`UOMWeldedChannel`Private`alphaX$27016/
                      (MainProof`UOMWeldedChannel`Private`v$27016*
                       MainProof`UOMWeldedChannel`Private`lambda$27016)}], 
                 "CenterLockStatement" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`OmegaStar == 
                    MainProof`UOMWeldedChannel`Private`center$27016], 
                 "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 
                  0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                 "CompressedChannelStatement" -> HoldForm[
                   Subscript[MainProof`UOMWeldedChannel`Private`H, 
                      MainProof`UOMWeldedChannel`Private`LoG][
                     MainProof`UOMWeldedChannel`Private`lambda$27016] == 
                    Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                       MainProof`UOMWeldedChannel`Private`lambda$27016]}]]|>, 
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                 "Parameter" -> 
                  MainProof`ActiveTransport`Private`lambda$27017, 
                 "Assumptions" -> 1 <= 
                   MainProof`ActiveTransport`Private`lambda$27017 <= 3, 
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                  {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$27017}, 
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$27017, 
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
               "ActiveProjectorB" -> {{1, 0}, {0, 0}}, 
               "ActiveScalarFunctional" -> {0, 0, 1}, 
               "RepresentativeImage" -> {{1, 0}, {0, 0}}, "AmbiguityBasis" -> 
                {{1, 0, 0}, {0, 1, 0}}, "AmbiguityImages" -> 
                {{{0, 0}, {0, 0}}, {{0, 0}, {0, 0}}}|>, "LedgerProjectors" -> 
              {{{1, 0}, {0, 0}}, {{0, 0}, {0, 1}}}, 
             "ControlledSplitUnitary" -> {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 
              1, 0}, {0, 0, 0, -1}}, "RepresentativeLift" -> {{1, 0, 0, 0}, 
              {0, 0, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, "AmbiguityLifts" -> 
              {{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, {{
                0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}|>, 
           "MainVisibleQuotientCoordinate" -> {{0, 0, 1}}, 
           "MainVisibleDescendedFunctional" -> {1}|>, "ThresholdAudit" -> 
          <|"CounterexampleExistsQ" -> True, "Witness" -> 
            {{MainProof`DelayedDescendantReentryAudit`Private`alphaPrime$2964\
7 -> 1, MainProof`DelayedDescendantReentryAudit`Private`dLambda$29647 -> 1, 
              MainProof`DelayedDescendantReentryAudit`Private`stock$29647 -> 
               1, 
              MainProof`DelayedDescendantReentryAudit`Private`alpha$29647 -> 
               1, 
              MainProof`DelayedDescendantReentryAudit`Private`eta$29647 -> 1, 
              MainProof`DelayedDescendantReentryAudit`Private`gcl$29647 -> 1, 
              MainProof`DelayedDescendantReentryAudit`Private`dI$29647 -> 1, 
              MainProof`DelayedDescendantReentryAudit`Private`zeta$29647 -> 
               1, MainProof`DelayedDescendantReentryAudit`Private`a0$29647 -> 
               1, 
              MainProof`DelayedDescendantReentryAudit`Private`lam$29647 -> 1, 
              MainProof`DelayedDescendantReentryAudit`Private`rabs$29647 -> 
               1, 
              MainProof`DelayedDescendantReentryAudit`Private`kappa$29647 -> 
               1, MainProof`DelayedDescendantReentryAudit`Private`c0$29647 -> 
               0}}, "NamedWitness" -> <|"alphaPrime" -> 1, "dLambda" -> 1, 
             "stock" -> 1, "alpha" -> 1, "eta" -> 1, "gcl" -> 1, "dI" -> 1, 
             "zeta" -> 1, "a0" -> 1, "lam" -> 1, "rabs" -> 1, "kappa" -> 1, 
             "c0" -> 0|>, "NamedWitnessVerifiedQ" -> True, 
           "Interpretation" -> "The effective split-threshold inequality \
admits positive exact witnesses with c_Lambda = 0, so the threshold does not \
force nonvanishing of the seam coefficient by itself."|>, 
         "CanonicalLiftAudit" -> <|"SplitModelName" -> 
            "uom_split_controlled_lift_contract", 
           "QuotientCoordinateMatrix" -> {{0, 0, 1}}, 
           "DescendedFunctionalCoordinates" -> {1}, "Claims" -> 
            <|"Current exact split family admits a canonical scalar \
descendant representative modulo Aminus" -> <|"Status" -> 
                "exact finite-dimensional certificate", "Certified" -> 
                True|>, "Canonical scalar representative survives the \
descendant ambiguity quotient in the current exact family" -> 
              <|"Status" -> "exact finite-dimensional certificate", 
               "Certified" -> True|>, "Canonical scalar representative \
survives the current Main-visible scalar quotient in the exact family" -> 
              <|"Status" -> "exact finite-dimensional certificate", 
               "Certified" -> True|>|>, "ResidualBoundary" -> 
            {"The scalar lift is a model-specific reconstruction on the exact \
one-dimensional split response line.", "This does not derive a microscopic \
completion-to-descendant lift theorem from the split note by itself.", "It \
certifies only that the present surrogate family admits a canonical scalar \
inverse modulo Aminus."}|>, "FurtherQuotientAudit" -> 
          <|"PhysicalQuotientVisibleCountermodel" -> 
            <|"AmbiguityImagesOnPhysicalBasis" -> {{{0, 0, 0, 0, 0}, {0, 0, 
                0, 1, 0}}}, "OnTheNoseTriviality" -> False, 
             "ActsIntoNullIdeal" -> False, 
             "GenericShiftDifferenceInNullIdeal" -> False, 
             "GenericShiftDifferenceCoordinates" -> {{}, {}}, 
             "ClassDefinedOnPhysicalQuotient" -> False, 
             "VisibleFailureWitness" -> True|>, 
           "BoundaryUnsafeCountermodel" -> <|"ModelName" -> 
              "unsafe_visible_2x2", "Dimension" -> {2, 2}, 
             "ControlledCommutatorFormula" -> <|"Dimension" -> {2, 2}, 
               "ControlledReductionFormula" -> True, 
               "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "\
For controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K \
on A \[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \
\[CircleTimes] [K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 
              0}, {0, -1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
             "ControlledBlocks" -> {{{1, 0}, {0, -1}}, {{0, 0}, {0, 0}}}, 
             "StrongBlockCentralityQ" -> False, "ModNullBlockCentralityQ" -> 
              False, "StrongClassDefinedQ" -> False, 
             "ModNullClassDefinedQ" -> False, "ExpectationLevelInvisibleQ" -> 
              True, "OperatorLevelVisibleQ" -> True, 
             "StrongEquivalenceCertified" -> True, 
             "ModNullEquivalenceCertified" -> True, 
             "ExpectationInsufficiencyWitnessQ" -> True, 
             "WitnessObservable" -> {{0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 
              0}, {0, 0, 0, 0}}, "WitnessImage" -> {{0, 2, 0, 0}, {0, 0, 0, 
              0}, {0, 0, 0, 0}, {0, 0, 0, 0}}|>, "BoundaryBorderlineModel" -> 
            <|"ModelName" -> "borderline_nullideal_2x3", "Dimension" -> 
              {2, 3}, "ControlledCommutatorFormula" -> <|"Dimension" -> 
                {2, 3}, "ControlledReductionFormula" -> True, 
               "OffDiagonalLedgerPartKilled" -> True, "TheoremStatement" -> "\
For controlled observables O = Sum_i Pi^(A) \[CircleTimes] O_i^(B) and any K \
on A \[CircleTimes] B, ControlledProjection([K,O]) = Sum_i Pi^(A) \
\[CircleTimes] [K_i^(B), O_i^(B)]."|>, "ControlledAmbiguity" -> {{1, 0, 0, 0, 
              0, 0}, {0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
              0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
             "ControlledBlocks" -> {{{1, 0, 0}, {0, 1, 0}, {0, 0, 0}}, {{
                0, 0, 0}, {0, 0, 0}, {0, 0, 0}}}, "StrongBlockCentralityQ" -> 
              False, "ModNullBlockCentralityQ" -> True, 
             "StrongClassDefinedQ" -> False, "ModNullClassDefinedQ" -> True, 
             "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" -> 
              True, "StrongEquivalenceCertified" -> True, 
             "ModNullEquivalenceCertified" -> True, 
             "ExpectationInsufficiencyWitnessQ" -> True, 
             "WitnessObservable" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
              {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 
              0, 0, 0, 0, 0}}, "WitnessImage" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 
              0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 
              0, 0, 0}, {0, 0, 0, 0, 0, 0}}|>, "Claims" -> 
            <|"Further post-Main-visible reentry is automatic from \
split-controlled localization alone" -> <|"Status" -> "counterexample found", 
               "Certified" -> False|>, "A chosen mod-null boundary quotient \
can support conditional reentry on the audited borderline family" -> 
              <|"Status" -> "exact finite-dimensional certificate", 
               "Certified" -> True|>|>, "ResidualBoundary" -> 
            {"The visible physical-sector example is not class-defined on the \
physical quotient.", "The unsafe controlled split-welded family is not \
mod-null class-defined, even though expectation-level invisibility holds \
there.", "So the current exact lane does not certify an automatic V^1-style \
or physical/null-ideal reentry theorem from split-controlled localization \
alone."}|>, "Claims" -> <|"Split-threshold regime forces c_Lambda != 0" -> 
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
        <|"ModelName" -> "borderline_nullideal_2x3", 
         "SelectedLineGenerator" -> {{0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
          0, 0, 0, 0}}, "NullIdealBasis" -> {{{0, 0, 1, 0, 0, 0}, {0, 0, 0, 
           0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
           0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
           {1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
           0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 
           0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
           0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 
           0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 
           0, 0, 1}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 
           0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 
           0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 
           0, 0, 1}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 
           0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 1, 0}}}, "QuotientCoordinateMatrix" -> 
          {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 
            1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
           {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0}, {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}, 
         "SelectedQuotientImage" -> {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0}, 
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
          {"This is an exact controlled finite-dimensional mod-null \
certificate on the audited borderline family.", "It does not derive the \
abstract Main/UOM transversality hypothesis automatically for the scalar \
descendant line in D^-."}|>, "Claims" -> <|"The remaining mod-null step \
reduces to line/null-ideal transversality plus quotient construction" -> 
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
        0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 
        0, 0, 0, 0, 0}}, "SelectedLineGenerator" -> {{0, 1, 0, 0, 0, 0}, {0, 
        0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 
        0, 0}, {0, 0, 0, 0, 0, 0}}, "NullIdealBasis" -> 
        {{{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 
         0, 0}, {0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
         {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 
         1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
         0}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
         {0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
         0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 
         0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
         {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 1, 0, 0}}, {{0, 0, 0, 0, 
         0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, 
         {0, 0, 0, 0, 0, 1}, {0, 0, 0, 0, 0, 0}}, {{0, 0, 0, 0, 0, 0}, {0, 0, 
         0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
         0}, {0, 0, 0, 0, 1, 0}}}, "SelectedScalar" -> 1, 
       "Claims" -> <|"Chosen mod-null subspace lies in the kernel of the \
dominant functional surrogate on the audited borderline family" -> 
          <|"Status" -> "exact finite-dimensional certificate", 
           "Certified" -> True|>, "Selected scalar generator has nonzero \
dominant functional surrogate value on the audited borderline family" -> 
          <|"Status" -> "exact finite-dimensional certificate", 
           "Certified" -> True|>, "Chosen mod-null subspace is parity-stable \
on the audited borderline family" -> <|"Status" -> 
            "exact finite-dimensional certificate", "Certified" -> True|>|>, 
       "ResidualBoundary" -> {"The functional is an exact finite-dimensional \
surrogate built from the audited borderline-family witness pairing.", "This \
does not identify the surrogate with the abstract descended dominant \
functional outside that model family."}|>, "Claims" -> 
      <|"Kernel-subordinated parity-stable mod-null data discharge theorem-2 \
transversality on the audited family" -> 
        <|"Status" -> 
          "exact finite-dimensional certificate for the discharge schema", 
         "Certified" -> True|>|>, "TopLineReading" -> 
      {"On the audited borderline family, the dominant-functional-kernel \
route is exact: the chosen parity-stable mod-null subspace lies in the kernel \
of the functional surrogate, while the selected generator has nonzero value."\
, "Therefore the selected line is automatically transverse to that mod-null \
subspace on the audited family.", "This certifies the discharge schema \
familywise, but it does not yet construct a canonical dominant-null subspace \
in the abstract Main/UOM theorem stack."}|>, "TransverseReduction" -> 
    <|"UnderlyingDelayedReentryAudit" -> 
      <|"Model" -> <|"TransportModel" -> 
          <|"Name" -> "certified_polynomial_branch", "Parameter" -> 
            MainProof`ActiveTransport`Private`lambda$33438, 
           "Assumptions" -> 1 <= 
             MainProof`ActiveTransport`Private`lambda$33438 <= 3, 
           "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
            {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$33438}, 
           "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$33438, 
           "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
         "SplitModel" -> <|"Name" -> "uom_split_controlled_lift_contract", 
           "IntrinsicResponseContract" -> <|"Name" -> 
              "uom_intrinsic_response_contract_from_welded_boundary", 
             "BoundaryModel" -> <|"BoundaryAudit" -> <|"Model" -> 
                  <|"Channel" -> <|"Name" -> 
                      "uom_exact_welded_bandlocked_log_channel", "Lambda" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$33444, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$33444, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$33444, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$33444, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$33444, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$33444, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$33444 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$33444 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$33444 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$33444 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$33445, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33445}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33445, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$33444/
                         MainProof`UOMWeldedChannel`Private`lambda$33444, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$33444/
                         (MainProof`UOMWeldedChannel`Private`lambda$33444*
                          MainProof`UOMWeldedChannel`Private`v$33444)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33444]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33444] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33444], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33444] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33444] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$33444]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$33444/
                          MainProof`UOMWeldedChannel`Private`lambda$33444, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$33444/
                          (MainProof`UOMWeldedChannel`Private`v$33444*
                          MainProof`UOMWeldedChannel`Private`lambda$33444)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$33444], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$33444] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$33444]}]]\
|>, "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                     "Parameter" -> 
                      MainProof`ActiveTransport`Private`lambda$33445, 
                     "Assumptions" -> 1 <= 
                       MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
                     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                      {0, 0, 1 + 
                        MainProof`ActiveTransport`Private`lambda$33445}, 
                     "Nu" -> 1 + 
                       MainProof`ActiveTransport`Private`lambda$33445, 
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
                        MainProof`UOMFactPreservation`Private`kernel$33448[1, 
                          2]*MainProof`UOMFactPreservation`Private`r[1, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$33448[1, 
                          3]*MainProof`UOMFactPreservation`Private`r[1, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$33448[2, 
                          1]*MainProof`UOMFactPreservation`Private`r[2, 1], 
                        MainProof`UOMFactPreservation`Private`r[2, 2], 
                        MainProof`UOMFactPreservation`Private`kernel$33448[2, 
                          3]*MainProof`UOMFactPreservation`Private`r[2, 3]}, 
                       {MainProof`UOMFactPreservation`Private`kernel$33448[3, 
                          1]*MainProof`UOMFactPreservation`Private`r[3, 1], 
                        MainProof`UOMFactPreservation`Private`kernel$33448[3, 
                          2]*MainProof`UOMFactPreservation`Private`r[3, 2], 
                        MainProof`UOMFactPreservation`Private`r[3, 3]}}, 
                     "AcceptedRecordState" -> 
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
                      MainProof`UOMWeldedChannel`Private`lambda$33522, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$33522, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$33522, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$33522, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$33522, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$33522, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$33522 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$33522 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$33522 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$33522 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$33523, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33523 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33523}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33523, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$33522/
                         MainProof`UOMWeldedChannel`Private`lambda$33522, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$33522/
                         (MainProof`UOMWeldedChannel`Private`lambda$33522*
                          MainProof`UOMWeldedChannel`Private`v$33522)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33522]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33522] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33522], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33522] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33522] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$33522]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$33522/
                          MainProof`UOMWeldedChannel`Private`lambda$33522, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$33522/
                          (MainProof`UOMWeldedChannel`Private`v$33522*
                          MainProof`UOMWeldedChannel`Private`lambda$33522)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$33522], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$33522] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$33522]}]]\
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
                         MainProof`UOMWeldedChannel`Private`tick$33522]*
                       MainProof`UOMWeldedChannel`Private`gPrime[
                         MainProof`UOMWeldedChannel`Private`sigmaT][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$33522] == 
                      D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                        MainProof`UOMWeldedChannel`Private`t - 
                         MainProof`UOMWeldedChannel`Private`tick$33522], 
                       {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                   "SpatialWeldedForm" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`LoG[
                         MainProof`UOMWeldedChannel`Private`rho][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$33522] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                         MainProof`UOMWeldedChannel`Private`sigmaX][
                        MainProof`UOMWeldedChannel`Private`Omega, 
                        MainProof`UOMWeldedChannel`Private`center$33522] == 
                      MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                         MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                       MainProof`UOMWeldedChannel`Private`Omega, 
                       MainProof`UOMWeldedChannel`Private`center$33522]], 
                   "CoCenteringStatement" -> HoldForm[
                     MainProof`UOMWeldedChannel`Private`OmegaStar == 
                      MainProof`UOMWeldedChannel`Private`center$33522], 
                   "BandLockStatement" -> HoldForm[
                     {MainProof`UOMWeldedChannel`Private`sT == 
                       MainProof`UOMWeldedChannel`Private`alphaT$33522/
                        MainProof`UOMWeldedChannel`Private`lambda$33522, 
                      MainProof`UOMWeldedChannel`Private`sX == 
                       MainProof`UOMWeldedChannel`Private`alphaX$33522/
                        (MainProof`UOMWeldedChannel`Private`v$33522*
                         MainProof`UOMWeldedChannel`Private`lambda$33522)}], 
                   "BandLockScales" -> <|"s_t" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$33522/
                       MainProof`UOMWeldedChannel`Private`lambda$33522, 
                     "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$33522/
                       (MainProof`UOMWeldedChannel`Private`lambda$33522*
                        MainProof`UOMWeldedChannel`Private`v$33522)|>, 
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
                      MainProof`UOMWeldedChannel`Private`lambda$33529, 
                     "vGeom" -> MainProof`UOMWeldedChannel`Private`v$33529, 
                     "AlphaTStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaT$33529, 
                     "AlphaXStar" -> 
                      MainProof`UOMWeldedChannel`Private`alphaX$33529, 
                     "Center" -> 
                      MainProof`UOMWeldedChannel`Private`center$33529, 
                     "Tick" -> MainProof`UOMWeldedChannel`Private`tick$33529, 
                     "DimB" -> 2, "Assumptions" -> 
                      MainProof`UOMWeldedChannel`Private`lambda$33529 > 0 && 
                       MainProof`UOMWeldedChannel`Private`v$33529 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaT$33529 > 0 && 
                       MainProof`UOMWeldedChannel`Private`alphaX$33529 > 0, 
                     "TransportModel" -> <|"Name" -> 
                        "certified_polynomial_branch", "Parameter" -> 
                        MainProof`ActiveTransport`Private`lambda$33530, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33530 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33530}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33530, 
                       "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                      <|"s_t" -> 
                        MainProof`UOMWeldedChannel`Private`alphaT$33529/
                         MainProof`UOMWeldedChannel`Private`lambda$33529, 
                       "s_x" -> 
                        MainProof`UOMWeldedChannel`Private`alphaX$33529/
                         (MainProof`UOMWeldedChannel`Private`lambda$33529*
                          MainProof`UOMWeldedChannel`Private`v$33529)|>, 
                     "TemporalWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33529]*
                         MainProof`UOMWeldedChannel`Private`gPrime[
                          MainProof`UOMWeldedChannel`Private`sigmaT][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33529] == 
                        D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                          MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                          MainProof`UOMWeldedChannel`Private`t - 
                          MainProof`UOMWeldedChannel`Private`tick$33529], 
                         {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                     "SpatialWeldedForm" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`LoG[
                          MainProof`UOMWeldedChannel`Private`rho][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33529] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                          MainProof`UOMWeldedChannel`Private`sigmaX][
                          MainProof`UOMWeldedChannel`Private`Omega, 
                          MainProof`UOMWeldedChannel`Private`center$33529] == 
                        MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                          MainProof`UOMWeldedChannel`Private`rho^2 + 
                          MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                         MainProof`UOMWeldedChannel`Private`Omega, 
                         MainProof`UOMWeldedChannel`Private`center$33529]], 
                     "BandLockStatement" -> HoldForm[
                       {MainProof`UOMWeldedChannel`Private`sT == 
                         MainProof`UOMWeldedChannel`Private`alphaT$33529/
                          MainProof`UOMWeldedChannel`Private`lambda$33529, 
                        MainProof`UOMWeldedChannel`Private`sX == 
                         MainProof`UOMWeldedChannel`Private`alphaX$33529/
                          (MainProof`UOMWeldedChannel`Private`v$33529*
                          MainProof`UOMWeldedChannel`Private`lambda$33529)}], 
                     "CenterLockStatement" -> HoldForm[
                       MainProof`UOMWeldedChannel`Private`OmegaStar == 
                        MainProof`UOMWeldedChannel`Private`center$33529], 
                     "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> 
                      {{1, 0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                     "CompressedChannelStatement" -> HoldForm[
                       Subscript[MainProof`UOMWeldedChannel`Private`H, 
                          MainProof`UOMWeldedChannel`Private`LoG][
                         MainProof`UOMWeldedChannel`Private`lambda$33529] == 
                        Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                          MainProof`UOMWeldedChannel`Private`lambda$33529]}]]\
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
                      MainProof`UOMFactPreservation`Private`kernel$33536[1, 
                        2]*MainProof`UOMFactPreservation`Private`r[1, 2], 
                      MainProof`UOMFactPreservation`Private`kernel$33536[1, 
                        3]*MainProof`UOMFactPreservation`Private`r[1, 3]}, 
                     {MainProof`UOMFactPreservation`Private`kernel$33536[2, 
                        1]*MainProof`UOMFactPreservation`Private`r[2, 1], 
                      MainProof`UOMFactPreservation`Private`r[2, 2], 
                      MainProof`UOMFactPreservation`Private`kernel$33536[2, 
                        3]*MainProof`UOMFactPreservation`Private`r[2, 3]}, 
                     {MainProof`UOMFactPreservation`Private`kernel$33536[3, 
                        1]*MainProof`UOMFactPreservation`Private`r[3, 1], 
                      MainProof`UOMFactPreservation`Private`kernel$33536[3, 
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
                        MainProof`ActiveTransport`Private`lambda$33554, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33554 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33554}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33554, 
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
                        MainProof`ActiveTransport`Private`lambda$33562, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33562 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33562}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33562, 
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
                        MainProof`ActiveTransport`Private`lambda$33554, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33554 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33554}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33554, 
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
                        MainProof`ActiveTransport`Private`lambda$33562, 
                       "Assumptions" -> 1 <= 
                         MainProof`ActiveTransport`Private`lambda$33562 <= 3, 
                       "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                        {0, 0, 1 + 
                          MainProof`ActiveTransport`Private`lambda$33562}, 
                       "Nu" -> 1 + 
                         MainProof`ActiveTransport`Private`lambda$33562, 
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
                 "Lambda" -> MainProof`UOMWeldedChannel`Private`lambda$33444, 
                 "vGeom" -> MainProof`UOMWeldedChannel`Private`v$33444, 
                 "AlphaTStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaT$33444, 
                 "AlphaXStar" -> 
                  MainProof`UOMWeldedChannel`Private`alphaX$33444, 
                 "Center" -> MainProof`UOMWeldedChannel`Private`center$33444, 
                 "Tick" -> MainProof`UOMWeldedChannel`Private`tick$33444, 
                 "DimB" -> 2, "Assumptions" -> 
                  MainProof`UOMWeldedChannel`Private`lambda$33444 > 0 && 
                   MainProof`UOMWeldedChannel`Private`v$33444 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaT$33444 > 0 && 
                   MainProof`UOMWeldedChannel`Private`alphaX$33444 > 0, 
                 "TransportModel" -> <|"Name" -> 
                    "certified_polynomial_branch", "Parameter" -> 
                    MainProof`ActiveTransport`Private`lambda$33445, 
                   "Assumptions" -> 1 <= 
                     MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
                   "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                    {0, 0, 1 + 
                      MainProof`ActiveTransport`Private`lambda$33445}, 
                   "Nu" -> 1 + 
                     MainProof`ActiveTransport`Private`lambda$33445, 
                   "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
                 "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                  <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$33444/
                     MainProof`UOMWeldedChannel`Private`lambda$33444, 
                   "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$33444/
                     (MainProof`UOMWeldedChannel`Private`lambda$33444*
                      MainProof`UOMWeldedChannel`Private`v$33444)|>, 
                 "TemporalWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`CapitalSigma][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$33444]*
                     MainProof`UOMWeldedChannel`Private`gPrime[
                       MainProof`UOMWeldedChannel`Private`sigmaT][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$33444] == 
                    D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                        MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                         MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                      MainProof`UOMWeldedChannel`Private`t - 
                       MainProof`UOMWeldedChannel`Private`tick$33444], 
                     {MainProof`UOMWeldedChannel`Private`t, 2}]], 
                 "SpatialWeldedForm" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`LoG[
                       MainProof`UOMWeldedChannel`Private`rho][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$33444] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                       MainProof`UOMWeldedChannel`Private`sigmaX][
                      MainProof`UOMWeldedChannel`Private`Omega, 
                      MainProof`UOMWeldedChannel`Private`center$33444] == 
                    MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                       MainProof`UOMWeldedChannel`Private`rho^2 + 
                        MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                     MainProof`UOMWeldedChannel`Private`Omega, 
                     MainProof`UOMWeldedChannel`Private`center$33444]], 
                 "BandLockStatement" -> HoldForm[
                   {MainProof`UOMWeldedChannel`Private`sT == 
                     MainProof`UOMWeldedChannel`Private`alphaT$33444/
                      MainProof`UOMWeldedChannel`Private`lambda$33444, 
                    MainProof`UOMWeldedChannel`Private`sX == 
                     MainProof`UOMWeldedChannel`Private`alphaX$33444/
                      (MainProof`UOMWeldedChannel`Private`v$33444*
                       MainProof`UOMWeldedChannel`Private`lambda$33444)}], 
                 "CenterLockStatement" -> HoldForm[
                   MainProof`UOMWeldedChannel`Private`OmegaStar == 
                    MainProof`UOMWeldedChannel`Private`center$33444], 
                 "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 
                  0}, {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
                 "CompressedChannelStatement" -> HoldForm[
                   Subscript[MainProof`UOMWeldedChannel`Private`H, 
                      MainProof`UOMWeldedChannel`Private`LoG][
                     MainProof`UOMWeldedChannel`Private`lambda$33444] == 
                    Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                       MainProof`UOMWeldedChannel`Private`lambda$33444]}]]|>, 
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                 "Parameter" -> 
                  MainProof`ActiveTransport`Private`lambda$33445, 
                 "Assumptions" -> 1 <= 
                   MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                  {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$33445}, 
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$33445, 
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
                MainProof`UOMWeldedChannel`Private`lambda$33444, "vGeom" -> 
                MainProof`UOMWeldedChannel`Private`v$33444, "AlphaTStar" -> 
                MainProof`UOMWeldedChannel`Private`alphaT$33444, 
               "AlphaXStar" -> 
                MainProof`UOMWeldedChannel`Private`alphaX$33444, "Center" -> 
                MainProof`UOMWeldedChannel`Private`center$33444, "Tick" -> 
                MainProof`UOMWeldedChannel`Private`tick$33444, "DimB" -> 
                2, "Assumptions" -> 
                MainProof`UOMWeldedChannel`Private`lambda$33444 > 0 && 
                 MainProof`UOMWeldedChannel`Private`v$33444 > 0 && 
                 MainProof`UOMWeldedChannel`Private`alphaT$33444 > 0 && 
                 MainProof`UOMWeldedChannel`Private`alphaX$33444 > 0, 
               "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
                 "Parameter" -> 
                  MainProof`ActiveTransport`Private`lambda$33445, 
                 "Assumptions" -> 1 <= 
                   MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
                 "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                  {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$33445}, 
                 "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$33445, 
                 "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>, 
               "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "BandLockScales" -> 
                <|"s_t" -> MainProof`UOMWeldedChannel`Private`alphaT$33444/
                   MainProof`UOMWeldedChannel`Private`lambda$33444, 
                 "s_x" -> MainProof`UOMWeldedChannel`Private`alphaX$33444/
                   (MainProof`UOMWeldedChannel`Private`lambda$33444*
                    MainProof`UOMWeldedChannel`Private`v$33444)|>, 
               "TemporalWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`CapitalSigma][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$33444]*
                   MainProof`UOMWeldedChannel`Private`gPrime[
                     MainProof`UOMWeldedChannel`Private`sigmaT][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$33444] == 
                  D[MainProof`UOMWeldedChannel`Private`g[Sqrt[
                      MainProof`UOMWeldedChannel`Private`CapitalSigma^2 + 
                       MainProof`UOMWeldedChannel`Private`sigmaT^2]][
                    MainProof`UOMWeldedChannel`Private`t - 
                     MainProof`UOMWeldedChannel`Private`tick$33444], 
                   {MainProof`UOMWeldedChannel`Private`t, 2}]], 
               "SpatialWeldedForm" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`LoG[
                     MainProof`UOMWeldedChannel`Private`rho][
                    MainProof`UOMWeldedChannel`Private`Omega, 
                    MainProof`UOMWeldedChannel`Private`center$33444] \
\[CircleTimes] MainProof`UOMWeldedChannel`Private`Gaussian[
                     MainProof`UOMWeldedChannel`Private`sigmaX][
                    MainProof`UOMWeldedChannel`Private`Omega, 
                    MainProof`UOMWeldedChannel`Private`center$33444] == 
                  MainProof`UOMWeldedChannel`Private`LoG[Sqrt[
                     MainProof`UOMWeldedChannel`Private`rho^2 + 
                      MainProof`UOMWeldedChannel`Private`sigmaX^2]][
                   MainProof`UOMWeldedChannel`Private`Omega, 
                   MainProof`UOMWeldedChannel`Private`center$33444]], 
               "BandLockStatement" -> HoldForm[
                 {MainProof`UOMWeldedChannel`Private`sT == 
                   MainProof`UOMWeldedChannel`Private`alphaT$33444/
                    MainProof`UOMWeldedChannel`Private`lambda$33444, 
                  MainProof`UOMWeldedChannel`Private`sX == 
                   MainProof`UOMWeldedChannel`Private`alphaX$33444/
                    (MainProof`UOMWeldedChannel`Private`v$33444*
                     MainProof`UOMWeldedChannel`Private`lambda$33444)}], 
               "CenterLockStatement" -> HoldForm[
                 MainProof`UOMWeldedChannel`Private`OmegaStar == 
                  MainProof`UOMWeldedChannel`Private`center$33444], 
               "WeldedChannelDimension" -> 1, "ProfileProjectorB" -> {{1, 0}, 
                {0, 0}}, "ProfileBasisB" -> {{1, 0}}, 
               "CompressedChannelStatement" -> HoldForm[
                 Subscript[MainProof`UOMWeldedChannel`Private`H, 
                    MainProof`UOMWeldedChannel`Private`LoG][
                   MainProof`UOMWeldedChannel`Private`lambda$33444] == 
                  Span[{MainProof`UOMWeldedChannel`Private`uLoG[
                     MainProof`UOMWeldedChannel`Private`lambda$33444]}]]|>, 
             "TransportModel" -> <|"Name" -> "certified_polynomial_branch", 
               "Parameter" -> MainProof`ActiveTransport`Private`lambda$33445, 
               "Assumptions" -> 1 <= 
                 MainProof`ActiveTransport`Private`lambda$33445 <= 3, 
               "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "RhoDom" -> 
                {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$33445}, 
               "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$33445, 
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
            MainProof`DelayedDescendantReentryAudit`Private`alphaPrime$36075 \
-> 1, MainProof`DelayedDescendantReentryAudit`Private`dLambda$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`stock$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`alpha$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`eta$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`gcl$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`dI$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`zeta$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`a0$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`lam$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`rabs$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`kappa$36075 -> 1, 
            MainProof`DelayedDescendantReentryAudit`Private`c0$36075 -> 0}}, 
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
descendant representative modulo Aminus" -> <|"Status" -> 
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
from split localization alone."}|>|>|>
