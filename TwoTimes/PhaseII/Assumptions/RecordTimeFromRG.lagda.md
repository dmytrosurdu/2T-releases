Phase II: derive record-level time action from the RG sector.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.RecordTimeFromRG where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_)

open import TwoTimes.Prelude.Path using (_∙_; cong; sym)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.RecordReflection as RR

record RecordTimeIF {ℓ ℓT : Level}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  : Set (lsuc (ℓ ⊔ ℓT))
  where

  open Core.CoreIF C
  open TA.TwoArrowsIF A2 using (T; eT; _∙T_; invT; actT)
  open Diag.DiagonalizationIF Ad using (Π)

  field
    -- Record-level time action induced from RG sector.
    actSys : T → Sys → Sys
    actSys-id   : ∀ s → actSys eT s ≡ s
    actSys-comp :
      ∀ s (t₁ t₂ : T) →
      actSys (t₂ ∙T t₁) s ≡ actSys t₂ (actSys t₁ s)
    actSys-inv  :
      ∀ s (t : T) →
      actSys (invT t) (actSys t s) ≡ s

    -- Derived diagonal equivariance on the RG sector.
    actT-diagRG : ∀ (t : T) (s : Sys) → actT t (diag s) ≡ diag (actSys t s)

open RecordTimeIF public

recordTimeFromRG :
  ∀ {ℓ ℓT}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  (Rf : RR.RecordReflectionIF C) →
  RecordTimeIF C A2 Ad
recordTimeFromRG C A2 Ad Rf =
  record
    { actSys      = actSysRG
    ; actSys-id   = actSysRG-id
    ; actSys-comp = actSysRG-comp
    ; actSys-inv  = actSysRG-inv
    ; actT-diagRG = actT-diagRG'
    }
  where
    open Core.CoreIF C
    open TA.TwoArrowsIF A2 using
      (T; eT; _∙T_; invT; actT; actT-id; actT-comp; actT-inv; actU; weak-comm)
    open Diag.DiagonalizationIF Ad using
      (Π; secΠ; secΠ-β; actU-factor-suc)
    open RR.RecordReflectionIF Rf using (diag-cancel)

    actSysRG : T → Sys → Sys
    actSysRG t s = Π (suc zero) (actT t (secΠ s))

    Π-actT-cong :
      ∀ (t : T) (x y : SK) →
      Π (suc zero) x ≡ Π (suc zero) y →
      Π (suc zero) (actT t x) ≡ Π (suc zero) (actT t y)
    Π-actT-cong t x y Πeq =
      diag-cancel
        ( sym (actU-factor-suc zero (actT t x))
        ∙ weak-comm t (suc zero) x
        ∙ cong (actT t) (actU-factor-suc zero x)
        ∙ cong (actT t) (cong diag Πeq)
        ∙ cong (actT t) (sym (actU-factor-suc zero y))
        ∙ sym (weak-comm t (suc zero) y)
        ∙ actU-factor-suc zero (actT t y)
        )

    actSysRG-id : ∀ s → actSysRG eT s ≡ s
    actSysRG-id s =
      cong (Π (suc zero)) (actT-id (secΠ s))
      ∙ secΠ-β s

    actSysRG-comp :
      ∀ s (t₁ t₂ : T) →
      actSysRG (t₂ ∙T t₁) s ≡ actSysRG t₂ (actSysRG t₁ s)
    actSysRG-comp s t₁ t₂ =
      cong (Π (suc zero)) (actT-comp (secΠ s) t₁ t₂)
      ∙ Π-actT-cong t₂
          (actT t₁ (secΠ s))
          (secΠ (actSysRG t₁ s))
          (sym (secΠ-β (actSysRG t₁ s)))

    actSysRG-inv : ∀ s (t : T) → actSysRG (invT t) (actSysRG t s) ≡ s
    actSysRG-inv s t =
      Π-actT-cong (invT t)
        (secΠ (actSysRG t s))
        (actT t (secΠ s))
        (secΠ-β (actSysRG t s))
      ∙ cong (Π (suc zero)) (actT-inv (secΠ s) t)
      ∙ secΠ-β s

    actT-diagRG' : ∀ (t : T) (s : Sys) → actT t (diag s) ≡ diag (actSysRG t s)
    actT-diagRG' t s =
      cong (actT t)
        (sym (actU-factor-suc zero (secΠ s) ∙ cong diag (secΠ-β s)))
      ∙ sym (weak-comm t (suc zero) (secΠ s))
      ∙ actU-factor-suc zero (actT t (secΠ s))
```
