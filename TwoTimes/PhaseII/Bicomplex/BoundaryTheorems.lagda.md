# TwoTimes/PhaseII/Bicomplex/BoundaryTheorems.lagda.md

Phase II (Batch 8): **bicomplex identity packaging** for Phase II boundaries.

This module provides:

1. The `BicomplexIdentities` record (Phase II version, referencing Phase II `Qt`/`Qu`).
2. Generator-level identity types (`Qt²Onη`, `Qu²Onη`, `AnticommOnη`).
3. A *generic assembly lemma* `bicomplexFromη` that lifts generator-level
   equalities to chain-level `HomEq` equalities using `FreeAbIF_Ext.extFree`.

**Design note.**
This file is intentionally “interface-shaped”: it does not hardcode any
particular bisimplicial semantics; it is parameterized by:

* `FreeAbIF_Ext` (for free abelian chains + freeness extension),
* `BisimplicialIF` (for the underlying bisimplicial object).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Bicomplex.BoundaryTheorems where

open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Nat using (Nat; zero; suc)

open import TwoTimes.Prelude.Path
import TwoTimes.Process.Grid.Nerve as N

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FA
import TwoTimes.PhaseII.Bicomplex.BisimplicialIF as BI
import TwoTimes.PhaseII.Bicomplex.BoundaryDefs as BD

open import TwoTimes.Algebra.Sign
  using (sgn; parity; parity-suc; sgn-invol; sgn-not)
open import TwoTimes.Algebra.SumFin
  using (altFin; altFin-map; altFin-cong; altFin-neg; altFin-swap; altFin-+; altFin-zero)
open import TwoTimes.Algebra.ReindexAltFin
  using (caseMaybe; caseMaybe-just; caseMaybe-nothing; after?; after?-lt; after?-gt; reindex-altFin)
open import TwoTimes.Algebra.AltFin2 using (altFin2-antisym)
open import TwoTimes.Prelude.FinLemmas
  using (punchIn; punchOut?; punchOut?-punchIn; punchIn-punchOut?; Maybe; nothing; just; z<s; s<s; ⊥; ⊥-elim; <-irrefl)
  renaming (_<_ to _<ᶠ_)

module Inst {ℓX ℓF : Level}
  (E : FA.FreeAbIF_Ext ℓF)
  (B : BI.BisimplicialIF ℓX)
  where

  module D = BD.Inst {ℓX = ℓX} {ℓF = ℓF} E B
  open D public
    using ( Obj
          ; C
          ; ∂H-gen ; ∂V-gen
          ; dH ; dV
          ; faceH-faceH ; faceV-faceV ; faceH-faceV-comm
          ; Qt ; Qu
          ; Qt²Hom ; Qu²Hom ; anticommHom
          ; η
          )

  open FA.FreeAbIF_ExtOps E using (FreeAb; liftHom; liftHom-β-η)
  open FA.Hom using (f; f-neg)
  open N using (Fin; fzero; fsuc)

  -- ------------------------------------------------------------------------
  -- Phase II bicomplex identity record (chain-level)
  -- ------------------------------------------------------------------------

  record BicomplexIdentities : Set (lsuc (ℓF ⊔ ℓX)) where
    field
      Qt² :
        ∀ (m n : Nat) →
        FA.HomEq
          (Qt {m = m} {n = n} FA.∘ Qt {m = suc m} {n = n})
          (FA.zeroHom {A = C (suc (suc m)) n} {B = C m n})

      Qu² :
        ∀ (m n : Nat) →
        FA.HomEq
          (Qu {m = m} {n = n} FA.∘ Qu {m = m} {n = suc n})
          (FA.zeroHom {A = C m (suc (suc n))} {B = C m n})

      anticomm :
        ∀ (m n : Nat) →
        FA.HomEq
          (FA.addHom
            (Qt {m = m} {n = n} FA.∘ Qu {m = suc m} {n = n})
            (Qu {m = m} {n = n} FA.∘ Qt {m = m} {n = suc n}))
          (FA.zeroHom {A = C (suc m) (suc n)} {B = C m n})

  open BicomplexIdentities public

  -- ------------------------------------------------------------------------
  -- Generator-level identity types (η-level)
  --
  -- These are the “on generators” obligations that can be proved by purely
  -- combinatorial simplicial reasoning from the face–face and commutation
  -- laws in BisimplicialIF (and then lifted by extFree).
  -- ------------------------------------------------------------------------

  Qt²Onη : (m n : Nat) → Set (ℓF ⊔ ℓX)
  Qt²Onη m n =
    ∀ (x : Obj (suc (suc m)) n) →
      FA.Hom.f (Qt²Hom m n) (η x)
      ≡
      FA.Hom.f (FA.zeroHom {A = C (suc (suc m)) n} {B = C m n}) (η x)

  Qu²Onη : (m n : Nat) → Set (ℓF ⊔ ℓX)
  Qu²Onη m n =
    ∀ (x : Obj m (suc (suc n))) →
      FA.Hom.f (Qu²Hom m n) (η x)
      ≡
      FA.Hom.f (FA.zeroHom {A = C m (suc (suc n))} {B = C m n}) (η x)

  AnticommOnη : (m n : Nat) → Set (ℓF ⊔ ℓX)
  AnticommOnη m n =
    ∀ (x : Obj (suc m) (suc n)) →
      FA.Hom.f (anticommHom m n) (η x)
      ≡
      FA.Hom.f (FA.zeroHom {A = C (suc m) (suc n)} {B = C m n}) (η x)

  -- ------------------------------------------------------------------------
  -- Lift generator-level identities to chain-level identities (by freeness).
  -- ------------------------------------------------------------------------

  bicomplexFromη :
    (qt²η   : ∀ m n → Qt²Onη m n) →
    (qu²η   : ∀ m n → Qu²Onη m n) →
    (antiη  : ∀ m n → AnticommOnη m n) →
    BicomplexIdentities
  Qt² (bicomplexFromη qt²η qu²η antiη) m n =
    FA.FreeAbIF_Ext.extFree E
      (Qt {m = m} {n = n} FA.∘ Qt {m = suc m} {n = n})
      (FA.zeroHom {A = C (suc (suc m)) n} {B = C m n})
      (qt²η m n)

  Qu² (bicomplexFromη qt²η qu²η antiη) m n =
    FA.FreeAbIF_Ext.extFree E
      (Qu {m = m} {n = n} FA.∘ Qu {m = m} {n = suc n})
      (FA.zeroHom {A = C m (suc (suc n))} {B = C m n})
      (qu²η m n)

  anticomm (bicomplexFromη qt²η qu²η antiη) m n =
    FA.FreeAbIF_Ext.extFree E
      (FA.addHom
        (Qt {m = m} {n = n} FA.∘ Qu {m = suc m} {n = n})
        (Qu {m = m} {n = n} FA.∘ Qt {m = m} {n = suc n}))
      (FA.zeroHom {A = C (suc m) (suc n)} {B = C m n})
      (antiη m n)

  -- ------------------------------------------------------------------------
  -- Generator-level cancellations (Phase II)
  -- ------------------------------------------------------------------------

  -- Local path algebra for AbGroup computations.
  symG : ∀ {ℓ} {A : Set ℓ} {x y : A} → x ≡ y → y ≡ x
  symG refl = refl

  transG : ∀ {ℓ} {A : Set ℓ} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
  transG refl q = q

  infixl 20 _∙G_
  _∙G_ : ∀ {ℓ} {A : Set ℓ} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
  _∙G_ = transG

  congG : ∀ {ℓ₁ ℓ₂} {A : Set ℓ₁} {B : Set ℓ₂} (f : A → B) {x y : A} →
          x ≡ y → f x ≡ f y
  congG f refl = refl

  -- ----------------------------------------------------------------------
  -- Helper lemmas: homomorphisms and signs
  -- ----------------------------------------------------------------------

  hom-sgn :
    ∀ {ℓA ℓB} {A : FA.AbGroup ℓA} {B : FA.AbGroup ℓB}
      (F : FA.Hom A B) (b : Bool) (x : FA.AbGroup.Carrier A) →
    f F (sgn A b x) ≡ sgn B b (f F x)
  hom-sgn F false x = refl
  hom-sgn F true  x = f-neg F x

  sgn-altFin :
    ∀ {ℓ} (G : FA.AbGroup ℓ) (b : Bool) {n : Nat}
      (f : Fin n → FA.AbGroup.Carrier G) →
    sgn G b (altFin G f) ≡ altFin G (λ i → sgn G b (f i))
  sgn-altFin G false f = refl
  sgn-altFin G true  f = symG (altFin-neg G f)

  -- ----------------------------------------------------------------------
  -- Local order witnesses for punchIn (structural recursion, no Bool/Dec)
  -- ----------------------------------------------------------------------

  data _⊎_ {ℓ₁ ℓ₂ : Level} (A : Set ℓ₁) (B : Set ℓ₂) : Set (ℓ₁ ⊔ ℓ₂) where
    inj₁ : A → A ⊎ B
    inj₂ : B → A ⊎ B

  -- Tri-comparison for Fin (structural, no Bool/Dec).
  Tri : ∀ {n : Nat} → Fin (suc n) → Fin (suc n) → Set
  Tri a b = (a <ᶠ b) ⊎ ((a ≡ b) ⊎ (b <ᶠ a))

  compareFin : ∀ {n : Nat} (a b : Fin (suc n)) → Tri a b
  compareFin {n} fzero fzero = inj₂ (inj₁ refl)
  compareFin {n} fzero (fsuc b) = inj₁ z<s
  compareFin {n} (fsuc a) fzero = inj₂ (inj₂ z<s)
  compareFin {n = suc n} (fsuc a) (fsuc b) with compareFin {n = n} a b
  ... | inj₁ p = inj₁ (s<s p)
  ... | inj₂ (inj₁ eq) = inj₂ (inj₁ (cong fsuc eq))
  ... | inj₂ (inj₂ p) = inj₂ (inj₂ (s<s p))

  compareFin-refl :
    ∀ {n : Nat} (i : Fin (suc n)) →
    compareFin i i ≡ inj₂ (inj₁ refl)
  compareFin-refl fzero = refl
  compareFin-refl {n = suc n} (fsuc i) with compareFin-refl {n = n} i
  ... | ih rewrite ih = refl

  -- Diagonal punchOut? is always nothing.
  punchOut?-self :
    ∀ {n : Nat} (i : Fin (suc n)) →
    punchOut? i i ≡ nothing
  punchOut?-self fzero = refl
  punchOut?-self {n = suc n} (fsuc i) with punchOut?-self {n = n} i
  ... | ih rewrite ih = refl

  punchOut?-inject :
    ∀ {n : Nat} (j : Fin (suc (suc n))) →
    punchOut? (BI.inject j) (BI.inject j) ≡ nothing
  punchOut?-inject j = punchOut?-self (BI.inject j)

  -- Structural comparison: punchIn i j is either before or after inject i.
  punchIn-order-split :
    ∀ {n : Nat} (i : Fin (suc n)) (j : Fin n) →
    (punchIn i j <ᶠ i) ⊎ (i <ᶠ punchIn i j)
  punchIn-order-split fzero j = inj₂ z<s
  punchIn-order-split (fsuc i) fzero = inj₁ z<s
  punchIn-order-split (fsuc i) (fsuc j) with punchIn-order-split i j
  ... | inj₁ p = inj₁ (s<s p)
  ... | inj₂ p = inj₂ (s<s p)

  -- If punchOut? i k = just j, then k is punchIn i j.
  punchOut-just→punchIn :
    ∀ {n : Nat} (i : Fin (suc n)) (k : Fin (suc n)) (j : Fin n) →
    punchOut? i k ≡ just j →
    punchIn i j ≡ k
  punchOut-just→punchIn = punchIn-punchOut?

  -- If punchOut? i k = just j, obtain an order witness between k and inject i.
  -- This avoids any Bool/Dec-based comparison.
  punchOut-order :
    ∀ {n : Nat} (i : Fin (suc n)) (k : Fin (suc n)) (j : Fin n) →
    punchOut? i k ≡ just j →
    (k <ᶠ i) ⊎ (i <ᶠ k)
  punchOut-order i k j eq with punchIn-order-split i j
  ... | inj₁ p =
    inj₁ (subst (λ t → t <ᶠ i) (punchOut-just→punchIn i k j eq) p)
  ... | inj₂ p =
    inj₂ (subst (λ t → i <ᶠ t) (punchOut-just→punchIn i k j eq) p)

  -- If inject j < i, then punching j into i is still before i.
  inject<→punchIn< :
    ∀ {n : Nat} {i : Fin (suc (suc (suc n)))} {j : Fin (suc (suc n))} →
    BI.inject j <ᶠ i → punchIn i j <ᶠ i
  inject<→punchIn< {i = fzero} ()
  inject<→punchIn< {i = fsuc i} {j = fzero} z<s = z<s
  inject<→punchIn< {n = zero} {i = fsuc fzero} {j = fsuc fzero} (s<s ())
  inject<→punchIn< {n = zero} {i = fsuc (fsuc fzero)} {j = fsuc fzero} (s<s p) = s<s z<s
  inject<→punchIn< {n = suc n} {i = fsuc i} {j = fsuc j} (s<s p) =
    s<s (inject<→punchIn< {n = n} {i = i} {j = j} p)

  -- punchOut? alignment with predJ.
  punchOut?-predJ :
    ∀ {n : Nat}
      (i : Fin (suc (suc n)))
      (j : Fin (suc (suc (suc n))))
      (p : BI.inject i <ᶠ j) →
    punchOut? (BI.inject i) j ≡ just (BI.predJ j p)
  punchOut?-predJ i fzero ()
  punchOut?-predJ fzero (fsuc j₀) p = refl
  punchOut?-predJ {n = zero} (fsuc fzero) (fsuc (fsuc fzero)) (s<s p) = refl
  punchOut?-predJ {n = suc n} (fsuc i) (fsuc fzero) (s<s ())
  punchOut?-predJ {n = suc n} (fsuc i) (fsuc (fsuc j₀)) (s<s p)
    with punchOut?-predJ {n = n} i (fsuc j₀) p
  ... | ih rewrite ih = refl

  ----------------------------------------------------------------------
  -- Shared d² cancellation core (local helper)
  ----------------------------------------------------------------------

  d2-cancel-core :
    ∀ {ℓX : Level}
      (X : Nat → Set ℓX)
      (G : FA.AbGroup (ℓF ⊔ ℓX))
      {m : Nat}
      (ηm : X m → FA.AbGroup.Carrier G)
      (d : ∀ {k : Nat} → Fin (suc (suc k)) → X (suc k) → X k)
      (predJ :
        ∀ {k : Nat} {i : Fin (suc (suc k))} →
        (j : Fin (suc (suc (suc k)))) →
        (p : BI.inject i <ᶠ j) →
        Fin (suc (suc k)))
      (punchOut?-predJ :
        ∀ {k : Nat}
          (i : Fin (suc (suc k)))
          (j : Fin (suc (suc (suc k))))
          (p : BI.inject i <ᶠ j) →
        punchOut? (BI.inject i) j ≡ just (predJ j p))
      (face-face :
        ∀ {k : Nat}
          (i : Fin (suc (suc k)))
          (j : Fin (suc (suc (suc k))))
          (p : BI.inject i <ᶠ j)
          (x : X (suc (suc k))) →
        d i (d j x) ≡ d (predJ j p) (d (BI.inject i) x))
      (x : X (suc (suc m))) →
    altFin G {n = suc (suc (suc m))}
      (λ i → altFin G {n = suc (suc m)} (λ j → ηm (d j (d i x))))
      ≡ FA.AbGroup.0# G
  d2-cancel-core X G {m} ηm d predJ punchOut?-predJ face-face x =
    step-reindex ∙ pairwise-cancel
    where
      open FA.AbGroup G renaming
        (_+_ to _+G_; -_ to -G_; 0# to 0G
        ; assoc to assocG; comm to commG; idl to idlG; invl to invlG)
      open FA.AbGroupLemmas G

      F : Fin (suc (suc (suc m))) → Fin (suc (suc (suc m))) → FA.AbGroup.Carrier G
      F i k =
        caseMaybe
          (λ j → sgn G (after? i k) (ηm (d j (d i x))))
          0G
          (punchOut? i k)

      inner-reindexed :
        ∀ i →
          altFin G {n = suc (suc m)} (λ j → ηm (d j (d i x)))
          ≡
          altFin G {n = suc (suc (suc m))} (λ k → F i k)
      inner-reindexed i = reindex-altFin G i (λ j → ηm (d j (d i x)))

      step-reindex :
        altFin G {n = suc (suc (suc m))}
          (λ i → altFin G {n = suc (suc m)} (λ j → ηm (d j (d i x))))
        ≡
        altFin G {n = suc (suc (suc m))}
          (λ i → altFin G {n = suc (suc (suc m))} (λ k → F i k))
      step-reindex =
        altFin-cong G
          (λ i → altFin G (λ j → ηm (d j (d i x))))
          (λ i → altFin G (λ k → F i k))
          (λ i → inner-reindexed i)

      -- Local helper: evaluate F when punchOut? returns just.
      F-just :
        ∀ i k j →
        punchOut? i k ≡ just j →
        F i k ≡ sgn G (after? i k) (ηm (d j (d i x)))
      F-just i k j eq rewrite eq =
        caseMaybe-just
          (λ j' → sgn G (after? i k) (ηm (d j' (d i x))))
          0G
          j

      -- Local helper: evaluate F when punchOut? returns nothing.
      F-nothing :
        ∀ i k →
        punchOut? i k ≡ nothing →
        F i k ≡ 0G
      F-nothing i k eq rewrite eq =
        caseMaybe-nothing
          (λ j → sgn G (after? i k) (ηm (d j (d i x))))
          0G

      -- Canonical pair cancellation for a fixed orbit.
      pair-cancel :
        ∀ i k j →
        (eq : punchOut? i k ≡ just j) →
        (p : BI.inject j <ᶠ i) →
        F i k +G F (BI.inject j) i ≡ 0G
      pair-cancel i k j eq p =
        let
          FiK : F i k ≡ sgn G (after? i k) (ηm (d j (d i x)))
          FiK = F-just i k j eq

          k< : k <ᶠ i
          k< = subst (λ t → t <ᶠ i) (punchOut-just→punchIn i k j eq)
                (inject<→punchIn< p)

          aFalse : after? i k ≡ false
          aFalse = after?-gt k<

          aTrue : after? (BI.inject j) i ≡ true
          aTrue = after?-lt p

          partner :
            punchOut? (BI.inject j) i ≡ just (predJ i p)
          partner = punchOut?-predJ j i p

          Fpartner :
            F (BI.inject j) i
            ≡
            sgn G (after? (BI.inject j) i)
              (ηm (d (predJ i p) (d (BI.inject j) x)))
          Fpartner =
            F-just (BI.inject j) i (predJ i p) partner

          payload :
            ηm (d j (d i x)) ≡
            ηm (d (predJ i p) (d (BI.inject j) x))
          payload = congG ηm (face-face j i p x)
        in
        congG (λ t → t +G F (BI.inject j) i) FiK
        ∙ congG (λ t → sgn G (after? i k) t +G F (BI.inject j) i) payload
        ∙ congG (λ t → sgn G (after? i k) (ηm (d (predJ i p) (d (BI.inject j) x))) +G t) Fpartner
        ∙ congG (λ t → sgn G (after? i k) (ηm (d (predJ i p) (d (BI.inject j) x))) +G t)
            (congG (λ b → sgn G b (ηm (d (predJ i p) (d (BI.inject j) x)))) aTrue)
        ∙ congG (λ t → t +G sgn G true (ηm (d (predJ i p) (d (BI.inject j) x))))
            (congG (λ b → sgn G b (ηm (d (predJ i p) (d (BI.inject j) x)))) aFalse)
        ∙ invr (ηm (d (predJ i p) (d (BI.inject j) x)))

      ----------------------------------------------------------------------
      -- Plumbing: punchOut?/punchIn alignment (local, structural)
      ----------------------------------------------------------------------

      -- Universe-polymorphic empty elimination.
      ⊥-elimℓ : ∀ {ℓ} {A : Set ℓ} → ⊥ → A
      ⊥-elimℓ ()

      -- If punchOut? i k = nothing, then i ≡ k (structural recursion).
      just≠nothing : ∀ {ℓ} {A : Set ℓ} {a : A} → just a ≡ nothing → ⊥
      just≠nothing ()

      punchOut?-fzero-fsuc :
        ∀ {n : Nat} (k : Fin n) →
        punchOut? fzero (fsuc k) ≡ just k
      punchOut?-fzero-fsuc k = punchOut?-punchIn fzero k

      punchOut?-fsuc-fzero :
        ∀ {n : Nat} (i : Fin (suc n)) →
        punchOut? (fsuc i) fzero ≡ just fzero
      punchOut?-fsuc-fzero i = punchOut?-punchIn (fsuc i) fzero

      punchOut?-nothing→eq :
        ∀ {n : Nat} (i k : Fin (suc n)) →
        punchOut? i k ≡ nothing → i ≡ k
      punchOut?-nothing→eq fzero fzero eq = refl
      punchOut?-nothing→eq fzero (fsuc k) eq
        =
          ⊥-elimℓ (just≠nothing (symG (punchOut?-fzero-fsuc k) ∙G eq))
      punchOut?-nothing→eq {n = suc n} (fsuc i) fzero eq
        =
          ⊥-elimℓ (just≠nothing (symG (punchOut?-fsuc-fzero i) ∙G eq))
      punchOut?-nothing→eq {n = suc n} (fsuc i) (fsuc k) eq with punchOut? i k in eqik
      ... | nothing = congG fsuc (punchOut?-nothing→eq i k eqik)
      ... | just j with eq
      ...   | ()

      -- If the inserted index lands strictly before i, then punchIn i j is inject j.
      punchIn<→inject :
        ∀ {n : Nat} (i : Fin (suc (suc (suc n)))) (j : Fin (suc (suc n))) →
        punchIn i j <ᶠ i → punchIn i j ≡ BI.inject j
      punchIn<→inject fzero j ()
      punchIn<→inject (fsuc i) fzero z<s = refl
      punchIn<→inject {n = zero} (fsuc fzero) (fsuc fzero) (s<s ())
      punchIn<→inject {n = zero} (fsuc (fsuc fzero)) (fsuc fzero) (s<s p) = refl
      punchIn<→inject {n = suc n} (fsuc i) (fsuc j) (s<s p) =
        congG fsuc (punchIn<→inject {n = n} i j p)

      ----------------------------------------------------------------------
      -- F is antisymmetric (and diagonal-zero)
      ----------------------------------------------------------------------

      F-diag0 : ∀ i → F i i ≡ 0G
      F-diag0 i = F-nothing i i (punchOut?-self i)

      F-anti-lt : ∀ i k → i <ᶠ k → F i k ≡ -G_ (F k i)
      F-anti-lt i k p with punchOut? k i in eqki
      ... | nothing =
        ⊥-elimℓ (<-irrefl
          (subst (λ t → i <ᶠ t)
            (punchOut?-nothing→eq k i eqki) p))
      ... | just j =
        let
          iEq : punchIn k j ≡ i
          iEq = punchIn-punchOut? k i j eqki

          lessPunch : punchIn k j <ᶠ k
          lessPunch = subst (λ t → t <ᶠ k) (symG iEq) p

          injEq' : punchIn k j ≡ BI.inject j
          injEq' = punchIn<→inject k j lessPunch

          injEq : BI.inject j ≡ i
          injEq = symG injEq' ∙G iEq

          pInj : BI.inject j <ᶠ k
          pInj = subst (λ t → t <ᶠ k) (symG injEq) p

          pc : F k i +G F (BI.inject j) k ≡ 0G
          pc = pair-cancel k i j eqki pInj

          rewritePartner : F (BI.inject j) k ≡ F i k
          rewritePartner = congG (λ t → F t k) injEq

          sum0' : F k i +G F i k ≡ 0G
          sum0' = symG (congG (λ t → F k i +G t) rewritePartner) ∙G pc

          sum0 : F i k +G F k i ≡ 0G
          sum0 = commG (F i k) (F k i) ∙G sum0'
        in
        subst (λ t → F i k ≡ -G_ t) (F-just k i j eqki)
          (invUniqueR (F k i) (F i k) (-G_ (F k i)) sum0 (invlG (F k i)))

      F-anti-gt : ∀ i k → k <ᶠ i → F i k ≡ -G_ (F k i)
      F-anti-gt i k p with punchOut? i k in eqik
      ... | nothing =
        ⊥-elimℓ (<-irrefl
          (subst (λ t → k <ᶠ t)
            (punchOut?-nothing→eq i k eqik) p))
      ... | just j =
        let
          kEq : punchIn i j ≡ k
          kEq = punchIn-punchOut? i k j eqik

          lessPunch : punchIn i j <ᶠ i
          lessPunch = subst (λ t → t <ᶠ i) (symG kEq) p

          injEq' : punchIn i j ≡ BI.inject j
          injEq' = punchIn<→inject i j lessPunch

          injEq : BI.inject j ≡ k
          injEq = symG injEq' ∙G kEq

          pInj : BI.inject j <ᶠ i
          pInj = subst (λ t → t <ᶠ i) (symG injEq) p

          pc : F i k +G F (BI.inject j) i ≡ 0G
          pc = pair-cancel i k j eqik pInj

          rewritePartner : F (BI.inject j) i ≡ F k i
          rewritePartner = congG (λ t → F t i) injEq

          sum0 : F i k +G F k i ≡ 0G
          sum0 = symG (congG (λ t → F i k +G t) rewritePartner) ∙G pc
        in
        subst (λ t → t ≡ -G_ (F k i)) (F-just i k j eqik)
          (invUniqueR (F k i) (F i k) (-G_ (F k i)) sum0 (invlG (F k i)))

      -- Antisymmetry: F i k = - F k i (all sizes).
      F-anti : ∀ i k → F i k ≡ -G_ (F k i)
      F-anti i k with compareFin i k
      ... | inj₂ (inj₁ eq) =
        let Fi : F i i ≡ 0G
            Fi = F-diag0 i
        in
        subst (λ t → F i t ≡ -G_ (F t i)) eq
          (Fi ∙G zero-neg ∙G congG -G_ (symG Fi))
      ... | inj₁ p = F-anti-lt i k p
      ... | inj₂ (inj₂ p) = F-anti-gt i k p

      ----------------------------------------------------------------------
      -- Finish: antisymmetry closes the double sum
      ----------------------------------------------------------------------

      pairwise-cancel :
        altFin G {n = suc (suc (suc m))}
          (λ i → altFin G {n = suc (suc (suc m))} (λ k → F i k)) ≡ 0G
      pairwise-cancel =
        altFin2-antisym G {n = suc (suc (suc m))} F F-diag0 F-anti

  ----------------------------------------------------------------------
  -- Horizontal generator cancellation: Qt²Onη
  ----------------------------------------------------------------------

  -- The alternating double boundary vanishes on generators (horizontal).
  Qt²Onη-proof : ∀ m n → Qt²Onη m n
  Qt²Onη-proof m n x =
    let
      G = C m n
      open FA.AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G; invl to invlG)
      open FA.AbGroupLemmas G

      -- Expand Qt² on a generator into a double alternating sum.
      step₁ :
        f (Qt²Hom m n) (η x)
        ≡
        altFin G (λ i → altFin G (λ j → η (dH j (dH i x))))
      step₁ =
        congG (f (Qt {m} {n}))
          (liftHom-β-η (C (suc m) n) (∂H-gen {suc m} {n}) x)
        ∙ altFin-map (Qt {m} {n}) (λ i → η (dH i x))
        ∙ altFin-cong G
            (λ i → f (Qt {m} {n}) (η (dH i x)))
            (λ i → ∂H-gen (dH i x))
            (λ i → liftHom-β-η G (∂H-gen {m} {n}) (dH i x))

      -- Core cancellation lemma for the horizontal faces.
      d2-cancel :
        altFin G (λ i → altFin G (λ j → η (dH j (dH i x))))
        ≡ 0G
      d2-cancel =
        d2-cancel-core
          (λ k → Obj k n)
          G
          {m = m}
          (λ y → η y)
          (λ {k} i y → dH i y)
          BI.predJ
          punchOut?-predJ
          (λ {k} i j p y → faceH-faceH i j p y)
          x
    in
    step₁ ∙ d2-cancel

  ----------------------------------------------------------------------
  -- Vertical generator cancellation: Qu²Onη
  ----------------------------------------------------------------------

  Qu²Onη-proof : ∀ m n → Qu²Onη m n
  Qu²Onη-proof m n x =
    let
      G = C m n
      open FA.AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G; invl to invlG)
      open FA.AbGroupLemmas G

      step₁ :
        f (Qu²Hom m n) (η x)
        ≡
        sgn G (parity m)
          (altFin G (λ i → sgn G (parity m)
            (altFin G (λ j → η (dV j (dV i x))))))
      step₁ =
        congG (f (Qu {m} {n}))
          (liftHom-β-η (C m (suc n))
            (λ y → sgn (C m (suc n)) (parity m) (∂V-gen {m = m} {n = suc n} y))
            x)
        ∙ hom-sgn (Qu {m} {n}) (parity m)
            (∂V-gen {m = m} {n = suc n} x)
        ∙ congG (sgn G (parity m))
            (altFin-map (Qu {m} {n}) (λ i → η (dV i x)))
        ∙ congG (sgn G (parity m))
            (altFin-cong G
              (λ i → f (Qu {m} {n}) (η (dV i x)))
              (λ i → sgn G (parity m) (∂V-gen {m = m} {n = n} (dV i x)))
              (λ i →
                liftHom-β-η G
                  (λ y → sgn G (parity m) (∂V-gen {m = m} {n = n} y))
                  (dV i x)))

      -- Pull the Koszul sign through twice.
      step₂ :
        sgn G (parity m)
          (altFin G (λ i → sgn G (parity m)
            (altFin G (λ j → η (dV j (dV i x))))))
        ≡
        altFin G (λ i → altFin G (λ j → η (dV j (dV i x))))
      step₂ =
        sgn-altFin G (parity m)
          (λ i → sgn G (parity m)
            (altFin G (λ j → η (dV j (dV i x)))))
        ∙ altFin-cong G
            (λ i → sgn G (parity m)
              (sgn G (parity m)
                (altFin G (λ j → η (dV j (dV i x))))))
            (λ i → altFin G (λ j → η (dV j (dV i x))))
            (λ i →
              sgn-invol G (parity m)
                (altFin G (λ j → η (dV j (dV i x)))))

      d2-cancel :
        altFin G (λ i → altFin G (λ j → η (dV j (dV i x))))
        ≡ 0G
      d2-cancel =
        d2-cancel-core
          (λ k → Obj m k)
          G
          {m = n}
          (λ y → η y)
          (λ {k} i y → dV i y)
          BI.predJ
          punchOut?-predJ
          (λ {k} i j p y → faceV-faceV i j p y)
          x
    in
    step₁ ∙ step₂ ∙ d2-cancel

  ----------------------------------------------------------------------
  -- Mixed anticommutation on generators: AnticommOnη
  ----------------------------------------------------------------------

  AnticommOnη-proof : ∀ m n → AnticommOnη m n
  AnticommOnη-proof m n x =
    let
      G = C m n
      open FA.AbGroup G renaming (_+_ to _+G_; -_ to -G_; 0# to 0G)
      open FA.AbGroupLemmas G

      -- Expand the mixed composite on a generator.
      left-term :
        f (Qt {m} {n} FA.∘ Qu {m = suc m} {n = n}) (η x)
        ≡
        sgn G (parity (suc m))
          (altFin G (λ j → altFin G (λ i → η (dH i (dV j x)))))
      left-term =
        congG (f (Qt {m} {n}))
          (liftHom-β-η (C (suc m) n)
            (λ y → sgn (C (suc m) n) (parity (suc m)) (∂V-gen {m = suc m} {n = n} y))
            x)
        ∙ hom-sgn (Qt {m} {n}) (parity (suc m))
            (∂V-gen {m = suc m} {n = n} x)
        ∙ congG (sgn G (parity (suc m)))
            (altFin-map (Qt {m} {n}) (λ j → η (dV j x)))
        ∙ congG (sgn G (parity (suc m)))
            (altFin-cong G
              (λ j → f (Qt {m} {n}) (η (dV j x)))
              (λ j → ∂H-gen (dV j x))
              (λ j → liftHom-β-η G (∂H-gen {m} {n}) (dV j x)))

      right-term :
        f (Qu {m} {n} FA.∘ Qt {m = m} {n = suc n}) (η x)
        ≡
        altFin G (λ i → sgn G (parity m)
          (altFin G (λ j → η (dV j (dH i x)))))
      right-term =
        congG (f (Qu {m} {n}))
          (liftHom-β-η (C m (suc n)) (∂H-gen {m} {suc n}) x)
        ∙ altFin-map (Qu {m} {n}) (λ i → η (dH i x))
        ∙ altFin-cong G
            (λ i → f (Qu {m} {n}) (η (dH i x)))
            (λ i → sgn G (parity m) (∂V-gen {m = m} {n = n} (dH i x)))
            (λ i →
              liftHom-β-η G
                (λ y → sgn G (parity m) (∂V-gen {m = m} {n = n} y))
                (dH i x))

      -- Core anticommute cancellation (using face commutation and Koszul shift).
      anticomm-cancel :
        f (anticommHom m n) (η x) ≡ 0G
      anticomm-cancel =
        let
          termL =
            sgn G (parity (suc m))
              (altFin G (λ j → altFin G (λ i → η (dH i (dV j x)))))

          termR =
            altFin G (λ i → sgn G (parity m)
              (altFin G (λ j → η (dV j (dH i x)))))

          t : Fin (suc (suc m)) → Fin (suc (suc n)) → FA.AbGroup.Carrier G
          t i j = η (dV j (dH i x))

          termL≡ :
            termL ≡
            sgn G (parity (suc m))
              (altFin G (λ j → altFin G (λ i → t i j)))
          termL≡ =
            congG (sgn G (parity (suc m)))
              (altFin-cong G
                (λ j → altFin G (λ i → η (dH i (dV j x))))
                (λ j → altFin G (λ i → t i j))
                (λ j →
                  altFin-cong G
                    (λ i → η (dH i (dV j x)))
                    (λ i → t i j)
                    (λ i → congG η (faceH-faceV-comm i j x))))

          termL→common :
            termL ≡
            altFin G (λ i → altFin G (λ j → sgn G (parity (suc m)) (t i j)))
          termL→common =
            termL≡
            ∙ congG (sgn G (parity (suc m)))
                (altFin-swap G (λ j i → t i j))
            ∙ sgn-altFin G (parity (suc m)) (λ i → altFin G (λ j → t i j))
            ∙ altFin-cong G
                (λ i → sgn G (parity (suc m)) (altFin G (λ j → t i j)))
                (λ i → altFin G (λ j → sgn G (parity (suc m)) (t i j)))
                (λ i → sgn-altFin G (parity (suc m)) (λ j → t i j))

          termR→common :
            termR ≡
            altFin G (λ i → altFin G (λ j → sgn G (parity m) (t i j)))
          termR→common =
            altFin-cong G
              (λ i → sgn G (parity m) (altFin G (λ j → t i j)))
              (λ i → altFin G (λ j → sgn G (parity m) (t i j)))
              (λ i → sgn-altFin G (parity m) (λ j → t i j))

          pointwise0 :
            ∀ i j →
              (sgn G (parity (suc m)) (t i j))
              +G
              (sgn G (parity m) (t i j))
              ≡ 0G
          pointwise0 i j =
            let s = sgn G (parity m) (t i j) in
            congG (λ u → u +G s)
              (congG (λ b → sgn G b (t i j)) (parity-suc m)
               ∙ sgn-not G (parity m) (t i j))
            ∙ FA.AbGroup.invl G s

          sumCommon0 :
            (altFin G (λ i → altFin G (λ j → sgn G (parity (suc m)) (t i j))))
            +G
            (altFin G (λ i → altFin G (λ j → sgn G (parity m) (t i j))))
            ≡ 0G
          sumCommon0 =
            sym (altFin-+ G
              (λ i → altFin G (λ j → sgn G (parity (suc m)) (t i j)))
              (λ i → altFin G (λ j → sgn G (parity m) (t i j))))
            ∙ altFin-cong G
                (λ i →
                  altFin G (λ j → sgn G (parity (suc m)) (t i j))
                  +G
                  altFin G (λ j → sgn G (parity m) (t i j)))
                (λ (i : Fin (suc (suc m))) →
                  altFin G {n = suc (suc n)} (λ (_ : Fin (suc (suc n))) → 0G))
                (λ i →
                  sym (altFin-+ G
                        (λ j → sgn G (parity (suc m)) (t i j))
                        (λ j → sgn G (parity m) (t i j)))
                  ∙ altFin-cong G
                      (λ j →
                        (sgn G (parity (suc m)) (t i j))
                        +G
                        (sgn G (parity m) (t i j)))
                      (λ (_ : Fin (suc (suc n))) → 0G)
                      (pointwise0 i)
                  )
            ∙ altFin-cong G
                (λ (_ : Fin (suc (suc m))) →
                  altFin G {n = suc (suc n)} (λ (_ : Fin (suc (suc n))) → 0G))
                (λ (_ : Fin (suc (suc m))) → 0G)
                (λ _ → altFin-zero G {n = suc (suc n)})
            ∙ altFin-zero G {n = suc (suc m)}
        in
        congG (λ a → a +G f (Qu {m} {n} FA.∘ Qt {m} {n = suc n}) (η x)) left-term
        ∙ congG (λ b → termL +G b) right-term
        ∙ congG (λ a → a +G termR) termL→common
        ∙ congG (λ b →
              (altFin G (λ i → altFin G (λ j → sgn G (parity (suc m)) (t i j))))
              +G b) termR→common
        ∙ sumCommon0
    in
    anticomm-cancel

  ----------------------------------------------------------------------
  -- Export a closed term
  ----------------------------------------------------------------------

  bicomplex : BicomplexIdentities
  bicomplex =
    bicomplexFromη Qt²Onη-proof Qu²Onη-proof AnticommOnη-proof

open Inst public
```
