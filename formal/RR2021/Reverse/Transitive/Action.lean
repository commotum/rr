import RR2021.Reverse.Transitive.Relation

/-!
# Transitive reverse construction: local action

A transformation on `A` acts on a fundamental class by first extending it to
the global system and then multiplying the chosen global representative on the
left.  The only representative-independence step is the commutation of the
local extension with every complementary extension.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace FundamentallyEquivalent

/-- Left multiplication by a compiled local extension preserves the
fundamental relation.  This is the representative-independence obligation for
the quotient action. -/
theorem extendSystem_mul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (localTransformation : Transformation A)
    {left right : Transformation globalSystem}
    (equivalent : FundamentallyEquivalent theory A left right) :
    FundamentallyEquivalent theory A
      (RR2021.Reverse.extendSystem theory A localTransformation * left)
      (RR2021.Reverse.extendSystem theory A localTransformation * right) := by
  obtain ⟨remote, left_eq⟩ := equivalent
  refine ⟨remote, ?_⟩
  calc
    RR2021.Reverse.extendSystem theory A localTransformation * left =
        RR2021.Reverse.extendSystem theory A localTransformation *
          (extendComplement theory A remote * right) := by rw [left_eq]
    _ = (RR2021.Reverse.extendSystem theory A localTransformation *
          extendComplement theory A remote) * right :=
      (mul_assoc (RR2021.Reverse.extendSystem theory A localTransformation)
        (extendComplement theory A remote) right).symm
    _ = (extendComplement theory A remote *
          RR2021.Reverse.extendSystem theory A localTransformation) * right := by
      rw [extendSystem_extendComplement_commute]
    _ = extendComplement theory A remote *
          (RR2021.Reverse.extendSystem theory A localTransformation * right) :=
      mul_assoc (extendComplement theory A remote)
        (RR2021.Reverse.extendSystem theory A localTransformation) right

end FundamentallyEquivalent

namespace NoumenalState

/-- The local action on fundamental classes. -/
def smul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (state : NoumenalState theory invertible A) :
    NoumenalState theory invertible A :=
  Quotient.map
    (fun globalTransformation =>
      RR2021.Reverse.extendSystem theory A localTransformation * globalTransformation)
    (fun _ _ equivalent =>
      FundamentallyEquivalent.extendSystem_mul theory A localTransformation equivalent)
    state

/-- Computation of the local action on a represented class. -/
@[simp]
theorem smul_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (globalTransformation : Transformation globalSystem) :
    smul theory invertible localTransformation
        (mk theory invertible A globalTransformation) =
      mk theory invertible A
        (RR2021.Reverse.extendSystem theory A localTransformation * globalTransformation) :=
  rfl

/-- The fundamental quotient carries the indexed action by local
transformations. -/
@[reducible, instance]
def indexedMulAction
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    IndexedMulAction System Transformation (NoumenalState theory invertible) where
  mulAction A := {
    smul := smul theory invertible
    one_smul := by
      intro state
      refine Quotient.inductionOn state ?_
      intro globalTransformation
      change mk theory invertible A
          (RR2021.Reverse.extendSystem theory A (1 : Transformation A) *
            globalTransformation) =
        mk theory invertible A globalTransformation
      apply congrArg (mk theory invertible A)
      calc
        RR2021.Reverse.extendSystem theory A (1 : Transformation A) *
            globalTransformation =
          (1 : Transformation globalSystem) * globalTransformation := by
            rw [RR2021.Reverse.extendSystem_one]
        _ = globalTransformation := one_mul globalTransformation
    mul_smul := by
      intro outer inner state
      refine Quotient.inductionOn state ?_
      intro globalTransformation
      change mk theory invertible A
          (RR2021.Reverse.extendSystem theory A (outer * inner) *
            globalTransformation) =
        mk theory invertible A
          (RR2021.Reverse.extendSystem theory A outer *
            (RR2021.Reverse.extendSystem theory A inner * globalTransformation))
      apply congrArg (mk theory invertible A)
      calc
        RR2021.Reverse.extendSystem theory A (outer * inner) *
            globalTransformation =
          (RR2021.Reverse.extendSystem theory A outer *
              RR2021.Reverse.extendSystem theory A inner) *
            globalTransformation := by
              rw [RR2021.Reverse.extendSystem_mul]
        _ = RR2021.Reverse.extendSystem theory A outer *
            (RR2021.Reverse.extendSystem theory A inner * globalTransformation) :=
          mul_assoc (RR2021.Reverse.extendSystem theory A outer)
            (RR2021.Reverse.extendSystem theory A inner) globalTransformation
  }

/-- Fundamental equivalence can be consumed directly as equality after any
local action. -/
theorem smul_mk_eq_of_fundamentallyEquivalent
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    {left right : Transformation globalSystem}
    (equivalent : FundamentallyEquivalent theory A left right) :
    smul theory invertible localTransformation (mk theory invertible A left) =
      smul theory invertible localTransformation (mk theory invertible A right) := by
  rw [smul_mk, smul_mk]
  exact (mk_eq_mk_iff theory invertible A _ _).2
    (FundamentallyEquivalent.extendSystem_mul theory A localTransformation equivalent)

end NoumenalState

end RR2021.Reverse.Transitive
