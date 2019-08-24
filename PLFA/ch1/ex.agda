import Data.Nat as Nat
import Relation.Binary.PropositionalEquality as Eq

open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)
open Nat using (ℕ; zero; suc; _+_; _*_)

{- seven -}
_ : 7 ≡ suc (suc (suc (suc (suc (suc (suc zero))))))
_ = refl

{- 3+4 = 7 -}
_ : 3 + 4 ≡ 7
_ =
  begin
    3 + 4
  ≡⟨⟩
    suc (2 + 4)
  ≡⟨⟩
    suc (suc (1 + 4))
  ≡⟨⟩
    suc (suc (suc (0 + 4)))
  ≡⟨⟩
    suc (suc (suc 4))
  ≡⟨⟩
    7
  ∎

{- define nat power -}
_^_ : ℕ → ℕ → ℕ
_ ^ zero = suc zero
m ^ suc n = m * (m ^ n)
