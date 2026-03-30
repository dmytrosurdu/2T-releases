# TwoTimes/Integration/Omega5ActionOnDiff.lagda.md

Batch 7 (D7.6): represent the **parity cocycle** `ω₅` as an actual action on the
difference object `Diff = Cofiber diag`.

Given:

* the Batch 5 presented groupoid `Proc₅` with equality `≈₅`,
* the parity map `ω₅ : Proc₅ r s → Bool` with `ω₅-resp`,
* a Diff-level `Z2Action Diff` (from `DiffZ2Action`) built from the SK swap,

we define:

* `actω p x = act (ω₅ p) x`

and prove, pointwise (no funext):

* `actω-resp : p ≈₅ q → ∀ x → actω p x ≡ actω q x`
* `actω-comp : ∀ p q x → actω (p ⨟ q) x ≡ actω q (actω p x)` (functorial order)
* `actω-sqLoop : ∀ t u r x → actω (sqLoop t u r) x ≡ flip x`

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Omega5ActionOnDiff where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat)

open import TwoTimes.Prelude.Path using (sym; trans; cong; _∙_)
open import TwoTimes.Z2.XorLemmas using (xor; xor-comm)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Integration.SKSwapIF as SK
import TwoTimes.Integration.DiffZ2Action as DZ
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5

-- Pointwise equality of endomaps (no funext).
HomEq : ∀ {ℓ} {X : Set ℓ} → (X → X) → (X → X) → Set ℓ
HomEq f g = ∀ x → f x ≡ g x

module Inst {ℓ ℓT ℓR : Level}
  (H : PI.PushoutIndIF ℓ)
  (S : SK.SKSwapIF ℓ)
  (Time : Pres.Group ℓT)
  (I : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  -- Diff-level Z₂ action from the SK swap.
  module D = DZ.Inst H S
  open D public using (Diff; flip; mkZ2Action; act-true)

  A : DZ.Z2Action Diff
  A = D.mkZ2Action

  act : Bool → Diff → Diff
  act = DZ.Z2Action.act A

  -- Record-process layer (Proc₅, ≈₅, sqLoop) and parity ω₅
  module P = RP5.Inst Time I
  module O = Ω5.Inst Time I

  open P public using (R; Proc₅; _≈₅_; _⨟_; sqLoop)
  open O public using (ω₅; ω₅-resp; ω₅-sqLoop)

  -- The ω-action on Diff
  actω : ∀ {r s : R} → Proc₅ r s → Diff → Diff
  actω p x = act (ω₅ p) x

  -- --------------------------------------------------------------------------
  -- Generic lemma: abelianity of a Bool/xor action
  --
  -- From act-xor and xor-comm we can swap the order of actions:
  --   act b (act c x) = act c (act b x)
  -- This is crucial to get the “functorial” ordering with the project’s
  -- convention for Proc₅ composition.
  -- --------------------------------------------------------------------------

  act-comm : ∀ (b c : Bool) (x : Diff) → act b (act c x) ≡ act c (act b x)
  act-comm b c x =
    -- act b (act c x)  ≡ act (xor b c) x
    --                ≡ act (xor c b) x     (xor-comm)
    --                ≡ act c (act b x)
    ( sym (DZ.Z2Action.act-xor A b c x)
      ∙ cong (λ k → act k x) (xor-comm b c)
      ∙ DZ.Z2Action.act-xor A c b x
    )

  -- --------------------------------------------------------------------------
  -- Respect for ≈₅ (well-definedness)
  -- --------------------------------------------------------------------------

  actω-resp :
    ∀ {r s : R} {p q : Proc₅ r s} →
    p ≈₅ q → ∀ x → actω p x ≡ actω q x
  actω-resp {p = p} {q = q} h x =
    cong (λ b → act b x) (ω₅-resp h)

  -- --------------------------------------------------------------------------
  -- Composition law (functorial order):
  --   actω (p ⨟ q) = actω q ∘ actω p     (pointwise)
  --
  -- Proof: ω₅(p⨟q) = xor (ω₅ p) (ω₅ q) definitionally, and using the action
  -- law + commutation to swap order.
  -- --------------------------------------------------------------------------

  actω-comp :
    ∀ {r s t : R} (p : Proc₅ r s) (q : Proc₅ s t) →
    ∀ x → actω (p ⨟ q) x ≡ actω q (actω p x)
  actω-comp p q x =
    -- actω(p⨟q) x = act (xor (ω₅ p) (ω₅ q)) x
    --             = act (ω₅ p) (act (ω₅ q) x)          (act-xor)
    --             = act (ω₅ q) (act (ω₅ p) x)          (act-comm)
    --             = actω q (actω p x)
    let b = ω₅ p
        c = ω₅ q
    in
      ( DZ.Z2Action.act-xor A b c x
        ∙ act-comm b c x
      )

  -- --------------------------------------------------------------------------
  -- Square-loop acts by flip (odd operator)
  -- --------------------------------------------------------------------------

  actω-sqLoop :
    ∀ (t : Pres.Group.Carrier Time) (u : Nat) (r : R) →
    ∀ x → actω (sqLoop t u r) x ≡ flip x
  actω-sqLoop t u r x =
    -- actω(sqLoop) x = act (ω₅(sqLoop)) x = act true x = flip x
    ( cong (λ b → act b x) (ω₅-sqLoop t u r)
      ∙ act-true x
    )

open Inst public
```
