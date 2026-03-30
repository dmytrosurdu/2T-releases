```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.HIT.PushoutIF where
```

# Pushout interface (axiomatic HoTT style, but **parameterized**, so still `--safe`)

This module defines a record interface `PushoutIF` that packages:

* the pushout type former `Pushout f g`,
* constructors `inl`, `inr`, and the glue path `glue`,
* a non-dependent recursor `rec`,
* propositional computation rules (`β-inl`, `β-inr`),
* and (optionally) a dependent eliminator `elim` with propositional computation rules.

> **Team goal notes**
>
> * In Phase I we only need the **non-dependent** recursor to define induced maps
>   out of a pushout (functoriality) and to define `Cofiber`.
> * The dependent eliminator is included because it often becomes necessary for
>   higher arguments in cofiber/pasting developments; but if it causes trouble,
>   it can be split into a separate interface later.

---

## Minimal Prelude (builtins only)

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import TwoTimes.Prelude.Path
-- Core fields are inlined here to avoid import-time meta issues

-- Basic path algebra and transport (needed below in the interface)

transport : ∀ {ℓ : Level} {A : Set ℓ} (P : A → Set ℓ) {x y : A} →
       x ≡ y → P x → P y
transport P refl px = px
```

---

## Interface

```agda
record PushoutIF (ℓ : Level) : Set (lsuc ℓ) where
  field
    -- Core fields
    Pushout : ∀ {A B C : Set ℓ} → (f : A → B) → (g : A → C) → Set ℓ
    inl     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → B → Pushout f g
    inr     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → C → Pushout f g
    glue    : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → (a : A) →
              inl {A = A} {B = B} {C = C} {f = f} {g = g} (f a) ≡
              inr {A = A} {B = B} {C = C} {f = f} {g = g} (g a)
    rec     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
              (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → Pushout f g → P
    β-inl   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
              (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (b : B) →
              rec l r h (inl b) ≡ l b
    β-inr   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
              (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (c : C) →
              rec l r h (inr c) ≡ r c

    -- β-glue (optional) can be added in a separate extension module if needed.
```

---
