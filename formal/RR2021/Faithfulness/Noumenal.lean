import RR2021.Faithfulness.NoumenalProduct

/-!
# Appendix B: construction of a noumenally faithful theory

The construction changes only the transformation family and the operations
whose domains mention transformations.  Both state families, both projector
families, the partial noumenal state product, and the phenomenalization
function are reused verbatim.
-/

namespace RR2021.Theories.LocalRealisticCore

open RR2021.Dynamics RR2021.Faithfulness

universe u v w x

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

variable
  (theory :
    LocalRealisticCore System Transformation NoumenalState PhenomenalState)

/-- A theory-tagged presentation of the Appendix B action-kernel quotient.
The underlying quotient relation is theory-independent, but retaining the
source theory in this type constructor makes its descended phenomenal action
inferable by downstream consumers. -/
def NoumenalFaithfulTransformation
    (_source :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    (A : System) : Type v :=
  NoumenalQuotientTransformation
    (Transformation := Transformation) (NoumenalState := NoumenalState) A

namespace NoumenalFaithfulTransformation

/-- The quotient monoid, exposed as an inferable instance on the theory-tagged
family. -/
@[reducible, instance]
def indexedMonoid :
    IndexedMonoid System (NoumenalFaithfulTransformation theory) :=
  NoumenalQuotientTransformation.quotientIndexedMonoid
    (Transformation := Transformation) (NoumenalState := NoumenalState)

/-- The faithful descended noumenal action on the theory-tagged family. -/
@[reducible, instance]
def indexedNoumenalMulAction :
    IndexedMulAction System (NoumenalFaithfulTransformation theory) NoumenalState :=
  NoumenalQuotientTransformation.quotientIndexedNoumenalMulAction
    (Transformation := Transformation) (NoumenalState := NoumenalState)

/-- The descended phenomenal action.  Its source `theory` is now recoverable
from the transformation-family type, avoiding a non-inferable global
instance. -/
@[reducible, instance]
def indexedPhenomenalMulAction :
    IndexedMulAction System (NoumenalFaithfulTransformation theory) PhenomenalState :=
  NoumenalQuotientTransformation.quotientIndexedPhenomenalMulAction theory

end NoumenalFaithfulTransformation

/-- Appendix B's strongest honest result: every corrected local-realistic core
(all Section 3 data except Axiom 3.7) yields a full local-realistic theory by
quotienting transformations by the kernel of their noumenal action.

No invertibility, transformation separation, phenomenal faithfulness, global
transitivity, representative choice, or total product on incompatible states
is used. -/
def toNoumenallyFaithfulQuotient :
    LocalRealisticTheory System
      (NoumenalFaithfulTransformation theory)
      NoumenalState PhenomenalState := by
  exact {
    noumenalNonempty := theory.noumenalNonempty
    phenomenalization := theory.phenomenalization
    phenomenalizationEquivariant :=
      NoumenalQuotientTransformation.quotientPhenomenalizationEquivariant theory
    phenomenalizationSurjective := theory.phenomenalizationSurjective
    noumenalProjectors := theory.noumenalProjectors
    noumenalProjectorsSurjective := theory.noumenalProjectorsSurjective
    phenomenalProjectors := theory.phenomenalProjectors
    phenomenalizationProjectionCompatible :=
      theory.phenomenalizationProjectionCompatible
    noumenalProduct := theory.noumenalProduct
    transformationProducts :=
      NoumenalQuotientTransformation.quotientTransformationProducts theory
    locality := NoumenalQuotientTransformation.quotientLocality theory
    noumenalActionFaithful :=
      NoumenalQuotientTransformation.quotientNoumenalActionEffective
        (Transformation := Transformation) (NoumenalState := NoumenalState)
  }

end RR2021.Theories.LocalRealisticCore
