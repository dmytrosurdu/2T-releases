 
```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Diff.LoopAction where
```

# Loop actions on cofibers (difference objects)

This module provides a `--safe` construction of induced endomorphisms on cofibers.

---

## Imports

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)

open import TwoTimes.Util.Path using (sym; trans; _∙_; cong)
import TwoTimes.Diff.Cofiber as Cof
```

---

## Minimal notions: Iso

```agda
record Iso {ℓ : Level} (X : Set ℓ) : Set (lsuc ℓ) where
  field
    f g : X → X
    fg : ∀ x → f (g x) ≡ x
    gf : ∀ x → g (f x) ≡ x
```

---

## Squares over a map `f : A → B`

```agda
record SquareEndo {ℓ : Level} {A B : Set ℓ} (f : A → B) : Set (lsuc ℓ) where
  field
    α    : A → A
    β    : B → B
    comm : ∀ a → β (f a) ≡ f (α a)

module _ {ℓ : Level} {A B : Set ℓ} {f : A → B} where
  open SquareEndo

  idSquare : SquareEndo f
  α idSquare a = a
  β idSquare b = b
  comm idSquare a = refl

  _∘Sq_ : SquareEndo f → SquareEndo f → SquareEndo f
  α (S₁ ∘Sq S₂) a = α S₁ (α S₂ a)
  β (S₁ ∘Sq S₂) b = β S₁ (β S₂ b)
  comm (S₁ ∘Sq S₂) a =
    cong (β S₁) (comm S₂ a) ∙ comm S₁ (α S₂ a)
```

---

## Parameterized interface over pushout primitives

```agda
module _ {ℓ : Level}
  (Pushout : ∀ {A B C : Set ℓ} → (f : A → B) → (g : A → C) → Set ℓ)
  (inl     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → B → Pushout f g)
  (inr     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → C → Pushout f g)
  (glue    : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} → (a : A) →
             inl {A = A} {B = B} {C = C} {f = f} {g = g} (f a) ≡
             inr {A = A} {B = B} {C = C} {f = f} {g = g} (g a))
  (rec     : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → Pushout f g → P)
  (β-inl   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (b : B) →
             rec l r h (inl b) ≡ l b)
  (β-inr   : ∀ {A B C : Set ℓ} {f : A → B} {g : A → C} {P : Set ℓ} →
             (l : B → P) → (r : C → P) → (h : ∀ a → l (f a) ≡ r (g a)) → (c : C) →
             rec l r h (inr c) ≡ r c)
  where
  -- Reuse Cofiber machinery from the proven Cofiber module
  module CC = Cof.CofCore {ℓ = ℓ} Pushout inl inr glue rec β-inl β-inr
  open CC public using (Cofiber; cf-in; cf-base; cf-glue; Cofiber-map; Cofiber-map-β-in; Cofiber-map-β-base)

  cofEndo : ∀ {A B : Set ℓ} {f : A → B} → SquareEndo f → Cofiber f → Cofiber f
  cofEndo {f = f} S =
    Cofiber-map f f (SquareEndo.α S) (SquareEndo.β S) (SquareEndo.comm S)

  cofEndo-β-in
    : ∀ {A B : Set ℓ} {f : A → B} (S : SquareEndo f) (b : B) →
      cofEndo S (cf-in {f = f} b) ≡ cf-in {f = f} (SquareEndo.β S b)
  cofEndo-β-in {f = f} S b =
    Cofiber-map-β-in f f (SquareEndo.α S) (SquareEndo.β S) (SquareEndo.comm S) b

  cofEndo-β-base
    : ∀ {A B : Set ℓ} {f : A → B} (S : SquareEndo f) →
      cofEndo S (cf-base {f = f}) ≡ cf-base {f = f}
  cofEndo-β-base {f = f} S =
    Cofiber-map-β-base f f (SquareEndo.α S) (SquareEndo.β S) (SquareEndo.comm S)

  record SquareIso {A B : Set ℓ} (f : A → B) : Set (lsuc ℓ) where
    field
      Fwd : SquareEndo f
      Bwd : SquareEndo f

  loopIso
    : ∀ {A B : Set ℓ} {f : A → B} →
      (SI : SquareIso f) →
      (fg : ∀ x → cofEndo (SquareIso.Fwd SI) (cofEndo (SquareIso.Bwd SI) x) ≡ x) →
      (gf : ∀ x → cofEndo (SquareIso.Bwd SI) (cofEndo (SquareIso.Fwd SI) x) ≡ x) →
      Iso (Cofiber f)
  Iso.f (loopIso {f = f} SI _ _) = cofEndo (SquareIso.Fwd SI)
  Iso.g (loopIso {f = f} SI _ _) = cofEndo (SquareIso.Bwd SI)
  Iso.fg (loopIso {f = f} SI fg _) = fg
  Iso.gf (loopIso {f = f} SI _ gf) = gf

  record SquareIsoData {A B : Set ℓ} (f : A → B) : Set (lsuc ℓ) where
    field
      αIso : Iso A
      βIso : Iso B
      commF : ∀ a → Iso.f βIso (f a) ≡ f (Iso.f αIso a)
      commG : ∀ a → Iso.g βIso (f a) ≡ f (Iso.g αIso a)

    Fwd : SquareEndo f
    SquareEndo.α Fwd = Iso.f αIso
    SquareEndo.β Fwd = Iso.f βIso
    SquareEndo.comm Fwd = commF

    Bwd : SquareEndo f
    SquareEndo.α Bwd = Iso.g αIso
    SquareEndo.β Bwd = Iso.g βIso
    SquareEndo.comm Bwd = commG

  -- Minimal Sigma (dependent pair) to package existence
  record Sigma {ℓ₁ ℓ₂ : Level} (X : Set ℓ₁) (Y : X → Set ℓ₂) : Set (ℓ₁ ⊔ ℓ₂) where
    constructor _,_
    field fstΣ : X
          sndΣ : Y fstΣ

  CofiberIsoGoal
    : ∀ {A B : Set ℓ} (f : A → B) →
      SquareIsoData f → Set (lsuc ℓ)
  CofiberIsoGoal f D =
    Sigma (SquareIso f)
          (λ SI → Sigma (SquareIso.Fwd SI ≡ SquareIsoData.Fwd D)
                          (λ _ → SquareIso.Bwd SI ≡ SquareIsoData.Bwd D))

  -- (optional product type could be added if needed)
```

---

This module is parameterized by pushout primitives, so it can be instantiated
with any implementation providing those operations.

````
