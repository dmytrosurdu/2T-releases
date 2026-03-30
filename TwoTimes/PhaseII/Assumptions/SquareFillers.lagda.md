# TwoTimes/PhaseII/Assumptions/SquareFillers.lagda.md

Phase II: **square filler** compatibility interface at the *record/Sys* level.

This interface is a legacy bridge to instantiate the Phase I
`TwoTimeRecordIF` / `Proc₅` layer on `R = Sys`. It is now **derived** from the
single interchange witness (see `SquareFillersFromInterchange`) rather than
being a primitive assumption.

**Guardrail note (Required tweak 1 context).** Because `SysIsSet` is assumed in
`CoreIF`, UIP implies any two fillers of the same square are equal *as paths in Sys*.
That is fine, but Phase II must still ensure it does **not** become derivable that
the distinct Proc₅ generators `sq diag …` and `sq bridge …` are equal under `≈₅`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.SquareFillers where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Equality using (_≡_)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT

-- Phase II “square filler generators” on Sys (compatibility view).
--
-- The two tagged fillers (diag/bridge) are used by the Phase I presentation.
-- They are typically derived from a single interchange path, even though their
-- types coincide.
--
-- IMPORTANT consistency note (Required tweak 1, guardrail context):
-- Since SysIsSet holds (in CoreIF), these two paths are equal as elements of
-- an identity type in Sys (UIP).  That is *fine*.  What must remain unprovable
-- is that the corresponding *generators* `sq diag ...` and `sq bridge ...` in
-- Proc₅ become identified by ≈₅.  Batch 8 instantiation must preserve the
-- Batch 5 discipline that ≈₅ does not collapse Fill.
--
-- The canonical meaning of the tags is fixed elsewhere: see
-- TwoTimes.Integration.CanonicalFillers (diag ↦ id, bridge ↦ flip on Diff).
record SquareFillersIF {ℓ ℓT : Level}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  (Rt : RT.RecordTimeIF {ℓ = ℓ} {ℓT = ℓT} C A2 Ad)
  : Set (lsuc (ℓ ⊔ ℓT))
  where

  open Core.CoreIF C public using (diag; swap; swap²; swap-diag; SysIsSet; SKIsSet)
  open TA.TwoArrowsIF A2 public using (T)
  open RT.RecordTimeIF Rt public using (actSys)
  open Diag.DiagonalizationIF Ad public using (R̂)

  field
    -- Two tagged fillers on Sys (same type, different generator names).
    sqDiag :
      ∀ (t : T) (u : Nat) (s : Core.CoreIF.Sys C) →
      R̂ u (actSys t s) ≡ actSys t (R̂ u s)

    sqBridge :
      ∀ (t : T) (u : Nat) (s : Core.CoreIF.Sys C) →
      R̂ u (actSys t s) ≡ actSys t (R̂ u s)

open SquareFillersIF public
```
