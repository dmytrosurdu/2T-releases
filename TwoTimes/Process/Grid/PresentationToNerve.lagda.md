# TwoTimes/Process/Grid/PresentationToNerve.lagda.md

This module is the Batch 4 “bridge” target.

It makes the *semantic meaning* of a syntactic process be the total pair:

- `evalT : Proc → T`
- `evalU : Proc → Nat`
- `eval  : Proc → (T × Nat)`

Soundness is proved first for `eval`, then for `interp : Proc → Grid 1 1`
by postcomposing with an embedding `embed : (T × Nat) → Grid 1 1`.

```agda
{-# OPTIONS --without-K --safe #-}

module TwoTimes.Process.Grid.PresentationToNerve where

open import Agda.Primitive using (Level; _⊔_; lzero; lsuc)
open import Agda.Builtin.Equality using (_≡_; refl)
open import Agda.Builtin.Nat using (Nat; zero; suc)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.List as L using (List; []; _∷_)

open import TwoTimes.Prelude.Path using (sym; trans; cong; subst)

import TwoTimes.Process.Grid.Presentation as Pres
import TwoTimes.Process.Grid.Nerve as Nerv

module Inst {ℓT : Level} (Time : Pres.Group ℓT) where

  open Nerv using (_×_; _,_; fst; snd)

  cong₂
    : ∀ {ℓA ℓB ℓC : Level}
      {A : Set ℓA} {B : Set ℓB} {C : Set ℓC}
      (f : A → B → C) {x x' : A} {y y' : B}
    → x ≡ x' → y ≡ y' → f x y ≡ f x' y'
  cong₂ f refl refl = refl

  -- --------------------------------------------------------------------------
  -- Open the project’s Group + Presentation + Nerve layers
  -- --------------------------------------------------------------------------

  open Pres using
    ( T-id₀; T-comp₀; T-invL₀; T-invR₀
    ; R-zero₀; R-comp₀; square₀
    ; ≈-refl; ≈-sym; ≈-trans; ≈-step; ≈-congL; ≈-congR
    ; _+_
    )

  open Pres.Group Time renaming
    ( Carrier to T
    ; e       to eT
    ; _∙_     to _∙T_
    ; inv     to invT
    ; assoc   to assocT
    ; idl     to idlT
    ; idr     to idrT
    ; linv    to linvT
    ; rinv    to rinvT
    )

  Gen : Set ℓT
  Gen = Pres.Gen Time

  τ : T → Gen
  τ t = Pres.τ t

  ρ : Nat → Gen
  ρ u = Pres.ρ u

  Proc : Set ℓT
  Proc = Pres.Proc Time

  ε : Proc
  ε = Pres.ε Time

  infixr 5 _⨟_
  _⨟_ : Proc → Proc → Proc
  _⨟_ = Pres._⨟_ Time

  infix 3 _↝₀_
  _↝₀_ : Proc → Proc → Set ℓT
  _↝₀_ = Pres._↝₀_ Time

  infix 2 _≈_
  _≈_ : Proc → Proc → Set ℓT
  _≈_ = Pres._≈_ Time

  module G = Nerv.Grid Time
  open G public using (Grid)

  -- NOTE: We only target Grid 1 1 here (as approved). The “meaning” is eval : Proc → (T × Nat).

  -- --------------------------------------------------------------------------
  -- Nat lemmas (minimal; keep local)
  -- --------------------------------------------------------------------------

  +-zeroʳ : ∀ (n : Nat) → n + zero ≡ n
  +-zeroʳ zero    = refl
  +-zeroʳ (suc n) = cong suc (+-zeroʳ n)

  +-assoc : ∀ (a b c : Nat) → (a + b) + c ≡ a + (b + c)
  +-assoc zero    b c = refl
  +-assoc (suc a) b c = cong suc (+-assoc a b c)

  -- --------------------------------------------------------------------------
  -- Pair monoid operation (semantic target)
  --
  -- Convention (important):
  --   eval(p ⨟ q) computes “q after p” with respect to _⋆_:
  --     eval(p ⨟ q) = eval q ⋆ eval p
  --
  -- With _⋆_ defined below (opposite multiplication/addition), this means:
  --   evalT(p ⨟ q) = evalT p ∙ evalT q
  --   evalU(p ⨟ q) = evalU p + evalU q
  --
  -- This aligns the fold-based eval with the presentation’s head-compression rules.
  -- --------------------------------------------------------------------------

  unit : T × Nat
  unit = eT , zero

  infixl 7 _⋆_
  _⋆_ : (T × Nat) → (T × Nat) → (T × Nat)
  (t₁ , u₁) ⋆ (t₂ , u₂) = (t₂ ∙T t₁) , (u₂ + u₁)

  ⋆-assoc : ∀ (a b c : T × Nat) → (a ⋆ b) ⋆ c ≡ a ⋆ (b ⋆ c)
  ⋆-assoc (t₁ , u₁) (t₂ , u₂) (t₃ , u₃) =
    cong₂ _,_
      (sym (assocT t₃ t₂ t₁))
      (sym (+-assoc u₃ u₂ u₁))

  ⋆-idl : ∀ (a : T × Nat) → unit ⋆ a ≡ a
  ⋆-idl (t , u) =
    cong₂ _,_
      (idrT t)
      (+-zeroʳ u)

  ⋆-idr : ∀ (a : T × Nat) → a ⋆ unit ≡ a
  ⋆-idr (t , u) =
    cong₂ _,_
      (idlT t)
      refl

  -- --------------------------------------------------------------------------
  -- List fold + evaluation
  -- --------------------------------------------------------------------------

  foldr : ∀ {ℓA ℓB : Level} {A : Set ℓA} {B : Set ℓB} →
          (A → B → B) → B → List A → B
  foldr f z []       = z
  foldr f z (x ∷ xs) = f x (foldr f z xs)

  evalGen : Gen → (T × Nat)
  evalGen (Pres.τ t) = (t , zero)
  evalGen (Pres.ρ u) = (eT , u)

  -- Fold step: right fold with the opposite monoid yields list-order totals.
  step : Gen → (T × Nat) → (T × Nat)
  step g acc = acc ⋆ evalGen g

  eval : Proc → (T × Nat)
  eval p = foldr step unit p

  evalT : Proc → T
  evalT p = fst (eval p)

  evalU : Proc → Nat
  evalU p = snd (eval p)

  -- --------------------------------------------------------------------------
  -- Lemma: eval respects concatenation (anti-hom form)
  --   eval (p ⨟ q) = eval q ⋆ eval p
  --
  -- This lemma is the workhorse for congruence (`≈-congL`/`≈-congR`) proofs.
  -- --------------------------------------------------------------------------

  -- _⨟_ is definitional list append (Proc = List Gen), so we use it directly.
  eval-++ : ∀ (p q : Proc) → eval (p ⨟ q) ≡ eval q ⋆ eval p
  eval-++ [] q = sym (⋆-idr (eval q))
  eval-++ (g ∷ gs) q =
    trans
      (cong (λ x → x ⋆ evalGen g) (eval-++ gs q))
      (trans (⋆-assoc (eval q) (eval gs) (evalGen g)) refl)

  -- Helper: “congruence in context” for eval, for ≈-congL/≈-congR.
  eval-congL : ∀ {p q r : Proc} → eval p ≡ eval q → eval (p ⨟ r) ≡ eval (q ⨟ r)
  eval-congL {p} {q} {r} epq =
    trans (eval-++ p r)
      (trans (cong (λ x → eval r ⋆ x) epq)
        (sym (eval-++ q r)))

  eval-congR : ∀ {p q r : Proc} → eval p ≡ eval q → eval (r ⨟ p) ≡ eval (r ⨟ q)
  eval-congR {p} {q} {r} epq =
    trans (eval-++ r p)
      (trans (cong (λ x → x ⋆ eval r) epq)
        (sym (eval-++ r q)))

  -- --------------------------------------------------------------------------
  -- Soundness: primitive rewrite steps
  --
  -- IMPORTANT GUARDRAIL: no catch-all; pattern match on every constructor of _↝₀_.
  -- --------------------------------------------------------------------------

  sound₀-eval : ∀ {p q : Proc} → p ↝₀ q → eval p ≡ eval q
  sound₀-eval (T-id₀ {xs}) =
    eval-congL {p = τ eT ∷ []} {q = ε} {r = xs} head
    where
      head : eval (τ eT ∷ []) ≡ eval ε
      head = ⋆-idl unit
  sound₀-eval (T-comp₀ {t₁} {t₂} {xs}) =
    eval-congL {p = τ t₁ ∷ τ t₂ ∷ []} {q = τ (t₁ ∙T t₂) ∷ []} {r = xs} head
    where
      head : eval (τ t₁ ∷ τ t₂ ∷ []) ≡ eval (τ (t₁ ∙T t₂) ∷ [])
      head =
        trans
          (cong (λ x → x ⋆ evalGen (τ t₁)) (⋆-idl (evalGen (τ t₂))))
          (trans refl (sym (⋆-idl (evalGen (τ (t₁ ∙T t₂))))))
  sound₀-eval (T-invL₀ {t} {xs}) =
    eval-congL {p = τ (invT t) ∷ τ t ∷ []} {q = ε} {r = xs} head
    where
      head : eval (τ (invT t) ∷ τ t ∷ []) ≡ eval ε
      head =
        trans
          (cong (λ x → x ⋆ evalGen (τ (invT t))) (⋆-idl (evalGen (τ t))))
          (trans (cong₂ _,_ (linvT t) refl) refl)
  sound₀-eval (T-invR₀ {t} {xs}) =
    eval-congL {p = τ t ∷ τ (invT t) ∷ []} {q = ε} {r = xs} head
    where
      head : eval (τ t ∷ τ (invT t) ∷ []) ≡ eval ε
      head =
        trans
          (cong (λ x → x ⋆ evalGen (τ t)) (⋆-idl (evalGen (τ (invT t)))))
          (trans (cong₂ _,_ (rinvT t) refl) refl)
  sound₀-eval (R-zero₀ {xs}) =
    eval-congL {p = ρ zero ∷ []} {q = ε} {r = xs} head
    where
      head : eval (ρ zero ∷ []) ≡ eval ε
      head = ⋆-idl unit
  sound₀-eval (R-comp₀ {u₁} {u₂} {xs}) =
    eval-congL {p = ρ u₁ ∷ ρ u₂ ∷ []} {q = ρ (u₁ + u₂) ∷ []} {r = xs} head
    where
      head : eval (ρ u₁ ∷ ρ u₂ ∷ []) ≡ eval (ρ (u₁ + u₂) ∷ [])
      head =
        trans
          (cong (λ x → x ⋆ evalGen (ρ u₁)) (⋆-idl (evalGen (ρ u₂))))
          (trans
            (cong₂ _,_ (idlT eT) refl)
            (sym (⋆-idl (evalGen (ρ (u₁ + u₂))))))
  sound₀-eval (square₀ {t} {u} {xs}) =
    eval-congL {p = τ t ∷ ρ u ∷ []} {q = ρ u ∷ τ t ∷ []} {r = xs} head
    where
      head : eval (τ t ∷ ρ u ∷ []) ≡ eval (ρ u ∷ τ t ∷ [])
      head = trans lhs (sym rhs)
        where
          lhs : eval (τ t ∷ ρ u ∷ []) ≡ (t , u)
          lhs =
            trans
              (cong (λ x → x ⋆ evalGen (τ t)) (⋆-idl (evalGen (ρ u))))
              (cong₂ _,_ (idrT t) refl)

          rhs : eval (ρ u ∷ τ t ∷ []) ≡ (t , u)
          rhs =
            trans
              (cong (λ x → x ⋆ evalGen (ρ u)) (⋆-idl (evalGen (τ t))))
              (cong₂ _,_ (idlT t) (+-zeroʳ u))

  -- --------------------------------------------------------------------------
  -- Soundness: equational closure
  -- --------------------------------------------------------------------------

  sound≈-eval : ∀ {p q : Proc} → p ≈ q → eval p ≡ eval q
  sound≈-eval ≈-refl = refl
  sound≈-eval (≈-sym h) = sym (sound≈-eval h)
  sound≈-eval (≈-trans h₁ h₂) = trans (sound≈-eval h₁) (sound≈-eval h₂)
  sound≈-eval (≈-step r) = sound₀-eval r
  sound≈-eval (≈-congL {p = p} {q = q} {r = r} h) =
    eval-congL {p = p} {q = q} {r = r} (sound≈-eval h)
  sound≈-eval (≈-congR {p = p} {q = q} {r = r} h) =
    eval-congR {p = p} {q = q} {r = r} (sound≈-eval h)

  -- --------------------------------------------------------------------------
  -- Embedding into Grid 1 1 and corollary soundness
  -- --------------------------------------------------------------------------

  -- NOTE: This definition assumes the standard Bar/nerve choice where:
  --   TimeSimplex 1 is a length-1 vector containing a single time element,
  --   RGSimplex   1 is a length-1 vector containing a single Nat element,
  -- and Grid 1 1 = TimeSimplex 1 × RGSimplex 1.
  --
  -- If the concrete representation differs, only `embed` should be updated;
  -- the rest of the module (eval + soundness) stays unchanged.

  embed : (T × Nat) → Grid 1 1
  embed (t , u) = (Nerv._∷_ t Nerv.[]) , (Nerv._∷_ u Nerv.[])

  interp : Proc → Grid 1 1
  interp p = embed (eval p)

  sound₀ : ∀ {p q : Proc} → p ↝₀ q → interp p ≡ interp q
  sound₀ r = cong embed (sound₀-eval r)

  sound≈ : ∀ {p q : Proc} → p ≈ q → interp p ≡ interp q
  sound≈ h = cong embed (sound≈-eval h)

open Inst public
```
