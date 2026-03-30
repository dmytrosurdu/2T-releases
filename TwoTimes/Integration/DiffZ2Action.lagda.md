# TwoTimes/Integration/DiffZ2Action.lagda.md

Batch 7 (D7.5): build the **difference object** `Diff := Cofiber diag` and a
canonical **Z₂-action candidate** on it arising from an abstract SK branch-swap.

This module is **Phase I+ / still --safe**:

* It *defines* the candidate endomorphism `flip : Diff → Diff` induced by `swap : SK → SK`.
* It *packages* the key proof obligation `flip² : ∀ x → flip (flip x) ≡ x` as a goal
  coming from the cofiber-iso construction (Batch 7 D7.3).
* From `flip²` it constructs a `Z2Action Diff` instance (pointwise, no funext).

> **Where the real proof happens (team work):**
> The involution proof `flip²` is to be obtained by proving the cofiber map induced by
> `swap` is an isomorphism/involution using `Cofiber-ind` and the whiskered
> `Cofiber-map-β-glue` lemma from `TwoTimes.Diff.CofiberInd`, via
> `TwoTimes.Diff.CofiberIso`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.DiffZ2Action where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Prelude.Path using (sym; trans; cong)

import TwoTimes.Z2.XorLemmas as XOR
import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Diff.CofiberIso as CofIso
import TwoTimes.Integration.SKSwapIF as SK

-- Pointwise equality of endomaps (no funext).
HomEq : ∀ {ℓ} {X : Set ℓ} → (X → X) → (X → X) → Set ℓ
HomEq f g = ∀ x → f x ≡ g x

-- --------------------------------------------------------------------------
-- Z₂-action record (Bool-based, xor law)
-- --------------------------------------------------------------------------

record Z2Action {ℓ : Level} (X : Set ℓ) : Set (lsuc ℓ) where
  field
    act      : Bool → X → X
    act-false : ∀ x → act false x ≡ x
    act-xor  : ∀ b c x → act (XOR.xor b c) x ≡ act b (act c x)

open Z2Action public

-- --------------------------------------------------------------------------
-- Main construction, parameterized by pushout induction interface + SK swap
-- --------------------------------------------------------------------------

module Inst {ℓ : Level}
  (H  : PI.PushoutIndIF ℓ)
  (S  : SK.SKSwapIF ℓ)
  where

  open PI.PushoutIndIF H public
    using (base; Pushout; inl; inr; glue; rec; β-inl; β-inr)

  -- Pull out the SK swap interface
  open SK.SKSwapIF S public
    using (Sys; SK; diag; swap; swap²; swap-diag; SysIsSet; SKIsSet)

  -- The square data for the map diag : Sys → SK induced by the swap involution.
  --
  -- We use the SquareIsoData record from TwoTimes.Diff.CofiberIso.
  -- αIso is identity on Sys; βIso is swap on SK (self-inverse).
  idIso : CofIso.Iso Sys
  CofIso.Iso.f  idIso x = x
  CofIso.Iso.g  idIso x = x
  CofIso.Iso.fg idIso x = refl
  CofIso.Iso.gf idIso x = refl

  swapIso : CofIso.Iso SK
  CofIso.Iso.f  swapIso = swap
  CofIso.Iso.g  swapIso = swap
  CofIso.Iso.fg swapIso = swap²
  CofIso.Iso.gf swapIso = swap²

  diagSquareIsoData : CofIso.SquareIsoData diag
  CofIso.SquareIsoData.αIso  diagSquareIsoData = idIso
  CofIso.SquareIsoData.βIso  diagSquareIsoData = swapIso
  CofIso.SquareIsoData.commF diagSquareIsoData s = swap-diag s
  CofIso.SquareIsoData.commG diagSquareIsoData s = swap-diag s

  -- Instantiate CofiberIso using the SK isSet assumption.
  module CI = CofIso.Inst H SKIsSet diag diagSquareIsoData

  open CI public using (Cofiber; cf-in; cf-base; cf-glue)

  -- The difference object
  Diff : Set ℓ
  Diff = Cofiber diag

  flipIso : CofIso.Iso Diff
  flipIso = CI.cofiberIsoFromSquareIsoData-iso

  -- Candidate flip map on Diff: the forward map of the cofiber iso.
  flip : Diff → Diff
  flip = CofIso.Iso.f flipIso

  -- Derived involution law (no external witness).
  flip² : ∀ x → flip (flip x) ≡ x
  flip² x = CofIso.Iso.fg flipIso x

  -- ------------------------------------------------------------------------
  -- Build the Bool/xor action once flip² is available
  -- ------------------------------------------------------------------------

  actDiff : Diff → Diff
  actDiff = flip

  actD : Bool → Diff → Diff
  actD false x = x
  actD true  x = actDiff x

  actD-false : ∀ x → actD false x ≡ x
  actD-false x = refl

  -- The xor law needs flip² only in the (true,true) case.
  mkZ2Action : Z2Action Diff
  Z2Action.act      mkZ2Action = actD
  Z2Action.act-false mkZ2Action = actD-false
  Z2Action.act-xor  mkZ2Action b c x with b | c
  ... | false | false = refl
  ... | false | true  = refl
  ... | true  | false = refl
  ... | true  | true  =
    -- xor true true = false, so LHS is x; RHS is flip (flip x).
    sym (flip² x)

  -- Convenience: act true = flip
  act-true : ∀ (x : Diff) → Z2Action.act mkZ2Action true x ≡ flip x
  act-true x = refl

open Inst public
```
