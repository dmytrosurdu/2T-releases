```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.HIT.PushoutCoreIF where
```

# Pushout Core interface (Phase I)

This module defines the minimal core record interface `PushoutCoreIF` for pushouts.
It is used by `Cofiber` to avoid import-time meta-variable complexity associated
with the full interface.

---

## Minimal Prelude

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_)
```

---

## Interface

```agda
record PushoutCoreIF (ℓ : Level) : Set (lsuc ℓ) where
  field
    -- Pushout type former
    Pushout : ∀ {A B C : Set ℓ} → (f : A → B) → (g : A → C) → Set ℓ

    -- Point constructors
    inl     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} →
              B → Pushout f g

    inr     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} →
              C → Pushout f g

    -- Glue path constructor
    glue    : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} →
              (a : A) →
              inl {A = A} {B = B} {C = C} {f = f} {g = g} (f a) ≡
              inr {A = A} {B = B} {C = C} {f = f} {g = g} (g a)

    --------------------------------------------------------------------
    -- Non-dependent recursor (sufficient for Phase I)
    --------------------------------------------------------------------

    rec     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C}
              {P : Set ℓ} →
              (l : B → P) →
              (r : C → P) →
              (h : ∀ a → l (f a) ≡ r (g a)) →
              Pushout f g → P

    β-inl   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C}
              {P : Set ℓ} →
              (l : B → P) →
              (r : C → P) →
              (h : ∀ a → l (f a) ≡ r (g a)) →
              (b : B) →
              rec l r h (inl b) ≡ l b

    β-inr   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C}
              {P : Set ℓ} →
              (l : B → P) →
              (r : C → P) →
              (h : ∀ a → l (f a) ≡ r (g a)) →
              (c : C) →
              rec l r h (inr c) ≡ r c
```
