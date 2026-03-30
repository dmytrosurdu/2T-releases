# Projection Formula Insertion Proposal

Target location: immediately after `prop:Jcan-orth` in [appendix_main.tex](/home/kray-l8/work/2T/Main/appendix_main.tex#L1837).

## Proposed insertion

```tex
\begin{remark}[Finite-dimensional projection formula]
In any finite-dimensional realization of the affine odd descendant class
\(
[\Xi^{(1)}_{\Lambda_k}] = J_{0,\Lambda_k} + \operatorname{im}(U_{\Lambda_k})
\)
with full-column-rank basis matrix \(U_{\Lambda_k}\) for
\(\mathcal A^-_{\Lambda_k}\), and with matrix \(B_{\Lambda_k}\) representing the
calibration form \(\mathsf B_{\Lambda_k}\), the canonical representative admits
the explicit projector formula
\[
P_{\mathcal A_{\Lambda_k}}^{B_{\Lambda_k}}
:=
U_{\Lambda_k}
\bigl(U_{\Lambda_k}^{\top} B_{\Lambda_k} U_{\Lambda_k}\bigr)^{-1}
U_{\Lambda_k}^{\top} B_{\Lambda_k},
\]
\[
\mathcal J^{\mathrm{can}}_{\Lambda_k}
=
\bigl(I-P_{\mathcal A_{\Lambda_k}}^{B_{\Lambda_k}}\bigr)\,J_{0,\Lambda_k}.
\]
Equivalently, if
\[
a_{\ast}
:=
-\bigl(U_{\Lambda_k}^{\top} B_{\Lambda_k} U_{\Lambda_k}\bigr)^{-1}
U_{\Lambda_k}^{\top} B_{\Lambda_k} J_{0,\Lambda_k},
\]
then
\[
\mathcal J^{\mathrm{can}}_{\Lambda_k}
=
J_{0,\Lambda_k}+U_{\Lambda_k}a_{\ast}.
\]
The orthogonality condition
\(
\mathsf B_{\Lambda_k}(\mathcal J^{\mathrm{can}}_{\Lambda_k},A)=0
\)
for all \(A\in\mathcal A^-_{\Lambda_k}\) is exactly the normal-equation system
\[
U_{\Lambda_k}^{\top} B_{\Lambda_k}\,\mathcal J^{\mathrm{can}}_{\Lambda_k}=0.
\]
\end{remark}
```

## Rationale

- It makes `prop:Jcan-orth` more concrete without changing the abstract proof.
- It exposes the exact object the Mathematica audit is certifying.
- It gives a clean bridge from the Hilbert-space statement to the finite-cutoff WL package.
- It foregrounds the representative-shift invariance of `Jcan`, since replacing `J0` by `J0 + U h` leaves `(I - P_A^B) J0` unchanged.

## Audit basis

This insertion matches the exact finite-dimensional certificate in:

- [CanonicalRepresentative.wl](/home/kray-l8/work/2T/Main/Mathematica/Kernel/CanonicalRepresentative.wl)
- [05_JcanProjection.nb](/home/kray-l8/work/2T/Main/Mathematica/Notebooks/05_JcanProjection.nb)
- [WeakInterfaceToJcan_Certificates.wl](/home/kray-l8/work/2T/Main/Mathematica/Certificates/WeakInterfaceToJcan_Certificates.wl)
