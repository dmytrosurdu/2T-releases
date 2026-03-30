# Corrected Dominant-Scalar Reduction

The finite-cutoff Wolfram audit rules out the stronger unscaled claim that representative search on
the descendant affine class reduces directly to bare `chi`-compatibility.

The correct general statement is the `rho^dom`-level quotient statement:

\[
\overline{\rho}^{\mathrm{dom}}_{\Lambda_k}([J])
:=
\rho^{\mathrm{dom}}_{\Lambda_k}(J)
\qquad
\text{on}
\qquad
E^-_{\Lambda_k}/\mathcal A^-_{\Lambda_k}.
\]

If

\[
[\Xi^{(1)}_{\Lambda_k}]
=
J_{0,\Lambda_k}+\mathcal A^-_{\Lambda_k},
\qquad
\chi_{\Lambda_k}
=
\nu_{\Lambda_k}^{-1}\rho^{\mathrm{dom}}_{\Lambda_k},
\qquad
\chi_{\Lambda_k}(\mathcal A^-_{\Lambda_k})=0,
\]

then any representative-search condition depending only on dominant pairing should be stated first as

\[
\rho^{\mathrm{dom}}_{\Lambda_k}(J)
=
s
\qquad
\Longleftrightarrow
\qquad
\overline{\rho}^{\mathrm{dom}}_{\Lambda_k}\big([\![\Xi^{(1)}_{\Lambda_k}]\!]\big)
=
s.
\]

Equivalently, in weak-interface variables,

\[
\chi_{\Lambda_k}(J)
=
\nu_{\Lambda_k}^{-1}s.
\]

Only after an explicit normalization such as `nu = 1` may the same statement be rewritten in bare
`chi` form without changing the scalar value.

This correction has been propagated into:

- `Main/appendix_main.tex`
- `UOM/active_response_transport_program_note.tex`
- `UOM/canonical_odd_interface_note.tex`
- `UOM/summability_split_note.tex`
