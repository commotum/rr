import RR2021.Reverse.Extension

/-!
# Transitive reverse construction: fundamental relation

Definition 5.1 is an orbit relation on global transformations.  Its symmetry
uses only the existential inverse postulate on the complementary system.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Definition 5.1 with multiplication orientation explicit: `left` differs
from `right` by a transformation supported on `Aᶜ`, applied afterward on the
left. -/
def FundamentallyEquivalent
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (left right : Transformation globalSystem) : Prop :=
  ∃ remote : Transformation (complement A),
    left = extendComplement theory A remote * right

namespace FundamentallyEquivalent

/-- Reflexivity uses the identity complementary extension. -/
theorem refl
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (transformation : Transformation globalSystem) :
    FundamentallyEquivalent theory A transformation transformation := by
  refine ⟨1, ?_⟩
  rw [extendComplement_one, one_mul transformation]

/-- Transitivity uses multiplication of complementary witnesses. -/
theorem trans
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) {first second third : Transformation globalSystem}
    (firstSecond : FundamentallyEquivalent theory A first second)
    (secondThird : FundamentallyEquivalent theory A second third) :
    FundamentallyEquivalent theory A first third := by
  obtain ⟨outer, first_eq⟩ := firstSecond
  obtain ⟨inner, second_eq⟩ := secondThird
  refine ⟨outer * inner, ?_⟩
  calc
    first = extendComplement theory A outer * second := first_eq
    _ = extendComplement theory A outer *
        (extendComplement theory A inner * third) := by rw [second_eq]
    _ = (extendComplement theory A outer *
          extendComplement theory A inner) * third :=
      (mul_assoc (extendComplement theory A outer)
        (extendComplement theory A inner) third).symm
    _ = extendComplement theory A (outer * inner) * third := by
      rw [extendComplement_mul]

/-- Symmetry uses an existential inverse witness only at `Aᶜ`; no group
structure or global inverse selection is introduced. -/
theorem symm
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) {left right : Transformation globalSystem}
    (equivalent : FundamentallyEquivalent theory A left right) :
    FundamentallyEquivalent theory A right left := by
  obtain ⟨remote, left_eq⟩ := equivalent
  obtain ⟨inverse, remote_inverse, inverse_remote⟩ :=
    invertible (complement A) remote
  refine ⟨inverse, ?_⟩
  calc
    right = 1 * right := (one_mul right).symm
    _ = extendComplement theory A (inverse * remote) * right := by
      rw [inverse_remote, extendComplement_one]
    _ = (extendComplement theory A inverse *
          extendComplement theory A remote) * right := by
      rw [extendComplement_mul]
    _ = extendComplement theory A inverse *
        (extendComplement theory A remote * right) := mul_assoc _ _ _
    _ = extendComplement theory A inverse * left := by rw [left_eq]

end FundamentallyEquivalent

/-- Theorem 5.1 as an explicit setoid. -/
def fundamentalSetoid
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) : Setoid (Transformation globalSystem) where
  r := FundamentallyEquivalent theory A
  iseqv := {
    refl := FundamentallyEquivalent.refl theory A
    symm := FundamentallyEquivalent.symm theory invertible A
    trans := FundamentallyEquivalent.trans theory A
  }

/-- Definition 5.3: noumenal states are fundamental equivalence classes of
global transformations. -/
abbrev NoumenalState
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) : Type v :=
  Quotient (fundamentalSetoid theory invertible A)

namespace NoumenalState

/-- The class of a global transformation at subsystem `A`. -/
def mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (transformation : Transformation globalSystem) :
    NoumenalState theory invertible A :=
  Quotient.mk _ transformation

/-- Equality of represented classes is exactly fundamental equivalence. -/
theorem mk_eq_mk_iff
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (left right : Transformation globalSystem) :
    mk theory invertible A left = mk theory invertible A right ↔
      FundamentallyEquivalent theory A left right :=
  Quotient.eq

end NoumenalState

end RR2021.Reverse.Transitive
