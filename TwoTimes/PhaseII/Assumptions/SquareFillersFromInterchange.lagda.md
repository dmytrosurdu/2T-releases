# TwoTimes/PhaseII/Assumptions/SquareFillersFromInterchange.lagda.md

Phase II: derive the legacy SquareFillersIF from a single interchange witness.

This is a compatibility layer for Phase I instantiation; it is not a new axiom.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.SquareFillersFromInterchange where

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.Interchange as Int
import TwoTimes.PhaseII.Assumptions.SquareFillers as SF
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT

squareFillersFromInterchange :
  ∀ {ℓ ℓT}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  (Ad : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C A2)
  (Rt : RT.RecordTimeIF {ℓ = ℓ} {ℓT = ℓT} C A2 Ad) →
  Int.InterchangeIF C A2 Ad Rt →
  SF.SquareFillersIF C A2 Ad Rt
squareFillersFromInterchange C A2 Ad Rt I =
  record
    { sqDiag   = Int.InterchangeIF.interchange I
    ; sqBridge = Int.InterchangeIF.interchange I
    }
```
