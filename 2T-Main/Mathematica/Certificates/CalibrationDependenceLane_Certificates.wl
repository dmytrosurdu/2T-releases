<|"GeneratedAt" -> "2026-03-12 19:01:14", "SprintScope" -> "Repo-wide \
transport correction propagation plus exact calibration-comparison and narrow \
Peierls odd-derivation lane.", "Milestone" -> "determine whether admissible \
calibration dependence is representational or physically visible", 
 "MilestoneStatus" -> "green", "CalibrationDependenceConclusion" -> "Jcan \
depends on the admissible calibration in general. The dependence is always \
quotient-level invisible because DeltaJ lies in Aminus, and it is \
representational on the physical sector when ambiguity directions bracket \
trivially there. It is not harmless automatically: the exact \
visible-ambiguity model gives a physical-sector counterexample.", 
 "Ledger" -> {<|"TheoremLabel" -> "def:2T-char", 
    "Assumptions" -> "Finite-dimensional surrogate for the seven Main-facing \
interface clauses.", "Method" -> 
     "Exact association validation plus 3 valid and 3 invalid synthetic \
examples.", "Status" -> "exact finite-dimensional certificate", 
    "ScopeClass" -> "schema-validator", "SurrogateBlindSpots" -> 
     {"Closedness is automatic/invisible at finite dimension.", 
      "Continuity of chi is automatic for finite-dimensional linear maps.", "\
Hilbertizability is reduced to positive-definite matrix data, not the \
abstract completion statement."}, "CertificateArtifact" -> "/home/kray-l8/wor\
k/2T/Main/Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl:\
:Task2Schema.ValidExamples", "CounterexampleArtifact" -> "/home/kray-l8/work/\
2T/Main/Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl::T\
ask2Schema.InvalidExamples", "RepresentativeModelFamily" -> "valid_basic_iden\
tity, valid_nontrivial_gram, valid_zero_ambiguity; invalid_parity_tag, \
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
ates/CalibrationDependenceLane_Certificates.wl::Task3_5ActiveTransport.Certif\
iedModel", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematic\
a/Certificates/CalibrationDependenceLane_Certificates.wl::Task3_5ActiveTransp\
ort.BrokenModels", "RepresentativeModelFamily" -> "certified_polynomial_branc\
h, broken_zero_sign_undefined, broken_jump_discontinuity, \
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
ica/Certificates/CalibrationDependenceLane_Certificates.wl::Task3_5ActiveTran\
sport.CertifiedModel", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Mai\
n/Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl::Task3_5\
ActiveTransport.BrokenModels", "RepresentativeModelFamily" -> 
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
ates/CalibrationDependenceLane_Certificates.wl::Task4Calibration.ValidExample\
", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certif\
icates/CalibrationDependenceLane_Certificates.wl::Task4Calibration.BrokenExam\
ples", "RepresentativeModelFamily" -> "Exact basis-aware ambient calibration \
examples with broken-input countermodels", "NoApproximationQ" -> True, 
    "Source" -> "UOM/active_response_transport_program_note.tex:1987-2056"|>, 
   <|"TheoremLabel" -> "thm:finite-cutoff-Jcan", 
    "Assumptions" -> 
     "Weak 2T_char interface and a positive symmetric B on the affine class."\
, "Method" -> 
     "Exact affine projection with GA = U^T B U and Jcan = J0 + U a*.", 
    "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> {"Closed affine subspace and Hilbert projection \
are realized by finite-dimensional matrix algebra."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/CalibrationDependenceLane_Certificates.wl::Task5CanonicalRepresentative.\
ValidExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathem\
atica/Certificates/CalibrationDependenceLane_Certificates.wl::Task5CanonicalR\
epresentative.BrokenExamples", "RepresentativeModelFamily" -> 
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
ome/kray-l8/work/2T/Main/Mathematica/Certificates/CalibrationDependenceLane_C\
ertificates.wl::Task5CanonicalRepresentative.ValidExample", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/CalibrationDependenceLane_Certificates.wl::Task5CanonicalRepresentati\
ve.BrokenExamples", "RepresentativeModelFamily" -> 
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
me/kray-l8/work/2T/Main/Mathematica/Certificates/CalibrationDependenceLane_Ce\
rtificates.wl::Task6QuotientDescent.ValidExample", 
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/CalibrationDependenceLane_Certificates.wl::Task6QuotientDescent.Broke\
nExamples", "RepresentativeModelFamily" -> "Exact quotient-descent \
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
ates/CalibrationDependenceLane_Certificates.wl::Task6QuotientDescent.ValidExa\
mple", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Ce\
rtificates/CalibrationDependenceLane_Certificates.wl::Task6QuotientDescent.Br\
okenExamples", "RepresentativeModelFamily" -> 
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
ates/CalibrationDependenceLane_Certificates.wl::Task7Representability.ValidEx\
amples", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/\
Certificates/CalibrationDependenceLane_Certificates.wl::Task7Representability\
.BrokenExamples", "RepresentativeModelFamily" -> "Exact representable \
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
Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl::Task8Witn\
essComparison", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathe\
matica/Certificates/CalibrationDependenceLane_Certificates.wl::Task8WitnessCo\
mparison.UnscaledChiCompatibilityWitness", "RepresentativeModelFamily" -> 
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
ca/Certificates/CalibrationDependenceLane_Certificates.wl::Task9JcanBranchReg\
ularity.ValidExample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Mai\
n/Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl::Task9Jc\
anBranchRegularity.DegenerateExample", "RepresentativeModelFamily" -> 
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
athematica/Certificates/CalibrationDependenceLane_Certificates.wl::Task11Cali\
brationComparison.NonInvariantExample", "CounterexampleArtifact" -> "/home/kr\
ay-l8/work/2T/Main/Mathematica/Certificates/CalibrationDependenceLane_Certifi\
cates.wl::Task11CalibrationComparison.NonInvariantExample.DeltaJ", 
    "RepresentativeModelFamily" -> "Exact admissible-calibration pairs with \
one non-invariant and one projector-equal comparison family", 
    "NoApproximationQ" -> True, "Source" -> 
     "Main/appendix_main.tex:1787-1917 plus WL calibration-comparison lane"|>\
, <|"TheoremLabel" -> "task:Peierls-odd-derivation", 
    "Assumptions" -> "Explicit associative bracket model with parity \
involution and odd generator J.", "Method" -> "Exact associative-model \
commutator bracket with parity involution; delta_J(A) = {J, A} checked on \
basis products.", "Status" -> "finite-dimensional-theorem-certificate", 
    "ScopeClass" -> "finite-dimensional-theorem-certificate", 
    "SurrogateBlindSpots" -> 
     {"The bracket lane is audited only on explicit associative models.", 
      "Locality/AQFT/HLS semantics remain imported metadata."}, 
    "CertificateArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certific\
ates/CalibrationDependenceLane_Certificates.wl::Task12PeierlsOddDerivation", 
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" -> 
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
ates/CalibrationDependenceLane_Certificates.wl::Task13CalibrationSensitivity.\
InvisibleSensitivityExample", "CounterexampleArtifact" -> "/home/kray-l8/work\
/2T/Main/Mathematica/Certificates/CalibrationDependenceLane_Certificates.wl::\
Task13CalibrationSensitivity.VisibleSensitivityExample", 
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
      {1 <= MainProof`ActiveTransport`Private`lambda$1114144 && 
        MainProof`ActiveTransport`Private`lambda$1114144 <= 3}, 
     "SignDefinedComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1114144 && 
        MainProof`ActiveTransport`Private`lambda$1114144 <= 3}, 
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" -> 
      1 + MainProof`ActiveTransport`Private`lambda$1114144, 
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
          <|1 <= MainProof`ActiveTransport`Private`lambda$1114144 && 
             MainProof`ActiveTransport`Private`lambda$1114144 <= 3 -> 1|>|>, 
       "Sign changes only across zeros of rho or nu" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>, 
   "BrokenModels" -> {<|"Name" -> "broken_zero_sign_undefined", 
      "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3}, 
      "SignDefinedComponents" -> 
       {2 < MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3, 
        MainProof`ActiveTransport`Private`lambda$1114169 < 2 && 
         1 <= MainProof`ActiveTransport`Private`lambda$1114169}, 
      "DerivedChi" -> {0, 0, 
        -2 + MainProof`ActiveTransport`Private`lambda$1114169}, 
      "DominantScalar" -> 
       -2 + MainProof`ActiveTransport`Private`lambda$1114169, 
      "EpsilonExpression" -> 
       -2 + MainProof`ActiveTransport`Private`lambda$1114169, 
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
           {{MainProof`ActiveTransport`Private`lambda$1114169 -> 2}}|>, 
        "Local constancy of branch sign on sign-defined components" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ComponentSigns" -> 
           <|2 < MainProof`ActiveTransport`Private`lambda$1114169 && 
              MainProof`ActiveTransport`Private`lambda$1114169 <= 3 -> 1, 
            MainProof`ActiveTransport`Private`lambda$1114169 < 2 && 
              1 <= MainProof`ActiveTransport`Private`lambda$1114169 -> 
             -1|>|>, "Sign changes only across zeros of rho or nu" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ExcludedSetWitness" -> 
           {{MainProof`ActiveTransport`Private`lambda$1114169 -> 2}}|>|>|>, 
     <|"Name" -> "broken_jump_discontinuity", "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3}, 
      "SignDefinedComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3}, 
      "DerivedChi" -> {0, 0, 1 + UnitStep[
          -2 + MainProof`ActiveTransport`Private`lambda$1114169]}, 
      "DominantScalar" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$1114169], 
      "EpsilonExpression" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$1114169], 
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
           <|1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
              MainProof`ActiveTransport`Private`lambda$1114169 <= 3 -> 1|>|>, 
        "Sign changes only across zeros of rho or nu" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>, 
     <|"Name" -> "broken_ambiguity_not_in_kernel", 
      "AcceptedBranchComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3}, 
      "SignDefinedComponents" -> 
       {1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
         MainProof`ActiveTransport`Private`lambda$1114169 <= 3}, 
      "DerivedChi" -> {1, 0, 1}, "DominantScalar" -> 1, 
      "EpsilonExpression" -> 1, "Claims" -> <|"Annihilation of Aminus" -> 
         <|"Status" -> "counterexample found", "Certified" -> False|>, 
        "Constancy on affine class" -> <|"Status" -> "counterexample found", 
          "Certified" -> False, "Counterexample" -> 
           {{MainProof`ActiveTransport`Private`lambda$1114169 -> 1, 
             MainProof`ActiveTransport`Private`a1$1114291 -> -1, 
             MainProof`ActiveTransport`Private`a2$1114291 -> 99/5}}|>, 
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
           <|1 <= MainProof`ActiveTransport`Private`lambda$1114169 && 
              MainProof`ActiveTransport`Private`lambda$1114169 <= 3 -> 1|>|>, 
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
       "Coordinates" -> {a751[1] -> -2., a751[2] -> 3.}, 
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
     "UnscaledChiCompatibilityWitness" -> {{r784 -> 1}}, 
     "DescendedFunctionalCoordinates" -> {1}, "QuotientCoordinateMatrix" -> 
      {{0, 0, 1}}|>, "BrokenExamples" -> 
    {<|"Name" -> "ambiguity_not_in_kernel", "ExpectedFailure" -> 
       "ChiAnnihilatesAminus", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True, "CounterexampleWitness" -> 
       {{r789 -> 1}}|>}|>, "Task7Representability" -> 
  <|"ValidExamples" -> {<|"RepresentableQ" -> True, 
      "ImageMembershipCriterion" -> True, "ObstructionSpaceBasis" -> {}, 
      "GaugeSpaceBasis" -> {{-1, -1, 1}}, "SolutionFamily" -> 
       {{f790[2] -> 1 + f790[1], f790[3] -> 2 - f790[1]}}, 
      "OneExactSolution" -> {2, 3, 0}, "ExactSolutionCheck" -> True, 
      "GaugeFamilyCheck" -> True, "ObstructionWitness" -> 
       Missing["NoObstruction"], "LocalityStatus" -> "imported"|>, 
     <|"RepresentableQ" -> True, "ImageMembershipCriterion" -> True, 
      "ObstructionSpaceBasis" -> {}, "GaugeSpaceBasis" -> {}, 
      "SolutionFamily" -> {{f791[1] -> 1, f791[2] -> -1}}, 
      "OneExactSolution" -> {1, -1}, "ExactSolutionCheck" -> True, 
      "GaugeFamilyCheck" -> True, "ObstructionWitness" -> 
       Missing["NoObstruction"], "LocalityStatus" -> "imported"|>}, 
   "BrokenExamples" -> {<|"Name" -> "physical_target_outside_image", 
      "ExpectedFailure" -> "RepresentableQ", "ObservedValue" -> False, 
      "ExpectedFailureObservedQ" -> True, "ObstructionWitness" -> 
       <|"ObstructionVector" -> {0, 1}, "ObstructionValue" -> 1|>|>}|>, 
 "Task9JcanBranchRegularity" -> 
  <|"ValidExample" -> <|"GramBlock" -> 
      {{2 + MainProof`JcanRegularity`Private`lambda$1114773 + 
         3*(1 + MainProof`JcanRegularity`Private`lambda$1114773)^2}}, 
     "GramDeterminant" -> 
      5 + 7*MainProof`JcanRegularity`Private`lambda$1114773 + 
       3*MainProof`JcanRegularity`Private`lambda$1114773^2, 
     "InputRationalQ" -> True, "GramInvertibleOnDomain" -> True, 
     "JcanFormula" -> {1 + MainProof`JcanRegularity`Private`lambda$1114773 + 
        (-9 - 7*MainProof`JcanRegularity`Private`lambda$1114773 + 
          2*MainProof`JcanRegularity`Private`lambda$1114773^2)/
         (5 + 7*MainProof`JcanRegularity`Private`lambda$1114773 + 
          3*MainProof`JcanRegularity`Private`lambda$1114773^2), 
       2 - MainProof`JcanRegularity`Private`lambda$1114773 + 
        ((1 + MainProof`JcanRegularity`Private`lambda$1114773)*
          (-9 - 7*MainProof`JcanRegularity`Private`lambda$1114773 + 
           2*MainProof`JcanRegularity`Private`lambda$1114773^2))/
         (5 + 7*MainProof`JcanRegularity`Private`lambda$1114773 + 
          3*MainProof`JcanRegularity`Private`lambda$1114773^2), 1}, 
     "JcanEntriesRationalQ" -> True, "JcanContinuousOnDomain" -> True, 
     "SingularSet" -> False, "SingularitiesOnlyAtGramDegeneracy" -> True|>, 
   "DegenerateExample" -> <|"GramBlock" -> 
      {{MainProof`JcanRegularity`Private`lambda$1114773^2}}, 
     "GramDeterminant" -> MainProof`JcanRegularity`Private`lambda$1114773^2, 
     "InputRationalQ" -> True, "GramInvertibleOnDomain" -> False, 
     "JcanFormula" -> {0, 1}, "JcanEntriesRationalQ" -> True, 
     "JcanContinuousOnDomain" -> True, "SingularSet" -> 
      MainProof`JcanRegularity`Private`lambda$1114773 == 0, 
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
      {0, 1}, {0, 0}, {0, 0}}, "AmbiguityBasis" -> {{0}, {0}, {1}, {0}}|>, 
   "JOdd" -> True, "GammaOddDerivation" -> True, "DerivationOnBasis" -> True, 
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
 "EndToEnd_WeakInterface_to_Jcan" -> 
  <|"TransportAudit" -> <|"Name" -> "certified_polynomial_branch", 
     "AcceptedBranchComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1114557 && 
        MainProof`ActiveTransport`Private`lambda$1114557 <= 3}, 
     "SignDefinedComponents" -> 
      {1 <= MainProof`ActiveTransport`Private`lambda$1114557 && 
        MainProof`ActiveTransport`Private`lambda$1114557 <= 3}, 
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" -> 
      1 + MainProof`ActiveTransport`Private`lambda$1114557, 
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
          <|1 <= MainProof`ActiveTransport`Private`lambda$1114557 && 
             MainProof`ActiveTransport`Private`lambda$1114557 <= 3 -> 1|>|>, 
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
       "Coordinates" -> {a774[1] -> -2., a774[2] -> 0.9999999999999999}, 
       "PrimalMinimumValue" -> 5., "ExpectedCoordinates" -> {-2., 1.}, 
       "ExpectedValue" -> 5.|>|>, "MilestoneClaims" -> 
    <|"TransportCertified" -> True, "CalibrationCertified" -> True, 
     "TickDataValid" -> True, "JcanCertified" -> True|>, 
   "MilestoneStatus" -> "green"|>, "CompileArtifacts" -> 
  <|"Main" -> "/home/kray-l8/work/2T/Main/Mathematica/Reports/Compile_Main_ma\
in_theorem.log", "UOMParent" -> "/home/kray-l8/work/2T/Main/Mathematica/Repor\
ts/Compile_UOM_summability_split_note.log", "FragmentParentingNote" -> "/home\
/kray-l8/work/2T/Main/Mathematica/Reports/Compile_UOM_fragment_parenting.txt"\
|>, "CorrectionNote" -> "/home/kray-l8/work/2T/Main/Mathematica/Reports/Corre\
ctedDominantScalarReduction.md", "ImportedAssumptions" -> 
  {"Closedness of Aminus, continuity of branch data, and Hilbertizability are \
still represented by finite-dimensional surrogates rather than independent \
infinite-dimensional constructions.", "Source representability is split into \
an exact algebraic image-membership problem and a still-imported \
sufficient-locality condition.", "The calibration-comparison and bracket \
lanes certify exact finite-dimensional formulas and conditions, but they do \
not construct the AQFT/HLS observable sector.", "LoG spectral certification \
and the abstract Main Peierls/AQFT tail remain outside the Mathematica core."}\
, "BoundaryDelta" -> {"Transport correction propagated: quotient and \
representative-search statements now use the descended rho^dom scalar as the \
general form, while chi-form statements are marked as normalized special \
cases.", "Calibration dependence sharpened: Jcan depends on B in general, but \
the exact comparison formula shows DeltaJ always lies in Aminus.", "Physical \
consequence sharpened: exact bracket models show that calibration dependence \
is representational on the physical sector when ambiguity directions are \
bracket-trivial there, and physically visible otherwise.", 
   "Full parent-document compile logs are now part of the handoff artifact \
set."}|>
