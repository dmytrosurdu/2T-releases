```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Prelude.IsSet where

open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_)

isProp : ∀ {ℓ} → Set ℓ → Set ℓ
isProp A = ∀ (x y : A) → x ≡ y

isSet : ∀ {ℓ} → Set ℓ → Set ℓ
isSet A = ∀ (x y : A) (p q : x ≡ y) → p ≡ q

uip : ∀ {ℓ} {A : Set ℓ} → isSet A → ∀ {x y} (p q : x ≡ y) → p ≡ q
uip setA p q = setA _ _ p q
```
