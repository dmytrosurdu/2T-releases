# TwoTimes/HIT/PushoutIndIF.lagda.md

This module provides a **parameterized interface** for pushouts with a **dependent eliminator**.
It extends the existing non-dependent `PushoutIF` interface, while staying fully `--safe`.

The key additional pieces are:

* a dependent eliminator `ind`,
* propositional computation rules `βind-inl`, `βind-inr`, and a **whiskered** `βind-glue`,
* the standard helper `PathP` and `apd` (dependent action on paths).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.HIT.PushoutIndIF where

open import Agda.Primitive using (Level; lsuc; _⊔_; Setω)
open import Agda.Builtin.Equality using (_≡_; refl)
open import TwoTimes.Prelude.Path public using (sym; trans; cong; subst; _∙_)

import TwoTimes.HIT.PushoutIF as PO

------------------------------------------------------------------------
-- Basic path algebra and dependent transport
------------------------------------------------------------------------

-- Dependent path (PathP) used throughout the project:
-- PathP P p u v  :=  transport(P, p, u) = v
PathP : ∀ {ℓ₁ ℓ₂} {A : Set ℓ₁} (P : A → Set ℓ₂) {x y : A} →
        x ≡ y → P x → P y → Set ℓ₂
PathP P p u v = subst P p u ≡ v

-- Dependent action on paths (“apd”):
-- Given f : ∀ x → P x and p : x ≡ y, produce a dependent path from f x to f y.
apd : ∀ {ℓ₁ ℓ₂} {A : Set ℓ₁} {P : A → Set ℓ₂}
      (f : ∀ x → P x) {x y : A} (p : x ≡ y) →
      PathP P p (f x) (f y)
apd f refl = refl

------------------------------------------------------------------------
-- Pushout with dependent elimination (interface-only; still --safe)
------------------------------------------------------------------------

-- We quantify over ℓP (the universe of the motive) for robustness.
-- This pushes the interface to Setω (like other “generic” interfaces).
record PushoutIndIF (ℓ : Level) : Setω where
  field
    base : PO.PushoutIF ℓ

  open PO.PushoutIF base public

  field
    -- Dependent eliminator
    ind :
      ∀ {ℓP : Level}
        {A B C : Set ℓ} {f : A → B} {g : A → C} →
      (P  : Pushout f g → Set ℓP) →
      (l  : ∀ b → P (inl b)) →
      (r  : ∀ c → P (inr c)) →
      (gl : ∀ a → PathP P (glue a) (l (f a)) (r (g a))) →
      ∀ x → P x

    -- β-rules at points (propositional)
    βind-inl :
      ∀ {ℓP : Level}
        {A B C : Set ℓ} {f : A → B} {g : A → C} →
      (P  : Pushout f g → Set ℓP) →
      (l  : ∀ b → P (inl b)) →
      (r  : ∀ c → P (inr c)) →
      (gl : ∀ a → PathP P (glue a) (l (f a)) (r (g a))) →
      ∀ b → ind P l r gl (inl b) ≡ l b

    βind-inr :
      ∀ {ℓP : Level}
        {A B C : Set ℓ} {f : A → B} {g : A → C} →
      (P  : Pushout f g → Set ℓP) →
      (l  : ∀ b → P (inl b)) →
      (r  : ∀ c → P (inr c)) →
      (gl : ∀ a → PathP P (glue a) (l (f a)) (r (g a))) →
      ∀ c → ind P l r gl (inr c) ≡ r c

    -- β-glue (whiskered, type-correct in intensional Agda)
    --
    -- This equates the *transported* apd of ind along glue with the supplied gl.
    --
    -- Concretely for each a:
    --   subst P (glue a) (l (f a))  ==  r (g a)
    --
    -- obtained by:
    --   subst P (glue a) (l (f a))
    --     -- rewrite l(f a) to ind(inl(f a)) via sym βind-inl, under subst
    --   → subst P (glue a) (ind ... (inl (f a)))
    --     -- apd(ind) along glue
    --   → ind ... (inr (g a))
    --     -- rewrite to r(g a) via βind-inr
    --   → r (g a)
    --
    βind-glue :
      ∀ {ℓP : Level}
        {A B C : Set ℓ} {f : A → B} {g : A → C} →
      (P  : Pushout f g → Set ℓP) →
      (l  : ∀ b → P (inl b)) →
      (r  : ∀ c → P (inr c)) →
      (gl : ∀ a → PathP P (glue a) (l (f a)) (r (g a))) →
      ∀ a →
        ( cong (subst P (glue a)) (sym (βind-inl P l r gl (f a)))
          ∙ apd (ind P l r gl) (glue a)
          ∙ βind-inr P l r gl (g a)
        )
        ≡ gl a
```
