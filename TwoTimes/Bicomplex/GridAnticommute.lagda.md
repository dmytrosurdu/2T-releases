```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Bicomplex.GridAnticommute where
```

# Grid anticommutation: lifting `{Qt,Qu}=0` from generators

This module packages the **Batch 3 lifting step** for the mixed bicomplex law:

[
Qt \circ Qu + Qu \circ Qt = 0
]

for the **product grid** from `TwoTimes.Process.Grid.Nerve`, where:

* `Qt` is the alternating sum of **horizontal** faces,
* `Qu` is the alternating sum of **vertical** faces, multiplied by the Koszul twist `(-1)^m`
  (horizontal degree).

At this stage, the hard part (the **generator-level** cancellation proof) is kept as an
**assumption parameter** `AnticommOnη`, and we provide the clean, reviewable lift:

* generator computation on `η`-generators
* ⟹ chain-level `HomEq` by `extFree`

No postulates, no holes, no funext.

---

## Imports

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Process.Grid.Presentation using (Group)
import TwoTimes.Process.Grid.Nerve as N
open import TwoTimes.Prelude.Path

open import TwoTimes.Bicomplex.FreeAbIF_Extensions
  using (AbGroup; Hom; HomEq; _∘_; zeroHom; addHom; FreeAbIF_Ext)
import TwoTimes.Bicomplex.BoundaryDefs as BD

```

## Main construction: Qt, Qu, and the lifted anticommutation lemma

```agda
module _ {ℓT ℓF : Level} (Time : Group ℓT) (FA : FreeAbIF_Ext ℓF) where

  open FreeAbIF_Ext FA using (extFree)
  open TwoTimes.Bicomplex.FreeAbIF_Extensions.FreeAbIF_ExtOps FA using (FreeAb; η; liftHom)
  open Hom using (f)

  FreeAbE : ∀ {ℓX : Level} → Set ℓX → AbGroup (ℓF ⊔ ℓX)
  FreeAbE = FreeAb

  ηE : ∀ {ℓX : Level} {X : Set ℓX} → X → AbGroup.Carrier (FreeAbE X)
  ηE = η

  open N.Grid Time renaming (Grid to Grid₀)
  open BD.BoundaryDefs Time FA
    using (C; ∂H-gen; ∂V-gen; Qt; Qu; anticommHom)

  -- Generator-level condition: the mixed map vanishes on η-generators.
  --
  -- This is exactly what Batch 3 will prove *algebraically* using:
  -- - commutation of horizontal/vertical faces,
  -- - the Koszul sign shift when m decreases by 1 under Qt,
  -- - abelian group laws + homomorphism laws for lift.
  AnticommOnη : (m n : Nat) → Set (ℓF ⊔ ℓT)
  AnticommOnη m n =
    ∀ (x : Grid₀ (suc m) (suc n)) →
      f (anticommHom m n) (ηE x) ≡ AbGroup.0# (C m n)

  -- Lift generator-level anticommutation to a chain-level HomEq via extFree.
  gridAnticommute
    : ∀ (m n : Nat) →
      AnticommOnη m n →
      HomEq (anticommHom m n)
            (zeroHom {A = C (suc m) (suc n)} {B = C m n})
  gridAnticommute m n anticommη =
    extFree
      (anticommHom m n)
      (zeroHom {A = C (suc m) (suc n)} {B = C m n})
      anticommη
```
