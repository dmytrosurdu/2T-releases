# TwoTimes/Integration/RecordProc5.lagda.md

This module defines the **Batch 5 presented record process theory** `Proc₅`
with generators:

* `time` (Lorentzian time transport),
* `rg`   (RG/diagonal record step),
* `sq`   (tagged square filler, `Fill = diag | bridge`),

and a **presentation equality** `≈₅` (groupoid laws + time laws + rg laws + congruence).

It also defines the **square-derived loop** `sqLoop`, constructed *without* using
Ω’s primitive `loop` generator.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.RecordProc5 where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)
open import Data.Empty using (⊥; ⊥-elim)

open import TwoTimes.Prelude.Path using (sym; trans; cong; subst)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Obstruction.Omega as Ω
import TwoTimes.Integration.TwoTimeRecordIF as IF

¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

-- --------------------------------------------------------------------------
-- Presented groupoid Proc₅
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open Pres.Group Time renaming
    ( Carrier to T
    ; e       to eT
    ; _∙_     to _∙T_
    ; inv     to invT
    ; assoc   to assocT
    ; idl     to idlT
    ; idr     to idrT
    ; linv    to linvT
    ; rinv    to rinvT
    )

  open IF using (Fill; diag; bridge)

  open IF.TwoTimeRecordIF I public
    using (RD; rec; rec-zero; rec-comp; sqPath; sqDiag; sqBridge)

  open Ω.RecordDynamics RD public using (R; act; act-id; act-comp; act-inv)

  infixr 5 _⨟_

  data Proc₅ : R → R → Set (ℓT ⊔ ℓR) where
    id    : ∀ r → Proc₅ r r
    time  : ∀ {r : R} → (t : T) → Proc₅ r (act t r)
    rg    : ∀ {r : R} → (u : Nat) → Proc₅ r (rec u r)

    -- Tagged square filler:
    --   rec u (act t r)  →  act t (rec u r)
    -- The tag meaning is fixed canonically by CanonicalFillers
    -- (diag ↦ id, bridge ↦ flip on Diff).
    sq    : ∀ {r : R} → (f : Fill) (t : T) (u : Nat) →
            Proc₅ (rec u (act t r)) (act t (rec u r))

    _⨟_   : ∀ {r s t} → Proc₅ r s → Proc₅ s t → Proc₅ r t
    inv   : ∀ {r s} → Proc₅ r s → Proc₅ s r

    -- Typed transport on the *codomain* (as in ΩInst)
    castR : ∀ {r s s'} → s ≡ s' → Proc₅ r s → Proc₅ r s'

  infix 2 _≈₅_

  data _≈₅_ : ∀ {r s : R} → Proc₅ r s → Proc₅ r s → Set (ℓT ⊔ ℓR) where
    -- Equivalence closure
    ≈-refl  : ∀ {r s} {p : Proc₅ r s} → p ≈₅ p
    ≈-sym   : ∀ {r s} {p q : Proc₅ r s} → p ≈₅ q → q ≈₅ p
    ≈-trans : ∀ {r s} {p q u : Proc₅ r s} → p ≈₅ q → q ≈₅ u → p ≈₅ u

    -- Congruence
    ≈-cong-⨟ :
      ∀ {r s t} {p p' : Proc₅ r s} {q q' : Proc₅ s t} →
      p ≈₅ p' → q ≈₅ q' → (p ⨟ q) ≈₅ (p' ⨟ q')
    ≈-cong-inv :
      ∀ {r s} {p q : Proc₅ r s} → p ≈₅ q → inv p ≈₅ inv q
    ≈-cong-castR :
      ∀ {r s s'} (e : s ≡ s') {p q : Proc₅ r s} →
      p ≈₅ q → castR e p ≈₅ castR e q

    -- Groupoid laws
    ≈-assoc :
      ∀ {r s t u} (p : Proc₅ r s) (q : Proc₅ s t) (h : Proc₅ t u) →
      (p ⨟ q) ⨟ h ≈₅ p ⨟ (q ⨟ h)

    ≈-idl : ∀ {r s} (p : Proc₅ r s) → id r ⨟ p ≈₅ p
    ≈-idr : ∀ {r s} (p : Proc₅ r s) → p ⨟ id s ≈₅ p

    ≈-invL : ∀ {r s} (p : Proc₅ r s) → inv p ⨟ p ≈₅ id s
    ≈-invR : ∀ {r s} (p : Proc₅ r s) → p ⨟ inv p ≈₅ id r

    ≈-inv-inv : ∀ {r s} (p : Proc₅ r s) → inv (inv p) ≈₅ p
    ≈-inv-id  : ∀ {r} → inv (id r) ≈₅ id r
    ≈-inv-comp :
      ∀ {r s t} (p : Proc₅ r s) (q : Proc₅ s t) →
      inv (p ⨟ q) ≈₅ (inv q ⨟ inv p)

    -- castR laws
    ≈-castR-refl : ∀ {r s} (p : Proc₅ r s) → castR refl p ≈₅ p

    -- Time action laws (expressed using castR)
    ≈-time-id :
      ∀ (r : R) →
      castR (act-id r) (time {r = r} eT) ≈₅ id r

    ≈-time-comp :
      ∀ (r : R) (t₁ t₂ : T) →
      castR (act-comp r t₁ t₂) (time {r = r} (t₂ ∙T t₁))
      ≈₅ (time {r = r} t₁ ⨟ time {r = act t₁ r} t₂)

    ≈-time-inv :
      ∀ (r : R) (t : T) →
      castR (act-inv r t)
        (time {r = r} t ⨟ time {r = act t r} (invT t))
      ≈₅ id r

    -- RG/record-step laws (Nat-monoid expressed using castR)
    ≈-rg-zero :
      ∀ (r : R) →
      castR (rec-zero r) (rg {r = r} zero) ≈₅ id r

    ≈-rg-comp :
      ∀ (r : R) (u₁ u₂ : Nat) →
      castR (rec-comp r u₁ u₂) (rg {r = r} (u₂ Pres.+ u₁))
      ≈₅ (rg {r = r} u₁ ⨟ rg {r = rec u₁ r} u₂)

    -- Square filler: connect the tagged generator to its semantic path via castR.
    ≈-sq-path :
      ∀ (f : Fill) (t : T) (u : Nat) (r : R) →
      castR (trans (sym (sqPath f t u r)) (sqPath f t u r))
        (sq {r = r} f t u) ≈₅ sq {r = r} f t u

  -- --------------------------------------------------------------------------
  -- Square-derived path into the corner, and the loop comparing diag vs bridge
  -- --------------------------------------------------------------------------

  -- A canonical path to the “upper-right corner” using a chosen filler tag f:
  --
  --   r --time t--> act t r --rg u--> rec u (act t r) --sq f t u--> act t (rec u r)
  --
  toCorner : (f : Fill) (t : T) (u : Nat) (r : R) → Proc₅ r (act t (rec u r))
  toCorner f t u r =
      time {r = r} t
    ⨟ rg   {r = act t r} u
    ⨟ sq   {r = r} f t u

  -- The “square loop” at r is the mismatch between the two fillers, conjugated back:
  --
  --   sqLoop t u r = toCorner diag t u r  ;  inv (toCorner bridge t u r)
  --
  sqLoop : (t : T) (u : Nat) (r : R) → Proc₅ r r
  sqLoop t u r =
    toCorner diag t u r ⨟ inv (toCorner bridge t u r)

open Inst public
```
