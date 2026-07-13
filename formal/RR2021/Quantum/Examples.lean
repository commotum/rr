import RR2021.Quantum.API

/-!
# Finite quantum boundary examples

The one-dimensional identity example exercises corrected Theorem C.1.  The
empty-factor regression shows why the explicit nonempty cancellation premise
cannot be dropped.
-/

namespace RR2021.Quantum.Examples

open scoped Kronecker

/-- Identity operations on one-dimensional factors satisfy the overlap
equation. -/
theorem unit_identity_overlap :
    OverlappingExtensionsAgree
      (1 : Matrix (Unit × Unit) (Unit × Unit) ℂ)
      (1 : Matrix (Unit × Unit) (Unit × Unit) ℂ) := by
  rintro ⟨⟩ ⟨⟩ ⟨⟩ ⟨⟩ ⟨⟩ ⟨⟩
  simp

/-- Corrected Theorem C.1 is consumable on the simplest nonempty coordinate
model. -/
example :
    ∃ VB : Matrix Unit Unit ℂ,
      VB ∈ Matrix.unitaryGroup Unit ℂ ∧
        (1 : Matrix (Unit × Unit) (Unit × Unit) ℂ) =
          (1 : Matrix Unit Unit ℂ) ⊗ₖ VB ∧
        (1 : Matrix (Unit × Unit) (Unit × Unit) ℂ) =
          VB ⊗ₖ (1 : Matrix Unit Unit ℂ) := by
  apply commonMiddleUnitaryFactor ⟨()⟩ ⟨()⟩ 1 1 unit_identity_overlap
  exact Submonoid.one_mem _

/-- If the right factor has no coordinate, tensoring with its identity loses
all matrix information.  This guards the nonempty premise used by unitarity
reflection. -/
theorem empty_right_factor_not_injective :
    ¬ Function.Injective
      (fun VB : Matrix Unit Unit ℂ =>
        VB ⊗ₖ (1 : Matrix Empty Empty ℂ)) := by
  intro injective
  have tensorsEqual :
      (0 : Matrix Unit Unit ℂ) ⊗ₖ (1 : Matrix Empty Empty ℂ) =
        (1 : Matrix Unit Unit ℂ) ⊗ₖ (1 : Matrix Empty Empty ℂ) := by
    apply Matrix.ext
    rintro ⟨_, impossible⟩
    exact Empty.elim impossible
  have matricesEqual := injective tensorsEqual
  have entry := congrArg (fun M : Matrix Unit Unit ℂ => M () ()) matricesEqual
  simp at entry

/-- The symmetric empty-left regression guards the other outer nonempty
premise in common-middle factorization. -/
theorem empty_left_factor_not_injective :
    ¬ Function.Injective
      (fun VB : Matrix Unit Unit ℂ =>
        (1 : Matrix Empty Empty ℂ) ⊗ₖ VB) := by
  intro injective
  have tensorsEqual :
      (1 : Matrix Empty Empty ℂ) ⊗ₖ (0 : Matrix Unit Unit ℂ) =
        (1 : Matrix Empty Empty ℂ) ⊗ₖ (1 : Matrix Unit Unit ℂ) := by
    apply Matrix.ext
    rintro ⟨impossible, _⟩
    exact Empty.elim impossible
  have matricesEqual := injective tensorsEqual
  have entry := congrArg (fun M : Matrix Unit Unit ℂ => M () ()) matricesEqual
  simp at entry

end RR2021.Quantum.Examples
