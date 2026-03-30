```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Algebra.Sign where
```

# Bool signs and parity (Phase I)

This module provides the Bool-based sign action used throughout Batch 3:

* `sgn b x` is either `x` (if `b = false`) or `- x` (if `b = true`),
* basic algebraic lemmas for distributing `sgn` over `+`,
* composition via `xor`,
* a Nat parity function `parity : Nat → Bool`,
* and the key “Koszul shift” helper in Bool form.

Everything is non-cubical and `--safe`.

---

## Imports

```agda
open import Agda.Primitive using (Level)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Prelude.Path
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup)
```

---

## Bool operations

```agda
not : Bool → Bool
not false = true
not true  = false

xor : Bool → Bool → Bool
xor false b = b
xor true  b = not b

not-invol : ∀ b → not (not b) ≡ b
not-invol false = refl
not-invol true  = refl
```

---

## Parity on Nat

We use the convention: `parity n = false` means “even”, `true` means “odd”.

```agda
parity : Nat → Bool
parity zero    = false
parity (suc n) = not (parity n)

pred : Nat → Nat
pred zero    = zero
pred (suc n) = n

parity-suc : ∀ n → parity (suc n) ≡ not (parity n)
parity-suc n = refl

parity-pred-suc : ∀ n → parity (pred (suc n)) ≡ not (parity (suc n))
parity-pred-suc n =
  -- LHS reduces to parity n, RHS reduces to not (not (parity n))
  sym (cong not (parity-suc n) ∙ not-invol (parity n))

parity-pred-suc' : ∀ n → parity n ≡ not (parity (suc n))
parity-pred-suc' n = parity-pred-suc n
```

---

## Sign action in an abelian group

```agda
sgn : ∀ {ℓ : Level} (G : AbGroup ℓ) → Bool → AbGroup.Carrier G → AbGroup.Carrier G
sgn G false x = x
sgn G true  x = AbGroup.-_ G x
```

### Basic lemmas

All lemmas are proven by Bool case analysis, using only the derived abelian-group
lemmas from `AbGroupLemmas` (notably `neg-distrib-+`, `neg-0`, and `neg-invol`).

```agda
sgn-false : ∀ {ℓ} (G : AbGroup ℓ) (x : AbGroup.Carrier G) → sgn G false x ≡ x
sgn-false G x = refl

sgn-true : ∀ {ℓ} (G : AbGroup ℓ) (x : AbGroup.Carrier G) → sgn G true x ≡ AbGroup.-_ G x
sgn-true G x = refl

sgn-0 : ∀ {ℓ} (G : AbGroup ℓ) (b : Bool) → sgn G b (AbGroup.0# G) ≡ AbGroup.0# G
sgn-0 G false = refl
sgn-0 G true  =
  let open FAE.AbGroupLemmas G in
  neg-0

sgn-+ :
  ∀ {ℓ} (G : AbGroup ℓ) (b : Bool)
    (x y : AbGroup.Carrier G) →
  sgn G b (AbGroup._+_ G x y) ≡ AbGroup._+_ G (sgn G b x) (sgn G b y)
sgn-+ G false x y = refl
sgn-+ G true  x y =
  let open FAE.AbGroupLemmas G in
  neg-distrib-+ x y

sgn-neg :
  ∀ {ℓ} (G : AbGroup ℓ) (b : Bool)
    (x : AbGroup.Carrier G) →
  sgn G b (AbGroup.-_ G x) ≡ AbGroup.-_ G (sgn G b x)
sgn-neg G false x = refl
sgn-neg G true  x = refl

sgn-invol :
  ∀ {ℓ} (G : AbGroup ℓ) (b : Bool)
    (x : AbGroup.Carrier G) →
  sgn G b (sgn G b x) ≡ x
sgn-invol G false x = refl
sgn-invol G true  x =
  let open FAE.AbGroupLemmas G in
  neg-invol x

sgn-xor :
  ∀ {ℓ} (G : AbGroup ℓ) (b c : Bool)
    (x : AbGroup.Carrier G) →
  sgn G (xor b c) x ≡ sgn G b (sgn G c x)
sgn-xor G false c x = refl
sgn-xor G true  false x = refl
sgn-xor G true  true  x =
  -- LHS: sgn false x = x
  -- RHS: sgn true (sgn true x) = -(-x) = x
  sym (sgn-invol G true x)

sgn-not :
  ∀ {ℓ} (G : AbGroup ℓ) (b : Bool)
    (x : AbGroup.Carrier G) →
  sgn G (not b) x ≡ AbGroup.-_ G (sgn G b x)
sgn-not G false x = refl
sgn-not G true  x =
  let open FAE.AbGroupLemmas G in
  sym (neg-invol x)
```

---

## Koszul shift helper (Bool-based)

This is the exact “degree drops by 1 flips the Koszul sign” statement needed for
anticommutation proofs: for `m = suc n`, the parity at `pred m` is `not` the parity
at `m`, so the corresponding sign action differs by a negation.

```agda
koszulShift :
  ∀ {ℓ} (G : AbGroup ℓ) (n : Nat) (x : AbGroup.Carrier G) →
  sgn G (parity (pred (suc n))) x ≡ AbGroup.-_ G (sgn G (parity (suc n)) x)
koszulShift G n x =
  -- parity (pred (suc n)) = not (parity (suc n))
  cong (λ b → sgn G b x) (parity-pred-suc n)
  ∙ sgn-not G (parity (suc n)) x
```
