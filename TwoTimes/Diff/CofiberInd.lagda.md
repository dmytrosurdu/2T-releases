# TwoTimes/Diff/CofiberInd.lagda.md

This module derives **dependent induction on cofibers** from a pushout dependent
eliminator interface `PushoutIndIF`, and states the corrected, well-typed
**glue computation goal** for `Cofiber-map` in the whiskered form required
for Batch 7.

> Design note: We reuse the *same* level-polymorphic unit type `One` as in
> `TwoTimes.Diff.Cofiber` to keep the **Cofiber type definition compatible**.
> We deliberately define new `Cofiber-rec` / `Cofiber-map` here in terms of the
> dependent eliminator (so we can later prove glue behavior), while keeping the
> underlying `Cofiber f` type as the pushout `Pushout f !`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Diff.CofiberInd where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import TwoTimes.Prelude.Path using (sym; trans; cong; _∙_)

import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Diff.Cofiber as Cof

-- --------------------------------------------------------------------------
-- Utilities
-- --------------------------------------------------------------------------

infix 3 ¬_
data ⊥ : Set where
¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

-- `PathP` and `apd` as used in Batch 7
open PI using (PathP; apd)

-- --------------------------------------------------------------------------
-- Main construction: cofiber induction and induced maps
-- --------------------------------------------------------------------------

module Inst {ℓ : Level} (H : PI.PushoutIndIF ℓ) where

  open PI.PushoutIndIF H public
    using ( base
          ; Pushout; inl; inr; glue
          ; rec; β-inl; β-inr
          ; ind; βind-inl; βind-inr; βind-glue
          )

  -- Reuse the same One type as in Diff.Cofiber to keep Cofiber compatible.
  open Cof using (One; unit)

  -- Constant map to One
  ! : ∀ {A : Set ℓ} → A → One ℓ
  ! _ = unit

  -- Cofiber as pushout of f and !
  Cofiber : ∀ {A B : Set ℓ} → (f : A → B) → Set ℓ
  Cofiber {A} {B} f = Pushout {A = A} {B = B} {C = One ℓ} f (! {A = A})

  -- Constructors
  cf-in : ∀ {A B : Set ℓ} {f : A → B} → B → Cofiber f
  cf-in {A} {B} {f} b = inl {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} b

  cf-base : ∀ {A B : Set ℓ} {f : A → B} → Cofiber f
  cf-base {A} {B} {f} =
    inr {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} unit

  cf-glue : ∀ {A B : Set ℓ} {f : A → B} → (a : A) → cf-in (f a) ≡ cf-base
  cf-glue {A} {B} {f} a =
    glue {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}} a

  -- ------------------------------------------------------------------------
  -- Dependent induction on Cofiber (derived from pushout ind)
  -- ------------------------------------------------------------------------

  Cofiber-ind :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B)
      (P : Cofiber f → Set ℓP) →
      (inCase   : ∀ b → P (cf-in {f = f} b)) →
      (baseCase : P (cf-base {f = f})) →
      (glCase   : ∀ a → PathP P (cf-glue {f = f} a) (inCase (f a)) baseCase) →
      ∀ x → P x
  Cofiber-ind {A = A} {B = B} f P inCase baseCase glCase =
    ind {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}
        P
        inCase
        (λ _ → baseCase)
        glCase

  -- Convenient β-rules on points (propositional)
  Cofiber-ind-β-in :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B)
      (P : Cofiber f → Set ℓP)
      (inCase   : ∀ b → P (cf-in {f = f} b))
      (baseCase : P (cf-base {f = f}))
      (glCase   : ∀ a → PathP P (cf-glue {f = f} a) (inCase (f a)) baseCase)
      (b : B) →
      Cofiber-ind f P inCase baseCase glCase (cf-in {f = f} b) ≡ inCase b
  Cofiber-ind-β-in {A = A} {B = B} f P inCase baseCase glCase b =
    βind-inl {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}
      P inCase (λ _ → baseCase) glCase b

  Cofiber-ind-β-base :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B)
      (P : Cofiber f → Set ℓP)
      (inCase   : ∀ b → P (cf-in {f = f} b))
      (baseCase : P (cf-base {f = f}))
      (glCase   : ∀ a → PathP P (cf-glue {f = f} a) (inCase (f a)) baseCase) →
      Cofiber-ind f P inCase baseCase glCase (cf-base {f = f}) ≡ baseCase
  Cofiber-ind-β-base {A = A} {B = B} f P inCase baseCase glCase =
    βind-inr {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}
      P inCase (λ _ → baseCase) glCase unit

  -- ------------------------------------------------------------------------
  -- Nondependent recursor on Cofiber, derived from ind with constant motive
  -- ------------------------------------------------------------------------

  subst-const :
    ∀ {ℓA ℓP : Level} {A : Set ℓA} {P : Set ℓP} {x y : A}
      (p : x ≡ y) (u : P) →
      PI.subst (λ _ → P) p u ≡ u
  subst-const refl u = refl

  -- Path algebra helpers (kept local to avoid extra imports)
  assoc :
    ∀ {ℓA : Level} {A : Set ℓA} {x y z w : A}
      (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) →
      (p ∙ q) ∙ r ≡ p ∙ (q ∙ r)
  assoc refl q r = refl


  sym-∙-cancel :
    ∀ {ℓA : Level} {A : Set ℓA} {x y z : A}
      (p : x ≡ y) (q : y ≡ z) →
      sym p ∙ (p ∙ q) ≡ q
  sym-∙-cancel refl q = refl

  apd-const-cong :
    ∀ {ℓA ℓP : Level} {A : Set ℓA} {P : Set ℓP}
      (f : A → P) {x y : A} (p : x ≡ y) →
      sym (subst-const p (f x)) ∙ apd f p ≡ cong f p
  apd-const-cong f refl = refl

  subst-const-cong :
    ∀ {ℓA ℓP : Level} {A : Set ℓA} {P : Set ℓP} {x y : A}
      (p : x ≡ y) {u v : P} (q : u ≡ v) →
      sym (subst-const p u) ∙ cong (PI.subst (λ _ → P) p) q ≡ q ∙ sym (subst-const p v)
  subst-const-cong refl refl = refl

  Cofiber-rec :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B) {P : Set ℓP} →
      (b  : B → P) →
      (pt : P) →
      (h  : ∀ a → b (f a) ≡ pt) →
      Cofiber f → P
  Cofiber-rec {A = A} {B = B} f {P = P} b pt h =
    Cofiber-ind f (λ _ → P)
      b
      pt
      (λ a → subst-const (cf-glue {f = f} a) (b (f a)) ∙ h a)

  -- β on points for Cofiber-rec
  Cofiber-rec-β-in :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B) {P : Set ℓP}
      (b : B → P) (pt : P) (h : ∀ a → b (f a) ≡ pt) (x : B) →
      Cofiber-rec f b pt h (cf-in {f = f} x) ≡ b x
  Cofiber-rec-β-in {A = A} {B = B} f b pt h x =
    Cofiber-ind-β-in f (λ _ → _) b pt (λ a → subst-const (cf-glue {f = f} a) (b (f a)) ∙ h a) x

  Cofiber-rec-β-base :
    ∀ {ℓP : Level} {A B : Set ℓ} (f : A → B) {P : Set ℓP}
      (b : B → P) (pt : P) (h : ∀ a → b (f a) ≡ pt) →
      Cofiber-rec f b pt h (cf-base {f = f}) ≡ pt
  Cofiber-rec-β-base {A = A} {B = B} f b pt h =
    Cofiber-ind-β-base f (λ _ → _) b pt (λ a → subst-const (cf-glue {f = f} a) (b (f a)) ∙ h a)

  -- ------------------------------------------------------------------------
  -- Cofiber-map induced by a commuting square on the nose (as in earlier Diff)
  -- ------------------------------------------------------------------------

  Cofiber-map :
    ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      Cofiber f → Cofiber f'
  Cofiber-map f f' α β comm =
    Cofiber-rec f
      (λ b → cf-in {f = f'} (β b))
      (cf-base {f = f'})
      (λ a → cong (cf-in {f = f'}) (comm a) ∙ cf-glue {f = f'} (α a))

  -- Point β-laws for Cofiber-map (these match the lead’s corrected whiskering)
  Cofiber-map-β-in :
    ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      ∀ b →
      Cofiber-map f f' α β comm (cf-in {f = f} b) ≡ cf-in {f = f'} (β b)
  Cofiber-map-β-in f f' α β comm b =
    Cofiber-rec-β-in f
      (λ b₀ → cf-in {f = f'} (β b₀))
      (cf-base {f = f'})
      (λ a → cong (cf-in {f = f'}) (comm a) ∙ cf-glue {f = f'} (α a))
      b

  Cofiber-map-β-base :
    ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      Cofiber-map f f' α β comm (cf-base {f = f}) ≡ cf-base {f = f'}
  Cofiber-map-β-base f f' α β comm =
    Cofiber-rec-β-base f
      (λ b₀ → cf-in {f = f'} (β b₀))
      (cf-base {f = f'})
      (λ a → cong (cf-in {f = f'}) (comm a) ∙ cf-glue {f = f'} (α a))

  -- ------------------------------------------------------------------------
  -- Goal (Batch 7 linchpin): β-glue computation for Cofiber-map (whiskered)
  --
  -- Required by project lead: endpoints must match via β-in and β-base whiskering.
  --
  -- This is stated as a *goal type* here; the proof is expected to be derived
  -- using `βind-glue` (pushout dependent computation) and path algebra.
  -- ------------------------------------------------------------------------

  Cofiber-map-β-glue :
    ∀ {A B A' B' : Set ℓ}
      (f  : A  → B)
      (f' : A' → B')
      (α  : A  → A')
      (β  : B  → B')
      (comm : ∀ a → β (f a) ≡ f' (α a)) →
      (a : A) →
      ( sym (Cofiber-map-β-in f f' α β comm (f a))
        ∙ cong (Cofiber-map f f' α β comm) (cf-glue {f = f} a)
        ∙ Cofiber-map-β-base f f' α β comm
      )
      ≡
      ( cong (cf-in {f = f'}) (comm a)
        ∙ cf-glue {f = f'} (α a)
      )
  Cofiber-map-β-glue {A = A} {B = B} {A' = A'} {B' = B'} f f' α β comm a =
    let
      p : cf-in {f = f} (f a) ≡ cf-base {f = f}
      p = cf-glue {f = f} a

      M : Cofiber f → Cofiber f'
      M = Cofiber-map f f' α β comm

      βin : M (cf-in {f = f} (f a)) ≡ cf-in {f = f'} (β (f a))
      βin = Cofiber-map-β-in f f' α β comm (f a)

      βbase : M (cf-base {f = f}) ≡ cf-base {f = f'}
      βbase = Cofiber-map-β-base f f' α β comm

      S : PI.subst (λ _ → Cofiber f') p (cf-in {f = f'} (β (f a))) ≡ cf-in {f = f'} (β (f a))
      S = subst-const p (cf-in {f = f'} (β (f a)))

      h : cf-in {f = f'} (β (f a)) ≡ cf-base {f = f'}
      h = cong (cf-in {f = f'}) (comm a) ∙ cf-glue {f = f'} (α a)

      gl :
        ∀ a →
        PathP (λ _ → Cofiber f') (cf-glue {f = f} a)
          (cf-in {f = f'} (β (f a))) (cf-base {f = f'})
      gl a =
        subst-const (cf-glue {f = f} a) (cf-in {f = f'} (β (f a)))
        ∙ (cong (cf-in {f = f'}) (comm a) ∙ cf-glue {f = f'} (α a))

      term1 :
        PI.subst (λ _ → Cofiber f') p (cf-in {f = f'} (β (f a)))
        ≡ PI.subst (λ _ → Cofiber f') p (M (cf-in {f = f} (f a)))
      term1 = cong (PI.subst (λ _ → Cofiber f') p) (sym βin)

      βgl :
        ( term1
          ∙ apd M p
          ∙ βbase
        )
        ≡ gl a
      βgl =
        βind-glue {A = A} {B = B} {C = One ℓ} {f = f} {g = ! {A = A}}
          (λ _ → Cofiber f')
          (λ b → cf-in {f = f'} (β b))
          (λ _ → cf-base {f = f'})
          gl
          a
    in
      -- Rewrite cong via apd + subst-const, then apply βind-glue, then cancel.
      let
        step1 :
          sym βin ∙ cong M p ∙ βbase
          ≡
          sym βin ∙ (sym (subst-const p (M (cf-in {f = f} (f a)))) ∙ apd M p) ∙ βbase
        step1 =
          cong (λ q → sym βin ∙ q ∙ βbase) (sym (apd-const-cong M p))

        step2 :
          sym βin ∙ (sym (subst-const p (M (cf-in {f = f} (f a)))) ∙ apd M p) ∙ βbase
          ≡
          (sym βin ∙ sym (subst-const p (M (cf-in {f = f} (f a))))) ∙ apd M p ∙ βbase
        step2 =
          cong (λ q → q ∙ βbase)
            (sym (assoc (sym βin) (sym (subst-const p (M (cf-in {f = f} (f a))))) (apd M p)))

        step3 :
          (sym βin ∙ sym (subst-const p (M (cf-in {f = f} (f a))))) ∙ apd M p ∙ βbase
          ≡
          (sym S ∙ term1) ∙ apd M p ∙ βbase
        step3 =
          cong (λ q → q ∙ apd M p ∙ βbase)
            (sym (subst-const-cong p (sym βin)))

        step4 :
          (sym S ∙ term1) ∙ apd M p ∙ βbase
          ≡
          sym S ∙ (term1 ∙ apd M p ∙ βbase)
        step4 =
          trans
            (cong (λ q → q ∙ βbase) (assoc (sym S) term1 (apd M p)))
            (assoc (sym S) (term1 ∙ apd M p) βbase)

        step5 :
          sym S ∙ (term1 ∙ apd M p ∙ βbase) ≡ sym S ∙ gl a
        step5 =
          cong (λ q → sym S ∙ q) βgl

        step6 :
          sym S ∙ gl a ≡ h
        step6 =
          sym-∙-cancel S h
      in
        step1 ∙ step2 ∙ step3 ∙ step4 ∙ step5 ∙ step6

open Inst public
```
