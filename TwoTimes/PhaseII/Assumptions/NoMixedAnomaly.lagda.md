# TwoTimes/PhaseII/Assumptions/NoMixedAnomaly.lagda.md

Phase II (Batch 8) **A_mix / no mixed anomaly** assumption package.

This file encodes the *honest* Phase II move:

> We do **not** derive anomaly-freeness from weak commutativity alone.
> Instead, we assume the existence of a bisimplicial “descent” object `CSK`
> equipped with face maps satisfying the simplicial face–face laws and
> horizontal/vertical commutation.

This record is intended to be the explicit hypothesis that drives the Phase II
bicomplex identities in the final theorem module (Required tweak 2).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.NoMixedAnomaly where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Equality using (_≡_)
open import Agda.Builtin.Nat using (Nat; suc)

open import TwoTimes.Process.Grid.Nerve using (Fin; fzero; fsuc)
open import TwoTimes.Prelude.FinLemmas using (_<_)

import TwoTimes.PhaseII.Assumptions.Core as Core

------------------------------------------------------------------------
-- Index utilities (purely combinatorial; not additional assumptions)
------------------------------------------------------------------------

-- We use the project’s Fin order as a strict order on finite indices.
infix 4 _<ᶠ_
_<ᶠ_ : ∀ {n : Nat} → Fin n → Fin n → Set
_<ᶠ_ = _<_

-- Value-preserving embedding Fin n → Fin (suc n) (keeps the numeric index).
weaken : ∀ {n : Nat} → Fin n → Fin (suc n)
weaken {suc n} fzero    = fzero
weaken {suc n} (fsuc i) = fsuc (weaken i)

-- “Inject” an index into the next larger Fin by keeping its numeric value.
-- This matches the standard simplicial indexing trick used in face-face laws.
inject : ∀ {n : Nat} → Fin (suc (suc n)) → Fin (suc (suc (suc n)))
inject = weaken

-- For i < j, the simplicial identity needs the predecessor index (j-1).
-- Here we only need it in the “j is not zero” case, which follows from i<j.
predJ :
  ∀ {n : Nat} {i : Fin (suc (suc n))}
  (j : Fin (suc (suc (suc n)))) →
  inject i <ᶠ j →
  Fin (suc (suc n))
predJ fzero ()
predJ (fsuc k) _ = k

------------------------------------------------------------------------
-- A_mix interface: anomaly-free bisimplicial descent data exists
------------------------------------------------------------------------

record NoMixedAnomalyIF {ℓ : Level} (C : Core.CoreIF ℓ) : Set (lsuc ℓ) where
  open Core.CoreIF C public

  field
    -- The bisimplicial “descent data” object.
    CSK : Nat → Nat → Set ℓ

    -- Horizontal faces: CSK (m+1,n) → CSK (m,n), indexed by Fin (m+2).
    dH : ∀ {m n : Nat} →
         Fin (suc (suc m)) → CSK (suc m) n → CSK m n

    -- Vertical faces: CSK (m,n+1) → CSK (m,n), indexed by Fin (n+2).
    dV : ∀ {m n : Nat} →
         Fin (suc (suc n)) → CSK m (suc n) → CSK m n

    -- Simplicial face–face law (horizontal direction):
    -- For i < j:
    --   dH i (dH j x) = dH (j-1) (dH (inject i) x)
    faceH-faceH :
      ∀ {m n : Nat}
        (i : Fin (suc (suc m)))
        (j : Fin (suc (suc (suc m))))
        (p : inject i <ᶠ j)
        (x : CSK (suc (suc m)) n) →
        dH i (dH j x) ≡ dH (predJ j p) (dH (inject i) x)

    -- Simplicial face–face law (vertical direction):
    faceV-faceV :
      ∀ {m n : Nat}
        (i : Fin (suc (suc n)))
        (j : Fin (suc (suc (suc n))))
        (p : inject i <ᶠ j)
        (x : CSK m (suc (suc n))) →
        dV i (dV j x) ≡ dV (predJ j p) (dV (inject i) x)

    -- Horizontal / vertical commutation of faces (bisimplicial law):
    faceH-faceV-comm :
      ∀ {m n : Nat}
        (i : Fin (suc (suc m)))
        (j : Fin (suc (suc n)))
        (x : CSK (suc m) (suc n)) →
        dH i (dV j x) ≡ dV j (dH i x)

open NoMixedAnomalyIF public
```
