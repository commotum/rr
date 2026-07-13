import RR2021.Reverse.Transitive.Action
import RR2021.Reverse.Transitive.Projection

/-!
# General reverse construction: enlarged noumenal states

Section 5.1 removes global transitivity by retaining the global phenomenal
state used to interpret a fundamental class.  An enlarged state at `A` is
therefore a pair consisting of the transitive construction's fundamental
quotient at `A` and a global phenomenal-state label.  Local transformations
and subsystem projectors change only the quotient component.

This module deliberately stops before defining the partial product or the
noumenal--phenomenal map.  In particular, it does not hide the product's
additional equal-label compatibility condition in the state carrier.
-/

namespace RR2021.Reverse.General

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Section 5.1's enlarged noumenal state space.  The first component is the
fundamental class at `A`; the second is the global phenomenal state retained
as an orbit label. -/
abbrev EnlargedNoumenalState
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) : Type (max v w) :=
  Reverse.Transitive.NoumenalState theory invertible A ×
    PhenomenalState globalSystem

namespace EnlargedNoumenalState

/-- Construct an enlarged state from its fundamental class and global
phenomenal label. -/
def mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System)
    (fundamental : Reverse.Transitive.NoumenalState theory invertible A)
    (label : PhenomenalState globalSystem) :
    EnlargedNoumenalState theory invertible A :=
  (fundamental, label)

/-- The source-facing enlarged state represented by a global transformation
and carrying a global phenomenal label. -/
def ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    EnlargedNoumenalState theory invertible A :=
  mk theory invertible A
    (Reverse.Transitive.NoumenalState.mk theory invertible A representative)
    globalLabel

/-- The underlying fundamental class. -/
def fundamental
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (state : EnlargedNoumenalState theory invertible A) :
    Reverse.Transitive.NoumenalState theory invertible A :=
  state.1

/-- The retained global phenomenal label. -/
def label
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (state : EnlargedNoumenalState theory invertible A) :
    PhenomenalState globalSystem :=
  state.2

@[simp]
theorem fundamental_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System)
    (classState : Reverse.Transitive.NoumenalState theory invertible A)
    (globalLabel : PhenomenalState globalSystem) :
    fundamental theory invertible
        (mk theory invertible A classState globalLabel) =
      classState :=
  rfl

@[simp]
theorem label_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System)
    (classState : Reverse.Transitive.NoumenalState theory invertible A)
    (globalLabel : PhenomenalState globalSystem) :
    label theory invertible
        (mk theory invertible A classState globalLabel) = globalLabel :=
  rfl

@[simp]
theorem fundamental_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    fundamental theory invertible
        (ofRepresentative theory invertible A representative globalLabel) =
      Reverse.Transitive.NoumenalState.mk theory invertible A representative :=
  rfl

@[simp]
theorem label_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    label theory invertible
        (ofRepresentative theory invertible A representative globalLabel) =
      globalLabel :=
  rfl

/-- The enlarged local action: act on the fundamental class and retain the
global phenomenal label unchanged. -/
def smul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (state : EnlargedNoumenalState theory invertible A) :
    EnlargedNoumenalState theory invertible A :=
  (Reverse.Transitive.NoumenalState.smul theory invertible
      localTransformation state.1,
    state.2)

/-- Computation of the enlarged action on an explicit state pair. -/
@[simp]
theorem smul_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (fundamental : Reverse.Transitive.NoumenalState theory invertible A)
    (label : PhenomenalState globalSystem) :
    smul theory invertible localTransformation
        (mk theory invertible A fundamental label) =
      mk theory invertible A
        (Reverse.Transitive.NoumenalState.smul theory invertible
          localTransformation fundamental)
        label :=
  rfl

@[simp]
theorem fundamental_smul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (state : EnlargedNoumenalState theory invertible A) :
    fundamental theory invertible
        (smul theory invertible localTransformation state) =
      Reverse.Transitive.NoumenalState.smul theory invertible
        localTransformation (fundamental theory invertible state) :=
  rfl

@[simp]
theorem label_smul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (state : EnlargedNoumenalState theory invertible A) :
    label theory invertible (smul theory invertible localTransformation state) =
      label theory invertible state :=
  rfl

/-- Computation of the enlarged action on a represented fundamental class. -/
@[simp]
theorem smul_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    smul theory invertible localTransformation
        (ofRepresentative theory invertible A representative globalLabel) =
      ofRepresentative theory invertible A
        (RR2021.Reverse.extendSystem theory A localTransformation * representative)
        globalLabel :=
  rfl

/-- The enlarged state family carries the local indexed action.  The instance
is reducible so downstream structure constructors can infer ordinary `•`
notation without installing a global opaque action. -/
@[reducible, instance]
def indexedMulAction
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    IndexedMulAction System Transformation
      (EnlargedNoumenalState theory invertible) where
  mulAction A := {
    smul := smul theory invertible
    one_smul := by
      intro state
      cases state with
      | mk fundamental label =>
          apply Prod.ext
          · exact one_smul (Transformation A) fundamental
          · rfl
    mul_smul := by
      intro outer inner state
      cases state with
      | mk fundamental label =>
          apply Prod.ext
          · exact mul_smul outer inner fundamental
          · rfl
  }

/-- The reducible indexed action is inferable through ordinary `•` notation. -/
@[simp]
theorem act_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (classState : Reverse.Transitive.NoumenalState theory invertible A)
    (globalLabel : PhenomenalState globalSystem) :
    localTransformation • mk theory invertible A classState globalLabel =
      mk theory invertible A
        (Reverse.Transitive.NoumenalState.smul theory invertible
          localTransformation classState)
        globalLabel :=
  rfl

/-- Ordinary action notation also computes directly on a global
representative. -/
@[simp]
theorem act_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (localTransformation : Transformation A)
    (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    localTransformation •
        ofRepresentative theory invertible A representative globalLabel =
      ofRepresentative theory invertible A
        (RR2021.Reverse.extendSystem theory A localTransformation * representative)
        globalLabel :=
  rfl

/-- The enlarged subsystem projector: project the fundamental class and
retain the same global phenomenal label. -/
def project
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (state : EnlargedNoumenalState theory invertible B) :
    EnlargedNoumenalState theory invertible A :=
  (Reverse.Transitive.NoumenalState.project theory invertible hAB state.1,
    state.2)

/-- Computation of an enlarged projector on an explicit state pair. -/
@[simp]
theorem project_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (fundamental : Reverse.Transitive.NoumenalState theory invertible B)
    (label : PhenomenalState globalSystem) :
    project theory invertible hAB
        (mk theory invertible B fundamental label) =
      mk theory invertible A
        (Reverse.Transitive.NoumenalState.project theory invertible hAB
          fundamental)
        label :=
  rfl

/-- Projection changes only the system index of a represented fundamental
class and retains both its representative and global label. -/
@[simp]
theorem project_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    project theory invertible hAB
        (ofRepresentative theory invertible B representative globalLabel) =
      ofRepresentative theory invertible A representative globalLabel :=
  rfl

@[simp]
theorem fundamental_project
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (state : EnlargedNoumenalState theory invertible B) :
    fundamental theory invertible (project theory invertible hAB state) =
      Reverse.Transitive.NoumenalState.project theory invertible hAB
        (fundamental theory invertible state) :=
  rfl

@[simp]
theorem label_project
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (state : EnlargedNoumenalState theory invertible B) :
    label theory invertible (project theory invertible hAB state) =
      label theory invertible state :=
  rfl

/-- The enlarged projector family.  Nesting is inherited by the fundamental
component, while the global label is definitionally unchanged. -/
def projectors
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    ProjectorFamily System (EnlargedNoumenalState theory invertible) where
  project := project theory invertible
  nested := by
    intro A B C hAB hBC state
    cases state with
    | mk fundamental label =>
        apply Prod.ext
        · exact (Reverse.Transitive.NoumenalState.projectors theory invertible).nested
            hAB hBC fundamental
        · rfl

/-- Every enlarged projector is surjective.  Lift a preimage of the
fundamental component through the transitive quotient projector and retain
the target's label. -/
theorem projectors_surjective
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    (projectors theory invertible).Surjective := by
  intro A B hAB state
  obtain ⟨fundamental, label⟩ := state
  obtain ⟨preimage, hpreimage⟩ :=
    Reverse.Transitive.NoumenalState.projectors_surjective
      theory invertible hAB fundamental
  refine ⟨mk theory invertible B preimage label, ?_⟩
  apply Prod.ext
  · exact hpreimage
  · rfl

end EnlargedNoumenalState

end RR2021.Reverse.General
