import RR2021.Theories.NoSignalling
import RR2021.Theories.LocalRealistic
import RR2021.Dynamics.TransformationProductDerived

/-!
# Operational theories: derived validation laws

This leaf recovers source-facing consequences from the minimal structures.
It does not add fields to either theory bundle.
-/

namespace RR2021.Theories

open RR2021.Systems RR2021.Dynamics

universe u v w x

namespace NoSignallingTheory

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The right marginal form of Axiom 4.6(1), derived from its stored left
form and the explicit symmetry transport. -/
theorem noSignallingRight
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (hsep : Separated A B)
    (state : PhenomenalState (Composite A B)) :
    theory.projectors.projectRight
        (theory.transformationProducts.product leftTransformation
          rightTransformation hsep • state) =
      rightTransformation • theory.projectors.projectRight state := by
  let productAB := theory.transformationProducts.product
    leftTransformation rightTransformation hsep
  calc
    theory.projectors.projectRight (productAB • state) =
        theory.projectors.projectLeft
          (reindex PhenomenalState (sup_comm A B) (productAB • state)) :=
      (theory.projectors.projectLeft_reindexSupComm (productAB • state)).symm
    _ = theory.projectors.projectLeft
        (reindex Transformation (sup_comm A B) productAB •
          reindex PhenomenalState (sup_comm A B) state) := by
      rw [reindex_smul]
    _ = theory.projectors.projectLeft
        (theory.transformationProducts.product rightTransformation
            leftTransformation hsep.symm •
          reindex PhenomenalState (sup_comm A B) state) := by
      rw [theory.productSymmetric hsep leftTransformation rightTransformation]
    _ = rightTransformation • theory.projectors.projectLeft
        (reindex PhenomenalState (sup_comm A B) state) :=
      theory.noSignalling rightTransformation leftTransformation hsep.symm _
    _ = rightTransformation • theory.projectors.projectRight state := by
      rw [theory.projectors.projectLeft_reindexSupComm state]

end NoSignallingTheory

namespace LocalRealisticCore

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Theory-level validation of Theorem 3.1. -/
theorem noumenalProjectSelf
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    {A : System} (state : NoumenalState A) :
    theory.noumenalProjectors.project (le_refl A) state = state :=
  theory.noumenalProjectors.project_self
    theory.noumenalProjectorsSurjective state

/-- Theory-level validation of Theorem 3.2, using the derived phenomenal
projector surjectivity rather than a redundant structure field. -/
theorem phenomenalProjectSelf
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState)
    {A : System} (state : PhenomenalState A) :
    theory.phenomenalProjectors.project (le_refl A) state = state :=
  theory.phenomenalProjectors.project_self
    theory.phenomenalProjectorsSurjective state

end LocalRealisticCore

namespace LocalRealisticTheory

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Axiom 3.13 determines the separated transformation product uniquely once
the noumenal action is effective. -/
theorem transformationProduct_unique
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState)
    (otherProducts : TransformationProduct System Transformation)
    (otherLocality :
      Locality theory.noumenalProjectors theory.noumenalProduct otherProducts)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (hsep : Separated A B) :
    theory.transformationProducts.product leftTransformation rightTransformation hsep =
      otherProducts.product leftTransformation rightTransformation hsep := by
  apply theory.noumenalActionFaithful (Composite A B)
  intro whole
  apply theory.noumenalProduct.eq_of_projections hsep
  · rw [theory.locality.project_left_product_action,
      otherLocality.project_left_product_action]
  · rw [theory.locality.project_right_product_action,
      otherLocality.project_right_product_action]

/-- Theory-level Theorem 3.8, derived rather than stored. -/
theorem productMultiplicative
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    theory.transformationProducts.Multiplicative :=
  theory.transformationProducts.multiplicative_of_locality
    theory.locality theory.noumenalActionFaithful

/-- Theory-level Theorem 3.9, derived rather than stored. -/
theorem productUnital
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    theory.transformationProducts.Unital :=
  theory.transformationProducts.unital_of_locality
    theory.locality theory.noumenalActionFaithful

/-- Theory-level Theorem 3.10, with `sup_comm` transport retained. -/
theorem productSymmetric
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    theory.transformationProducts.Symmetric :=
  theory.transformationProducts.symmetric_of_locality
    theory.locality theory.noumenalActionFaithful

/-- Theory-level Theorem 3.11, with pairwise separation and `sup_assoc`
transport retained. -/
theorem productAssociative
    (theory : LocalRealisticTheory System Transformation NoumenalState PhenomenalState) :
    theory.transformationProducts.Associative :=
  theory.transformationProducts.associative_of_locality
    theory.locality theory.noumenalActionFaithful

end LocalRealisticTheory

end RR2021.Theories
