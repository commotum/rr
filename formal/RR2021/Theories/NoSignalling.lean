import RR2021.Theories.Core
import RR2021.Dynamics.Projection
import RR2021.Dynamics.TransformationProduct

/-!
# Phenomenal and no-signalling theories

`PhenomenalTheory` captures Axioms 4.1--4.5.  `NoSignallingTheory`
adds exactly the five parts of Axiom 4.6: the marginal law and the four
algebra/coherence laws for separated transformation products. Reverse-only
postulates are isolated in `Theories.Postulates`.
-/

namespace RR2021.Theories

open RR2021.Systems RR2021.Dynamics

universe u v w

/-- Axioms 4.1--4.5: nonempty phenomenal state spaces with indexed monoid
actions and surjective nested projectors.  The Boolean system algebra and the
standard monoid/action data are visible parameters of the structure. -/
structure PhenomenalTheory (System : Type u) [BooleanAlgebra System]
    (Transformation : System → Type v) (PhenomenalState : System → Type w)
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState] where
  stateNonempty : IndexedNonempty PhenomenalState
  projectors : ProjectorFamily System PhenomenalState
  projectorsSurjective : projectors.Surjective

/-- The state-level no-signalling proposition from Axiom 4.6(1). -/
def NoSignallingAxiom {System : Type u} [SemilatticeSup System]
    [OrderBot System] {Transformation : System → Type v}
    {PhenomenalState : System → Type w}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    (projectors : ProjectorFamily System PhenomenalState)
    (transformationProducts : TransformationProduct System Transformation) : Prop :=
  ∀ {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (hsep : Separated A B)
    (state : PhenomenalState (Composite A B)),
    projectors.projectLeft
        (transformationProducts.product leftTransformation rightTransformation hsep • state) =
      leftTransformation • projectors.projectLeft state

/-- Axiom 4.6, separated into the raw product and its five explicit laws. -/
structure NoSignallingTheory (System : Type u) [BooleanAlgebra System]
    (Transformation : System → Type v) (PhenomenalState : System → Type w)
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation PhenomenalState]
    extends PhenomenalTheory System Transformation PhenomenalState where
  transformationProducts : TransformationProduct System Transformation
  noSignalling : NoSignallingAxiom projectors transformationProducts
  productMultiplicative : transformationProducts.Multiplicative
  productUnital : transformationProducts.Unital
  productSymmetric : transformationProducts.Symmetric
  productAssociative : transformationProducts.Associative

end RR2021.Theories
