# TwoTimes/PhaseII/Assumptions/OpaqueA1A3.lagda.md

Phase II (Batch 8): **store A1 and A3 as explicit, opaque hypothesis packages**.

These axiom blocks contain analytic / Hilbert-space content in the project narrative.
In Phase II we do **not** formalize or use them; we merely ensure the final theorem
statements can quantify over them **explicitly** (no smuggling).

No postulates and no holes appear here: A1/A3 are just record fields.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.OpaqueA1A3 where

open import Agda.Primitive using (Level; lsuc; _⊔_)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA

-- Opaque storage for analytic axiom blocks.
--
-- We parameterize by Core + TwoArrows so later phases can refine these hypotheses
-- in a way that refers to Sys/SK and the two evolutions, while keeping Phase II
-- itself completely non-analytic.
record OpaqueA1A3IF {ℓ ℓT : Level}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  : Set (lsuc (ℓ ⊔ ℓT))
  where

  open Core.CoreIF C public
  open TA.TwoArrowsIF A2 public

  field
    -- A1: analytic/Hilbert-space content (opaque in Phase II).
    A1 : Set (ℓ ⊔ ℓT)

    -- A3: analytic/Hilbert-space content (opaque in Phase II).
    A3 : Set (ℓ ⊔ ℓT)

open OpaqueA1A3IF public
```
