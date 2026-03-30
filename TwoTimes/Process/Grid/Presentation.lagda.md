```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Process.Grid.Presentation where
```

# Presented 2D process language (Phase I)

This module provides a *syntactic* presentation of two independent process directions:

* **time steps** indexed by a group `Time`,
* **RG steps** indexed by `Nat` (discrete RG time),

together with a *chosen commutation square* generator between adjacent time/RG steps.

The intent is to use this as the “walking grid” presentation whose (bi)simplicial nerve
yields a bicomplex via the standard alternating-face construction in an additive target
(implemented in later modules).

> **Team goal notes**
>
> * This file deliberately avoids any semantic action on a state space.
> * It also avoids truncations; thus the 2-cells (equalities) here are *derivation trees*.
> * Thinness/proof-irrelevance of 2-cells is stated as a *goal type* (`Thin`) that later
>   developments may assume as a parameter if needed.
> * Coherence (compatibility with composition/units) is built in by making `≈` a congruence
>   under list concatenation, not by additional “cube axioms”.

---

## Imports and basic list operations

```agda
open import Agda.Primitive using (Level; lsuc; lzero; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Sigma using (Σ; _,_)
open import Agda.Builtin.Unit using (⊤; tt)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.List using (List; []; _∷_)

-- Minimal empty type
data ⊥ : Set where

infix 4 _≠_
_≠_ : ∀ {ℓ} {A : Set ℓ} → A → A → Set ℓ
x ≠ y = x ≡ y → ⊥

-- “Proposition” predicate (proof-irrelevance)
IsProp : ∀ {ℓ} → Set ℓ → Set ℓ
IsProp P = ∀ (p q : P) → p ≡ q

-- Nat addition (we avoid importing stdlib)
infixl 6 _+_
_+_ : Nat → Nat → Nat
zero  + n = n
suc m + n = suc (m + n)

-- List append
infixr 5 _++_
_++_ : ∀ {ℓ} {A : Set ℓ} → List A → List A → List A
[]       ++ ys = ys
(x ∷ xs) ++ ys = x ∷ (xs ++ ys)
```

---

## Time group interface (parameterized)

We keep `Time` abstract at this layer; later modules will instantiate it (e.g. as a
concrete group or as a group presented by generators/relations).

```agda
record Group (ℓ : Level) : Set (lsuc ℓ) where
  field
    Carrier : Set ℓ
    e       : Carrier
    _∙_     : Carrier → Carrier → Carrier
    inv     : Carrier → Carrier

    assoc   : ∀ x y z → (x ∙ y) ∙ z ≡ x ∙ (y ∙ z)
    idl     : ∀ x → e ∙ x ≡ x
    idr     : ∀ x → x ∙ e ≡ x
    linv    : ∀ x → (inv x ∙ x) ≡ e
    rinv    : ∀ x → (x ∙ inv x) ≡ e
```

---

## Generators and process words (1-cells)

A 1-cell is a *word* in generators: `τ t` (time) and `ρ u` (RG).
Composition is list concatenation `++`.

```agda
module _ {ℓT : Level} (Time : Group ℓT) where

  open Group Time renaming
    ( Carrier to TimeCarrier
    ; e       to eT
    ; _∙_     to _∙T_
    ; inv     to invT
    )

  data Gen : Set ℓT where
    τ : TimeCarrier → Gen         -- time generator
    ρ : Nat → Gen                 -- RG generator

  Proc : Set ℓT
  Proc = List Gen

  -- Identity 1-cell
  ε : Proc
  ε = []

  -- 1-cell composition
  infixr 5 _⨟_
  _⨟_ : Proc → Proc → Proc
  xs ⨟ ys = xs ++ ys
```

---

## Head-step rewriting rules (primitive 2-cells)

`_↝₀_` captures the *primitive* rewrite steps at the head of a word.
Closure under arbitrary contexts is handled by `≈` below via congruence rules.

```agda
  infix 3 _↝₀_
  data _↝₀_ : Proc → Proc → Set ℓT where

    -- Time group compression rules (head-local)
    T-id₀   : ∀ {xs} →
              (τ eT ∷ xs) ↝₀ xs

    T-comp₀ : ∀ {t₁ t₂ xs} →
              (τ t₁ ∷ τ t₂ ∷ xs) ↝₀ (τ (t₁ ∙T t₂) ∷ xs)

    T-invL₀ : ∀ {t xs} →
              (τ (invT t) ∷ τ t ∷ xs) ↝₀ xs

    T-invR₀ : ∀ {t xs} →
              (τ t ∷ τ (invT t) ∷ xs) ↝₀ xs

    -- RG monoid compression rules (head-local; RG is Nat under +)
    R-zero₀ : ∀ {xs} →
              (ρ zero ∷ xs) ↝₀ xs

    R-comp₀ : ∀ {u₁ u₂ xs} →
              (ρ u₁ ∷ ρ u₂ ∷ xs) ↝₀ (ρ (u₁ + u₂) ∷ xs)

    -- The key square: commute one time step past one RG step (head-local)
    square₀ : ∀ {t u xs} →
              (τ t ∷ ρ u ∷ xs) ↝₀ (ρ u ∷ τ t ∷ xs)
```

---

## Congruence/equivalence closure: the presented thin-2-cell candidate

`≈` is the smallest equivalence relation containing `_↝₀_` and closed under
whiskering (left/right concatenation). This models a *presented strict 2-category*
with one object and thin 2-cells **as a goal** (see `Thin` below).

> **Team suggestion**
>
> Later modules that truly require thinness should not attempt to prove it here
> (it’s typically hard without truncations). Instead:
>
> * either keep working with derivation-based 2-cells,
> * or parameterize the rest of the development by a proof `Thin : ∀ p q → IsProp (p ≈ q)`,
> * or introduce a truncation interface and set `≈ := ∥ derivations ∥` in a refinement layer.

```agda
  infix 2 _≈_
  data _≈_ : Proc → Proc → Set ℓT where
    -- Equivalence closure
    ≈-refl  : ∀ {p} → p ≈ p
    ≈-sym   : ∀ {p q} → p ≈ q → q ≈ p
    ≈-trans : ∀ {p q r} → p ≈ q → q ≈ r → p ≈ r

    -- Generate from primitive head steps
    ≈-step  : ∀ {p q} → p ↝₀ q → p ≈ q

    -- Congruence under concatenation (whiskering)
    ≈-congL : ∀ {p q r} → p ≈ q → (p ⨟ r) ≈ (q ⨟ r)
    ≈-congR : ∀ {p q r} → p ≈ q → (r ⨟ p) ≈ (r ⨟ q)

  -- Thinness goal type (proof-irrelevance of 2-cells)
  Thin : Set ℓT
  Thin = ∀ p q → IsProp (p ≈ q)
```

---

## Optional: derived “contextual” rewrite and normalization goals (declared as types)

The following are **useful targets** for later files (nerve, bicomplex, ω),
but we do not implement proofs here.

* `ContextStep`: one-step rewrite anywhere in a word (via congruence).
* `NormalForm`: a suggested normal form (e.g. all RG generators collected on the left).
* `normalize`: a normalization procedure (if desired), with soundness w.r.t. `≈`.

We only *declare* the types as guidance; implementers can decide the route.

```agda
  -- A contextual (anywhere) one-step rewrite can be defined using congruence:
  ContextStep : Proc → Proc → Set ℓT
  ContextStep p q = Σ Proc (λ l → Σ Proc (λ r → (l ⨟ p ⨟ r) ≈ (l ⨟ q ⨟ r)))

  -- Suggested normal form: collect all ρ’s on the left, τ’s on the right
  -- (not enforced here; just a target predicate)
  NormalForm : Proc → Set
  NormalForm w = ⊤
```

---

## Optional: semantic soundness interface (future hook)

Later, when we interpret process words on an ambient type `X` (states, records, etc.),
it is useful to package the semantic laws that make the presentation *sound*.

This file only provides the *interface type* (no instances, no proofs).

```agda
  record Endo {ℓX : Level} (X : Set ℓX) : Set (lsuc ℓX) where
    field f : X → X

  Endo≡ : ∀ {ℓX} {X : Set ℓX} → Endo X → Endo X → Set ℓX
  Endo≡ {X = X} F G = ∀ x → Endo.f F x ≡ Endo.f G x

  record Model {ℓX : Level} (X : Set ℓX) : Set (lsuc (ℓT ⊔ ℓX)) where
    field
      actT : TimeCarrier → Endo X
      actR : Nat → Endo X

      -- Laws matching the presentation generators
      actT-id   : Endo≡ (actT eT) (record { f = λ x → x })
      actT-comp : ∀ t₁ t₂ →
                  Endo≡ (record { f = λ x → Endo.f (actT t₁) (Endo.f (actT t₂) x) })
                        (actT (t₁ ∙T t₂))
      actT-invL : ∀ t →
                  Endo≡ (record { f = λ x → Endo.f (actT (invT t)) (Endo.f (actT t) x) })
                        (record { f = λ x → x })
      actT-invR : ∀ t →
                  Endo≡ (record { f = λ x → Endo.f (actT t) (Endo.f (actT (invT t)) x) })
                        (record { f = λ x → x })

      actR-zero : Endo≡ (actR zero) (record { f = λ x → x })
      actR-comp : ∀ u₁ u₂ →
                  Endo≡ (record { f = λ x → Endo.f (actR u₁) (Endo.f (actR u₂) x) })
                        (actR (u₁ + u₂))

      actSquare : ∀ t u →
                  Endo≡ (record { f = λ x → Endo.f (actT t) (Endo.f (actR u) x) })
                        (record { f = λ x → Endo.f (actR u) (Endo.f (actT t) x) })

  -- Interpretation of a word as an endomorphism (left-to-right execution)
  eval : ∀ {ℓX} {X : Set ℓX} → Model X → Proc → Endo X
  eval {X = X} M [] = record { f = λ x → x }
  eval {X = X} M (g ∷ gs) with g
  ... | τ t = record { f = λ x → Endo.f (eval M gs) (Endo.f (Model.actT M t) x) }
  ... | ρ u = record { f = λ x → Endo.f (eval M gs) (Endo.f (Model.actR M u) x) }

  -- Soundness target: if p ≈ q then eval M p ≡ eval M q (pointwise).
  -- Team should prove this by induction on the derivation `p ≈ q`,
  -- using the semantic laws in `Model`.
  Sound : ∀ {ℓX} {X : Set ℓX} (M : Model X) → Proc → Proc → Set ℓX
  Sound {X = X} M p q = Endo≡ (eval M p) (eval M q)
```
