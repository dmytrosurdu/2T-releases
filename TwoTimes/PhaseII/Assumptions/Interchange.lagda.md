# TwoTimes/PhaseII/Assumptions/Interchange.lagda.md

Phase II: record-level interchange interface on Sys.

This interface packages the interchange path; it is typically *derived* from
weak commutation + diagonalization + record reflection and does not introduce
any "two fillers" tag.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.Interchange where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Equality using (_≡_)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT

-- Record-level interchange witness on Sys.
record InterchangeIF {ℓ ℓT : Level}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  (Rt : RT.RecordTimeIF {ℓ = ℓ} {ℓT = ℓT} C A2 Ad)
  : Set (lsuc (ℓ ⊔ ℓT))
  where

  open Core.CoreIF C public
  open TA.TwoArrowsIF A2 public using (T)
  open RT.RecordTimeIF Rt public using (actSys)
  open Diag.DiagonalizationIF Ad public using (R̂)

  field
    interchange :
      ∀ (t : T) (u : Nat) (s : Sys) →
      R̂ u (actSys t s) ≡ actSys t (R̂ u s)

open InterchangeIF public
```
