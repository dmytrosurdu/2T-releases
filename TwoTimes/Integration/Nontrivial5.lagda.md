# TwoTimes/Integration/Nontrivial5.lagda.md

Batch 5 nontriviality lemma for the **presented integration groupoid** `Proc₅`
and its parity map `ω₅`.

Key deliverable: `nontrivLoop5 -> not Trivialomega5`.

where `nontrivLoop₅` is a **groupoid-level** hypothesis about `≈₅`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Nontrivial5 where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)
open import Data.Empty using (⊥; ⊥-elim)

open import TwoTimes.Prelude.Path using (sym; trans)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5

infix 3 ¬_
¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

true≢false : true ≡ false → ⊥
true≢false ()

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open Pres.Group Time renaming (Carrier to T)

  open RP5.Inst Time I public
    using (R; Proc₅; _≈₅_; id; sqLoop)

  open Ω5.Inst Time I public
    using (ω₅; ω₅-sqLoop; Trivialω₅)

  -- --------------------------------------------------------------------------
  -- Groupoid-level “physics hook” (as required by the project lead)
  --
  -- There exist parameters producing a square-loop that is *not* identified
  -- with the identity by the presented equality ≈₅.
  -- --------------------------------------------------------------------------

  nontrivLoop₅ : Set (ℓT ⊔ ℓR)
  nontrivLoop₅ =
    Σ T (λ t →
    Σ Nat (λ u →
    Σ R (λ r →
      ¬ (sqLoop t u r ≈₅ id r))))

  -- --------------------------------------------------------------------------
  -- Nontriviality: conditional on nontrivLoop₅ (supplies a witness record r,
  -- plus the intended “not collapsed by relations” hypothesis at the ≈₅ level).
  --
  -- Note: the proof only needs the witness (t,u,r) and Trivialω₅; the ≈₅-inequality
  -- is included to pin down that the loop is not intended to be definitional noise.
  -- --------------------------------------------------------------------------

  nontrivLoop₅→¬Trivialω₅ : nontrivLoop₅ → ¬ Trivialω₅
  nontrivLoop₅→¬Trivialω₅ (t , (u , (r , _notCollapsed))) triv =
    true≢false
      (trans
        (sym (ω₅-sqLoop t u r))     -- true ≡ ω₅(sqLoop…)
        (triv (sqLoop t u r)))      -- ω₅(sqLoop…) ≡ false

open Inst public
```
