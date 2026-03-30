# TwoTimes/PhaseII/LimitedScopeTheorem.lagda.md

Phase II (Batch 8): **single top-level theorem module** (limited-scope, non-analytic).

This module packages:

1. **Bicomplex identities** on the assumed A_mix descent object (via Phase II bicomplex compiler),
2. the **ω₅ / Z₂-cover / splitting ↔ coboundary** stack instantiated on `R = Sys`,
3. the **Diff flip** and the induced **ω-action on Diff**, including `actω-sqLoop = flip`,
4. the **detector ⇒ semantic nontriviality** implications on Diff and canonical fillers,
5. the **detector ⇒ ¬ SplitCover** corollary (stronger than needed for cohomological non-splitting).

Design note: bicomplex identities are produced from explicit generator-level
hypotheses (`Qt²Onη`, `Qu²Onη`, `AnticommOnη`) via `bicomplexFromη`. This keeps
the module meta-clean and avoids hidden assumptions.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.LimitedScopeTheorem where

open import Agda.Primitive using (Level; Setω; lzero; _⊔_)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import TwoTimes.Prelude.Path using (sym; trans; cong; _∙_)

import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FA
import TwoTimes.Z2.XorLemmas as XOR

import TwoTimes.PhaseII.Assumptions.All as Asm
import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.Detector as Det

import TwoTimes.Diff.CofiberInd as CofInd
import TwoTimes.PhaseII.Instantiate.ToPhaseI as ToP1
import TwoTimes.Integration.DiffZ2Action as DZ
import TwoTimes.Integration.Omega5OddnessOnAb as Ω5Ab
import TwoTimes.Integration.Z2Cover5 as Cov5

module Inst {ℓ ℓT ℓF : Level}
  (H : PI.PushoutIndIF ℓ)
  (E : FA.FreeAbIF_Ext ℓF)
  (A : Asm.AssumptionsIF {ℓ = ℓ} {ℓT = ℓT})
  where

  module I = ToP1.Inst H E A
  open I public hiding (bicomplex; diag; Sys; SK; swap; swap²; swap-diag; Time; T)

  -- Re-open the relevant Phase II assumptions (for Π and eT).
  C0 : Core.CoreIF ℓ
  C0 = Asm.AssumptionsIF.core A

  A2' : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} C0
  A2' = Asm.AssumptionsIF.twoArrows A

  Ad' : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} C0 A2'
  Ad' = Asm.AssumptionsIF.diagonalization A

  open Core.CoreIF C0 using (Sys; SK; diag; swap; swap-diag) public
  open TA.TwoArrowsIF A2' using (T; eT) public
  open Diag.DiagonalizationIF Ad' using (Π) public

  -- Use the Detector module’s negation/inequality types (avoid duplicate ⊥).
  open Det using (⊥; ¬_; _≢_)

  --------------------------------------------------------------------------
  -- Detector ⇒ Diff has a non-fixed point of flip
  --
  -- This is the standard constructive trick: separate points in Diff by a map
  -- to a set (the detector observable), rather than proving inequalities inside
  -- the HIT.
  --------------------------------------------------------------------------

  detector⇒DiffNonFixed' :
    Det.DetectorIF C0 → Σ Diff (λ y → flip y ≢ y)
  detector⇒DiffNonFixed' DIF =
    let
      open Det.DetectorIF DIF

      -- Cofiber machinery (dependent eliminator derived module).
      module CI = CofInd.Inst {ℓ = ℓ} H
      open CI using
        ( cf-in
        ; Cofiber-rec
        ; Cofiber-rec-β-in
        ; Cofiber-map-β-in
        )

      -- The observable factors through Diff via the cofiber recursor.
      obsDiff : Diff → X
      obsDiff = Cofiber-rec diag obs base obs-diag

      obsDiff-β-in : ∀ (x : SK) → obsDiff (cf-in {f = diag} x) ≡ obs x
      obsDiff-β-in x = Cofiber-rec-β-in diag obs base obs-diag x

      -- β on in-points for flip: flip (cf-in x) = cf-in (swap x).
      -- (flip is definitional to the induced cofiber map from (id, swap, swap-diag).)
      flip-β-in : ∀ (x : SK) → flip (cf-in {f = diag} x) ≡ cf-in {f = diag} (swap x)
      flip-β-in x =
        Cofiber-map-β-in
          diag diag
          (λ s → s)
          swap
          swap-diag
          x

      x : SK
      x = fst witness

      nx : obs (swap x) ≢ obs x
      nx = snd witness
    in
      ( cf-in {f = diag} x
      , λ fx≡x →
          let
            step0 : obsDiff (flip (cf-in {f = diag} x)) ≡ obsDiff (cf-in {f = diag} x)
            step0 = cong obsDiff fx≡x

            stepL : obsDiff (flip (cf-in {f = diag} x)) ≡ obs (swap x)
            stepL =
              cong obsDiff (flip-β-in x)
              ∙ obsDiff-β-in (swap x)

            stepR : obsDiff (cf-in {f = diag} x) ≡ obs x
            stepR = obsDiff-β-in x

            obsSwap≡obs : obs (swap x) ≡ obs x
            obsSwap≡obs =
              sym stepL
              ∙ step0
              ∙ stepR
          in
            nx obsSwap≡obs
      )

  detector⇒canonicalFillersDifferent :
    Det.DetectorIF C0 →
    Σ Diff (λ y → actFill I.CF0.bridge y ≢ actFill I.CF0.diag y)
  detector⇒canonicalFillersDifferent DIF =
    nonfixed→actFillDifferent {Z = ⊥} (detector⇒DiffNonFixed' DIF)

  --------------------------------------------------------------------------
  -- Detector ⇒ ¬ SplitCover (stronger corollary; not needed for cohomological non-splitting)
  --
  -- Strategy (no smuggling):
  --   1) Detector provides x : SK, hence Sys is inhabited via Π (suc 0) x.
  --   2) If SplitCover existed, ω₅ would be a coboundary (split→coboundary).
  --   3) Any coboundary sends loops to false (via SectionForm→Sym and xor-self).
  --   4) Hence actω(sqLoop) is pointwise identity, so flip is identity
  --      by actω-sqLoop, contradicting the non-fixed-point witness.
  --------------------------------------------------------------------------

  detector⇒¬Split : Det.DetectorIF C0 → ¬ SplitCover
  detector⇒¬Split DIF split =
    let
      open Det.DetectorIF DIF

      nonfixed : Σ Diff (λ y → flip y ≢ y)
      nonfixed = detector⇒DiffNonFixed' DIF

      y : Diff
      y = fst nonfixed

      ny : flip y ≢ y
      ny = snd nonfixed

      x : SK
      x = fst witness

      -- Use Π to obtain a concrete record r : Sys (hence r : R).
      r : Sys
      r = Π (suc zero) x

      t : T
      t = eT

      u : Nat
      u = zero

      p : Proc₅ r r
      p = sqLoop t u r

      -- From a split we get a coboundary representation for ω₅.
      cob : I.IsCoboundaryω₅
      cob = split→coboundary split

      sec : Σ (I.Cb.0Cochain) (λ s → ∀ {r s'} (q : Proc₅ r s') → ω₅ q ≡ XOR.xor (s r) (s s'))
      sec = I.Cb.SectionForm→Sym cob

      s₀ : I.Cb.0Cochain
      s₀ = fst sec

      cob-form :
        ∀ {r s'} (q : Proc₅ r s') → ω₅ q ≡ XOR.xor (s₀ r) (s₀ s')
      cob-form = snd sec

      eqCob : ω₅ p ≡ XOR.xor (s₀ r) (s₀ r)
      eqCob = cob-form p

      eqFalse : ω₅ p ≡ false
      eqFalse = eqCob ∙ XOR.xor-self (s₀ r)

      act : Bool → Diff → Diff
      act = DZ.Z2Action.act mkZ2Action

      actFalse : ∀ x → actω p x ≡ x
      actFalse x =
        cong (λ b → act b x) eqFalse
        ∙ DZ.Z2Action.act-false mkZ2Action x

      flip-id : ∀ x → flip x ≡ x
      flip-id x =
        sym (actω-sqLoop t u r x)
        ∙ actFalse x
    in
      ny (flip-id y)

  --------------------------------------------------------------------------
  -- Final packaged “limited scope result”
  --------------------------------------------------------------------------

  record LimitedScopeResult : Setω where
    field
      -- Bicomplex identities on Phase II chains (C, Qt, Qu from the instantiation)
      bicomplex : BicomplexIdentities

      -- Z₂ cover groupoid and splitting/coboundary equivalence maps
      ωCover    : Cov5.GroupoidS (ℓ ⊔ lzero) (ℓT ⊔ ℓ) (ℓT ⊔ ℓ)
      split→cob : SplitCover → IsCoboundaryω₅
      cob→split : IsCoboundaryω₅ → SplitCover

      -- Key action statement: sqLoop acts by flip on Diff
      sqLoopActsByFlip :
        ∀ (t : T) (u : Nat) (r : R) (x : Diff) →
        actω (sqLoop t u r) x ≡ flip x

      -- Canonical two-fillers orbit law on Diff
      canonicalFillersOrbit :
        ∀ f x → actFill (toggle f) x ≡ flip (actFill f x)

      -- ω₅ oddness on abelian groups: sqLoop acts by negation
      sqLoopActsByNegOnAb :
        ∀ {ℓG : Level} (G : FA.AbGroup ℓG) →
        ∀ (t : T) (u : Nat) (r : R) (x : FA.AbGroup.Carrier G) →
          (let module Ω = Ω5Ab.Inst I.Time I.RecordIF G in
           Ω.actωG (sqLoop t u r) x ≡ FA.AbGroup.-_ G x)

      -- Detector consequences
      detector⇒DiffNonFixed :
        Det.DetectorIF C0 → Σ Diff (λ y → flip y ≢ y)

      detector⇒nontrivial :
        Det.DetectorIF C0 → ¬ SplitCover

  open LimitedScopeResult public

  -- Builder: produce the package once generator-level d²/anticomm proofs are supplied.
  limitedScopeFromη :
    (qt²η  : ∀ m n → Qt²Onη m n) →
    (qu²η  : ∀ m n → Qu²Onη m n) →
    (antiη : ∀ m n → AnticommOnη m n) →
    LimitedScopeResult
  limitedScopeFromη qt²η qu²η antiη =
    record
      { bicomplex            = bicomplexFromη qt²η qu²η antiη
      ; ωCover               = Cover5Groupoid
      ; split→cob            = split→coboundary
      ; cob→split            = coboundary→split
      ; sqLoopActsByFlip     = actω-sqLoop
      ; canonicalFillersOrbit = actFill-toggle
      ; sqLoopActsByNegOnAb  =
          λ {ℓG} G t u r x →
            let module Ω = Ω5Ab.Inst I.Time I.RecordIF G in
            Ω.actωG-sqLoop t u r x
      ; detector⇒DiffNonFixed = detector⇒DiffNonFixed'
      ; detector⇒nontrivial  = detector⇒¬Split
      }

  -- Fully instantiated package using the derived bicomplex identities.
  limitedScope : LimitedScopeResult
  limitedScope =
    record
      { bicomplex            = I.bicomplex
      ; ωCover               = Cover5Groupoid
      ; split→cob            = split→coboundary
      ; cob→split            = coboundary→split
      ; sqLoopActsByFlip     = actω-sqLoop
      ; canonicalFillersOrbit = actFill-toggle
      ; sqLoopActsByNegOnAb  =
          λ {ℓG} G t u r x →
            let module Ω = Ω5Ab.Inst I.Time I.RecordIF G in
            Ω.actωG-sqLoop t u r x
      ; detector⇒DiffNonFixed = detector⇒DiffNonFixed'
      ; detector⇒nontrivial  = detector⇒¬Split
      }

open Inst public
```
