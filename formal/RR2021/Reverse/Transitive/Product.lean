import RR2021.Reverse.Transitive.Projection
import RR2021.Reverse.Transitive.Action
import RR2021.Reverse.Transitive.Intersection
import RR2021.Dynamics.StateProduct

/-!
# Transitive reverse construction: the honest partial state product

Theorem 5.8 first proves that a quotient state on a separated composite is
determined by its two projections.  Only after that uniqueness result do we
use unique choice to extract the common extension stored propositionally by
`Compatible`.  Thus choice does not supply existence or conceal an
incompatible branch.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace NoumenalState

/-- Theorem 5.8 at the quotient-state level: a state of a separated
composite is determined by its two constructed projections. -/
theorem eq_of_projections
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    {first second : NoumenalState theory invertible (Composite A B)}
    (left_eq :
      project theory invertible
          (show Subsystem A (Composite A B) from le_sup_left) first =
        project theory invertible
          (show Subsystem A (Composite A B) from le_sup_left) second)
    (right_eq :
      project theory invertible
          (show Subsystem B (Composite A B) from le_sup_right) first =
        project theory invertible
          (show Subsystem B (Composite A B) from le_sup_right) second) :
    first = second := by
  revert left_eq right_eq
  refine Quotient.inductionOn first ?_
  intro firstRepresentative
  refine Quotient.inductionOn second ?_
  intro secondRepresentative left_eq right_eq
  change mk theory invertible A firstRepresentative =
      mk theory invertible A secondRepresentative at left_eq
  change mk theory invertible B firstRepresentative =
      mk theory invertible B secondRepresentative at right_eq
  apply (mk_eq_mk_iff theory invertible (Composite A B)
    firstRepresentative secondRepresentative).2
  exact FundamentallyEquivalent.intersection theory invertible
    transformationSeparation separated
    ((mk_eq_mk_iff theory invertible A
      firstRepresentative secondRepresentative).1 left_eq)
    ((mk_eq_mk_iff theory invertible B
      firstRepresentative secondRepresentative).1 right_eq)

/-- Any two common extensions of a compatible separated pair are equal.
This is the uniqueness premise required before extracting data from the
propositional compatibility witness. -/
theorem commonExtension_unique
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    {left : NoumenalState theory invertible A}
    {right : NoumenalState theory invertible B}
    {first second : NoumenalState theory invertible (Composite A B)}
    (first_left :
      (projectors theory invertible).projectLeft first = left)
    (first_right :
      (projectors theory invertible).projectRight first = right)
    (second_left :
      (projectors theory invertible).projectLeft second = left)
    (second_right :
      (projectors theory invertible).projectRight second = right) :
    first = second := by
  apply eq_of_projections theory invertible transformationSeparation separated
  · exact first_left.trans second_left.symm
  · exact first_right.trans second_right.symm

/-- Compatibility gives a unique common extension, not merely a selected
one.  Existence is exactly the witness already present in `Compatible`;
uniqueness is Theorem 5.8. -/
theorem compatible_uniqueCommonExtension
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    ∃! whole : NoumenalState theory invertible (Composite A B),
      (projectors theory invertible).projectLeft whole = left ∧
        (projectors theory invertible).projectRight whole = right := by
  obtain ⟨separated, whole, whole_left, whole_right⟩ := compatible
  refine ⟨whole, ⟨whole_left, whole_right⟩, ?_⟩
  intro other other_projections
  exact commonExtension_unique theory invertible transformationSeparation
    separated other_projections.1 other_projections.2 whole_left whole_right

/-- The source's unnumbered compatibility characterization: for separated
systems, two fundamental classes are compatible exactly when they have a
common raw global representative. -/
theorem compatible_iff_exists_globalRepresentative
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (separated : Separated A B)
    (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B) :
    Compatible (projectors theory invertible) left right ↔
      ∃ representative : Transformation globalSystem,
        mk theory invertible A representative = left ∧
          mk theory invertible B representative = right := by
  constructor
  · rintro ⟨_, whole, whole_left, whole_right⟩
    revert whole_left whole_right
    refine Quotient.inductionOn whole ?_
    intro representative whole_left whole_right
    exact ⟨representative, whole_left, whole_right⟩
  · rintro ⟨representative, left_eq, right_eq⟩
    exact ⟨separated, mk theory invertible (Composite A B) representative,
      left_eq, right_eq⟩

/-- The canonical compatibility witness for two classes represented by the
same global transformation. -/
def representedCompatibility
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (separated : Separated A B)
    (representative : Transformation globalSystem) :
    Compatible (projectors theory invertible)
      (mk theory invertible A representative)
      (mk theory invertible B representative) :=
  ⟨separated, mk theory invertible (Composite A B) representative, rfl, rfl⟩

/-- The sole data-extraction boundary in the constructed state product.
`Classical.choose` is applied to an already proved unique-existence theorem. -/
noncomputable def chosenCommonExtension
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    NoumenalState theory invertible (Composite A B) :=
  Classical.choose
    (compatible_uniqueCommonExtension theory invertible
      transformationSeparation left right compatible)

/-- The selected extension has the prescribed left projection. -/
theorem chosenCommonExtension_projectLeft
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    (projectors theory invertible).projectLeft
        (chosenCommonExtension theory invertible transformationSeparation
          left right compatible) = left :=
  (Classical.choose_spec
    (compatible_uniqueCommonExtension theory invertible
      transformationSeparation left right compatible)).1.1

/-- The selected extension has the prescribed right projection. -/
theorem chosenCommonExtension_projectRight
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    (projectors theory invertible).projectRight
        (chosenCommonExtension theory invertible transformationSeparation
          left right compatible) = right :=
  (Classical.choose_spec
    (compatible_uniqueCommonExtension theory invertible
      transformationSeparation left right compatible)).1.2

/-- The selected extension is the unique common extension. -/
theorem chosenCommonExtension_eq
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right)
    (whole : NoumenalState theory invertible (Composite A B))
    (whole_left : (projectors theory invertible).projectLeft whole = left)
    (whole_right : (projectors theory invertible).projectRight whole = right) :
    chosenCommonExtension theory invertible transformationSeparation
        left right compatible = whole := by
  exact commonExtension_unique theory invertible transformationSeparation
    compatible.1
    (chosenCommonExtension_projectLeft theory invertible
      transformationSeparation left right compatible)
    (chosenCommonExtension_projectRight theory invertible
      transformationSeparation left right compatible)
    whole_left whole_right

/-- Definition 5.6 and Theorem 5.9 as an honest compatibility-indexed state
product.  No value exists for incompatible inputs. -/
noncomputable def stateProduct
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation) :
    StateProduct (projectors theory invertible) where
  product := fun left right _ compatible =>
    chosenCommonExtension theory invertible transformationSeparation
      left right compatible
  reconstruct := by
    intro A B separated whole
    exact chosenCommonExtension_eq theory invertible transformationSeparation
      ((projectors theory invertible).projectLeft whole)
      ((projectors theory invertible).projectRight whole)
      (canonicalCompatibility (projectors theory invertible) separated whole)
      whole rfl rfl

/-- Definition 5.6's representative computation:
`[W]_A ⊙ [W]_B = [W]_{A ⊔ B}`. -/
theorem stateProduct_mk_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    (representative : Transformation globalSystem) :
    (stateProduct theory invertible transformationSeparation).product
        (mk theory invertible A representative)
        (mk theory invertible B representative) separated
        (representedCompatibility theory invertible separated representative) =
      mk theory invertible (Composite A B) representative := by
  exact chosenCommonExtension_eq theory invertible transformationSeparation
    (mk theory invertible A representative)
    (mk theory invertible B representative)
    (representedCompatibility theory invertible separated representative)
    (mk theory invertible (Composite A B) representative) rfl rfl

end NoumenalState

end RR2021.Reverse.Transitive
