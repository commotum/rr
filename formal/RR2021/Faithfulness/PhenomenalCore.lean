import RR2021.Theories.Postulates
import Mathlib.GroupTheory.Congruence.Defs

/-!
# Phenomenal faithfulness: the observational quotient core

This module packages corrected Definition 4.1 as a setoid, proves Theorems
A.1 and the corrected A.2, and descends the indexed monoid and phenomenal
action.  Transformation products and the no-signalling constructor live in
later leaves.
-/

namespace RR2021

open Systems Dynamics

namespace Theories.NoSignallingTheory

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Phenomenal equivalence is reflexive. -/
theorem phenomenallyEquivalent_refl
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (transformation : Transformation A) :
    theory.PhenomenallyEquivalent transformation transformation := by
  intro B hsep state
  rfl

/-- Phenomenal equivalence is symmetric. -/
theorem phenomenallyEquivalent_symm
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} {left right : Transformation A}
    (equivalent : theory.PhenomenallyEquivalent left right) :
    theory.PhenomenallyEquivalent right left := by
  intro B hsep state
  exact (equivalent hsep state).symm

/-- Phenomenal equivalence is transitive. -/
theorem phenomenallyEquivalent_trans
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} {first second third : Transformation A}
    (firstSecond : theory.PhenomenallyEquivalent first second)
    (secondThird : theory.PhenomenallyEquivalent second third) :
    theory.PhenomenallyEquivalent first third := by
  intro B hsep state
  exact (firstSecond hsep state).trans (secondThird hsep state)

/-- Corrected Definition 4.1 packaged as the equivalence relation used by
Appendix A. -/
def phenomenalSetoid
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) : Setoid (Transformation A) where
  r := theory.PhenomenallyEquivalent
  iseqv := {
    refl := theory.phenomenallyEquivalent_refl
    symm := theory.phenomenallyEquivalent_symm
    trans := theory.phenomenallyEquivalent_trans
  }

/-- Theorem A.1: contextual phenomenal equivalence implies equal local action.
The empty extension and its index transport are kept explicit. -/
theorem phenomenallyEquivalent_action_eq
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} {left right : Transformation A}
    (equivalent : theory.PhenomenallyEquivalent left right)
    (state : PhenomenalState A) :
    left • state = right • state := by
  let domainEq : Composite A emptySystem = A := composite_empty A
  let extended : PhenomenalState (Composite A emptySystem) :=
    reindex PhenomenalState domainEq.symm state
  have extended_roundtrip :
      reindex PhenomenalState domainEq extended = state := by
    simpa only [extended, domainEq] using
      reindex_inverse_rev PhenomenalState domainEq state
  have projected : theory.projectors.projectLeft extended = state := by
    calc
      theory.projectors.projectLeft extended =
          theory.projectors.project
            (ProjectorFamily.reindexSubsystemDomain domainEq
              (show Subsystem A (Composite A emptySystem) from le_sup_left))
            (reindex PhenomenalState domainEq extended) :=
        (theory.projectors.project_reindex_domain domainEq
          (show Subsystem A (Composite A emptySystem) from le_sup_left)
          extended).symm
      _ = theory.projectors.project (show Subsystem A A from le_rfl) state := by
        rw [extended_roundtrip]
      _ = state :=
        theory.projectors.project_self theory.projectorsSurjective state
  have contextual := equivalent (B := emptySystem) (separated_empty A) extended
  calc
    left • state = left • theory.projectors.projectLeft extended := by
      rw [projected]
    _ = theory.projectors.projectLeft
        (theory.transformationProducts.product left
          (1 : Transformation emptySystem) (separated_empty A) • extended) :=
      (theory.noSignalling left (1 : Transformation emptySystem)
        (separated_empty A) extended).symm
    _ = theory.projectors.projectLeft
        (theory.transformationProducts.product right
          (1 : Transformation emptySystem) (separated_empty A) • extended) :=
      congrArg theory.projectors.projectLeft contextual
    _ = right • theory.projectors.projectLeft extended :=
      theory.noSignalling right (1 : Transformation emptySystem)
        (separated_empty A) extended
    _ = right • state := by rw [projected]

/-- Corrected Theorem A.2 (`RR-C012`): congruence pairs corresponding outer
and inner transformations, not the crossed pairs printed in the statement. -/
theorem phenomenallyEquivalent_mul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} {leftOuter rightOuter leftInner rightInner : Transformation A}
    (outerEquivalent : theory.PhenomenallyEquivalent leftOuter rightOuter)
    (innerEquivalent : theory.PhenomenallyEquivalent leftInner rightInner) :
    theory.PhenomenallyEquivalent
      (leftOuter * leftInner) (rightOuter * rightInner) := by
  intro B hsep state
  let products := theory.transformationProducts
  have expand (outer inner : Transformation A) :
      products.product (outer * inner) (1 : Transformation B) hsep • state =
        products.product outer (1 : Transformation B) hsep •
          (products.product inner (1 : Transformation B) hsep • state) := by
    calc
      products.product (outer * inner) (1 : Transformation B) hsep • state =
          products.product (outer * inner)
            ((1 : Transformation B) * (1 : Transformation B)) hsep • state := by
        rw [one_mul]
      _ = (products.product outer (1 : Transformation B) hsep *
            products.product inner (1 : Transformation B) hsep) • state := by
        rw [theory.productMultiplicative hsep outer inner
          (1 : Transformation B) (1 : Transformation B)]
      _ = products.product outer (1 : Transformation B) hsep •
          (products.product inner (1 : Transformation B) hsep • state) :=
        mul_smul _ _ _
  calc
    products.product (leftOuter * leftInner) (1 : Transformation B) hsep • state =
        products.product leftOuter (1 : Transformation B) hsep •
          (products.product leftInner (1 : Transformation B) hsep • state) :=
      expand leftOuter leftInner
    _ = products.product leftOuter (1 : Transformation B) hsep •
        (products.product rightInner (1 : Transformation B) hsep • state) := by
      rw [innerEquivalent hsep state]
    _ = products.product rightOuter (1 : Transformation B) hsep •
        (products.product rightInner (1 : Transformation B) hsep • state) :=
      outerEquivalent hsep _
    _ = products.product (rightOuter * rightInner) (1 : Transformation B) hsep • state :=
      (expand rightOuter rightInner).symm

/-- Phenomenal equivalence is coherent with equality transport of the system
index. -/
theorem phenomenallyEquivalent_reindex
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (indexEq : A = B) {left right : Transformation A}
    (equivalent : theory.PhenomenallyEquivalent left right) :
    theory.PhenomenallyEquivalent
      (reindex Transformation indexEq left)
      (reindex Transformation indexEq right) := by
  cases indexEq
  exact equivalent

/-- The multiplicative congruence whose quotient supplies the monoid structure
without any representative selection. -/
def phenomenalCon
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) : Con (Transformation A) where
  toSetoid := theory.phenomenalSetoid A
  mul' := fun leftRelated rightRelated =>
    theory.phenomenallyEquivalent_mul leftRelated rightRelated

end Theories.NoSignallingTheory

namespace Faithfulness

open Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Transformations modulo corrected contextual phenomenal equivalence. -/
abbrev PhenomenalTransformation
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) :=
  (theory.phenomenalCon A).Quotient

/-- The explicit class constructor. -/
def PhenomenalTransformation.mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (transformation : Transformation A) :
    PhenomenalTransformation theory A :=
  transformation

/-- The indexed quotient monoid family. -/
@[reducible, instance]
def phenomenalTransformationIndexedMonoid
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    IndexedMonoid System (PhenomenalTransformation theory) where
  monoid _ := inferInstance

@[simp]
theorem PhenomenalTransformation.mk_one
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} :
    PhenomenalTransformation.mk theory (1 : Transformation A) = 1 :=
  rfl

@[simp]
theorem PhenomenalTransformation.mk_mul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (left right : Transformation A) :
    PhenomenalTransformation.mk theory (left * right) =
      PhenomenalTransformation.mk theory left * PhenomenalTransformation.mk theory right :=
  rfl

/-- Equality transport of a quotient class is represented by equality
transport of its representative. -/
@[simp]
theorem PhenomenalTransformation.reindex_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (indexEq : A = B) (transformation : Transformation A) :
    reindex (PhenomenalTransformation theory) indexEq
        (PhenomenalTransformation.mk theory transformation) =
      PhenomenalTransformation.mk theory
        (reindex Transformation indexEq transformation) := by
  subst B
  rfl

/-- The quotient action.  Its representative-independence proof is Theorem
A.1, not a local-action definition of the equivalence relation. -/
def phenomenalTransformationSMul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (transformation : PhenomenalTransformation theory A)
    (state : PhenomenalState A) : PhenomenalState A :=
  Con.liftOn transformation (fun representative => representative • state)
    (fun _ _ related => theory.phenomenallyEquivalent_action_eq related state)

/-- The descended phenomenal action satisfies the standard left-action laws. -/
@[reducible, instance]
def phenomenalTransformationIndexedMulAction
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    IndexedMulAction System (PhenomenalTransformation theory) PhenomenalState where
  mulAction A := {
    smul := phenomenalTransformationSMul theory
    one_smul := by
      intro state
      change (1 : Transformation A) • state = state
      exact one_smul (Transformation A) state
    mul_smul := by
      intro left right state
      refine Con.induction_on₂ left right ?_
      intro leftRepresentative rightRepresentative
      exact mul_smul leftRepresentative rightRepresentative state
  }

@[simp]
theorem PhenomenalTransformation.mk_smul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (transformation : Transformation A)
    (state : PhenomenalState A) :
    PhenomenalTransformation.mk theory transformation • state = transformation • state :=
  rfl

end Faithfulness

end RR2021
