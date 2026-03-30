```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Process.Grid.Nerve where
```

# Nerve and bisimplicial “grid” object (Phase I)

This module defines:

1. A **bar/nerve-style simplicial object** for a one-object category presented by
   a carrier `A` with an operation `_∙_` and unit `e` (no proofs required to define faces).
2. Specializations:

   * `TimeBar` for a **group** `Time`,
   * `RGBar` for the **monoid** `(Nat, zero, _+_)`.
3. A **bisimplicial object** as the product of the two simplicial objects:
   [
   \mathsf{Grid}_{m,n} := \mathsf{TimeBar}_m \times \mathsf{RGBar}_n .
   ]
   Horizontal faces/degeneracies act only on the time component, vertical ones only on the RG component.
4. Trivial commutation lemmas between horizontal and vertical operators (by definitional equality).

> **Team goals (not proved here)**
>
> * Prove the simplicial identities for `dBar`/`sBar` under associativity/unit laws.
> * Connect this “normal form” bisimplicial object to the *presented grid* in
>   `TwoTimes.Process.Grid.Presentation` via a normalization/evaluation map.
>   (This is a later “soundness/completeness” layer.)

---

## Imports and small primitives

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Sigma using (Σ; _,_)
open import Agda.Builtin.List using (List; []; _∷_)
open import Agda.Builtin.Unit using (⊤; tt)

open import TwoTimes.Process.Grid.Presentation using (Group)

-- Nat addition (local, to avoid extra dependencies)
infixl 6 _+_
_+_ : Nat → Nat → Nat
zero  + n = n
suc m + n = suc (m + n)

-- Finite indices
data Fin : Nat → Set where
  fzero : ∀ {n} → Fin (suc n)
  fsuc  : ∀ {n} → Fin n → Fin (suc n)

-- Length-indexed vectors
data Vec {ℓ : Level} (A : Set ℓ) : Nat → Set ℓ where
  []  : Vec A zero
  _∷_ : ∀ {n} → A → Vec A n → Vec A (suc n)

-- Product (simple record)
record _×_ {ℓ₁ ℓ₂ : Level} (A : Set ℓ₁) (B : Set ℓ₂) : Set (ℓ₁ ⊔ ℓ₂) where
  constructor _,_
  field fst : A
        snd : B
open _×_ public
```

---

## Generic “bar” faces and degeneracies

We model the *reduced nerve* of a one-object category with endomorphisms `A`,
composition `_∙_`, and identity `e`.

* An `n`-simplex is a vector of `n` morphisms: `Vec A n`.
* Faces map from `(suc n)`-simplices to `n`-simplices and are indexed by `Fin (suc (suc n))`
  (i.e. `suc n + 1` faces).
* Degeneracies map from `n`-simplices to `(suc n)`-simplices and are indexed by `Fin (suc n)`
  (i.e. `n + 1` degeneracies).

```agda
module Bar
  {ℓ : Level}
  (A : Set ℓ)
  (_∙_ : A → A → A)
  (e : A)
  where

  -- Faces: d : (suc n)-simplices → n-simplices, with (suc n)+1 faces
  dBar : ∀ {n : Nat} → Fin (suc (suc n)) → Vec A (suc n) → Vec A n
  dBar {zero}  fzero      (x ∷ []) = []
  dBar {zero}  (fsuc fzero) (x ∷ []) = []

  dBar {suc n} fzero (x ∷ y ∷ xs) = y ∷ xs
  dBar {suc n} (fsuc fzero) (x ∷ y ∷ xs) = (x ∙ y) ∷ xs
  dBar {suc n} (fsuc (fsuc i)) (x ∷ y ∷ xs) =
    x ∷ dBar (fsuc i) (y ∷ xs)

  -- Degeneracies: s : n-simplices → (suc n)-simplices, with n+1 degeneracies
  sBar : ∀ {n : Nat} → Fin (suc n) → Vec A n → Vec A (suc n)
  sBar {zero}  fzero [] = e ∷ []
  sBar {suc n} fzero (x ∷ xs) = e ∷ x ∷ xs
  sBar {suc n} (fsuc i) (x ∷ xs) = x ∷ sBar i xs
```

---

## Time bar construction (from a group)

We reuse the group interface from `Presentation`.

```agda
module TimeBar {ℓT : Level} (Time : Group ℓT) where
  open Group Time renaming
    ( Carrier to T
    ; e       to eT
    ; _∙_     to _∙T_
    )

  open Bar T _∙T_ eT public
    renaming
      ( dBar to dᵗ
      ; sBar to sᵗ
      )

  -- Time simplices
  TimeSimplex : Nat → Set ℓT
  TimeSimplex n = Vec T n
```

---

## RG bar construction (Nat under +)

```agda
module RGBar where
  open Bar Nat _+_ zero public
    renaming
      ( dBar to dᵘ
      ; sBar to sᵘ
      )

  RGSimplex : Nat → Set
  RGSimplex n = Vec Nat n
```

---

## Bisimplicial grid as a product

For each bidegree `(m,n)` we define
[
\mathsf{Grid}_{m,n} := \mathsf{TimeSimplex}_m \times \mathsf{RGSimplex}_n .
]

Horizontal operators act on the time component; vertical operators act on the RG component.

```agda
module Grid {ℓT : Level} (Time : Group ℓT) where
  open TimeBar Time
  open RGBar

  Grid : Nat → Nat → Set ℓT
  Grid m n = TimeSimplex m × RGSimplex n

  -- Horizontal faces/degeneracies
  dH : ∀ {m n : Nat} → Fin (suc (suc m)) → Grid (suc m) n → Grid m n
  dH i (ts , us) = dᵗ i ts , us

  sH : ∀ {m n : Nat} → Fin (suc m) → Grid m n → Grid (suc m) n
  sH i (ts , us) = sᵗ i ts , us

  -- Vertical faces/degeneracies
  dV : ∀ {m n : Nat} → Fin (suc (suc n)) → Grid m (suc n) → Grid m n
  dV j (ts , us) = ts , dᵘ j us

  sV : ∀ {m n : Nat} → Fin (suc n) → Grid m n → Grid m (suc n)
  sV j (ts , us) = ts , sᵘ j us
```

---

## Trivial commutation lemmas between horizontal and vertical operators

Since `dH/sH` affect only the first component and `dV/sV` only the second,
the mixed commutations hold by definitional equality (hence `refl`).

These lemmas are used later to prove `{Q_t,Q_u}=0` once the alternating-sum
boundary operators are defined in an additive target.

```agda
module GridComm {ℓT : Level} (Time : Group ℓT) where
  open Grid Time

  dH-dV-comm :
    ∀ {m n : Nat} (i : Fin (suc (suc m))) (j : Fin (suc (suc n)))
      (x : Grid (suc m) (suc n)) →
      dH i (dV j x) ≡ dV j (dH i x)
  dH-dV-comm i j (ts , us) = refl

  sH-sV-comm :
    ∀ {m n : Nat} (i : Fin (suc m)) (j : Fin (suc n))
      (x : Grid m n) →
      sH i (sV j x) ≡ sV j (sH i x)
  sH-sV-comm i j (ts , us) = refl

  dH-sV-comm :
    ∀ {m n : Nat} (i : Fin (suc (suc m))) (j : Fin (suc n))
      (x : Grid (suc m) n) →
      dH i (sV j x) ≡ sV j (dH i x)
  dH-sV-comm i j (ts , us) = refl

  dV-sH-comm :
    ∀ {m n : Nat} (i : Fin (suc m)) (j : Fin (suc (suc n)))
      (x : Grid m (suc n)) →
      dV j (sH i x) ≡ sH i (dV j x)
  dV-sH-comm i j (ts , us) = refl
```

---

## Future hook: relating the grid bisimplicial object to the presented grid language

The presented grid language from `Process/Grid/Presentation.agda` has *words* in generators
`τ t` and `ρ u`, quotiented by `≈` (generated by a commuting square rewrite).
A future refinement layer should:

1. Define a normalization map sending any word to a pair `(time-sequence, rg-sequence)`,
2. Prove that `≈`-equivalent words normalize to the same pair,
3. Show that the normalization respects the (bi)simplicial structure.

This module does not implement that normalization; it only names the goal shape.

```agda
module RelateToPresentation
  {ℓT : Level}
  (Time : Group ℓT)
  where

  open import TwoTimes.Process.Grid.Presentation as P
  open Grid Time

  -- Goal (to be implemented later):
  -- A normalization map from process words to “separated” (time, RG) data.
  --
  -- normalize : Proc → Σ Nat (λ m → Σ Nat (λ n → Grid m n))
  --
  -- plus soundness: p ≈ q → normalize p ≡ normalize q
  --
  -- We only declare the types as placeholders once the team decides
  -- what exact normal form / indexing convention (m,n) should be used.

  Normalize : Set
  Normalize = ⊤
```
