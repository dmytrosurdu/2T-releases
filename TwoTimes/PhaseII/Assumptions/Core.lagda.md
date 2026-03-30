# TwoTimes/PhaseII/Assumptions/Core.lagda.md

Phase II (Batch 8) **core physics-facing** interface: the SK doubled space, the
diagonal embedding, and the branch swap involution.

Design guardrail: Phase II does **not** duplicate Phase I interfaces. Instead,
we provide constructors/compilers into the Phase I interfaces (e.g. `SKSwapIF`).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.Core where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.Equality using (_≡_)
open import TwoTimes.Prelude.IsSet using (isSet)

import TwoTimes.Integration.SKSwapIF as SK

-- --------------------------------------------------------------------------
-- CoreIF: the minimal “physics meaning” package for the SK layer
-- --------------------------------------------------------------------------

record CoreIF (ℓ : Level) : Set (lsuc ℓ) where
  field
    -- State space (records) and SK doubled space
    Sys : Set ℓ
    SK  : Set ℓ

    -- Set-level discipline (UIP for equality proofs)
    SysIsSet : isSet Sys
    SKIsSet  : isSet SK

    -- Diagonal embedding
    diag : Sys → SK

    -- SK branch swap (Z₂ generator) + laws
    swap      : SK → SK
    swap²     : ∀ x → swap (swap x) ≡ x
    swap-diag : ∀ s → swap (diag s) ≡ diag s

open CoreIF public

-- --------------------------------------------------------------------------
-- Phase II → Phase I compiler: CoreIF produces the Phase I SKSwapIF
-- --------------------------------------------------------------------------

core→SKSwapIF : ∀ {ℓ : Level} → CoreIF ℓ → SK.SKSwapIF ℓ
core→SKSwapIF C =
  record
    { Sys       = CoreIF.Sys C
    ; SK        = CoreIF.SK C
    ; SysIsSet  = CoreIF.SysIsSet C
    ; SKIsSet   = CoreIF.SKIsSet C
    ; diag      = CoreIF.diag C
    ; swap      = CoreIF.swap C
    ; swap²     = CoreIF.swap² C
    ; swap-diag = CoreIF.swap-diag C
    }
```
