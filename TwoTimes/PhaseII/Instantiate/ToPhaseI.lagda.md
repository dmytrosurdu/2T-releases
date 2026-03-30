# TwoTimes/PhaseII/Instantiate/ToPhaseI.lagda.md

Phase II (Batch 8): compiler/instantiator from **Phase II assumption records**
into the existing **Phase I stack** (bicomplex, Proc₅/ω₅, Diff flip action, cover/splitting).

This module is intentionally **mechanical** and **no-smuggling**:

* It does **not** derive new physics facts.
* It composes existing Phase I constructions using Phase II records.
* Where Phase I needs *proofs* (e.g. bicomplex identities), it exposes a
  constructor `bicomplexFromη` that lifts **generator-level** equalities into
  chain-level equalities via `FreeAbIF_Ext.extFree`.

Optional: a submodule `WithDetector` compiles `DetectorIF` into a concrete
“non-fixed point of flip” witness in `Diff` using a cofiber recursor, avoiding
reasoning “inside the HIT”.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Instantiate.ToPhaseI where

open import Agda.Primitive using (Level; lsuc; _⊔_; Setω)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)
open import Data.Empty using (⊥)

open import TwoTimes.Prelude.Path using (sym; trans; cong; subst; _∙_)

import TwoTimes.Process.Grid.Nerve as Nerve
import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Prelude.NatLemmas as NL
import TwoTimes.Prelude.FinLemmas as FL
import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FA

import TwoTimes.PhaseII.Assumptions.All as AsmAll
import TwoTimes.PhaseII.Assumptions.Core as Core
import TwoTimes.PhaseII.Assumptions.TwoArrows as TA
import TwoTimes.PhaseII.Assumptions.Diagonalization as Diag
import TwoTimes.PhaseII.Assumptions.RecordTimeFromRG as RT
import TwoTimes.PhaseII.Assumptions.SquareFillers as SF
import TwoTimes.PhaseII.Assumptions.NoMixedAnomaly as NMA
import TwoTimes.PhaseII.Assumptions.Detector as Det

import TwoTimes.PhaseII.Bicomplex.BisimplicialIF as BI
import TwoTimes.PhaseII.Bicomplex.BoundaryDefs as P2BD
import TwoTimes.PhaseII.Bicomplex.BoundaryTheorems as P2BT

import TwoTimes.Obstruction.Omega as Ω0
import TwoTimes.Integration.SKSwapIF as SK
import TwoTimes.Integration.TwoTimeRecordIF as TT
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5
import TwoTimes.Integration.Nontrivial5 as NT5
import TwoTimes.Integration.Proc5Groupoid as PG5
import TwoTimes.Integration.Coboundary5 as Cob5
import TwoTimes.Integration.Z2Cover5 as Cov5
import TwoTimes.Integration.Splitting5 as Split5
import TwoTimes.Integration.CanonicalFillers as CF

import TwoTimes.Integration.DiffZ2Action as DZ
import TwoTimes.Integration.Omega5ActionOnDiff as Ω5D

import TwoTimes.Diff.CofiberInd as CofInd

-- --------------------------------------------------------------------------
-- Core instantiation: assumptions → Phase I instances
-- --------------------------------------------------------------------------

module Inst {ℓ ℓT ℓF : Level}
  (H  : PI.PushoutIndIF ℓ)
  (E  : FA.FreeAbIF_Ext ℓF)
  (A  : AsmAll.AssumptionsIF {ℓ = ℓ} {ℓT = ℓT})
  where

  -- Unpack Phase II assumption bundle
  Core0 : Core.CoreIF ℓ
  Core0 = AsmAll.AssumptionsIF.core A

  A2  : TA.TwoArrowsIF {ℓ = ℓ} {ℓT = ℓT} Core0
  A2  = AsmAll.AssumptionsIF.twoArrows A

  Ad  : Diag.DiagonalizationIF {ℓ = ℓ} {ℓT = ℓT} Core0 A2
  Ad  = AsmAll.AssumptionsIF.diagonalization A

  Rt  : RT.RecordTimeIF {ℓ = ℓ} {ℓT = ℓT} Core0 A2 Ad
  Rt  = AsmAll.recordTimeOf A

  Sqs : SF.SquareFillersIF {ℓ = ℓ} {ℓT = ℓT} Core0 A2 Ad Rt
  Sqs = AsmAll.squareFillersOf A

  Mix : NMA.NoMixedAnomalyIF {ℓ = ℓ} Core0
  Mix = AsmAll.AssumptionsIF.noMixedAnomaly A

  -- ------------------------------------------------------------------------
  -- Phase II → Phase I: SKSwapIF (guardrail: do not duplicate)
  -- ------------------------------------------------------------------------

  SKSwap : SK.SKSwapIF ℓ
  SKSwap = AsmAll.core→SKSwapIF Core0

  -- ------------------------------------------------------------------------
  -- Record dynamics + TwoTimeRecordIF instantiation on R = Sys
  -- ------------------------------------------------------------------------

  open Core.CoreIF Core0 public using (Sys; SK; diag; swap; swap²; swap-diag)
  open TA.TwoArrowsIF A2 public using (Time; T)
  open RT.RecordTimeIF Rt public using (actSys; actSys-id; actSys-comp; actSys-inv)

  open Diag.DiagonalizationIF Ad public using (R̂; R̂-zero; R̂-comp)

  -- Align Nat addition with the Presentation convention used by TwoTimeRecordIF.
  +-agree : ∀ (u₂ u₁ : Nat) → NL._+_ u₂ u₁ ≡ Pres._+_ u₂ u₁
  +-agree zero u₁ = refl
  +-agree (suc u₂) u₁ = cong suc (+-agree u₂ u₁)

  RD : Ω0.RecordDynamics {ℓT = ℓT} {ℓR = ℓ} Time
  RD =
    record
      { R        = Sys
      ; act      = actSys
      ; act-id   = actSys-id
      ; act-comp = actSys-comp
      ; act-inv  = actSys-inv
      }

  -- TwoTimeRecordIF instance:
  --   - R = Sys
  --   - act = actSys
  --   - rec u = R̂ u
  --   - sqPath diag/bridge supplied by SquareFillersIF
  RecordIF : TT.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓ} Time
  RecordIF =
    record
      { RD       = RD
      ; rec      = R̂
      ; rec-zero = R̂-zero
      ; rec-comp = rec-comp
      ; sqPath   = sqPath
      }
    where
      open SF.SquareFillersIF Sqs using (sqDiag; sqBridge)

      rec-comp :
        ∀ r (u₁ u₂ : Nat) → R̂ (Pres._+_ u₂ u₁) r ≡ R̂ u₂ (R̂ u₁ r)
      rec-comp r u₁ u₂ =
        subst (λ k → R̂ k r ≡ R̂ u₂ (R̂ u₁ r)) (+-agree u₂ u₁) (R̂-comp r u₁ u₂)

      sqPath :
        TT.Fill →
        (t : T) (u : Nat) (r : Sys) →
        R̂ u (actSys t r) ≡ actSys t (R̂ u r)
      sqPath TT.diag   t u r = sqDiag t u r
      sqPath TT.bridge t u r = sqBridge t u r

  -- ------------------------------------------------------------------------
  -- Instantiate the Proc₅ / ω₅ / cover / splitting stack (Phase I)
  -- ------------------------------------------------------------------------

  module P = RP5.Inst Time RecordIF
  module O = Ω5.Inst Time RecordIF
  module N = NT5.Inst Time RecordIF
  module G = PG5.Inst Time RecordIF
  module Cb = Cob5.Inst Time RecordIF
  module Cv = Cov5.Inst Time RecordIF
  module Sp = Split5.Inst Time RecordIF

  -- Re-export the most-used names in a stable way (optional convenience).
  open P public using (R; Proc₅; sqLoop)
  open O public using (ω₅)
  open Cb public using (IsCoboundaryω₅)
  open Cv public using (Cover5Groupoid)
  open Sp public using (SplitCover; split→coboundary; coboundary→split; cornerPathsObstructSplit)

  sqLoopTrue→¬Coboundary : Cb.SqLoopTrue → Cb.IsCoboundaryω₅ → ⊥
  sqLoopTrue→¬Coboundary st =
    Cb.loopTrue→¬Coboundary (Cb.SqLoopTrue→LoopTrue st)

  -- ------------------------------------------------------------------------
  -- Diff, flip, and ω-action on Diff (Phase I, Batch 7′)
  -- ------------------------------------------------------------------------

  module D = DZ.Inst H SKSwap
  module CF0 = CF.Inst H SKSwap
  module Act = Ω5D.Inst H SKSwap Time RecordIF

  open D public using (Diff; flip; flip²; mkZ2Action)
  open CF0 public using
    ( toggle; toggle²
    ; fillParity; fillParity-toggle
    ; actFill; actFill-diag; actFill-bridge
    ; actFill-toggle; actFill-toggle²
    ; actFill-bridge≡diag→flip-id
    ; nonfixed→actFillDifferent; nonfixed→¬actFillBridge≡Diag
    )
  open Act public using (actω; actω-resp; actω-comp; actω-sqLoop)

  -- ------------------------------------------------------------------------
  -- Phase II bicomplex on the A_mix descent object CSK
  --
  -- We compile NoMixedAnomalyIF → BisimplicialIF, then reuse Phase II
  -- boundary definitions and lifting theorem.
  -- ------------------------------------------------------------------------

  private
    open Nerve using (Fin; fzero; fsuc)

    infix 4 _<ᶠ_
    _<ᶠ_ : ∀ {n : Nat} → Fin n → Fin n → Set
    _<ᶠ_ = FL._<_

    inject≡ : ∀ {n : Nat} (i : Fin (suc (suc n))) → BI.inject i ≡ NMA.inject i
    inject≡ fzero = refl
    inject≡ {n = zero} (fsuc fzero) = refl
    inject≡ {n = suc n} (fsuc i) = cong fsuc (inject≡ {n = n} i)

    predJ-agree :
      ∀ {n : Nat} {i : Fin (suc (suc n))}
        (j : Fin (suc (suc (suc n))))
        (p  : BI.inject i <ᶠ j)
        (p' : NMA.inject i <ᶠ j) →
      BI.predJ j p ≡ NMA.predJ j p'
    predJ-agree fzero () _
    predJ-agree (fsuc k) p p' = refl

    faceH-faceH' :
      ∀ {m n : Nat}
        (i : Fin (suc (suc m)))
        (j : Fin (suc (suc (suc m))))
        (p : BI.inject i <ᶠ j)
        (x : NMA.NoMixedAnomalyIF.CSK Mix (suc (suc m)) n) →
        NMA.NoMixedAnomalyIF.dH Mix i (NMA.NoMixedAnomalyIF.dH Mix j x)
        ≡
        NMA.NoMixedAnomalyIF.dH Mix (BI.predJ j p)
          (NMA.NoMixedAnomalyIF.dH Mix (BI.inject i) x)
    faceH-faceH' i j p x =
      let
        p' = subst (λ t → t <ᶠ j) (inject≡ i) p

        step0 = NMA.NoMixedAnomalyIF.faceH-faceH Mix i j p' x

        step1 =
          cong
            (λ k → NMA.NoMixedAnomalyIF.dH Mix k
              (NMA.NoMixedAnomalyIF.dH Mix (NMA.inject i) x))
            (sym (predJ-agree j p p'))

        step2 =
          cong
            (λ t → NMA.NoMixedAnomalyIF.dH Mix (BI.predJ j p) t)
            (cong (λ k → NMA.NoMixedAnomalyIF.dH Mix k x) (sym (inject≡ i)))
      in
        step0 ∙ step1 ∙ step2

    faceV-faceV' :
      ∀ {m n : Nat}
        (i : Fin (suc (suc n)))
        (j : Fin (suc (suc (suc n))))
        (p : BI.inject i <ᶠ j)
        (x : NMA.NoMixedAnomalyIF.CSK Mix m (suc (suc n))) →
        NMA.NoMixedAnomalyIF.dV Mix i (NMA.NoMixedAnomalyIF.dV Mix j x)
        ≡
        NMA.NoMixedAnomalyIF.dV Mix (BI.predJ j p)
          (NMA.NoMixedAnomalyIF.dV Mix (BI.inject i) x)
    faceV-faceV' i j p x =
      let
        p' = subst (λ t → t <ᶠ j) (inject≡ i) p

        step0 = NMA.NoMixedAnomalyIF.faceV-faceV Mix i j p' x

        step1 =
          cong
            (λ k → NMA.NoMixedAnomalyIF.dV Mix k
              (NMA.NoMixedAnomalyIF.dV Mix (NMA.inject i) x))
            (sym (predJ-agree j p p'))

        step2 =
          cong
            (λ t → NMA.NoMixedAnomalyIF.dV Mix (BI.predJ j p) t)
            (cong (λ k → NMA.NoMixedAnomalyIF.dV Mix k x) (sym (inject≡ i)))
      in
        step0 ∙ step1 ∙ step2

    Bis : BI.BisimplicialIF ℓ
    Bis =
      record
        { X = NMA.NoMixedAnomalyIF.CSK Mix
        ; dH  = NMA.NoMixedAnomalyIF.dH Mix
        ; dV  = NMA.NoMixedAnomalyIF.dV Mix
        ; faceH-faceH      = faceH-faceH'
        ; faceV-faceV      = faceV-faceV'
        ; faceH-faceV-comm = NMA.NoMixedAnomalyIF.faceH-faceV-comm Mix
        }

  module BD = P2BD.Inst {ℓX = ℓ} {ℓF = ℓF} E Bis
  module BT = P2BT.Inst {ℓX = ℓ} {ℓF = ℓF} E Bis

  open BD public using (C; Qt; Qu)
  open BT public using (BicomplexIdentities; Qt²Onη; Qu²Onη; AnticommOnη; bicomplexFromη)

  abstract
    bicomplex : BicomplexIdentities
    bicomplex = BT.bicomplex

  -- ------------------------------------------------------------------------
  -- Optional detector compilation (recommended Phase II nontriviality hook)
  -- ------------------------------------------------------------------------

  module WithDetector (DIF : Det.DetectorIF Core0) where
    open Det.DetectorIF DIF

    -- Reuse the detector's negation / inequality utilities.
    open Det using (⊥; ¬_; _≢_)

    -- Cofiber recursor on Diff (from PushoutIndIF) to define obs on Diff.
    module CI = CofInd.Inst {ℓ = ℓ} H

    -- Diff is Cofiber diag (definitionally the same as in DZ.Inst).
    -- We use CI’s cofiber constructors/recursor for the detector proof.
    open CI using (cf-in; Cofiber-rec; Cofiber-rec-β-in; Cofiber-map-β-in)

    private
      obsDiff : D.Diff → X
      obsDiff =
        -- Cofiber-rec takes: b : SK → X, pt : X, h : ∀ s → obs (diag s) ≡ base
        Cofiber-rec diag obs base obs-diag

      obsDiff-β-in : ∀ (x : SK) → obsDiff (cf-in {f = diag} x) ≡ obs x
      obsDiff-β-in x = Cofiber-rec-β-in diag obs base obs-diag x

      -- Compute flip on in-points: flip (cf-in x) = cf-in (swap x).
      flip-β-in : ∀ (x : SK) → D.flip (cf-in {f = diag} x) ≡ cf-in {f = diag} (swap x)
      flip-β-in x =
        -- flip is definitionally the cofiber map induced by (id, swap, swap-diag)
        Cofiber-map-β-in
          diag diag
          (λ s → s)
          swap
          swap-diag
          x

    -- Detector implies existence of a non-fixed point of flip in Diff.
    abstract
      DiffHasNonFixed : Σ D.Diff (λ y → D.flip y ≢ y)
      DiffHasNonFixed =
        let
          x  = fst witness
          nx = snd witness  -- obs (swap x) ≢ obs x
        in
          ( cf-in {f = diag} x
          , λ fx≡x →
              -- Apply obsDiff to fx≡x and rewrite both sides to get obs(swap x) ≡ obs x.
              let
                step0 : obsDiff (D.flip (cf-in {f = diag} x)) ≡ obsDiff (cf-in {f = diag} x)
                step0 = cong obsDiff fx≡x

                stepL : obsDiff (D.flip (cf-in {f = diag} x)) ≡ obs (swap x)
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
```
