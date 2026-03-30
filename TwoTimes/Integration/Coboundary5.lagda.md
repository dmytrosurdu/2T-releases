# TwoTimes/Integration/Coboundary5.lagda.md

Batch 6: coboundaries / “H¹-triviality” for the Batch 5 parity map `ω₅`.

We work purely in **presentation/setoid** style: `Proc₅ r s` is raw syntax and
`≈₅` is the presented equality. Coboundary-ness is a *0-cochain witness* `s : R → Bool`
satisfying the standard section equation.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Coboundary5 where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import Data.Empty using (⊥; ⊥-elim)

open import TwoTimes.Prelude.Path using (sym; trans; cong)
open import TwoTimes.Z2.XorLemmas using (not; xor; xor-idl; xor-idr)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5

infix 3 ¬_
¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

true≢false : true ≡ false → ⊥
true≢false ()

-- --------------------------------------------------------------------------
-- Coboundary notions for Proc₅ / ω₅
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open RP5.Inst Time I public
    using (R; Proc₅)

  open Ω5.Inst Time I public
    using (ω₅; sqLoop; ω₅-sqLoop)

  open Pres.Group Time renaming (Carrier to T)

  -- 0-cochains on objects
  0Cochain : Set ℓR
  0Cochain = R → Bool

  -- Coboundary in “section form” (recommended by the project lead):
  --   s s' = s r xor ω(p)
  --
  -- This matches the later cover constraint:
  --   c ≡ xor b (ω p)
  --
  IsCoboundary :
    (ω : ∀ {r s : R} → Proc₅ r s → Bool) → Set (ℓT ⊔ ℓR)
  IsCoboundary ω =
    Σ 0Cochain (λ s →
      ∀ {r s'} (p : Proc₅ r s') → s s' ≡ xor (s r) (ω p))

  IsCoboundaryω₅ : Set (ℓT ⊔ ℓR)
  IsCoboundaryω₅ = IsCoboundary ω₅

  -- Symmetric re-expression (sometimes convenient):
  -- from section form, we can derive: ω(p) = (s r) xor (s s')
  --
  -- (proved by cases; avoids needing general xor-cancellation lemmas).
  SectionForm→Sym :
    ∀ {ω : ∀ {r s : R} → Proc₅ r s → Bool} →
    IsCoboundary ω →
    Σ 0Cochain (λ s →
      ∀ {r s'} (p : Proc₅ r s') → ω p ≡ xor (s r) (s s'))
  SectionForm→Sym {ω} (s , sec) = s , symFromSec
    where
      symFromSec : ∀ {r s'} (p : Proc₅ r s') → ω p ≡ xor (s r) (s s')
      symFromSec {r} {s'} p with s r | sec {r} {s'} p
      ... | false | eq =
        -- eq : s s' ≡ xor false (ω p) = ω p
        trans (sym eq) refl
      ... | true | eq =
        -- eq : s s' ≡ xor true (ω p) = not (ω p)
        -- so not (ω p) ≡ s s' and by cases on ω p, conclude ω p ≡ xor true (s s')
        caseω (ω p) eq
        where
          caseω : ∀ b → s s' ≡ xor true b → b ≡ xor true (s s')
          caseω true  eq' =  -- s s' ≡ not true = false, so s s' = false and b=true
            -- then xor true (s s') = xor true false = true
            trans refl (cong (λ x → xor true x) (sym eq'))
          caseω false eq' =
            -- s s' ≡ not false = true, so s s' = true and b=false
            -- then xor true (s s') = xor true true = false
            trans refl (cong (λ x → xor true x) (sym eq'))

  -- --------------------------------------------------------------------------
  -- Loop obstruction: if some loop has ω₅ = true, then ω₅ is not a coboundary.
  -- --------------------------------------------------------------------------

  LoopTrue : Set (ℓT ⊔ ℓR)
  LoopTrue = Σ R (λ r → Σ (Proc₅ r r) (λ p → ω₅ p ≡ true))

  SqLoopTrue : Set (ℓT ⊔ ℓR)
  SqLoopTrue =
    Σ T (λ t →
    Σ Nat (λ u →
    Σ R (λ r → ω₅ (sqLoop t u r) ≡ true)))

  SqLoopTrue→LoopTrue : SqLoopTrue → LoopTrue
  SqLoopTrue→LoopTrue (t , (u , (r , prf))) = r , (sqLoop t u r , prf)

  loopTrue→¬Coboundary : LoopTrue → ¬ IsCoboundaryω₅
  loopTrue→¬Coboundary (r , (p , ωp≡true)) (s , sec) =
    -- Use the section equation at the loop p : Proc₅ r r:
    --   s r ≡ xor (s r) (ω₅ p)
    -- and conclude ω₅ p ≡ false by cases on s r; contradiction.
    contradiction
    where
      ωp≡false : ω₅ p ≡ false
      ωp≡false with s r | sec {r = r} {s' = r} p
      ... | false | eq =
        -- eq : false ≡ xor false (ω₅ p) = ω₅ p
        trans (sym (xor-idl (ω₅ p))) (sym eq)
      ... | true | eq =
        -- eq : true ≡ xor true (ω₅ p) = not (ω₅ p)
        -- so not (ω₅ p) ≡ true, hence ω₅ p ≡ false (by cases on ω₅ p)
        caseω (ω₅ p) (sym eq)
        where
          caseω : ∀ b → not b ≡ true → b ≡ false
          caseω true  pr = ⊥-elim (true≢false (sym pr))
          caseω false pr = refl

      contradiction : ⊥
      contradiction =
        true≢false (trans (sym ωp≡true) ωp≡false)

open Inst public
```
