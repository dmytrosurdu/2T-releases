# TwoTimes/Integration/Splitting5.lagda.md

Batch 6: **splitting ↔ coboundary** for the canonical Z₂-cover induced by `ω₅`.

We work entirely in presentation/setoid style (modulo `≈₅` and `≈~`), with no
funext, no truncation, no HIT cohomology.

Main exports (inside `Inst`):

* `SplitCover` (a section/lift structure, functorial up to `≈~`)
* `split→coboundary` and `coboundary→split`
* `SqLoopTrue → ¬ SplitCover` (odd square-loop obstructs splitting)

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Integration.Splitting5 where

open import Agda.Primitive using (Level; _⊔_; lsuc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat)
open import Agda.Builtin.Sigma using (Σ; _,_; fst; snd)
open import Data.Empty using (⊥)

open import TwoTimes.Prelude.Path using (sym; trans; cong)
open import TwoTimes.Z2.XorLemmas using (xor)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Integration.TwoTimeRecordIF as IF
import TwoTimes.Integration.RecordProc5 as RP5
import TwoTimes.Integration.Omega5 as Ω5
import TwoTimes.Integration.Coboundary5 as CB5
import TwoTimes.Integration.Z2Cover5 as Cover5

infix 3 ¬_
¬_ : ∀ {ℓ} → Set ℓ → Set ℓ
¬ A = A → ⊥

-- --------------------------------------------------------------------------
-- Splitting ↔ coboundary (parameterized by Time and interface I)
-- --------------------------------------------------------------------------

module Inst {ℓT ℓR : Level}
  (Time : Pres.Group ℓT)
  (I    : IF.TwoTimeRecordIF {ℓT = ℓT} {ℓR = ℓR} Time)
  where

  open RP5.Inst Time I public
    using (R; Proc₅; _≈₅_; id; _⨟_; inv; toCorner)

  open IF using (diag; bridge)

  open Ω5.Inst Time I public
    using (ω₅; ω₅-resp; ω₅-toCorner-diag; ω₅-toCorner-bridge)

  open CB5.Inst Time I public
    using ( IsCoboundary; IsCoboundaryω₅
          ; LoopTrue; SqLoopTrue; SqLoopTrue→LoopTrue
          ; loopTrue→¬Coboundary
          ; SectionForm→Sym
          )

  open Cover5.Inst Time I public
    using ( Obj~; Hom~; _≈~_
          ; Cover5Groupoid
          ; πObj; πHom
          )

  -- ------------------------------------------------------------------------
  -- Splitting structure (minimal but functorial up to ≈~)
  -- ------------------------------------------------------------------------

  record SplitCover : Set (lsuc (ℓT ⊔ ℓR)) where
    field
      s    : R → Bool

      -- Lift any base morphism p : r → s' to a cover morphism between
      -- the chosen section objects (r , s r) and (s' , s s').
      lift : ∀ {r s'} → Proc₅ r s' → Hom~ (r , s r) (s' , s s')

      -- Projection correctness (setoid-level): πHom (lift p) ≈₅ p.
      lift-π :
        ∀ {r s'} (p : Proc₅ r s') →
        πHom {x = (r , s r)} {y = (s' , s s')} (lift p) ≈₅ p

      -- Functorial laws, all up to ≈~ (never compare parity proof components).
      lift-id  :
        ∀ (r : R) →
        _≈~_ {x = (r , s r)} {y = (r , s r)}
          (lift (id r))
          (Cover5Groupoid .Cover5.GroupoidS.id (r , s r))

      lift-comp :
        ∀ {r s' t} (p : Proc₅ r s') (q : Proc₅ s' t) →
        _≈~_ {x = (r , s r)} {y = (t , s t)}
          (lift (p ⨟ q))
          (Cover5Groupoid .Cover5.GroupoidS._∘_
            {x = (r , s r)} {y = (s' , s s')} {z = (t , s t)}
            (lift q) (lift p))

      lift-inv :
        ∀ {r s'} (p : Proc₅ r s') →
        _≈~_ {x = (s' , s s')} {y = (r , s r)}
          (lift (inv p))
          (Cover5Groupoid .Cover5.GroupoidS.inv (lift p))

      lift-resp :
        ∀ {r s'} {p q : Proc₅ r s'} → p ≈₅ q →
        _≈~_ {x = (r , s r)} {y = (s' , s s')} (lift p) (lift q)

  -- ------------------------------------------------------------------------
  -- split → coboundary (extract section equation from the lift constraint)
  --
  -- Coboundary is defined in “section form”:
  --   Σ s : R→Bool , ∀ p : r→s' , s s' ≡ xor (s r) (ω₅ p)
  --
  -- Here that equation is exactly the second component of lift p.
  -- ------------------------------------------------------------------------

  split→coboundary : SplitCover → IsCoboundaryω₅
  split→coboundary sp =
    SplitCover.s sp , λ {r} {s'} p →
      trans
        (snd (SplitCover.lift sp p))
        (cong (λ x → xor (SplitCover.s sp r) x)
          (ω₅-resp (SplitCover.lift-π sp p)))

  split→ω₅-parallel :
    SplitCover → ∀ {r s : R} (p q : Proc₅ r s) → ω₅ p ≡ ω₅ q
  split→ω₅-parallel sp {r} {s} p q =
    let
      cob = split→coboundary sp
      sec = SectionForm→Sym cob
      σ = fst sec
      symForm = snd sec
    in
      trans (symForm p) (sym (symForm q))

  -- ------------------------------------------------------------------------
  -- coboundary → split (build the canonical splitting by choosing lift p = (p , eq))
  -- ------------------------------------------------------------------------

  coboundary→split : IsCoboundaryω₅ → SplitCover
  coboundary→split (s , eq) = mk
    where
      mk : SplitCover
      mk .SplitCover.s = s
      mk .SplitCover.lift {r} {s'} p = p , eq p
      mk .SplitCover.lift-π p = RP5.≈-refl
      mk .SplitCover.lift-id r =
        record
          { base≈ = RP5.≈-refl
          ; dom-parity = refl
          ; cod-parity = refl
          }
      mk .SplitCover.lift-comp p q =
        record
          { base≈ = RP5.≈-refl
          ; dom-parity = refl
          ; cod-parity = refl
          }
      mk .SplitCover.lift-inv p =
        record
          { base≈ = RP5.≈-refl
          ; dom-parity = refl
          ; cod-parity = refl
          }
      mk .SplitCover.lift-resp h =
        record
          { base≈ = h
          ; dom-parity = refl
          ; cod-parity = refl
          }

  -- ------------------------------------------------------------------------
  -- Consequence: an odd loop obstructs splitting (via coboundary obstruction).
  -- ------------------------------------------------------------------------

  sqLoopTrue→¬Split : SqLoopTrue → ¬ SplitCover
  sqLoopTrue→¬Split sqT sp =
    loopTrue→¬Coboundary (SqLoopTrue→LoopTrue sqT) (split→coboundary sp)

  false≢true : false ≡ true → ⊥
  false≢true ()

  cornerPathsObstructSplit :
    ∀ (t : Pres.Group.Carrier Time) (u : Nat) (r : R) → ¬ SplitCover
  cornerPathsObstructSplit t u r sp =
    let
      eqPar : ω₅ (toCorner diag t u r) ≡ ω₅ (toCorner bridge t u r)
      eqPar = split→ω₅-parallel sp (toCorner diag t u r) (toCorner bridge t u r)

      false≡true : false ≡ true
      false≡true =
        trans
          (sym (ω₅-toCorner-diag t u r))
          (trans eqPar (ω₅-toCorner-bridge t u r))
    in
      false≢true false≡true

open Inst public
```
