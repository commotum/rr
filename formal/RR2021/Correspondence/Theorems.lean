import RR2021.Forward.API
import RR2021.Faithfulness.API
import RR2021.Reverse.API

/-!
# Exact forward and reverse theorem family

This module gives public names to the separate constructions supported by the
formal development.  It deliberately does not define an equivalence of model
categories: the forward construction forgets noumenal data, while the two
faithfulness repairs change the transformation family.

For reverse outputs that retain the input transformation family, forwarding
the constructed theory preserves the source phenomenal projectors and
separated transformation product.  `SameOperationalData` records exactly
those remaining data fields; the carrier, monoid, phenomenal action, and
phenomenal-state family are already shared by its type.
-/

namespace RR2021.Correspondence

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w x

/-- The forward construction, with no reverse postulates. -/
def forward
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {NoumenalState : System → Type w}
    {PhenomenalState : System → Type x}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation NoumenalState]
    [IndexedMulAction System Transformation PhenomenalState]
    (source :
      LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    NoSignallingTheory System Transformation PhenomenalState :=
  source.toNoSignallingTheory

/-- Appendix A's contextual phenomenal-faithfulness quotient.  It changes the
transformation family and leaves the phenomenal state family unchanged. -/
def phenomenalFaithfulnessQuotient
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState) :
    NoSignallingTheory System
      (Faithfulness.PhenomenalTransformation source) PhenomenalState :=
  Faithfulness.phenomenalQuotientTheory source

/-- The Appendix A output is faithful in the source's contextual sense. -/
theorem phenomenalFaithfulnessQuotient_faithful
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalFaithfulnessQuotient source).PhenomenallyFaithful :=
  Faithfulness.phenomenalQuotientTheory_phenomenallyFaithful source

/-- Appendix B's noumenal action-kernel quotient.  It needs only an already
completed pre-faithful core and changes the transformation family. -/
def noumenalFaithfulnessQuotient
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {NoumenalState : System → Type w}
    {PhenomenalState : System → Type x}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation NoumenalState]
    [IndexedMulAction System Transformation PhenomenalState]
    (source :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState) :
    LocalRealisticTheory System source.NoumenalFaithfulTransformation
      NoumenalState PhenomenalState :=
  source.toNoumenallyFaithfulQuotient

/-- The transitive reverse construction retaining the input transformation
family.  Its reference, transitivity, and phenomenal-faithfulness premises are
all explicit. -/
noncomputable def transitiveReverseRetainingTransformations
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : source.GloballyTransitive)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (Reverse.Transitive.NoumenalState source invertible) PhenomenalState :=
  Reverse.Transitive.theoryAtReference source invertible
    transformationSeparation reference globallyTransitive phenomenallyFaithful

/-- The transitive reverse construction followed by Appendix B.  It drops
phenomenal faithfulness by changing the transformation family. -/
noncomputable def transitiveReverseWithFaithfulQuotient
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : source.GloballyTransitive) :
    LocalRealisticTheory System
      (Reverse.Transitive.coreAtReference source invertible
        transformationSeparation reference
        globallyTransitive).NoumenalFaithfulTransformation
      (Reverse.Transitive.NoumenalState source invertible) PhenomenalState :=
  Reverse.Transitive.faithfulQuotientAtReference source invertible
    transformationSeparation reference globallyTransitive

/-- The general reverse construction retaining the input transformation
family.  It removes the reference/transitivity premises but still requires
contextual phenomenal faithfulness. -/
noncomputable def generalReverseRetainingTransformations
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    LocalRealisticTheory System Transformation
      (Reverse.General.EnlargedNoumenalState source invertible)
      PhenomenalState :=
  Reverse.General.theory source invertible transformationSeparation
    phenomenallyFaithful

/-- The weakest-assumption corrected headline reverse result proved in this
development.

A no-signalling theory with existentially invertible dynamics and raw
transformation separation yields a full local-realistic theory over the
noumenal action-kernel quotient transformation family.  No global
transitivity or phenomenal faithfulness is required, but this is not a
same-signature model of the input theory. -/
noncomputable def generalReverseWithFaithfulQuotient
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation) :
    LocalRealisticTheory System
      (Reverse.General.core source invertible
        transformationSeparation).NoumenalFaithfulTransformation
      (Reverse.General.EnlargedNoumenalState source invertible)
      PhenomenalState :=
  Reverse.General.faithfulQuotient source invertible transformationSeparation

/-- Equality of the non-proof operational data of two no-signalling theories
over already-fixed transformation and phenomenal-state families.

The common type fixes the indexed monoid, phenomenal action, and state family.
The remaining data are the phenomenal projectors and separated transformation
product; all other structure fields are propositions. -/
def SameOperationalData
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (left right :
      NoSignallingTheory System Transformation PhenomenalState) : Prop :=
  left.projectors = right.projectors ∧
    left.transformationProducts = right.transformationProducts

/-- Forwarding the raw-transformation transitive reverse output preserves the
source operational data.  This is a one-sided preservation result, not model
uniqueness or a categorical equivalence. -/
theorem transitiveReverse_forward_sameOperationalData
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (reference : PhenomenalState globalSystem)
    (globallyTransitive : source.GloballyTransitive)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    SameOperationalData
      (forward (transitiveReverseRetainingTransformations source invertible
        transformationSeparation reference globallyTransitive
        phenomenallyFaithful))
      source :=
  ⟨rfl, rfl⟩

/-- Forwarding the raw-transformation general reverse output preserves the
source operational data.  Quotient-transformation outputs intentionally have
no theorem of this fixed-transformation type. -/
theorem generalReverse_forward_sameOperationalData
    {System : Type u} [BooleanAlgebra System]
    {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (source : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : source.TransformationSeparation)
    (phenomenallyFaithful : source.PhenomenallyFaithful) :
    SameOperationalData
      (forward (generalReverseRetainingTransformations source invertible
        transformationSeparation phenomenallyFaithful))
      source :=
  ⟨rfl, rfl⟩

end RR2021.Correspondence
