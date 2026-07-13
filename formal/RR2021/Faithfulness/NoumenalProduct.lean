import RR2021.Faithfulness.NoumenalPhenomenal

/-!
# Transformation-product and locality descent through the noumenal kernel

Appendix B's product congruence is proved here for arbitrary composite states.
The proof uses the two locality marginals and uniqueness from the honest
compatibility-indexed state product; it does not assume that arbitrary factor
states have a product.
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

/-- Theorem B.3 with all hidden obligations exposed: separated transformation
products preserve the noumenal action kernel. -/
theorem noumenallyEquivalent_transformationProduct
    (theory :
      LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    {A B : System} (hsep : Separated A B)
    {left left' : Transformation A} {right right' : Transformation B}
    (leftEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) left left')
    (rightEquivalent :
      NoumenallyEquivalent (NoumenalState := NoumenalState) right right') :
    NoumenallyEquivalent (NoumenalState := NoumenalState)
      (theory.transformationProducts.product left right hsep)
      (theory.transformationProducts.product left' right' hsep) := by
  intro whole
  apply theory.noumenalProduct.eq_of_projections hsep
  · calc
      theory.noumenalProjectors.projectLeft
          (theory.transformationProducts.product left right hsep • whole) =
        left • theory.noumenalProjectors.projectLeft whole :=
          theory.locality.project_left_product_action left right hsep whole
      _ = left' • theory.noumenalProjectors.projectLeft whole :=
        leftEquivalent _
      _ = theory.noumenalProjectors.projectLeft
          (theory.transformationProducts.product left' right' hsep • whole) :=
        (theory.locality.project_left_product_action left' right' hsep whole).symm
  · calc
      theory.noumenalProjectors.projectRight
          (theory.transformationProducts.product left right hsep • whole) =
        right • theory.noumenalProjectors.projectRight whole :=
          theory.locality.project_right_product_action left right hsep whole
      _ = right' • theory.noumenalProjectors.projectRight whole :=
        rightEquivalent _
      _ = theory.noumenalProjectors.projectRight
          (theory.transformationProducts.product left' right' hsep • whole) :=
        (theory.locality.project_right_product_action left' right' hsep whole).symm

namespace NoumenalQuotientTransformation

variable
  (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState)

local instance quotientMonoidInstance :
    IndexedMonoid System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState)) :=
  quotientIndexedMonoid
    (Transformation := Transformation) (NoumenalState := NoumenalState)

local instance quotientNoumenalActionInstance :
    IndexedMulAction System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState))
      NoumenalState :=
  quotientIndexedNoumenalMulAction
    (Transformation := Transformation) (NoumenalState := NoumenalState)

/-- The quotient product of separated transformation classes.  Its `map₂`
congruence argument is the named Theorem-B.3 repair above. -/
def quotientTransformationProducts :
    TransformationProduct System
      (NoumenalQuotientTransformation
        (Transformation := Transformation) (NoumenalState := NoumenalState)) where
  product := fun {_ _} left right hsep =>
    Quotient.map₂
      (fun leftRepresentative rightRepresentative =>
        theory.transformationProducts.product
          leftRepresentative rightRepresentative hsep)
      (fun _ _ leftEquivalent _ _ rightEquivalent =>
        noumenallyEquivalent_transformationProduct theory hsep
          leftEquivalent rightEquivalent)
      left right

@[simp]
theorem quotientTransformationProducts_mk {A B : System}
    (left : Transformation A) (right : Transformation B)
    (hsep : Separated A B) :
    (quotientTransformationProducts theory).product
        (mk (NoumenalState := NoumenalState) left)
        (mk (NoumenalState := NoumenalState) right) hsep =
      mk (NoumenalState := NoumenalState)
        (theory.transformationProducts.product left right hsep) := by
  rfl

/-- Axiom 3.13 descends to the quotient transformations. -/
def quotientLocality :
    Locality theory.noumenalProjectors theory.noumenalProduct
      (quotientTransformationProducts theory) where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    revert compatible
    refine Con.induction_on₂ leftTransformation rightTransformation ?_
    intro leftRepresentative rightRepresentative compatible
    exact theory.locality.mapCompatible
      leftRepresentative rightRepresentative left right compatible
  act_product := by
    intro A B leftTransformation rightTransformation left right hsep compatible
    revert compatible
    refine Con.induction_on₂ leftTransformation rightTransformation ?_
    intro leftRepresentative rightRepresentative compatible
    exact theory.locality.act_product
      leftRepresentative rightRepresentative left right hsep compatible

end NoumenalQuotientTransformation

end RR2021.Faithfulness
