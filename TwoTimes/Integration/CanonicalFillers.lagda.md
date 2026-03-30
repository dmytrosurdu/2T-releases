# TwoTimes/Integration/CanonicalFillers.lagda.md

Canonical, **non-cubical** meaning of the two filler tags:

* `diag` corresponds to the identity action on `Diff`.
* `bridge` corresponds to the involution `flip`.
* The only canonical options are the Z₂-orbit `{ id , flip }`, witnessed pointwise.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.CanonicalFillers where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Sigma using (Σ; _,_)

open import TwoTimes.Prelude.Path using (sym; trans)
open import TwoTimes.Z2.XorLemmas using (not)

import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Integration.SKSwapIF as SK
import TwoTimes.Integration.DiffZ2Action as DZ
import TwoTimes.Integration.TwoTimeRecordIF as IF

module Inst {ℓ : Level}
  (H : PI.PushoutIndIF ℓ)
  (S : SK.SKSwapIF ℓ)
  where

  open IF public using (Fill; diag; bridge)

  module D = DZ.Inst H S
  open D public using (Diff; flip; flip²; mkZ2Action; act-true)

  open DZ.Z2Action mkZ2Action public using (act; act-false; act-xor)

  toggle : Fill → Fill
  toggle diag = bridge
  toggle bridge = diag

  toggle² : ∀ f → toggle (toggle f) ≡ f
  toggle² diag = refl
  toggle² bridge = refl

  fillParity : Fill → Bool
  fillParity diag = false
  fillParity bridge = true

  fillParity-toggle : ∀ f → fillParity (toggle f) ≡ not (fillParity f)
  fillParity-toggle diag = refl
  fillParity-toggle bridge = refl

  actFill : Fill → Diff → Diff
  actFill f x = act (fillParity f) x

  actFill-diag : ∀ x → actFill diag x ≡ x
  actFill-diag x = act-false x

  actFill-bridge : ∀ x → actFill bridge x ≡ flip x
  actFill-bridge x = act-true x

  actFill-toggle :
    ∀ f x → actFill (toggle f) x ≡ flip (actFill f x)
  actFill-toggle diag x = refl
  actFill-toggle bridge x = sym (flip² x)

  actFill-toggle² :
    ∀ f x → actFill (toggle (toggle f)) x ≡ actFill f x
  actFill-toggle² diag x = refl
  actFill-toggle² bridge x = refl

  actFill-bridge≡diag→flip-id :
    (∀ x → actFill bridge x ≡ actFill diag x) → ∀ x → flip x ≡ x
  actFill-bridge≡diag→flip-id eq x =
    trans (sym (actFill-bridge x)) (trans (eq x) (actFill-diag x))

  nonfixed→actFillDifferent :
    ∀ {Z : Set} →
    Σ Diff (λ y → flip y ≡ y → Z) →
    Σ Diff (λ y → actFill bridge y ≡ actFill diag y → Z)
  nonfixed→actFillDifferent {Z} (y , ny) =
    y , λ eq →
      ny (trans (sym (actFill-bridge y)) (trans eq (actFill-diag y)))

  nonfixed→¬actFillBridge≡Diag :
    ∀ {Z : Set} →
    Σ Diff (λ y → flip y ≡ y → Z) →
    (∀ x → actFill bridge x ≡ actFill diag x) → Z
  nonfixed→¬actFillBridge≡Diag {Z} (y , ny) eq =
    ny (trans (sym (actFill-bridge y)) (trans (eq y) (actFill-diag y)))

open Inst public
```
