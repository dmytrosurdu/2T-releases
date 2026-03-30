# TwoTimes/PhaseII/Mixing/NoRealSubgroup.lagda.md

Mixing lemma: a minimal abelian-group argument excluding a nontrivial
"real subgroup" under the stated K/mulI/adD relations.
Physics instantiations may define adD only on a chosen core/subalgebra; the
lemma only requires the stated equalities on the element H.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Mixing.NoRealSubgroup where

open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_)

open import TwoTimes.Prelude.Path using (cong; sym; _∙_)
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE

open FAE using (AbGroup)

module Inst {ℓ : Level} (G : AbGroup ℓ) where
  open AbGroup G
  open FAE.AbGroupLemmas G using (neg-invol)

  mixingContradictionCore :
    (mulI K adD : Carrier → Carrier) →
    (K-mulI : ∀ x → K (mulI x) ≡ mulI (- (K x))) →
    (K-adD  : ∀ x → K (adD x) ≡ adD (K x)) →
    (adD-neg : ∀ x → adD (- x) ≡ - (adD x)) →
    (H : Carrier) →
    (mixing : adD H ≡ mulI H) →
    (K-odd : K H ≡ - H) →
    mulI H ≡ - (mulI H)
  mixingContradictionCore mulI K adD K-mulI K-adD adD-neg H mixing K-odd =
    let
      k-mix : adD (K H) ≡ mulI (- (K H))
      k-mix =
        sym (K-adD H)
        ∙ cong K mixing
        ∙ K-mulI H

      step0 : adD (- H) ≡ mulI (- (- H))
      step0 =
        sym (cong adD K-odd)
        ∙ k-mix
        ∙ cong mulI (cong -_ K-odd)

      step1 : - (adD H) ≡ mulI (- (- H))
      step1 =
        sym (adD-neg H)
        ∙ step0

      step2 : - (mulI H) ≡ mulI (- (- H))
      step2 =
        sym (cong -_ mixing)
        ∙ step1

      step3 : - (mulI H) ≡ mulI H
      step3 =
        step2
        ∙ cong mulI (neg-invol H)
    in
      sym step3

  mixingKillsRealSubgroup :
    (mulI K adD : Carrier → Carrier) →
    (K-mulI : ∀ x → K (mulI x) ≡ mulI (- (K x))) →
    (K-adD  : ∀ x → K (adD x) ≡ adD (K x)) →
    (adD-neg : ∀ x → adD (- x) ≡ - (adD x)) →
    (No2Torsion : ∀ x → x ≡ - x → x ≡ 0#) →
    (mulI-kernel0 : ∀ x → mulI x ≡ 0# → x ≡ 0#) →
    (H : Carrier) →
    (mixing : adD H ≡ mulI H) →
    (K-odd : K H ≡ - H) →
    H ≡ 0#
  mixingKillsRealSubgroup mulI K adD K-mulI K-adD adD-neg No2Torsion mulI-kernel0 H mixing K-odd =
    let
      core : mulI H ≡ - (mulI H)
      core = mixingContradictionCore mulI K adD K-mulI K-adD adD-neg H mixing K-odd

      mulI-zero : mulI H ≡ 0#
      mulI-zero = No2Torsion (mulI H) core
    in
      mulI-kernel0 H mulI-zero
```
