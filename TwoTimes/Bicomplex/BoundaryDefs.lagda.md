```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Bicomplex.BoundaryDefs where
```

# Shared boundary definitions (Batch 3 core)

This module centralizes the definitions of the grid chain groups and the
horizontal/vertical boundaries so the “definition layer” matches the Batch 3
proof layer.

---

## Imports

```agda
open import Agda.Primitive using (Level; _⊔_)
open import Agda.Builtin.Nat using (Nat; suc)

open import TwoTimes.Process.Grid.Presentation using (Group)
import TwoTimes.Process.Grid.Nerve as N

import TwoTimes.Bicomplex.FreeAbIF_Extensions as FAE
open FAE using (AbGroup; Hom; _∘_; addHom; FreeAbIF_Ext)

open import TwoTimes.Algebra.Sign using (sgn; parity)
open import TwoTimes.Algebra.SumFin using (altFin)
```

---

## Core definitions (parameterized)

```agda
module BoundaryDefs {ℓT ℓF : Level} (Time : Group ℓT) (FA : FreeAbIF_Ext ℓF) where

  open FAE.FreeAbIF_ExtOps FA using (FreeAb; η; liftHom)
  open N.Grid Time using (dH; dV) renaming (Grid to Grid₀)

  -- Chain group at bidegree (m,n)
  C : Nat → Nat → AbGroup (ℓF ⊔ ℓT)
  C m n = FreeAb (Grid₀ m n)

  -- Horizontal boundary on generators
  ∂H-gen : ∀ {m n : Nat} → Grid₀ (suc m) n → AbGroup.Carrier (C m n)
  ∂H-gen {m} {n} x =
    altFin (C m n) (λ i → η (dH i x))

  -- Vertical boundary on generators (with twist (-1)^m)
  ∂V-gen : ∀ {m n : Nat} → Grid₀ m (suc n) → AbGroup.Carrier (C m n)
  ∂V-gen {m} {n} x =
    sgn (C m n) (parity m)
      (altFin (C m n) (λ j → η (dV j x)))

  -- Differentials
  Qt : ∀ {m n : Nat} → Hom (C (suc m) n) (C m n)
  Qt {m} {n} = liftHom (C m n) (∂H-gen {m} {n})

  Qu : ∀ {m n : Nat} → Hom (C m (suc n)) (C m n)
  Qu {m} {n} = liftHom (C m n) (∂V-gen {m} {n})

  -- Composite homomorphisms used in proofs
  Qt²Hom : ∀ (m n : Nat) → Hom (C (suc (suc m)) n) (C m n)
  Qt²Hom m n = Qt {m} {n} ∘ Qt {suc m} {n}

  Qu²Hom : ∀ (m n : Nat) → Hom (C m (suc (suc n))) (C m n)
  Qu²Hom m n = Qu {m} {n} ∘ Qu {m} {suc n}

  anticommHom : ∀ (m n : Nat) → Hom (C (suc m) (suc n)) (C m n)
  anticommHom m n =
    addHom (Qt {m} {n} ∘ Qu {suc m} {n})
           (Qu {m} {n} ∘ Qt {m} {suc n})
```
