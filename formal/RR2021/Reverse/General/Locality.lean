import RR2021.Reverse.General.Product
import RR2021.Reverse.Transitive.Locality

/-!
# General reverse construction: locality on enlarged states

The enlarged action and projectors leave the global phenomenal label fixed.
Consequently the transitive construction's compatibility preservation and
componentwise action theorem lift directly through the pair-state wrapper.
-/

namespace RR2021.Reverse.General

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace EnlargedNoumenalState

/-- Local transformations preserve enlarged compatibility.  On labels this
is the original equality; on fundamental classes this is transitive
locality's compatibility-preservation theorem. -/
def mapCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B)
    (left : EnlargedNoumenalState theory invertible A)
    (right : EnlargedNoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    Compatible (projectors theory invertible)
      (leftTransformation • left) (rightTransformation • right) := by
  apply (compatible_iff_label_eq_and_fundamental_compatible
    theory invertible _ _).2
  have oldCompatibility :=
    fundamentalCompatible theory invertible left right compatible
  refine ⟨((compatible_iff_label_eq_and_fundamental_compatible
    theory invertible left right).1 compatible).1, ?_⟩
  exact (Reverse.Transitive.NoumenalState.locality
    theory invertible transformationSeparation).mapCompatible
      leftTransformation rightTransformation
      (fundamental theory invertible left)
      (fundamental theory invertible right) oldCompatibility

/-- The enlarged product is local because both its action and product are
componentwise on the fundamental quotient and inert on the common label. -/
noncomputable def locality
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation) :
    @Locality System _ _ Transformation
      (EnlargedNoumenalState theory invertible)
      _ (indexedMulAction theory invertible)
      (projectors theory invertible)
      (stateProduct theory invertible transformationSeparation)
      theory.transformationProducts where
  mapCompatible := mapCompatible theory invertible transformationSeparation
  act_product := by
    intro A B leftTransformation rightTransformation left right separated compatible
    apply Prod.ext
    · exact (Reverse.Transitive.NoumenalState.locality
        theory invertible transformationSeparation).act_product
          leftTransformation rightTransformation
          (fundamental theory invertible left)
          (fundamental theory invertible right) separated
          (fundamentalCompatible theory invertible left right compatible)
    · rfl

end EnlargedNoumenalState

end RR2021.Reverse.General
