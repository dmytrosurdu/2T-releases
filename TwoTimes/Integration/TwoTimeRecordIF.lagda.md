# TwoTimes/Integration/TwoTimeRecordIF.lagda.md

This module declares the **minimal Phase I integration interface** tying:

* the global time group `Time`,
* a record type `R` with a `Time`-action (via `RecordDynamics`),
* an RG/diagonal “record step” `rec : Nat → R → R`,
* and a *tagged* family of square fillers `sqPath : Fill → ... ≡ ...`.

**Important (Phase I / intensional Agda):** `Fill` distinguishes operationally distinct square fillers at the *presentation* level; the semantic paths `sqPath` are carried as data for later interpretation. No attempt is made here to compare equality proofs computationally.

The operational meaning of the tags is fixed canonically in
`TwoTimes.Integration.CanonicalFillers`: `diag` acts as identity on `Diff`,
`bridge` acts as `flip`, and the orbit has only these two choices.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.TwoTimeRecordIF where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_; refl)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Obstruction.Omega as Ω

open Pres using (Group; _+_)
open Ω using (RecordDynamics)

-- --------------------------------------------------------------------------
-- Presentation tag for square fillers
-- --------------------------------------------------------------------------

data Fill : Set where
  diag   : Fill
  bridge : Fill

-- --------------------------------------------------------------------------
-- Integration interface
-- --------------------------------------------------------------------------

record TwoTimeRecordIF {ℓT ℓR : Level} (Time : Group ℓT)
  : Set (lsuc (ℓT ⊔ ℓR)) where

  -- Time group carrier
  open Pres.Group Time renaming (Carrier to T) public

  -- Records + Time action (already used by Ω)
  field
    RD : RecordDynamics {ℓR = ℓR} Time

  open Ω.RecordDynamics RD public using (R; act; act-id; act-comp; act-inv)

  -- Abstract “RG / diagonal record step” and its Nat-monoid laws.
  field
    rec      : Nat → R → R
    rec-zero : ∀ r → rec zero r ≡ r
    rec-comp : ∀ r (u₁ u₂ : Nat) → rec (u₂ + u₁) r ≡ rec u₂ (rec u₁ r)

  -- Tagged square fillers as semantic paths in R.
  field
    sqPath :
      Fill → (t : T) (u : Nat) (r : R) →
      rec u (act t r) ≡ act t (rec u r)

  -- Definitional abbreviations (names used in docs / later modules)
  sqDiag :
    (t : T) (u : Nat) (r : R) →
    rec u (act t r) ≡ act t (rec u r)
  sqDiag t u r = sqPath diag t u r

  sqBridge :
    (t : T) (u : Nat) (r : R) →
    rec u (act t r) ≡ act t (rec u r)
  sqBridge t u r = sqPath bridge t u r
```
