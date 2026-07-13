import Mathlib.Data.Finset.BooleanAlgebra
import Mathlib.Data.Fintype.Basic
import Mathlib.GroupTheory.Perm.Basic
import RR2021.Dynamics.StateProductCoherence
import RR2021.Dynamics.TransformationProductDerived

/-!
# Indexed dynamics: executable examples and boundary tests

This diagnostic leaf fixes the action convention with noncommuting
permutations and instantiates the honest partial product on a constant family.
It is never imported by the public API.
-/

namespace RR2021.Dynamics.Examples

open RR2021.Systems

abbrev ExampleSystem := Finset (Fin 2)
abbrev Point := Fin 3
abbrev PointState (_ : ExampleSystem) := Point
abbrev Permutation (_ : ExampleSystem) := Equiv.Perm Point

local instance : MulAction (Equiv.Perm Point) Point where
  smul permutation point := permutation point
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance : IndexedMonoid ExampleSystem Permutation where
  monoid _ := inferInstance

local instance : IndexedMulAction ExampleSystem Permutation PointState where
  mulAction _ := inferInstance

def firstSwap : Equiv.Perm Point := Equiv.swap 0 1
def secondSwap : Equiv.Perm Point := Equiv.swap 1 2

/-- Standard multiplication acts right-to-left: the second swap is applied first. -/
example : (firstSwap * secondSwap) • (0 : Point) = 1 := by
  decide

/-- Reversing the action order gives a genuinely different result. -/
example : secondSwap • (firstSwap • (0 : Point)) = 2 := by
  decide

theorem reversed_action_order_is_wrong :
    (firstSwap * secondSwap) • (0 : Point) ≠
      secondSwap • (firstSwap • (0 : Point)) := by
  decide

/-- Identity projectors on a constant indexed family. -/
def identityProjectors : ProjectorFamily ExampleSystem PointState where
  project := fun _ state => state
  nested := by intros; rfl

theorem identityProjectors_surjective : identityProjectors.Surjective := by
  intro A B h state
  exact ⟨state, rfl⟩

example {A : ExampleSystem} (state : PointState A) :
    identityProjectors.project (A := A) (B := A) le_rfl state = state :=
  identityProjectors.project_self identityProjectors_surjective state

/-- On identity projectors, compatible subsystem states must agree; the product
returns that common value. -/
def equalStateProduct : StateProduct identityProjectors where
  product := fun left _ _ _ => left
  reconstruct := by intros; rfl

private def empty : ExampleSystem := ∅
private def whole : ExampleSystem := Finset.univ

private theorem empty_whole_separated : Separated empty whole := by
  simp [empty, whole, Separated]

example : Compatible (A := empty) (B := whole) identityProjectors
    (0 : PointState empty) (0 : PointState whole) :=
  canonicalCompatibility identityProjectors empty_whole_separated 0

example :
    equalStateProduct.product (A := empty) (B := whole) 0 0
        empty_whole_separated
        (canonicalCompatibility identityProjectors empty_whole_separated 0) = 0 :=
  rfl

/-- Distinct values have no common extension, so no product input exists. -/
theorem unequal_states_incompatible :
    ¬ Compatible (A := empty) (B := whole) identityProjectors
      (0 : PointState empty) (1 : PointState whole) := by
  simp [Compatible, identityProjectors, ProjectorFamily.projectLeft,
    ProjectorFamily.projectRight]

example :
    reindex PointState (sup_comm empty whole)
        (equalStateProduct.product (A := empty) (B := whole) 0 0
          empty_whole_separated
          (canonicalCompatibility identityProjectors empty_whole_separated 0)) =
      equalStateProduct.product (A := whole) (B := empty) 0 0
        empty_whole_separated.symm
        (compatible_swap
          (canonicalCompatibility identityProjectors empty_whole_separated 0)) :=
  equalStateProduct.product_comm 0 0 empty_whole_separated _

private theorem empty_empty_separated : Separated empty empty := by
  simp [empty, Separated]

example :
    let hAB := empty_empty_separated
    let hAC := empty_whole_separated
    let hBC := empty_whole_separated
    let hab : Compatible (A := empty) (B := empty) identityProjectors 0 0 :=
      canonicalCompatibility identityProjectors hAB 0
    let hab_c : Compatible (A := Composite empty empty) (B := whole)
        identityProjectors (equalStateProduct.product 0 0 hAB hab) 0 :=
      canonicalCompatibility identityProjectors (leftOuterSeparated hAC hBC) 0
    let hbc : Compatible (A := empty) (B := whole) identityProjectors 0 0 :=
      canonicalCompatibility identityProjectors hBC 0
    let ha_bc : Compatible (A := empty) (B := Composite empty whole)
        identityProjectors 0 (equalStateProduct.product 0 0 hBC hbc) :=
      canonicalCompatibility identityProjectors (rightOuterSeparated hAB hAC) 0
    reindex PointState (sup_assoc empty empty whole)
        (equalStateProduct.product (equalStateProduct.product 0 0 hAB hab) 0
          (leftOuterSeparated hAC hBC) hab_c) =
      equalStateProduct.product 0 (equalStateProduct.product 0 0 hBC hbc)
        (rightOuterSeparated hAB hAC) ha_bc := by
  dsimp
  exact equalStateProduct.product_assoc
    (A := empty) (B := empty) (C := whole)
    empty_empty_separated empty_whole_separated empty_whole_separated
    0 0 0
    (canonicalCompatibility identityProjectors empty_empty_separated 0)
    (canonicalCompatibility identityProjectors
      (leftOuterSeparated empty_whole_separated empty_whole_separated) 0)
    (canonicalCompatibility identityProjectors empty_whole_separated 0)
    (canonicalCompatibility identityProjectors
      (rightOuterSeparated empty_empty_separated empty_whole_separated) 0)

private def atom : ExampleSystem := {0}

/-- Two adjacent separation proofs do not supply the missing pairwise premise
required by triple-product associativity. -/
theorem adjacent_separation_does_not_supply_pairwise :
    Separated atom empty ∧ Separated empty atom ∧ ¬ Separated atom atom := by
  simp [atom, empty, Separated]

/-! ## A complete trivial dynamics model

The singleton transformation family supplies an executable boundary model for
locality.  It exercises the four transformation-product laws as theorems
derived from locality and effective action, rather than fields of the raw
product structure.
-/

abbrev TrivialTransformation (_ : ExampleSystem) := Unit

local instance : Monoid Unit where
  one := ()
  mul _ _ := ()
  mul_assoc _ _ _ := rfl
  one_mul _ := rfl
  mul_one _ := rfl

local instance : IndexedMonoid ExampleSystem TrivialTransformation where
  monoid _ := inferInstance

local instance : MulAction Unit Point where
  smul _ point := point
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance : IndexedMulAction ExampleSystem TrivialTransformation PointState where
  mulAction _ := inferInstance

def trivialTransformationProduct :
    TransformationProduct ExampleSystem TrivialTransformation where
  product := fun _ _ _ => ()

theorem trivial_action_effective :
    ActionEffective TrivialTransformation PointState := by
  intro A left right sameAction
  cases left
  cases right
  rfl

def trivialLocality :
    Locality identityProjectors equalStateProduct trivialTransformationProduct where
  mapCompatible := by
    intro A B leftTransformation rightTransformation left right compatible
    change Compatible identityProjectors left right
    exact compatible
  act_product := by
    intros
    rfl

example : trivialTransformationProduct.Multiplicative :=
  trivialTransformationProduct.multiplicative_of_locality
    trivialLocality trivial_action_effective

example : trivialTransformationProduct.Unital :=
  trivialTransformationProduct.unital_of_locality
    trivialLocality trivial_action_effective

example : trivialTransformationProduct.Symmetric :=
  trivialTransformationProduct.symmetric_of_locality
    trivialLocality trivial_action_effective

example : trivialTransformationProduct.Associative :=
  trivialTransformationProduct.associative_of_locality
    trivialLocality trivial_action_effective

end RR2021.Dynamics.Examples
