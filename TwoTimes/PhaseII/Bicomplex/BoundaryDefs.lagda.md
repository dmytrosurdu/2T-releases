# TwoTimes/PhaseII/Bicomplex/BoundaryDefs.lagda.md

Phase II (Batch 8): **boundary definitions** for a bicomplex built from a
bisimplicial object.

Given:

* a bisimplicial object `X` with faces `dH`/`dV` (via `BisimplicialIF`),
* an extended free-abelian interface `FreeAbIF_Ext`,

we define:

* chain groups `C m n = FreeAb (X m n)`,
* generator-level boundaries `∂H-gen`, `∂V-gen` as alternating sums of faces,
* induced homomorphisms `Qt`, `Qu` via freeness (`liftHom`),
* composite homs `Qt²Hom`, `Qu²Hom`, and `anticommHom` (the anticommutator map).

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.PhaseII.Bicomplex.BoundaryDefs where

open import Agda.Primitive using (Level; _⊔_)
open import Agda.Builtin.Nat using (Nat; suc)

import TwoTimes.PhaseII.Bicomplex.BisimplicialIF as BI
import TwoTimes.Bicomplex.FreeAbIF_Extensions as FA
import TwoTimes.Algebra.SumFin as SumFin
import TwoTimes.Algebra.Sign as Sign

module Inst {ℓX ℓF : Level}
  (E : FA.FreeAbIF_Ext ℓF)
  (B : BI.BisimplicialIF ℓX)
  where

  open BI.BisimplicialIF B public
    renaming (X to Obj)

  module F = FA.FreeAbIF_ExtOps E
  open F public using (FreeAb; η; liftHom)

  -- Chain groups: free abelian group on the bisimplicial object at (m,n).
  C : Nat → Nat → FA.AbGroup (ℓF ⊔ ℓX)
  C m n = FreeAb (Obj m n)

  -- Generator-level horizontal boundary: alternating sum of horizontal faces.
  ∂H-gen : ∀ {m n : Nat} → Obj (suc m) n → FA.AbGroup.Carrier (C m n)
  ∂H-gen {m} {n} x =
    SumFin.altFin (C m n) (λ i → η (dH i x))

  -- Generator-level vertical boundary: alternating sum of vertical faces.
  ∂V-gen : ∀ {m n : Nat} → Obj m (suc n) → FA.AbGroup.Carrier (C m n)
  ∂V-gen {m} {n} x =
    SumFin.altFin (C m n) (λ j → η (dV j x))

  -- Horizontal boundary hom: Qt : C (m+1,n) → C (m,n)
  Qt : ∀ {m n : Nat} → FA.Hom (C (suc m) n) (C m n)
  Qt {m} {n} =
    liftHom (C m n) (∂H-gen {m = m} {n = n})

  -- Vertical boundary hom with Koszul sign twist (-1)^m:
  -- Qu : C (m,n+1) → C (m,n)
  Qu : ∀ {m n : Nat} → FA.Hom (C m (suc n)) (C m n)
  Qu {m} {n} =
    liftHom (C m n)
      (λ x → Sign.sgn (C m n) (Sign.parity m) (∂V-gen {m = m} {n = n} x))

  -- Convenience composites (definition layer only).

  Qt²Hom : ∀ (m n : Nat) → FA.Hom (C (suc (suc m)) n) (C m n)
  Qt²Hom m n = Qt {m = m} {n = n} FA.∘ Qt {m = suc m} {n = n}

  Qu²Hom : ∀ (m n : Nat) → FA.Hom (C m (suc (suc n))) (C m n)
  Qu²Hom m n = Qu {m = m} {n = n} FA.∘ Qu {m = m} {n = suc n}

  anticommHom : ∀ (m n : Nat) → FA.Hom (C (suc m) (suc n)) (C m n)
  anticommHom m n =
    FA.addHom
      (Qt {m = m} {n = n} FA.∘ Qu {m = suc m} {n = n})
      (Qu {m = m} {n = n} FA.∘ Qt {m = m} {n = suc n})

open Inst public
```
