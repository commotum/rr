import RR2021.Faithfulness.NoumenalCore
import RR2021.Theories.LocalRealistic

/-!
# Phenomenal action descent through the noumenal kernel

The quotient relation mentions only the noumenal action.  Its invariance for
the phenomenal action is proved, not assumed, from the surjective equivariant
phenomenalization map in `LocalRealisticCore`.
-/

namespace RR2021.Faithfulness

open RR2021.Dynamics RR2021.Theories

universe u v w x

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Theorem B.1 in the exact form needed for descent: equality of the
noumenal action forces equality of the ordinary phenomenal action.  The proof
uses only surjectivity and equivariance of phenomenalization. -/
theorem noumenallyEquivalent_phenomenal_smul
    (theory :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    {A : System} {left right : Transformation A}
    (equivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) left right)
    (state : PhenomenalState A) : left • state = right • state := by
  obtain ⟨noumenalState, rfl⟩ :=
    theory.phenomenalizationSurjective A state
  calc
    left • theory.phenomenalization.toFun noumenalState =
        theory.phenomenalization.toFun (left • noumenalState) :=
      (theory.phenomenalizationEquivariant left noumenalState).symm
    _ = theory.phenomenalization.toFun (right • noumenalState) :=
      congrArg theory.phenomenalization.toFun (equivalent noumenalState)
    _ = right • theory.phenomenalization.toFun noumenalState :=
      theory.phenomenalizationEquivariant right noumenalState

namespace NoumenalQuotientTransformation

variable
  (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState)

/-- The quotient-class action on phenomenal states. -/
def phenomenalSmul {A : System}
    (transformation :
      NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState) A)
    (state : PhenomenalState A) : PhenomenalState A :=
  Con.liftOn transformation
    (fun representative : Transformation A => representative • state)
    (fun _ _ equivalent =>
      noumenallyEquivalent_phenomenal_smul theory equivalent state)

@[simp]
theorem phenomenalSmul_mk {A : System} (transformation : Transformation A)
    (state : PhenomenalState A) :
    phenomenalSmul theory
        (mk (NoumenalState := NoumenalState) transformation) state =
      transformation • state :=
  rfl

/-- The descended phenomenal action. -/
@[reducible]
def quotientIndexedPhenomenalMulAction :
    @IndexedMulAction System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      PhenomenalState
      (quotientIndexedMonoid
        (Transformation := Transformation) (NoumenalState := NoumenalState)) := by
  letI : IndexedMonoid System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState)) :=
    quotientIndexedMonoid
      (Transformation := Transformation) (NoumenalState := NoumenalState)
  exact {
    mulAction := fun A => {
      smul := phenomenalSmul theory
      one_smul := by
        intro state
        change (1 : Transformation A) • state = state
        exact one_act state
      mul_smul := by
        intro outer inner state
        refine Con.induction_on₂ outer inner ?_
        intro outerRepresentative innerRepresentative
        exact mul_act outerRepresentative innerRepresentative state
    }
  }

/-- The unchanged phenomenalization function is equivariant for the two
descended quotient actions. -/
theorem quotientPhenomenalizationEquivariant :
    @IndexedMap.Equivariant System NoumenalState PhenomenalState
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      (quotientIndexedMonoid
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      (quotientIndexedNoumenalMulAction
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      (quotientIndexedPhenomenalMulAction theory)
      theory.phenomenalization := by
  intro A transformation state
  revert state
  refine Con.induction_on transformation ?_
  intro representative state
  exact theory.phenomenalizationEquivariant representative state

end NoumenalQuotientTransformation

end RR2021.Faithfulness
