```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Algebra.SumFin where
```

# Finite sums over `Fin`

This module provides minimal recursion on `Fin` for finite sums and alternating sums,
plus homomorphism push-through lemmas. No lists or permutations.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Prelude.Path
open import TwoTimes.Process.Grid.Nerve using (Fin; fzero; fsuc)

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup; Hom)
```

---

## Sum and alternating sum

```agda
sumFin : ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} → (Fin n → AbGroup.Carrier G) → AbGroup.Carrier G
sumFin G {zero}  f = AbGroup.0# G
sumFin G {suc n} f =
  let open AbGroup G renaming (_+_ to _+G_) in
  f fzero +G sumFin G (λ i → f (fsuc i))

altFin : ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} → (Fin n → AbGroup.Carrier G) → AbGroup.Carrier G
altFin G {zero}  f = AbGroup.0# G
altFin G {suc n} f =
  let open AbGroup G renaming (_+_ to _+G_; -_ to -G_) in
  f fzero +G (-G_ (altFin G (λ i → f (fsuc i))))

-- Unfolding lemma for altFin at suc n (definitionally true).
altFin-unfold :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} (f : Fin (suc n) → AbGroup.Carrier G) →
  altFin G f ≡
  let open AbGroup G renaming (_+_ to _+G_; -_ to -G_) in
  f fzero +G (-G_ (altFin G (λ i → f (fsuc i))))
altFin-unfold G f = refl

-- Negation commutes with altFin.
altFin-neg :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} (f : Fin n → AbGroup.Carrier G) →
  altFin G (λ i → AbGroup.-_ G (f i)) ≡ AbGroup.-_ G (altFin G f)
altFin-neg G {zero} f =
  let open FAE.AbGroupLemmas G in
  zero-neg
altFin-neg G {suc n} f =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_)
    open FAE.AbGroupLemmas G
  in
  altFin-unfold G (λ i → -G_ (f i))
  ∙ cong (λ t → (-G_ (f fzero)) +G (-G_ t))
      (altFin-neg G (λ i → f (fsuc i)))
  ∙ sym (neg-distrib-+ (f fzero) (-G_ (altFin G (λ i → f (fsuc i)))))

-- Alternating sum of all zeros is zero.
altFin-zero :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat} →
  altFin G {n = n} (λ _ → AbGroup.0# G) ≡ AbGroup.0# G
altFin-zero G {zero} = refl
altFin-zero G {suc n} =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G; idl to idlG)
    open FAE.AbGroupLemmas G
  in
  altFin-unfold G {n = n} (λ _ → 0G)
  ∙ cong (λ t → 0G +G t) (cong -G_ (altFin-zero G {n = n}))
  ∙ cong (λ t → 0G +G t) neg-0
  ∙ idlG 0G

-- Alternating sum distributes over pointwise addition.
altFin-+ :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat}
    (f g : Fin n → AbGroup.Carrier G) →
  altFin G (λ i → AbGroup._+_ G (f i) (g i))
  ≡
  AbGroup._+_ G (altFin G f) (altFin G g)
altFin-+ G {zero} f g =
  let open FAE.AbGroupLemmas G in
  sym zero-plus-zero
altFin-+ G {suc n} f g =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_; assoc to assocG; comm to commG)
    open FAE.AbGroupLemmas G
    f0 = f fzero
    g0 = g fzero
    ft = λ i → f (fsuc i)
    gt = λ i → g (fsuc i)
    tail-lemma :
      -G_ (altFin G (λ i → f (fsuc i) +G g (fsuc i)))
      ≡
      (-G_ (altFin G ft)) +G (-G_ (altFin G gt))
    tail-lemma =
      cong -G_ (altFin-+ G ft gt)
      ∙ neg-distrib-+ (altFin G ft) (altFin G gt)

    interchange : ∀ a b c d →
      (a +G b) +G (c +G d) ≡ (a +G c) +G (b +G d)
    interchange a b c d =
      sym (assocG (a +G b) c d)
      ∙ cong (λ t → t +G d) (assocG a b c)
      ∙ cong (λ t → (a +G t) +G d) (commG b c)
      ∙ cong (λ t → t +G d) (sym (assocG a c b))
      ∙ assocG (a +G c) b d
  in
  altFin-unfold G (λ i → f i +G g i)
  ∙ cong (λ t → (f0 +G g0) +G t) tail-lemma
  ∙ interchange f0 g0 (-G_ (altFin G ft)) (-G_ (altFin G gt))

-- If the head equals the alternating sum of the tail, the whole sum is 0.
altFin-cancel :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat}
    (f : Fin (suc n) → AbGroup.Carrier G) →
  f fzero ≡ altFin G (λ i → f (fsuc i)) →
  altFin G f ≡ AbGroup.0# G
altFin-cancel G {n} f head= =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_)
    open FAE.AbGroupLemmas G
    tail = altFin G (λ i → f (fsuc i))
  in
  altFin-unfold G f
  ∙ cong (λ t → t +G (-G_ tail)) head=
  ∙ invr tail

```

---

## Congruence and homomorphism push-through

```agda
sumFin-cong :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat}
    (f g : Fin n → AbGroup.Carrier G) →
  (∀ i → f i ≡ g i) →
  sumFin G f ≡ sumFin G g
sumFin-cong G {zero}  f g fg = refl
sumFin-cong G {suc n} f g fg =
  let open AbGroup G renaming (_+_ to _+G_) in
  cong (λ t → f fzero +G t)
      (sumFin-cong G (λ i → f (fsuc i)) (λ i → g (fsuc i)) (λ i → fg (fsuc i)))
  ∙ cong (λ t → t +G sumFin G (λ i → g (fsuc i))) (fg fzero)

altFin-cong :
  ∀ {ℓ} (G : AbGroup ℓ) {n : Nat}
    (f g : Fin n → AbGroup.Carrier G) →
  (∀ i → f i ≡ g i) →
  altFin G f ≡ altFin G g
altFin-cong G {zero}  f g fg = refl
altFin-cong G {suc n} f g fg =
  let open AbGroup G renaming (_+_ to _+G_; -_ to -G_) in
  cong (λ t → f fzero +G (-G_ t))
      (altFin-cong G (λ i → f (fsuc i)) (λ i → g (fsuc i)) (λ i → fg (fsuc i)))
  ∙ cong (λ t → t +G (-G_ (altFin G (λ i → g (fsuc i))))) (fg fzero)

sumFin-map :
  ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} {n : Nat}
    (F : Hom A B) (f : Fin n → AbGroup.Carrier A) →
  Hom.f F (sumFin A f) ≡ sumFin B (λ i → Hom.f F (f i))
sumFin-map {A = A} {B = B} {zero} F f =
  Hom.f-0 F
sumFin-map {A = A} {B = B} {suc n} F f =
  let
    open AbGroup B renaming (_+_ to _+B_)
  in
  Hom.f-+ F (f fzero) (sumFin A (λ i → f (fsuc i)))
  ∙ cong (λ t → Hom.f F (f fzero) +B t)
      (sumFin-map F (λ i → f (fsuc i)))

altFin-map :
  ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} {n : Nat}
    (F : Hom A B) (f : Fin n → AbGroup.Carrier A) →
  Hom.f F (altFin A f) ≡ altFin B (λ i → Hom.f F (f i))
altFin-map {A = A} {B = B} {zero} F f =
  Hom.f-0 F
altFin-map {A = A} {B = B} {suc n} F f =
  let
    open AbGroup A renaming (_+_ to _+A_; -_ to -A_)
    open AbGroup B renaming (_+_ to _+B_; -_ to -B_)
  in
  Hom.f-+ F (f fzero) (-A_ (altFin A (λ i → f (fsuc i))))
  ∙ cong (λ t → Hom.f F (f fzero) +B t)
      (Hom.f-neg F (altFin A (λ i → f (fsuc i)))
       ∙ cong -B_ (altFin-map F (λ i → f (fsuc i))))

-- Swap the order of two alternating sums.
altFin-swap :
  ∀ {ℓ} (G : AbGroup ℓ) {m n : Nat}
    (f : Fin m → Fin n → AbGroup.Carrier G) →
  altFin G (λ i → altFin G (λ j → f i j))
  ≡
  altFin G (λ j → altFin G (λ i → f i j))
altFin-swap G {zero} {n} f =
  let open AbGroup G renaming (0# to 0G) in
  sym (altFin-zero G {n = n})
  ∙ altFin-cong G {n = n}
      (λ _ → 0G)
      (λ j → altFin G (λ i → f i j))
      (λ _ → refl)
altFin-swap G {suc m} {n} f =
  let
    open AbGroup G renaming (_+_ to _+G_; -_ to -G_)
    f0 = λ j → f fzero j
    ft = λ i j → f (fsuc i) j
  in
  altFin-unfold G (λ i → altFin G (λ j → f i j))
  ∙ cong (λ t → altFin G f0 +G t)
      (cong -G_ (altFin-swap G (λ i j → f (fsuc i) j)))
  ∙ cong (λ t → altFin G f0 +G t)
      (sym (altFin-neg G (λ j → altFin G (λ i → f (fsuc i) j))))
  ∙ sym
      (altFin-+ G
        (λ j → f0 j)
        (λ j → -G_ (altFin G (λ i → f (fsuc i) j))))
```
