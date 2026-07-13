import Mathlib.Data.Finset.BooleanAlgebra
import Mathlib.Data.Fintype.Basic
import RR2021.Correspondence.API

/-!
# A stable finite trivial model

This module constructs a complete nonempty local-realistic theory over a
nontrivial finite Boolean system algebra using singleton state and
transformation values.  It then exercises the forward constructor and both
general reverse outputs.  Unlike earlier diagnostic fixtures, this model is a
stable public declaration and imports only completed APIs.
-/

namespace RR2021.Models.Trivial

open RR2021.Systems RR2021.Dynamics RR2021.Theories

/-- A nontrivial four-element Boolean algebra of systems. -/
abbrev System := Finset (Fin 2)

/-- The single transformation value at every system. -/
inductive TransformationValue : Type
  | identity
  deriving DecidableEq

/-- The single state value at every system. -/
inductive StateValue : Type
  | unique
  deriving DecidableEq

instance : Subsingleton TransformationValue where
  allEq left right := by cases left; cases right; rfl

instance : Subsingleton StateValue where
  allEq left right := by cases left; cases right; rfl

instance : Monoid TransformationValue where
  one := .identity
  mul _ _ := .identity
  mul_assoc _ _ _ := rfl
  one_mul _ := rfl
  mul_one _ := rfl

instance : MulAction TransformationValue StateValue where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

abbrev Transformation (_ : System) := TransformationValue
abbrev State (_ : System) := StateValue

@[reducible, instance]
def indexedMonoid : IndexedMonoid System Transformation where
  monoid _ := inferInstance

@[reducible, instance]
def indexedMulAction : IndexedMulAction System Transformation State where
  mulAction _ := inferInstance

/-- Identity projectors on the singleton indexed state family. -/
def projectors : ProjectorFamily System State where
  project := fun _ state => state
  nested := by intros; rfl

theorem projectors_surjective : projectors.Surjective := by
  intro A B hAB state
  exact ⟨state, rfl⟩

/-- The honest compatibility-indexed product.  It has no off-domain value even
though every pair in this singleton model is compatible. -/
def stateProduct : StateProduct projectors where
  product := fun left _ _ _ => left
  reconstruct := by intros; exact Subsingleton.elim _ _

/-- The unique separated transformation product. -/
def transformationProduct : TransformationProduct System Transformation where
  product := fun _ _ _ => 1

/-- Locality for the singleton state and transformation families. -/
def locality : Locality projectors stateProduct transformationProduct where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    exact compatible
  act_product := by intros; exact Subsingleton.elim _ _

/-- Identity noumenal--phenomenal map. -/
def phenomenalization : IndexedMap System State State :=
  IndexedMap.id State

/-- Complete pre-faithful local-realistic data. -/
def core : LocalRealisticCore System Transformation State State where
  noumenalNonempty := fun _ => ⟨.unique⟩
  phenomenalization := phenomenalization
  phenomenalizationEquivariant := IndexedMap.id_equivariant
  phenomenalizationSurjective := IndexedMap.id_surjective
  noumenalProjectors := projectors
  noumenalProjectorsSurjective := projectors_surjective
  phenomenalProjectors := projectors
  phenomenalizationProjectionCompatible := by
    intro A B hAB state
    rfl
  noumenalProduct := stateProduct
  transformationProducts := transformationProduct
  locality := locality

/-- The stable complete local-realistic model. -/
def theory : LocalRealisticTheory System Transformation State State where
  toLocalRealisticCore := core
  noumenalActionFaithful := by
    intro A left right sameAction
    exact Subsingleton.elim _ _

/-- Its forward no-signalling image. -/
def noSignallingTheory : NoSignallingTheory System Transformation State :=
  RR2021.Correspondence.forward theory

/-- Singleton transformations are existentially invertible. -/
theorem invertible : InvertibleDynamics Transformation := by
  intro A transformation
  exact ⟨1, Subsingleton.elim _ _, Subsingleton.elim _ _⟩

/-- Raw transformation separation holds nonvacuously over the finite Boolean
system algebra, with the unique middle transformation. -/
theorem transformationSeparation :
    noSignallingTheory.TransformationSeparation := by
  intro A B C hAB hAC hBC transformationBC transformationAC equality
  exact ⟨1, Subsingleton.elim _ _⟩

/-- Contextual phenomenal faithfulness holds because every local
transformation family is a singleton. -/
theorem phenomenallyFaithful : noSignallingTheory.PhenomenallyFaithful := by
  intro A left right equivalent
  exact Subsingleton.elim _ _

/-- Global transitivity also holds on the singleton global state space. -/
theorem globallyTransitive : noSignallingTheory.GloballyTransitive := by
  intro initial target
  exact ⟨1, Subsingleton.elim _ _⟩

/-- Concrete general reverse output retaining the raw transformation family. -/
noncomputable def generalRawTheory :=
  RR2021.Correspondence.generalReverseRetainingTransformations
    noSignallingTheory invertible transformationSeparation phenomenallyFaithful

/-- Concrete general reverse output using the Appendix-B faithful
transformation quotient. -/
noncomputable def generalQuotientTheory :=
  RR2021.Correspondence.generalReverseWithFaithfulQuotient
    noSignallingTheory invertible transformationSeparation

/-- The concrete raw reverse/forward composite preserves the source
operational data. -/
theorem generalRaw_forward_sameOperationalData :
    RR2021.Correspondence.SameOperationalData
      (RR2021.Correspondence.forward generalRawTheory)
      noSignallingTheory :=
  RR2021.Correspondence.generalReverse_forward_sameOperationalData
    noSignallingTheory invertible transformationSeparation phenomenallyFaithful

end RR2021.Models.Trivial
