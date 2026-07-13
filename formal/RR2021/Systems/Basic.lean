import Mathlib.Order.BooleanAlgebra.Basic
import RR2021.Systems.Core

/-!
# Systems: basic algebra

Cheap order and separation facts use only the standard structures they need.
Boolean-algebra strength first appears in the complement and corrected
relative-complement results.
-/

namespace RR2021.Systems

universe u

variable {System : Type u} {A B C : System}

theorem subsystem_iff_inf_eq [SemilatticeInf System] :
    Subsystem A B ↔ A ⊓ B = A := by
  simpa only [Subsystem] using (inf_eq_left : A ⊓ B = A ↔ A ≤ B).symm

theorem subsystem_iff_sup_eq [SemilatticeSup System] :
    Subsystem A B ↔ A ⊔ B = B := by
  simpa only [Subsystem] using (sup_eq_right : A ⊔ B = B ↔ A ≤ B).symm

@[simp]
theorem empty_subsystem [PartialOrder System] [OrderBot System] (A : System) :
    Subsystem emptySystem A :=
  bot_le

@[simp]
theorem subsystem_global [PartialOrder System] [OrderTop System] (A : System) :
    Subsystem A globalSystem :=
  le_top

theorem separated_comm [PartialOrder System] [OrderBot System] :
    Separated A B ↔ Separated B A :=
  disjoint_comm

theorem separated_iff_inf_eq_bot [SemilatticeInf System] [OrderBot System] :
    Separated A B ↔ A ⊓ B = emptySystem :=
  disjoint_iff

@[simp]
theorem empty_separated [PartialOrder System] [OrderBot System] (A : System) :
    Separated emptySystem A :=
  disjoint_bot_left

@[simp]
theorem separated_empty [PartialOrder System] [OrderBot System] (A : System) :
    Separated A emptySystem :=
  disjoint_bot_right

@[simp]
theorem separated_global_iff_empty [PartialOrder System] [BoundedOrder System] :
    Separated A globalSystem ↔ A = emptySystem :=
  disjoint_top

@[simp]
theorem global_separated_iff_empty [PartialOrder System] [BoundedOrder System] :
    Separated globalSystem A ↔ A = emptySystem :=
  top_disjoint

theorem composite_comm [SemilatticeSup System] (A B : System) :
    Composite A B = Composite B A :=
  sup_comm A B

theorem composite_assoc [SemilatticeSup System] (A B C : System) :
    Composite (Composite A B) C = Composite A (Composite B C) :=
  sup_assoc A B C

theorem left_subsystem_composite [SemilatticeSup System] (A B : System) :
    Subsystem A (Composite A B) :=
  le_sup_left

theorem right_subsystem_composite [SemilatticeSup System] (A B : System) :
    Subsystem B (Composite A B) :=
  le_sup_right

theorem composite_separated_iff [DistribLattice System] [OrderBot System] :
    Separated (Composite A B) C ↔ Separated A C ∧ Separated B C :=
  disjoint_sup_left

theorem separated_composite_iff [DistribLattice System] [OrderBot System] :
    Separated A (Composite B C) ↔ Separated A B ∧ Separated A C :=
  disjoint_sup_right

theorem separated_composite_of_pairwise [DistribLattice System] [OrderBot System]
    (hAB : Separated A B) (hAC : Separated A C) :
    Separated A (Composite B C) :=
  separated_composite_iff.mpr ⟨hAB, hAC⟩

theorem composite_separated_of_pairwise [DistribLattice System] [OrderBot System]
    (hAC : Separated A C) (hBC : Separated B C) :
    Separated (Composite A B) C :=
  composite_separated_iff.mpr ⟨hAC, hBC⟩

@[simp]
theorem composite_empty [SemilatticeSup System] [OrderBot System] (A : System) :
    Composite A emptySystem = A := by
  change A ⊔ ⊥ = A
  exact sup_bot_eq A

@[simp]
theorem empty_composite [SemilatticeSup System] [OrderBot System] (A : System) :
    Composite emptySystem A = A := by
  change ⊥ ⊔ A = A
  exact bot_sup_eq A

@[simp]
theorem composite_global [SemilatticeSup System] [OrderTop System] (A : System) :
    Composite A globalSystem = globalSystem := by
  change A ⊔ ⊤ = ⊤
  exact sup_top_eq A

@[simp]
theorem separated_complement [HeytingAlgebra System] (A : System) :
    Separated A (complement A) :=
  disjoint_compl_right

@[simp]
theorem composite_complement [BooleanAlgebra System] (A : System) :
    Composite A (complement A) = globalSystem :=
  sup_compl_eq_top

/-- The corrected relative complement from Theorem 5.2 is `Aᶜ ⊓ B`. -/
abbrev relativeComplement [Compl System] [Min System] (A B : System) : System :=
  complement A ⊓ B

/-- A system is disjoint from its relative complement, without needing `A ≤ B`. -/
theorem relativeComplement_disjoint [HeytingAlgebra System] (A B : System) :
    Separated A (relativeComplement A B) := by
  change Disjoint A (Aᶜ ⊓ B)
  exact disjoint_compl_right.mono_right inf_le_left

/-- A subsystem is separated from the complement of its containing system. -/
theorem subsystem_separated_complement [HeytingAlgebra System]
    (h : Subsystem A B) : Separated A (complement B) := by
  change Disjoint A Bᶜ
  exact disjoint_compl_right.mono_left h

/-- The relative complement is separated from the containing system's complement. -/
theorem relativeComplement_separated_complement [HeytingAlgebra System] (A B : System) :
    Separated (relativeComplement A B) (complement B) := by
  change Disjoint (Aᶜ ⊓ B) Bᶜ
  exact disjoint_compl_right.mono_left inf_le_right

/-- If `A ≤ B`, adjoining the corrected relative complement recovers `B`. -/
theorem composite_relativeComplement [BooleanAlgebra System] (h : Subsystem A B) :
    Composite A (relativeComplement A B) = B := by
  change A ⊔ Aᶜ ⊓ B = B
  rw [sup_inf_left, sup_compl_eq_top, top_inf_eq, sup_eq_right.mpr h]

/-- The relative complement together with `Bᶜ` recovers `Aᶜ`. -/
theorem relativeComplement_composite_complement [BooleanAlgebra System]
    (h : Subsystem A B) :
    Composite (relativeComplement A B) (complement B) = complement A := by
  change (Aᶜ ⊓ B) ⊔ Bᶜ = Aᶜ
  rw [sup_inf_right, sup_compl_eq_top, inf_top_eq]
  exact sup_eq_left.mpr (compl_le_compl h)

/-- The three corrected Boolean obligations used by the later reconstruction. -/
theorem relativeComplement_decomposition [BooleanAlgebra System]
    (h : Subsystem A B) :
    Separated A (relativeComplement A B) ∧
      Composite A (relativeComplement A B) = B ∧
      Composite (relativeComplement A B) (complement B) = complement A :=
  ⟨relativeComplement_disjoint A B, composite_relativeComplement h,
    relativeComplement_composite_complement h⟩

/--
The fully typed five-fact decomposition used by Theorem 5.2: both input pairs
for the later partial products are separated, as are `A` and its relative
complement, and the two required joins have the corrected values.
-/
theorem relativeComplement_decomposition_typed [BooleanAlgebra System]
    (h : Subsystem A B) :
    Separated A (complement B) ∧
      Separated (relativeComplement A B) (complement B) ∧
      Separated A (relativeComplement A B) ∧
      Composite A (relativeComplement A B) = B ∧
      Composite (relativeComplement A B) (complement B) = complement A :=
  ⟨subsystem_separated_complement h,
    relativeComplement_separated_complement A B,
    relativeComplement_disjoint A B,
    composite_relativeComplement h,
    relativeComplement_composite_complement h⟩

/-- For disjoint `A` and `B`, adjoining the complement of `A ⊔ B` to `B`
recovers `Aᶜ`.  This types the complement decomposition used around Theorem 5.8. -/
theorem right_composite_complement [BooleanAlgebra System]
    (h : Separated A B) :
    Composite B (complement (Composite A B)) = complement A := by
  change B ⊔ (A ⊔ B)ᶜ = Aᶜ
  rw [compl_sup, sup_inf_left, sup_eq_right.mpr h.le_compl_left,
    sup_compl_eq_top, inf_top_eq]

/-- Symmetric complement decomposition for a disjoint composite. -/
theorem left_composite_complement [BooleanAlgebra System]
    (h : Separated A B) :
    Composite A (complement (Composite A B)) = complement B := by
  change A ⊔ (A ⊔ B)ᶜ = Bᶜ
  rw [compl_sup, sup_inf_left, sup_compl_eq_top, top_inf_eq,
    sup_eq_right.mpr h.le_compl_right]

/-- A composite and its complement form the global system. -/
theorem composite_with_its_complement [BooleanAlgebra System] (A B : System) :
    Composite (Composite A B) (complement (Composite A B)) = globalSystem :=
  composite_complement (Composite A B)

end RR2021.Systems
