import Mathlib.Algebra.Group.Nat.Defs
import Mathlib.Data.Finset.BooleanAlgebra
import Mathlib.Data.Fintype.Basic
import Lean.Elab.Tactic.Omega
import RR2021.Forward.Construction

/-!
# Forward construction: assumption-boundary examples

A non-effective natural-number action exercises the state-level theorem on
`LocalRealisticCore`.  A separate singleton transformation family exercises
the complete `LocalRealisticTheory → NoSignallingTheory` constructor.
This file is diagnostic and is excluded from the public API.
-/

namespace RR2021.Forward.Examples

open RR2021.Systems RR2021.Dynamics RR2021.Theories

abbrev ExampleSystem := Finset (Fin 2)
abbrev ExampleState (_ : ExampleSystem) := Bool

def identityProjectors : ProjectorFamily ExampleSystem ExampleState where
  project := fun _ state => state
  nested := by intros; rfl

theorem identityProjectorsSurjective : identityProjectors.Surjective := by
  intro A B hAB state
  exact ⟨state, rfl⟩

def equalityStateProduct : StateProduct identityProjectors where
  product := fun left _ _ _ => left
  reconstruct := by intros; rfl

def identityPhenomenalization :
    IndexedMap ExampleSystem ExampleState ExampleState :=
  IndexedMap.id ExampleState

/-! ## Pre-faithful boundary -/

abbrev NonfaithfulTransformation (_ : ExampleSystem) := Nat

local instance : IndexedMonoid ExampleSystem NonfaithfulTransformation where
  monoid _ := inferInstance

local instance : MulAction Nat Bool where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance :
    IndexedMulAction ExampleSystem NonfaithfulTransformation ExampleState where
  mulAction _ := inferInstance

def nonfaithfulTransformationProduct :
    TransformationProduct ExampleSystem NonfaithfulTransformation where
  product := fun left right _ => left * right

def nonfaithfulLocality :
    Locality identityProjectors equalityStateProduct nonfaithfulTransformationProduct where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    change Compatible identityProjectors left right
    exact compatible
  act_product := by
    intros
    rfl

def nonfaithfulCore :
    LocalRealisticCore ExampleSystem NonfaithfulTransformation ExampleState ExampleState where
  noumenalNonempty := fun _ => ⟨false⟩
  phenomenalization := identityPhenomenalization
  phenomenalizationEquivariant := by
    exact IndexedMap.id_equivariant
  phenomenalizationSurjective := IndexedMap.id_surjective
  noumenalProjectors := identityProjectors
  noumenalProjectorsSurjective := identityProjectorsSurjective
  phenomenalProjectors := identityProjectors
  phenomenalizationProjectionCompatible := by
    unfold ProjectionCompatible
    intros
    rfl
  noumenalProduct := equalityStateProduct
  transformationProducts := nonfaithfulTransformationProduct
  locality := nonfaithfulLocality

theorem nonfaithfulCore_is_not_faithful :
    ¬ NoumenallyFaithful NonfaithfulTransformation ExampleState := by
  unfold NoumenallyFaithful ActionEffective
  intro faithful
  have equality := faithful (∅ : ExampleSystem) 1 2 (by intros; rfl)
  change (1 : Nat) = 2 at equality
  omega

/-- The assumption-minimal state theorem does not consume Axiom 3.7. -/
example : NoSignallingAxiom nonfaithfulCore.phenomenalProjectors
    nonfaithfulCore.transformationProducts :=
  nonfaithfulCore.noSignallingAxiom

example : PhenomenalTheory ExampleSystem NonfaithfulTransformation ExampleState :=
  nonfaithfulCore.toPhenomenalTheory

/-! ## Full forward constructor -/

abbrev FaithfulTransformation (_ : ExampleSystem) := Unit

local instance : Monoid Unit where
  one := ()
  mul _ _ := ()
  mul_assoc _ _ _ := rfl
  one_mul _ := rfl
  mul_one _ := rfl

local instance : IndexedMonoid ExampleSystem FaithfulTransformation where
  monoid _ := inferInstance

local instance : MulAction Unit Bool where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance : IndexedMulAction ExampleSystem FaithfulTransformation ExampleState where
  mulAction _ := inferInstance

def faithfulTransformationProduct :
    TransformationProduct ExampleSystem FaithfulTransformation where
  product := fun _ _ _ => ()

def faithfulLocality :
    Locality identityProjectors equalityStateProduct faithfulTransformationProduct where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    change Compatible identityProjectors left right
    exact compatible
  act_product := by
    intros
    rfl

def faithfulCore :
    LocalRealisticCore ExampleSystem FaithfulTransformation ExampleState ExampleState where
  noumenalNonempty := fun _ => ⟨false⟩
  phenomenalization := identityPhenomenalization
  phenomenalizationEquivariant := by
    exact IndexedMap.id_equivariant
  phenomenalizationSurjective := IndexedMap.id_surjective
  noumenalProjectors := identityProjectors
  noumenalProjectorsSurjective := identityProjectorsSurjective
  phenomenalProjectors := identityProjectors
  phenomenalizationProjectionCompatible := by
    unfold ProjectionCompatible
    intros
    rfl
  noumenalProduct := equalityStateProduct
  transformationProducts := faithfulTransformationProduct
  locality := faithfulLocality

def faithfulTheory :
    LocalRealisticTheory ExampleSystem FaithfulTransformation ExampleState ExampleState where
  toLocalRealisticCore := faithfulCore
  noumenalActionFaithful := by
    unfold NoumenallyFaithful ActionEffective
    intros
    exact Subsingleton.elim _ _

def inducedNoSignallingTheory :
    NoSignallingTheory ExampleSystem FaithfulTransformation ExampleState :=
  faithfulTheory.toNoSignallingTheory

example : NoSignallingAxiom inducedNoSignallingTheory.projectors
    inducedNoSignallingTheory.transformationProducts :=
  inducedNoSignallingTheory.noSignalling

example : inducedNoSignallingTheory.transformationProducts.Multiplicative :=
  inducedNoSignallingTheory.productMultiplicative

end RR2021.Forward.Examples
