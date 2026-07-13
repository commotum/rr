import Mathlib.Data.Finset.BooleanAlgebra
import Mathlib.Data.Fintype.Basic
import Mathlib.Algebra.Group.Nat.Defs
import Lean.Elab.Tactic.Omega
import RR2021.Theories.Basic
import RR2021.Theories.Postulates

/-!
# Operational theories: finite/trivial constructor examples

These examples inhabit every Stage 4 layer with singleton states and
transformations over a nontrivial finite Boolean system algebra.  They are a
diagnostic leaf and are never imported by the public API.
-/

namespace RR2021.Theories.Examples

open RR2021.Systems RR2021.Dynamics

abbrev ExampleSystem := Finset (Fin 2)
abbrev ExampleState (_ : ExampleSystem) := Unit
abbrev ExampleTransformation (_ : ExampleSystem) := Unit

local instance : Monoid Unit where
  one := ()
  mul _ _ := ()
  mul_assoc _ _ _ := rfl
  one_mul _ := rfl
  mul_one _ := rfl

local instance : IndexedMonoid ExampleSystem ExampleTransformation where
  monoid _ := inferInstance

local instance : MulAction Unit Unit where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance : IndexedMulAction ExampleSystem ExampleTransformation ExampleState where
  mulAction _ := inferInstance

def exampleProjectors : ProjectorFamily ExampleSystem ExampleState where
  project := fun _ state => state
  nested := by intros; rfl

theorem exampleProjectorsSurjective : exampleProjectors.Surjective := by
  intro A B hAB state
  exact ⟨state, rfl⟩

def exampleStateProduct : StateProduct exampleProjectors where
  product := fun left _ _ _ => left
  reconstruct := by intros; rfl

def exampleTransformationProduct :
    TransformationProduct ExampleSystem ExampleTransformation where
  product := fun _ _ _ => ()

def exampleLocality :
    Locality exampleProjectors exampleStateProduct exampleTransformationProduct where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    change Compatible exampleProjectors left right
    exact compatible
  act_product := by
    intros
    rfl

def examplePhenomenalTheory :
    PhenomenalTheory ExampleSystem ExampleTransformation ExampleState where
  stateNonempty := fun _ => ⟨()⟩
  projectors := exampleProjectors
  projectorsSurjective := exampleProjectorsSurjective

def exampleNoSignallingTheory :
    NoSignallingTheory ExampleSystem ExampleTransformation ExampleState where
  toPhenomenalTheory := examplePhenomenalTheory
  transformationProducts := exampleTransformationProduct
  noSignalling := by
    unfold NoSignallingAxiom
    intros
    exact Subsingleton.elim _ _
  productMultiplicative := by
    unfold TransformationProduct.Multiplicative
    intros
    exact Subsingleton.elim _ _
  productUnital := by
    unfold TransformationProduct.Unital
    intros
    exact Subsingleton.elim _ _
  productSymmetric := by
    unfold TransformationProduct.Symmetric
    intros
    exact Subsingleton.elim _ _
  productAssociative := by
    unfold TransformationProduct.Associative
    intros
    exact Subsingleton.elim _ _

def examplePhenomenalization :
    IndexedMap ExampleSystem ExampleState ExampleState :=
  IndexedMap.id ExampleState

def exampleLocalRealisticCore :
    LocalRealisticCore ExampleSystem ExampleTransformation ExampleState ExampleState where
  noumenalNonempty := fun _ => ⟨()⟩
  phenomenalization := examplePhenomenalization
  phenomenalizationEquivariant := IndexedMap.id_equivariant
  phenomenalizationSurjective := IndexedMap.id_surjective
  noumenalProjectors := exampleProjectors
  noumenalProjectorsSurjective := exampleProjectorsSurjective
  phenomenalProjectors := exampleProjectors
  phenomenalizationProjectionCompatible := by
    unfold ProjectionCompatible
    intros
    rfl
  noumenalProduct := exampleStateProduct
  transformationProducts := exampleTransformationProduct
  locality := exampleLocality

def exampleLocalRealisticTheory :
    LocalRealisticTheory ExampleSystem ExampleTransformation ExampleState ExampleState where
  toLocalRealisticCore := exampleLocalRealisticCore
  noumenalActionFaithful := by
    intro A left right sameAction
    exact Subsingleton.elim _ _

example : IndexedNonempty ExampleState :=
  exampleLocalRealisticCore.phenomenalNonempty

example : exampleLocalRealisticCore.phenomenalProjectors.Surjective :=
  exampleLocalRealisticCore.phenomenalProjectorsSurjective

example : exampleLocalRealisticTheory.transformationProducts.Multiplicative :=
  exampleLocalRealisticTheory.productMultiplicative

example : exampleLocalRealisticTheory.transformationProducts.Unital :=
  exampleLocalRealisticTheory.productUnital

example : exampleLocalRealisticTheory.transformationProducts.Symmetric :=
  exampleLocalRealisticTheory.productSymmetric

example : exampleLocalRealisticTheory.transformationProducts.Associative :=
  exampleLocalRealisticTheory.productAssociative

example : InvertibleDynamics ExampleTransformation := by
  intro A transformation
  exact ⟨(), Subsingleton.elim _ _, Subsingleton.elim _ _⟩

example : exampleNoSignallingTheory.PhenomenallyFaithful := by
  intro A left right equivalent
  exact Subsingleton.elim _ _

example : exampleNoSignallingTheory.GloballyTransitive := by
  intro initial target
  exact ⟨(), Subsingleton.elim _ _⟩

example : exampleNoSignallingTheory.TransformationSeparation := by
  intro A B C hAB hAC hBC transformationBC transformationAC equality
  exact ⟨(), Subsingleton.elim _ _⟩

/-! ## A no-signalling model without the reverse postulates

Natural-number transformations multiply componentwise but act trivially on
Boolean states.  This makes a valid no-signalling theory while refuting
invertibility, contextual phenomenal faithfulness, and global transitivity.
These negative checks guard the constructor boundary against field creep.
-/

abbrev BoundaryState (_ : ExampleSystem) := Bool
abbrev BoundaryTransformation (_ : ExampleSystem) := Nat

local instance : IndexedMonoid ExampleSystem BoundaryTransformation where
  monoid _ := inferInstance

local instance : MulAction Nat Bool where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance : IndexedMulAction ExampleSystem BoundaryTransformation BoundaryState where
  mulAction _ := inferInstance

def boundaryProjectors : ProjectorFamily ExampleSystem BoundaryState where
  project := fun _ state => state
  nested := by intros; rfl

theorem boundaryProjectorsSurjective : boundaryProjectors.Surjective := by
  intro A B hAB state
  exact ⟨state, rfl⟩

def boundaryTransformationProduct :
    TransformationProduct ExampleSystem BoundaryTransformation where
  product := fun left right _ => left * right

private theorem reindexBoundaryTransformation {A B : ExampleSystem}
    (h : A = B) (transformation : BoundaryTransformation A) :
    reindex BoundaryTransformation h transformation = transformation := by
  subst B
  rfl

theorem boundaryProductMultiplicative :
    boundaryTransformationProduct.Multiplicative := by
  unfold TransformationProduct.Multiplicative
  intro A B hsep leftOuter leftInner rightOuter rightInner
  change (leftOuter * rightOuter) * (leftInner * rightInner) =
    (leftOuter * leftInner) * (rightOuter * rightInner)
  ac_rfl

theorem boundaryProductUnital : boundaryTransformationProduct.Unital := by
  unfold TransformationProduct.Unital
  intros
  rfl

theorem boundaryProductSymmetric : boundaryTransformationProduct.Symmetric := by
  unfold TransformationProduct.Symmetric
  intro A B hsep left right
  rw [reindexBoundaryTransformation]
  exact Nat.mul_comm left right

theorem boundaryProductAssociative : boundaryTransformationProduct.Associative := by
  unfold TransformationProduct.Associative
  intro A B C hAB hAC hBC left middle right
  rw [reindexBoundaryTransformation]
  exact Nat.mul_assoc left middle right

def boundaryPhenomenalTheory :
    PhenomenalTheory ExampleSystem BoundaryTransformation BoundaryState where
  stateNonempty := fun _ => ⟨false⟩
  projectors := boundaryProjectors
  projectorsSurjective := boundaryProjectorsSurjective

def boundaryNoSignallingTheory :
    NoSignallingTheory ExampleSystem BoundaryTransformation BoundaryState where
  toPhenomenalTheory := boundaryPhenomenalTheory
  transformationProducts := boundaryTransformationProduct
  noSignalling := by
    unfold NoSignallingAxiom
    intros
    rfl
  productMultiplicative := boundaryProductMultiplicative
  productUnital := boundaryProductUnital
  productSymmetric := boundaryProductSymmetric
  productAssociative := boundaryProductAssociative

theorem boundary_not_invertible :
    ¬ InvertibleDynamics BoundaryTransformation := by
  intro invertible
  obtain ⟨inverse, product_eq, inverse_product_eq⟩ :=
    invertible (∅ : ExampleSystem) 2
  change (2 : Nat) * inverse = 1 at product_eq
  omega

theorem boundary_not_phenomenallyFaithful :
    ¬ boundaryNoSignallingTheory.PhenomenallyFaithful := by
  intro faithful
  have equivalent : boundaryNoSignallingTheory.PhenomenallyEquivalent
      (A := (∅ : ExampleSystem)) 1 2 := by
    unfold NoSignallingTheory.PhenomenallyEquivalent
    intros
    rfl
  have equality := faithful (∅ : ExampleSystem) 1 2 equivalent
  change (1 : Nat) = 2 at equality
  omega

theorem boundary_not_globallyTransitive :
    ¬ boundaryNoSignallingTheory.GloballyTransitive := by
  intro transitive
  obtain ⟨transformation, equality⟩ := transitive false true
  change false = true at equality
  contradiction

end RR2021.Theories.Examples
