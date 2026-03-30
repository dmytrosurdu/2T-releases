# TwoTimes/Diff/CofiberIso.lagda.md

Batch 7 (D7.3): derive an `Iso (Cofiber f)` from square isomorphism data on a map
`f : A → B`, using **cofiber induction** and the **β-glue computation** for
`Cofiber-map`.

This module is intentionally structured to:

* define the **forward/backward cofiber maps** induced by the square data,
* package the two inverse laws as a goal record (`CofiberIsoWitness`),
* and provide a constructor `witness→Iso` turning such a witness into an `Iso`.

> The proof team will construct `CofiberIsoWitness` using `Cofiber-ind` and
> `Cofiber-map-β-glue` from `TwoTimes.Diff.CofiberInd`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Diff.CofiberIso where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Prelude.Path using (sym; trans; cong; subst; _∙_)
open import TwoTimes.Prelude.IsSet using (isSet; uip)

import TwoTimes.HIT.PushoutIndIF as PI
import TwoTimes.Diff.CofiberInd as CI
```

## Minimal `Iso` record (map + inverse laws)

```agda
record Iso {ℓ : Level} (X : Set ℓ) : Set (lsuc ℓ) where
  field
    f g : X → X
    fg : ∀ x → f (g x) ≡ x
    gf : ∀ x → g (f x) ≡ x
```

## Square isomorphism data over `f : A → B`

We use the standard shape:

* `αIso : Iso A` on the domain,
* `βIso : Iso B` on the codomain,
* commuting squares for forward and backward directions.

```agda
record SquareIsoData {ℓ : Level} {A B : Set ℓ} (f : A → B) : Set (lsuc ℓ) where
  field
    αIso : Iso A
    βIso : Iso B

    commF : ∀ a → Iso.f βIso (f a) ≡ f (Iso.f αIso a)
    commG : ∀ a → Iso.g βIso (f a) ≡ f (Iso.g αIso a)
```

## Main construction (parameterized by `PushoutIndIF`)

```agda
module Inst {ℓ : Level}
  (H : PI.PushoutIndIF ℓ)
  {A B : Set ℓ}
  -- We need isSet B to identify parallel proofs in B (glue-case triangles).
  (BIsSet : isSet B)
  (f : A → B)
  (D : SquareIsoData f)
  where

  module C = CI.Inst {ℓ = ℓ} H
  open C public using (Cofiber; cf-in; cf-base; cf-glue)

  open SquareIsoData D
  open Iso αIso renaming (f to αf; g to αg; fg to αfg; gf to αgf)
  open Iso βIso renaming (f to βf; g to βg; fg to βfg; gf to βgf)

  uipB : ∀ {x y : B} (p q : x ≡ y) → p ≡ q
  uipB = uip BIsSet

  -- Forward and backward induced cofiber endomorphisms.
  --
  -- These are definable immediately via Cofiber-map.
  Fwd : Cofiber f → Cofiber f
  Fwd = C.Cofiber-map f f αf βf commF

  Bwd : Cofiber f → Cofiber f
  Bwd = C.Cofiber-map f f αg βg commG

  -- Goal package: the inverse laws for Fwd/Bwd on the cofiber.
  --
  -- Proof route (team task):
  --   - prove fg by Cofiber-ind on x
  --       * in-case: use Cofiber-map-β-in twice + βIso/αIso inverse laws + commF/commG
  --       * base-case: use Cofiber-map-β-base twice
  --       * glue-case: use Cofiber-map-β-glue (whiskered) for both maps, then reduce
  --   - similarly for gf.
  record CofiberIsoWitness : Set (lsuc ℓ) where
    field
      fgC : ∀ x → Fwd (Bwd x) ≡ x
      gfC : ∀ x → Bwd (Fwd x) ≡ x

  -- Turn a witness into an Iso structure.
  witness→Iso : CofiberIsoWitness → Iso (Cofiber f)
  Iso.f  (witness→Iso w) = Fwd
  Iso.g  (witness→Iso w) = Bwd
  Iso.fg (witness→Iso w) = CofiberIsoWitness.fgC w
  Iso.gf (witness→Iso w) = CofiberIsoWitness.gfC w

  -- The Batch 7 target theorem statement (to be implemented by the proof team):
  --
  -- cofiberIsoFromSquareIsoData :
  --   CofiberIsoWitness
  --
  -- After constructing the witness, define:
  --
  --   cofiberIsoFromSquareIsoData-iso : Iso (Cofiber f)
  --   cofiberIsoFromSquareIsoData-iso = witness→Iso cofiberIsoFromSquareIsoData
  --
  -- This avoids any need for function extensionality; all equalities are pointwise.

  cofiberIsoFromSquareIsoData : CofiberIsoWitness
  cofiberIsoFromSquareIsoData = record { fgC = fgC ; gfC = gfC }
    where
    assoc :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w : A}
        (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) →
        (p ∙ q) ∙ r ≡ p ∙ (q ∙ r)
    assoc refl q r = refl

    assoc-4 :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w v : A}
        (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) (s : w ≡ v) →
        p ∙ (q ∙ r ∙ s) ≡ p ∙ q ∙ r ∙ s
    assoc-4 p q r s =
      cong (λ t → p ∙ t) (assoc q r s)
      ∙ sym (assoc p q (r ∙ s))
      ∙ sym (assoc (p ∙ q) r s)

    assoc-5 :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w v u : A}
        (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) (s : w ≡ v) (t : v ≡ u) →
        p ∙ (q ∙ r ∙ s ∙ t) ≡ p ∙ q ∙ r ∙ s ∙ t
    assoc-5 refl q r s t = refl

    ∙-idr :
      ∀ {ℓA : Level} {A : Set ℓA} {x y : A}
        (p : x ≡ y) → p ∙ refl ≡ p
    ∙-idr refl = refl

    sym-∙-cancel :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z : A}
        (p : x ≡ y) (q : y ≡ z) →
        sym p ∙ (p ∙ q) ≡ q
    sym-∙-cancel refl q = refl

    sym-∙-cancel-triple :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w : A}
        (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) →
        sym p ∙ p ∙ q ∙ r ≡ q ∙ r
    sym-∙-cancel-triple refl q r = refl

    sym-∙-cancel-mid :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w v : A}
        (p : x ≡ z) (q : y ≡ z) (r : z ≡ w) (s : w ≡ v) →
        p ∙ sym q ∙ q ∙ r ∙ s ≡ p ∙ r ∙ s
    sym-∙-cancel-mid p refl r s =
      cong (λ t → t ∙ r ∙ s) (assoc p refl refl ∙ ∙-idr p)

    ∙-sym-cancel :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z : A}
        (p : x ≡ y) (q : x ≡ z) →
        (p ∙ sym p) ∙ q ≡ q
    ∙-sym-cancel refl q = refl

    sym-∙ :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z : A}
        (p : x ≡ y) (q : y ≡ z) →
        sym (p ∙ q) ≡ sym q ∙ sym p
    sym-∙ refl refl = refl

    sym-∙-triple :
      ∀ {ℓA : Level} {A : Set ℓA} {x y z w : A}
        (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) →
        sym (p ∙ q ∙ r) ≡ sym r ∙ sym q ∙ sym p
    sym-∙-triple refl refl refl = refl

    sym-sym :
      ∀ {ℓA : Level} {A : Set ℓA} {x y : A}
        (p : x ≡ y) → sym (sym p) ≡ p
    sym-sym refl = refl

    cong-id :
      ∀ {ℓA : Level} {A : Set ℓA} {x y : A} (p : x ≡ y) →
      cong (λ z → z) p ≡ p
    cong-id refl = refl

    cong-∙ :
      ∀ {ℓA ℓB : Level} {A : Set ℓA} {B : Set ℓB}
        (f : A → B) {x y z : A} (p : x ≡ y) (q : y ≡ z) →
        cong f (p ∙ q) ≡ cong f p ∙ cong f q
    cong-∙ f refl q = refl

    cong-∙-triple :
      ∀ {ℓA ℓB : Level} {A : Set ℓA} {B : Set ℓB}
        (f : A → B) {x y z w : A} (p : x ≡ y) (q : y ≡ z) (r : z ≡ w) →
        cong f (p ∙ q ∙ r) ≡ cong f p ∙ cong f q ∙ cong f r
    cong-∙-triple f p q r =
      cong-∙ f (p ∙ q) r
      ∙ cong (λ t → t ∙ cong f r) (cong-∙ f p q)

    cong-sym :
      ∀ {ℓA ℓB : Level} {A : Set ℓA} {B : Set ℓB}
        (f : A → B) {x y : A} (p : x ≡ y) →
        cong f (sym p) ≡ sym (cong f p)
    cong-sym f refl = refl

    cong-comp :
      ∀ {ℓA ℓB ℓC : Level} {A : Set ℓA} {B : Set ℓB} {C : Set ℓC}
        (f : B → C) (g : A → B) {x y : A} (p : x ≡ y) →
        cong (λ x → f (g x)) p ≡ cong f (cong g p)
    cong-comp f g refl = refl

    subst-≡ :
      ∀ {ℓA ℓB : Level} {A : Set ℓA} {B : Set ℓB}
        (f g : A → B) {x y : A} (p : x ≡ y) (q : f x ≡ g x) →
        subst (λ z → f z ≡ g z) p q ≡ sym (cong f p) ∙ q ∙ cong g p
    subst-≡ f g refl q = sym (∙-idr q)

    bwd-rearrange :
      ∀ a →
      sym (cong Bwd (cf-glue a))
      ∙ C.Cofiber-map-β-in f f αg βg commG (f a)
      ≡
      C.Cofiber-map-β-base f f αg βg commG
      ∙ sym (cong cf-in (commG a) ∙ cf-glue (αg a))
    bwd-rearrange a =
      let
        p = cf-glue a
        βinB = C.Cofiber-map-β-in f f αg βg commG (f a)
        βbaseB = C.Cofiber-map-β-base f f αg βg commG
        hB = cong cf-in (commG a) ∙ cf-glue (αg a)
        glueB = C.Cofiber-map-β-glue f f αg βg commG a
        step1 : sym hB ≡ sym βbaseB ∙ sym (cong Bwd p) ∙ βinB
        step1 =
          sym (cong sym glueB)
          ∙ sym-∙-triple (sym βinB) (cong Bwd p) βbaseB
          ∙ cong (λ t → sym βbaseB ∙ sym (cong Bwd p) ∙ t) (sym-sym βinB)
        step2 :
          βbaseB ∙ sym hB ≡ sym (cong Bwd p) ∙ βinB
        step2 =
          cong (λ r → βbaseB ∙ r) step1
          ∙ cong (λ r → βbaseB ∙ r) (assoc (sym βbaseB) (sym (cong Bwd p)) βinB)
          ∙ sym (assoc βbaseB (sym βbaseB) (sym (cong Bwd p) ∙ βinB))
          ∙ ∙-sym-cancel βbaseB (sym (cong Bwd p) ∙ βinB)
      in
        sym step2

    fwd-rearrange :
      ∀ a →
      sym (cong Fwd (cf-glue a))
      ∙ C.Cofiber-map-β-in f f αf βf commF (f a)
      ≡
      C.Cofiber-map-β-base f f αf βf commF
      ∙ sym (cong cf-in (commF a) ∙ cf-glue (αf a))
    fwd-rearrange a =
      let
        p = cf-glue a
        βinF = C.Cofiber-map-β-in f f αf βf commF (f a)
        βbaseF = C.Cofiber-map-β-base f f αf βf commF
        hF = cong cf-in (commF a) ∙ cf-glue (αf a)
        glueF = C.Cofiber-map-β-glue f f αf βf commF a
        step1 : sym hF ≡ sym βbaseF ∙ sym (cong Fwd p) ∙ βinF
        step1 =
          sym (cong sym glueF)
          ∙ sym-∙-triple (sym βinF) (cong Fwd p) βbaseF
          ∙ cong (λ t → sym βbaseF ∙ sym (cong Fwd p) ∙ t) (sym-sym βinF)
        step2 :
          βbaseF ∙ sym hF ≡ sym (cong Fwd p) ∙ βinF
        step2 =
          cong (λ r → βbaseF ∙ r) step1
          ∙ cong (λ r → βbaseF ∙ r) (assoc (sym βbaseF) (sym (cong Fwd p)) βinF)
          ∙ sym (assoc βbaseF (sym βbaseF) (sym (cong Fwd p) ∙ βinF))
          ∙ ∙-sym-cancel βbaseF (sym (cong Fwd p) ∙ βinF)
      in
        sym step2

    βinF-nat :
      ∀ {b b'} (p : b ≡ b') →
      cong Fwd (sym (cong cf-in p))
      ∙ C.Cofiber-map-β-in f f αf βf commF b
      ∙ cong cf-in (cong βf p)
      ≡ C.Cofiber-map-β-in f f αf βf commF b'
    βinF-nat refl =
      ∙-idr (C.Cofiber-map-β-in f f αf βf commF _)

    βinB-nat :
      ∀ {b b'} (p : b ≡ b') →
      cong Bwd (sym (cong cf-in p))
      ∙ C.Cofiber-map-β-in f f αg βg commG b
      ∙ cong cf-in (cong βg p)
      ≡ C.Cofiber-map-β-in f f αg βg commG b'
    βinB-nat refl =
      ∙-idr (C.Cofiber-map-β-in f f αg βg commG _)

    β-square-cohF :
      ∀ a →
      (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a))
      ≡ βfg (f a)
    β-square-cohF a = uipB _ _

    β-square-cohG :
      ∀ a →
      (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a))
      ≡ βgf (f a)
    β-square-cohG a = uipB _ _

    cf-glue-nat :
      ∀ a a' (r : a ≡ a') →
      sym (cf-glue a) ∙ cong cf-in (cong f r) ∙ cf-glue a' ≡ refl
    cf-glue-nat a a' refl =
      let
        p = cf-glue a
      in
        assoc (sym p) refl p
        ∙ sym (cong (λ r → sym p ∙ r) (∙-idr p))
        ∙ sym-∙-cancel p refl

    fg-in : ∀ b → Fwd (Bwd (cf-in b)) ≡ cf-in b
    fg-in b =
      cong Fwd (C.Cofiber-map-β-in f f αg βg commG b)
      ∙ C.Cofiber-map-β-in f f αf βf commF (βg b)
      ∙ cong cf-in (βfg b)

    fg-base : Fwd (Bwd cf-base) ≡ cf-base
    fg-base =
      cong Fwd (C.Cofiber-map-β-base f f αg βg commG)
      ∙ C.Cofiber-map-β-base f f αf βf commF

    fg-step6 :
      ∀ a →
      cong Fwd (sym (cong cf-in (commG a) ∙ cf-glue (αg a)))
      ∙ C.Cofiber-map-β-in f f αf βf commF (βg (f a))
      ∙ cong cf-in (βfg (f a))
      ∙ cf-glue a
      ≡ C.Cofiber-map-β-base f f αf βf commF
    fg-step6 a =
      let
        p = cf-glue a
        βinF = C.Cofiber-map-β-in f f αf βf commF (βg (f a))
        βbaseF = C.Cofiber-map-β-base f f αf βf commF
        hB = cong cf-in (commG a) ∙ cf-glue (αg a)
        x = cong Fwd (sym (cf-glue (αg a)))
        y = cong Fwd (sym (cong cf-in (commG a)))
        c1 = cong cf-in (cong βf (commG a))
        c2 = cong cf-in (commF (αg a))
        c3 = cong cf-in (cong f (αfg a))
        βinF' = C.Cofiber-map-β-in f f αf βf commF (f (αg a))

        hB-sym :
          cong Fwd (sym hB) ≡ x ∙ y
        hB-sym =
          cong (λ r → cong Fwd r) (sym-∙ (cong cf-in (commG a)) (cf-glue (αg a)))
          ∙ cong-∙ Fwd (sym (cf-glue (αg a))) (sym (cong cf-in (commG a)))

        βfg-rewrite :
          cong cf-in (βfg (f a)) ≡
          cong cf-in (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a))
        βfg-rewrite =
          cong (λ r → cong cf-in r) (sym (β-square-cohF a))

        βfg-split :
          cong cf-in (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a))
          ≡ c1 ∙ c2 ∙ c3
        βfg-split =
          cong-∙-triple cf-in (cong βf (commG a)) (commF (αg a)) (cong f (αfg a))

        step1 :
          cong Fwd (sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡ (x ∙ y) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
        step1 =
          cong (λ r → r ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p) hB-sym

        step2 :
          (x ∙ y) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡ (x ∙ y) ∙ βinF ∙ c1 ∙ c2 ∙ c3 ∙ p
        step2 =
          let
            step2a :
              (x ∙ y) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
              ≡
              (x ∙ y) ∙ βinF
              ∙ cong cf-in (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a))
              ∙ p
            step2a =
              cong (λ r → (x ∙ y) ∙ βinF ∙ r ∙ p) βfg-rewrite

            step2b :
              (x ∙ y) ∙ βinF
              ∙ cong cf-in (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a))
              ∙ p
              ≡ (x ∙ y) ∙ βinF ∙ c1 ∙ c2 ∙ c3 ∙ p
            step2b =
              let
                t = (x ∙ y) ∙ βinF
                step2b1 :
                  t ∙ cong cf-in (cong βf (commG a) ∙ commF (αg a) ∙ cong f (αfg a)) ∙ p
                  ≡ t ∙ (c1 ∙ c2 ∙ c3) ∙ p
                step2b1 =
                  cong (λ r → t ∙ r ∙ p)
                    (cong-∙-triple cf-in (cong βf (commG a)) (commF (αg a)) (cong f (αfg a)))

                step2b2 :
                  t ∙ (c1 ∙ c2 ∙ c3) ∙ p ≡ t ∙ c1 ∙ c2 ∙ c3 ∙ p
                step2b2 =
                  cong (λ r → r ∙ p) (assoc-4 t c1 c2 c3)
              in
                step2b1 ∙ step2b2
          in
            step2a ∙ step2b

        step3 :
          (x ∙ y) ∙ βinF ∙ c1 ∙ c2 ∙ c3 ∙ p
          ≡ x ∙ (y ∙ βinF ∙ c1) ∙ c2 ∙ c3 ∙ p
        step3 =
          cong (λ r → r ∙ c1 ∙ c2 ∙ c3 ∙ p) (assoc x y βinF)
          ∙ cong (λ r → r ∙ c2 ∙ c3 ∙ p) (assoc x (y ∙ βinF) c1)

        step4 :
          x ∙ (y ∙ βinF ∙ c1) ∙ c2 ∙ c3 ∙ p
          ≡ x ∙ βinF' ∙ c2 ∙ c3 ∙ p
        step4 =
          cong (λ r → x ∙ r ∙ c2 ∙ c3 ∙ p) (βinF-nat (commG a))

        step5 :
          x ∙ βinF' ∙ c2 ∙ c3 ∙ p
          ≡ sym (cong Fwd (cf-glue (αg a))) ∙ βinF' ∙ c2 ∙ c3 ∙ p
        step5 =
          cong (λ r → r ∙ βinF' ∙ c2 ∙ c3 ∙ p) (cong-sym Fwd (cf-glue (αg a)))

        step6 :
          sym (cong Fwd (cf-glue (αg a))) ∙ βinF' ∙ c2 ∙ c3 ∙ p
          ≡
          βbaseF ∙ sym (cong cf-in (commF (αg a)) ∙ cf-glue (αf (αg a)))
          ∙ c2 ∙ c3 ∙ p
        step6 =
          cong (λ r → r ∙ c2 ∙ c3 ∙ p) (fwd-rearrange (αg a))

        step7 :
          βbaseF ∙ sym (cong cf-in (commF (αg a)) ∙ cf-glue (αf (αg a)))
          ∙ c2 ∙ c3 ∙ p
          ≡ βbaseF ∙ sym (cf-glue (αf (αg a))) ∙ c3 ∙ p
        step7 =
          let
            q0 = cf-glue (αf (αg a))
            p0 = cong cf-in (commF (αg a))
          in
            cong (λ r → βbaseF ∙ r ∙ c2 ∙ c3 ∙ p) (sym-∙ p0 q0)
            ∙ cong (λ r → r ∙ c2 ∙ c3 ∙ p)
                (sym (assoc βbaseF (sym q0) (sym p0)))
            ∙ sym-∙-cancel-mid (βbaseF ∙ sym q0) p0 c3 p

        step8 :
          βbaseF ∙ sym (cf-glue (αf (αg a))) ∙ c3 ∙ p ≡ βbaseF
        step8 =
          let
            q0 = cf-glue (αf (αg a))
          in
            sym (assoc-4 βbaseF (sym q0) c3 p)
            ∙ cong (λ r → βbaseF ∙ r) (cf-glue-nat (αf (αg a)) a (αfg a))
            ∙ ∙-idr βbaseF
      in
        step1 ∙ step2 ∙ step3 ∙ step4 ∙ step5 ∙ step6 ∙ step7 ∙ step8

    fg-glue :
      ∀ a →
      PI.PathP (λ x → Fwd (Bwd x) ≡ x)
        (cf-glue a) (fg-in (f a)) fg-base
    fg-glue a =
      subst-≡ (λ x → Fwd (Bwd x)) (λ x → x) (cf-glue a) (fg-in (f a))
      ∙ cong (λ r → sym (cong (λ x → Fwd (Bwd x)) (cf-glue a)) ∙ fg-in (f a) ∙ r)
          (cong-id (cf-glue a))
      ∙
      let
        p = cf-glue a
        βinB = C.Cofiber-map-β-in f f αg βg commG (f a)
        βbaseB = C.Cofiber-map-β-base f f αg βg commG
        βinF = C.Cofiber-map-β-in f f αf βf commF (βg (f a))
        βbaseF = C.Cofiber-map-β-base f f αf βf commF
        hB = cong cf-in (commG a) ∙ cf-glue (αg a)

        step1 :
          sym (cong (λ x → Fwd (Bwd x)) p) ∙ fg-in (f a) ∙ p
          ≡
          sym (cong Fwd (cong Bwd p)) ∙ fg-in (f a) ∙ p
        step1 =
          cong (λ r → r ∙ fg-in (f a) ∙ p) (cong sym (cong-comp Fwd Bwd p))

        step2 :
          sym (cong Fwd (cong Bwd p)) ∙ fg-in (f a) ∙ p
          ≡
          cong Fwd (sym (cong Bwd p)) ∙ fg-in (f a) ∙ p
        step2 =
          cong (λ r → r ∙ fg-in (f a) ∙ p) (sym (cong-sym Fwd (cong Bwd p)))

        step3 :
          cong Fwd (sym (cong Bwd p)) ∙ fg-in (f a) ∙ p
          ≡
          cong Fwd (sym (cong Bwd p) ∙ βinB) ∙
          βinF ∙ cong cf-in (βfg (f a)) ∙ p
        step3 =
          let
            tail : Fwd (cf-in (βg (f a))) ≡ cf-in (f a)
            tail = βinF ∙ cong cf-in (βfg (f a))

            step3prefix :
              cong Fwd (sym (cong Bwd p)) ∙ fg-in (f a)
              ≡
              cong Fwd (sym (cong Bwd p) ∙ βinB) ∙
              βinF ∙ cong cf-in (βfg (f a))
            step3prefix =
              let
                fg-in-def :
                  fg-in (f a) ≡
                  (cong Fwd βinB ∙ βinF) ∙ cong cf-in (βfg (f a))
                fg-in-def = refl
              in
                cong (λ r → cong Fwd (sym (cong Bwd p)) ∙ r) fg-in-def
                ∙ sym (assoc (cong Fwd (sym (cong Bwd p))) (cong Fwd βinB ∙ βinF)
                              (cong cf-in (βfg (f a))))
                ∙ cong (λ r → r ∙ cong cf-in (βfg (f a)))
                    (sym (assoc (cong Fwd (sym (cong Bwd p))) (cong Fwd βinB) βinF))
                ∙ cong (λ r → r ∙ βinF ∙ cong cf-in (βfg (f a)))
                    (sym (cong-∙ Fwd (sym (cong Bwd p)) βinB))
          in
            cong (λ t → t ∙ p) step3prefix

        step4 :
          cong Fwd (sym (cong Bwd p) ∙ βinB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡
          cong Fwd (βbaseB ∙ sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
        step4 =
          cong (λ r → cong Fwd r ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p)
            (bwd-rearrange a)

        step5 :
          cong Fwd (βbaseB ∙ sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡
          cong Fwd βbaseB ∙ cong Fwd (sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
        step5 =
          cong (λ r → r ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p)
            (cong-∙ Fwd βbaseB (sym hB))

        step6 :
          cong Fwd (sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡ βbaseF
        step6 = fg-step6 a

        step6' :
          cong Fwd (sym hB) ∙ βinF ∙ (cong cf-in (βfg (f a)) ∙ p)
          ≡ βbaseF
        step6' =
          sym (assoc (cong Fwd (sym hB) ∙ βinF) (cong cf-in (βfg (f a))) p)
          ∙ step6

        step6'' :
          cong Fwd βbaseB ∙ cong Fwd (sym hB) ∙ βinF ∙ cong cf-in (βfg (f a)) ∙ p
          ≡ cong Fwd βbaseB ∙ βbaseF
        step6'' =
          sym (assoc-5 (cong Fwd βbaseB) (cong Fwd (sym hB)) βinF (cong cf-in (βfg (f a))) p)
          ∙ cong (λ r → cong Fwd βbaseB ∙ r) step6
      in
        step1 ∙ step2 ∙ step3 ∙ step4 ∙ step5 ∙ step6''

    fgC : ∀ x → Fwd (Bwd x) ≡ x
    fgC =
      C.Cofiber-ind f
        (λ x → Fwd (Bwd x) ≡ x)
        fg-in
        fg-base
        fg-glue

    gf-in : ∀ b → Bwd (Fwd (cf-in b)) ≡ cf-in b
    gf-in b =
      cong Bwd (C.Cofiber-map-β-in f f αf βf commF b)
      ∙ C.Cofiber-map-β-in f f αg βg commG (βf b)
      ∙ cong cf-in (βgf b)

    gf-base : Bwd (Fwd cf-base) ≡ cf-base
    gf-base =
      cong Bwd (C.Cofiber-map-β-base f f αf βf commF)
      ∙ C.Cofiber-map-β-base f f αg βg commG

    gf-step6 :
      ∀ a →
      cong Bwd (sym (cong cf-in (commF a) ∙ cf-glue (αf a)))
      ∙ C.Cofiber-map-β-in f f αg βg commG (βf (f a))
      ∙ cong cf-in (βgf (f a))
      ∙ cf-glue a
      ≡ C.Cofiber-map-β-base f f αg βg commG
    gf-step6 a =
      let
        p = cf-glue a
        βinB = C.Cofiber-map-β-in f f αg βg commG (βf (f a))
        βbaseB = C.Cofiber-map-β-base f f αg βg commG
        hF = cong cf-in (commF a) ∙ cf-glue (αf a)
        x = cong Bwd (sym (cf-glue (αf a)))
        y = cong Bwd (sym (cong cf-in (commF a)))
        c1 = cong cf-in (cong βg (commF a))
        c2 = cong cf-in (commG (αf a))
        c3 = cong cf-in (cong f (αgf a))
        βinB' = C.Cofiber-map-β-in f f αg βg commG (f (αf a))

        hF-sym :
          cong Bwd (sym hF) ≡ x ∙ y
        hF-sym =
          cong (λ r → cong Bwd r) (sym-∙ (cong cf-in (commF a)) (cf-glue (αf a)))
          ∙ cong-∙ Bwd (sym (cf-glue (αf a))) (sym (cong cf-in (commF a)))

        βgf-rewrite :
          cong cf-in (βgf (f a)) ≡
          cong cf-in (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a))
        βgf-rewrite =
          cong (λ r → cong cf-in r) (sym (β-square-cohG a))

        βgf-split :
          cong cf-in (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a))
          ≡ c1 ∙ c2 ∙ c3
        βgf-split =
          cong-∙-triple cf-in (cong βg (commF a)) (commG (αf a)) (cong f (αgf a))

        step1 :
          cong Bwd (sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡ (x ∙ y) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
        step1 =
          cong (λ r → r ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p) hF-sym

        step2 :
          (x ∙ y) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡ (x ∙ y) ∙ βinB ∙ c1 ∙ c2 ∙ c3 ∙ p
        step2 =
          let
            step2a :
              (x ∙ y) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
              ≡
              (x ∙ y) ∙ βinB
              ∙ cong cf-in (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a))
              ∙ p
            step2a =
              cong (λ r → (x ∙ y) ∙ βinB ∙ r ∙ p) βgf-rewrite

            step2b :
              (x ∙ y) ∙ βinB
              ∙ cong cf-in (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a))
              ∙ p
              ≡ (x ∙ y) ∙ βinB ∙ c1 ∙ c2 ∙ c3 ∙ p
            step2b =
              let
                t = (x ∙ y) ∙ βinB
                step2b1 :
                  t ∙ cong cf-in (cong βg (commF a) ∙ commG (αf a) ∙ cong f (αgf a)) ∙ p
                  ≡ t ∙ (c1 ∙ c2 ∙ c3) ∙ p
                step2b1 =
                  cong (λ r → t ∙ r ∙ p)
                    (cong-∙-triple cf-in (cong βg (commF a)) (commG (αf a)) (cong f (αgf a)))

                step2b2 :
                  t ∙ (c1 ∙ c2 ∙ c3) ∙ p ≡ t ∙ c1 ∙ c2 ∙ c3 ∙ p
                step2b2 =
                  cong (λ r → r ∙ p) (assoc-4 t c1 c2 c3)
              in
                step2b1 ∙ step2b2
          in
            step2a ∙ step2b

        step3 :
          (x ∙ y) ∙ βinB ∙ c1 ∙ c2 ∙ c3 ∙ p
          ≡ x ∙ (y ∙ βinB ∙ c1) ∙ c2 ∙ c3 ∙ p
        step3 =
          cong (λ r → r ∙ c1 ∙ c2 ∙ c3 ∙ p) (assoc x y βinB)
          ∙ cong (λ r → r ∙ c2 ∙ c3 ∙ p) (assoc x (y ∙ βinB) c1)

        step4 :
          x ∙ (y ∙ βinB ∙ c1) ∙ c2 ∙ c3 ∙ p
          ≡ x ∙ βinB' ∙ c2 ∙ c3 ∙ p
        step4 =
          cong (λ r → x ∙ r ∙ c2 ∙ c3 ∙ p) (βinB-nat (commF a))

        step5 :
          x ∙ βinB' ∙ c2 ∙ c3 ∙ p
          ≡ sym (cong Bwd (cf-glue (αf a))) ∙ βinB' ∙ c2 ∙ c3 ∙ p
        step5 =
          cong (λ r → r ∙ βinB' ∙ c2 ∙ c3 ∙ p) (cong-sym Bwd (cf-glue (αf a)))

        step6 :
          sym (cong Bwd (cf-glue (αf a))) ∙ βinB' ∙ c2 ∙ c3 ∙ p
          ≡
          βbaseB ∙ sym (cong cf-in (commG (αf a)) ∙ cf-glue (αg (αf a)))
          ∙ c2 ∙ c3 ∙ p
        step6 =
          cong (λ r → r ∙ c2 ∙ c3 ∙ p) (bwd-rearrange (αf a))

        step7 :
          βbaseB ∙ sym (cong cf-in (commG (αf a)) ∙ cf-glue (αg (αf a)))
          ∙ c2 ∙ c3 ∙ p
          ≡ βbaseB ∙ sym (cf-glue (αg (αf a))) ∙ c3 ∙ p
        step7 =
          let
            q0 = cf-glue (αg (αf a))
            p0 = cong cf-in (commG (αf a))
          in
            cong (λ r → βbaseB ∙ r ∙ c2 ∙ c3 ∙ p) (sym-∙ p0 q0)
            ∙ cong (λ r → r ∙ c2 ∙ c3 ∙ p)
                (sym (assoc βbaseB (sym q0) (sym p0)))
            ∙ sym-∙-cancel-mid (βbaseB ∙ sym q0) p0 c3 p

        step8 :
          βbaseB ∙ sym (cf-glue (αg (αf a))) ∙ c3 ∙ p ≡ βbaseB
        step8 =
          let
            q0 = cf-glue (αg (αf a))
          in
            sym (assoc-4 βbaseB (sym q0) c3 p)
            ∙ cong (λ r → βbaseB ∙ r) (cf-glue-nat (αg (αf a)) a (αgf a))
            ∙ ∙-idr βbaseB
      in
        step1 ∙ step2 ∙ step3 ∙ step4 ∙ step5 ∙ step6 ∙ step7 ∙ step8

    gf-glue :
      ∀ a →
      PI.PathP (λ x → Bwd (Fwd x) ≡ x)
        (cf-glue a) (gf-in (f a)) gf-base
    gf-glue a =
      subst-≡ (λ x → Bwd (Fwd x)) (λ x → x) (cf-glue a) (gf-in (f a))
      ∙ cong (λ r → sym (cong (λ x → Bwd (Fwd x)) (cf-glue a)) ∙ gf-in (f a) ∙ r)
          (cong-id (cf-glue a))
      ∙
      let
        p = cf-glue a
        βinF = C.Cofiber-map-β-in f f αf βf commF (f a)
        βbaseF = C.Cofiber-map-β-base f f αf βf commF
        βinB = C.Cofiber-map-β-in f f αg βg commG (βf (f a))
        βbaseB = C.Cofiber-map-β-base f f αg βg commG
        hF = cong cf-in (commF a) ∙ cf-glue (αf a)

        step1 :
          sym (cong (λ x → Bwd (Fwd x)) p) ∙ gf-in (f a) ∙ p
          ≡
          sym (cong Bwd (cong Fwd p)) ∙ gf-in (f a) ∙ p
        step1 =
          cong (λ r → r ∙ gf-in (f a) ∙ p) (cong sym (cong-comp Bwd Fwd p))

        step2 :
          sym (cong Bwd (cong Fwd p)) ∙ gf-in (f a) ∙ p
          ≡
          cong Bwd (sym (cong Fwd p)) ∙ gf-in (f a) ∙ p
        step2 =
          cong (λ r → r ∙ gf-in (f a) ∙ p) (sym (cong-sym Bwd (cong Fwd p)))

        step3 :
          cong Bwd (sym (cong Fwd p)) ∙ gf-in (f a) ∙ p
          ≡
          cong Bwd (sym (cong Fwd p) ∙ βinF) ∙
          βinB ∙ cong cf-in (βgf (f a)) ∙ p
        step3 =
          let
            tail : Bwd (cf-in (βf (f a))) ≡ cf-in (f a)
            tail = βinB ∙ cong cf-in (βgf (f a))

            step3prefix :
              cong Bwd (sym (cong Fwd p)) ∙ gf-in (f a)
              ≡
              cong Bwd (sym (cong Fwd p) ∙ βinF) ∙
              βinB ∙ cong cf-in (βgf (f a))
            step3prefix =
              let
                gf-in-def :
                  gf-in (f a) ≡
                  (cong Bwd βinF ∙ βinB) ∙ cong cf-in (βgf (f a))
                gf-in-def = refl
              in
                cong (λ r → cong Bwd (sym (cong Fwd p)) ∙ r) gf-in-def
                ∙ sym (assoc (cong Bwd (sym (cong Fwd p))) (cong Bwd βinF ∙ βinB)
                              (cong cf-in (βgf (f a))))
                ∙ cong (λ r → r ∙ cong cf-in (βgf (f a)))
                    (sym (assoc (cong Bwd (sym (cong Fwd p))) (cong Bwd βinF) βinB))
                ∙ cong (λ r → r ∙ βinB ∙ cong cf-in (βgf (f a)))
                    (sym (cong-∙ Bwd (sym (cong Fwd p)) βinF))
          in
            cong (λ t → t ∙ p) step3prefix

        step4 :
          cong Bwd (sym (cong Fwd p) ∙ βinF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡
          cong Bwd (βbaseF ∙ sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
        step4 =
          cong (λ r → cong Bwd r ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p)
            (fwd-rearrange a)

        step5 :
          cong Bwd (βbaseF ∙ sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡
          cong Bwd βbaseF ∙ cong Bwd (sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
        step5 =
          cong (λ r → r ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p)
            (cong-∙ Bwd βbaseF (sym hF))

        step6 :
          cong Bwd (sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡ βbaseB
        step6 = gf-step6 a

        step6' :
          cong Bwd (sym hF) ∙ βinB ∙ (cong cf-in (βgf (f a)) ∙ p)
          ≡ βbaseB
        step6' =
          sym (assoc (cong Bwd (sym hF) ∙ βinB) (cong cf-in (βgf (f a))) p)
          ∙ step6

        step6'' :
          cong Bwd βbaseF ∙ cong Bwd (sym hF) ∙ βinB ∙ cong cf-in (βgf (f a)) ∙ p
          ≡ cong Bwd βbaseF ∙ βbaseB
        step6'' =
          sym (assoc-5 (cong Bwd βbaseF) (cong Bwd (sym hF)) βinB (cong cf-in (βgf (f a))) p)
          ∙ cong (λ r → cong Bwd βbaseF ∙ r) step6
      in
        step1 ∙ step2 ∙ step3 ∙ step4 ∙ step5 ∙ step6''

    gfC : ∀ x → Bwd (Fwd x) ≡ x
    gfC =
      C.Cofiber-ind f
        (λ x → Bwd (Fwd x) ≡ x)
        gf-in
        gf-base
        gf-glue

  cofiberIsoFromSquareIsoData-iso : Iso (Cofiber f)
  cofiberIsoFromSquareIsoData-iso = witness→Iso cofiberIsoFromSquareIsoData
```

```agda
  CofiberIsoGoal : Set (lsuc ℓ)
  CofiberIsoGoal = CofiberIsoWitness
```
