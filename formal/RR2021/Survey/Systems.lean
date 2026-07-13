import Mathlib.Order.BooleanAlgebra.Basic

/-!
# System algebra encoding spike

This module tests the small amount of system algebra needed to state separation
and composition.  It deliberately contains no paper-specific axioms.
-/

namespace RR2021.Survey

universe u

/-- Two systems bundled with evidence that they are disjoint. -/
structure SeparatedSystems (System : Type u) [BooleanAlgebra System] where
  left : System
  right : System
  separated : Disjoint left right

namespace SeparatedSystems

variable {System : Type u} [BooleanAlgebra System]

/-- The composite of a separated pair is its lattice join. -/
def composite (pair : SeparatedSystems System) : System :=
  pair.left ⊔ pair.right

/-- Separation is symmetric, so a separated pair can be swapped. -/
def swap (pair : SeparatedSystems System) : SeparatedSystems System where
  left := pair.right
  right := pair.left
  separated := pair.separated.symm

@[simp]
theorem swap_left (pair : SeparatedSystems System) : pair.swap.left = pair.right :=
  rfl

@[simp]
theorem swap_right (pair : SeparatedSystems System) : pair.swap.right = pair.left :=
  rfl

end SeparatedSystems

end RR2021.Survey
