import RR2021.Forward.Core
import RR2021.Theories.Basic

/-!
# Forward construction: local realism implies no-signalling

The constructor forgets the noumenal carrier while retaining the original
phenomenal states, transformations, projectors, and separated transformation
product.  Its five Axiom 4.6 fields are the state-level forward theorem and
the four transformation-product laws already derived from locality and
noumenal action effectivity.
-/

namespace RR2021.Theories

open RR2021.Dynamics

universe u v w x

namespace LocalRealisticTheory

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The forward implication: every local-realistic theory induces a
no-signalling theory on the same phenomenal states and transformations. -/
def toNoSignallingTheory
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    NoSignallingTheory System Transformation PhenomenalState where
  toPhenomenalTheory := theory.toLocalRealisticCore.toPhenomenalTheory
  transformationProducts := theory.transformationProducts
  noSignalling := theory.toLocalRealisticCore.noSignallingAxiom
  productMultiplicative := theory.productMultiplicative
  productUnital := theory.productUnital
  productSymmetric := theory.productSymmetric
  productAssociative := theory.productAssociative

end LocalRealisticTheory

end RR2021.Theories
