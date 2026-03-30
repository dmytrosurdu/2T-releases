```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Bicomplex.FreeAbIF_Extensions where
```

# FreeAbIF extensions for Batch 3 (Phase I)

This module provides a **layered** strengthening of the additive/free-abelian
interfaces used by the bicomplex development:

* a structured homomorphism record `Hom` (maps with laws),
* pointwise equality `HomEq` (to avoid function extensionality),
* standard homomorphism combinators (composition, zero map, pointwise sum),
* a *minimal* freeness/uniqueness principle `extFree` (as an assumption),
* and a compatibility wrapper `FreeAbIF_Extensions` that **extends** a base `FreeAbIF`
  without exposing constructors of the free object.

Everything remains `--without-K --safe` and does not instantiate any HITs.

---

## Imports and basic path algebra

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_; Setω)
open import Agda.Builtin.Equality using (_≡_; refl)
open import TwoTimes.Prelude.Path

-- Path helpers are provided by TwoTimes.Prelude.Path.
```

---

## Abelian group interface (as used in Boundary)

```agda
record AbGroup (ℓ : Level) : Set (lsuc ℓ) where
  field
    Carrier : Set ℓ
    0#      : Carrier
    _+_     : Carrier → Carrier → Carrier
    -_      : Carrier → Carrier

    -- Laws (assumptions)
    assoc   : ∀ x y z → (x + y) + z ≡ x + (y + z)
    comm    : ∀ x y   → x + y ≡ y + x
    idl     : ∀ x     → 0# + x ≡ x
    invl    : ∀ x     → (- x) + x ≡ 0#

open AbGroup
```

### Derived abelian-group lemmas (internal library)

We derive standard consequences needed to build homomorphism combinators
without adding extra axioms.

```agda
module AbGroupLemmas {ℓ : Level} (G : AbGroup ℓ) where
  open AbGroup G renaming
    ( 0#    to 0G
    ; _+_   to _+G_
    ; -_    to -G_
    ; assoc to assocG
    ; comm  to commG
    ; idl   to idlG
    ; invl  to invlG
    )

  -- Right identity derived from commutativity + left identity
  idr : ∀ x → x +G 0G ≡ x
  idr x = commG x 0G ∙ idlG x

  -- Right inverse derived from commutativity + left inverse
  invr : ∀ x → x +G (-G_ x) ≡ 0G
  invr x = commG x (-G_ x) ∙ invlG x

  -- Cancellation (left)
  cancelL : ∀ a b c → a +G b ≡ a +G c → b ≡ c
  cancelL a b c p =
    let
      p₁ : (-G_ a) +G (a +G b) ≡ (-G_ a) +G (a +G c)
      p₁ = cong (λ t → (-G_ a) +G t) p

      redL : (-G_ a) +G (a +G b) ≡ b
      redL =
        -- (-a) + (a + b)  ≡  ((-a)+a)+b  ≡  0+b  ≡  b
        sym (assocG (-G_ a) a b)
        ∙ cong (λ t → t +G b) (invlG a)
        ∙ idlG b

      redR : (-G_ a) +G (a +G c) ≡ c
      redR =
        sym (assocG (-G_ a) a c)
        ∙ cong (λ t → t +G c) (invlG a)
        ∙ idlG c
    in
    sym redL ∙ p₁ ∙ redR

  -- Cancellation (right), via commutativity + cancelL
  cancelR : ∀ a x y → x +G a ≡ y +G a → x ≡ y
  cancelR a x y p =
    let
      p' : a +G x ≡ a +G y
      p' = sym (commG x a) ∙ p ∙ commG y a
    in
    cancelL a x y p'

  -- Inverse uniqueness on the right: if x+a=0 and y+a=0 then x=y
  invUniqueR : ∀ a x y → (x +G a ≡ 0G) → (y +G a ≡ 0G) → x ≡ y
  invUniqueR a x y xa ya =
    cancelR a x y (xa ∙ sym ya)

  -- -0 = 0
  neg-0 : (-G_ 0G) ≡ 0G
  neg-0 =
    -- (-0)  ≡  (-0)+0  ≡  0
    sym (idr (-G_ 0G)) ∙ invlG 0G

  -- A helper: 0+0 = 0
  zero-plus-zero : 0G +G 0G ≡ 0G
  zero-plus-zero = idlG 0G

  -- (-a)+(-b) is a right inverse of (a+b)
  invSum : ∀ a b → ((-G_ a) +G (-G_ b)) +G (a +G b) ≡ 0G
  invSum a b =
    -- ((-a)+(-b))+(a+b)
    assocG (-G_ a) (-G_ b) (a +G b)
    -- = (-a)+((-b)+(a+b))
    ∙ cong (λ t → (-G_ a) +G t) (sym (assocG (-G_ b) a b))
    -- = (-a)+(((-b)+a)+b)
    ∙ cong (λ t → (-G_ a) +G (t +G b)) (commG (-G_ b) a)
    -- = (-a)+((a+(-b))+b)
    ∙ cong (λ t → (-G_ a) +G t) (assocG a (-G_ b) b)
    -- = (-a)+(a+((-b)+b))
    ∙ sym (assocG (-G_ a) a ((-G_ b) +G b))
    -- = ((-a)+a)+((-b)+b)
    ∙ cong (λ t → t +G ((-G_ b) +G b)) (invlG a)
    -- = 0+((-b)+b)
    ∙ idlG ((-G_ b) +G b)
    -- = (-b)+b
    ∙ invlG b
    -- = 0

  -- Negation distributes over addition: -(a+b) = (-a)+(-b)
  neg-distrib-+ : ∀ a b → (-G_ (a +G b)) ≡ ((-G_ a) +G (-G_ b))
  neg-distrib-+ a b =
    -- Both are right inverses of (a+b)
    invUniqueR (a +G b)
      (-G_ (a +G b))
      ((-G_ a) +G (-G_ b))
      (invlG (a +G b))
      (invSum a b)

  -- Negation of 0 in the other direction: 0 = -0
  zero-neg : 0G ≡ (-G_ 0G)
  zero-neg = sym neg-0

  -- Double negation: -(-a) = a
  neg-invol : ∀ a → (-G_ (-G_ a)) ≡ a
  neg-invol a =
    invUniqueR (-G_ a)
      (-G_ (-G_ a))
      a
      (invlG (-G_ a))   -- -(-a)+(-a)=0
      (invr a)          -- a+(-a)=0  (then comm to match) already invr gives it
```

---

## Raw (unstructured) maps and the base FreeAbIF

The base free-abelian interface is intentionally minimal: `lift` returns a raw map
with β-law on generators and additive preservation assumptions. This mirrors the
setup currently used in `Boundary`.

```agda
record Hom₀ {ℓA ℓB : Level} (A : AbGroup ℓA) (B : AbGroup ℓB)
  : Set (lsuc (ℓA ⊔ ℓB)) where
  field
    f : Carrier A → Carrier B

open Hom₀

-- Pointwise equality of raw maps
HomEq₀ : ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} → Hom₀ A B → Hom₀ A B → Set (ℓA ⊔ ℓB)
HomEq₀ F G = ∀ x → f F x ≡ f G x

record FreeAbIF (ℓF : Level) : Setω where
  field
    FreeAb : ∀ {ℓX : Level} (X : Set ℓX) → AbGroup (ℓF ⊔ ℓX)

    η      : ∀ {ℓX : Level} {X : Set ℓX} →
             X → Carrier (FreeAb X)

    -- Linear extension into any abelian group
    lift   : ∀ {ℓX ℓA : Level} {X : Set ℓX} →
             (A : AbGroup ℓA) →
             (X → Carrier A) →
             Hom₀ (FreeAb X) A

    -- β-law for generators
    β-η    : ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
             (g : X → Carrier A) (x : X) →
             f (lift A g) (η x) ≡ g x

    -- Homomorphism laws for lift (assumptions)
    lift-0 : ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
             (g : X → Carrier A) →
             f (lift A g) (AbGroup.0# (FreeAb X)) ≡ AbGroup.0# A

    lift-+ : ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
             (g : X → Carrier A) →
             ∀ x y →
             f (lift A g) (AbGroup._+_ (FreeAb X) x y) ≡
             AbGroup._+_ A (f (lift A g) x) (f (lift A g) y)

```

---

## Structured homomorphisms and combinators (Option A)

```agda
record Hom {ℓA ℓB : Level} (A : AbGroup ℓA) (B : AbGroup ℓB)
  : Set (lsuc (ℓA ⊔ ℓB)) where
  field
    f     : Carrier A → Carrier B
    f-0   : f (AbGroup.0# A) ≡ AbGroup.0# B
    f-+   : ∀ x y → f (AbGroup._+_ A x y) ≡ AbGroup._+_ B (f x) (f y)
    f-neg : ∀ x → f (AbGroup.-_ A x) ≡ AbGroup.-_ B (f x)

open Hom

HomEq : ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} → Hom A B → Hom A B → Set (ℓA ⊔ ℓB)
HomEq F G = ∀ x → f F x ≡ f G x

-- Forget the laws
forget : ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} → Hom A B → Hom₀ A B
f (forget F) = f F

-- Identity homomorphism
idHom : ∀ {ℓ} (A : AbGroup ℓ) → Hom A A
f     (idHom A) x = x
f-0   (idHom A)   = refl
f-+   (idHom A) x y = refl
f-neg (idHom A) x = refl

-- Composition of homomorphisms
infixr 50 _∘_
_∘_ : ∀ {ℓA ℓB ℓC}
      {A : AbGroup ℓA} {B : AbGroup ℓB} {C : AbGroup ℓC} →
      Hom B C → Hom A B → Hom A C
f (F ∘ G) x = f F (f G x)
f-0 (F ∘ G) =
  cong (f F) (f-0 G) ∙ f-0 F
f-+ (F ∘ G) x y =
  cong (f F) (f-+ G x y) ∙ f-+ F (f G x) (f G y)
f-neg (F ∘ G) x =
  cong (f F) (f-neg G x) ∙ f-neg F (f G x)
```

### Zero homomorphism and pointwise sum

```agda
zeroHom : ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} → Hom A B
f (zeroHom {B = B}) x = AbGroup.0# B
f-0 (zeroHom {A = A} {B = B}) =
  refl
f-+ (zeroHom {A = A} {B = B}) x y =
  let open AbGroupLemmas B in
  sym (zero-plus-zero)
f-neg (zeroHom {A = A} {B = B}) x =
  let
    open AbGroupLemmas B
    open AbGroup B renaming (0# to 0B; -_ to -B_)
  in
  -- 0B ≡ -B 0B, using 0 = -0
  zero-neg

addHom : ∀ {ℓA ℓB} {A : AbGroup ℓA} {B : AbGroup ℓB} →
         Hom A B → Hom A B → Hom A B
f (addHom {B = B} F G) x =
  let open AbGroup B renaming (_+_ to _+B_) in
  f F x +B f G x

f-0 (addHom {A = A} {B = B} F G) =
  let
    open AbGroup B renaming (_+_ to _+B_; 0# to 0B; assoc to assocB; comm to commB; idl to idlB)
    open AbGroupLemmas B
  in
  cong (λ u → u +B f G (AbGroup.0# A)) (f-0 F)
  ∙ cong (λ v → 0B +B v) (f-0 G)
  ∙ idlB 0B

f-+ (addHom {A = A} {B = B} F G) x y =
  let
    open AbGroup B renaming (_+_ to _+B_; assoc to assocB; comm to commB)
  in
  -- (F(x+y)+G(x+y))  =  (Fx+Fy) + (Gx+Gy)  ≡  (Fx+Gx) + (Fy+Gy)
  cong (λ u → u +B (f G (AbGroup._+_ A x y))) (f-+ F x y)
  ∙ cong (λ v → (f F x +B f F y) +B v) (f-+ G x y)
  ∙
  -- interchange: (a+b)+(c+d) ≡ (a+c)+(b+d)
  let
    interchange : ∀ a b c d →
      (a +B b) +B (c +B d) ≡ (a +B c) +B (b +B d)
    interchange a b c d =
      sym (assocB (a +B b) c d)
      ∙ cong (λ t → t +B d) (assocB a b c)
      ∙ cong (λ t → (a +B t) +B d) (commB b c)
      ∙ cong (λ t → t +B d) (sym (assocB a c b))
      ∙ assocB (a +B c) b d
  in
  interchange (f F x) (f F y) (f G x) (f G y)

f-neg (addHom {A = A} {B = B} F G) x =
  let
    open AbGroup B renaming (_+_ to _+B_; -_ to -B_)
    open AbGroupLemmas B
  in
  cong (λ u → u +B f G (AbGroup.-_ A x)) (f-neg F x)
  ∙ cong (λ v → (-B_ (f F x)) +B v) (f-neg G x)
  ∙ sym (neg-distrib-+ (f F x) (f G x))
```

---

## The extension layer: lift-neg and extFree (minimal freeness)

We do **not** change `FreeAbIF` here. Instead we extend it with:

* `lift-neg`: `lift` preserves additive inverse,
* `extFree`: if two homomorphisms out of `FreeAb X` agree on `η`, they are equal pointwise.

```agda
record FreeAbIF_Ext (ℓF : Level) : Setω where
  field
    base : FreeAbIF ℓF

    -- Minimal freeness: agree on η ⇒ equal as functions (HomEq)
    extFree :
      ∀ {ℓX ℓA : Level} {X : Set ℓX} {A : AbGroup ℓA} →
      (F G : Hom (FreeAbIF.FreeAb base X) A) →
      (∀ x → Hom.f F (FreeAbIF.η base x) ≡ Hom.f G (FreeAbIF.η base x)) →
      HomEq F G
```

---

## Derived constructions from the extension layer

```agda
module FreeAbIF_ExtOps {ℓF : Level} (E : FreeAbIF_Ext ℓF) where
  open FreeAbIF_Ext E

  -- Raw interface (renamed to avoid projection clashes).
  FreeAb₀ : ∀ {ℓX : Level} → Set ℓX → AbGroup (ℓF ⊔ ℓX)
  FreeAb₀ = FreeAbIF.FreeAb base

  η₀ : ∀ {ℓX : Level} {X : Set ℓX} → X → Carrier (FreeAb₀ X)
  η₀ = FreeAbIF.η base

  lift₀ :
    ∀ {ℓX ℓA : Level} {X : Set ℓX} →
    (A : AbGroup ℓA) →
    (X → Carrier A) →
    Hom₀ (FreeAb₀ X) A
  lift₀ = FreeAbIF.lift base

  β-η₀ :
    ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
    (g : X → Carrier A) (x : X) →
    Hom₀.f (lift₀ A g) (η₀ x) ≡ g x
  β-η₀ = FreeAbIF.β-η base

  lift-0₀ :
    ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
    (g : X → Carrier A) →
    Hom₀.f (lift₀ A g) (AbGroup.0# (FreeAb₀ X)) ≡ AbGroup.0# A
  lift-0₀ = FreeAbIF.lift-0 base

  lift-+₀ :
    ∀ {ℓX ℓA : Level} {X : Set ℓX} (A : AbGroup ℓA)
    (g : X → Carrier A) →
    ∀ x y →
    Hom₀.f (lift₀ A g) (AbGroup._+_ (FreeAb₀ X) x y) ≡
    AbGroup._+_ A (Hom₀.f (lift₀ A g) x) (Hom₀.f (lift₀ A g) y)
  lift-+₀ = FreeAbIF.lift-+ base

  -- Extended interface (preferred names).
  FreeAb : ∀ {ℓX : Level} → Set ℓX → AbGroup (ℓF ⊔ ℓX)
  FreeAb = FreeAb₀

  η : ∀ {ℓX : Level} {X : Set ℓX} → X → Carrier (FreeAb X)
  η = η₀

  -- Derive that lift preserves negation from lift-0/lift-+ and abelian-group laws.
  lift-neg-derivable :
    ∀ {ℓX ℓA : Level} {X : Set ℓX}
      (A : AbGroup ℓA)
      (g : X → Carrier A) →
    ∀ (x : Carrier (FreeAb₀ X)) →
      Hom₀.f (lift₀ A g) (AbGroup.-_ (FreeAb₀ X) x)
      ≡
      AbGroup.-_ A (Hom₀.f (lift₀ A g) x)
  lift-neg-derivable {X = X} A g x =
    let
      open AbGroup (FreeAb₀ X) renaming
        (_+_ to _+F_; -_ to -F_; 0# to 0F; invl to invlF)
      open AbGroup A renaming (_+_ to _+A_; -_ to -A_; 0# to 0A; invl to invlA)
      open AbGroupLemmas A
      F = lift₀ A g

      inv-proof : Hom₀.f F (-F_ x) +A Hom₀.f F x ≡ 0A
      inv-proof =
        sym (lift-+₀ A g (-F_ x) x)
        ∙ cong (Hom₀.f F) (invlF x)
        ∙ lift-0₀ A g
    in
    invUniqueR (Hom₀.f F x)
      (Hom₀.f F (-F_ x))
      (-A_ (Hom₀.f F x))
      inv-proof
      (invlA (Hom₀.f F x))

  -- Promote lift (raw map) to a structured homomorphism using lift-0/lift-+/lift-neg.
  liftHom :
    ∀ {ℓX ℓA : Level} {X : Set ℓX} →
    (A : AbGroup ℓA) →
    (X → Carrier A) →
    Hom (FreeAb X) A
  f     (liftHom {X = X} A g) = Hom₀.f (lift₀ A g)
  f-0   (liftHom {X = X} A g) = lift-0₀ A g
  f-+   (liftHom {X = X} A g) x y = lift-+₀ A g x y
  f-neg (liftHom {X = X} A g) x = lift-neg-derivable A g x

  -- β-law for liftHom on generators
  liftHom-β-η :
    ∀ {ℓX ℓA : Level} {X : Set ℓX}
      (A : AbGroup ℓA) (g : X → Carrier A) (x : X) →
      Hom.f (liftHom A g) (η x) ≡ g x
  liftHom-β-η A g x = β-η₀ A g x

  -- Uniqueness of liftHom (pointwise), using extFree
  liftHom-unique :
    ∀ {ℓX ℓA : Level} {X : Set ℓX}
      (A : AbGroup ℓA) (g : X → Carrier A) →
      (F : Hom (FreeAb X) A) →
      (∀ x → Hom.f F (η x) ≡ g x) →
      HomEq F (liftHom A g)
  liftHom-unique A g F agree =
    extFree F (liftHom A g)
      (λ x → agree x ∙ sym (liftHom-β-η A g x))

  -- Congruence of liftHom from pointwise congruence on generators
  liftHom-cong :
    ∀ {ℓX ℓA : Level} {X : Set ℓX}
      (A : AbGroup ℓA) {g h : X → Carrier A} →
      (∀ x → g x ≡ h x) →
      HomEq (liftHom A g) (liftHom A h)
  liftHom-cong A {g = g} {h = h} gh =
    extFree (liftHom A g) (liftHom A h)
      (λ x → liftHom-β-η A g x ∙ gh x ∙ sym (liftHom-β-η A h x))

  -- A canonical induced map FreeAb X → FreeAb Y from a function X → Y
  map :
    ∀ {ℓX ℓY : Level} {X : Set ℓX} {Y : Set ℓY} →
    (X → Y) →
    Hom (FreeAb X) (FreeAb Y)
  map {X = X} {Y = Y} fXY =
    liftHom (FreeAb Y) (λ x → η (fXY x))

  -- β on generators for map
  map-β-η :
    ∀ {ℓX ℓY : Level} {X : Set ℓX} {Y : Set ℓY}
      (fXY : X → Y) (x : X) →
      Hom.f (map fXY) (η x) ≡ η (fXY x)
  map-β-η fXY x = liftHom-β-η (FreeAb _) (λ x' → η (fXY x')) x

-- Backwards-compatibility alias.
module FreeAbIF_Extensions = FreeAbIF_Ext
```
