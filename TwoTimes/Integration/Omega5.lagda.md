# TwoTimes/Integration/Omega5.lagda.md

This module defines the **parity/obstruction map** for the Batch 5 presented groupoid
`Proc₅` (from `RecordProc5`):

* `ω₅ : Proc₅ r s → Bool`
* `ω₅-resp : p ≈₅ q → ω₅ p ≡ ω₅ q`
* `ω₅(sqLoop t u r) ≡ true` (computes by unfolding)

It treats `Fill` as operational tags:

* `sq diag …` contributes `false`
* `sq bridge …` contributes `true`

All other generators (`time`, `rg`) contribute `false`, and composition is `xor`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Omega5 where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import Data.Empty using (⊥)

open import TwoTimes.Prelude.Path using (sym; trans; cong)
open import TwoTimes.Z2.XorLemmas using (not; xor; xor-assoc; xor-idl; xor-idr; xor-self; xor-comm)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5

cong₂
  : ∀ {ℓA ℓB ℓC : Level}
    {A : Set ℓA} {B : Set ℓB} {C : Set ℓC}
    (f : A → B → C) {x x' : A} {y y' : B}
  → x ≡ x' → y ≡ y' → f x y ≡ f x' y'
cong₂ f refl refl = refl

infix 3 ¬_
¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

true≢false : true ≡ false → ⊥
true≢false ()

-- --------------------------------------------------------------------------
-- ω₅ on Proc₅ + respect for ≈₅
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open Pres.Group Time renaming (Carrier to T; inv to invT)

  open RP5.Inst Time I public
    using ( R
          ; Proc₅; id; time; rg; sq; _⨟_; inv; castR
          ; _≈₅_
          ; sqLoop; toCorner
          )

  ω₅ : ∀ {r s : R} → Proc₅ r s → Bool
  ω₅ (id _)          = false
  ω₅ (time _)        = false
  ω₅ (rg _)          = false
  ω₅ (sq IF.diag _ _)   = false
  ω₅ (sq IF.bridge _ _) = true
  ω₅ (p ⨟ q)         = xor (ω₅ p) (ω₅ q)
  ω₅ (inv p)         = ω₅ p
  ω₅ (castR _ p)     = ω₅ p

  -- Triviality predicate (useful for Nontrivial5):
  Trivialω₅ : Set (ℓT ⊔ ℓR)
  Trivialω₅ = ∀ {r s : R} (p : Proc₅ r s) → ω₅ p ≡ false

  ω₅-resp : ∀ {r s : R} {p q : Proc₅ r s} → p ≈₅ q → ω₅ p ≡ ω₅ q
  ω₅-resp RP5.≈-refl = refl
  ω₅-resp (RP5.≈-sym h) = sym (ω₅-resp h)
  ω₅-resp (RP5.≈-trans h₁ h₂) = trans (ω₅-resp h₁) (ω₅-resp h₂)

  ω₅-resp (RP5.≈-cong-⨟ hp hq) =
    cong₂ xor (ω₅-resp hp) (ω₅-resp hq)

  ω₅-resp (RP5.≈-cong-inv h) = ω₅-resp h
  ω₅-resp (RP5.≈-cong-castR _ h) = ω₅-resp h

  ω₅-resp (RP5.≈-assoc p q h) =
    xor-assoc (ω₅ p) (ω₅ q) (ω₅ h)

  ω₅-resp (RP5.≈-idl p) = xor-idl (ω₅ p)
  ω₅-resp (RP5.≈-idr p) = xor-idr (ω₅ p)

  ω₅-resp (RP5.≈-invL p) =
    xor-self (ω₅ p)

  ω₅-resp (RP5.≈-invR p) =
    xor-self (ω₅ p)

  ω₅-resp (RP5.≈-inv-inv p) = refl
  ω₅-resp RP5.≈-inv-id      = refl

  ω₅-resp (RP5.≈-inv-comp p q) =
    trans refl (xor-comm (ω₅ p) (ω₅ q))

  ω₅-resp (RP5.≈-castR-refl p) = refl

  -- Time laws: all map to false by computation.
  ω₅-resp (RP5.≈-time-id r) = refl
  ω₅-resp (RP5.≈-time-comp r t₁ t₂) = refl
  ω₅-resp (RP5.≈-time-inv r t) = refl

  -- RG laws: all map to false by computation.
  ω₅-resp (RP5.≈-rg-zero r) = refl
  ω₅-resp (RP5.≈-rg-comp r u₁ u₂) = refl

  ω₅-resp (RP5.≈-sq-path f t u r) = refl

  -- Key computed fact: sqLoop has odd parity (by unfolding).
  ω₅-sqLoop : ∀ (t : T) (u : Nat) (r : R) → ω₅ (sqLoop t u r) ≡ true
  ω₅-sqLoop t u r = refl

  ω₅-toCorner-diag :
    ∀ (t : T) (u : Nat) (r : R) →
    ω₅ (toCorner IF.diag t u r) ≡ false
  ω₅-toCorner-diag t u r = refl

  ω₅-toCorner-bridge :
    ∀ (t : T) (u : Nat) (r : R) →
    ω₅ (toCorner IF.bridge t u r) ≡ true
  ω₅-toCorner-bridge t u r = refl

  record FunctorToBZ₂ : Set (lsuc (ℓT ⊔ ℓR)) where
    field
      onHom  : ∀ {r s : R} → Proc₅ r s → Bool
      resp≈  : ∀ {r s} {p q : Proc₅ r s} → p ≈₅ q → onHom p ≡ onHom q
      onId   : ∀ (r : R) → onHom (id r) ≡ false
      onComp : ∀ {r s t} (p : Proc₅ r s) (q : Proc₅ s t) →
               onHom (p ⨟ q) ≡ xor (onHom p) (onHom q)
      onInv  : ∀ {r s} (p : Proc₅ r s) → onHom (inv p) ≡ onHom p

  ω₅Functor : FunctorToBZ₂
  ω₅Functor .FunctorToBZ₂.onHom = ω₅
  ω₅Functor .FunctorToBZ₂.resp≈ = ω₅-resp
  ω₅Functor .FunctorToBZ₂.onId r = refl
  ω₅Functor .FunctorToBZ₂.onComp p q = refl
  ω₅Functor .FunctorToBZ₂.onInv p = refl

  -- ------------------------------------------------------------------------
  -- Collapsed presentation: add a relation identifying the two square tags.
  -- ------------------------------------------------------------------------

  data _≈₅ᶜ_ : ∀ {r s : R} → Proc₅ r s → Proc₅ r s → Set (ℓT ⊔ ℓR) where
    base     : ∀ {r s} {p q : Proc₅ r s} → p ≈₅ q → p ≈₅ᶜ q
    collapse : ∀ (t : T) (u : Nat) (r : R) →
               sq {r = r} IF.diag t u ≈₅ᶜ sq {r = r} IF.bridge t u

  record FunctorToBZ₂ᶜ : Set (lsuc (ℓT ⊔ ℓR)) where
    field
      onHom  : ∀ {r s : R} → Proc₅ r s → Bool
      resp≈  : ∀ {r s} {p q : Proc₅ r s} → p ≈₅ᶜ q → onHom p ≡ onHom q
      onId   : ∀ (r : R) → onHom (id r) ≡ false
      onComp : ∀ {r s t} (p : Proc₅ r s) (q : Proc₅ s t) →
               onHom (p ⨟ q) ≡ xor (onHom p) (onHom q)
      onInv  : ∀ {r s} (p : Proc₅ r s) → onHom (inv p) ≡ onHom p

  trivialFunctorᶜ : FunctorToBZ₂ᶜ
  trivialFunctorᶜ .FunctorToBZ₂ᶜ.onHom _ = false
  trivialFunctorᶜ .FunctorToBZ₂ᶜ.resp≈ _ = refl
  trivialFunctorᶜ .FunctorToBZ₂ᶜ.onId _ = refl
  trivialFunctorᶜ .FunctorToBZ₂ᶜ.onComp _ _ = refl
  trivialFunctorᶜ .FunctorToBZ₂ᶜ.onInv _ = refl

  -- ω₅ does not descend to the collapsed relation: the collapse forces
  -- ω₅(sq diag) ≡ ω₅(sq bridge), hence false ≡ true.
  ω₅-not-resp-collapsed :
    ∀ (t : T) (u : Nat) (r : R) →
    ¬ (∀ {r s : R} {p q : Proc₅ r s} → p ≈₅ᶜ q → ω₅ p ≡ ω₅ q)
  ω₅-not-resp-collapsed t u r resp =
    true≢false (trans (sym (resp (collapse t u r))) refl)

open Inst public
```
