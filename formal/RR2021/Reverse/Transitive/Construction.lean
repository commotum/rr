import RR2021.Reverse.Transitive.Locality
import RR2021.Reverse.Transitive.Phenomenalization
import RR2021.Faithfulness.NoumenalContextual
import RR2021.Faithfulness.Noumenal

/-!
# Transitive reverse construction: final constructors

The construction is deliberately assembled in three layers.  First,
`coreAtReference` builds every corrected local-realistic field except
noumenal action effectivity.  Only after that pre-faithful core exists does
Theorem 4.2 turn equality of its noumenal actions into contextual phenomenal
equivalence.  Input phenomenal faithfulness can then recover the original
transformations, without using the desired effectivity anywhere upstream.

The alternative `faithfulQuotientAtReference` implements the repaired
`RR-C017` route: it applies Appendix B to the completed core, so it does not
need phenomenal faithfulness or Appendix A's unproved separation-preservation
claim.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Section 5's transitive special case at an explicit global
reference state, before Axiom 3.7 is added.

Invertibility makes the fundamental relation a setoid and supports Theorem
5.8; transformation separation makes the compatibility-indexed state product
unique; global transitivity is used only for Theorem 5.14, the surjectivity of
the reference-state phenomenalization.  No phenomenal-faithfulness assumption
is used. -/
noncomputable def coreAtReference
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : theory.GloballyTransitive) :
    LocalRealisticCore System Transformation
      (NoumenalState theory invertible) PhenomenalState where
  noumenalNonempty := by
    intro A
    exact ⟨NoumenalState.mk theory invertible A 1⟩
  phenomenalization :=
    NoumenalState.phenomenalization theory invertible reference
  phenomenalizationEquivariant :=
    NoumenalState.phenomenalization_equivariant theory invertible reference
  phenomenalizationSurjective :=
    NoumenalState.phenomenalization_surjective theory invertible reference
      globallyTransitive
  noumenalProjectors := NoumenalState.projectors theory invertible
  noumenalProjectorsSurjective :=
    NoumenalState.projectors_surjective theory invertible
  phenomenalProjectors := theory.projectors
  phenomenalizationProjectionCompatible :=
    NoumenalState.phenomenalization_projectionCompatible theory invertible reference
  noumenalProduct :=
    NoumenalState.stateProduct theory invertible transformationSeparation
  transformationProducts := theory.transformationProducts
  locality :=
    NoumenalState.locality theory invertible transformationSeparation

/-- Theorem 4.3 specialized to the constructed fundamental-state core.

The proof is noncircular: Theorem 4.2 consumes only the already completed
`LocalRealisticCore`.  Its transformation product is definitionally the input
no-signalling product, so contextual phenomenal faithfulness applies directly.
-/
theorem actionEffectiveAtReference
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : theory.GloballyTransitive)
    (phenomenallyFaithful : theory.PhenomenallyFaithful) :
    NoumenallyFaithful Transformation (NoumenalState theory invertible) := by
  let core := coreAtReference theory invertible transformationSeparation
    reference globallyTransitive
  apply Faithfulness.noumenallyFaithful_of_contextualPhenomenalFaithfulness core
  intro A left right equivalent
  exact phenomenallyFaithful A left right equivalent

/-- The transitive reverse constructor retaining the input transformation
family.  Its additional `PhenomenallyFaithful` premise is used exactly once,
to add Axiom 3.7 after the pre-faithful core has been built. -/
noncomputable def theoryAtReference
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : theory.GloballyTransitive)
    (phenomenallyFaithful : theory.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (NoumenalState theory invertible) PhenomenalState where
  toLocalRealisticCore :=
    coreAtReference theory invertible transformationSeparation reference
      globallyTransitive
  noumenalActionFaithful :=
    actionEffectiveAtReference theory invertible transformationSeparation reference
      globallyTransitive phenomenallyFaithful

/-- The repaired `RR-C017` constructor.  Reverse construction is performed
with the original transformations while invertibility and transformation
separation are still available; Appendix B then quotients by the constructed
noumenal action kernel.  Consequently no phenomenal-faithfulness premise and
no preservation of reverse postulates through the quotient are required. -/
noncomputable def faithfulQuotientAtReference
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : theory.GloballyTransitive) :
    LocalRealisticTheory System
      (coreAtReference theory invertible transformationSeparation reference
        globallyTransitive).NoumenalFaithfulTransformation
      (NoumenalState theory invertible) PhenomenalState :=
  (coreAtReference theory invertible transformationSeparation reference
    globallyTransitive).toNoumenallyFaithfulQuotient

end RR2021.Reverse.Transitive
