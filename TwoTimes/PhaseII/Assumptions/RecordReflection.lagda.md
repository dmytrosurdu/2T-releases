# TwoTimes/PhaseII/Assumptions/RecordReflection.lagda.md

Phase II: record reflection / diagonal cancellation.

This is the minimal descent principle used to cancel diagonal equalities back
to record equalities.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.RecordReflection where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Equality using (_≡_)

import TwoTimes.PhaseII.Assumptions.Core as Core

record RecordReflectionIF {ℓ : Level} (C : Core.CoreIF ℓ) : Set (lsuc ℓ) where
  open Core.CoreIF C public

  field
    diag-cancel : ∀ {s s' : Sys} → diag s ≡ diag s' → s ≡ s'

open RecordReflectionIF public
```
