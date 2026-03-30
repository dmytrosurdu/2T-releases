```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Z2.BoolGroup where
```

# The group Z₂ as Bool under xor (Phase I)

This module defines:

* `Z₂` with carrier `Bool`,
* group operation `xor`,
* identity `false`,
* inverse is identity (`inv b = b`),
* and the standard group laws as **goals** (fields), not fully proved.

> **Team note**
>
> The laws are all straightforward by case analysis on Bool. You can either:
>
> * fill them in with explicit pattern matching proofs, or
> * keep them as postulated fields in an interface if you want to stay minimal.
>
> We provide a concrete record `Group` instance with proof obligations
> as `TODO` fields to be completed.

---

## Imports

```agda
open import Agda.Primitive using (Level; lzero; lsuc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
```

---

## Bool xor and basic lemmas

```agda
not : Bool → Bool
not true  = false
not false = true

xor : Bool → Bool → Bool
xor false b = b
xor true  b = not b

-- Handy: involution of not (trivial)
not-invol : ∀ b → not (not b) ≡ b
not-invol true  = refl
not-invol false = refl
```

---

## Group interface (minimal)

```agda
record Group (ℓ : Level) : Set (lsuc ℓ) where
  field
    Carrier : Set ℓ
    e       : Carrier
    _∙_     : Carrier → Carrier → Carrier
    inv     : Carrier → Carrier

    assoc   : ∀ x y z → (x ∙ y) ∙ z ≡ x ∙ (y ∙ z)
    idl     : ∀ x → e ∙ x ≡ x
    idr     : ∀ x → x ∙ e ≡ x
    linv    : ∀ x → (inv x ∙ x) ≡ e
    rinv    : ∀ x → (x ∙ inv x) ≡ e
```

---

## Z₂ as a Group (proof obligations marked as goals)

We define the structure and leave the proofs as explicit goals to fill.

```agda
assoc-xor : ∀ x y z → xor (xor x y) z ≡ xor x (xor y z)
assoc-xor false y z = refl
assoc-xor true  false false = refl
assoc-xor true  false true  = refl
assoc-xor true  true  false = refl
assoc-xor true  true  true  = refl

idl-xor : ∀ x → xor false x ≡ x
idl-xor x = refl

idr-xor : ∀ x → xor x false ≡ x
idr-xor false = refl
idr-xor true  = refl

linv-xor : ∀ x → xor x x ≡ false
linv-xor false = refl
linv-xor true  = refl

rinv-xor : ∀ x → xor x x ≡ false
rinv-xor false = refl
rinv-xor true  = refl
```

```agda
Z₂ : Group lzero
Group.Carrier Z₂ = Bool
Group.e       Z₂ = false
Group._∙_     Z₂ = xor
Group.inv     Z₂ = λ b → b

-- Goals: fill by case analysis on Bool
Group.assoc Z₂ = assoc-xor
Group.idl   Z₂ = idl-xor
Group.idr   Z₂ = idr-xor
Group.linv  Z₂ = linv-xor
Group.rinv  Z₂ = rinv-xor
```

---

## Two-element torsor action primitive (optional utility)

Often we only need the generating involution `flip : X → X` with `flip ∘ flip = id`.

```agda
flip : Bool → Bool
flip = not

flip-invol : ∀ b → flip (flip b) ≡ b
flip-invol = not-invol
```
