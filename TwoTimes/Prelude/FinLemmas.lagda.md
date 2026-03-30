```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Prelude.FinLemmas where
```

# Fin utilities (Phase I)

This module provides a small, dependency-light lemma library for the `Fin`
type used in `TwoTimes.Process.Grid.Nerve`.

Batch 3 needs predictable tools for:

* embedding `Fin n → Fin (suc n)`,
* predecessor on nonzero indices,
* a minimal `<` relation and basic lemmas,
* `Fin → Nat` conversion and a few facts.

No stdlib is used.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Prelude.Path
open import TwoTimes.Process.Grid.Nerve using (Fin; fzero; fsuc)
```

---

## Minimal empty type

```agda
data ⊥ : Set where

⊥-elim : ∀ {A : Set} → ⊥ → A
⊥-elim ()
```

---

## Basic constructors: embedding and conversion to Nat

```agda
-- Embed Fin n into Fin (suc n)
raise : ∀ {n : Nat} → Fin n → Fin (suc n)
raise = fsuc

-- Convert Fin n to Nat (forget the bound)
finToNat : ∀ {n : Nat} → Fin n → Nat
finToNat {suc n} fzero    = zero
finToNat {suc n} (fsuc i) = suc (finToNat i)

finToNat-raise : ∀ {n : Nat} (i : Fin n) → finToNat (raise i) ≡ suc (finToNat i)
finToNat-raise i = refl
```

---

## A tiny Maybe type (for partial predecessor)

```agda
data Maybe {ℓ : Level} (A : Set ℓ) : Set ℓ where
  nothing : Maybe A
  just    : A → Maybe A
```

```agda
-- Partial predecessor: undefined at 0
predFin? : ∀ {n : Nat} → Fin (suc n) → Maybe (Fin n)
predFin? fzero    = nothing
predFin? (fsuc i) = just i
```

---

## Equality discrimination helpers for Fin

```agda
fzero≠fsuc : ∀ {n : Nat} {i : Fin n} → fzero ≡ fsuc i → ⊥
fzero≠fsuc ()

fsuc≠fzero : ∀ {n : Nat} {i : Fin n} → fsuc i ≡ fzero → ⊥
fsuc≠fzero ()

fsuc-injective : ∀ {n : Nat} {i j : Fin n} → fsuc i ≡ fsuc j → i ≡ j
fsuc-injective refl = refl
```

---

## A minimal strict order on Fin

We use the standard inductive definition:

* `fzero < fsuc j`
* and `fsuc i < fsuc j` if `i < j`.

```agda
infix 4 _<_
data _<_ : ∀ {n : Nat} → Fin n → Fin n → Set where
  z<s : ∀ {n : Nat} {j : Fin n} → fzero < fsuc j
  s<s : ∀ {n : Nat} {i j : Fin n} → i < j → fsuc i < fsuc j
```

### Basic facts

```agda
-- No index is strictly less than itself.
<-irrefl : ∀ {n : Nat} {i : Fin n} → i < i → ⊥
<-irrefl {i = fzero}    ()
<-irrefl {i = fsuc i} (s<s p) = <-irrefl p

-- Transitivity.
<-trans : ∀ {n : Nat} {i j k : Fin n} → i < j → j < k → i < k
<-trans z<s (s<s _) = z<s
<-trans (s<s p) (s<s q) = s<s (<-trans p q)

-- Monotonicity under fsuc.
<-fsuc : ∀ {n : Nat} {i j : Fin n} → i < j → fsuc i < fsuc j
<-fsuc = s<s

-- Inversion under fsuc.
<-fsuc-inv : ∀ {n : Nat} {i j : Fin n} → fsuc i < fsuc j → i < j
<-fsuc-inv (s<s p) = p
```

---

## Predecessor under a proof of nonzero

When `j : Fin (suc n)` is known to be nonzero (i.e. `fzero < j`), then `j` must be
`fsuc k` and we can extract the predecessor `k : Fin n`.

This is the `pred` operation needed for the classical face identity
`d i (d j x) = d (pred j) (d i x)` (when phrased with `<`).

```agda
predNonzero : ∀ {n : Nat} (j : Fin (suc n)) → fzero < j → Fin n
predNonzero fzero    ()
predNonzero (fsuc k) _ = k

predNonzero-β : ∀ {n : Nat} (k : Fin n) → predNonzero (fsuc k) z<s ≡ k
predNonzero-β k = refl
```

---

## A simple case splitter for Fin (often useful in proofs)

```agda
caseFin
  : ∀ {n : Nat} {P : Fin (suc n) → Set}
    → P fzero
    → (∀ k → P (fsuc k))
    → ∀ i → P i
caseFin p0 ps fzero    = p0
caseFin p0 ps (fsuc k) = ps k

-- Insert an index into a larger Fin by “skipping” a position.
-- (The standard punch-in operation.)
punchIn : ∀ {n : Nat} → Fin (suc n) → Fin n → Fin (suc n)
punchIn fzero    j        = fsuc j
punchIn (fsuc i) fzero    = fzero
punchIn (fsuc i) (fsuc j) = fsuc (punchIn i j)

-- Inverse to punchIn (partial): remove i from a larger Fin.
punchOut? : ∀ {n : Nat} → (i : Fin (suc n)) → Fin (suc n) → Maybe (Fin n)
punchOut? fzero    fzero    = nothing
punchOut? fzero    (fsuc k) = just k
punchOut? {n = suc n} (fsuc i) fzero = just fzero
punchOut? {n = suc n} (fsuc i) (fsuc k) with punchOut? i k
... | nothing = nothing
... | just j  = just (fsuc j)

punchOut?-punchIn :
  ∀ {n : Nat} (i : Fin (suc n)) (j : Fin n) →
  punchOut? i (punchIn i j) ≡ just j
punchOut?-punchIn fzero j = refl
punchOut?-punchIn (fsuc i) fzero = refl
punchOut?-punchIn (fsuc i) (fsuc j) with punchOut?-punchIn i j
... | ih rewrite ih = refl

punchIn-punchOut? :
  ∀ {n : Nat} (i : Fin (suc n)) (k : Fin (suc n)) (j : Fin n) →
  punchOut? i k ≡ just j →
  punchIn i j ≡ k
punchIn-punchOut? fzero fzero j ()
punchIn-punchOut? fzero (fsuc k) .k refl = refl
punchIn-punchOut? {n = suc n} (fsuc i) fzero .fzero refl = refl
punchIn-punchOut? {n = suc n} (fsuc i) (fsuc k) j eq with punchOut? i k in eqik | eq
... | nothing | ()
... | just j' | refl =
  cong fsuc (punchIn-punchOut? i k j' eqik)
```
