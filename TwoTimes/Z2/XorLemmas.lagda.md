# TwoTimes/Z2/XorLemmas.lagda.md

Centralized Bool xor kit for Batch 6.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Z2.XorLemmas where

open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Z2.BoolGroup public
  using (not; xor; assoc-xor; idl-xor; idr-xor; linv-xor)

xor-assoc : ∀ (a b c : Bool) → xor (xor a b) c ≡ xor a (xor b c)
xor-assoc = assoc-xor

xor-comm : ∀ (a b : Bool) → xor a b ≡ xor b a
xor-comm false false = refl
xor-comm false true  = refl
xor-comm true  false = refl
xor-comm true  true  = refl

xor-idl : ∀ (b : Bool) → xor false b ≡ b
xor-idl = idl-xor

xor-idr : ∀ (b : Bool) → xor b false ≡ b
xor-idr = idr-xor

xor-self : ∀ (b : Bool) → xor b b ≡ false
xor-self = linv-xor
```
