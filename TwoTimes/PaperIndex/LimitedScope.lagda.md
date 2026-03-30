# TwoTimes/PaperIndex/LimitedScope.lagda.md

Paper-facing aliases for the Limited Scope theorem package.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PaperIndex.LimitedScope where

-- Conventions:
-- Proc₅: p ⨟ q means "do p then q".
-- GroupoidS: q ∘ p := p ⨟ q (right-to-left).
-- Qu includes Koszul twist (-1)^m (horizontal degree), matching Phase I/II boundary defs.
-- Z₂-cover constraint: cover morphisms satisfy c ≡ xor b (ω₅ p) (see TwoTimes.Integration.Z2Cover5.Inst.Hom~).

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.Interchange as Int
import TwoTimes.PhaseII.Assumptions.RecordReflection as RR
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT
import TwoTimes.PhaseII.Assumptions.SquareFillers as Sq
import TwoTimes.PhaseII.Assumptions.NoMixedAnomaly as NMA
import TwoTimes.PhaseII.Assumptions.Detector as Det

import TwoTimes.PhaseII.LimitedScopeTheorem as LST
import TwoTimes.Integration.Omega5OddnessOnAb as Ω5Ab
import TwoTimes.PhaseII.Mixing.NoRealSubgroup as NRS

module Paper where
  private
    module LimitedScope = LST
    module Omega5OddnessOnAb = Ω5Ab

  -- Tier A assumption interfaces
  open Core public using (CoreIF)
  open TA public using (TwoArrowsIF)
  open Diag public using (DiagonalizationIF)
  open RT public using (RecordTimeIF; recordTimeFromRG)
  open RR public using (RecordReflectionIF)
  -- Compatibility interfaces; derived in Assumptions.All.
  open Int public using (InterchangeIF)
  open Sq public using (SquareFillersIF)
  open NMA public using (NoMixedAnomalyIF)
  open Det public using (DetectorIF)

  -- Main packaged theorem module (limited scope result)
  -- Cohomological non-splitting (detector-free)
  open LST public using
    ( LimitedScopeResult
    ; limitedScopeFromη
    ; limitedScope
    ; cornerPathsObstructSplit
    )
  -- Semantic add-ons (detector-based)
  open LST public using
    ( detector⇒canonicalFillersDifferent
    ; detector⇒¬Split
    ; canonicalFillersOrbit
    )
  open LST public using () renaming (detector⇒DiffNonFixed' to detector⇒DiffNonFixed)
  -- detector⇒¬Split is a stronger corollary; cohomological non-splitting uses cornerPathsObstructSplit.

  -- ω₅ oddness on abelian groups
  open Ω5Ab.Inst public using (actωG-sqLoop)

  -- Mixing lemma: no real subgroup loophole
  open NRS.Inst public using (mixingContradictionCore; mixingKillsRealSubgroup)
```
