```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Algebra.AltFin2 where
```

# Double alternating sums (antisymmetric cancellation)

This module provides a 2D alternating-sum lemma: antisymmetric matrices have
zero double alternating sum.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Prelude.Path
import TwoTimes.Process.Grid.Nerve as N
open N using (fzero; fsuc)

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup)

open import TwoTimes.Algebra.SumFin
  using (altFin; altFin-unfold; altFin-cong; altFin-neg; altFin-+)
```

---

## Antisymmetry cancellation

```agda
altFin2-antisym :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat}
    (M : N.Fin n → N.Fin n → AbGroup.Carrier G) →
    (diag0 : ∀ i → M i i ≡ AbGroup.0# G) →
    (anti : ∀ i k → M i k ≡ AbGroup.-_ G (M k i)) →
    altFin G (λ i → altFin G (λ k → M i k)) ≡ AbGroup.0# G
altFin2-antisym G {zero} M diag0 anti = refl
altFin2-antisym G {suc n} M diag0 anti =
  let
    open AbGroup G renaming
      (_+_ to _+G_; -_ to -G_; 0# to 0G
      ; assoc to assocG; idl to idlG; invl to invlG)
    open FAE.AbGroupLemmas G

    A = altFin G (λ k → M fzero (fsuc k))
    B = altFin G (λ i → M (fsuc i) fzero)

    M' : N.Fin n → N.Fin n → AbGroup.Carrier G
    M' i k = M (fsuc i) (fsuc k)

    S' : AbGroup.Carrier G
    S' = altFin G (λ i → altFin G (λ k → M' i k))

    headRow :
      altFin G (λ k → M fzero k) ≡ -G_ A
    headRow =
      altFin-unfold G (λ k → M fzero k)
      ∙ cong (λ t → t +G (-G_ A)) (diag0 fzero)
      ∙ idlG (-G_ A)

    tailOuterEq :
      altFin G (λ i → altFin G (λ k → M (fsuc i) k))
      ≡
      B +G (-G_ S')
    tailOuterEq =
      altFin-cong G
        (λ i → altFin G (λ k → M (fsuc i) k))
        (λ i → M (fsuc i) fzero +G (-G_ (altFin G (λ k → M (fsuc i) (fsuc k)))))
        (λ i → altFin-unfold G (λ k → M (fsuc i) k))
      ∙ altFin-+ G
          (λ i → M (fsuc i) fzero)
          (λ i → -G_ (altFin G (λ k → M (fsuc i) (fsuc k))))
      ∙ cong (λ t → B +G t)
          (altFin-neg G (λ i → altFin G (λ k → M (fsuc i) (fsuc k))))

    B≡-A : B ≡ -G_ A
    B≡-A =
      altFin-cong G
        (λ i → M (fsuc i) fzero)
        (λ i → -G_ (M fzero (fsuc i)))
        (λ i → anti (fsuc i) fzero)
      ∙ altFin-neg G (λ i → M fzero (fsuc i))

    negB≡A : -G_ B ≡ A
    negB≡A = cong -G_ B≡-A ∙ neg-invol A

    negTail :
      -G_ (B +G (-G_ S')) ≡ (-G_ B) +G S'
    negTail =
      neg-distrib-+ B (-G_ S')
      ∙ cong (λ t → (-G_ B) +G t) (neg-invol S')
  in
  altFin-unfold G (λ i → altFin G (λ k → M i k))
  ∙ cong (λ t → t +G (-G_ (altFin G (λ i → altFin G (λ k → M (fsuc i) k))))) headRow
  ∙ cong (λ t → (-G_ A) +G t)
      (cong -G_ tailOuterEq ∙ negTail)
  ∙ sym (assocG (-G_ A) (-G_ B) S')
  ∙ cong (λ t → ((-G_ A) +G t) +G S') negB≡A
  ∙ cong (λ t → t +G S') (invlG A)
  ∙ idlG S'
  ∙ altFin2-antisym G {n} M'
      (λ i → diag0 (fsuc i))
      (λ i k → anti (fsuc i) (fsuc k))
```
