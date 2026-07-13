import RR2021.Reverse.Transitive.Action
import RR2021.Reverse.Transitive.Projection

/-!
# Transitive reverse construction: reference-state phenomenalization

For a fixed global phenomenal state `reference`, the phenomenal image of the
fundamental class represented by `globalTransformation` is the `A`-marginal
of `globalTransformation • reference`.  Theorem 5.11 is the exact quotient
descent obligation.  Theorems 5.12--5.14 then give equivariance, projector
compatibility, and (under global transitivity) surjectivity.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace NoumenalState

/-- Theorem 5.11: fundamentally equivalent global transformations have the
same `A`-phenomenal marginal after acting on any fixed global state.  This is
the sole representative-independence proof used to descend `phenomenalize`. -/
theorem globalProjection_smul_eq_of_fundamentallyEquivalent
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (A : System) (reference : PhenomenalState globalSystem)
    {left right : Transformation globalSystem}
    (equivalent : FundamentallyEquivalent theory A left right) :
    globalProjection theory A (left • reference) =
      globalProjection theory A (right • reference) := by
  obtain ⟨remote, left_eq⟩ := equivalent
  calc
    globalProjection theory A (left • reference) =
        globalProjection theory A
          ((extendComplement theory A remote * right) • reference) := by
      rw [left_eq]
    _ = globalProjection theory A
          (extendComplement theory A remote • (right • reference)) := by
      rw [mul_smul]
    _ = globalProjection theory A (right • reference) :=
      globalProjection_extendComplement theory A remote (right • reference)

/-- The reference-state phenomenal map on the quotient at `A`. -/
def phenomenalize
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem) {A : System} :
    NoumenalState theory invertible A → PhenomenalState A :=
  Quotient.lift
    (fun globalTransformation =>
      globalProjection theory A (globalTransformation • reference))
    (fun _ _ equivalent =>
      globalProjection_smul_eq_of_fundamentallyEquivalent
        theory A reference equivalent)

/-- Computation of the reference-state phenomenal map on a represented
fundamental class. -/
@[simp]
theorem phenomenalize_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem) (A : System)
    (globalTransformation : Transformation globalSystem) :
    phenomenalize theory invertible reference
        (mk theory invertible A globalTransformation) =
      globalProjection theory A (globalTransformation • reference) :=
  rfl

/-- The family of reference-state phenomenal maps, packaged as an indexed
map without bundling any of its independent properties. -/
def phenomenalization
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem) :
    IndexedMap System (NoumenalState theory invertible) PhenomenalState where
  toFun := phenomenalize theory invertible reference

/-- Theorem 5.12: reference-state phenomenalization intertwines the descended
local quotient action with the original phenomenal action. -/
theorem phenomenalization_equivariant
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem) :
    letI := indexedMulAction theory invertible
    (phenomenalization theory invertible reference).Equivariant
      (Transformation := Transformation) := by
  letI := indexedMulAction theory invertible
  intro A localTransformation state
  induction state using Quotient.inductionOn with
  | _ globalTransformation =>
      change globalProjection theory A
          ((extendSystem theory A localTransformation * globalTransformation) •
            reference) =
        localTransformation •
          globalProjection theory A (globalTransformation • reference)
      calc
        globalProjection theory A
            ((extendSystem theory A localTransformation * globalTransformation) •
              reference) =
          globalProjection theory A
            (extendSystem theory A localTransformation •
              (globalTransformation • reference)) := by
            rw [mul_smul]
        _ = localTransformation •
            globalProjection theory A (globalTransformation • reference) :=
          globalProjection_extendSystem theory A localTransformation
            (globalTransformation • reference)

/-- Corrected Theorem 5.13 (`RR-C020`): phenomenalization commutes with
projectors.  On a representative, quotient projection first changes
`[W]^B` to `[W]^A`; only then is the `A`-indexed phenomenal map applied. -/
theorem phenomenalization_projectionCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem) :
    ProjectionCompatible
      (phenomenalization theory invertible reference)
      (projectors theory invertible) theory.projectors := by
  intro A B hAB state
  induction state using Quotient.inductionOn with
  | _ globalTransformation =>
      change globalProjection theory A (globalTransformation • reference) =
        theory.projectors.project hAB
          (globalProjection theory B (globalTransformation • reference))
      unfold globalProjection
      calc
        theory.projectors.project (subsystem_global A)
            (globalTransformation • reference) =
          theory.projectors.project (hAB.trans (subsystem_global B))
            (globalTransformation • reference) :=
          theory.projectors.project_proof_irrelevant _ _ _
        _ = theory.projectors.project hAB
            (theory.projectors.project (subsystem_global B)
              (globalTransformation • reference)) :=
          (theory.projectors.nested hAB (subsystem_global B)
            (globalTransformation • reference)).symm

/-- Theorem 5.14: global transitivity from the explicit reference state,
together with surjectivity of the phenomenal projector from the global
system, makes every component of the reference-state map surjective. -/
theorem phenomenalization_surjective
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : theory.GloballyTransitive) :
    (phenomenalization theory invertible reference).Surjective := by
  intro A target
  obtain ⟨globalTarget, globalTarget_projection⟩ :=
    theory.projectorsSurjective (subsystem_global A) target
  obtain ⟨globalTransformation, reaches_target⟩ :=
    globallyTransitive reference globalTarget
  refine ⟨mk theory invertible A globalTransformation, ?_⟩
  change globalProjection theory A (globalTransformation • reference) = target
  rw [reaches_target]
  exact globalTarget_projection

end NoumenalState

end RR2021.Reverse.Transitive
