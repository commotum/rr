import RR2021.Reverse.General.Locality
import RR2021.Reverse.General.Phenomenalization
import RR2021.Faithfulness.NoumenalContextual
import RR2021.Faithfulness.Noumenal

/-!
# General reverse construction: final constructors

Section 5.1 stores the reference global phenomenal state in each enlarged
noumenal state.  This removes global transitivity from the construction of
the noumenal--phenomenal epimorphism.  As in the transitive special case, the
construction is assembled first as a `LocalRealisticCore`, before any
noumenal action-effectivity argument is used.

There are then two honest full-theory outputs.  Contextual phenomenal
faithfulness recovers effectivity while retaining the input transformation
family.  Alternatively, the Appendix-B action-kernel quotient supplies
effectivity without phenomenal faithfulness; this is the general `RR-C017`
route and deliberately changes the transformation family.
-/

namespace RR2021.Reverse.General

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Section 5.1's general reverse construction before Axiom 3.7 is added.

Invertibility makes the fundamental relation a setoid and is used by the
Stage 7 quotient infrastructure.  Raw transformation separation supplies
the uniqueness needed by the honest compatibility-indexed state product.
The global phenomenal state required by the reference-state map is retained
inside each enlarged state, so no global-transitivity or
phenomenal-faithfulness premise occurs here. -/
noncomputable def core
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation) :
    LocalRealisticCore System Transformation
      (EnlargedNoumenalState source invertible) PhenomenalState where
  noumenalNonempty := by
    intro A
    obtain ⟨globalLabel⟩ := source.stateNonempty globalSystem
    exact ⟨EnlargedNoumenalState.ofRepresentative source invertible A
      (1 : Transformation globalSystem) globalLabel⟩
  phenomenalization :=
    EnlargedNoumenalState.phenomenalization source invertible
  phenomenalizationEquivariant :=
    EnlargedNoumenalState.phenomenalization_equivariant source invertible
  phenomenalizationSurjective :=
    EnlargedNoumenalState.phenomenalization_surjective source invertible
  noumenalProjectors := EnlargedNoumenalState.projectors source invertible
  noumenalProjectorsSurjective :=
    EnlargedNoumenalState.projectors_surjective source invertible
  phenomenalProjectors := source.projectors
  phenomenalizationProjectionCompatible :=
    EnlargedNoumenalState.phenomenalization_projectionCompatible
      source invertible
  noumenalProduct :=
    EnlargedNoumenalState.stateProduct source invertible
      transformationSeparation
  transformationProducts := source.transformationProducts
  locality :=
    EnlargedNoumenalState.locality source invertible transformationSeparation

/-- Theorem 4.3 specialized to the enlarged-state core.

The contextual refinement theorem consumes only the already-completed
`LocalRealisticCore`.  Because its transformation product is definitionally
the input no-signalling product, the input phenomenal-faithfulness postulate
then identifies the two raw transformations.  No global transitivity is
introduced by this final step. -/
theorem actionEffective
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    NoumenallyFaithful Transformation
      (EnlargedNoumenalState source invertible) := by
  let constructedCore := core source invertible transformationSeparation
  apply Faithfulness.noumenallyFaithful_of_contextualPhenomenalFaithfulness
    constructedCore
  intro A left right equivalent
  exact phenomenallyFaithful A left right equivalent

/-- The general reverse constructor retaining the original transformation
family.  Its additional contextual phenomenal-faithfulness premise is used
only after every `LocalRealisticCore` field has been constructed. -/
noncomputable def theory
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (EnlargedNoumenalState source invertible) PhenomenalState where
  toLocalRealisticCore := core source invertible transformationSeparation
  noumenalActionFaithful :=
    actionEffective source invertible transformationSeparation
      phenomenallyFaithful

/-- The general repaired `RR-C017` constructor.

The reverse construction consumes invertibility and raw transformation
separation before Appendix B quotients the completed enlarged-state core by
the kernel of its noumenal action.  Consequently this result needs neither
global transitivity nor phenomenal faithfulness.  It does not claim that the
input transformation family, invertibility, or separation survives the
quotient. -/
noncomputable def faithfulQuotient
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation) :
    LocalRealisticTheory System
      (core source invertible
        transformationSeparation).NoumenalFaithfulTransformation
      (EnlargedNoumenalState source invertible) PhenomenalState :=
  (core source invertible
    transformationSeparation).toNoumenallyFaithfulQuotient

end RR2021.Reverse.General
