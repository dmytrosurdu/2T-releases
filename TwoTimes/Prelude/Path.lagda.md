```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Prelude.Path where
```

# Minimal path algebra (shared)

Common non-cubical path helpers used across Phase I modules.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_; refl)
```

---

## Basic path operations

```agda
sym : ∀ {ℓ} {A : Set ℓ} {x y : A} → x ≡ y → y ≡ x
sym refl = refl

trans : ∀ {ℓ} {A : Set ℓ} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans refl q = q

infixl 20 _∙_
_∙_ : ∀ {ℓ} {A : Set ℓ} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
_∙_ = trans

cong : ∀ {ℓ₁ ℓ₂} {A : Set ℓ₁} {B : Set ℓ₂} (f : A → B) {x y : A} →
       x ≡ y → f x ≡ f y
cong f refl = refl

subst : ∀ {ℓ₁ ℓ₂} {A : Set ℓ₁} (P : A → Set ℓ₂) {x y : A} →
        x ≡ y → P x → P y
subst P refl px = px
```
