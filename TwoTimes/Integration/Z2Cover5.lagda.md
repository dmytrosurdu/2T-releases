# TwoTimes/Integration/Z2Cover5.lagda.md

Batch 6: the canonical **Z₂-cover groupoid** induced by `ω₅`.

Construction (Grothendieck / “twisted product”):

* Objects: `Obj~ = Σ r : R , Bool`
* Morphisms: `(r,b) → (s,c)` are pairs `(p , proof)` where `p : Proc₅ r s`
  and `proof : c ≡ xor b (ω₅ p)`.
* Equality on morphisms forgets the proof component: compare only the base morphisms
  by `≈₅` (and never require proof components to coincide).

This is strictly presentation/setoid style: nothing uses funext, truncation, or cubical features.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Z2Cover5 where

open import Agda.Primitive using (Level; _⊔_; lzero)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)

open import TwoTimes.Prelude.Path using (sym; trans; cong)
open import TwoTimes.Z2.XorLemmas using (xor; xor-assoc; xor-idr; xor-comm; xor-self)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5
import TwoTimes.Integration.Proc5Groupoid as G5

-- --------------------------------------------------------------------------
-- Z₂-cover construction over Proc₅ using ω₅
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open RP5.Inst Time I public
    using (R; Proc₅; _≈₅_; id; _⨟_; inv)

  open Ω5.Inst Time I public
    using (ω₅)

  -- Reuse GroupoidS record and the Proc₅ instantiation.
  open G5 public using (GroupoidS)
  open G5.Inst Time I public
    using (Proc₅G)

  -- Cover objects
  Obj~ : Set (ℓR ⊔ lzero)
  Obj~ = Σ R (λ _ → Bool)

  -- Cover morphisms: base morphism + parity constraint
  Hom~ : Obj~ → Obj~ → Set (ℓT ⊔ ℓR)
  Hom~ x y =
    Σ (Proc₅ (fst x) (fst y)) (λ p → snd y ≡ xor (snd x) (ω₅ p))

  -- Setoid equality on cover morphisms: forget the parity proof component
  infix 2 _≈~_
  record _≈~_ {x y : Obj~} (f g : Hom~ x y) : Set (ℓT ⊔ ℓR) where
    constructor mk≈~
    field
      base≈ : fst f ≈₅ fst g
      dom-parity : snd x ≡ snd x
      cod-parity : snd y ≡ snd y

  open _≈~_ public

  -- Projection functor components
  πObj : Obj~ → R
  πObj = fst

  πHom : ∀ {x y : Obj~} → Hom~ x y → Proc₅ (πObj x) (πObj y)
  πHom = fst

  -- Identity in the cover
  id~ : ∀ (x : Obj~) → Hom~ x x
  id~ (rx , bx) = id rx , proof
    where
      -- ω₅(id r) is definitional false; xor b false = b
      proof : bx ≡ xor bx (ω₅ (id rx))
      proof = sym (xor-idr bx)

  -- Composition in the cover: keep base composition order aligned with ω₅’s xor law.
  --
  -- IMPORTANT: our GroupoidS convention is “do p then q” = (q ∘ p) = (p ⨟ q),
  -- chosen so that ω₅(p ⨟ q) is definitional `xor (ω₅ p) (ω₅ q)` (from Omega5).
  --
  comp~ : ∀ {x y z : Obj~} → Hom~ y z → Hom~ x y → Hom~ x z
  comp~ {x = (rx , bx)} {y = (ry , by)} {z = (rz , bz)} (q , cq) (p , cp) =
    (p ⨟ q) , proof
    where
      -- cp : by ≡ xor bx (ω₅ p)
      -- cq : bz ≡ xor by (ω₅ q)
      --
      -- want: bz ≡ xor bx (ω₅ (p ⨟ q))
      -- and ω₅(p⨟q) definally = xor (ω₅ p) (ω₅ q),
      -- so RHS becomes xor b (xor (ω₅ p) (ω₅ q)).
      --
      -- From cq and cp we rewrite:
      -- d = xor c (ω₅ q)
      --   = xor (xor b (ω₅ p)) (ω₅ q)
      --   = xor b (xor (ω₅ p) (ω₅ q))   by xor-assoc
      --
      proof : bz ≡ xor bx (ω₅ (p ⨟ q))
      proof =
        trans cq
          (trans
            (cong (λ x₁ → xor x₁ (ω₅ q)) cp)
            (trans
              (xor-assoc bx (ω₅ p) (ω₅ q))
              refl))

  -- Inverse in the cover
  inv~ : ∀ {x y : Obj~} → Hom~ x y → Hom~ y x
  inv~ {x = (rx , bx)} {y = (ry , by)} (p , cp) = inv p , proof
    where
      -- cp : by ≡ xor bx (ω₅ p)
      -- Need: bx ≡ xor by (ω₅ (inv p)) = xor by (ω₅ p)
      --
      -- Rewrite using cp:
      -- xor by (ω₅ p) = xor (xor bx (ω₅ p)) (ω₅ p)
      --               = bx   by assoc + b⊕a⊕a=b
      --
      -- We avoid a separate lemma by Boolean case split on ω₅ p.
      proof : bx ≡ xor by (ω₅ (inv p))
      proof with ω₅ p
      ... | false =
        -- cp : by ≡ xor bx false
        -- goal bx ≡ xor by false = by
        trans (trans (sym (xor-idr bx)) (sym cp)) (sym (xor-idr by))
      ... | true =
        -- cp : by ≡ xor bx true
        -- goal bx ≡ xor by true
        let
          xor-cancel-true : ∀ b → xor (xor b true) true ≡ b
          xor-cancel-true b =
            trans (xor-assoc b true true)
              (trans (cong (λ x → xor b x) (xor-self true))
                     (xor-idr b))

          step1 : bx ≡ xor (xor bx true) true
          step1 = sym (xor-cancel-true bx)

          step2 : xor (xor bx true) true ≡ xor by true
          step2 = sym (cong (λ x → xor x true) cp)
        in
        trans step1 step2

  -- --------------------------------------------------------------------------
  -- GroupoidS instance for the cover
  -- --------------------------------------------------------------------------

  -- Laws: we prove them by projecting to the base and using Proc₅G laws.
  -- Proof components are ignored (by construction of ≈~).

  ≈~-refl : ∀ {x y} {f : Hom~ x y} → _≈~_ {x = x} {y = y} f f
  ≈~-refl {x = (rx , bx)} {y = (ry , by)} {f = f} =
    record
      { base≈ = RP5.≈-refl {p = fst f}
      ; dom-parity = refl
      ; cod-parity = refl
      }

  ≈~-sym :
    ∀ {x y} {f g : Hom~ x y} →
    _≈~_ {x = x} {y = y} f g → _≈~_ {x = x} {y = y} g f
  ≈~-sym {x = (rx , bx)} {y = (ry , by)} {f = f} {g = g} h =
    record
      { base≈ = RP5.≈-sym {p = fst f} {q = fst g} (base≈ h)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  ≈~-trans :
    ∀ {x y} {f g h : Hom~ x y} →
    _≈~_ {x = x} {y = y} f g → _≈~_ {x = x} {y = y} g h →
    _≈~_ {x = x} {y = y} f h
  ≈~-trans {x = (rx , bx)} {y = (ry , by)} {f = f} {g = g} {h = h} h₁ h₂ =
    record
      { base≈ =
          RP5.≈-trans {p = fst f} {q = fst g} {u = fst h} (base≈ h₁) (base≈ h₂)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  comp-resp~ :
    ∀ {x y z} {p p' : Hom~ x y} {q q' : Hom~ y z} →
    _≈~_ {x = x} {y = y} p p' →
    _≈~_ {x = y} {y = z} q q' →
    _≈~_ {x = x} {y = z}
      (comp~ {x = x} {y = y} {z = z} q p)
      (comp~ {x = x} {y = y} {z = z} q' p')
  comp-resp~
    {x = (rx , bx)} {y = (ry , by)} {z = (rz , bz)}
    {p = p} {p' = p'} {q = q} {q' = q'} hp hq =
    record
      { base≈ =
          RP5.≈-cong-⨟ {p = fst p} {p' = fst p'} {q = fst q} {q' = fst q'}
            (base≈ hp) (base≈ hq)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  inv-resp~ :
    ∀ {x y} {p q : Hom~ x y} →
    _≈~_ {x = x} {y = y} p q →
    _≈~_ {x = y} {y = x}
      (inv~ {x = x} {y = y} p)
      (inv~ {x = x} {y = y} q)
  inv-resp~ {x = (rx , bx)} {y = (ry , by)} {p = p} {q = q} hp =
    record
      { base≈ = RP5.≈-cong-inv {p = fst p} {q = fst q} (base≈ hp)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  assoc~ :
    ∀ {w x y z} (p : Hom~ w x) (q : Hom~ x y) (r : Hom~ y z) →
    _≈~_ {x = w} {y = z}
      (comp~ {x = w} {y = y} {z = z}
        r
        (comp~ {x = w} {y = x} {z = y} q p))
      (comp~ {x = w} {y = x} {z = z}
        (comp~ {x = x} {y = y} {z = z} r q)
        p)
  assoc~ {w = (rw , bw)} {x = (rx , bx)} {y = (ry , by)} {z = (rz , bz)} p q r =
    record
      { base≈ = RP5.≈-assoc (fst p) (fst q) (fst r)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  idl~ :
    ∀ {x y} (p : Hom~ x y) →
    _≈~_ {x = x} {y = y} (comp~ {x = x} {y = y} {z = y} (id~ y) p) p
  idl~ {x = (rx , bx)} {y = (ry , by)} p =
    record
      { base≈ = RP5.≈-idr (fst p)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  idr~ :
    ∀ {x y} (p : Hom~ x y) →
    _≈~_ {x = x} {y = y} (comp~ {x = x} {y = x} {z = y} p (id~ x)) p
  idr~ {x = (rx , bx)} {y = (ry , by)} p =
    record
      { base≈ = RP5.≈-idl (fst p)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  invL~ :
    ∀ {x y} (p : Hom~ x y) →
    _≈~_ {x = x} {y = x}
      (comp~ {x = x} {y = y} {z = x} (inv~ {x = x} {y = y} p) p)
      (id~ x)
  invL~ {x = (rx , bx)} {y = (ry , by)} p =
    record
      { base≈ = RP5.≈-invR (fst p)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  invR~ :
    ∀ {x y} (p : Hom~ x y) →
    _≈~_ {x = y} {y = y}
      (comp~ {x = y} {y = x} {z = y} p (inv~ {x = x} {y = y} p))
      (id~ y)
  invR~ {x = (rx , bx)} {y = (ry , by)} p =
    record
      { base≈ = RP5.≈-invL (fst p)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  inv-inv~ :
    ∀ {x y} (p : Hom~ x y) →
    _≈~_ {x = x} {y = y}
      (inv~ {x = y} {y = x} (inv~ {x = x} {y = y} p))
      p
  inv-inv~ {x = (rx , bx)} {y = (ry , by)} p =
    record
      { base≈ = RP5.≈-inv-inv (fst p)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  inv-id~ :
    ∀ {x} → _≈~_ {x = x} {y = x} (inv~ {x = x} {y = x} (id~ x)) (id~ x)
  inv-id~ {x = (rx , bx)} =
    record
      { base≈ = RP5.≈-inv-id {r = rx}
      ; dom-parity = refl
      ; cod-parity = refl
      }

  inv-comp~ :
    ∀ {x y z} (p : Hom~ x y) (q : Hom~ y z) →
    _≈~_ {x = z} {y = x}
      (inv~ {x = x} {y = z} (comp~ {x = x} {y = y} {z = z} q p))
      (comp~ {x = z} {y = y} {z = x}
        (inv~ {x = x} {y = y} p)
        (inv~ {x = y} {y = z} q))
  inv-comp~ {x = (rx , bx)} {y = (ry , by)} {z = (rz , bz)} p q =
    record
      { base≈ = RP5.≈-inv-comp (fst p) (fst q)
      ; dom-parity = refl
      ; cod-parity = refl
      }

  Cover5Groupoid : GroupoidS (ℓR ⊔ lzero) (ℓT ⊔ ℓR) (ℓT ⊔ ℓR)
  Cover5Groupoid = record
    { Obj      = Obj~
    ; Hom      = Hom~
    ; _≈_      = λ {x} {y} f g → _≈~_ {x = x} {y = y} f g
    ; id       = λ x → id~ x
    ; _∘_      = λ {x} {y} {z} q p → comp~ {x = x} {y = y} {z = z} q p
    ; inv      = λ {x} {y} p → inv~ {x = x} {y = y} p
    ; ≈-refl   = λ {x} {y} {p} → ≈~-refl {x = x} {y = y} {f = p}
    ; ≈-sym    = λ {x} {y} {p} {q} h → ≈~-sym {x = x} {y = y} {f = p} {g = q} h
    ; ≈-trans  = λ {x} {y} {p} {q} {r} h₁ h₂ →
                   ≈~-trans {x = x} {y = y} {f = p} {g = q} {h = r} h₁ h₂
    ; comp-resp =
        λ {x} {y} {z} {p} {p'} {q} {q'} hp hq →
          comp-resp~ {x = x} {y = y} {z = z} {p = p} {p' = p'} {q = q} {q' = q'} hp hq
    ; inv-resp  =
        λ {x} {y} {p} {q} hp → inv-resp~ {x = x} {y = y} {p = p} {q = q} hp
    ; assoc    = λ {w} {x} {y} {z} p q r → assoc~ {w = w} {x = x} {y = y} {z = z} p q r
    ; idl      = λ {x} {y} p → idl~ {x = x} {y = y} p
    ; idr      = λ {x} {y} p → idr~ {x = x} {y = y} p
    ; invL     = λ {x} {y} p → invL~ {x = x} {y = y} p
    ; invR     = λ {x} {y} p → invR~ {x = x} {y = y} p
    ; inv-inv  = λ {x} {y} p → inv-inv~ {x = x} {y = y} p
    ; inv-id   = λ {x} → inv-id~ {x = x}
    ; inv-comp = λ {x} {y} {z} p q → inv-comp~ {x = x} {y = y} {z = z} p q
    }

  -- --------------------------------------------------------------------------
  -- π as a setoid-functor into Proc₅G (minimal packaging)
  -- --------------------------------------------------------------------------

  π-resp :
    ∀ {x y : Obj~} {f g : Hom~ x y} →
    _≈~_ {x = x} {y = y} f g →
    πHom {x = x} {y = y} f ≈₅ πHom {x = x} {y = y} g
  π-resp {x = (rx , bx)} {y = (ry , by)} h = base≈ h

  π-id :
    ∀ (x : Obj~) →
    πHom {x = x} {y = x} (id~ x) ≈₅ (Proc₅G .GroupoidS.id (πObj x))
  π-id (rx , bx) = RP5.≈-refl {p = id rx}

  π-comp :
    ∀ {x y z : Obj~} (g : Hom~ y z) (f : Hom~ x y) →
    πHom {x = x} {y = z} (comp~ {x = x} {y = y} {z = z} g f) ≈₅
    (Proc₅G .GroupoidS._∘_
      (πHom {x = y} {y = z} g)
      (πHom {x = x} {y = y} f))
  π-comp {x = (rx , bx)} {y = (ry , by)} {z = (rz , bz)} g f =
    RP5.≈-refl {p = fst f ⨟ fst g}

  π-inv : ∀ {x y : Obj~} (f : Hom~ x y) →
          πHom {x = y} {y = x} (inv~ {x = x} {y = y} f) ≈₅
          (Proc₅G .GroupoidS.inv (πHom {x = x} {y = y} f))
  π-inv {x = (rx , bx)} {y = (ry , by)} f = RP5.≈-refl {p = inv (fst f)}

open Inst public
```
