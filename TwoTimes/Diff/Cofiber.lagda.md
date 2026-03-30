```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Diff.Cofiber where
```

# Cofiber via parameterized Pushout primitives (Phase I)

This module defines the **cofiber** of a map `f : A → B` as a pushout
[
\mathrm{Cofiber}(f) := \mathrm{Pushout}(f,; ! : A \to \top).
]
We expose constructors and a recursor, plus a **functoriality map** between cofibers.

> **Team notes / goals**
>
> * This module is intentionally *library-like*: it contains only basic definitions and
>   some simple derived equalities.
> * Later obstruction work will use `Cofiber diag` as the “difference object.”
> * If dependent elimination or more HIT structure is needed later, it can be added
>   in a separate module; Phase I can proceed with the non-dependent recursor.

---

## Imports

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import TwoTimes.Prelude.Path
-- We avoid Agda.Builtin.Unit (⊤ : Set₀) to stay universe-polymorphic
```

---

## Basic path algebra (non-cubical, safe)

```agda
-- Path helpers are provided by TwoTimes.Prelude.Path.

-- Level-polymorphic unit type
record One (ℓ : Level) : Set ℓ where
  constructor unit
```

---

## Cofiber core module (parameterized over Pushout primitives)

```agda
module CofCore
  {ℓ : Level}
  (Pushout : ∀ {A B C : Set ℓ} → (f : A → B) → (g : A → C) → Set ℓ)
  (inl     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → B → Pushout f g)
  (inr     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → C → Pushout f g)
  (glue    : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → (a : A) →
             inl {A = A} {B = B} {C = C} {f = f} {g = g} (f a) ≡
             inr {A = A} {B = B} {C = C} {f = f} {g = g} (g a))
  (rec     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → Pushout f g → P)
  (β-inl   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (b : B) →
             rec l r h (inl b) ≡ l b)
  (β-inr   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (c : C) →
             rec l r h (inr c) ≡ r c)
  where

  -- Constant map to a level-polymorphic unit
  ! : ∀ {A : Set ℓ} → A → One ℓ
  ! _ = unit

  Cofiber : ∀ {A B : Set ℓ} → (f : A → B) → Set ℓ
  Cofiber {A} {B} f = Pushout {A = A} {B = B} {C = One ℓ} f (! {A = A})

  -- Specialized constructors/recursor for the cofiber leg g = !
  inl! : ∀ {A B : Set ℓ} {f : A → B} → B → Cofiber {A = A} f
  inl! {A = A} {B = B} {f = f} = inl {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}

  inr! : ∀ {A B : Set ℓ} {f : A → B} → One ℓ → Cofiber {A = A} f
  inr! {A = A} {B = B} {f = f} = inr {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}

  glue! : ∀ {A B : Set ℓ} {f : A → B} → (a : A) → inl! {A = A} {f = f} (f a) ≡ inr! {A = A} {f = f} unit
  glue! {A = A} {B = B} {f = f} a = glue {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} a

  rec! : ∀ {A B : Set ℓ} {f : A → B} {P : Set ℓ} →
         (l : B → P) → (pt : P) → (h : ∀ a → l (f a) ≡ pt) → Cofiber {A = A} f → P
  rec! {A = A} {B = B} {f = f} l pt h =
    rec {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} l (λ (_ : One ℓ) → pt) h

  -- Inclusions
  cf-in : ∀ {A B : Set ℓ} {f : A → B} → B → Cofiber {A = A} f
  cf-in {A = A} {f = f} = inl! {A = A} {f = f}

  cf-base : ∀ {A B : Set ℓ} {f : A → B} → Cofiber {A = A} f
  cf-base {A = A} {f = f} = inr! {A = A} {f = f} unit

  -- Glue identifies f(a) with the basepoint
  cf-glue : ∀ {A B : Set ℓ} {f : A → B} → (a : A) → cf-in {A = A} {f = f} (f a) ≡ cf-base {A = A} {f = f}
  cf-glue {A = A} {f = f} a = glue! {A = A} {f = f} a

  -- Recursor
  Cofiber-rec
    : ∀ {A B : Set ℓ} (f : A → B) {P : Set ℓ} →
      (b : B → P) →
      (pt : P) →
      (h : ∀ a → b (f a) ≡ pt) →
      Cofiber f → P
  Cofiber-rec {A = A} {B = B} f b pt h =
    rec {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} b (λ _ → pt) h

  -- rec! β-lemmas specialized to the cofiber helpers
  rec!-β-in
    : ∀ {A B : Set ℓ} {f : A → B} {P : Set ℓ}
      (l : B → P) (pt : P) (h : ∀ a → l (f a) ≡ pt) (b : B) →
      rec! {A = A} {B = B} {f = f} l pt h (inl! {A = A} {B = B} {f = f} b) ≡ l b
  rec!-β-in {A = A} {B = B} {f = f} l pt h b =
    β-inl {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} l (λ _ → pt) h b

  rec!-β-base
    : ∀ {A B : Set ℓ} {f : A → B} {P : Set ℓ}
      (l : B → P) (pt : P) (h : ∀ a → l (f a) ≡ pt) →
      rec! {A = A} {B = B} {f = f} l pt h (inr! {A = A} {B = B} {f = f} unit) ≡ pt
  rec!-β-base {A = A} {B = B} {f = f} l pt h =
    β-inr {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} l (λ _ → pt) h unit

  -- β-rules on constructors
  β-cf-in
    : ∀ {A B : Set ℓ} (f : A → B) {P : Set ℓ} →
      (b : B → P) (pt : P) (h : ∀ a → b (f a) ≡ pt) (x : B) →
      Cofiber-rec f b pt h (cf-in {f = f} x) ≡ b x
  β-cf-in {A = A} {B = B} f b pt h x =
    β-inl {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} b (λ _ → pt) h x

  β-cf-base
    : ∀ {A B : Set ℓ} (f : A → B) {P : Set ℓ} →
      (b : B → P) (pt : P) (h : ∀ a → b (f a) ≡ pt) →
      Cofiber-rec f b pt h (cf-base {f = f}) ≡ pt
  β-cf-base {A = A} {B = B} f b pt h =
    β-inr {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} b (λ _ → pt) h unit
  

  -- Cofiber map induced by a commuting square
  Cofiber-map
    : ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      Cofiber f → Cofiber f'

  

  Cofiber-map'
    : ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      Cofiber f → Cofiber f'
  Cofiber-map' {A = A} {B = B} {A' = A'} {B' = B'} f f' α β comm =
    rec! {A = A} {B = B} {f = f}
         (λ b → cf-in {A = A'} {B = B'} {f = f'} (β b))
         (cf-base {A = A'} {B = B'} {f = f'})
         (λ a → cong (λ x → cf-in {A = A'} {B = B'} {f = f'} x) (comm a)
                 ∙ cf-glue {A = A'} {B = B'} {f = f'} (α a))

  Cofiber-map {A = A} {B = B} {A' = A'} {B' = B'} f f' α β comm = Cofiber-map' f f' α β comm

-- β on cf-in
  Cofiber-map-β-in
    : ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      ∀ b →
      Cofiber-map f f' α β comm (cf-in {f = f} b) ≡ cf-in {f = f'} (β b)
  Cofiber-map-β-in {A = A} {B = B} {A' = A'} {B' = B'} f f' α β comm b =
    rec!-β-in
      (λ b' → cf-in {A = A'} {B = B'} {f = f'} (β b'))
      (cf-base {A = A'} {B = B'} {f = f'})
      (λ a → cong (λ x → cf-in {A = A'} {B = B'} {f = f'} x) (comm a)
              ∙ cf-glue {A = A'} {B = B'} {f = f'} (α a))
      b

-- β on basepoint
  Cofiber-map-β-base
    : ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      Cofiber-map f f' α β comm (cf-base {f = f}) ≡ cf-base {f = f'}
  Cofiber-map-β-base {A = A} {B = B} {A' = A'} {B' = B'} f f' α β comm =
    rec!-β-base
      (λ b → cf-in {A = A'} {B = B'} {f = f'} (β b))
      (cf-base {A = A'} {B = B'} {f = f'})
      (λ a → cong (λ x → cf-in {A = A'} {B = B'} {f = f'} x) (comm a)
              ∙ cf-glue {A = A'} {B = B'} {f = f'} (α a))
```

---

## Notes for later: `Cofiber diag` as the “difference object”

Given an SK structure with `diag : Sys → SK`, the Phase I difference object is:

```agda
-- Diff u := Cofiber diag   (u fixed in Phase I; u only used later for actions)
```

No additional structure is needed at this layer; actions/loop maps will be defined
in `Diff/LoopAction.agda` by composing `Cofiber-map` along the syntactic square loops.
