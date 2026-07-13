import RR2021.Theories.Basic
import RR2021.Theories.Postulates

/-!
# Reverse construction: canonical global extensions

Local transformations are extended by the identity on the complementary
system and then reindexed from `A ⊔ Aᶜ` to the global system.  These named
operations keep every system transport used by Section 5 explicit.
-/

namespace RR2021.Reverse

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Extend a transformation on `A` by the identity on `Aᶜ`, at the global
system index. -/
def extendSystem
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (transformation : Transformation A) :
    Transformation globalSystem :=
  reindex Transformation (composite_complement A)
    (theory.transformationProducts.product transformation
      (1 : Transformation (complement A)) (separated_complement A))

/-- Extend a transformation on `Aᶜ` by the identity on `A`, at the global
system index. -/
def extendComplement
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (transformation : Transformation (complement A)) :
    Transformation globalSystem :=
  reindex Transformation (composite_complement A)
    (theory.transformationProducts.product (1 : Transformation A)
      transformation (separated_complement A))

/-- The phenomenal projection from the global system to `A`. -/
def globalProjection
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) : PhenomenalState globalSystem → PhenomenalState A :=
  theory.projectors.project (subsystem_global A)

/-- Reindexing a state from `A ⊔ Aᶜ` to the global system and then projecting
to `A` agrees with the ordinary left composite projection. -/
theorem globalProjection_reindex_complement
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (state : PhenomenalState (Composite A (complement A))) :
    globalProjection theory A
        (reindex PhenomenalState (composite_complement A) state) =
      theory.projectors.projectLeft state := by
  unfold globalProjection ProjectorFamily.projectLeft
  calc
    theory.projectors.project (subsystem_global A)
        (reindex PhenomenalState (composite_complement A) state) =
      theory.projectors.project
        (ProjectorFamily.reindexSubsystemDomain (composite_complement A)
          (show Subsystem A (Composite A (complement A)) from le_sup_left))
        (reindex PhenomenalState (composite_complement A) state) :=
      theory.projectors.project_proof_irrelevant _ _ _
    _ = theory.projectors.project
        (show Subsystem A (Composite A (complement A)) from le_sup_left) state :=
      theory.projectors.project_reindex_domain (composite_complement A) _ state

/-- A local extension of the identity is the global identity. -/
@[simp]
theorem extendSystem_one
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) :
    extendSystem theory A (1 : Transformation A) =
      (1 : Transformation globalSystem) := by
  unfold extendSystem
  rw [theory.productUnital (separated_complement A), reindex_one]

/-- A complementary extension of the identity is the global identity. -/
@[simp]
theorem extendComplement_one
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) :
    extendComplement theory A (1 : Transformation (complement A)) =
      (1 : Transformation globalSystem) := by
  unfold extendComplement
  rw [theory.productUnital (separated_complement A), reindex_one]

/-- Local extension preserves multiplication. -/
theorem extendSystem_mul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (outer inner : Transformation A) :
    extendSystem theory A (outer * inner) =
      extendSystem theory A outer * extendSystem theory A inner := by
  unfold extendSystem
  rw [← reindex_mul]
  apply congrArg (reindex Transformation (composite_complement A))
  simpa only [one_mul] using
    (theory.productMultiplicative (separated_complement A)
      outer inner (1 : Transformation (complement A))
      (1 : Transformation (complement A))).symm

/-- Complementary extension preserves multiplication. -/
theorem extendComplement_mul
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (outer inner : Transformation (complement A)) :
    extendComplement theory A (outer * inner) =
      extendComplement theory A outer * extendComplement theory A inner := by
  unfold extendComplement
  rw [← reindex_mul]
  apply congrArg (reindex Transformation (composite_complement A))
  simpa only [one_mul] using
    (theory.productMultiplicative (separated_complement A)
      (1 : Transformation A) (1 : Transformation A) outer inner).symm

/-- The two disjoint global extensions commute. -/
theorem extendSystem_extendComplement_commute
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (localTransformation : Transformation A)
    (remote : Transformation (complement A)) :
    extendSystem theory A localTransformation * extendComplement theory A remote =
      extendComplement theory A remote *
        extendSystem theory A localTransformation := by
  unfold extendSystem extendComplement
  rw [← reindex_mul, ← reindex_mul]
  apply congrArg (reindex Transformation (composite_complement A))
  calc
    theory.transformationProducts.product localTransformation 1
        (separated_complement A) *
        theory.transformationProducts.product 1 remote (separated_complement A) =
      theory.transformationProducts.product (localTransformation * 1) (1 * remote)
        (separated_complement A) :=
      theory.productMultiplicative (separated_complement A)
        localTransformation 1 1 remote
    _ = theory.transformationProducts.product localTransformation remote
        (separated_complement A) := by
      rw [mul_one localTransformation, one_mul remote]
    _ = theory.transformationProducts.product (1 * localTransformation) (remote * 1)
        (separated_complement A) := by
      rw [one_mul localTransformation, mul_one remote]
    _ = theory.transformationProducts.product 1 remote
          (separated_complement A) *
        theory.transformationProducts.product localTransformation 1
          (separated_complement A) :=
      (theory.productMultiplicative (separated_complement A)
        1 localTransformation remote 1).symm

/-- A complementary extension has no effect on the `A` phenomenal marginal. -/
theorem globalProjection_extendComplement
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (remote : Transformation (complement A))
    (state : PhenomenalState globalSystem) :
    globalProjection theory A (extendComplement theory A remote • state) =
      globalProjection theory A state := by
  let indexEq := composite_complement A
  let compositeState : PhenomenalState (Composite A (complement A)) :=
    reindex PhenomenalState indexEq.symm state
  have state_roundtrip :
      reindex PhenomenalState indexEq compositeState = state := by
    exact reindex_inverse_rev PhenomenalState indexEq state
  have acted_roundtrip :
      reindex PhenomenalState indexEq
          (theory.transformationProducts.product (1 : Transformation A) remote
            (separated_complement A) • compositeState) =
        extendComplement theory A remote • state := by
    rw [reindex_smul, state_roundtrip]
    rfl
  rw [← acted_roundtrip, globalProjection_reindex_complement]
  calc
    theory.projectors.projectLeft
        (theory.transformationProducts.product (1 : Transformation A) remote
          (separated_complement A) • compositeState) =
      (1 : Transformation A) • theory.projectors.projectLeft compositeState :=
      theory.noSignalling 1 remote (separated_complement A) compositeState
    _ = theory.projectors.projectLeft compositeState := one_act _
    _ = globalProjection theory A state := by
      rw [← state_roundtrip, globalProjection_reindex_complement]

/-- A local extension acts on the `A` phenomenal marginal by the original
local transformation. -/
theorem globalProjection_extendSystem
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (localTransformation : Transformation A)
    (state : PhenomenalState globalSystem) :
    globalProjection theory A (extendSystem theory A localTransformation • state) =
      localTransformation • globalProjection theory A state := by
  let indexEq := composite_complement A
  let compositeState : PhenomenalState (Composite A (complement A)) :=
    reindex PhenomenalState indexEq.symm state
  have state_roundtrip :
      reindex PhenomenalState indexEq compositeState = state := by
    exact reindex_inverse_rev PhenomenalState indexEq state
  have acted_roundtrip :
      reindex PhenomenalState indexEq
          (theory.transformationProducts.product localTransformation
            (1 : Transformation (complement A)) (separated_complement A) •
            compositeState) =
        extendSystem theory A localTransformation • state := by
    rw [reindex_smul, state_roundtrip]
    rfl
  rw [← acted_roundtrip, globalProjection_reindex_complement]
  calc
    theory.projectors.projectLeft
        (theory.transformationProducts.product localTransformation
          (1 : Transformation (complement A)) (separated_complement A) •
          compositeState) =
      localTransformation • theory.projectors.projectLeft compositeState :=
      theory.noSignalling localTransformation 1 (separated_complement A)
        compositeState
    _ = localTransformation • globalProjection theory A state := by
      rw [← state_roundtrip, globalProjection_reindex_complement]

end RR2021.Reverse
