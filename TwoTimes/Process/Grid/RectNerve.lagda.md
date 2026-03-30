# TwoTimes/Process/Grid/RectNerve.lagda.md

Batch 4 stretch (D4.4): a typed “Rect layer” that is definitionally the nerve grid,
plus face-compatibility lemmas (all `refl`).

No `flattenRect` here (explicitly deferred).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Process.Grid.RectNerve where

open import Agda.Primitive using (Level; _⊔_; lzero; lsuc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Process.Grid.Nerve as Nerv

module Inst {ℓT : Level} (Time : Pres.Group ℓT) where

  open Nerv using (Fin; fzero; fsuc)
  module G = Nerv.Grid Time
  open G public using (Grid; dH; dV)

  -- Rect is just a wrapper around Grid.
  record Rect (m n : Nat) : Set ℓT where
    constructor rect
    field unrect : Grid m n
  open Rect public

  interpRect : ∀ {m n : Nat} → Rect m n → Grid m n
  interpRect r = unrect r

  rectFaceH : ∀ {m n : Nat} → Fin (suc (suc m)) → Rect (suc m) n → Rect m n
  rectFaceH i r = rect (dH i (unrect r))

  rectFaceV : ∀ {m n : Nat} → Fin (suc (suc n)) → Rect m (suc n) → Rect m n
  rectFaceV j r = rect (dV j (unrect r))

  -- Face compatibility is definitional by construction.
  interpRect-faceH :
    ∀ {m n : Nat} (i : Fin (suc (suc m))) (r : Rect (suc m) n) →
    interpRect (rectFaceH i r) ≡ dH i (interpRect r)
  interpRect-faceH i r = refl

  interpRect-faceV :
    ∀ {m n : Nat} (j : Fin (suc (suc n))) (r : Rect m (suc n)) →
    interpRect (rectFaceV j r) ≡ dV j (interpRect r)
  interpRect-faceV j r = refl

open Inst public
```
