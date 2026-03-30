# TwoTimes/Integration/Proc5Groupoid.lagda.md

This module packages a **presented process theory** as a **setoid-enriched groupoid**
(“setoid groupoid”): morphisms are raw syntax, equipped with an explicit equivalence
relation `≈` respected by composition and inversion.

For Batch 6 we will instantiate this interface for:

* objects: `R`
* morphisms: `Proc₅ r s`
* equality: `≈₅`

and we will use the resulting `Proc₅G` throughout the Z₂-cover construction.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Proc5Groupoid where

open import Agda.Primitive using (Level; _⊔_; lsuc)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5

-- --------------------------------------------------------------------------
-- Setoid groupoid interface (groupoid presented by generators/relations)
-- --------------------------------------------------------------------------

record GroupoidS (ℓObj ℓHom ℓ≈ : Level) : Set (lsuc (ℓObj ⊔ ℓHom ⊔ ℓ≈)) where
  infixr 9 _∘_
  infix  4 _≈_

  field
    Obj : Set ℓObj
    Hom : Obj → Obj → Set ℓHom

    _≈_ : ∀ {x y : Obj} → Hom x y → Hom x y → Set ℓ≈

    -- Equivalence structure (per hom-set)
    ≈-refl  : ∀ {x y} {p : Hom x y} → p ≈ p
    ≈-sym   : ∀ {x y} {p q : Hom x y} → p ≈ q → q ≈ p
    ≈-trans : ∀ {x y} {p q r : Hom x y} → p ≈ q → q ≈ r → p ≈ r

    -- Operations (composition is *right-to-left*: “do p then q” = q ∘ p)
    id  : ∀ (x : Obj) → Hom x x
    _∘_ : ∀ {x y z : Obj} → Hom y z → Hom x y → Hom x z
    inv : ∀ {x y : Obj} → Hom x y → Hom y x

    -- Respect for ≈ (well-definedness on the presented equality)
    comp-resp : ∀ {x y z} {p p' : Hom x y} {q q' : Hom y z} →
                p ≈ p' → q ≈ q' → (q ∘ p) ≈ (q' ∘ p')
    inv-resp  : ∀ {x y} {p q : Hom x y} → p ≈ q → inv p ≈ inv q

    -- Groupoid laws up to ≈
    assoc : ∀ {w x y z}
              (p : Hom w x) (q : Hom x y) (r : Hom y z) →
              (r ∘ (q ∘ p)) ≈ ((r ∘ q) ∘ p)

    idl   : ∀ {x y} (p : Hom x y) → (id y ∘ p) ≈ p
    idr   : ∀ {x y} (p : Hom x y) → (p ∘ id x) ≈ p
    invL  : ∀ {x y} (p : Hom x y) → (inv p ∘ p) ≈ id x
    invR  : ∀ {x y} (p : Hom x y) → (p ∘ inv p) ≈ id y

    inv-inv  : ∀ {x y} (p : Hom x y) → inv (inv p) ≈ p
    inv-id   : ∀ {x} → inv (id x) ≈ id x
    inv-comp : ∀ {x y z} (p : Hom x y) (q : Hom y z) →
               inv (q ∘ p) ≈ (inv p ∘ inv q)

open GroupoidS public

-- --------------------------------------------------------------------------
-- Functors between setoid groupoids (used for the Z₂-cover projection)
-- --------------------------------------------------------------------------

record FunctorS
  {ℓObjA ℓHomA ℓ≈A ℓObjB ℓHomB ℓ≈B : Level}
  (A : GroupoidS ℓObjA ℓHomA ℓ≈A)
  (B : GroupoidS ℓObjB ℓHomB ℓ≈B)
  : Set (lsuc (ℓObjA ⊔ ℓHomA ⊔ ℓ≈A ⊔ ℓObjB ⊔ ℓHomB ⊔ ℓ≈B)) where

  open GroupoidS A renaming (Obj to ObjA; Hom to HomA; _≈_ to _≈A_;
                             id to idA; _∘_ to _∘A_; inv to invA)
  open GroupoidS B renaming (Obj to ObjB; Hom to HomB; _≈_ to _≈B_;
                             id to idB; _∘_ to _∘B_; inv to invB)

  field
    onObj : ObjA → ObjB
    onHom : ∀ {x y : ObjA} → HomA x y → HomB (onObj x) (onObj y)

    resp≈ : ∀ {x y} {p q : HomA x y} → p ≈A q → onHom p ≈B onHom q

    onId  : ∀ (x : ObjA) → onHom (idA x) ≈B idB (onObj x)
    onComp : ∀ {x y z : ObjA} (q : HomA y z) (p : HomA x y) →
             onHom (q ∘A p) ≈B (onHom q ∘B onHom p)
    onInv : ∀ {x y : ObjA} (p : HomA x y) →
            onHom (invA p) ≈B invB (onHom p)

open FunctorS public

-- --------------------------------------------------------------------------
-- Instantiation for Proc₅ (Batch 6: base groupoid)
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open RP5.Inst Time I public
    using (R; Proc₅; _≈₅_; _⨟_)
    renaming (id to id₅; inv to inv₅)

  -- Composition direction note:
  -- We take GroupoidS composition to be *right-to-left* and set it so that
  --   q ∘ p = p ⨟ q,
  -- hence ω₅ (q ∘ p) = xor (ω₅ p) (ω₅ q) definitionally.

  Proc₅G : GroupoidS ℓR (ℓT ⊔ ℓR) (ℓT ⊔ ℓR)
  Proc₅G .GroupoidS.Obj = R
  Proc₅G .GroupoidS.Hom = Proc₅
  Proc₅G .GroupoidS._≈_ = _≈₅_

  Proc₅G .GroupoidS.≈-refl = RP5.≈-refl
  Proc₅G .GroupoidS.≈-sym = RP5.≈-sym
  Proc₅G .GroupoidS.≈-trans = RP5.≈-trans

  Proc₅G .GroupoidS.id = id₅
  Proc₅G .GroupoidS._∘_ = λ q p → p ⨟ q
  Proc₅G .GroupoidS.inv = inv₅

  Proc₅G .GroupoidS.comp-resp = RP5.≈-cong-⨟
  Proc₅G .GroupoidS.inv-resp  = RP5.≈-cong-inv

  Proc₅G .GroupoidS.assoc = RP5.≈-assoc
  Proc₅G .GroupoidS.idl   = RP5.≈-idr
  Proc₅G .GroupoidS.idr   = RP5.≈-idl
  Proc₅G .GroupoidS.invL  = RP5.≈-invR
  Proc₅G .GroupoidS.invR  = RP5.≈-invL
  Proc₅G .GroupoidS.inv-inv  = RP5.≈-inv-inv
  Proc₅G .GroupoidS.inv-id   = RP5.≈-inv-id
  Proc₅G .GroupoidS.inv-comp = RP5.≈-inv-comp

open Inst public
```
