```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Z2.BZ2 where
```

# The delooping groupoid BZ₂ (one-object groupoid with Bool morphisms)

This module defines a minimal *one-object groupoid* representation of `BZ₂`:

* objects: `⊤` (one object),
* morphisms: `Bool` (to be interpreted as elements of Z₂),
* composition: `xor`,
* identity: `false`,
* inverse: identity (`inv b = b`).

We package the structure as a `Groupoid` record with laws as **goals**.

> **Team note**
>
> * The laws reduce to the Bool xor group laws.
> * You can either fill the goals directly, or import the completed
>   `TwoTimes.Z2.BoolGroup` instance and reuse its proofs.

---

## Imports

```agda
open import Agda.Primitive using (Level; lzero; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Unit using (⊤; tt)
open import Agda.Builtin.Bool using (Bool; true; false)

open import TwoTimes.Prelude.Path
open import TwoTimes.Z2.BoolGroup using (xor; not; flip; not-invol; assoc-xor; idl-xor; idr-xor; linv-xor; rinv-xor)
```

---

## Minimal groupoid interface

We use a strict (1-)groupoid record: hom types, composition, identity, and inverse,
with unit/assoc/inverse laws as equalities.

```agda
record Groupoid (ℓObj ℓHom : Level) : Set (lsuc (ℓObj ⊔ ℓHom)) where
  field
    Obj   : Set ℓObj
    Hom   : Obj → Obj → Set ℓHom

    id    : ∀ {x} → Hom x x
    _∘_   : ∀ {x y z} → Hom y z → Hom x y → Hom x z
    inv   : ∀ {x y} → Hom x y → Hom y x

    assoc : ∀ {w x y z} (h₃ : Hom y z) (h₂ : Hom x y) (h₁ : Hom w x) →
            (h₃ ∘ h₂) ∘ h₁ ≡ h₃ ∘ (h₂ ∘ h₁)

    idl   : ∀ {x y} (h : Hom x y) → id ∘ h ≡ h
    idr   : ∀ {x y} (h : Hom x y) → h ∘ id ≡ h

    linv  : ∀ {x y} (h : Hom x y) → (inv h ∘ h) ≡ id
    rinv  : ∀ {x y} (h : Hom x y) → (h ∘ inv h) ≡ id

open Groupoid
```

---

## BZ₂ definition

```agda
BZ₂ : Groupoid lzero lzero
Obj BZ₂ = ⊤
Hom BZ₂ _ _ = Bool

id  BZ₂ = false
_∘_ BZ₂ h₂ h₁ = xor h₁ h₂      -- NOTE: right-to-left composition convention
inv BZ₂ h = h

-- Goals: xor associativity/unit/inverse laws
assoc BZ₂ h₃ h₂ h₁ = sym (assoc-xor h₁ h₂ h₃)
idl   BZ₂ h = idr-xor h
idr   BZ₂ h = idl-xor h
linv  BZ₂ h = linv-xor h
rinv  BZ₂ h = rinv-xor h
```

> **Orientation note**
>
> We defined `_∘_` as `xor h₁ h₂` so that `(h₂ ∘ h₁)` corresponds to “do h₁ then h₂”.
> If you prefer `xor h₂ h₁` instead, adjust the proofs accordingly.
