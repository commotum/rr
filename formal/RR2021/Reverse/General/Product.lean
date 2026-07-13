import RR2021.Reverse.General.State
import RR2021.Reverse.Transitive.Product

/-!
# General reverse construction: enlarged-state product

Section 5.1 makes the extra compatibility condition on enlarged states
explicit: their retained global phenomenal labels must agree, and their
fundamental quotient components must already be compatible.  The product
then reuses the transitive construction's honest partial product and retains
the common label.  No new representative or common-extension choice is made
in this layer.
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

/-- The exact compatibility criterion for Section 5.1's enlarged states:
their global phenomenal labels agree and their fundamental classes admit an
old common extension. -/
theorem compatible_iff_label_eq_and_fundamental_compatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (left : EnlargedNoumenalState theory invertible A)
    (right : EnlargedNoumenalState theory invertible B) :
    Compatible (projectors theory invertible) left right ↔
      label theory invertible left = label theory invertible right ∧
        Compatible (Reverse.Transitive.NoumenalState.projectors theory invertible)
          (fundamental theory invertible left)
          (fundamental theory invertible right) := by
  constructor
  · rintro ⟨separated, whole, wholeLeft, wholeRight⟩
    refine ⟨?_, separated, whole.1, ?_, ?_⟩
    · exact (congrArg Prod.snd wholeLeft).symm.trans
        (congrArg Prod.snd wholeRight)
    · exact congrArg Prod.fst wholeLeft
    · exact congrArg Prod.fst wholeRight
  · rintro ⟨labelEq, separated, whole, wholeLeft, wholeRight⟩
    refine ⟨separated,
      mk theory invertible (Composite A B) whole
        (label theory invertible left), ?_, ?_⟩
    · exact Prod.ext wholeLeft rfl
    · exact Prod.ext wholeRight labelEq

/-- Forget an enlarged compatibility witness to the compatibility of its two
fundamental components.  This is data elimination only; no witness is
selected. -/
def fundamentalCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (left : EnlargedNoumenalState theory invertible A)
    (right : EnlargedNoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    Compatible (Reverse.Transitive.NoumenalState.projectors theory invertible)
      (fundamental theory invertible left)
      (fundamental theory invertible right) :=
  ((compatible_iff_label_eq_and_fundamental_compatible
    theory invertible left right).1 compatible).2

/-- An old compatible pair with a shared label gives an enlarged compatible
pair.  This named constructor is useful for representative computations and
does not extract any quotient representative. -/
def compatibleOfLabelEqAndFundamentalCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (left : EnlargedNoumenalState theory invertible A)
    (right : EnlargedNoumenalState theory invertible B)
    (labelEq : label theory invertible left = label theory invertible right)
    (compatible :
      Compatible (Reverse.Transitive.NoumenalState.projectors theory invertible)
        (fundamental theory invertible left)
        (fundamental theory invertible right)) :
    Compatible (projectors theory invertible) left right :=
  (compatible_iff_label_eq_and_fundamental_compatible
    theory invertible left right).2 ⟨labelEq, compatible⟩

/-- Canonical enlarged compatibility for two states with the same raw global
representative and the same global phenomenal label. -/
def representedCompatibility
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (separated : Separated A B)
    (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    Compatible (projectors theory invertible)
      (ofRepresentative theory invertible A representative globalLabel)
      (ofRepresentative theory invertible B representative globalLabel) :=
  compatibleOfLabelEqAndFundamentalCompatible theory invertible _ _ rfl
    (Reverse.Transitive.NoumenalState.representedCompatibility
      theory invertible separated representative)

/-- Section 5.1's enlarged-state product.  The only noncomputability is
inherited from the already-constructed transitive quotient-state product;
this wrapper makes no additional choice. -/
noncomputable def stateProduct
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation) :
    StateProduct (projectors theory invertible) where
  product := fun left right separated compatible =>
    mk theory invertible _
      ((Reverse.Transitive.NoumenalState.stateProduct
          theory invertible transformationSeparation).product
        (fundamental theory invertible left)
        (fundamental theory invertible right) separated
        (fundamentalCompatible theory invertible left right compatible))
      (label theory invertible left)
  reconstruct := by
    intro A B separated whole
    apply Prod.ext
    · exact
        (Reverse.Transitive.NoumenalState.stateProduct
          theory invertible transformationSeparation).product_eq_common_extension
          ((projectors theory invertible).projectLeft whole).1
          ((projectors theory invertible).projectRight whole).1
          separated
          (fundamentalCompatible theory invertible
            ((projectors theory invertible).projectLeft whole)
            ((projectors theory invertible).projectRight whole)
            (canonicalCompatibility (projectors theory invertible)
              separated whole))
          whole.1 rfl rfl
    · rfl

/-- Direct computation of the enlarged product from an old compatible pair
with a common label. -/
theorem stateProduct_mk_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    (left : Reverse.Transitive.NoumenalState theory invertible A)
    (right : Reverse.Transitive.NoumenalState theory invertible B)
    (globalLabel : PhenomenalState globalSystem)
    (compatible :
      Compatible (Reverse.Transitive.NoumenalState.projectors theory invertible)
        left right) :
    (stateProduct theory invertible transformationSeparation).product
        (mk theory invertible A left globalLabel)
        (mk theory invertible B right globalLabel) separated
        (compatibleOfLabelEqAndFundamentalCompatible theory invertible
          (mk theory invertible A left globalLabel)
          (mk theory invertible B right globalLabel) rfl compatible) =
      mk theory invertible (Composite A B)
        ((Reverse.Transitive.NoumenalState.stateProduct
          theory invertible transformationSeparation).product
            left right separated compatible)
        globalLabel := by
  rfl

/-- Theorem 5.15's displayed representative computation. -/
theorem stateProduct_ofRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    (representative : Transformation globalSystem)
    (globalLabel : PhenomenalState globalSystem) :
    (stateProduct theory invertible transformationSeparation).product
        (ofRepresentative theory invertible A representative globalLabel)
        (ofRepresentative theory invertible B representative globalLabel)
        separated
        (representedCompatibility theory invertible separated
          representative globalLabel) =
      ofRepresentative theory invertible (Composite A B)
        representative globalLabel := by
  exact (stateProduct theory invertible
    transformationSeparation).product_eq_common_extension
      (ofRepresentative theory invertible A representative globalLabel)
      (ofRepresentative theory invertible B representative globalLabel)
      separated
      (representedCompatibility theory invertible separated
        representative globalLabel)
      (ofRepresentative theory invertible (Composite A B)
        representative globalLabel) rfl rfl

end EnlargedNoumenalState

end RR2021.Reverse.General
