```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Algebra.ReindexAltFin where
```

# Reindexing alternating sums over `Fin`

Shared helpers for `altFin` reindexing via `punchOut?`, plus the structural
`after?` comparison and its order lemmas.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Prelude.Path
import TwoTimes.Process.Grid.Nerve as N
open N using (Fin; fzero; fsuc)

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup)

open import TwoTimes.Algebra.Sign using (sgn)
open import TwoTimes.Algebra.SumFin using (altFin; altFin-unfold; altFin-cong; altFin-neg)
open import TwoTimes.Prelude.FinLemmas
  using (Maybe; nothing; just; punchOut?; z<s; s<s)
  renaming (_<_ to _<ᶠ_)
```

---

## Small `Maybe` eliminator

```agda
caseMaybe : ∀ {ℓA ℓB} {A : Set ℓA} {B : Set ℓB} →
            (A → B) → B → Maybe A → B
caseMaybe f z nothing  = z
caseMaybe f z (just a) = f a

caseMaybe-just :
  ∀ {ℓA ℓB} {A : Set ℓA} {B : Set ℓB}
    (f : A → B) (z : B) (a : A) →
  caseMaybe f z (just a) ≡ f a
caseMaybe-just f z a = refl

caseMaybe-nothing :
  ∀ {ℓA ℓB} {A : Set ℓA} {B : Set ℓB}
    (f : A → B) (z : B) →
  caseMaybe f z nothing ≡ z
caseMaybe-nothing f z = refl
```

---

## Structural comparison on `Fin`

```agda
after? : ∀ {n : Nat} → N.Fin (suc n) → N.Fin (suc n) → Bool
after? fzero    fzero    = false
after? fzero    (fsuc _) = true
after? (fsuc _) fzero    = false
after? {n = suc n} (fsuc i) (fsuc k) = after? {n = n} i k

after?-lt :
  ∀ {n : Nat} {i k : N.Fin (suc n)} →
  i <ᶠ k → after? i k ≡ true
after?-lt z<s = refl
after?-lt {n = suc n} (s<s p) = after?-lt {n = n} p

after?-gt :
  ∀ {n : Nat} {i k : N.Fin (suc n)} →
  k <ᶠ i → after? i k ≡ false
after?-gt z<s = refl
after?-gt {n = suc n} (s<s p) = after?-gt {n = n} p
```

---

## Reindexing `altFin` after deleting an index

```agda
reindex-altFin :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} (i : N.Fin (suc n))
    (f : N.Fin n → AbGroup.Carrier G) →
  altFin G f
  ≡
  altFin G (λ k →
    caseMaybe (λ j → sgn G (after? i k) (f j))
              (AbGroup.0# G)
              (punchOut? i k))
reindex-altFin G {n} fzero f =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G; idl to idlG)
    open FAE.AbGroupLemmas G
    g : N.Fin (suc n) → AbGroup.Carrier G
    g k = caseMaybe (λ j → sgn G (after? fzero k) (f j)) 0G (punchOut? fzero k)
  in
  sym
    (altFin-unfold G g
     ∙ cong (λ t → 0G +G t) (cong -G_ (altFin-neg G f))
     ∙ cong (λ t → 0G +G t) (neg-invol (altFin G f))
     ∙ idlG (altFin G f))
reindex-altFin G {suc n} (fsuc i) f =
  sym (altFin-unfold G f)
  ∙ cong (λ t → f fzero +G (-G_ t)) ih
  ∙ cong (λ t → t +G (-G_ (altFin G gTail))) (sym g-fzero)
  ∙ cong (λ t → g fzero +G (-G_ t))
      (altFin-cong G gTail (λ k → g (fsuc k)) gTail-def)
  ∙ sym (altFin-unfold G g)
  where
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G; idl to idlG)
    fTail : N.Fin n → AbGroup.Carrier G
    fTail j = f (fsuc j)
    gTail : N.Fin (suc n) → AbGroup.Carrier G
    gTail k = caseMaybe (λ j → sgn G (after? i k) (f (fsuc j))) 0G (punchOut? i k)
    ih : altFin G fTail ≡ altFin G gTail
    ih = reindex-altFin G i fTail
    g : N.Fin (suc (suc n)) → AbGroup.Carrier G
    g k = caseMaybe (λ j → sgn G (after? (fsuc i) k) (f j)) 0G (punchOut? (fsuc i) k)
    g-fzero : g fzero ≡ f fzero
    g-fzero = refl
    gTail-def : ∀ k → gTail k ≡ g (fsuc k)
    gTail-def k with punchOut? i k
    ... | nothing = refl
    ... | just j  = refl
```
