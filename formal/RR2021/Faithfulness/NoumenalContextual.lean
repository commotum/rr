import RR2021.Faithfulness.NoumenalProduct
import RR2021.Forward.Construction
import RR2021.Theories.Postulates

/-!
# Noumenal equivalence refines contextual phenomenal equivalence

The contextual relation is stated first against raw transformation-product
data so Theorems 4.2--4.3 remain meaningful for `LocalRealisticCore`, before
noumenal action effectivity is available to assemble the full forward
`NoSignallingTheory`.
-/

namespace RR2021.Faithfulness

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w x

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The contextual phenomenal relation of corrected Definition 4.1, factored
away from the `NoSignallingTheory` bundle because its formula uses only the
raw transformation product and phenomenal action. -/
def ContextuallyPhenomenallyEquivalent
    (products : TransformationProduct System Transformation)
    {A : System} (left right : Transformation A) : Prop :=
  ∀ {B : System} (hsep : Separated A B)
    (state : PhenomenalState (Composite A B)),
    products.product left (1 : Transformation B) hsep • state =
      products.product right (1 : Transformation B) hsep • state

/-- Contextual phenomenal faithfulness for raw product data. -/
def ContextuallyPhenomenallyFaithful
    (products : TransformationProduct System Transformation) : Prop :=
  ∀ (A : System) (left right : Transformation A),
    ContextuallyPhenomenallyEquivalent
      (PhenomenalState := PhenomenalState) products left right → left = right

/-- The standalone contextual formula is exactly the existing
no-signalling-theory predicate when supplied that theory's product. -/
theorem contextuallyPhenomenallyEquivalent_iff
    (noSignallingTheory :
      NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (left right : Transformation A) :
    ContextuallyPhenomenallyEquivalent
        (PhenomenalState := PhenomenalState)
        noSignallingTheory.transformationProducts left right ↔
      noSignallingTheory.PhenomenallyEquivalent left right :=
  Iff.rfl

/-- Theorem 4.2 / Appendix B's refinement claim: equality in the noumenal
action kernel implies contextual phenomenal equivalence, not merely equality
of the local phenomenal actions. -/
theorem noumenallyEquivalent_contextuallyPhenomenallyEquivalent
    (theory :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    {A : System} {left right : Transformation A}
    (equivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) left right) :
    ContextuallyPhenomenallyEquivalent
      (PhenomenalState := PhenomenalState)
      theory.transformationProducts left right := by
  intro B hsep state
  have productEquivalent :=
    noumenallyEquivalent_transformationProduct theory hsep equivalent
      (NoumenallyEquivalent.refl (NoumenalState := NoumenalState)
        (1 : Transformation B))
  exact noumenallyEquivalent_phenomenal_smul theory productEquivalent state

/-- Source-facing full-theory form of Theorem 4.2. -/
theorem noumenallyEquivalent_phenomenallyEquivalent
    (theory :
      LocalRealisticTheory System Transformation NoumenalState PhenomenalState)
    {A : System} {left right : Transformation A}
    (equivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) left right) :
    theory.toNoSignallingTheory.PhenomenallyEquivalent left right := by
  exact (contextuallyPhenomenallyEquivalent_iff
    theory.toNoSignallingTheory left right).mp
      (noumenallyEquivalent_contextuallyPhenomenallyEquivalent
        theory.toLocalRealisticCore equivalent)

/-- Theorem 4.3 at its noncircular strength: contextual phenomenal
faithfulness of a pre-faithful core's raw product forces noumenal action
effectivity. -/
theorem noumenallyFaithful_of_contextualPhenomenalFaithfulness
    (theory :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    (phenomenallyFaithful :
      ContextuallyPhenomenallyFaithful
        (PhenomenalState := PhenomenalState) theory.transformationProducts) :
    NoumenallyFaithful Transformation NoumenalState := by
  intro A left right equivalent
  exact phenomenallyFaithful A left right
    (noumenallyEquivalent_contextuallyPhenomenallyEquivalent theory equivalent)

end RR2021.Faithfulness
