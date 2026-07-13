import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.UnitaryGroup
import Mathlib.RingTheory.MatrixAlgebra

/-!
# Finite-matrix repair of Appendix C

Appendix C claims a common-middle-factor theorem for arbitrary Hilbert spaces
by expanding endomorphisms in a product basis.  That basis argument is not
valid without finite-dimensional tensor identifications.  Here we prove the
finite coordinate statement directly from matrix entries over `ℂ`.

The overlap equation is written with six indices.  This explicitly accounts
for the reindex between `(A × B) × C` and `A × (B × C)` in the paper's
expression `V_AB ⊗ I_C = I_A ⊗ V_BC`.
-/

namespace RR2021.Quantum

open scoped Kronecker TensorProduct

universe u v w

/-- The finite-dimensional matrix-algebra equivalence missing from Definition
C.1's unrestricted basis argument.  It identifies the tensor product of two
finite complex matrix spaces with the matrix space on the product index. -/
noncomputable def finiteMatrixTensorEquiv
    (A : Type u) (B : Type v)
    [Fintype A] [DecidableEq A] [Fintype B] [DecidableEq B]
    : (Matrix A A ℂ ⊗[ℂ] Matrix B B ℂ) ≃ₗ[ℂ]
        Matrix (A × B) (A × B) ℂ :=
  kroneckerLinearEquiv A A B B ℂ

/-- The finite matrix tensor equivalence sends simple tensors to Kronecker
products.  Combined with mathlib's `Module.Basis.tensorProduct`, this is the
finite replacement for Appendix C's product-basis sentence. -/
@[simp]
theorem finiteMatrixTensorEquiv_tmul
    {A : Type u} {B : Type v}
    [Fintype A] [DecidableEq A] [Fintype B] [DecidableEq B]
    (left : Matrix A A ℂ) (right : Matrix B B ℂ) :
    finiteMatrixTensorEquiv A B (left ⊗ₜ[ℂ] right) = left ⊗ₖ right :=
  rfl

/-- The entrywise, associativity-corrected meaning of
`V_AB ⊗ I_C = I_A ⊗ V_BC`. -/
def OverlappingExtensionsAgree
    {A : Type u} {B : Type v} {C : Type w}
    [DecidableEq A] [DecidableEq C]
    (VAB : Matrix (A × B) (A × B) ℂ)
    (VBC : Matrix (B × C) (B × C) ℂ) : Prop :=
  ∀ a b c a' b' c',
    VAB (a, b) (a', b') * (1 : Matrix C C ℂ) c c' =
      (1 : Matrix A A ℂ) a a' * VBC (b, c) (b', c')

/-- With explicit nonzero-factor witnesses, equality of the two overlapping
extensions forces both matrices to factor through a common middle matrix.

The proof inspects diagonal entries at `a₀` and `c₀`; it uses no basis of an
endomorphism space and makes no infinite-dimensional claim. -/
theorem commonMiddleFactorAt
    {A : Type u} {B : Type v} {C : Type w}
    [DecidableEq A] [DecidableEq C]
    (a₀ : A) (c₀ : C)
    (VAB : Matrix (A × B) (A × B) ℂ)
    (VBC : Matrix (B × C) (B × C) ℂ)
    (overlap : OverlappingExtensionsAgree VAB VBC) :
    ∃ VB : Matrix B B ℂ,
      VAB = (1 : Matrix A A ℂ) ⊗ₖ VB ∧
        VBC = VB ⊗ₖ (1 : Matrix C C ℂ) := by
  let VB : Matrix B B ℂ := fun b b' => VAB (a₀, b) (a₀, b')
  refine ⟨VB, ?_, ?_⟩
  · apply Matrix.ext
    rintro ⟨a, b⟩ ⟨a', b'⟩
    rw [Matrix.kronecker_apply]
    have main := overlap a b c₀ a' b' c₀
    have slice := overlap a₀ b c₀ a₀ b' c₀
    simp only [Matrix.one_apply, if_pos, mul_one, one_mul] at main slice
    change VAB (a, b) (a', b') =
      (1 : Matrix A A ℂ) a a' * VB b b'
    calc
      VAB (a, b) (a', b') =
          (1 : Matrix A A ℂ) a a' * VBC (b, c₀) (b', c₀) := main
      _ = (1 : Matrix A A ℂ) a a' * VB b b' := by
        simp only [VB, slice]
  · apply Matrix.ext
    rintro ⟨b, c⟩ ⟨b', c'⟩
    rw [Matrix.kronecker_apply]
    have entry := overlap a₀ b c a₀ b' c'
    simp only [Matrix.one_apply, if_pos, one_mul] at entry
    change VBC (b, c) (b', c') =
      VB b b' * (1 : Matrix C C ℂ) c c'
    exact entry.symm

/-- Nonempty outer coordinate types suffice for the common-middle-factor
conclusion.  `Nonempty` is eliminated only into the existential proposition;
no default coordinate or data-level representative is selected. -/
theorem commonMiddleFactor
    {A : Type u} {B : Type v} {C : Type w}
    [DecidableEq A] [DecidableEq C]
    (hA : Nonempty A) (hC : Nonempty C)
    (VAB : Matrix (A × B) (A × B) ℂ)
    (VBC : Matrix (B × C) (B × C) ℂ)
    (overlap : OverlappingExtensionsAgree VAB VBC) :
    ∃ VB : Matrix B B ℂ,
      VAB = (1 : Matrix A A ℂ) ⊗ₖ VB ∧
        VBC = VB ⊗ₖ (1 : Matrix C C ℂ) := by
  exact hA.elim fun a₀ => hC.elim fun c₀ =>
    commonMiddleFactorAt a₀ c₀ VAB VBC overlap

/-- Tensoring a matrix on the right with a nonzero identity matrix is
injective.  The explicit coordinate is the finite-matrix cancellation premise
hidden in Appendix C's final sentence. -/
theorem kroneckerOneRight_injective
    {B : Type v} {C : Type w} [DecidableEq C] (c₀ : C) :
    Function.Injective
      (fun VB : Matrix B B ℂ => VB ⊗ₖ (1 : Matrix C C ℂ)) := by
  intro left right equalTensor
  apply Matrix.ext
  intro b b'
  have entry := congrArg
    (fun M : Matrix (B × C) (B × C) ℂ => M (b, c₀) (b', c₀))
    equalTensor
  simpa [Matrix.kronecker_apply] using entry

/-- The missing unitarity-reflection step in Appendix C.

If `VB ⊗ I_C` is unitary and `C` has a coordinate, then `VB` is unitary.
Both inverse equations are reflected through the injective Kronecker map. -/
theorem mem_unitary_of_kronecker_one
    {B : Type v} {C : Type w}
    [Fintype B] [DecidableEq B] [Fintype C] [DecidableEq C]
    (c₀ : C) (VB : Matrix B B ℂ)
    (unitaryTensor :
      VB ⊗ₖ (1 : Matrix C C ℂ) ∈
        Matrix.unitaryGroup (B × C) ℂ) :
    VB ∈ Matrix.unitaryGroup B ℂ := by
  rw [Unitary.mem_iff] at unitaryTensor ⊢
  constructor
  · apply kroneckerOneRight_injective c₀
    calc
      (star VB * VB) ⊗ₖ (1 : Matrix C C ℂ) =
          star (VB ⊗ₖ (1 : Matrix C C ℂ)) *
            (VB ⊗ₖ (1 : Matrix C C ℂ)) := by
              simp [Matrix.star_eq_conjTranspose,
                Matrix.conjTranspose_kronecker,
                ← Matrix.mul_kronecker_mul]
      _ = 1 := unitaryTensor.1
      _ = (1 : Matrix B B ℂ) ⊗ₖ (1 : Matrix C C ℂ) :=
        Matrix.one_kronecker_one.symm
  · apply kroneckerOneRight_injective c₀
    calc
      (VB * star VB) ⊗ₖ (1 : Matrix C C ℂ) =
          (VB ⊗ₖ (1 : Matrix C C ℂ)) *
            star (VB ⊗ₖ (1 : Matrix C C ℂ)) := by
              simp [Matrix.star_eq_conjTranspose,
                Matrix.conjTranspose_kronecker,
                ← Matrix.mul_kronecker_mul]
      _ = 1 := unitaryTensor.2
      _ = (1 : Matrix B B ℂ) ⊗ₖ (1 : Matrix C C ℂ) :=
        Matrix.one_kronecker_one.symm

/-- Corrected finite-dimensional complex version of Theorem C.1.

The nonempty outer factors are explicit, the shared middle operator is named
`VB`, and its unitarity is derived from the `BC` factorization rather than
asserted after the coefficient argument. -/
theorem commonMiddleUnitaryFactor
    {A : Type u} {B : Type v} {C : Type w}
    [Fintype A] [DecidableEq A]
    [Fintype B] [DecidableEq B]
    [Fintype C] [DecidableEq C]
    (hA : Nonempty A) (hC : Nonempty C)
    (VAB : Matrix (A × B) (A × B) ℂ)
    (VBC : Matrix (B × C) (B × C) ℂ)
    (overlap : OverlappingExtensionsAgree VAB VBC)
    (unitaryBC : VBC ∈ Matrix.unitaryGroup (B × C) ℂ) :
    ∃ VB : Matrix B B ℂ,
      VB ∈ Matrix.unitaryGroup B ℂ ∧
        VAB = (1 : Matrix A A ℂ) ⊗ₖ VB ∧
          VBC = VB ⊗ₖ (1 : Matrix C C ℂ) := by
  obtain ⟨VB, factorAB, factorBC⟩ :=
    commonMiddleFactor hA hC VAB VBC overlap
  refine ⟨VB, ?_, factorAB, factorBC⟩
  apply hC.elim
  intro c₀
  apply mem_unitary_of_kronecker_one c₀ VB
  rwa [← factorBC]

end RR2021.Quantum
