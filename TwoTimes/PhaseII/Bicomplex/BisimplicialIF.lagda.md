# TwoTimes/PhaseII/Bicomplex/BisimplicialIF.lagda.md

Phase II (Batch 8): a **generic bisimplicial interface** for descent data.

This is the minimal abstraction needed to define the bicomplex boundaries
`Qt`/`Qu` and prove the identities `Qt² = 0`, `Qu² = 0`, and anticommutation,
assuming only:

* horizontal face–face simplicial identities,
* vertical face–face simplicial identities,
* horizontal/vertical commutation of faces.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Bicomplex.BisimplicialIF where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Equality using (_≡_)
open import Agda.Builtin.Nat using (Nat; suc)

open import TwoTimes.Process.Grid.Nerve using (Fin; fzero; fsuc)
open import TwoTimes.Prelude.FinLemmas using (_<_)

------------------------------------------------------------------------
-- Fin index utilities (purely combinatorial; no extra assumptions)
------------------------------------------------------------------------

infix 4 _<ᶠ_
_<ᶠ_ : ∀ {n : Nat} → Fin n → Fin n → Set
_<ᶠ_ = _<_

-- Value-preserving embedding Fin n → Fin (suc n).
weaken : ∀ {n : Nat} → Fin n → Fin (suc n)
weaken {suc n} fzero    = fzero
weaken {suc n} (fsuc i) = fsuc (weaken i)

-- “Inject” an index into the next larger Fin by keeping its numeric value.
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
-- Bisimplicial interface
------------------------------------------------------------------------

record BisimplicialIF (ℓ : Level) : Set (lsuc ℓ) where
  field
    -- Underlying bisimplicial object (bidegree (m,n)).
    X : Nat → Nat → Set ℓ

    -- Horizontal faces: X (m+1,n) → X (m,n), indexed by Fin (m+2).
    dH : ∀ {m n : Nat} →
         Fin (suc (suc m)) → X (suc m) n → X m n

    -- Vertical faces: X (m,n+1) → X (m,n), indexed by Fin (n+2).
    dV : ∀ {m n : Nat} →
         Fin (suc (suc n)) → X m (suc n) → X m n

    -- Simplicial face–face law (horizontal direction): for i < j
    faceH-faceH :
      ∀ {m n : Nat}
        (i : Fin (suc (suc m)))
        (j : Fin (suc (suc (suc m))))
        (p : inject i <ᶠ j)
        (x : X (suc (suc m)) n) →
        dH i (dH j x) ≡ dH (predJ j p) (dH (inject i) x)

    -- Simplicial face–face law (vertical direction): for i < j
    faceV-faceV :
      ∀ {m n : Nat}
        (i : Fin (suc (suc n)))
        (j : Fin (suc (suc (suc n))))
        (p : inject i <ᶠ j)
        (x : X m (suc (suc n))) →
        dV i (dV j x) ≡ dV (predJ j p) (dV (inject i) x)

    -- Horizontal / vertical commutation of faces (bisimplicial law)
    faceH-faceV-comm :
      ∀ {m n : Nat}
        (i : Fin (suc (suc m)))
        (j : Fin (suc (suc n)))
        (x : X (suc m) (suc n)) →
        dH i (dV j x) ≡ dV j (dH i x)

open BisimplicialIF public
```
