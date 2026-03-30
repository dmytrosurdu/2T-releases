# TwoTimes/Integration/Omega5OddnessOnAb.lagda.md

This module packages the ω₅ parity as a sign action on any abelian group,
and proves that the square-loop acts by negation.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Omega5OddnessOnAb where

open import Agda.Primitive using (Level)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Prelude.Path using (cong; _∙_)
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup)

open import TwoTimes.Algebra.Sign using (sgn)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5

module Inst {ℓT ℓR ℓG : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  (G    : AbGroup ℓG)
  where

  open Pres.Group Time renaming (Carrier to T; _∙_ to _∙T_)

  module P = RP5.Inst Time I
  module O = Ω5.Inst Time I

  open P using (R; Proc₅; sqLoop)
  open O using (ω₅; ω₅-sqLoop)

  open AbGroup G renaming (Carrier to GCarrier; -_ to -G_)

  -- ω-twisted local system action on the constant coefficient group G
  actωG : ∀ {r s : R} → Proc₅ r s → GCarrier → GCarrier
  actωG p x = sgn G (ω₅ p) x

  -- Key lemma: sqLoop holonomy is multiplication by -1
  actωG-sqLoop :
    ∀ (t : T) (u : Nat) (r : R) (x : GCarrier) →
    actωG (sqLoop t u r) x ≡ -G_ x
  actωG-sqLoop t u r x =
    cong (λ b → sgn G b x) (ω₅-sqLoop t u r) ∙ refl
```
