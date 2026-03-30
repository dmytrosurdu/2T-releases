```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Obstruction.Nontrivial where
```

# Nontriviality of ω from an existential detector axiom A_det (Phase I)

This module states and proves the Phase I nontriviality result:

* We define what it means for the ω-functor (into `BZ₂`) to be **trivial**.
* We postulate a minimal *detector axiom* `A_det` giving an existential witness
  of a loop whose ω-value is `true`.
* From `A_det`, we derive that ω is **not** trivial.

> **Team note**
>
> * This module is intentionally agnostic about how `loop` is constructed (from SK squares).
> * The only required link is that the loop generator used in `Obstruction/Omega.agda`
>   corresponds to the square-loop action you build in Track B.
> * If later you use a different presentation (e.g. multiple loop generators, or
>   loop indexed by (t,u)), update `A_det` accordingly.

---

## Imports

```agda
open import Agda.Primitive using (Level; lsuc; _⊔_)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Sigma using (Σ; _,_)

open import TwoTimes.Prelude.Path

-- empty type
data ⊥ : Set where

infix 4 _≠_
_≠_ : ∀ {ℓ} {A : Set ℓ} → A → A → Set ℓ
x ≠ y = x ≡ y → ⊥

open import TwoTimes.Process.Grid.Presentation using (Group)
import TwoTimes.Obstruction.Omega as Ω
```

---

## Triviality notion for ω

We work inside the parameterized setting of `Obstruction/Omega.agda`:

* `Proc r s` is the presented morphism syntax,
* `≈` is the presented relation,
* `ω : Proc r s → Bool` is the parity map (functor to BZ₂).

A natural “triviality” condition is:

> ω is trivial iff ω(p) = false for all morphisms p.

This is stronger than “cohomologically trivial up to coboundary,” but it is exactly what
Phase I needs and matches the existential witness formulation.



---

## Detector axiom A_det (existential nontriviality)

## Main statement

```agda
module _ {ℓT ℓR : Level}
         (Time : Group ℓT)
         (RD   : Ω.RecordDynamics {ℓT} {ℓR} Time)
         where

  open Ω.ΩInst Time RD

  -- Triviality notion
  Trivialω : Set (ℓT ⊔ ℓR)
  Trivialω = ∀ {r s : R} (p : Proc r s) → ω p ≡ false

  -- Detector axiom
  A_det : Set ℓR
  A_det = Σ R (λ r → ω (loop r) ≡ true)

  -- A_det implies ω is not everywhere-false
  nontrivial-from-A_det : A_det → Trivialω → ⊥
  nontrivial-from-A_det (r , ωloop≡true) triv =
    let ωloop≡false : ω (loop r) ≡ false
        ωloop≡false = triv (loop r)
    in
    true≠false (trans (sym ωloop≡true) ωloop≡false)
    where
    true≠false : true ≡ false → ⊥
    true≠false ()

  ¬Trivialω : Set (ℓT ⊔ ℓR)
  ¬Trivialω = Trivialω → ⊥

  -- Packaged theorem
  theorem : A_det → ¬Trivialω
  theorem det triv = nontrivial-from-A_det det triv
```
