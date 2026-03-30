<|"GeneratedAt" -> "2026-03-29 18:00:20", "SprintScope" -> "Tasks 1-5 with \
Task 3.5 hardening: tightened ledger, weak-interface audit, calibration, \
canonical representative, and the end-to-end weak interface -> calibration -> \
Jcan certificate.", "Milestone" -> "weak interface -> calibration -> Jcan",
 "MilestoneStatus" -> "green",
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
k/2T/Main/Mathematica/Certificates/WeakInterfaceToJcan_Certificates.wl::Task2\
Schema.ValidExamples", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Mai\
n/Mathematica/Certificates/WeakInterfaceToJcan_Certificates.wl::Task2Schema.I\
nvalidExamples", "RepresentativeModelFamily" -> "valid_basic_identity, \
valid_nontrivial_gram, valid_zero_ambiguity; invalid_parity_tag, \
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
ates/WeakInterfaceToJcan_Certificates.wl::Task3_5ActiveTransport.CertifiedMod\
el", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Cert\
ificates/WeakInterfaceToJcan_Certificates.wl::Task3_5ActiveTransport.BrokenMo\
dels", "RepresentativeModelFamily" -> "certified_polynomial_branch, \
broken_zero_sign_undefined, broken_jump_discontinuity, \
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
ica/Certificates/WeakInterfaceToJcan_Certificates.wl::Task3_5ActiveTransport.\
CertifiedModel", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Math\
ematica/Certificates/WeakInterfaceToJcan_Certificates.wl::Task3_5ActiveTransp\
ort.BrokenModels", "RepresentativeModelFamily" ->
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
ates/WeakInterfaceToJcan_Certificates.wl::Task4Calibration.ValidExample",
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/WeakInterfaceToJcan_Certificates.wl::Task4Calibration.BrokenExamples"\
, "RepresentativeModelFamily" -> "Exact basis-aware ambient calibration \
examples with broken-input countermodels", "NoApproximationQ" -> True,
    "Source" -> "UOM/active_response_transport_program_note.tex:1987-2056"|>,
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
ates/WeakInterfaceToJcan_Certificates.wl::Task5CanonicalRepresentative.ValidE\
xample", "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/\
Certificates/WeakInterfaceToJcan_Certificates.wl::Task5CanonicalRepresentativ\
e.BrokenExamples", "RepresentativeModelFamily" ->
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
ome/kray-l8/work/2T/Main/Mathematica/Certificates/WeakInterfaceToJcan_Certifi\
cates.wl::Task5CanonicalRepresentative.ValidExample",
    "CounterexampleArtifact" -> "/home/kray-l8/work/2T/Main/Mathematica/Certi\
ficates/WeakInterfaceToJcan_Certificates.wl::Task5CanonicalRepresentative.Bro\
kenExamples", "RepresentativeModelFamily" ->
     "Exact projector-model family with representative-shift checks",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:1838-1870 (working sprint label)"|>,
   <|"TheoremLabel" -> "thm:dominant-quotient-descent",
    "Assumptions" -> "Dominant-response functional and ambiguity subspace on \
the finite-cutoff odd layer.", "Method" ->
     "Exact quotient descent and coset-constancy checks.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Quotient continuity is represented by \
finite-dimensional linear algebra.", "Closure of the ambiguity space is still \
only represented by the finite-dimensional surrogate."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/active_response_transport_program_note.tex:504-525"|>,
   <|"TheoremLabel" -> "cor:dominant-quotient-constancy",
    "Assumptions" -> "Descended dominant functional on the ambiguity quotient \
and the affine descendant class.", "Method" ->
     "Exact affine-class constancy via quotient coordinates.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The quotient point [![Xi^(1)]!] is represented \
only in finite-dimensional coordinates."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/active_response_transport_program_note.tex:444-468"|>,
   <|"TheoremLabel" -> "task:source-insertion-representability",
    "Assumptions" -> "Fixed-cutoff image-membership problem Pi_phys R(F_tau) \
= Pi_phys T[tau].", "Method" ->
     "Exact linear solver with obstruction and gauge analysis.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Sufficient locality remains imported and is \
not identified with algebraic image membership."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/active_response_transport_program_note.tex:1260-1310"|>,
   <|"TheoremLabel" -> "task:witness-comparison-reduction",
    "Assumptions" -> "Representative search on J0 + Aminus versus scalar \
compatibility of dominant pairings.", "Method" ->
     "Exact affine representative-search reduction and obstruction hunting.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The reduction is audited at fixed cutoff and \
may still require a normalization hypothesis."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/active_response_transport_program_note.tex:1323-1371"|>,
   <|"TheoremLabel" -> "task:Jcan-branch-regularity",
    "Assumptions" -> "Rational or polynomial branch data U(lambda), \
B(lambda), J0(lambda) with invertible Gram block.",
    "Method" ->
     "Exact rational-function regularity audit for the projector formula.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Only rational/polynomial finite-cutoff branch data are audited."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main/appendix_main.tex:1837-1870 \
plus finite-dimensional projector formula remark"|>,
   <|"TheoremLabel" -> "task:calibration-comparison",
    "Assumptions" -> "Two admissible positive calibrations B1, B2 on the same \
affine class J0 + im(U).", "Method" ->
     "Exact projector comparison and visibility-map invariance tests.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Physical invisibility is represented by exact \
finite-dimensional visible maps killing Aminus.",
      "No infinite-dimensional physical-sector semantics are built here."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:1787-1917 plus WL calibration-comparison lane"|>\
, <|"TheoremLabel" -> "task:ambiguity-trivial-on-physical-sector",
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model.", "Method" ->
     "Exact proof that ad_A vanishes on the physical sector.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Only explicit finite-dimensional bracket models are audited."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:ambiguity-trivial-mod-null-ideal",
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model with a physical null ideal.",
    "Method" -> "Exact proof that ad_A lands in the physical null ideal while \
remaining nonzero.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The physical null ideal is represented by an \
explicit finite-dimensional subspace."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" ->
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:ambiguity-physically-visible",
    "Assumptions" -> "Odd generator shift J -> J + A with A in Aminus on an \
explicit bracket model.", "Method" -> "Exact countermodel where ad_A survives \
on the physical sector outside the null ideal.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"Physical visibility is shown only on explicit bracket models."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:2055-2140 plus WL ambiguity-physical-sector \
lane"|>, <|"TheoremLabel" -> "task:class-defined-physical-derivation",
    "Assumptions" -> "Physical sector, physical null ideal, and ambiguity \
directions on an explicit bracket model.",
    "Method" -> "Exact quotient test for representative-independence modulo \
the null ideal.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The physical quotient is represented by an \
explicit finite-dimensional null-ideal quotient.",
      "No abstract AQFT/HLS quotient construction is attempted."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:2055-2140 plus WL class-defined-derivation lane"\
|>, <|"TheoremLabel" -> "task:strict-boundary-record-invariance",
    "Assumptions" -> "Boundary readout on the strict record sector D_A \
\[CircleTimes] 1_B with classical ledger projectors on A.",
    "Method" -> "Exact symbolic proof that BoundaryReadout([X,O]) vanishes on \
the strict record sector.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The readout is the exact finite-dimensional pinch_A after partial \
trace over B.", "Approximate end-of-aeon classicality is idealized as exact \
ledger diagonality."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" ->
     "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane"|>,
   <|"TheoremLabel" -> "task:controlled-boundary-reduction",
    "Assumptions" -> "Controlled boundary observables Sum_i Pi^(A) \
\[CircleTimes] O_i^(B) and a general ambiguity operator K on A \[CircleTimes] \
B.", "Method" -> "Exact symbolic reduction of controlled-projected \
commutators to diagonal controlled B-block commutators.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The theorem is proved on explicit finite \
matrix algebras with rank-one ledger projectors.", "No infinite-dimensional \
completion or AQFT/HLS controlled sector is constructed."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/summability_split_note.tex:743-792 plus WL boundary-sector lane"|>,
   <|"TheoremLabel" -> "task:boundary-class-defined-derivation-strong",
    "Assumptions" -> "Controlled boundary sector and ambiguity directions on \
split+welded boundary models.", "Method" -> "Exact operator-level criterion \
for literal ambiguity triviality on the controlled sector.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Strong class-definedness is tested only on \
explicit split+welded toy models."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" ->
     "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane"|>,
   <|"TheoremLabel" -> "task:boundary-class-defined-derivation-mod-null",
    "Assumptions" -> "Controlled boundary sector and a chosen boundary null \
ideal on the completion sector B.", "Method" ->
     "Exact representative-independence criterion modulo the boundary null \
ideal.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The boundary null ideal is model data rather \
than a derived AQFT/HLS object."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" ->
     "Main/appendix_main.tex:2140-2177 plus WL boundary-sector lane"|>,
   <|"TheoremLabel" -> "task:boundary-expectation-vs-operator-invisibility",
    "Assumptions" -> "Controlled boundary sector together with diagonal \
boundary-classical states.", "Method" -> "Exact comparison of operator-level \
invisibility and expectation-level invisibility.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"Expectation-level invisibility is tested only against the chosen \
diagonal boundary-classical state family."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/summability_split_note.tex:643-792 plus WL boundary-sector lane"|>,
   <|"TheoremLabel" -> "task:boundary-nontriviality-test",
    "Assumptions" -> "Controlled boundary sector, boundary null ideal, and a \
candidate boundary generator J.", "Method" -> "Exact search for a nonzero \
induced boundary derivation with ambiguity invisibility modulo the boundary \
null ideal.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Nontriviality is shown on explicit exact \
split+welded toy models rather than the transported full UOM ambiguity \
class."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:7\
43-856 plus WL split+welded boundary lane"|>,
   <|"TheoremLabel" -> "task:boundary-calibration-decision",
    "Assumptions" -> "Strict record sector, controlled boundary sector, and \
split+welded safe/unsafe/borderline ambiguity families.",
    "Method" -> "Exact finite-cutoff decision between strict trivial \
invariance, nontrivial controlled invariance, and visible failure.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The decision is conditional on the chosen \
split+welded toy families and is not yet a theorem of the full Main/UOM \
stack."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:7\
43-856 plus WL split+welded boundary lane"|>,
   <|"TheoremLabel" -> "thm:controlled-boundary-block-centrality-strong",
    "Assumptions" -> "Controlled boundary observables Sum_i Pi^(A) \
\[CircleTimes] O_i^(B) and a controlled ambiguity operator with diagonal \
B-blocks K_i^(B).", "Method" -> "Exact blockwise commutator reduction and \
centrality equivalence on full matrix blocks.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The theorem is proved on exact finite matrix blocks rather than an \
infinite-dimensional boundary algebra."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:7\
43-856 plus WL controlled-boundary block-centrality lane"|>,
   <|"TheoremLabel" -> "thm:controlled-boundary-block-centrality-mod-null",
    "Assumptions" -> "Controlled boundary observables together with a chosen \
boundary null ideal on each B-block.", "Method" ->
     "Exact blockwise commutator reduction and mod-null centrality \
equivalence.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The boundary null ideal is still represented \
by an explicit finite-dimensional block subspace."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:7\
43-856 plus WL controlled-boundary block-centrality lane"|>,
   <|"TheoremLabel" -> "rem:expectation-invisibility-insufficient",
    "Assumptions" -> "Controlled boundary observables and boundary-classical \
state families on the split+welded sector.", "Method" -> "Exact comparison of \
expectation-level invisibility against operator-level and mod-null \
class-definedness.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Expectation-level invisibility is only checked \
on the explicit boundary-classical state family."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex:6\
43-856 plus WL controlled-boundary block-centrality lane"|>,
   <|"TheoremLabel" -> "task:boundary-null-ideal-candidates",
    "Assumptions" -> "Natural split+welded boundary null-ideal candidates \
such as the readout kernel, block-trace-zero blocks, and state-invisible \
operators.", "Method" -> "Exact model-by-model comparison of stability, \
nontriviality, and borderline-family absorption.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The candidate list is finite and tied to explicit split+welded \
finite-cutoff semantics."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "UOM/summability_split_note.tex:643-856 plus WL \
boundary-null-ideal comparison lane"|>,
   <|"TheoremLabel" -> "task:transported-boundary-ambiguity-audit",
    "Assumptions" -> "Actual weak-interface transport export (Eminus, Aminus, \
XiClass, Chi, Epsilon) together with exact split+welded boundary \
realizations.", "Method" -> "Exact audit of the exported ambiguity basis \
under controlled boundary projection and natural null-ideal candidates.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Boundary realizations of the transported \
ambiguity basis are explicit finite-dimensional models rather than a theorem \
of the abstract transport semantics."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "UOM/active_response_transport_program_note.tex:1821-1960 \
plus WL transported-boundary audit lane"|>,
   <|"TheoremLabel" -> "task:selector-necessity-decision",
    "Assumptions" -> "Boundary block-centrality theorems, natural null-ideal \
comparison, and the transported ambiguity audit.",
    "Method" -> "Exact binary decision between structural boundary safety and \
selector necessity.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The decision is finite-cutoff and does not yet \
incorporate AQFT/HLS or LoG selector data."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main/appendix_main.tex:2140-2177 \
plus WL selector-necessity decision lane"|>,
   <|"TheoremLabel" -> "task:uom-welded-bandlocked-channel",
    "Assumptions" -> "Exact co-centered, band-locked compressed welded LoG \
channel at one accepted tick.", "Method" -> "Exact welded-line realization \
factoring through the descended dominant scalar.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The line/channel structure is imported from the proved UOM \
welded-shape and band-lock analysis rather than rederived from convolution \
integrals inside WL."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "UOM/main.tex:458-488, 6503-6525; \
UOM/compressed_log_spectral_selection_note.tex:18-95"|>,
   <|"TheoremLabel" -> "task:uom-subcutoff-fact-preservation",
    "Assumptions" -> "Accepted record algebra under commuting QND/CPTP \
evolution below cutoff.", "Method" ->
     "Exact symbolic diagonal-record projection and commuting dephasing \
audit.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The full infinite-dimensional band-limited \
Hilbert space is represented by exact finite-dimensional symbolic pointer \
models."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM/main.tex:5076-5093, 7280-7298, 9070-9086"|>,
   <|"TheoremLabel" -> "task:uom-transported-welded-boundary-audit",
    "Assumptions" -> "Actual weak-interface transport export composed with \
the exact welded/fact-preserving boundary image.",
    "Method" -> "Exact ambiguity audit after factorization through the \
descended dominant scalar on the welded LoG line.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"This certifies the preserved compiled/welded boundary image, not the \
full unreduced completion-sector operator algebra."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/active_response_transport_pr\
ogram_note.tex:1821-1960 together with UOM welded/accepted-record structure"|>\
, <|"TheoremLabel" -> "task:uom-welded-boundary-decision",
    "Assumptions" -> "Comparison between the old generic splitBlock boundary \
realization and the reworked UOM welded/fact-preserving realization.",
    "Method" -> "Exact finite-cutoff decision on whether the prior unsafe \
witnesses survive the UOM welded constraints.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The decision is about the exact welded preserved channel and leaves \
the unreduced Gaussian completion-sector operator reconstruction open."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main Mathematica rework lane \
grounded in UOM welded/fact-preserving structure"|>,
   <|"TheoremLabel" -> "task:uom-welded-boundary-ambiguity-annihilation",
    "Assumptions" -> "Transported ambiguity directions on the exact preserved \
welded boundary image.", "Method" -> "Exact matrix audit of the compiled \
welded boundary image after descended-scalar factorization.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The certificate is for the exact preserved \
welded boundary image, not the full completion-sector operator algebra."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main Mathematica welded-boundary \
canonicalization lane built on UOM welded/fact-preserving data"|>,
   <|"TheoremLabel" -> "task:uom-welded-boundary-class-defined-derivation",
    "Assumptions" -> "Boundary derivation induced by any representative in \
the transported affine class after compiled welded projection.",
    "Method" -> "Exact derivation equality test on the preserved welded \
boundary algebra.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Representative-independence is certified on \
the finite-dimensional compiled welded algebra only."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica welded-boundary canonicalization lane"|>,
   <|"TheoremLabel" -> "task:uom-welded-boundary-calibration-invariance",
    "Assumptions" -> "Two admissible canonical representatives in the same \
transported affine class viewed after compiled welded projection.",
    "Method" ->
     "Exact calibration comparison after UOM welded boundary projection.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Calibration invariance is certified only after \
projection to the preserved welded boundary image."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main Mathematica welded-boundary \
canonicalization lane plus WL canonical-representative machinery"|>,
   <|"TheoremLabel" -> "task:uom-welded-boundary-nontriviality",
    "Assumptions" -> "The surviving class representative line on the exact \
preserved welded boundary image.", "Method" -> "Exact nonvanishing commutator \
audit on a compiled welded boundary observable.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"Nontriviality is shown on an exact compiled welded boundary algebra \
witness, not on the unreduced microscopic completion sector."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica welded-boundary canonicalization lane"|>,
   <|"TheoremLabel" -> "task:uom-welded-log-shape",
    "Assumptions" ->
     "Macro/micro welded pulse formulas on the accepted UOM branch.",
    "Method" ->
     "Exact contract audit of temporal and spatial welded LoG shape \
formulas.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The WL lane certifies the exact algebraic \
contract, not the full continuum convolution derivation."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/compressed_log_spectral_sele\
ction_note.tex and UOM welded pulse notes"|>,
   <|"TheoremLabel" -> "task:uom-co-centering", "Assumptions" -> "Accepted \
welded pulse center alignment across the compiled macro/micro channel.",
    "Method" ->
     "Exact co-centering contract audit on the welded pulse data.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Co-centering is represented by the exact \
finite-cutoff contract rather than by a continuum transport proof."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM welded pulse notes and compressed welded LoG lane"|>,
   <|"TheoremLabel" -> "task:uom-bandlock-to-receiver",
    "Assumptions" -> "Receiver-cutoff locking of the welded pulse widths.",
    "Method" -> "Exact band-lock contract audit for the welded temporal and \
spatial scales.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Band-lock is certified as an exact algebraic contract at fixed \
cutoff."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM welded band-lock lane"|>,
   <|"TheoremLabel" -> "task:uom-compressed-line-rank",
    "Assumptions" ->
     "Compressed welded boundary image at one accepted cutoff.",
    "Method" -> "Exact rank-one projector audit for the welded LoG line.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The line rank is certified for the exact \
finite-dimensional compiled image only."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/compressed_log_spectral_sele\
ction_note.tex:259-288 plus WL welded channel lane"|>,
   <|"TheoremLabel" -> "task:uom-channel-factorization",
    "Assumptions" -> "Accepted finite-cutoff boundary channel written as \
projected Weyl-compensated compiled transport.", "Method" -> "Exact contract \
audit of T_Lambda = Pi_L o M_epsilon o K_comp o G_ret o W_src.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The WL lane certifies an exact \
finite-dimensional factorization surrogate rather than the full \
SK-to-boundary reconstruction."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" ->
     "UOM/main.tex and Main Mathematica accepted-channel contract lane"|>,
   <|"TheoremLabel" -> "task:uom-uplift-isometry-surrogate",
    "Assumptions" -> "Finite-cutoff uplift/Stinespring realization compatible \
with the accepted welded channel contract.",
    "Method" -> "Exact isometry audit for the chosen uplift surrogate.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Only the selected finite-dimensional uplift surrogate is certified."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM accepted-channel lane plus WL uplift surrogate"|>,
   <|"TheoremLabel" -> "task:uom-app-cptp-surrogate",
    "Assumptions" ->
     "Accepted tick map on the finite pointer sector below cutoff.",
    "Method" -> "Exact Kraus-completeness and CPTP surrogate audit.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The CPTP certificate is for the exact \
finite-dimensional surrogate only."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "UOM/main.tex accepted-tick lane plus WL Kraus surrogate"|>,
   <|"TheoremLabel" -> "task:uom-accepted-record-preservation",
    "Assumptions" -> "Accepted record algebra below cutoff under the exact \
accepted channel surrogate.", "Method" ->
     "Exact preservation audit against an intentional ablation witness.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {
      "Preservation is certified on finite-dimensional pointer models only."}\
, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/main.tex accepted-record \
lane plus WL accepted-channel contract lane"|>,
   <|"TheoremLabel" -> "task:uom-p3-admissibility",
    "Assumptions" -> "Finite-cutoff P3 least-action admissibility on the \
welded candidate family.", "Method" ->
     "Exact contract audit over finitely many candidate welded channel \
families.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Only exact symbolic contract families are \
compared; no continuum variational theorem is reproved."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM active-response transport and descendant-note admissibility lanes"|>\
, <|"TheoremLabel" -> "task:uom-sk-gaussian-selection",
    "Assumptions" -> "Least-influence SK Gaussian selection on admissible \
finite-cutoff welded families.", "Method" ->
     "Exact ranking audit of Gaussian drive/squeeze contracts.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The lane certifies symbolic contract data \
rather than the full continuum Gaussian optimization problem."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM SK least-influence selection notes"|>,
   <|"TheoremLabel" -> "task:uom-welded-family-selection",
    "Assumptions" ->
     "Selected admissible welded channel family at finite cutoff.",
    "Method" -> "Exact admissibility contract reducing to the welded rank-one \
factorized channel.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The selected family is finite-dimensional \
contract data, not a universal theorem over all boundary channels."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "UOM welded family-selection contract lane"|>,
   <|"TheoremLabel" -> "task:uom-ablation-fact-preservation",
    "Assumptions" ->
     "Exact welded boundary audit with accepted-record preservation removed."\
, "Method" -> "Finite-dimensional ablation classification on the preserved \
welded boundary image.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The ablation outcome is model-exact and does \
not by itself settle all microscopic realizations."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica UOM welded ablation lane"|>,
   <|"TheoremLabel" -> "task:uom-ablation-bandlock",
    "Assumptions" ->
     "Exact welded boundary audit with receiver band-lock relaxed.",
    "Method" -> "Finite-dimensional ablation classification on the compiled \
boundary image.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The ablation outcome is an exact \
channel-family witness, not a universal no-go theorem."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica UOM welded ablation lane"|>,
   <|"TheoremLabel" -> "task:uom-ablation-compressed-rank",
    "Assumptions" -> "Exact welded boundary audit with the rank-one \
compressed line replaced by a higher-rank channel.",
    "Method" -> "Finite-dimensional ablation classification on the compiled \
boundary image.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"The higher-rank witness is exact but model-specific."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica UOM welded ablation lane"|>,
   <|"TheoremLabel" -> "task:uom-ablation-co-centering",
    "Assumptions" ->
     "Exact welded boundary audit with co-centering relaxed.",
    "Method" -> "Finite-dimensional ablation classification on the compiled \
boundary image.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"The co-centering witness is exact but model-specific."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica UOM welded ablation lane"|>,
   <|"TheoremLabel" -> "task:uom-ablation-descended-scalar-factorization",
    "Assumptions" -> "Exact welded boundary audit with the descended-scalar \
factorization replaced by a generic control map.",
    "Method" -> "Finite-dimensional ablation classification against the \
legacy unsafe lane.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The certificate compares exact \
finite-dimensional channel families rather than the full continuum \
reconstruction."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "Main Mathematica UOM welded ablation lane plus legacy \
generic surrogate lane"|>, <|"TheoremLabel" ->
     "task:uom-minimal-boundary-safe-hypothesis-set",
    "Assumptions" -> "Minimal exact welded-boundary hypothesis package found \
by the ablation audit.", "Method" -> "Exact implication audit H_min => \
W_Lambda(A^-_Lambda) = 0 on the preserved welded boundary image.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Minimality is relative to the exact ablation family encoded in WL."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica UOM welded ablation lane"|>,
   <|"TheoremLabel" -> "task:legacy-generic-visible-ambiguity",
    "Assumptions" ->
     "Legacy generic boundary surrogates without the UOM welded contract.",
    "Method" ->
     "Exact regression audit reproducing visible ambiguity witnesses.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"These are deliberately negative-control \
models, not physical channel claims."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "Legacy split+welded/generic-boundary surrogate lane"|>,
   <|"TheoremLabel" -> "task:legacy-generic-splitblock-countermodels",
    "Assumptions" ->
     "Legacy generic splitBlock countermodels retained as negative controls."\
, "Method" -> "Exact unsafe-family regression audit on transported and \
generic surrogate realizations.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The lane preserves countermodels on purpose and does not claim \
physical admissibility."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "Legacy splitBlock negative-control lane"|>,
   <|"TheoremLabel" -> "task:sk-minimal-gaussian-completion-reconstruction",
    "Assumptions" -> "Exploratory exact algebraic completion lift compatible \
with the welded boundary block.", "Method" ->
     "Exact finite-dimensional audit of an appended algebraic completion \
lift.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"This is an exploratory exact algebraic \
extension of the welded boundary block.",
      "It is not yet a faithful UOM split/completion reconstruction."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica completion-sector reconstruction lane"|>,
   <|"TheoremLabel" -> "task:sk-completion-ambiguity-visibility",
    "Assumptions" -> "Transported ambiguity evaluated on the exploratory \
exact algebraic completion lift.", "Method" -> "Exact classification as \
strong-safe, mod-null-safe, or visible-again on the exploratory algebraic \
completion model.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"The classification is for the encoded exploratory algebraic model \
only.", "It is not a selector-necessity decision and not yet a verdict on the \
UOM split model."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "Main Mathematica completion-sector reconstruction lane"|>,
   <|"TheoremLabel" -> "task:sk-completion-boundary-lift",
    "Assumptions" -> "Boundary projection of the exploratory algebraic \
completion lift back to the welded boundary image.",
    "Method" -> "Exact boundary-compatibility audit for the exploratory \
completion-sector lift.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Compatibility is certified only for the chosen exploratory exact \
model."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica completion-sector reconstruction lane"|>,
   <|"TheoremLabel" -> "task:sk-intrinsic-response-map-contract",
    "Assumptions" -> "Intrinsic response-map contract derived from the \
compressed welded boundary image without appended free completion \
functionals.", "Method" ->
     "Exact contract extraction from chi and the accepted welded response \
map.", "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"This certifies a finite-dimensional contract \
realization of the intrinsic response map, not the full continuum response \
theorem."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/canonical_odd_interface_note\
.tex plus Main Mathematica intrinsic-response contract lane"|>,
   <|"TheoremLabel" -> "task:sk-split-controlled-lift-contract",
    "Assumptions" -> "Split-faithful A|B lift with classical-control/QND \
ledger sector and completion sector built from the intrinsic response \
contract.", "Method" -> "Exact tensor-product controlled-lift audit and \
ledger-projector commutation checks.", "Status" -> "deferred",
    "ScopeClass" -> "deferred", "SurrogateBlindSpots" ->
     {"The lift is a contract-level finite-dimensional surrogate for the \
split structure, not a full microscopic split theorem."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/summability_split_note.tex \
plus Main Mathematica split-controlled lift lane"|>,
   <|"TheoremLabel" -> "task:sk-gaussian-completion-contract",
    "Assumptions" -> "Gaussian completion contract derived from the intrinsic \
response map and compressed active line, with no appended free functional.",
    "Method" ->
     "Exact finite-dimensional quadrature/covariance contract audit.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"This is a contract-level Gaussian realization \
surrogate, not the full SK kernel reconstruction."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "UOM/canonical_odd_interface_note\
.tex and UOM/compressed_log_spectral_selection_note.tex plus Main Mathematica \
Gaussian-completion contract lane"|>,
   <|"TheoremLabel" ->
     "task:sk-split-faithful-completion-ambiguity-decision",
    "Assumptions" -> "Split-faithful completion decision combining intrinsic \
response, controlled split, derived Gaussian completion, and lifted fact \
preservation.", "Method" ->
     "Exact ambiguity audit on the split-faithful completion contract.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The decision is contract-level and does not \
yet settle the full microscopic completion-sector theorem."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica split-faithful completion audit lane"|>,
   <|"TheoremLabel" -> "task:uom-contract-traceability",
    "Assumptions" -> "Current WL contract ingredients for welded boundary \
safety and split-faithful completion.", "Method" ->
     "Exact source/role classification against Main, UOM, and 2T-LS labels.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"The traceability table is only as fine-grained \
as the current live theorem/assumption labels.", "The completion entries are \
still non-promoted: one is a bounded packaging theorem on explicit split \
data, while the Gaussian completion layer remains assumption-backed."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main/appendix_main.tex, UOM live \
notes, and latex/limited_scope_theorem_PRL_Supplementary.tex"|>,
   <|"TheoremLabel" -> "task:mock-cosmology-interface-realizations",
    "Assumptions" -> "UOM realization, synthetic non-UOM realizations, and a \
visible-ambiguity negative control.", "Method" ->
     "Exact mock-realization audit for interface candidacy.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Synthetic realizations certify interface \
shape, not microscopic physics."}, "CertificateArtifact" -> "Deferred",
    "CounterexampleArtifact" -> "Deferred", "RepresentativeModelFamily" ->
     "To be assigned", "NoApproximationQ" -> True,
    "Source" -> "Main Mathematica interface-search lane plus UOM \
welded/completion contracts"|>,
   <|"TheoremLabel" -> "task:cosmology-interface-boundary-minimality",
    "Assumptions" -> "Nested boundary-interface candidates I0, I1, I2.",
    "Method" -> "Exact minimality search on mock realizations.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Minimality is certified only in the current exact mock family."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" -> "Main abstract interface lane \
cross-checked against UOM contract realizations"|>,
   <|"TheoremLabel" -> "task:cosmology-interface-completion-minimality",
    "Assumptions" ->
     "Nested completion-aware interface candidates I0, I1, I2.",
    "Method" ->
     "Exact minimality search on completion-aware mock realizations.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Completion-aware minimality remains \
contract-level and does not close the microscopic SK theorem."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica completion-interface search lane"|>,
   <|"TheoremLabel" -> "task:boundary-contract-compression",
    "Assumptions" -> "Five-part strong-safe welded package versus a \
three-axiom conceptual compression.", "Method" ->
     "Exact equivalence audit on the welded ablation family.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Compression is certified only inside the present exact ablation \
family."}, "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica welded ablation lane plus UOM compressed welded notes"\
|>, <|"TheoremLabel" -> "task:manuscript-insertion-gate",
    "Assumptions" -> "Current traceability, compact-interface search, and \
completion-scope caveats.", "Method" -> "Joint manuscript gating decision.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"This gate is about what the current exact lane \
honestly licenses, not about the final theorem program."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main Mathematica report lane plus UOM contract/completion reports"|>,
   <|"TheoremLabel" -> "task:Peierls-odd-derivation",
    "Assumptions" -> "Explicit associative bracket model with parity \
involution and odd generator J.", "Method" ->
     "Exact basis-level derivation and Gamma-odd checks.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" ->
     {"Only explicit finite-dimensional bracket models are audited.",
      "Locality and AQFT/HLS remain imported."}, "CertificateArtifact" ->
     "Deferred", "CounterexampleArtifact" -> "Deferred",
    "RepresentativeModelFamily" -> "To be assigned",
    "NoApproximationQ" -> True, "Source" ->
     "Main/appendix_main.tex:2055-2130"|>,
   <|"TheoremLabel" -> "task:delta-calibration-sensitivity",
    "Assumptions" -> "Two canonical representatives Jcan_B1 and Jcan_B2 in an \
explicit bracket model.", "Method" -> "Exact derivation-difference formula \
plus ambiguity-triviality tests on the physical sector.",
    "Status" -> "deferred", "ScopeClass" -> "deferred",
    "SurrogateBlindSpots" -> {"Physical invisibility is represented by \
explicit bracket-trivial ambiguity directions.",
      "No AQFT/HLS physical-sector reconstruction is performed."},
    "CertificateArtifact" -> "Deferred", "CounterexampleArtifact" ->
     "Deferred", "RepresentativeModelFamily" -> "To be assigned",
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
      {1 <= MainProof`ActiveTransport`Private`lambda$19927 &&
        MainProof`ActiveTransport`Private`lambda$19927 <= 3},
     "SignDefinedComponents" ->
      {1 <= MainProof`ActiveTransport`Private`lambda$19927 &&
        MainProof`ActiveTransport`Private`lambda$19927 <= 3},
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" ->
      1 + MainProof`ActiveTransport`Private`lambda$19927,
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
          <|1 <= MainProof`ActiveTransport`Private`lambda$19927 &&
             MainProof`ActiveTransport`Private`lambda$19927 <= 3 -> 1|>|>,
       "Sign changes only across zeros of rho or nu" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>,
   "BrokenModels" -> {<|"Name" -> "broken_zero_sign_undefined",
      "AcceptedBranchComponents" ->
       {1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3},
      "SignDefinedComponents" ->
       {2 < MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3,
        MainProof`ActiveTransport`Private`lambda$19955 < 2 &&
         1 <= MainProof`ActiveTransport`Private`lambda$19955},
      "DerivedChi" -> {0, 0,
        -2 + MainProof`ActiveTransport`Private`lambda$19955},
      "DominantScalar" ->
       -2 + MainProof`ActiveTransport`Private`lambda$19955,
      "EpsilonExpression" ->
       -2 + MainProof`ActiveTransport`Private`lambda$19955,
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
           {{MainProof`ActiveTransport`Private`lambda$19955 -> 2}}|>,
        "Local constancy of branch sign on sign-defined components" ->
         <|"Status" -> "exact finite-dimensional certificate",
          "Certified" -> True, "ComponentSigns" ->
           <|2 < MainProof`ActiveTransport`Private`lambda$19955 &&
              MainProof`ActiveTransport`Private`lambda$19955 <= 3 -> 1,
            MainProof`ActiveTransport`Private`lambda$19955 < 2 &&
              1 <= MainProof`ActiveTransport`Private`lambda$19955 -> -1|>|>,
        "Sign changes only across zeros of rho or nu" ->
         <|"Status" -> "exact finite-dimensional certificate",
          "Certified" -> True, "ExcludedSetWitness" ->
           {{MainProof`ActiveTransport`Private`lambda$19955 -> 2}}|>|>|>,
     <|"Name" -> "broken_jump_discontinuity", "AcceptedBranchComponents" ->
       {1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3},
      "SignDefinedComponents" ->
       {1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3},
      "DerivedChi" -> {0, 0, 1 + UnitStep[
          -2 + MainProof`ActiveTransport`Private`lambda$19955]},
      "DominantScalar" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$19955],
      "EpsilonExpression" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$19955],
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
           <|1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
              MainProof`ActiveTransport`Private`lambda$19955 <= 3 -> 1|>|>,
        "Sign changes only across zeros of rho or nu" ->
         <|"Status" -> "exact finite-dimensional certificate",
          "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>,
     <|"Name" -> "broken_ambiguity_not_in_kernel",
      "AcceptedBranchComponents" ->
       {1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3},
      "SignDefinedComponents" ->
       {1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
         MainProof`ActiveTransport`Private`lambda$19955 <= 3},
      "DerivedChi" -> {1, 0, 1}, "DominantScalar" -> 1,
      "EpsilonExpression" -> 1, "Claims" -> <|"Annihilation of Aminus" ->
         <|"Status" -> "counterexample found", "Certified" -> False|>,
        "Constancy on affine class" -> <|"Status" -> "counterexample found",
          "Certified" -> False, "Counterexample" ->
           {{MainProof`ActiveTransport`Private`lambda$19955 -> 1,
             MainProof`ActiveTransport`Private`a1$20083 -> -1,
             MainProof`ActiveTransport`Private`a2$20083 -> 99/5}}|>,
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
           <|1 <= MainProof`ActiveTransport`Private`lambda$19955 &&
              MainProof`ActiveTransport`Private`lambda$19955 <= 3 -> 1|>|>,
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
       "Coordinates" -> {a35[1] -> -2., a35[2] -> 3.},
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
 "EndToEnd" -> <|"Model" -> <|"Name" -> "certified_polynomial_branch",
     "Parameter" -> MainProof`ActiveTransport`Private`lambda$20434,
     "Assumptions" -> 1 <= MainProof`ActiveTransport`Private`lambda$20434 <=
       3, "Aminus" -> {{1, 0}, {0, 1}, {0, 0}},
     "RhoDom" -> {0, 0, 1 + MainProof`ActiveTransport`Private`lambda$20434},
     "Nu" -> 1 + MainProof`ActiveTransport`Private`lambda$20434,
     "Jdesc" -> {0, 0, 1}, "ContinuityWitnesses" -> {}|>,
   "TransportAudit" -> <|"Name" -> "certified_polynomial_branch",
     "AcceptedBranchComponents" ->
      {1 <= MainProof`ActiveTransport`Private`lambda$20434 &&
        MainProof`ActiveTransport`Private`lambda$20434 <= 3},
     "SignDefinedComponents" ->
      {1 <= MainProof`ActiveTransport`Private`lambda$20434 &&
        MainProof`ActiveTransport`Private`lambda$20434 <= 3},
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" ->
      1 + MainProof`ActiveTransport`Private`lambda$20434,
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
          <|1 <= MainProof`ActiveTransport`Private`lambda$20434 &&
             MainProof`ActiveTransport`Private`lambda$20434 <= 3 -> 1|>|>,
       "Sign changes only across zeros of rho or nu" ->
        <|"Status" -> "exact finite-dimensional certificate",
         "Certified" -> True, "ExcludedSetWitness" -> {}|>|>|>,
   "CalibrationInput" -> <|"Chi" -> {0, 0, 1}, "jSharp" -> {0, 0, 1},
     "Beta" -> 5, "KernelBasis" -> {{0, 1}, {1, 0}, {0, 0}},
     "KernelMetric" -> {{2, 1}, {1, 3}}, "M" -> {{0, 0, 1}, {0, 1, 0},
       {1, 0, 0}}, "G" -> {{5, 0, 0}, {0, 2, 1}, {0, 1, 3}},
     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "Representative" -> {0, 0, 1},
     "Epsilon" -> 1|>, "CalibrationReport" ->
    <|"InputChecks" -> <|"Normalization chi(jSharp)=1" -> True,
       "Kernel basis lies in ker chi" -> True, "Kernel basis full rank" ->
        True, "Kernel metric dimensions" -> True, "Kernel metric coercive" ->
        True, "Beta positive" -> True, "M invertible" -> True,
       "Aminus in ker chi" -> True|>, "B" -> {{3, 1, 0}, {1, 2, 0}, {0, 0,
      5}}, "ProductDecomposition" -> True, "Symmetry" -> True,
     "PositiveDefinite" -> True, "OrthogonalToKerChi" -> True,
     "OrthogonalToAminus" -> True, "jSharpNorm" -> True,
     "AdmissibleChoice_jSharp_equals_epsilon_JXi" -> True|>,
   "ShiftCoordinates" -> {2, -1}, "ShiftedRepresentative" -> {2, -1, 1},
   "IntegratedTickData" -> <|"Tick" -> 1, "Eminus" ->
      <|"Dimension" -> 3, "Parity" -> "Odd"|>,
     "Aminus" -> {{1, 0}, {0, 1}, {0, 0}}, "XiClass" ->
      <|"Representative" -> {2, -1, 1}, "Basis" -> {{1, 0}, {0, 1},
         {0, 0}}|>, "J0" -> {2, -1, 1}, "Chi" -> {0, 0, 1}, "Epsilon" -> 1,
     "B" -> {{3, 1, 0}, {1, 2, 0}, {0, 0, 5}},
     "Ochar" -> <|"Name" -> "TransportExportedChar",
       "SourceModel" -> "certified_polynomial_branch"|>,
     "BranchSignRecord" -> <|"Tick" -> 1, "Epsilon" -> 1|>|>,
   "TickValidation" -> <|"Valid" -> True, "Checks" ->
      <|"Odd space" -> True, "Closed ambiguity subspace" -> True,
       "Affine class bookkeeping" -> True, "Nonzero chi" -> True,
       "Chi annihilates Aminus" -> True, "Class constancy of chi" -> True,
       "Positive symmetric B" -> True, "Branch-sign bookkeeping" -> True|>,
     "FailedChecks" -> {}, "Reasons" -> <||>|>,
   "CanonicalRepresentativeData" -> <|"U" -> {{1, 0}, {0, 1}, {0, 0}},
     "B" -> {{3, 1, 0}, {1, 2, 0}, {0, 0, 5}}, "J0" -> {2, -1, 1},
     "Chi" -> {0, 0, 1}, "Epsilon" -> 1, "GA" -> {{3, 1}, {1, 2}},
     "LinearTerm" -> {-5, 0}, "aStar" -> {-2, 1}, "Jcan" -> {0, 0, 1},
     "Projector" -> {{1, 0, 0}, {0, 1, 0}, {0, 0, 0}}|>,
   "CanonicalRepresentativeReport" -> <|"UFullColumnRank" -> True,
     "GA_PositiveDefinite" -> True, "ChiAnnihilatesAminus" -> True,
     "JcanInAffineClass" -> True, "ChiJcanEqualsEpsilon" -> True,
     "Orthogonality" -> True, "MinimalityDifferenceIdentity" -> True,
     "OrthogonalityImpliesCanonicalCoordinates" -> True,
     "UniqueMinimizer" -> True, "ProjectorIdempotent" -> True,
     "ProjectorFormula" -> True, "RepresentativeShiftInvariant" -> True,
     "QuadraticOptimizationCrossCheck" -> <|"Status" -> "Executed",
       "Coordinates" -> {a58[1] -> -2., a58[2] -> 0.9999999999999999},
       "PrimalMinimumValue" -> 5., "ExpectedCoordinates" -> {-2., 1.},
       "ExpectedValue" -> 5.|>|>, "MilestoneClaims" ->
    <|"TransportCertified" -> True, "CalibrationCertified" -> True,
     "TickDataValid" -> True, "JcanCertified" -> True,
     "JcanMatchesCalibratingRepresentative" -> True|>,
   "MilestoneStatus" -> "green"|>, "ImportedAssumptions" ->
  {"Closedness of Aminus and closed-affine-subspace statements are not \
independently tested; they are automatic in the finite-dimensional surrogate \
used for def:2T-char and thm:finite-cutoff-Jcan.", "Continuity and branchwise \
connectedness in thm:active-response-transport-minimal are machine-audited \
only on the explicit exact model family in Task 3.5, not for every admissible \
UOM branch.", "Hilbertizability/coercivity are represented by exact \
positive-definite matrices on ker chi and on Eminus; no infinite-dimensional \
completion is constructed.", "AQFT/HLS semantics, locality/closability of the \
Peierls derivation, LoG spectral selection, and the three deferred UOM \
transport closures remain imported or deferred in this sprint."}|>
