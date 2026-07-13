import RR2021.Correspondence.API

/-!
# Stable correspondence consumers

These generic consumers exercise the public theorem family at each distinct
assumption boundary.  In particular, the general quotient consumer needs no
phenomenal-faithfulness or global-transitivity argument, while the raw and
transitive consumers display their additional premises.
-/

namespace RR2021.Correspondence.Examples

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w x

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The forward consumer has no reverse-postulate inputs. -/
def forwardConsumer
    [IndexedMulAction System Transformation NoumenalState]
    (source :
      LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    NoSignallingTheory System Transformation PhenomenalState :=
  Correspondence.forward source

/-- The corrected central general reverse consumer: invertibility and raw
separation are the only extra premises, and the output transformations are
the Appendix-B quotient family. -/
noncomputable def generalQuotientConsumer
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation) :
    LocalRealisticTheory System
      (Reverse.General.core source invertible
        transformationSeparation).NoumenalFaithfulTransformation
      (Reverse.General.EnlargedNoumenalState source invertible)
      PhenomenalState :=
  Correspondence.generalReverseWithFaithfulQuotient source invertible
    transformationSeparation

/-- Retaining the input transformation family adds exactly contextual
phenomenal faithfulness. -/
noncomputable def generalRawConsumer
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (Reverse.General.EnlargedNoumenalState source invertible)
      PhenomenalState :=
  Correspondence.generalReverseRetainingTransformations source invertible
    transformationSeparation phenomenallyFaithful

/-- The transitive raw-transform consumer makes its reference and global
transitivity inputs explicit in addition to phenomenal faithfulness. -/
noncomputable def transitiveRawConsumer
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : source.GloballyTransitive)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (Reverse.Transitive.NoumenalState source invertible) PhenomenalState :=
  Correspondence.transitiveReverseRetainingTransformations source invertible
    transformationSeparation reference globallyTransitive
    phenomenallyFaithful

/-- A stable consumer of general raw reverse/forward operational
preservation. -/
theorem generalRawConsumer_preservesOperationalData
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    Correspondence.SameOperationalData
      (Correspondence.forward
        (generalRawConsumer source invertible transformationSeparation
          phenomenallyFaithful))
      source :=
  Correspondence.generalReverse_forward_sameOperationalData source invertible
    transformationSeparation phenomenallyFaithful

/-- A stable consumer of transitive raw reverse/forward operational
preservation. -/
theorem transitiveRawConsumer_preservesOperationalData
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : source.GloballyTransitive)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    Correspondence.SameOperationalData
      (Correspondence.forward
        (transitiveRawConsumer source invertible transformationSeparation
          reference globallyTransitive phenomenallyFaithful))
      source :=
  Correspondence.transitiveReverse_forward_sameOperationalData source invertible
    transformationSeparation reference globallyTransitive
    phenomenallyFaithful

end RR2021.Correspondence.Examples
