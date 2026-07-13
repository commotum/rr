import RR2021.Dynamics.StateProduct
import RR2021.Dynamics.TransformationProduct

/-!
# Indexed dynamics: locality of transformation products

This file gives the fully typed form of Axiom 3.13.  The raw transformation
product is connected to noumenal state products by an explicit compatibility-
preservation proof and the componentwise action equation.  No faithfulness,
group structure, or unconditional algebraic law for transformation products is
assumed.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v w

variable {System : Type u} [SemilatticeSup System] [OrderBot System]
variable {Transformation : System → Type v}
variable {State : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation State]
variable {projectors : ProjectorFamily System State}
variable {stateProducts : StateProduct projectors}
variable {transformationProducts : TransformationProduct System Transformation}

/--
Axiom 3.13 with partiality exposed: transformed factors are first proved
compatible, then the raw product transformation acts componentwise on their
defined state product.
-/
structure Locality (projectors : ProjectorFamily System State)
    (stateProducts : StateProduct projectors)
    (transformationProducts : TransformationProduct System Transformation) where
  mapCompatible : ∀ {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (left : State A) (right : State B),
      Compatible projectors left right →
      Compatible projectors (leftTransformation • left) (rightTransformation • right)
  act_product : ∀ {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (left : State A) (right : State B)
    (hsep : Separated A B) (compatible : Compatible projectors left right),
    transformationProducts.product leftTransformation rightTransformation hsep •
        stateProducts.product left right hsep compatible =
      stateProducts.product (leftTransformation • left) (rightTransformation • right)
        hsep (mapCompatible leftTransformation rightTransformation left right compatible)

namespace Locality

/-- The left projection of an acted product is the acted left factor. -/
theorem project_left_act_product
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (left : State A) (right : State B)
    (hsep : Separated A B) (compatible : Compatible projectors left right) :
    projectors.projectLeft
        (transformationProducts.product leftTransformation rightTransformation hsep •
          stateProducts.product left right hsep compatible) =
      leftTransformation • left := by
  rw [locality.act_product]
  exact stateProducts.project_left _ _ hsep _

/-- The right projection of an acted product is the acted right factor. -/
theorem project_right_act_product
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (left : State A) (right : State B)
    (hsep : Separated A B) (compatible : Compatible projectors left right) :
    projectors.projectRight
        (transformationProducts.product leftTransformation rightTransformation hsep •
          stateProducts.product left right hsep compatible) =
      rightTransformation • right := by
  rw [locality.act_product]
  exact stateProducts.project_right _ _ hsep _

/-- Componentwise action on the left projection of an arbitrary composite state. -/
theorem project_left_product_action
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (hsep : Separated A B)
    (whole : State (Composite A B)) :
    projectors.projectLeft
        (transformationProducts.product leftTransformation rightTransformation hsep • whole) =
      leftTransformation • projectors.projectLeft whole := by
  calc
    _ = projectors.projectLeft
        (transformationProducts.product leftTransformation rightTransformation hsep •
          stateProducts.product (projectors.projectLeft whole)
            (projectors.projectRight whole) hsep
            (canonicalCompatibility projectors hsep whole)) := by
      rw [stateProducts.reconstruct hsep whole]
    _ = leftTransformation • projectors.projectLeft whole :=
      locality.project_left_act_product leftTransformation rightTransformation
        (projectors.projectLeft whole) (projectors.projectRight whole) hsep
        (canonicalCompatibility projectors hsep whole)

/-- Componentwise action on the right projection of an arbitrary composite state. -/
theorem project_right_product_action
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) (hsep : Separated A B)
    (whole : State (Composite A B)) :
    projectors.projectRight
        (transformationProducts.product leftTransformation rightTransformation hsep • whole) =
      rightTransformation • projectors.projectRight whole := by
  calc
    _ = projectors.projectRight
        (transformationProducts.product leftTransformation rightTransformation hsep •
          stateProducts.product (projectors.projectLeft whole)
            (projectors.projectRight whole) hsep
            (canonicalCompatibility projectors hsep whole)) := by
      rw [stateProducts.reconstruct hsep whole]
    _ = rightTransformation • projectors.projectRight whole :=
      locality.project_right_act_product leftTransformation rightTransformation
        (projectors.projectLeft whole) (projectors.projectRight whole) hsep
        (canonicalCompatibility projectors hsep whole)

/-- A transformation on the right system leaves the left state unchanged. -/
theorem remote_left_unchanged
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (rightTransformation : Transformation B)
    (hsep : Separated A B) (whole : State (Composite A B)) :
    projectors.projectLeft
        (transformationProducts.product (1 : Transformation A) rightTransformation hsep • whole) =
      projectors.projectLeft whole := by
  simpa only [one_act] using
    locality.project_left_product_action (1 : Transformation A) rightTransformation hsep whole

/-- A transformation on the left system leaves the right state unchanged. -/
theorem remote_right_unchanged
    (locality : Locality projectors stateProducts transformationProducts)
    {A B : System} (leftTransformation : Transformation A)
    (hsep : Separated A B) (whole : State (Composite A B)) :
    projectors.projectRight
        (transformationProducts.product leftTransformation (1 : Transformation B) hsep • whole) =
      projectors.projectRight whole := by
  simpa only [one_act] using
    locality.project_right_product_action leftTransformation (1 : Transformation B) hsep whole

end Locality

end RR2021.Dynamics
