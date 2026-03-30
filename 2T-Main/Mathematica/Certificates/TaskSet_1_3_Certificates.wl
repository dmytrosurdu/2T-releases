<|"GeneratedAt" -> "2026-03-12 14:57:40", "SprintScope" -> "Tasks 1-3 only: \
theorem ledger, TickData/ValidCharDataQ, and active transport audit.", 
 "Ledger" -> {<|"TheoremLabel" -> "def:2T-char", 
    "Assumptions" -> "Finite-dimensional surrogate for the seven Main-facing \
interface clauses.", "Method" -> 
     "Exact association validation plus 3 valid and 3 invalid synthetic \
examples.", "Status" -> "exact finite-dimensional certificate", 
    "Source" -> "Main/appendix_main.tex:535-586", 
    "Acceptance" -> 
     "3 valid accepted; 3 invalid rejected for the expected reason."|>, 
   <|"TheoremLabel" -> "thm:active-response-transport-minimal", 
    "Assumptions" -> "Branchwise rho^dom, nu, Aminus, and Jdesc family on an \
accepted interval.", "Method" -> "Resolve/Reduce on an exact polynomial \
branch model plus broken-model hypothesis audit.", 
    "Status" -> "exact finite-dimensional certificate", 
    "Source" -> "UOM/active_response_transport_program_note.tex:1821-1907"|>, 
   <|"TheoremLabel" -> "thm:char-weak-interface", "Assumptions" -> "Transport \
theorem discharged; chi = nu^-1 rho^dom defines the weak Main export.", 
    "Method" -> "Exact export chi = nu^-1 rho^dom with affine constancy and \
branch-sign certification.", "Status" -> 
     "exact finite-dimensional certificate", 
    "Source" -> "UOM/canonical_odd_interface_note.tex:699-744"|>, 
   <|"TheoremLabel" -> "prop:minimal-transport-calibration", 
    "Assumptions" -> 
     "chi, Jsharp, beta > 0, and a coercive form on ker chi.", 
    "Method" -> "Exact matrix decomposition and positivity certificates.", 
    "Status" -> "deferred", "Source" -> 
     "UOM/active_response_transport_program_note.tex:1987-2056"|>, 
   <|"TheoremLabel" -> "thm:finite-cutoff-Jcan", 
    "Assumptions" -> 
     "Weak 2T_char interface and a positive symmetric B on the affine class."\
, "Method" -> "Exact linear algebra + projection formula.", 
    "Status" -> "deferred", "Source" -> "Main/appendix_main.tex:1787-1811"|>, 
   <|"TheoremLabel" -> "prop:Jcan-orth", "Assumptions" -> 
     "Finite-dimensional affine class and positive B.", 
    "Method" -> "Exact orthogonality/minimality equivalence.", 
    "Status" -> "deferred", "Source" -> 
     "Main/appendix_main.tex:1838-1870 (working sprint label)"|>, 
   <|"TheoremLabel" -> "thm:finite-cutoff-canonical-odd-spectral-selection", 
    "Assumptions" -> 
     "Certified compressed spectral regime and rank-one LoG operator.", 
    "Method" -> "Exact eigenvalue/projector certificates.", 
    "Status" -> "deferred", "Source" -> 
     "UOM/compressed_log_spectral_selection_note.tex:259-288"|>, 
   <|"TheoremLabel" -> "thm:Main-Peierls-Hamiltonization", 
    "Assumptions" -> "Canonical representative plus imported bracket axioms \
on a concrete model.", "Method" -> "Formal rewrite + exact model checks.", 
    "Status" -> "deferred", "Source" -> 
     "Main/appendix_main.tex:2072-2084"|>}, 
 "Task2Examples" -> <|"ValidExamples" -> 
    {<|"Name" -> "valid_basic_identity", "Status" -> 
       "exact finite-dimensional certificate", "ValidQ" -> True, 
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
       {"Positive symmetric B"}|>}|>, "Task3ActiveTransport" -> 
  <|"CertifiedModel" -> <|"Name" -> "certified_polynomial_branch", 
     "DerivedChi" -> {0, 0, 1}, "DominantScalar" -> 
      1 + MainProof`ActiveTransport`Private`lambda$984989, 
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
       "Nonvanishing on branch" -> <|"Status" -> 
          "exact finite-dimensional certificate", "Certified" -> True, 
         "Counterexample" -> {}|>, "Local constancy of branch sign" -> 
        <|"Status" -> "exact finite-dimensional certificate", 
         "Certified" -> True, "Sign" -> 1|>|>|>, 
   "BrokenModels" -> {<|"Name" -> "broken_zero_crossing", 
      "DerivedChi" -> {0, 0, 
        -2 + MainProof`ActiveTransport`Private`lambda$985001}, 
      "DominantScalar" -> 
       -2 + MainProof`ActiveTransport`Private`lambda$985001, 
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
        "Nonvanishing on branch" -> <|"Status" -> "counterexample found", 
          "Certified" -> False, "Counterexample" -> 
           {{MainProof`ActiveTransport`Private`lambda$985001 -> 2}}|>, 
        "Local constancy of branch sign" -> 
         <|"Status" -> "counterexample found", "Certified" -> False, 
          "Sign" -> Missing["NotConstantSign"]|>|>|>, 
     <|"Name" -> "broken_jump_discontinuity", "DerivedChi" -> 
       {0, 0, 1 + UnitStep[-2 + 
           MainProof`ActiveTransport`Private`lambda$985001]}, 
      "DominantScalar" -> 1 + UnitStep[
         -2 + MainProof`ActiveTransport`Private`lambda$985001], 
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
              "Value" -> 2|>|>|>, "Nonvanishing on branch" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "Counterexample" -> {}|>, 
        "Local constancy of branch sign" -> 
         <|"Status" -> "exact finite-dimensional certificate", 
          "Certified" -> True, "Sign" -> 1|>|>|>}|>|>
