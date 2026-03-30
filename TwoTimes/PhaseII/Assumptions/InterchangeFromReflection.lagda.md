# TwoTimes/PhaseII/Assumptions/InterchangeFromReflection.lagda.md

Phase II: derive record-level interchange from weak commutation, diagonalization,
and record reflection.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.InterchangeFromReflection where

open import Agda.Primitive using (Level)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_)

open import TwoTimes.Prelude.Path using (_∙_; cong; sym)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.RecordReflection as RR
import TwoTimes.PhaseII.Assumptions.Interchange as Int
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT

interchangeFromReflection :
  ∀ {ℓ ℓT}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  (Rf : RR.RecordReflectionIF C) →
  Int.InterchangeIF C A2 Ad (RT.recordTimeFromRG C A2 Ad Rf)
interchangeFromReflection C A2 Ad Rf =
  record
    { interchange = interchange }
  where
    Rt = RT.recordTimeFromRG C A2 Ad Rf

    open Core.CoreIF C
    open TA.TwoArrowsIF A2 using (T; actT; actU; weak-comm)
    open Diag.DiagonalizationIF Ad
      using (R̂; actU-diag; R̂-zero)
    open RR.RecordReflectionIF Rf using (diag-cancel)
    open RT.RecordTimeIF Rt using (actSys; actT-diagRG)

    interchange :
      ∀ (t : T) (u : Nat) (s : Sys) →
      R̂ u (actSys t s) ≡ actSys t (R̂ u s)
    interchange t zero s =
      R̂-zero (actSys t s) ∙ sym (cong (actSys t) (R̂-zero s))
    interchange t (suc u) s =
      let
        leftPath : actU (suc u) (diag (actSys t s)) ≡ diag (R̂ (suc u) (actSys t s))
        leftPath = actU-diag u (actSys t s)

        step0 : actU (suc u) (diag (actSys t s)) ≡ actT t (actU (suc u) (diag s))
        step0 =
          sym (cong (actU (suc u)) (actT-diagRG t s))
          ∙ weak-comm t (suc u) (diag s)

        rightPath :
          actT t (actU (suc u) (diag s)) ≡ diag (actSys t (R̂ (suc u) s))
        rightPath =
          cong (actT t) (actU-diag u s)
          ∙ actT-diagRG t (R̂ (suc u) s)
      in
        diag-cancel (sym leftPath ∙ step0 ∙ rightPath)
```
