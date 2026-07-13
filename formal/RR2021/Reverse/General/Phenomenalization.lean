import RR2021.Reverse.General.State
import RR2021.Reverse.Transitive.Phenomenalization

/-!
# General reverse construction: phenomenalization

The enlarged construction uses the global phenomenal state stored in each
noumenal state as the explicit reference parameter of the Stage 7 quotient
map.  This makes the map total on all fundamental classes without selecting a
global reference state and makes it surjective without global transitivity.

The projector proof follows the corrected Stage 7 path: first project the
fundamental class from `B` to `A`, then apply the `A`-indexed phenomenal map.
-/

namespace RR2021.Reverse.General

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace EnlargedNoumenalState

/-- Section 5.1's general noumenal--phenomenal map.  The retained global
phenomenal label is supplied as the reference state to the already-descended
map on the fundamental quotient. -/
def phenomenalize
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System} (state : EnlargedNoumenalState theory invertible A) :
    PhenomenalState A :=
  Reverse.Transitive.NoumenalState.phenomenalize
    theory invertible state.2 state.1

/-- Computation of general phenomenalization on an explicit state pair. -/
@[simp]
theorem phenomenalize_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A : System}
    (classState : Reverse.Transitive.NoumenalState theory invertible A)
    (globalLabel : PhenomenalState globalSystem) :
    phenomenalize theory invertible
        (mk theory invertible A classState globalLabel) =
      Reverse.Transitive.NoumenalState.phenomenalize
        theory invertible globalLabel classState :=
  rfl

/-- On a represented fundamental class, the general map is the `A`-marginal
of that representative acting on the retained global label. -/
@[simp]
theorem phenomenalize_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (A : System) (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    phenomenalize theory invertible
        (ofRepresentative theory invertible A representative globalLabel) =
      globalProjection theory A (representative • globalLabel) :=
  rfl

/-- The general phenomenalization packaged as an indexed map. -/
def phenomenalization
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    IndexedMap System (EnlargedNoumenalState theory invertible) PhenomenalState where
  toFun := phenomenalize theory invertible

/-- The enlarged local action is equivariant for general phenomenalization.
The global label is fixed by the action, so this is exactly Stage 7
equivariance at that label. -/
theorem phenomenalization_equivariant
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    (phenomenalization theory invertible).Equivariant
      (Transformation := Transformation) := by
  intro A localTransformation state
  obtain ⟨classState, globalLabel⟩ := state
  change Reverse.Transitive.NoumenalState.phenomenalize
      theory invertible globalLabel
        (Reverse.Transitive.NoumenalState.smul
          theory invertible localTransformation classState) =
    localTransformation •
      Reverse.Transitive.NoumenalState.phenomenalize
        theory invertible globalLabel classState
  exact Reverse.Transitive.NoumenalState.phenomenalization_equivariant
    theory invertible globalLabel localTransformation classState

/-- General phenomenalization commutes with the enlarged noumenal projectors
and the original phenomenal projectors.  The retained label is unchanged by
projection, so the corrected Stage 7 projector theorem applies directly. -/
theorem phenomenalization_projectionCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    ProjectionCompatible
      (phenomenalization theory invertible)
      (projectors theory invertible) theory.projectors := by
  intro A B hAB state
  obtain ⟨classState, globalLabel⟩ := state
  change Reverse.Transitive.NoumenalState.phenomenalize
      theory invertible globalLabel
        (Reverse.Transitive.NoumenalState.project
          theory invertible hAB classState) =
    theory.projectors.project hAB
      (Reverse.Transitive.NoumenalState.phenomenalize
        theory invertible globalLabel classState)
  exact Reverse.Transitive.NoumenalState.phenomenalization_projectionCompatible
    theory invertible globalLabel hAB classState

/-- Theorem 5.16: general phenomenalization is componentwise surjective with
no global-transitivity hypothesis.  A phenomenal target at `A` lifts to a
global label by phenomenal-projector surjectivity; the identity fundamental
class paired with that label maps back to the target. -/
theorem phenomenalization_surjective
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    (phenomenalization theory invertible).Surjective := by
  intro A target
  obtain ⟨globalLabel, globalLabel_projection⟩ :=
    theory.projectorsSurjective (subsystem_global A) target
  refine ⟨ofRepresentative theory invertible A
      (1 : Transformation globalSystem) globalLabel, ?_⟩
  change globalProjection theory A
      ((1 : Transformation globalSystem) • globalLabel) = target
  rw [one_smul]
  exact globalLabel_projection

end EnlargedNoumenalState

end RR2021.Reverse.General
