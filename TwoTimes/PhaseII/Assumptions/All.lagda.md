```agda

{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.All where

open import Agda.Primitive using (Level; Setω)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.Interchange as Int
import TwoTimes.PhaseII.Assumptions.RecordReflection as RR
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT
import TwoTimes.PhaseII.Assumptions.SquareFillers as SF
import TwoTimes.PhaseII.Assumptions.InterchangeFromReflection as Int'
import TwoTimes.PhaseII.Assumptions.SquareFillersFromInterchange as SF'
import TwoTimes.PhaseII.Assumptions.NoMixedAnomaly as NMA
import TwoTimes.PhaseII.Assumptions.Detector as Det
import TwoTimes.PhaseII.Assumptions.OpaqueA1A3 as OA

-- Bundle of all Phase II assumptions needed to compile into the Phase I stack.
--
-- Note: Detector and OpaqueA1A3 are provided as separate “extensions” so
-- Batch 8 can include/exclude them without changing the mandatory core.
record AssumptionsIF {ℓ ℓT : Level} : Setω where
  field
    core : Core.CoreIF ℓ
    twoArrows : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} core
    diagonalization : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} core twoArrows
    recordReflection : RR.RecordReflectionIF {ℓ = ℓ} core

    -- A_mix is *explicitly* assumed as descent bisimplicial face laws, not derived.
    noMixedAnomaly : NMA.NoMixedAnomalyIF {ℓ = ℓ} core

open AssumptionsIF public

-- Derived record-time action on the RG sector.
recordTimeOf :
  ∀ {ℓ ℓT} →
  (A : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}) →
  RT.RecordTimeIF
    {ℓ = ℓ} {ℓT = ℓT}
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
recordTimeOf A =
  RT.recordTimeFromRG
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
    (AssumptionsIF.recordReflection A)

-- Derived interchange witness (record-level commutation).
interchangeOf :
  ∀ {ℓ ℓT} →
  (A : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}) →
  Int.InterchangeIF
    {ℓ = ℓ} {ℓT = ℓT}
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
    (recordTimeOf A)
interchangeOf A =
  Int'.interchangeFromReflection
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
    (AssumptionsIF.recordReflection A)

-- Derived compatibility layer for Phase I instantiation.
squareFillersOf :
  ∀ {ℓ ℓT} →
  (A : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}) →
  SF.SquareFillersIF
    {ℓ = ℓ} {ℓT = ℓT}
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
    (recordTimeOf A)
squareFillersOf A =
  SF'.squareFillersFromInterchange
    (AssumptionsIF.core A)
    (AssumptionsIF.twoArrows A)
    (AssumptionsIF.diagonalization A)
    (recordTimeOf A)
    (interchangeOf A)

-- Extension: include a DetectorIF (for Phase II nontriviality).
record AssumptionsIF+Detector {ℓ ℓT : Level} : Setω where
  field
    base : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}
    detector : Det.DetectorIF (AssumptionsIF.core base)

open AssumptionsIF+Detector public

-- Extension: include opaque A1/A3 storage (not used in Batch 8, but quantified).
record AssumptionsIF+OpaqueA1A3 {ℓ ℓT : Level} : Setω where
  field
    base : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}
    opaqueA1A3 : OA.OpaqueA1A3IF (AssumptionsIF.core base) (AssumptionsIF.twoArrows base)

open AssumptionsIF+OpaqueA1A3 public

-- Full bundle: include both detector and opaque A1/A3.
record AssumptionsFullIF {ℓ ℓT : Level} : Setω where
  field
    base : AssumptionsIF {ℓ = ℓ} {ℓT = ℓT}
    detector : Det.DetectorIF (AssumptionsIF.core base)
    opaqueA1A3 : OA.OpaqueA1A3IF (AssumptionsIF.core base) (AssumptionsIF.twoArrows base)

open AssumptionsFullIF public

-- Re-export the Core → Phase I SKSwapIF compiler (guardrail B: do not duplicate).
core→SKSwapIF = Core.core→SKSwapIF


```
