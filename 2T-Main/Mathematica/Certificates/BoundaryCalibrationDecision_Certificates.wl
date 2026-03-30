<|"GeneratedAt" -> "2026-03-12 23:21:45", "SprintScope" -> "Boundary \
calibration invariance under split+welded restriction at exact finite \
cutoff.", "DecisionQuestion" -> "Can the split+welded boundary restriction \
make calibration dependence invisible to the extent Main actually needs?", 
 "MilestoneStatus" -> "green", "BoundaryDecision" -> 
  <|"Decision" -> "Decision A", "Sentence" -> "Boundary class-defined \
derivation is recovered on the controlled split+welded sector under the \
hypothesis that the diagonal controlled ambiguity component acts trivially \
modulo the chosen boundary null ideal; visible controlled countermodels \
remain outside that hypothesis.", "Reason" -> "The strict record sector is \
automatically invariant but trivial, the borderline model is nontrivial and \
mod-null invisible, and the unsafe model shows the criterion is genuinely \
needed."|>, "Ledger" -> {<|"TheoremLabel" -> "def:2T-char", 
    "Assumptions" -> "Finite-dimensional surrogate for the seven Main-facing \
interface clauses.", "Method" -> 
     "Exact association validation plus 3 valid and 3 invalid synthetic \
examples.", "Status" -> "exact finite-dimensional certificate", 
    "ScopeClass" -> "schema-validator", "SurrogateBlindSpots" -> 
     {"Closedness is automatic/invisible at finite dimension.", 
      "Continuity of chi is automatic for finite-dimensional linear maps.", "\
Hilbertizability is reduced to positive-definite matrix data, not the \
abstract completion statement."}, "CertificateArtifact" -> "/home/kray-l8/wor\
k/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.w\
l::Task2Schema.ValidExamples", "CounterexampleArtifact" -> "/home/kray-l8/wor\
k/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.w\
l::Task2Schema.InvalidExamples", "RepresentativeModelFamily" -> "valid_basic_\
identity, valid_nontrivial_gram, valid_zero_ambiguity; invalid_parity_tag, \
invalid_chi_on_ambiguity, invalid_positive_form", "NoApproximationQ" -> True, 
    "Source" -> "Main/appendix_main.tex:535-586", 
    "Acceptance" -> 
     "3 valid accepted; 3 invalid rejected for the expected reason."|>, 
   <|"TheoremLabel" -> "thm:active-response-transport-minimal", 
    "Assumptions" -> "Branchwise rho^dom, nu, Aminus, and Jdesc family on an \
accepted interval.", "Method" -> "Resolve/Reduce on an exact polynomial \
branch model, connected-component audit, and broken-model hypothesis drops.", 
    "Status" -> "exact finite-dimensional certificate", 
    "ScopeClass" -> "exact-model-certificate", "SurrogateBlindSpots" -> 
     {"Continuity is certified only for the chosen exact model family.", 
      "The theorem is not universally proved for all admissible branches."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task3_5ActiveTransport.Cert\
ifiedModel", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathemat\
ica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task3_5ActiveTr\
ansport.BrokenModels", "RepresentativeModelFamily" -> "certified_polynomial_b\
ranch, broken_zero_sign_undefined, broken_jump_discontinuity, \
broken_ambiguity_not_in_kernel", "NoApproximationQ" -> True, 
    "Source" -> "UOM/active_response_transport_program_note.tex:1821-1907"|>, 
   <|"TheoremLabel" -> "thm:char-weak-interface", "Assumptions" -> "Transport \
theorem discharged; chi = nu^-1 rho^dom defines the weak Main export.", 
    "Method" -> "Exact export chi = nu^-1 rho^dom with affine constancy, \
sign-defined components, and ambiguity-leak counterexample.", 
    "Status" -> "exact finite-dimensional certificate", 
    "ScopeClass" -> "exact-model-certificate", "SurrogateBlindSpots" -> 
     {"The weak export is checked on exact branch models rather than \
universally."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathemat\
ica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task3_5ActiveTr\
ansport.CertifiedModel", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/M\
ain/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Tas\
k3_5ActiveTransport.BrokenModels", "RepresentativeModelFamily" -> 
     "certified_polynomial_branch with explicit broken hypothesis models", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/canonical_odd_interface_note.tex:699-744"|>, 
   <|"TheoremLabel" -> "prop:minimal-transport-calibration", 
    "Assumptions" -> 
     "chi, Jsharp, beta > 0, and a coercive form on ker chi.", 
    "Method" -> "Exact basis-aware ambient construction B = M^-T G M^-1 with \
coercive kernel metric.", "Status" -> 
     "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Coercivity and Hilbertizability are \
represented by positive-definite finite matrices.", 
      "No infinite-dimensional completion is constructed."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task4Calibration.ValidExamp\
le", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Cert\
ificates/BoundaryCalibrationDecision_Certificates.wl::Task4Calibration.Broken\
Examples", "RepresentativeModelFamily" -> "Exact basis-aware ambient \
calibration examples with broken-input countermodels", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/active_response_transport_program_note.tex:1987-2056"|>, 
   <|"TheoremLabel" -> "thm:finite-cutoff-Jcan", "Assumptions" -> "Weak \
2T_char interface and a positive symmetric ambient bilinear form B on E^- \
whose restriction is minimized on the affine class.", 
    "Method" -> 
     "Exact affine projection with GA = U^T B U and Jcan = J0 + U a*.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Closed affine subspace and Hilbert projection \
are realized by finite-dimensional matrix algebra."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task5CanonicalRepresentativ\
e.ValidExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Math\
ematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task5Canoni\
calRepresentative.BrokenExamples", "RepresentativeModelFamily" -> 
     "Exact full-column-rank affine examples with rank/B/chi countermodels", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:1787-1811"|>, 
   <|"TheoremLabel" -> "prop:Jcan-orth", "Assumptions" -> 
     "Finite-dimensional affine class and positive B.", 
    "Method" -> "Exact orthogonality, projector formula, and \
minimality-difference identity.", "Status" -> 
     "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The proof is finite-dimensional and does not \
replace the abstract Hilbert-space statement."}, "CertificateArtifact" -> "/h\
ome/kray-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision\
_Certificates.wl::Task5CanonicalRepresentative.ValidExample", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/BoundaryCalibrationDecision_Certificates.wl::Task5CanonicalRepresenta\
tive.BrokenExamples", "RepresentativeModelFamily" -> 
     "Exact projector-model family with representative-shift checks", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:1838-1870 (working sprint label)"|>, 
   <|"TheoremLabel" -> "thm:dominant-quotient-descent", 
    "Assumptions" -> "Dominant-response functional and ambiguity subspace on \
the finite-cutoff odd layer.", "Method" -> "Exact quotient coordinates W, \
descended covector eta, and universal descent equivalences via Resolve.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Topological quotient continuity is represented \
by exact finite-dimensional linear maps.", "Closure of the ambiguity span is \
not separately audited beyond the surrogate."}, "CertificateArtifact" -> "/ho\
me/kray-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_\
Certificates.wl::Task6QuotientDescent.ValidExample", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/BoundaryCalibrationDecision_Certificates.wl::Task6QuotientDescent.Bro\
kenExamples", "RepresentativeModelFamily" -> "Exact quotient-descent \
valid/broken model pair with nu != 1 obstruction witness", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/active_response_transport_program_note.tex:504-525"|>, 
   <|"TheoremLabel" -> "cor:dominant-quotient-constancy", 
    "Assumptions" -> "Descended dominant functional on the ambiguity quotient \
and the affine descendant class.", "Method" -> 
     "Exact affine-class constancy and quotient-value reduction on J0 + \
Aminus.", "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The quotient point [![Xi^(1)]!] is represented \
by exact coordinates rather than an abstract completion object."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task6QuotientDescent.ValidE\
xample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/\
Certificates/BoundaryCalibrationDecision_Certificates.wl::Task6QuotientDescen\
t.BrokenExamples", "RepresentativeModelFamily" -> 
     "Exact affine descendant class with quotient-point scalar reduction", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/active_response_transport_program_note.tex:444-468"|>, 
   <|"TheoremLabel" -> "task:source-insertion-representability", 
    "Assumptions" -> "Fixed-cutoff image-membership problem Pi_phys R(F_tau) \
= Pi_phys T[tau].", "Method" -> "Exact image-membership solver for Pi_phys \
R(F_tau) = Pi_phys T[tau], with obstruction and gauge-space extraction.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Sufficient locality remains imported and is \
not identified with algebraic image membership.", 
      "Only fixed-cutoff linear realizability is audited here."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task7Representability.Valid\
Examples", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematic\
a/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task7Representabi\
lity.BrokenExamples", "RepresentativeModelFamily" -> "Exact representable \
unique/family examples plus an explicit obstruction example", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/active_response_transport_program_note.tex:1260-1310"|>, 
   <|"TheoremLabel" -> "task:witness-comparison-reduction", 
    "Assumptions" -> "Representative search on J0 + Aminus versus scalar \
compatibility of dominant pairings.", "Method" -> "Exact \
representative-search reduction to rho-level scalar compatibility, plus \
obstruction witness for the unscaled chi-level claim when nu != 1.", 
    "Status" -> "counterexample found", "ScopeClass" -> 
     "finite-dimensional-theorem-certificate", "SurrogateBlindSpots" -> 
     {"The notebook certifies the scalar reduction at fixed cutoff only.", "T\
he unscaled chi-compatibility claim fails unless an extra normalization \
hypothesis is added."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/\
Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task8Wi\
tnessComparison", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mat\
hematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task8Witne\
ssComparison.UnscaledChiCompatibilityWitness", "RepresentativeModelFamily" -> 
     "Exact nu != 1 witness-comparison obstruction family", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/active_response_transport_program_note.tex:1323-1371"|>, 
   <|"TheoremLabel" -> "task:Jcan-branch-regularity", 
    "Assumptions" -> "Rational or polynomial branch data U(lambda), \
B(lambda), J0(lambda) with invertible Gram block.", 
    "Method" -> "Exact projector formula with rational-function continuity \
certified away from Gram-block degeneracy.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"Only rational/polynomial finite-cutoff branch data are audited.", 
      "The statement does not address infinite-dimensional branch \
regularity."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathemati\
ca/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task9JcanBranchR\
egularity.ValidExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/M\
ain/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Tas\
k9JcanBranchRegularity.DegenerateExample", "RepresentativeModelFamily" -> 
     "Exact valid and Gram-degenerate branch examples", 
    "NoApproximationQ" -> True, "Source" -> "Main/appendix_main.tex:1837-1870 \
plus finite-dimensional projector formula remark"|>, 
   <|"TheoremLabel" -> "task:calibration-comparison", 
    "Assumptions" -> "Two admissible positive calibrations B1, B2 on the same \
affine class J0 + im(U).", "Method" -> "Exact projector comparison Jcan_B = \
(I - P_A^B) J0, with DeltaJ in Aminus and visibility-map invariance when the \
visible map kills Aminus.", "Status" -> 
     "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"Only fixed-cutoff exact matrix calibrations are compared.", "Physical \
invisibility is represented by explicit visible maps that kill Aminus, not by \
AQFT/HLS semantics."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/M\
athematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task11Ca\
librationComparison.NonInvariantExample", "CounterexampleArtifact" -> "/home/\
kray-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Cer\
tificates.wl::Task11CalibrationComparison.NonInvariantExample.DeltaJ", 
    "RepresentativeModelFamily" -> "Exact admissible-calibration pairs with \
one non-invariant and one projector-equal comparison family", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:1787-1917 plus WL calibration-comparison lane"|>\
, <|"TheoremLabel" -> "task:ambiguity-trivial-on-physical-sector", 
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model.", "Method" -> "Exact proof that delta_{J + A} - \
delta_J = ad_A and that ad_A vanishes on the physical sector.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"Only explicit finite-dimensional bracket models are audited."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task14AmbiguityPhysicalSect\
or.InvisibleExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main\
/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task14\
AmbiguityPhysicalSector.VisibleExample", "RepresentativeModelFamily" -> 
     "Exact five-basis invisible-ambiguity commutator model", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:ambiguity-trivial-mod-null-ideal", 
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model with a physical null ideal.", 
    "Method" -> "Exact proof that ad_A on the physical sector lands in the \
physical null ideal while remaining nonzero.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The physical null ideal is represented by an \
explicit finite-dimensional subspace."}, "CertificateArtifact" -> "/home/kray\
-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certifi\
cates.wl::Task14AmbiguityPhysicalSector.NullIdealExample", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/BoundaryCalibrationDecision_Certificates.wl::Task14AmbiguityPhysicalS\
ector.VisibleExample", "RepresentativeModelFamily" -> 
     "Exact five-basis null-ideal ambiguity model", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:ambiguity-physically-visible", 
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model.", "Method" -> "Exact visible countermodel where ad_A \
acts nontrivially on the physical sector outside the null ideal.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"Physical visibility is shown only on explicit bracket models."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task14AmbiguityPhysicalSect\
or.VisibleExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/M\
athematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task14Am\
biguityPhysicalSector.InvisibleExample", "RepresentativeModelFamily" -> 
     "Exact five-basis visible-ambiguity commutator model", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:class-defined-physical-derivation", 
    "Assumptions" -> "Physical sector, physical null ideal, and ambiguity \
directions on an explicit bracket model.", "Method" -> "Exact quotient \
theorem: ad_A maps the physical sector into the null ideal iff the induced \
physical derivation is representative-independent modulo that ideal.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The physical quotient and null ideal are \
represented by explicit finite-dimensional subspaces.", 
      "No abstract AQFT/HLS quotient construction is attempted."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task15ClassDefinedPhysicalD\
erivation.NullIdealExample", "CounterexampleArtifact" -> "/home/kray-l8/work/\
2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl:\
:Task15ClassDefinedPhysicalDerivation.VisibleExample", 
    "RepresentativeModelFamily" -> 
     "Exact on-the-nose, null-ideal, and visible ambiguity model family", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2055-2140 plus WL class-defined-derivation lane"\
|>, <|"TheoremLabel" -> "task:strict-boundary-record-invariance", 
    "Assumptions" -> "Boundary readout on the strict record sector D_A \
\[CircleTimes] 1_B with classical ledger projectors on A.", 
    "Method" -> "Exact symbolic proof that BoundaryReadout([X,O]) = 0 for all \
strict-record observables O in D_A \[CircleTimes] 1_B.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The proof is finite-dimensional and exact for \
the tested dimensions only.", "The induced strict-record derivation is \
collapsed by the readout map itself."}, "CertificateArtifact" -> "/home/kray-\
l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certific\
ates.wl::Task16StrictBoundaryRecord.{2, 2}", "CounterexampleArtifact" -> "/ho\
me/kray-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_\
Certificates.wl::Task16StrictBoundaryRecord.{2, \
2}.TrivializationWitnessCommutator", "RepresentativeModelFamily" -> "Generic \
symbolic strict-record sectors on dimensions (2,2), (2,3), and (3,2)", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane"|>, 
   <|"TheoremLabel" -> "task:controlled-boundary-reduction", 
    "Assumptions" -> "Controlled boundary observables Sum_i Pi^(A) \
\[CircleTimes] O_i^(B) and a general ambiguity operator K on A \[CircleTimes] \
B.", "Method" -> "Exact symbolic reduction under controlled projection: \
off-diagonal ledger ambiguity is killed and only diagonal controlled B-block \
commutators survive.", "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The reduction is proved on finite matrix \
algebras with rank-one ledger projectors."}, "CertificateArtifact" -> "/home/\
kray-l8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Cer\
tificates.wl::Task17ControlledBoundarySector.{2, 2}", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/BoundaryCalibrationDecision_Certificates.wl::Task18SplitWeldedBoundar\
yInvariance.UnsafeFamily", "RepresentativeModelFamily" -> 
     "Generic symbolic controlled sectors on dimensions (2,2), (2,3), and \
(3,2)", "NoApproximationQ" -> True, "Source" -> 
     "UOM/summability_split_note.tex:743-792 plus WL boundary-sector lane"|>, 
   <|"TheoremLabel" -> "task:boundary-class-defined-derivation-strong", 
    "Assumptions" -> "Controlled boundary sector and ambiguity directions on \
split+welded boundary models.", "Method" -> "Exact controlled-sector \
criterion with literal operator-level ambiguity triviality.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Strong class-definedness is tested only on \
explicit split+welded toy families."}, "CertificateArtifact" -> "/home/kray-l\
8/work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certifica\
tes.wl::Task18SplitWeldedBoundaryInvariance.SafeFamily", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/BoundaryCalibrationDecision_Certificates.wl::Task18SplitWeldedBoundar\
yInvariance.UnsafeFamily", "RepresentativeModelFamily" -> 
     "Safe off-diagonal, unsafe visible, and borderline null-ideal families", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane"|>, 
   <|"TheoremLabel" -> "task:boundary-class-defined-derivation-mod-null", 
    "Assumptions" -> "Controlled boundary sector and a chosen boundary null \
ideal on the completion sector B.", "Method" -> 
     "Exact controlled-sector criterion modulo the chosen boundary null \
ideal.", "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The boundary null ideal is model data, not yet \
derived from an abstract AQFT/HLS construction."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task18SplitWeldedBoundaryIn\
variance.BorderlineFamily", "CounterexampleArtifact" -> "/home/kray-l8/work/2\
T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::\
Task18SplitWeldedBoundaryInvariance.UnsafeFamily", 
    "RepresentativeModelFamily" -> 
     "Safe off-diagonal, unsafe visible, and borderline null-ideal families", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane"|>, 
   <|"TheoremLabel" -> "task:boundary-expectation-vs-operator-invisibility", 
    "Assumptions" -> "Controlled boundary sector together with diagonal \
boundary-classical states.", "Method" -> "Side-by-side exact comparison of \
operator-level and boundary-classical expectation-level invisibility.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Expectation-level invisibility is tested only \
against the chosen diagonal boundary-classical states."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task18SplitWeldedBoundaryIn\
variance.UnsafeFamily", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Ma\
in/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task\
18SplitWeldedBoundaryInvariance.FalseOverreachModel", 
    "RepresentativeModelFamily" -> "Unsafe 2x2 controlled-visible family", 
    "NoApproximationQ" -> True, "Source" -> 
     "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane"|>, 
   <|"TheoremLabel" -> "task:boundary-nontriviality-test", 
    "Assumptions" -> "Controlled boundary sector, boundary null ideal, and a \
candidate boundary generator J.", "Method" -> "Exact search for a \
controlled-sector family with nonzero induced derivation and ambiguity \
invisibility modulo the boundary null ideal.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"The nontriviality test is established on \
explicit split+welded toy families rather than a full transported ambiguity \
class."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Ce\
rtificates/BoundaryCalibrationDecision_Certificates.wl::Task18SplitWeldedBoun\
daryInvariance.BorderlineFamily", "CounterexampleArtifact" -> "/home/kray-l8/\
work/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificate\
s.wl::Task16StrictBoundaryRecord.{2, 2}.TrivializationWitnessCommutator", 
    "RepresentativeModelFamily" -> 
     "Borderline 2x3 split+welded null-ideal family", 
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:7\
43-856 plus WL split+welded boundary lane"|>, 
   <|"TheoremLabel" -> "task:boundary-calibration-decision", 
    "Assumptions" -> "Strict record sector, controlled boundary sector, and \
split+welded safe/unsafe/borderline ambiguity families.", 
    "Method" -> "Decision extracted from exact strict-record theorems plus \
safe/unsafe/borderline split+welded model families.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Decision A is conditional on the diagonal \
controlled ambiguity criterion and is not yet derived from the full Main/UOM \
assumptions."}, "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathemat\
ica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task19BoundaryC\
alibrationDecision", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/\
Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.wl::Task18S\
plitWeldedBoundaryInvariance.UnsafeFamily", "RepresentativeModelFamily" -> "S\
trict-record theorem family plus split+welded safe/unsafe/borderline \
families", "NoApproximationQ" -> True, "Source" -> 
     "UOM/summability_split_note.tex:743-856 plus WL split+welded boundary \
lane"|>, <|"TheoremLabel" -> "task:Peierls-odd-derivation", 
    "Assumptions" -> "Explicit associative bracket model with parity \
involution and odd generator J.", "Method" -> "Exact associative-model \
commutator bracket with parity involution; delta_J(A) = {J, A} checked on \
basis products.", "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"The bracket lane is audited only on explicit associative models.", 
      "Locality/AQFT/HLS semantics remain imported metadata."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task12PeierlsOddDerivation"\
, "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certifi\
cates/BoundaryCalibrationDecision_Certificates.wl::Task14AmbiguityPhysicalSec\
tor.EvenJBrokenExample", "RepresentativeModelFamily" -> 
     "Exact four-basis associative commutator models with parity involution", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2055-2130"|>, 
   <|"TheoremLabel" -> "task:delta-calibration-sensitivity", 
    "Assumptions" -> "Two canonical representatives Jcan_B1 and Jcan_B2 in an \
explicit bracket model.", "Method" -> "Exact derivation-difference formula \
delta_B1 - delta_B2 = ad_{Jcan_B1 - Jcan_B2}, plus ambiguity-trivial and \
ambiguity-visible bracket models.", "Status" -> 
     "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Physical invisibility is represented by \
explicit bracket-trivial ambiguity models.", 
      "No AQFT/HLS observable-sector completion is attempted."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/BoundaryCalibrationDecision_Certificates.wl::Task13CalibrationSensitivit\
y.InvisibleSensitivityExample", "CounterexampleArtifact" -> "/home/kray-l8/wo\
rk/2T/Main/Mathematica/Certificates/BoundaryCalibrationDecision_Certificates.\
wl::Task13CalibrationSensitivity.VisibleSensitivityExample", 
    "RepresentativeModelFamily" -> 
     "Exact ambiguity-trivial and ambiguity-visible commutator models", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:2072-2084 plus WL calibration-sensitivity lane"|>\
, <|"TheoremLabel" -> "thm:finite-cutoff-canonical-odd-spectral-selection", 
    "Assumptions" -> 
     "Certified compressed spectral regime and rank-one LoG operator.", 
    "Method" -> "Exact eigenvalue/projector certificates.", 
    "Status" -> "deferred", "ScopeClass" -> "deferred", 
    "SurrogateBlindSpots" -> {"Branchwise smooth transport of the projector \
may remain an imported input."}, "CertificateArtifact" -> "Deferred", 
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" -> 
     "To be assigned", "NoApproximationQ" -> True, 
    "Source" -> "UOM/compressed_log_spectral_selection_note.tex:259-288"|>, 
   <|"TheoremLabel" -> "thm:Main-Peierls-Hamiltonization", 
    "Assumptions" -> "Canonical representative plus imported bracket axioms \
on a concrete model.", "Method" -> "Formal rewrite + exact model checks.", 
    "Status" -> "deferred", "ScopeClass" -> "abstract-imported-assumptions", 
    "SurrogateBlindSpots" -> 
     {"Bracket locality and AQFT/HLS semantics stay imported.", 
      "Only explicit concrete models can be machine-audited here."}, 
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" -> 
     "Deferred", "RepresentativeModelFamily" -> 
     "Explicit bracket models only", "NoApproximationQ" -> True, 
    "Source" -> "Main/appendix_main.tex:2072-2084"|>}, 
 "Task2Schema" -> <|"ValidExamples" -> {<|"Name" -> "valid_basic_identity", 
      "Status" -> "exact finite-dimensional certificate", "ValidQ" -> True, 
      "FailedChecks" -> {}|>, <|"Name" -> "valid_nontrivial_gram", 
      "Status" -> "exact finite-dimensional certificate", "ValidQ" -> True, 
      "FailedChecks" -> {}|>, <|"Name" -> "valid_zero_ambiguity", 
      "Status" -> "exact finite-dimensional certificate", "ValidQ" -> True, 
      "FailedChecks" -> {}|>}, "InvalidExamples" -> 
    {<|"Name" -> "invalid_parity_tag", "Status" -> 
       "exact finite-dimensional certificate", "ValidQ" -> False, 
      "ExpectedFailure" -> "Odd space", "FailedChecks" -> {"Odd space"}|>, 
     <|"Name" -> "invalid_chi_on_ambiguity", "Status" -> 
       "exact finite-dimensional certificate", "ValidQ" -> False, 
      "ExpectedFailure" -> "Chi annihilates Aminus", 
      "FailedChecks" -> {"Chi annihilates Aminus", 
        "Class constancy of chi"}|>, <|"Name" -> "invalid_positive_form", 
      "Status" -> "exact finite-dimensional certificate", "ValidQ" -> False, 
      "ExpectedFailure" -> "Positive symmetric B", "FailedChecks" -> 
       {"Positive symmetric B"}|>}|>, "Task3_5ActiveTransport" -> 
  <|"CertifiedModel" -> <|"Name" -> "certified_polynomial_branch", 
     "AcceptedBranchComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1213419 && 
        MainProof`ActiveTransport`Private`lambda$1213419 <= 3}, 
     "SignDefinedComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1213419 && 
        MainProof`ActiveTransport`Private`lambda$1213419 <= 3}, 
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" -> 
      1 + MainProof`ActiveTransport`Private`lambda$1213419, 
     "EpsilonExpression" -> 1, "Claims" -> <|"Annihilation of Aminus" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True|>, "Constancy on affine class" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "Counterexample" -> {}|>, 
       "Normalization chi = nu^-1 rho" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True|>, "Continuity of dominant scalar" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "WitnessDetails" -> <||>|>, 
       "Sign defined on full branch" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "UndefinedWitness" -> {}|>, 
       "Local constancy of branch sign on sign-defined components" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "ComponentSigns" -> 
          <|1 <= MainProof`ActiveTransport`Private`lambda$1213419 && 
             MainProof`ActiveTransport`Private`lambda$1213419 <= 3 -> 1|>|>, 
       "Sign changes only across zeros of rho or nu" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>, 
   "BrokenModels" -> {<|"Name" -> "broken_zero_sign_undefined", 
      "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3}, 
      "SignDefinedComponents" -> 
       {2 < MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3, 
        MainProof`ActiveTransport`Private`lambda$1213444 < 2 && 
         1 <= MainProof`ActiveTransport`Private`lambda$1213444}, 
      "DerivedChi" -> {0, 0, 
        -2 + MainProof`ActiveTransport`Private`lambda$1213444}, 
      "DominantScalar" -> 
       -2 + MainProof`ActiveTransport`Private`lambda$1213444, 
      "EpsilonExpression" -> 
       -2 + MainProof`ActiveTransport`Private`lambda$1213444, 
      "Claims" -> <|"Annihilation of Aminus" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True|>, "Constancy on affine class" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "Counterexample" -> {}|>, 
        "Normalization chi = nu^-1 rho" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True|>, "Continuity of dominant scalar" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "WitnessDetails" -> <||>|>, 
        "Sign defined on full branch" -> 
         <|"Status" -> "counterexample found", "Certified" -> False, 
          "UndefinedWitness" -> 
           {{MainProof`ActiveTransport`Private`lambda$1213444 -> 2}}|>, 
        "Local constancy of branch sign on sign-defined components" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ComponentSigns" -> 
           <|2 < MainProof`ActiveTransport`Private`lambda$1213444 && 
              MainProof`ActiveTransport`Private`lambda$1213444 <= 3 -> 1, 
            MainProof`ActiveTransport`Private`lambda$1213444 < 2 && 
              1 <= MainProof`ActiveTransport`Private`lambda$1213444 -> 
             -1|>|>, "Sign changes only across zeros of rho or nu" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ExcludedSetWitness" -> 
           {{MainProof`ActiveTransport`Private`lambda$1213444 -> 2}}|>|>|>, 
     <|"Name" -> "broken_jump_discontinuity", "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3}, 
      "SignDefinedComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3}, 
      "DerivedChi" -> {0, 0, 1 + UnitStep[
          -2 + MainProof`ActiveTransport`Private`lambda$1213444]}, 
      "DominantScalar" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$1213444], 
      "EpsilonExpression" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$1213444], 
      "Claims" -> <|"Annihilation of Aminus" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True|>, "Constancy on affine class" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "Counterexample" -> {}|>, 
        "Normalization chi = nu^-1 rho" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True|>, "Continuity of dominant scalar" -> 
         <|"Status" -> "counterexample found", "Certified" -> False, 
          "WitnessDetails" -> <|2 -> <|"LeftLimit" -> 1, "RightLimit" -> 2, 
              "Value" -> 2|>|>|>, "Sign defined on full branch" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "UndefinedWitness" -> {}|>, 
        "Local constancy of branch sign on sign-defined components" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ComponentSigns" -> 
           <|1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
              MainProof`ActiveTransport`Private`lambda$1213444 <= 3 -> 1|>|>, 
        "Sign changes only across zeros of rho or nu" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>, 
     <|"Name" -> "broken_ambiguity_not_in_kernel", 
      "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3}, 
      "SignDefinedComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
         MainProof`ActiveTransport`Private`lambda$1213444 <= 3}, 
      "DerivedChi" -> {1, 0, 1}, "DominantScalar" -> 1, 
      "EpsilonExpression" -> 1, "Claims" -> <|"Annihilation of Aminus" -> 
         <|"Status" -> "counterexample found", "Certified" -> False|>, 
        "Constancy on affine class" -> <|"Status" -> "counterexample found", 
          "Certified" -> False, "Counterexample" -> 
           {{MainProof`ActiveTransport`Private`lambda$1213444 -> 1, 
             MainProof`ActiveTransport`Private`a1$1213566 -> -1, 
             MainProof`ActiveTransport`Private`a2$1213566 -> 99/5}}|>, 
        "Normalization chi = nu^-1 rho" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True|>, "Continuity of dominant scalar" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "WitnessDetails" -> <||>|>, 
        "Sign defined on full branch" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "UndefinedWitness" -> {}|>, 
        "Local constancy of branch sign on sign-defined components" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ComponentSigns" -> 
           <|1 <= MainProof`ActiveTransport`Private`lambda$1213444 && 
              MainProof`ActiveTransport`Private`lambda$1213444 <= 3 -> 1|>|>, 
        "Sign changes only across zeros of rho or nu" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>}|>, 
 "Task4Calibration" -> <|"ValidExample" -> 
    <|"InputChecks" -> <|"Normalization chi(jSharp)=1" -> True, 
       "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" -> 
        True, "Kernel metric dimensions" -> True, "Kernel metric coercive" -> 
        True, "Beta positive" -> True, "M invertible" -> True, 
       "Aminus in ker chi" -> True|>, "B" -> {{5, 0, 0}, {0, 2, 1}, {0, 1, 
      3}}, "ProductDecomposition" -> True, "Symmetry" -> True, 
     "PositiveDefinite" -> True, "OrthogonalToKerChi" -> True, 
     "OrthogonalToAminus" -> True, "jSharpNorm" -> True, 
     "AdmissibleChoice_jSharp_equals_epsilon_JXi" -> True|>, 
   "BrokenExamples" -> {<|"Name" -> "beta_nonpositive", 
      "ExpectedFailure" -> "Beta positive", "Checks" -> 
       <|"Normalization chi(jSharp)=1" -> True, 
        "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" -> 
         True, "Kernel metric dimensions" -> True, 
        "Kernel metric coercive" -> True, "Beta positive" -> False, 
        "M invertible" -> True, "Aminus in ker chi" -> True|>, 
      "ExpectedFailureObservedQ" -> True|>, 
     <|"Name" -> "kernel_metric_not_coercive", "ExpectedFailure" -> 
       "Kernel metric coercive", "Checks" -> 
       <|"Normalization chi(jSharp)=1" -> True, 
        "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" -> 
         True, "Kernel metric dimensions" -> True, 
        "Kernel metric coercive" -> False, "Beta positive" -> True, 
        "M invertible" -> True, "Aminus in ker chi" -> True|>, 
      "ExpectedFailureObservedQ" -> True|>, 
     <|"Name" -> "wrong_jSharp_normalization", "ExpectedFailure" -> 
       "Normalization chi(jSharp)=1", "Checks" -> 
       <|"Normalization chi(jSharp)=1" -> False, 
        "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" -> 
         True, "Kernel metric dimensions" -> True, 
        "Kernel metric coercive" -> True, "Beta positive" -> True, 
        "M invertible" -> True, "Aminus in ker chi" -> True|>, 
      "ExpectedFailureObservedQ" -> True|>, 
     <|"Name" -> "Aminus_not_in_kernel", "ExpectedFailure" -> 
       "Aminus in ker chi", "Checks" -> <|"Normalization chi(jSharp)=1" -> 
         True, "Kernel basis lies in ker chi" -> True, 
        "Kernel basis full rank" -> True, "Kernel metric dimensions" -> True, 
        "Kernel metric coercive" -> True, "Beta positive" -> True, 
        "M invertible" -> True, "Aminus in ker chi" -> False|>, 
      "ExpectedFailureObservedQ" -> True|>}|>, 
 "Task5CanonicalRepresentative" -> 
  <|"ValidExample" -> <|"UFullColumnRank" -> True, "GA_PositiveDefinite" -> 
      True, "ChiAnnihilatesAminus" -> True, "JcanInAffineClass" -> True, 
     "ChiJcanEqualsEpsilon" -> True, "Orthogonality" -> True, 
     "MinimalityDifferenceIdentity" -> True, 
     "OrthogonalityImpliesCanonicalCoordinates" -> True, 
     "UniqueMinimizer" -> True, "ProjectorIdempotent" -> True, 
     "ProjectorFormula" -> True, "RepresentativeShiftInvariant" -> True, 
     "QuadraticOptimizationCrossCheck" -> <|"Status" -> "Executed", 
       "Coordinates" -> {a1265[1] -> -2., a1265[2] -> 3.}, 
       "PrimalMinimumValue" -> 5., "ExpectedCoordinates" -> {-2., 3.}, 
       "ExpectedValue" -> 5.|>|>, "BrokenExamples" -> 
    {<|"Name" -> "rank_deficient_U", "ExpectedFailure" -> "UFullColumnRank", 
      "ObservedValue" -> False, "ExpectedFailureObservedQ" -> True|>, 
     <|"Name" -> "non_positive_B", "ExpectedFailure" -> 
       "GA_PositiveDefinite", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True|>, 
     <|"Name" -> "chi_not_constant_on_affine_class", 
      "ExpectedFailure" -> "ChiAnnihilatesAminus", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True|>}|>, 
 "Task6QuotientDescent" -> 
  <|"ValidExample" -> <|"ChiAnnihilatesAminus" -> True, 
     "CosetConstancy" -> True, "QuotientCoordinatesFullRowRank" -> True, 
     "QuotientDirectSumDecomposition" -> True, "DescendedFunctionalExists" -> 
      True, "DescendedFunctionalUnique" -> True, "AffineClassConstancy" -> 
      True, "AffineClassQuotientValue" -> True, 
     "ChiLevelRepresentativeSearchReduction" -> True, 
     "RhoLevelRepresentativeSearchReduction" -> True, 
     "UnscaledChiCompatibilityWitness" -> {{r1298 -> 1}}, 
     "DescendedFunctionalCoordinates" -> {1}, "QuotientCoordinateMatrix" -> 
      {{0, 0, 1}}|>, "BrokenExamples" -> 
    {<|"Name" -> "ambiguity_not_in_kernel", "ExpectedFailure" -> 
       "ChiAnnihilatesAminus", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True, "CounterexampleWitness" -> 
       {{r1303 -> 1}}|>}|>, "Task7Representability" -> 
  <|"ValidExamples" -> {<|"RepresentableQ" -> True, 
      "ImageMembershipCriterion" -> True, "ObstructionSpaceBasis" -> {}, 
      "GaugeSpaceBasis" -> {{-1, -1, 1}}, "SolutionFamily" -> 
       {{f1304[2] -> 1 + f1304[1], f1304[3] -> 2 - f1304[1]}}, 
      "OneExactSolution" -> {2, 3, 0}, "ExactSolutionCheck" -> True, 
      "GaugeFamilyCheck" -> True, "ObstructionWitness" -> 
       Missing["NoObstruction"], "LocalityStatus" -> "imported"|>, 
     <|"RepresentableQ" -> True, "ImageMembershipCriterion" -> True, 
      "ObstructionSpaceBasis" -> {}, "GaugeSpaceBasis" -> {}, 
      "SolutionFamily" -> {{f1305[1] -> 1, f1305[2] -> -1}}, 
      "OneExactSolution" -> {1, -1}, "ExactSolutionCheck" -> True, 
      "GaugeFamilyCheck" -> True, "ObstructionWitness" -> 
       Missing["NoObstruction"], "LocalityStatus" -> "imported"|>}, 
   "BrokenExamples" -> {<|"Name" -> "physical_target_outside_image", 
      "ExpectedFailure" -> "RepresentableQ", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True, "ObstructionWitness" -> 
       <|"ObstructionVector" -> {0, 1}, "ObstructionValue" -> 1|>|>}|>, 
 "Task9JcanBranchRegularity" -> 
  <|"ValidExample" -> <|"GramBlock" -> 
      {{2 + MainProof`JcanRegularity`Private`lambda$1214048 + 
         3*(1 + MainProof`JcanRegularity`Private`lambda$1214048)^2}}, 
     "GramDeterminant" -> 
      5 + 7*MainProof`JcanRegularity`Private`lambda$1214048 + 
       3*MainProof`JcanRegularity`Private`lambda$1214048^2, 
     "InputRationalQ" -> True, "GramInvertibleOnDomain" -> True, 
     "JcanFormula" -> {1 + MainProof`JcanRegularity`Private`lambda$1214048 + 
        (-9 - 7*MainProof`JcanRegularity`Private`lambda$1214048 + 
          2*MainProof`JcanRegularity`Private`lambda$1214048^2)/
         (5 + 7*MainProof`JcanRegularity`Private`lambda$1214048 + 
          3*MainProof`JcanRegularity`Private`lambda$1214048^2), 
       2 - MainProof`JcanRegularity`Private`lambda$1214048 + 
        ((1 + MainProof`JcanRegularity`Private`lambda$1214048)*
          (-9 - 7*MainProof`JcanRegularity`Private`lambda$1214048 + 
           2*MainProof`JcanRegularity`Private`lambda$1214048^2))/
         (5 + 7*MainProof`JcanRegularity`Private`lambda$1214048 + 
          3*MainProof`JcanRegularity`Private`lambda$1214048^2), 1}, 
     "JcanEntriesRationalQ" -> True, "JcanContinuousOnDomain" -> True, 
     "SingularSet" -> False, "SingularitiesOnlyAtGramDegeneracy" -> True|>, 
   "DegenerateExample" -> <|"GramBlock" -> 
      {{MainProof`JcanRegularity`Private`lambda$1214048^2}}, 
     "GramDeterminant" -> MainProof`JcanRegularity`Private`lambda$1214048^2, 
     "InputRationalQ" -> True, "GramInvertibleOnDomain" -> False, 
     "JcanFormula" -> {0, 1}, "JcanEntriesRationalQ" -> True, 
     "JcanContinuousOnDomain" -> True, "SingularSet" -> 
      MainProof`JcanRegularity`Private`lambda$1214048 == 0, 
     "SingularitiesOnlyAtGramDegeneracy" -> True|>|>, 
 "Task11CalibrationComparison" -> 
  <|"NonInvariantExample" -> <|"Calibration1" -> <|"U" -> {{0}, {1}, {0}}, 
       "B" -> {{3, 0, 0}, {0, 1, 0}, {0, 0, 1}}, "J0" -> {1, 1, 1}, 
       "Chi" -> {1, 0, 0}, "Epsilon" -> 1, "GA" -> {{1}}, 
       "LinearTerm" -> {-1}, "aStar" -> {-1}, "Jcan" -> {1, 0, 1}, 
       "Projector" -> {{0, 0, 0}, {0, 1, 0}, {0, 0, 0}}|>, 
     "Calibration2" -> <|"U" -> {{0}, {1}, {0}}, "B" -> {{3, 0, 0}, {0, 2, 
        1}, {0, 1, 1}}, "J0" -> {1, 1, 1}, "Chi" -> {1, 0, 0}, 
       "Epsilon" -> 1, "GA" -> {{2}}, "LinearTerm" -> {-3}, 
       "aStar" -> {-3/2}, "Jcan" -> {1, -1/2, 1}, "Projector" -> 
        {{0, 0, 0}, {0, 1, 1/2}, {0, 0, 0}}|>, "Jcan1" -> {1, 0, 1}, 
     "Jcan2" -> {1, -1/2, 1}, "Projector1" -> {{0, 0, 0}, {0, 1, 0}, {0, 0, 
      0}}, "Projector2" -> {{0, 0, 0}, {0, 1, 1/2}, {0, 0, 0}}, 
     "DeltaJ" -> {0, 1/2, 0}, "DeltaCoordinates" -> {1/2}, 
     "DifferenceFormula" -> True, "DifferenceInAminus" -> True, 
     "SameJcanQ" -> False, "EqualityCriterion_ProjectorDifferenceKillsJ0" -> 
      True, "QuotientScalarInvariant" -> True, "VisibilityMapKillsAminus" -> 
      True, "VisibleOutputInvariant" -> True, 
     "VisibilityCriterionImpliesInvariant" -> True, 
     "NonInvarianceWitness" -> True|>, "EqualExample" -> 
    <|"Calibration1" -> <|"U" -> {{0}, {1}, {0}}, "B" -> {{3, 0, 0}, {0, 1, 
        0}, {0, 0, 1}}, "J0" -> {1, 1, 1}, "Chi" -> {1, 0, 0}, 
       "Epsilon" -> 1, "GA" -> {{1}}, "LinearTerm" -> {-1}, "aStar" -> {-1}, 
       "Jcan" -> {1, 0, 1}, "Projector" -> {{0, 0, 0}, {0, 1, 0}, {0, 0, 
        0}}|>, "Calibration2" -> <|"U" -> {{0}, {1}, {0}}, 
       "B" -> {{3, 0, 0}, {0, 3, 0}, {0, 0, 5}}, "J0" -> {1, 1, 1}, 
       "Chi" -> {1, 0, 0}, "Epsilon" -> 1, "GA" -> {{3}}, 
       "LinearTerm" -> {-3}, "aStar" -> {-1}, "Jcan" -> {1, 0, 1}, 
       "Projector" -> {{0, 0, 0}, {0, 1, 0}, {0, 0, 0}}|>, 
     "Jcan1" -> {1, 0, 1}, "Jcan2" -> {1, 0, 1}, "Projector1" -> {{0, 0, 0}, 
      {0, 1, 0}, {0, 0, 0}}, "Projector2" -> {{0, 0, 0}, {0, 1, 0}, {0, 0, 
      0}}, "DeltaJ" -> {0, 0, 0}, "DeltaCoordinates" -> {0}, 
     "DifferenceFormula" -> True, "DifferenceInAminus" -> True, 
     "SameJcanQ" -> True, "EqualityCriterion_ProjectorDifferenceKillsJ0" -> 
      True, "QuotientScalarInvariant" -> True, "VisibilityMapKillsAminus" -> 
      True, "VisibleOutputInvariant" -> True, 
     "VisibilityCriterionImpliesInvariant" -> True, 
     "NonInvarianceWitness" -> False|>|>, "Task12PeierlsOddDerivation" -> 
  <|"ModelChecks" -> <|"AssociativeProduct" -> True, 
     "GammaInvolution" -> True, "GammaProductAutomorphism" -> True, 
     "GammaBracketCompatibility" -> True, "PhysicalSectorBasis" -> {{1, 0}, 
      {0, 1}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {1}, {0}}, 
     "NullIdealBasis" -> Automatic|>, "JOdd" -> True, 
   "GammaOddDerivation" -> True, "DerivationOnBasis" -> True, 
   "NontrivialOnPhysicalSector" -> True|>, "Task13CalibrationSensitivity" -> 
  <|"InvisibleSensitivityExample" -> <|"DeltaJ" -> {0, 0, -1, 0}, 
     "DifferenceFormula" -> True, "DeltaJOdd" -> True, 
     "DeltaJInAmbiguity" -> True, 
     "AmbiguityBracketTrivialOnPhysicalSector" -> True, 
     "PhysicalSectorInvariantUnderDifference" -> True, 
     "PhysicalSectorNonInvariantWitness" -> False|>, 
   "VisibleSensitivityExample" -> <|"DeltaJ" -> {0, 0, -1, 0}, 
     "DifferenceFormula" -> True, "DeltaJOdd" -> True, 
     "DeltaJInAmbiguity" -> True, 
     "AmbiguityBracketTrivialOnPhysicalSector" -> False, 
     "PhysicalSectorInvariantUnderDifference" -> False, 
     "PhysicalSectorNonInvariantWitness" -> True|>|>, 
 "Task14AmbiguityPhysicalSector" -> 
  <|"InvisibleExample" -> <|"ModelChecks" -> <|"AssociativeProduct" -> True, 
       "GammaInvolution" -> True, "GammaProductAutomorphism" -> True, 
       "GammaBracketCompatibility" -> True, "PhysicalSectorBasis" -> {{1, 0}, 
        {0, 1}, {0, 0}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {0}, 
        {1}, {0}}, "NullIdealBasis" -> {{}, {}, {}, {}, {}}|>, 
     "DifferenceFormula" -> True, "PhysicalImagesOfAmbiguity" -> 
      {{0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}}, "BracketTrivialOnTheNose" -> True, 
     "ActsIntoNullIdeal" -> True, "PhysicallyVisible" -> False, 
     "Classification" -> "bracket-trivial on the nose"|>, 
   "NullIdealExample" -> <|"ModelChecks" -> <|"AssociativeProduct" -> True, 
       "GammaInvolution" -> True, "GammaProductAutomorphism" -> True, 
       "GammaBracketCompatibility" -> True, "PhysicalSectorBasis" -> {{1, 0}, 
        {0, 1}, {0, 0}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {0}, 
        {1}, {0}}, "NullIdealBasis" -> {{0}, {0}, {1}, {0}, {0}}|>, 
     "DifferenceFormula" -> True, "PhysicalImagesOfAmbiguity" -> 
      {{0, 0, 0, 0, 0}, {0, 0, 1, 0, 0}}, "BracketTrivialOnTheNose" -> False, 
     "ActsIntoNullIdeal" -> True, "PhysicallyVisible" -> False, 
     "Classification" -> "trivial modulo physical null ideal"|>, 
   "VisibleExample" -> <|"ModelChecks" -> <|"AssociativeProduct" -> True, 
       "GammaInvolution" -> True, "GammaProductAutomorphism" -> True, 
       "GammaBracketCompatibility" -> True, "PhysicalSectorBasis" -> {{1, 0}, 
        {0, 1}, {0, 0}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {0}, 
        {1}, {0}}, "NullIdealBasis" -> {{}, {}, {}, {}, {}}|>, 
     "DifferenceFormula" -> True, "PhysicalImagesOfAmbiguity" -> 
      {{0, 0, 0, 0, 0}, {0, 0, 0, 1, 0}}, "BracketTrivialOnTheNose" -> False, 
     "ActsIntoNullIdeal" -> False, "PhysicallyVisible" -> True, 
     "Classification" -> "physically visible"|>, 
   "EvenJBrokenExample" -> <|"ModelChecks" -> <|"AssociativeProduct" -> True, 
       "GammaInvolution" -> True, "GammaProductAutomorphism" -> True, 
       "GammaBracketCompatibility" -> True, "PhysicalSectorBasis" -> {{1, 0}, 
        {0, 1}, {0, 0}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {0}, 
        {1}, {0}}, "NullIdealBasis" -> {{}, {}, {}, {}, {}}|>, 
     "JOdd" -> False, "GammaOddDerivation" -> False, 
     "DerivationOnBasis" -> True, "NontrivialOnPhysicalSector" -> False|>|>, 
 "Task15ClassDefinedPhysicalDerivation" -> 
  <|"OnTheNoseExample" -> <|"AmbiguityImagesOnPhysicalBasis" -> 
      {{{0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}}}, "OnTheNoseTriviality" -> True, 
     "ActsIntoNullIdeal" -> True, "GenericShiftDifferenceInNullIdeal" -> 
      True, "GenericShiftDifferenceCoordinates" -> {{}, {}}, 
     "ClassDefinedOnPhysicalQuotient" -> True, "VisibleFailureWitness" -> 
      False|>, "NullIdealExample" -> <|"AmbiguityImagesOnPhysicalBasis" -> 
      {{{0, 0, 0, 0, 0}, {0, 0, 1, 0, 0}}}, "OnTheNoseTriviality" -> False, 
     "ActsIntoNullIdeal" -> True, "GenericShiftDifferenceInNullIdeal" -> 
      True, "GenericShiftDifferenceCoordinates" -> 
      {{0}, {MainProof`ClassDefinedDerivation`Private`a[1]}}, 
     "ClassDefinedOnPhysicalQuotient" -> True, "VisibleFailureWitness" -> 
      False|>, "VisibleExample" -> <|"AmbiguityImagesOnPhysicalBasis" -> 
      {{{0, 0, 0, 0, 0}, {0, 0, 0, 1, 0}}}, "OnTheNoseTriviality" -> False, 
     "ActsIntoNullIdeal" -> False, "GenericShiftDifferenceInNullIdeal" -> 
      False, "GenericShiftDifferenceCoordinates" -> {{}, {}}, 
     "ClassDefinedOnPhysicalQuotient" -> False, "VisibleFailureWitness" -> 
      True|>|>, "Task16StrictBoundaryRecord" -> 
  <|"{2, 2}" -> <|"Dimension" -> {2, 2}, "ReadoutAnnihilatesCommutator" -> 
      True, "InducedDerivationZeroOnStrictRecordSector" -> True, 
     "NonzeroOperatorLevelWitness" -> True, "TrivializationRisk" -> True, 
     "TrivializationWitnessOperator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, {1, 0, 
      0, 0}, {0, 1, 0, 0}}, "TrivializationWitnessObservable" -> {{1, 0, 0, 
      0}, {0, 1, 0, 0}, {0, 0, 2, 0}, {0, 0, 0, 2}}, 
     "TrivializationWitnessCommutator" -> {{0, 0, 1, 0}, {0, 0, 0, 1}, 
       {-1, 0, 0, 0}, {0, -1, 0, 0}}|>, 
   "{2, 3}" -> <|"Dimension" -> {2, 3}, "ReadoutAnnihilatesCommutator" -> 
      True, "InducedDerivationZeroOnStrictRecordSector" -> True, 
     "NonzeroOperatorLevelWitness" -> True, "TrivializationRisk" -> True, 
     "TrivializationWitnessOperator" -> {{0, 0, 0, 1, 0, 0}, {0, 0, 0, 0, 1, 
      0}, {0, 0, 0, 0, 0, 1}, {1, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0}, {0, 0, 
      1, 0, 0, 0}}, "TrivializationWitnessObservable" -> {{1, 0, 0, 0, 0, 0}, 
      {0, 1, 0, 0, 0, 0}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 2, 0, 0}, {0, 0, 0, 
      0, 2, 0}, {0, 0, 0, 0, 0, 2}}, "TrivializationWitnessCommutator" -> 
      {{0, 0, 0, 1, 0, 0}, {0, 0, 0, 0, 1, 0}, {0, 0, 0, 0, 0, 1}, 
       {-1, 0, 0, 0, 0, 0}, {0, -1, 0, 0, 0, 0}, {0, 0, -1, 0, 0, 0}}|>, 
   "{3, 2}" -> <|"Dimension" -> {3, 2}, "ReadoutAnnihilatesCommutator" -> 
      True, "InducedDerivationZeroOnStrictRecordSector" -> True, 
     "NonzeroOperatorLevelWitness" -> True, "TrivializationRisk" -> True, 
     "TrivializationWitnessOperator" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 1, 0, 
      0}, {1, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 
      0, 0, 0, 0}}, "TrivializationWitnessObservable" -> {{1, 0, 0, 0, 0, 0}, 
      {0, 1, 0, 0, 0, 0}, {0, 0, 2, 0, 0, 0}, {0, 0, 0, 2, 0, 0}, {0, 0, 0, 
      0, 3, 0}, {0, 0, 0, 0, 0, 3}}, "TrivializationWitnessCommutator" -> 
      {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 1, 0, 0}, {-1, 0, 0, 0, 0, 0}, 
       {0, -1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}|>|>, 
 "Task17ControlledBoundarySector" -> 
  <|"{2, 2}" -> <|"Dimension" -> {2, 2}, "ControlledObservableQ" -> True, 
     "OffDiagonalLedgerPartKilled" -> True, "ControlledReductionFormula" -> 
      True, "ControlledBlocksFormula" -> 
      {{-(MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2], 0, 0}, 
       {MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1], 0, 0}, 
       {0, 0, -(MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2]}, 
       {0, 0, MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1]}}|>, 
   "{2, 3}" -> <|"Dimension" -> {2, 3}, "ControlledObservableQ" -> True, 
     "OffDiagonalLedgerPartKilled" -> True, "ControlledReductionFormula" -> 
      True, "ControlledBlocksFormula" -> 
      {{-(MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2]) - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1]) - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 3], 0, 0, 0}, 
       {MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1], 
        MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 3], 0, 0, 0}, 
       {MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 3], 
        MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 3], 
        MainProof`BoundaryAmbiguityReduction`Private`x[3, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][3, 2], 0, 0, 0}, 
       {0, 0, 0, -(MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2]) - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1]) - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 3]}, 
       {0, 0, 0, MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1], 
        MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 3]}, 
       {0, 0, 0, MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 3], 
        MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 3], 
        MainProof`BoundaryAmbiguityReduction`Private`x[6, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 3] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 3] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][3, 2]}}|>, 
   "{3, 2}" -> <|"Dimension" -> {3, 2}, "ControlledObservableQ" -> True, 
     "OffDiagonalLedgerPartKilled" -> True, "ControlledReductionFormula" -> 
      True, "ControlledBlocksFormula" -> 
      {{-(MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
           MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2], 0, 0, 0, 
        0}, {MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[2, 1]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[1, 2]*
          MainProof`BoundaryAmbiguityReduction`Private`o[1][2, 1], 0, 0, 0, 
        0}, {0, 0, -(MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
           MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2], 0, 0}, 
       {0, 0, MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[4, 3]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[3, 4]*
          MainProof`BoundaryAmbiguityReduction`Private`o[2][2, 1], 0, 0}, 
       {0, 0, 0, 0, -(MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
           MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 2]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 1], 
        -(MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
           MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 1]) + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 2] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 2]}, 
       {0, 0, 0, 0, MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 1] + 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 1] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 2], 
        MainProof`BoundaryAmbiguityReduction`Private`x[6, 5]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][1, 2] - 
         MainProof`BoundaryAmbiguityReduction`Private`x[5, 6]*
          MainProof`BoundaryAmbiguityReduction`Private`o[3][2, 1]}}|>|>, 
 "Task18SplitWeldedBoundaryInvariance" -> 
  <|"SafeFamily" -> <|"ModelChecks" -> Missing["NotProvided"], 
     "StrongClassDefinedQ" -> True, "ModNullClassDefinedQ" -> True, 
     "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" -> False, 
     "WitnessImage_J" -> {{0, -2, 0, 0, 0, 0}, {2, 0, 0, 0, 0, 0}, {0, 0, 0, 
      0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
     "WitnessImage_K" -> {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 
      0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
     "NontrivialControlledDerivationQ" -> True, 
     "AmbiguityInvisibleModNullQ" -> True, 
     "AmbiguityVisibleAtOperatorLevelQ" -> False|>, 
   "UnsafeFamily" -> <|"ModelChecks" -> Missing["NotProvided"], 
     "StrongClassDefinedQ" -> False, "ModNullClassDefinedQ" -> False, 
     "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" -> True, 
     "WitnessImage_J" -> {{-1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 
      0, 0}}, "WitnessImage_K" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, 
      {0, 0, 0, 0}}, "NontrivialControlledDerivationQ" -> True, 
     "AmbiguityInvisibleModNullQ" -> False, 
     "AmbiguityVisibleAtOperatorLevelQ" -> True|>, 
   "BorderlineFamily" -> <|"ModelChecks" -> Missing["NotProvided"], 
     "StrongClassDefinedQ" -> False, "ModNullClassDefinedQ" -> True, 
     "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" -> True, 
     "WitnessImage_J" -> {{1, 0, 0, 0, 0, 0}, {0, -1, 0, 0, 0, 0}, {0, 0, 0, 
      0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
     "WitnessImage_K" -> {{0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 
      0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}, 
     "NontrivialControlledDerivationQ" -> True, 
     "AmbiguityInvisibleModNullQ" -> True, 
     "AmbiguityVisibleAtOperatorLevelQ" -> False|>, 
   "FalseOverreachModel" -> <|"ModelChecks" -> Missing["NotProvided"], 
     "StrongClassDefinedQ" -> False, "ModNullClassDefinedQ" -> False, 
     "ExpectationLevelInvisibleQ" -> True, "OperatorLevelVisibleQ" -> True, 
     "WitnessImage_J" -> {{-1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 
      0, 0}}, "WitnessImage_K" -> {{0, 2, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, 
      {0, 0, 0, 0}}, "NontrivialControlledDerivationQ" -> True, 
     "AmbiguityInvisibleModNullQ" -> False, 
     "AmbiguityVisibleAtOperatorLevelQ" -> True|>|>, 
 "Task19BoundaryCalibrationDecision" -> <|"Decision" -> "Decision A", 
   "Sentence" -> "Boundary class-defined derivation is recovered on the \
controlled split+welded sector under the hypothesis that the diagonal \
controlled ambiguity component acts trivially modulo the chosen boundary null \
ideal; visible controlled countermodels remain outside that hypothesis.", 
   "Reason" -> "The strict record sector is automatically invariant but \
trivial, the borderline model is nontrivial and mod-null invisible, and the \
unsafe model shows the criterion is genuinely needed."|>, 
 "EndToEnd_WeakInterface_to_Jcan" -> 
  <|"TransportAudit" -> <|"Name" -> "certified_polynomial_branch", 
     "AcceptedBranchComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1213832 && 
        MainProof`ActiveTransport`Private`lambda$1213832 <= 3}, 
     "SignDefinedComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1213832 && 
        MainProof`ActiveTransport`Private`lambda$1213832 <= 3}, 
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" -> 
      1 + MainProof`ActiveTransport`Private`lambda$1213832, 
     "EpsilonExpression" -> 1, "Claims" -> <|"Annihilation of Aminus" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True|>, "Constancy on affine class" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "Counterexample" -> {}|>, 
       "Normalization chi = nu^-1 rho" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True|>, "Continuity of dominant scalar" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "WitnessDetails" -> <||>|>, 
       "Sign defined on full branch" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "UndefinedWitness" -> {}|>, 
       "Local constancy of branch sign on sign-defined components" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "ComponentSigns" -> 
          <|1 <= MainProof`ActiveTransport`Private`lambda$1213832 && 
             MainProof`ActiveTransport`Private`lambda$1213832 <= 3 -> 1|>|>, 
       "Sign changes only across zeros of rho or nu" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>, 
   "CalibrationReport" -> <|"InputChecks" -> 
      <|"Normalization chi(jSharp)=1" -> True, 
       "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" -> 
        True, "Kernel metric dimensions" -> True, "Kernel metric coercive" -> 
        True, "Beta positive" -> True, "M invertible" -> True, 
       "Aminus in ker chi" -> True|>, "B" -> {{3, 1, 0}, {1, 2, 0}, {0, 0, 
      5}}, "ProductDecomposition" -> True, "Symmetry" -> True, 
     "PositiveDefinite" -> True, "OrthogonalToKerChi" -> True, 
     "OrthogonalToAminus" -> True, "jSharpNorm" -> True, 
     "AdmissibleChoice_jSharp_equals_epsilon_JXi" -> True|>, 
   "TickValidation" -> <|"Valid" -> True, "Checks" -> 
      <|"Odd space" -> True, "Closed ambiguity subspace" -> True, 
       "Affine class bookkeeping" -> True, "Nonzero chi" -> True, 
       "Chi annihilates Aminus" -> True, "Class constancy of chi" -> True, 
       "Positive symmetric B" -> True, "Branch-sign bookkeeping" -> True|>, 
     "FailedChecks" -> {}, "Reasons" -> <||>|>, 
   "CanonicalRepresentativeReport" -> <|"UFullColumnRank" -> True, 
     "GA_PositiveDefinite" -> True, "ChiAnnihilatesAminus" -> True, 
     "JcanInAffineClass" -> True, "ChiJcanEqualsEpsilon" -> True, 
     "Orthogonality" -> True, "MinimalityDifferenceIdentity" -> True, 
     "OrthogonalityImpliesCanonicalCoordinates" -> True, 
     "UniqueMinimizer" -> True, "ProjectorIdempotent" -> True, 
     "ProjectorFormula" -> True, "RepresentativeShiftInvariant" -> True, 
     "QuadraticOptimizationCrossCheck" -> <|"Status" -> "Executed", 
       "Coordinates" -> {a1288[1] -> -2., a1288[2] -> 0.9999999999999999}, 
       "PrimalMinimumValue" -> 5., "ExpectedCoordinates" -> {-2., 1.}, 
       "ExpectedValue" -> 5.|>|>, "MilestoneClaims" -> 
    <|"TransportCertified" -> True, "CalibrationCertified" -> True, 
     "TickDataValid" -> True, "JcanCertified" -> True|>, 
   "MilestoneStatus" -> "green"|>, "DecisionNote" -> "/home/kray-l8/work/2T/M\
ain/Mathematica/Reports/BoundaryCalibrationDecision.md", 
 "MainSnippet" -> "/home/kray-l8/work/2T/Main/Mathematica/Reports/BoundaryRec\
ordRestrictionRemark.tex", "SplitSnippet" -> "/home/kray-l8/work/2T/Main/Math\
ematica/Reports/SplitNoteControlledBoundaryRemark.tex", 
 "ImportedAssumptions" -> {"Closedness of Aminus, continuity of branch data, \
and Hilbertizability are still represented by finite-dimensional surrogates \
rather than independent infinite-dimensional constructions.", "Source \
representability is still split into an exact algebraic image-membership \
problem and a still-imported sufficient-locality condition.", "The boundary \
null ideal and the controlled boundary sector are modeled exactly but remain \
explicit finite-dimensional data rather than derived AQFT/HLS structures.", "\
Decision A is conditional: the sprint isolates the diagonal controlled \
ambiguity criterion but does not derive it from the full transported Main/UOM \
assumptions.", "LoG spectral selection and the abstract AQFT/HLS \
Hamiltonization tail remain outside the Mathematica core."}, 
 "BoundaryDelta" -> {"Strict boundary record invariance is exact but trivial: \
the induced derivation collapses after the boundary readout.", "Controlled \
projection isolates the exact source of boundary calibration dependence: only \
the diagonal controlled ambiguity component can survive; ledger-off-diagonal \
pieces are killed.", "Operator-level invisibility and expectation-level \
invisibility are now sharply separated. The unsafe controlled model is \
expectation-invisible on boundary-classical states while remaining \
operator-visible.", "A nontrivial mod-null invisible controlled family exists \
exactly at finite cutoff, so the boundary split+welded lane supports a \
conditional Path A rather than only trivial record-level invariance."}|>
