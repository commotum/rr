import Mathlib.Analysis.InnerProductSpace.Adjoint

/-!
# Phase equality for unitary conjugation

Mathlib proves the exact phase ambiguity for conjugation on the entire
continuous-operator algebra of a Hilbert space.  This is a useful checked
nearby theorem for Section 4.2, but it is not yet the paper's contextual
phenomenal equivalence on density states and separated extensions.
-/

namespace RR2021.Quantum

/-- Two unitary linear isometries induce the same conjugation equivalence on
all continuous endomorphisms exactly when they differ by a unitary scalar. -/
theorem conjugation_eq_iff_unitaryPhase
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    [CompleteSpace H] (left right : H ≃ₗᵢ[ℂ] H) :
    left.conjStarAlgEquiv = right.conjStarAlgEquiv ↔
      ∃ phase : unitary ℂ, left = phase • right :=
  LinearIsometryEquiv.conjStarAlgEquiv_ext_iff left right

end RR2021.Quantum
