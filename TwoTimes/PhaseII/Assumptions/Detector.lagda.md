# TwoTimes/PhaseII/Assumptions/Detector.lagda.md

Phase II (Batch 8) **detector** interface: a set-level observable on `SK` that

1. is **constant on diagonal** (`diag` collapses), so it factors through `Diff = Cofiber diag`, and
2. is **odd somewhere under swap**, i.e. detects a point `x` with `obs (swap x) ≢ obs x`.

This is the recommended nontriviality mechanism in intensional (non-cubical) Agda:
separate points via a map to a set, rather than proving inequalities inside the HIT.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.Detector where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Equality using (_≡_)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import TwoTimes.Prelude.IsSet using (isSet)
import TwoTimes.PhaseII.Assumptions.Core as Core

-- --------------------------------------------------------------------------
-- Minimal negation / inequality utilities (kept local; no stdlib dependency)
-- --------------------------------------------------------------------------

data ⊥ : Set where

infix 3 ¬_
¬_ : ∀ {ℓ : Level} → Set ℓ → Set ℓ
¬ A = A → ⊥

infix 4 _≢_
_≢_ : ∀ {ℓ : Level} {A : Set ℓ} → A → A → Set ℓ
x ≢ y = ¬ (x ≡ y)

-- --------------------------------------------------------------------------
-- Detector interface
-- --------------------------------------------------------------------------

record DetectorIF {ℓ : Level} (C : Core.CoreIF ℓ) : Set (lsuc ℓ) where
  open Core.CoreIF C

  field
    -- Value type for an “observable”
    X      : Set ℓ
    XIsSet : isSet X

    -- Observable on SK
    obs : SK → X

    -- Diagonal collapse: constant on diag
    base     : X
    obs-diag : ∀ s → obs (diag s) ≡ base

    -- Oddness witness: swap changes obs somewhere
    witness : Σ SK (λ x → obs (swap x) ≢ obs x)

open DetectorIF public
```
