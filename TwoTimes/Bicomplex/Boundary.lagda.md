```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Bicomplex.Boundary where
```

# Bicomplex boundary operators (Phase I)

This module defines the **horizontal** and **vertical** boundary operators
[
Q_t : C_{m+1,n} \to C_{m,n},
\qquad
Q_u : C_{m,n+1} \to C_{m,n},
]
on the **free abelian group** on the bisimplicial grid simplices
[
\mathrm{Grid}_{m,n}
]
(from `TwoTimes.Process.Grid.Nerve`).

* `Q_t` is the alternating sum of horizontal faces.
* `Q_u` is the alternating sum of vertical faces, **twisted by** `(-1)^m`
  so that the *odd* operators satisfy the desired bicomplex anticommutation:
  [
  Q_t Q_u + Q_u Q_t = 0.
  ]

> **Team goal notes**
>
> * We keep the target additive structure abstract via a parameterized `FreeAbIF_Ext`.
> * Proofs of `Q_t^2=0`, `Q_u^2=0`, and `Q_t Q_u + Q_u Q_t = 0` are *goals* in
>   `BicomplexIdentities` at the end.
> * These proofs should use simplicial identities for faces and linearity of `lift`.
> * No cubical machinery and no truncations are used.

---

## Imports and small utilities

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_; Setω)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import TwoTimes.Process.Grid.Presentation using (Group)

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup; Hom; HomEq; _∘_; zeroHom; addHom; FreeAbIF_Ext)

import TwoTimes.Bicomplex.BoundaryDefs as BD
```

---

## Additive targets: Abelian group and free abelian interface

We use the shared interfaces from `TwoTimes.Bicomplex.FreeAbIF_Extensions`
(`AbGroup`, `Hom`, `HomEq`, `FreeAbIF_Ext`) to avoid duplication.

---

## The boundary operators on grid generators

We now define the boundary on **generators** (simplices) and then extend linearly
to `FreeAb`.

* Horizontal generator boundary:
  [
  \partial_H(x) = \sum_i (-1)^i \eta(d^H_i x).
  ]
* Vertical generator boundary (with a `(-1)^m` twist):
  [
  \partial_V(x) = (-1)^m \sum_j (-1)^j \eta(d^V_j x).
  ]

```agda
module _ {ℓT ℓF : Level} (Time : Group ℓT) (FA : FreeAbIF_Ext ℓF) where

  open BD.BoundaryDefs Time FA
    using (C; ∂H-gen; ∂V-gen; Qt; Qu)
```

---

## Linear extensions: the actual differentials `Q_t` and `Q_u`

The linear extensions `Qt` and `Qu` are provided by `BoundaryDefs` and
are in scope via the `open BD.BoundaryDefs ...` above.

---

## Bicomplex identity goals

These are the key Phase I proof obligations.

> **Team proof route suggestion**
>
> 1. Prove the simplicial identities for faces `dᵗ` and `dᵘ`
>    (in `Process/Grid/Nerve.agda` or a dedicated lemma file).
> 2. Use those identities to show `∂H-gen` satisfies “boundary of boundary = 0”
>    on generators, and similarly for `∂V-gen`.
> 3. Use `lift-+` and `lift-0` to extend to all chains.
> 4. For the mixed identity: horizontal and vertical faces commute
>    (componentwise), and the extra twist `(-1)^m` forces **anticommutation**.

We phrase the identities as pointwise equalities of maps, i.e. `HomEq`.

```agda
  record BicomplexIdentities : Set (lsuc (ℓF ⊔ ℓT)) where
    field
      -- Qt ∘ Qt = 0 : C (m+2,n) → C (m,n)
      Qt² : ∀ (m n : Nat) →
            HomEq (Qt {m} {n} ∘ Qt {suc m} {n}) (zeroHom {A = C (suc (suc m)) n} {B = C m n})

      -- Qu ∘ Qu = 0 : C (m,n+2) → C (m,n)
      Qu² : ∀ (m n : Nat) →
            HomEq (Qu {m} {n} ∘ Qu {m} {suc n}) (zeroHom {A = C m (suc (suc n))} {B = C m n})

      -- Anticommutation: Qt∘Qu + Qu∘Qt = 0 : C (m+1,n+1) → C (m,n)
      anticomm :
        ∀ (m n : Nat) →
        HomEq
          (addHom (Qt {m} {n} ∘ Qu {suc m} {n})
                  (Qu {m} {n} ∘ Qt {m} {suc n}))
          (zeroHom {A = C (suc m) (suc n)} {B = C m n})
```
