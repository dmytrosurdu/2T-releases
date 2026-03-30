# TwoTimes/PhaseII/Assumptions/TwoArrows.lagda.md

Phase II (Batch 8): assumptions for the existence of **two arrows** (two evolutions)
on the doubled SK state space:

* a **group action** `actT` (Lorentzian time),
* a **monoid action** `actU` (RG time, discretized by `Nat`),
* plus a **weak commutativity** axiom between them.

**Guardrail A (convention pinning):** we fix the convention that composition is
“do the left argument first, then the right argument”, consistent with Phase I.
Concretely:

* `actT (t₂ ∙ t₁) x = actT t₂ (actT t₁ x)`
* `actU (u₂ + u₁) x = actU u₂ (actU u₁ x)`

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.TwoArrows where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Nat using (Nat; zero)
open import Agda.Builtin.Equality using (_≡_)

open import TwoTimes.Prelude.NatLemmas using (_+_)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.PhaseII.Assumptions.Core as Core

-- Phase II A₂ package (Two Arrows): a time group action + an RG monoid action,
-- both on SK, plus a weak commutation law on SK.
--
-- Convention pinning (Guardrail A):
--
--   - Group action comp is "rightmost first":
--       actT (t₂ ∙ t₁) x = actT t₂ (actT t₁ x)
--   - RG action comp is likewise "rightmost first":
--       actU (u₂ + u₁) x = actU u₂ (actU u₁ x)
--
-- This matches the repo-wide convention “q ∘ p means do p then q”.
record TwoArrowsIF {ℓ ℓT : Level} (C : Core.CoreIF ℓ) : Set (lsuc (ℓ ⊔ ℓT)) where
  open Core.CoreIF C public

  field
    Time : Pres.Group ℓT

  open Pres.Group Time
    renaming (Carrier to T; e to eT; _∙_ to _∙T_; inv to invT)
    public

  field
    --------------------------------------------------------------------------
    -- Time evolution on SK
    --------------------------------------------------------------------------
    actT : T → SK → SK
    actT-id   : ∀ x → actT eT x ≡ x
    actT-comp : ∀ x (t₁ t₂ : T) → actT (t₂ ∙T t₁) x ≡ actT t₂ (actT t₁ x)
    actT-inv  : ∀ x (t : T) → actT (invT t) (actT t x) ≡ x

    --------------------------------------------------------------------------
    -- RG evolution on SK (discretized)
    --------------------------------------------------------------------------
    actU : Nat → SK → SK
    actU-zero : ∀ x → actU zero x ≡ x
    actU-comp : ∀ x (u₁ u₂ : Nat) → actU (u₂ + u₁) x ≡ actU u₂ (actU u₁ x)

    --------------------------------------------------------------------------
    -- Weak commutativity on SK (A₂ “weak commutation” substitute in Phase II-A)
    --------------------------------------------------------------------------
    weak-comm :
      ∀ (t : T) (u : Nat) (x : SK) →
      actU u (actT t x) ≡ actT t (actU u x)

open TwoArrowsIF public

```
