# TwoTimes/Integration/SKSwapIF.lagda.md

Batch 7 (D7.4): a minimal abstract interface capturing the **SK branch-swap**
involution on the doubled system, with the property that it fixes diagonal
states/images.

This is a purely structural assumption; no hardcoding of `SK = Sys × Sys` is done.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.SKSwapIF where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import TwoTimes.Prelude.IsSet using (isSet)

record SKSwapIF (ℓ : Level) : Set (lsuc ℓ) where
  field
    Sys : Set ℓ
    SK  : Set ℓ

    SysIsSet : isSet Sys
    SKIsSet  : isSet SK

    diag : Sys → SK

    swap     : SK → SK
    swap²    : ∀ x → swap (swap x) ≡ x
    swap-diag : ∀ s → swap (diag s) ≡ diag s
```
