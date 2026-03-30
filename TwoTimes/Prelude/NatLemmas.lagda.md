```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Prelude.NatLemmas where
```

# Nat lemmas (Phase I)

Small lemma library for `Nat`, intended for Batch 3 sign bookkeeping and
index arithmetic. No stdlib.

---

## Imports

```agda
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import TwoTimes.Prelude.Path
open import TwoTimes.Algebra.Sign using (not; not-invol; parity; parity-suc; xor)
```

---

## Local addition and its basic laws

We define `_+_` locally to avoid importing additional modules, and provide
associativity and unit laws (needed frequently when massaging degrees).

```agda
infixl 6 _+_
_+_ : Nat → Nat → Nat
zero  + n = n
suc m + n = suc (m + n)

+-zeroL : ∀ n → zero + n ≡ n
+-zeroL n = refl

+-zeroR : ∀ n → n + zero ≡ n
+-zeroR zero    = refl
+-zeroR (suc n) = cong suc (+-zeroR n)

+-sucR : ∀ m n → m + suc n ≡ suc (m + n)
+-sucR zero    n = refl
+-sucR (suc m) n = cong suc (+-sucR m n)

+-assoc : ∀ a b c → (a + b) + c ≡ a + (b + c)
+-assoc zero    b c = refl
+-assoc (suc a) b c = cong suc (+-assoc a b c)
```

---

## Predecessor and simple properties

```agda
pred : Nat → Nat
pred zero    = zero
pred (suc n) = n

pred-suc : ∀ n → pred (suc n) ≡ n
pred-suc n = refl

pred-zero : pred zero ≡ zero
pred-zero = refl
```

---

## Bool utilities and evenness test

Batch 3 uses Bool-based signs, so we expose a minimal `xor` and an evenness
test derived from `TwoTimes.Algebra.Sign.parity` (true = even).

```agda
-- Evenness: true = even, derived from parity (false = even, true = odd).
isEven : Nat → Bool
isEven n = not (parity n)

xor-idl : ∀ b → xor false b ≡ b
xor-idl b = refl

xor-idr : ∀ b → xor b false ≡ b
xor-idr false = refl
xor-idr true  = refl
```

### Evenness shift lemmas

These are the core identities used to relate `(-1)^{m}` and `(-1)^{pred m}`.

```agda
isEven-suc : ∀ n → isEven (suc n) ≡ not (isEven n)
isEven-suc n = cong not (parity-suc n)

isEven-pred-suc : ∀ n → isEven (pred (suc n)) ≡ isEven n
isEven-pred-suc n = refl

-- For m = suc n: parity(pred m) = parity m flipped.
-- (This is the Bool-level version of (-1)^{m-1} = -(-1)^m.)
isEven-pred-flip : ∀ n → isEven (pred (suc n)) ≡ not (isEven (suc n))
isEven-pred-flip n =
  sym (not-invol (isEven n)) ∙ cong not (sym (isEven-suc n))
```

---

## A tiny “≤” and a couple of helper lemmas (optional but useful)

Some Batch 3 proofs want to do recursion on bounds.

```agda
infix 4 _≤_
data _≤_ : Nat → Nat → Set where
  z≤n : ∀ {n} → zero ≤ n
  s≤s : ∀ {m n} → m ≤ n → suc m ≤ suc n

≤-refl : ∀ n → n ≤ n
≤-refl zero    = z≤n
≤-refl (suc n) = s≤s (≤-refl n)

≤-trans : ∀ {a b c} → a ≤ b → b ≤ c → a ≤ c
≤-trans z≤n       _          = z≤n
≤-trans (s≤s p) (s≤s q) = s≤s (≤-trans p q)
```
