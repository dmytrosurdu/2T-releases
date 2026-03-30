# TwoTimes/PhaseII/Assumptions/Diagonalization.lagda.md

Phase II (Batch 8) **A_diag / diagonalization** assumption package.

This record isolates the “RG maps land in the diagonal” structure in a way that
can instantiate Phase I’s `TwoTimeRecordIF` on `R = Sys` without any analytic
content.

**Convention (pinned):** `u₂ + u₁` means “do `u₁` first, then `u₂`”, i.e.
`R̂-comp` is stated as `R̂ (u₂ + u₁) s ≡ R̂ u₂ (R̂ u₁ s)`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Assumptions.Diagonalization where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_)

open import TwoTimes.Prelude.NatLemmas using (_+_)
open import TwoTimes.Prelude.Path using (_∙_; cong; sym)

import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA

-- Phase II A_diag package (Diagonalization):
-- it must be *connected* to A₂'s RG arrow.  Therefore this record depends on
-- TwoArrowsIF and states diagonal-range factorization for the SAME actU.
record DiagonalizationIF {ℓ ℓT : Level}
  (C  : Core.CoreIF ℓ)
  (A2 : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C)
  : Set (lsuc (ℓ ⊔ ℓT))
  where

  open Core.CoreIF C public
  open TA.TwoArrowsIF A2 public using (actU; actU-zero)

  field
    -- Projection from SK to Sys at RG scale u.
    Π : Nat → SK → Sys

    -- RG-sector section at u★ = 1: Sys is the RG sector by construction.
    secΠ : Sys → SK
    secΠ-β : ∀ s → Π (suc zero) (secΠ s) ≡ s

    -- Strict diagonal range: actU factors through diag for positive RG time.
    actU-factor-suc : ∀ (u : Nat) (x : SK) → actU (suc u) x ≡ diag (Π (suc u) x)

    -- Induced RG evolution on Sys (records) as explicit structure.
    R̂ : Nat → Sys → Sys

    -- Definition: Π on diagonal states agrees with R̂.
    R̂-def : ∀ (u : Nat) (s : Sys) → Π u (diag s) ≡ R̂ u s

    -- Semigroup laws on R̂ (kept explicit; do NOT derive using hidden principles).
    R̂-zero : ∀ s → R̂ zero s ≡ s
    R̂-comp : ∀ s (u₁ u₂ : Nat) → R̂ (u₂ + u₁) s ≡ R̂ u₂ (R̂ u₁ s)

  -- Derived compatibility on diagonal states (not an extra axiom):
  actU-diag : ∀ (u : Nat) (s : Sys) → actU (suc u) (diag s) ≡ diag (R̂ (suc u) s)
  actU-diag u s =
    actU-factor-suc u (diag s)
    ∙ cong diag (R̂-def (suc u) s)

  actU-diag0 : ∀ s → actU zero (diag s) ≡ diag (R̂ zero s)
  actU-diag0 s =
    actU-zero (diag s)
    ∙ cong diag (sym (R̂-zero s))

open DiagonalizationIF public

```
