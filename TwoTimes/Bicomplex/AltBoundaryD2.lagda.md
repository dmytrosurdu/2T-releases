```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Bicomplex.AltBoundaryD2 where
```

# Alternating-face boundary: the `d²=0` lift principle

This module provides the **core lifting step** needed in Batch 3:

> If the *composed boundary* is `0` on **generators** (via `η`),
> then it is `0` on **all chains** (using the freeness/extension principle `extFree`).

Crucially, this avoids function extensionality by working with `HomEq`
(pointwise equality of homomorphisms).

This file does **not** prove the generator-level `d²=0` cancellation; it isolates
the step that turns a generator computation into a global chain equality.

---

## Imports

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_; Setω)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Process.Grid.Nerve using (Fin; fzero; fsuc)
open import TwoTimes.Prelude.Path

open import TwoTimes.Bicomplex.FreeAbIF_Extensions
  using (AbGroup; Hom; HomEq; zeroHom; _∘_; FreeAbIF_Ext)

open import TwoTimes.Algebra.SumFin using (altFin)
```

---

## Finite alternating sums over `Fin`

We reuse `altFin` from `TwoTimes.Algebra.SumFin`.

---

## Alternating-face boundary from an abstract face operator

We work with any family `X : Nat → Set ℓX` and faces
`d : Fin (suc (suc n)) → X (suc n) → X n`.

The boundary on generators is the alternating sum of faces mapped into `FreeAb` by `η`.

---

## Main lemma: lift generator computation to a chain-level hom equality

If `D2-on-η` holds, then we obtain:
[
\partial_n \circ \partial_{n+1} = 0
]
as a pointwise equality of homomorphisms `HomEq`.

```agda
module _ {ℓF : Level} (FA : FreeAbIF_Ext ℓF) where
  open FreeAbIF_Ext FA using (extFree)
  open TwoTimes.Bicomplex.FreeAbIF_Extensions.FreeAbIF_ExtOps FA using (FreeAb; η; liftHom; liftHom-β-η)
  open Hom using (f)

  FreeAbE₂ : ∀ {ℓX : Level} → Set ℓX → AbGroup (ℓF ⊔ ℓX)
  FreeAbE₂ = FreeAb

  ηE₂ : ∀ {ℓX : Level} {X : Set ℓX} → X → AbGroup.Carrier (FreeAbE₂ X)
  ηE₂ = η

  open import Agda.Builtin.Nat using (Nat; suc)

  ∂-gen
    : ∀ {ℓX : Level} (X : Nat → Set ℓX)
      (d : ∀ {n : Nat} → Fin (suc (suc n)) → X (suc n) → X n) →
      ∀ {n : Nat} →
      X (suc n) → AbGroup.Carrier (FreeAbE₂ (X n))
  ∂-gen X d {n} x =
    altFin (FreeAbE₂ (X n)) (λ i → ηE₂ (d i x))

  ∂
    : ∀ {ℓX : Level} (X : Nat → Set ℓX)
      (d : ∀ {n : Nat} → Fin (suc (suc n)) → X (suc n) → X n) →
      ∀ {n : Nat} →
      Hom (FreeAbE₂ (X (suc n))) (FreeAbE₂ (X n))
  ∂ X d {n} = liftHom (FreeAbE₂ (X n)) (∂-gen X d {n})

  D2-on-η
    : ∀ {ℓX : Level} (X : Nat → Set ℓX)
      (d : ∀ {n : Nat} → Fin (suc (suc n)) → X (suc n) → X n) →
      Nat → Set (ℓF ⊔ ℓX)
  D2-on-η X d n =
    ∀ (x : X (suc (suc n))) →
      f (∂ X d {n}) (∂-gen X d {suc n} x) ≡ AbGroup.0# (FreeAbE₂ (X n))

  -- The lifting lemma used by Batch 3:
  -- once you prove D2-on-η (a generator computation), you immediately get HomEq.
  altBoundaryD2
    : ∀ {ℓX : Level} (X : Nat → Set ℓX)
      (d : ∀ {n : Nat} → Fin (suc (suc n)) → X (suc n) → X n) →
      ∀ (n : Nat) →
      D2-on-η X d n →
      HomEq (∂ X d {n} ∘ ∂ X d {suc n})
            (zeroHom {A = FreeAbE₂ (X (suc (suc n)))} {B = FreeAbE₂ (X n)})
  altBoundaryD2 X d n d2η =
    extFree
      (∂ X d {n} ∘ ∂ X d {suc n})
      (zeroHom {A = FreeAbE₂ (X (suc (suc n)))} {B = FreeAbE₂ (X n)})
      (λ x →
        -- LHS on η x reduces by β-η for the *second* lift, then uses the provided d2η proof.
        --
        -- f (∂n ∘ ∂n+1) (η x)
        -- = f (∂n) (f (∂n+1) (η x))
        -- = f (∂n) (∂-gen_{n+1} x)
        -- = 0
        cong (f (∂ X d {n})) (liftHom-β-η (FreeAbE₂ (X (suc n))) (∂-gen X d {suc n}) x)
        ∙ d2η x)
```
