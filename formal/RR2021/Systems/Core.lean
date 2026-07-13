import Mathlib.Order.Disjoint

/-!
# Systems: core terminology

This module gives source-facing names to standard order operations.  The names
are transparent abbreviations: downstream results continue to use mathlib's
ordinary relations and typeclasses directly.
-/

namespace RR2021.Systems

universe u

/-- `A` is a subsystem of `B` exactly when `A ≤ B`. -/
abbrev Subsystem {System : Type u} [LE System] (A B : System) : Prop :=
  A ≤ B

/-- Two systems are separated exactly when they are order-theoretically disjoint. -/
abbrev Separated {System : Type u} [PartialOrder System] [OrderBot System]
    (A B : System) : Prop :=
  Disjoint A B

/-- The composite system is the lattice join.  Separation remains separate evidence. -/
abbrev Composite {System : Type u} [Max System] (A B : System) : System :=
  A ⊔ B

/-- The empty system is the bottom element. -/
abbrev emptySystem {System : Type u} [Bot System] : System :=
  ⊥

/-- The global system is the top element. -/
abbrev globalSystem {System : Type u} [Top System] : System :=
  ⊤

/-- The complementary system uses the carrier's standard complement. -/
abbrev complement {System : Type u} [Compl System] (A : System) : System :=
  Aᶜ

end RR2021.Systems
