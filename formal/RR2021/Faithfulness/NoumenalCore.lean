import RR2021.Dynamics.Map
import Mathlib.GroupTheory.Congruence.Defs

/-!
# Noumenal action-kernel quotients

This file contains the low-level Appendix B quotient: pointwise equality of
the noumenal action, its monoid congruence, the quotient transformation family,
and the faithful descended noumenal action.  Phenomenal-action and separated-
product descent are kept in later leaves because they consume additional
fields of `LocalRealisticCore`.
-/

namespace RR2021.Faithfulness

open RR2021.Dynamics

universe u v w

variable {System : Type u}
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]

/-- Definition B.1: two transformations are equivalent when their noumenal
actions agree pointwise. -/
def NoumenallyEquivalent {A : System} (left right : Transformation A) : Prop :=
  ∀ state : NoumenalState A, left • state = right • state

namespace NoumenallyEquivalent

theorem refl {A : System} (transformation : Transformation A) :
    NoumenallyEquivalent (NoumenalState := NoumenalState)
      transformation transformation := by
  intro state
  rfl

theorem symm {A : System} {left right : Transformation A}
    (equivalent : NoumenallyEquivalent (NoumenalState := NoumenalState) left right) :
    NoumenallyEquivalent (NoumenalState := NoumenalState) right left := by
  intro state
  exact (equivalent state).symm

theorem trans {A : System} {first second third : Transformation A}
    (first_second :
      NoumenallyEquivalent (NoumenalState := NoumenalState) first second)
    (second_third :
      NoumenallyEquivalent (NoumenalState := NoumenalState) second third) :
    NoumenallyEquivalent (NoumenalState := NoumenalState) first third := by
  intro state
  exact (first_second state).trans (second_third state)

/-- Named representative-independence theorem for the descended noumenal
action. -/
theorem smul_eq {A : System} {left right : Transformation A}
    (equivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) left right)
    (state : NoumenalState A) : left • state = right • state :=
  equivalent state

/-- Theorem B.2 (composition congruence), in the library's multiplication
orientation: `outer * inner` first applies `inner`, then `outer`. -/
theorem mul {A : System}
    {leftOuter rightOuter leftInner rightInner : Transformation A}
    (outerEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) leftOuter rightOuter)
    (innerEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) leftInner rightInner) :
    NoumenallyEquivalent (NoumenalState := NoumenalState)
      (leftOuter * leftInner) (rightOuter * rightInner) := by
  intro state
  rw [mul_act, mul_act, innerEquivalent state,
    outerEquivalent (rightInner • state)]

end NoumenallyEquivalent

/-- Definition B.1 packaged as the explicit equivalence relation used by the
Appendix B quotient. -/
def noumenalActionSetoid (A : System) : Setoid (Transformation A) where
  r := NoumenallyEquivalent (NoumenalState := NoumenalState)
  iseqv := {
    refl := NoumenallyEquivalent.refl
    symm := NoumenallyEquivalent.symm
    trans := NoumenallyEquivalent.trans
  }

/-- The action-kernel equivalence as a monoid congruence.  Using `Con` makes
the quotient monoid laws consequences of the checked multiplication
congruence rather than a second hand-written quotient construction. -/
def noumenalActionCon (A : System) : Con (Transformation A) where
  toSetoid := noumenalActionSetoid
    (Transformation := Transformation) (NoumenalState := NoumenalState) A
  mul' := NoumenallyEquivalent.mul

/-- Appendix B's replacement transformation family. -/
abbrev NoumenalQuotientTransformation (A : System) :=
  (noumenalActionCon
    (Transformation := Transformation) (NoumenalState := NoumenalState) A).Quotient

namespace NoumenalQuotientTransformation

/-- The class of a representative transformation. -/
def mk {A : System} (transformation : Transformation A) :
    NoumenalQuotientTransformation
      (Transformation := Transformation) (NoumenalState := NoumenalState) A :=
  transformation

/-- Equality of representative classes is exactly noumenal equivalence. -/
theorem mk_eq_mk_iff {A : System} (left right : Transformation A) :
    mk (NoumenalState := NoumenalState) left =
        mk (NoumenalState := NoumenalState) right ↔
      NoumenallyEquivalent (NoumenalState := NoumenalState) left right :=
  (noumenalActionCon
    (Transformation := Transformation) (NoumenalState := NoumenalState) A).eq

/-- Named representative-independence theorem for quotient multiplication. -/
theorem mul_congr {A : System}
    {leftOuter rightOuter leftInner rightInner : Transformation A}
    (outerEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) leftOuter rightOuter)
    (innerEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) leftInner rightInner) :
    mk (NoumenalState := NoumenalState) (leftOuter * leftInner) =
      mk (NoumenalState := NoumenalState) (rightOuter * rightInner) :=
  (mk_eq_mk_iff (NoumenalState := NoumenalState) _ _).2
    (NoumenallyEquivalent.mul outerEquivalent innerEquivalent)

/-- The quotient family carries the monoid structure supplied by `Con`. -/
@[reducible]
def quotientIndexedMonoid :
    IndexedMonoid System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState)) where
  monoid _ := inferInstance

/-- The action of a quotient class on a noumenal state. -/
def noumenalSmul {A : System}
    (transformation :
      NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState) A)
    (state : NoumenalState A) : NoumenalState A :=
  Con.liftOn transformation (fun representative : Transformation A => representative • state)
    (fun _ _ equivalent => NoumenallyEquivalent.smul_eq equivalent state)

@[simp]
theorem noumenalSmul_mk {A : System} (transformation : Transformation A)
    (state : NoumenalState A) :
    noumenalSmul (NoumenalState := NoumenalState)
        (mk (NoumenalState := NoumenalState) transformation) state =
      transformation • state :=
  rfl

/-- The descended noumenal action, supplied explicitly so downstream
constructions can keep the two state sorts' actions distinct. -/
@[reducible]
def quotientIndexedNoumenalMulAction :
    @IndexedMulAction System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      NoumenalState
      (quotientIndexedMonoid
        (Transformation := Transformation) (NoumenalState := NoumenalState)) := by
  letI : IndexedMonoid System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState)) :=
    quotientIndexedMonoid
      (Transformation := Transformation) (NoumenalState := NoumenalState)
  exact {
    mulAction := fun A => {
      smul := noumenalSmul (NoumenalState := NoumenalState)
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

/-- The quotient noumenal action is effective by construction. -/
theorem quotientNoumenalActionEffective :
    @ActionEffective System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      NoumenalState
      (quotientIndexedMonoid
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      (quotientIndexedNoumenalMulAction
        (Transformation := Transformation) (NoumenalState := NoumenalState)) := by
  intro A left right same
  revert same
  refine Con.induction_on₂ left right ?_
  intro leftRepresentative rightRepresentative same
  exact (noumenalActionCon
    (Transformation := Transformation) (NoumenalState := NoumenalState) A).eq.mpr same

end NoumenalQuotientTransformation

end RR2021.Faithfulness
