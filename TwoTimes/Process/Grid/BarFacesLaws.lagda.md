```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Process.Grid.BarFacesLaws where
```

# Face–face (simplicial) identities for the Bar construction

This module proves the **only simplicial identities needed for Batch 3**:
the **face–face** relations
[
d_i \circ d_j = d_{j-1} \circ d_i \quad (i < j).
]
We prove them for the *Bar* faces `dBar` from `TwoTimes.Process.Grid.Nerve`,
under **associativity** of the underlying operation.

We keep everything:

* non-cubical,
* `--without-K --safe`,
* no stdlib.

---

## Imports (from existing Phase I modules)

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)

import TwoTimes.Process.Grid.Nerve as N
open N using (Fin; fzero; fsuc; Vec; []; _∷_)
open import TwoTimes.Process.Grid.Presentation using (Group)
open import TwoTimes.Prelude.Path
open import TwoTimes.Prelude.FinLemmas
  using (⊥; ⊥-elim; z<s; s<s)
  renaming (_<_ to _<ᶠ_)
```

---

## A tiny order on `Fin` and an injection

We reuse `<` from `FinLemmas` and define the canonical embedding
`inject : Fin n → Fin (suc n)` that preserves the numeric value.

```agda
inject : ∀ {n : Nat} → Fin n → Fin (suc n)
inject {suc n} fzero    = fzero
inject {suc n} (fsuc i) = fsuc (inject i)
```

A predecessor for a `Fin (suc n)` index is definable whenever the index is nonzero.
In our use, nonzeroness is guaranteed by the `<` assumption.

```agda
predFrom<0 : ∀ {n : Nat} {j : Fin (suc n)} → fzero <ᶠ j → Fin n
predFrom<0 {j = fsuc j} _ = j
```

And from `inject i <ᶠ j` we can always conclude `fzero <ᶠ j`:

```agda
<ᶠ-implies-nonzero
  : ∀ {n : Nat} {i : Fin (suc n)} {j : Fin (suc n)} →
    i <ᶠ j → fzero <ᶠ j
<ᶠ-implies-nonzero {j = fsuc j} _ = z<s
```

---

## Generic Bar face–face law

We package the result for any carrier `A` with an associative operation `_∙A_`
(and any chosen unit `eA`, only needed to open `N.Bar`).

```agda
module BarFaces
  {ℓ : Level}
  (A : Set ℓ)
  (_∙A_ : A → A → A)
  (eA : A)
  (assocA : ∀ x y z → (_∙A_ (_∙A_ x y) z) ≡ (_∙A_ x (_∙A_ y z)))
  where

  open N.Bar A _∙A_ eA using (dBar)
```

### Statement (typed form)

For `n : Nat` we have:

* `j : Fin (suc (suc (suc n)))` selects a face of an `(n+2)`-simplex,
* `i : Fin (suc (suc n))` selects a face of an `(n+1)`-simplex,
* `inject i <ᶠ j` is the “`i < j`” side-condition,
* and the identity is the standard `d_i (d_j x) = d_{j-1} (d_i x)`.

We implement `j-1` as the predecessor of `j` (guaranteed nonzero).

```agda
  predJ
    : ∀ {n : Nat} {i : Fin (suc (suc n))} →
      (j : Fin (suc (suc (suc n)))) → inject i <ᶠ j → Fin (suc (suc n))
  predJ {i = i} (fsuc j₀) _ = j₀

  -- Head-preservation for faces with index ≥ 2.
  dBar-head
    : ∀ {n : Nat} (i : Fin (suc n)) (x : A) (ys : Vec A (suc n)) →
      dBar (fsuc (fsuc i)) (x ∷ ys) ≡ x ∷ dBar (fsuc i) ys
  dBar-head i x (y ∷ ys) = refl
```

### Proof

The proof is by structural recursion on the `i<j` witness and by case-splitting
on indices to force `dBar` to reduce. The *only* non-definitional step is the
associativity case corresponding to `i = 1` and `j = 2`.

```agda
  dBar-face-face
    : ∀ {n : Nat}
      (i : Fin (suc (suc n)))
      (j : Fin (suc (suc (suc n))))
      (p : inject i <ᶠ j)
      (xs : Vec A (suc (suc n))) →
      dBar i (dBar j xs) ≡ dBar (predJ j p) (dBar (inject i) xs)
```

#### Base case `n = 0`

```agda
  dBar-face-face {zero} fzero (fsuc fzero) z<s (x ∷ (y ∷ [])) = refl
  dBar-face-face {zero} fzero (fsuc (fsuc fzero)) z<s (x ∷ (y ∷ [])) = refl

  dBar-face-face {zero} (fsuc fzero) (fsuc (fsuc fzero)) (s<s z<s) (x ∷ (y ∷ [])) = refl
```

#### Inductive case `n = suc n`

We pattern-match enough to expose three points `x,y,z` (needed for the associativity subcase).

```agda
  dBar-face-face {suc n} fzero (fsuc j₀) z<s (x ∷ (y ∷ xs)) with j₀ | xs
  ... | fzero | z ∷ xs' = refl
  ... | fsuc fzero | z ∷ xs' = refl
  ... | fsuc (fsuc k) | z ∷ xs'' =
        -- i = 0, j ≥ 3: both sides reduce to the same expression
        -- after dropping the leading x.
        refl
```

Now `i = 1` (i.e. `fsuc fzero`). Here `p` forces `j ≥ 2`.

```agda
  dBar-face-face {suc n} (fsuc fzero) (fsuc fzero) (s<s ()) (x ∷ (y ∷ xs))

  dBar-face-face {suc n} (fsuc fzero) (fsuc (fsuc j₁)) (s<s z<s) (x ∷ (y ∷ (z ∷ xs))) with j₁
  ... | fzero =
        -- The key associativity case: i = 1, j = 2
        --
        -- LHS: d1 (d2 (x,y,z,...)) = d1 (x, (y∙z), ...) = x∙(y∙z), ...
        -- RHS: d1 (d1 (x,y,z,...)) = d1 ((x∙y), z, ...) = (x∙y)∙z, ...
        --
        -- Then use assocA to identify them.
        cong (λ t → t ∷ xs) (sym (assocA x y z))
  ... | fsuc k =
        -- i = 1, j ≥ 3: everything is definitional after reduction.
        refl
```

Finally, `i ≥ 2` reduces to the same lemma on the tail, because both faces are
in the “shifted” region of `dBar`.

```agda
  dBar-face-face {suc n} (fsuc (fsuc i₀)) (fsuc (fsuc fzero)) (s<s (s<s ())) (x ∷ (y ∷ xs))

  dBar-face-face {suc n} (fsuc (fsuc i₀)) (fsuc (fsuc (fsuc j₁))) (s<s (s<s p₀)) (x ∷ (y ∷ (z ∷ xs'))) =
    -- Unfold both sides using the head-preservation lemma, then recurse on the tail.
    dBar-head i₀ x (dBar (fsuc (fsuc j₁)) (y ∷ (z ∷ xs')))
    ∙ cong (λ t → x ∷ t)
        (dBar-face-face {n}
          (fsuc i₀)
          (fsuc (fsuc j₁))
          (s<s p₀)
          (y ∷ (z ∷ xs')))
    ∙ sym (dBar-head j₁ x (dBar (fsuc (inject i₀)) (y ∷ (z ∷ xs'))))
```

---

## Specializations used in Batch 3

### TimeBar faces

We expose the face–face identity for `dᵗ` (the Bar faces over the Time group).

```agda
module TimeBarFaces {ℓT : Level} (Time : Group ℓT) where
  open Group Time renaming (Carrier to T; e to eT; _∙_ to _∙T_; assoc to assocT)

  open N.TimeBar Time using (dᵗ; TimeSimplex)

  module BF = BarFaces T _∙T_ eT assocT

  dᵗ-face-face
    : ∀ {n : Nat}
      (i : Fin (suc (suc n)))
      (j : Fin (suc (suc (suc n))))
      (p : inject i <ᶠ j)
      (xs : TimeSimplex (suc (suc n))) →
      dᵗ i (dᵗ j xs) ≡ dᵗ (BF.predJ j p) (dᵗ (inject i) xs)
  dᵗ-face-face i j p xs = BF.dBar-face-face i j p xs
```

### RGBar faces

RG uses Nat addition `_+_` from `Nerve`. We prove associativity locally and
export the face–face identity for `dᵘ`.

```agda
module RGBarFaces where
  open N.RGBar using (dᵘ; RGSimplex)

  open N using (_+_)

  +-assoc : ∀ a b c → (a + b) + c ≡ a + (b + c)
  +-assoc zero    b c = refl
  +-assoc (suc a) b c = cong suc (+-assoc a b c)

  module BF = BarFaces Nat _+_ zero +-assoc

  dᵘ-face-face
    : ∀ {n : Nat}
      (i : Fin (suc (suc n)))
      (j : Fin (suc (suc (suc n))))
      (p : inject i <ᶠ j)
      (xs : RGSimplex (suc (suc n))) →
      dᵘ i (dᵘ j xs) ≡ dᵘ (BF.predJ j p) (dᵘ (inject i) xs)
  dᵘ-face-face i j p xs = BF.dBar-face-face i j p xs
```
