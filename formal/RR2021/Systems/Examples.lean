import Mathlib.Data.Finset.BooleanAlgebra
import Mathlib.Data.Fintype.Basic
import RR2021.Systems.Basic
import RR2021.Systems.Transport

/-!
# Systems: finite diagnostic examples

Finite sets provide a concrete Boolean algebra for positive examples and for
rejecting the false strengthening that disjoint systems force an empty factor.
Nothing in this module is imported by the public API.
-/

namespace RR2021.Systems.Examples

abbrev FiniteSystem := Finset (Fin 3)

def leftAtom : FiniteSystem := {0}

def rightAtom : FiniteSystem := {1}

def thirdAtom : FiniteSystem := {2}

def twoAtoms : FiniteSystem := {0, 1}

example : Subsystem leftAtom twoAtoms := by
  simp [leftAtom, twoAtoms]

example : Separated leftAtom rightAtom := by
  simp [Separated, leftAtom, rightAtom]

example : Composite leftAtom rightAtom = twoAtoms := by
  decide

example : emptySystem = (∅ : FiniteSystem) :=
  rfl

example : globalSystem = (Finset.univ : FiniteSystem) :=
  rfl

example : Separated leftAtom emptySystem :=
  separated_empty leftAtom

example : Composite leftAtom globalSystem = globalSystem :=
  composite_global leftAtom

example : complement leftAtom = ({1, 2} : FiniteSystem) := by
  decide

example : relativeComplement leftAtom twoAtoms = rightAtom := by
  decide

example : Separated leftAtom (complement twoAtoms) :=
  subsystem_separated_complement (by simp [leftAtom, twoAtoms])

example :
    Separated (relativeComplement leftAtom twoAtoms) (complement twoAtoms) :=
  relativeComplement_separated_complement leftAtom twoAtoms

example := relativeComplement_decomposition_typed
  (A := leftAtom) (B := twoAtoms) (by simp [leftAtom, twoAtoms])

example : Composite leftAtom (relativeComplement leftAtom twoAtoms) = twoAtoms :=
  composite_relativeComplement (by simp [leftAtom, twoAtoms])

example :
    Composite (relativeComplement leftAtom twoAtoms) (complement twoAtoms) =
      complement leftAtom :=
  relativeComplement_composite_complement (by simp [leftAtom, twoAtoms])

/-- A genuinely dependent family used to exercise named composite transports. -/
abbrev TaggedState (system : FiniteSystem) :=
  { observed : FiniteSystem // observed = system }

def taggedComposite : TaggedState (Composite leftAtom rightAtom) :=
  ⟨Composite leftAtom rightAtom, rfl⟩

example :
    reindexSupComm (A := rightAtom) (B := leftAtom) TaggedState
        (reindexSupComm TaggedState taggedComposite) = taggedComposite :=
  reindexSupComm_twice TaggedState taggedComposite

def taggedTriple :
    TaggedState (Composite (Composite leftAtom rightAtom) thirdAtom) :=
  ⟨Composite (Composite leftAtom rightAtom) thirdAtom, rfl⟩

example :
    reindexSupAssocInv TaggedState (reindexSupAssoc TaggedState taggedTriple) =
      taggedTriple :=
  reindexSupAssoc_inverse TaggedState taggedTriple

def taggedFour :
    TaggedState
      (Composite (Composite (Composite leftAtom rightAtom) thirdAtom) emptySystem) :=
  ⟨Composite (Composite (Composite leftAtom rightAtom) thirdAtom) emptySystem, rfl⟩

example :
    reindex TaggedState
        (supAssocPathShort leftAtom rightAtom thirdAtom emptySystem) taggedFour =
      reindex TaggedState
        (supAssocPathLong leftAtom rightAtom thirdAtom emptySystem) taggedFour :=
  reindexSupAssoc_pentagon TaggedState taggedFour

def taggedRelativeGlobal :
    TaggedState
      (Composite (Composite leftAtom (relativeComplement leftAtom twoAtoms))
        (complement twoAtoms)) :=
  ⟨_, rfl⟩

example :
    reindex TaggedState
        (relativeComplementTopPathViaB
          (A := leftAtom) (B := twoAtoms) (by simp [leftAtom, twoAtoms]))
        taggedRelativeGlobal =
      reindex TaggedState
        (relativeComplementTopPathViaA
          (A := leftAtom) (B := twoAtoms) (by simp [leftAtom, twoAtoms]))
        taggedRelativeGlobal :=
  reindexRelativeComplement_top_coherent TaggedState
    (by simp [leftAtom, twoAtoms]) taggedRelativeGlobal

/-- Nonempty disjoint factors refute the overstrong empty-factor inference. -/
theorem disjoint_does_not_force_empty_factor :
    ¬ ∀ A B : FiniteSystem, Separated A B →
      A = emptySystem ∨ B = emptySystem := by
  intro overstrong
  have conclusion := overstrong leftAtom rightAtom (by
    simp [Separated, leftAtom, rightAtom])
  simp [leftAtom, rightAtom, emptySystem] at conclusion

/-- Regression for the Markdown conversion that dropped the complement bar in
Theorem 5.2: `A ⊓ B` is not the required disjoint relative complement. -/
theorem lost_complement_bar_regression :
    ¬ Separated leftAtom (leftAtom ⊓ twoAtoms) ∧
      Composite leftAtom (leftAtom ⊓ twoAtoms) ≠ twoAtoms := by
  constructor <;> decide

/-- The subsystem premise is necessary for the reconstruction equation. -/
theorem relative_complement_needs_subsystem :
    Composite rightAtom (relativeComplement rightAtom leftAtom) ≠ leftAtom := by
  decide

/-- Adjacent disjointness alone is insufficient for regrouping three systems. -/
theorem adjacent_separation_is_not_pairwise :
    Separated leftAtom rightAtom ∧ Separated rightAtom leftAtom ∧
      ¬ Separated (Composite leftAtom rightAtom) leftAtom := by
  constructor
  · decide
  constructor <;> decide

end RR2021.Systems.Examples
