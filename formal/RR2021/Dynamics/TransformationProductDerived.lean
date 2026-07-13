import RR2021.Dynamics.Locality

/-!
# Derived algebra laws for transformation products

This heavy proof leaf derives algebraic laws from locality plus effective
action.  The raw `TransformationProduct` stores no multiplication or unit law.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v w

section Basic

variable {System : Type u} [SemilatticeSup System] [OrderBot System]
variable {Transformation : System → Type v}
variable {State : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation State]
variable {projectors : ProjectorFamily System State}
variable {stateProducts : StateProduct projectors}
variable {transformationProducts : TransformationProduct System Transformation}

namespace TransformationProduct

/-- Theorem 3.8: locality plus effective action forces componentwise multiplication. -/
theorem multiplicative_of_locality
    (locality : Locality projectors stateProducts transformationProducts)
    (effective : ActionEffective Transformation State) :
    transformationProducts.Multiplicative := by
  intro A B hsep leftOuter leftInner rightOuter rightInner
  apply effective (Composite A B)
  intro whole
  apply stateProducts.eq_of_projections hsep
  · calc
      projectors.projectLeft
          ((transformationProducts.product leftOuter rightOuter hsep *
              transformationProducts.product leftInner rightInner hsep) • whole) =
          projectors.projectLeft
            (transformationProducts.product leftOuter rightOuter hsep •
              (transformationProducts.product leftInner rightInner hsep • whole)) := by
        rw [mul_smul]
      _ = leftOuter • projectors.projectLeft
          (transformationProducts.product leftInner rightInner hsep • whole) :=
        locality.project_left_product_action leftOuter rightOuter hsep _
      _ = leftOuter • (leftInner • projectors.projectLeft whole) := by
        rw [locality.project_left_product_action leftInner rightInner hsep whole]
      _ = (leftOuter * leftInner) • projectors.projectLeft whole :=
        (mul_smul leftOuter leftInner (projectors.projectLeft whole)).symm
      _ = projectors.projectLeft
          (transformationProducts.product (leftOuter * leftInner)
            (rightOuter * rightInner) hsep • whole) :=
        (locality.project_left_product_action (leftOuter * leftInner)
          (rightOuter * rightInner) hsep whole).symm
  · calc
      projectors.projectRight
          ((transformationProducts.product leftOuter rightOuter hsep *
              transformationProducts.product leftInner rightInner hsep) • whole) =
          projectors.projectRight
            (transformationProducts.product leftOuter rightOuter hsep •
              (transformationProducts.product leftInner rightInner hsep • whole)) := by
        rw [mul_smul]
      _ = rightOuter • projectors.projectRight
          (transformationProducts.product leftInner rightInner hsep • whole) :=
        locality.project_right_product_action leftOuter rightOuter hsep _
      _ = rightOuter • (rightInner • projectors.projectRight whole) := by
        rw [locality.project_right_product_action leftInner rightInner hsep whole]
      _ = (rightOuter * rightInner) • projectors.projectRight whole :=
        (mul_smul rightOuter rightInner (projectors.projectRight whole)).symm
      _ = projectors.projectRight
          (transformationProducts.product (leftOuter * leftInner)
            (rightOuter * rightInner) hsep • whole) :=
        (locality.project_right_product_action (leftOuter * leftInner)
          (rightOuter * rightInner) hsep whole).symm

/-- Theorem 3.9: locality plus effective action forces preservation of identity. -/
theorem unital_of_locality
    (locality : Locality projectors stateProducts transformationProducts)
    (effective : ActionEffective Transformation State) :
    transformationProducts.Unital := by
  intro A B hsep
  apply effective (Composite A B)
  intro whole
  apply stateProducts.eq_of_projections hsep
  · calc
      projectors.projectLeft
          (transformationProducts.product (1 : Transformation A)
            (1 : Transformation B) hsep • whole) =
          (1 : Transformation A) • projectors.projectLeft whole :=
        locality.project_left_product_action (1 : Transformation A)
          (1 : Transformation B) hsep whole
      _ = projectors.projectLeft whole := one_smul (Transformation A) _
      _ = projectors.projectLeft ((1 : Transformation (Composite A B)) • whole) := by
        rw [one_smul]
  · calc
      projectors.projectRight
          (transformationProducts.product (1 : Transformation A)
            (1 : Transformation B) hsep • whole) =
          (1 : Transformation B) • projectors.projectRight whole :=
        locality.project_right_product_action (1 : Transformation A)
          (1 : Transformation B) hsep whole
      _ = projectors.projectRight whole := one_smul (Transformation B) _
      _ = projectors.projectRight ((1 : Transformation (Composite A B)) • whole) := by
        rw [one_smul]

/-- Theorem 3.10: locality plus effective action forces symmetry after reindexing. -/
theorem symmetric_of_locality
    (locality : Locality projectors stateProducts transformationProducts)
    (effective : ActionEffective Transformation State) :
    transformationProducts.Symmetric := by
  intro A B hsep leftTransformation rightTransformation
  apply effective (Composite B A)
  intro wholeBA
  let wholeAB : State (Composite A B) :=
    reindex State (sup_comm B A) wholeBA
  have whole_roundtrip :
      reindex State (sup_comm A B) wholeAB = wholeBA := by
    simpa only [wholeAB, reindexSupComm] using
      reindexSupComm_twice State wholeBA
  have action_reindex :
      reindex State (sup_comm A B)
          (transformationProducts.product leftTransformation rightTransformation hsep •
            wholeAB) =
        reindex Transformation (sup_comm A B)
            (transformationProducts.product leftTransformation rightTransformation hsep) •
          wholeBA := by
    rw [reindex_smul, whole_roundtrip]
  have wholeAB_left :
      projectors.projectLeft wholeAB = projectors.projectRight wholeBA := by
    simpa only [wholeAB] using projectors.projectLeft_reindexSupComm wholeBA
  have wholeAB_right :
      projectors.projectRight wholeAB = projectors.projectLeft wholeBA := by
    simpa only [wholeAB] using projectors.projectRight_reindexSupComm wholeBA
  apply stateProducts.eq_of_projections hsep.symm
  · calc
      projectors.projectLeft
          (reindex Transformation (sup_comm A B)
              (transformationProducts.product leftTransformation rightTransformation hsep) •
            wholeBA) =
          projectors.projectLeft
            (reindex State (sup_comm A B)
              (transformationProducts.product leftTransformation rightTransformation hsep •
                wholeAB)) :=
        congrArg (projectors.projectLeft (A := B) (B := A)) action_reindex.symm
      _ = projectors.projectRight
          (transformationProducts.product leftTransformation rightTransformation hsep •
            wholeAB) :=
        projectors.projectLeft_reindexSupComm _
      _ = rightTransformation • projectors.projectRight wholeAB :=
        locality.project_right_product_action leftTransformation rightTransformation hsep wholeAB
      _ = rightTransformation • projectors.projectLeft wholeBA := by
        rw [wholeAB_right]
      _ = projectors.projectLeft
          (transformationProducts.product rightTransformation leftTransformation hsep.symm •
            wholeBA) :=
        (locality.project_left_product_action rightTransformation leftTransformation
          hsep.symm wholeBA).symm
  · calc
      projectors.projectRight
          (reindex Transformation (sup_comm A B)
              (transformationProducts.product leftTransformation rightTransformation hsep) •
            wholeBA) =
          projectors.projectRight
            (reindex State (sup_comm A B)
              (transformationProducts.product leftTransformation rightTransformation hsep •
                wholeAB)) :=
        congrArg (projectors.projectRight (A := B) (B := A)) action_reindex.symm
      _ = projectors.projectLeft
          (transformationProducts.product leftTransformation rightTransformation hsep •
            wholeAB) :=
        projectors.projectRight_reindexSupComm _
      _ = leftTransformation • projectors.projectLeft wholeAB :=
        locality.project_left_product_action leftTransformation rightTransformation hsep wholeAB
      _ = leftTransformation • projectors.projectRight wholeBA := by
        rw [wholeAB_left]
      _ = projectors.projectRight
          (transformationProducts.product rightTransformation leftTransformation hsep.symm •
            wholeBA) :=
        (locality.project_right_product_action rightTransformation leftTransformation
          hsep.symm wholeBA).symm

end TransformationProduct

end Basic

section Associativity

variable {System : Type u} [DistribLattice System] [OrderBot System]
variable {Transformation : System → Type v}
variable {State : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation State]
variable {projectors : ProjectorFamily System State}
variable {stateProducts : StateProduct projectors}
variable {transformationProducts : TransformationProduct System Transformation}

namespace TransformationProduct

/-- Theorem 3.11: locality plus effective action forces associativity after reindexing. -/
theorem associative_of_locality
    (locality : Locality projectors stateProducts transformationProducts)
    (effective : ActionEffective Transformation State) :
    transformationProducts.Associative := by
  intro A B C hAB hAC hBC leftTransformation middleTransformation rightTransformation
  let hAB_C : Separated (Composite A B) C :=
    composite_separated_of_pairwise hAC hBC
  let hA_BC : Separated A (Composite B C) :=
    separated_composite_of_pairwise hAB hAC
  let leftAB : Transformation (Composite A B) :=
    transformationProducts.product leftTransformation middleTransformation hAB
  let rightBC : Transformation (Composite B C) :=
    transformationProducts.product middleTransformation rightTransformation hBC
  let leftABC : Transformation (Composite (Composite A B) C) :=
    transformationProducts.product leftAB rightTransformation hAB_C
  let rightABC : Transformation (Composite A (Composite B C)) :=
    transformationProducts.product leftTransformation rightBC hA_BC
  change reindex Transformation (sup_assoc A B C) leftABC = rightABC
  apply effective (Composite A (Composite B C))
  intro wholeR
  let wholeL : State (Composite (Composite A B) C) :=
    reindex State (sup_assoc A B C).symm wholeR
  have whole_roundtrip :
      reindex State (sup_assoc A B C) wholeL = wholeR := by
    simpa only [wholeL, reindexSupAssoc, reindexSupAssocInv] using
      reindexSupAssoc_inverse_rev State wholeR
  have action_reindex :
      reindex State (sup_assoc A B C) (leftABC • wholeL) =
        reindex Transformation (sup_assoc A B C) leftABC • wholeR := by
    rw [reindex_smul, whole_roundtrip]
  let hB_L : Subsystem B (Composite (Composite A B) C) :=
    le_sup_right.trans le_sup_left
  let hB_R : Subsystem B (Composite A (Composite B C)) :=
    le_sup_left.trans le_sup_right
  have project_middle_reindex (state : State (Composite (Composite A B) C)) :
      projectors.project hB_R (reindex State (sup_assoc A B C) state) =
        projectors.project hB_L state := by
    simpa only [hB_L, hB_R] using
      projectors.project_reindex_domain (sup_assoc A B C)
        (show Subsystem B (Composite (Composite A B) C) from
          le_sup_right.trans le_sup_left)
        state
  apply stateProducts.eq_of_projections hA_BC
  · calc
      projectors.projectLeft
          (reindex Transformation (sup_assoc A B C) leftABC • wholeR) =
          projectors.projectLeft
            (reindex State (sup_assoc A B C) (leftABC • wholeL)) :=
        congrArg (projectors.projectLeft (A := A) (B := Composite B C))
          action_reindex.symm
      _ = projectors.project
          (show Subsystem A (Composite (Composite A B) C) from
            le_sup_left.trans le_sup_left)
          (leftABC • wholeL) := by
        simpa only [ProjectorFamily.projectLeft] using
          projectors.project_reindexSupAssoc_left (leftABC • wholeL)
      _ = projectors.projectLeft
          (projectors.projectLeft (A := Composite A B) (B := C)
            (leftABC • wholeL)) :=
        (projectors.projectLeft_projectLeft (leftABC • wholeL)).symm
      _ = projectors.projectLeft (leftAB • projectors.projectLeft wholeL) := by
        apply congrArg (projectors.projectLeft (A := A) (B := B))
        exact locality.project_left_product_action leftAB rightTransformation hAB_C wholeL
      _ = leftTransformation •
          projectors.projectLeft (projectors.projectLeft wholeL) :=
        locality.project_left_product_action leftTransformation middleTransformation hAB
          (projectors.projectLeft wholeL)
      _ = leftTransformation •
          projectors.project
            (show Subsystem A (Composite (Composite A B) C) from
              le_sup_left.trans le_sup_left)
            wholeL := by
        rw [projectors.projectLeft_projectLeft wholeL]
      _ = leftTransformation •
          projectors.project
            (show Subsystem A (Composite A (Composite B C)) from le_sup_left)
            wholeR := by
        rw [← projectors.project_reindexSupAssoc_left wholeL, whole_roundtrip]
      _ = leftTransformation • projectors.projectLeft wholeR := by rfl
      _ = projectors.projectLeft (rightABC • wholeR) :=
        (locality.project_left_product_action leftTransformation rightBC hA_BC wholeR).symm
  · apply stateProducts.eq_of_projections hBC
    · calc
        projectors.projectLeft
            (projectors.projectRight
              (reindex Transformation (sup_assoc A B C) leftABC • wholeR)) =
            projectors.project hB_R
              (reindex Transformation (sup_assoc A B C) leftABC • wholeR) :=
          projectors.projectLeft_projectRight _
        _ = projectors.project hB_R
            (reindex State (sup_assoc A B C) (leftABC • wholeL)) :=
          congrArg (projectors.project hB_R) action_reindex.symm
        _ = projectors.project hB_L (leftABC • wholeL) :=
          project_middle_reindex (leftABC • wholeL)
        _ = projectors.projectRight
            (projectors.projectLeft (A := Composite A B) (B := C)
              (leftABC • wholeL)) :=
          (projectors.projectRight_projectLeft (leftABC • wholeL)).symm
        _ = projectors.projectRight (leftAB • projectors.projectLeft wholeL) := by
          apply congrArg (projectors.projectRight (A := A) (B := B))
          exact locality.project_left_product_action leftAB rightTransformation hAB_C wholeL
        _ = middleTransformation •
            projectors.projectRight (projectors.projectLeft wholeL) :=
          locality.project_right_product_action leftTransformation middleTransformation hAB
            (projectors.projectLeft wholeL)
        _ = middleTransformation • projectors.project hB_L wholeL := by
          rw [projectors.projectRight_projectLeft wholeL]
        _ = middleTransformation •
            projectors.project hB_R (reindex State (sup_assoc A B C) wholeL) := by
          rw [project_middle_reindex wholeL]
        _ = middleTransformation • projectors.project hB_R wholeR := by
          rw [whole_roundtrip]
        _ = middleTransformation •
            projectors.projectLeft (projectors.projectRight wholeR) := by
          rw [projectors.projectLeft_projectRight wholeR]
        _ = projectors.projectLeft (rightBC • projectors.projectRight wholeR) :=
          (locality.project_left_product_action middleTransformation rightTransformation hBC
            (projectors.projectRight wholeR)).symm
        _ = projectors.projectLeft
            (projectors.projectRight (rightABC • wholeR)) := by
          apply congrArg (projectors.projectLeft (A := B) (B := C))
          exact (locality.project_right_product_action leftTransformation rightBC hA_BC
            wholeR).symm
    · calc
        projectors.projectRight
            (projectors.projectRight
              (reindex Transformation (sup_assoc A B C) leftABC • wholeR)) =
            projectors.project
              (show Subsystem C (Composite A (Composite B C)) from
                le_sup_right.trans le_sup_right)
              (reindex Transformation (sup_assoc A B C) leftABC • wholeR) :=
          projectors.projectRight_projectRight _
        _ = projectors.project
            (show Subsystem C (Composite A (Composite B C)) from
              le_sup_right.trans le_sup_right)
            (reindex State (sup_assoc A B C) (leftABC • wholeL)) :=
          congrArg
            (projectors.project
              (show Subsystem C (Composite A (Composite B C)) from
                le_sup_right.trans le_sup_right))
            action_reindex.symm
        _ = projectors.project
            (show Subsystem C (Composite (Composite A B) C) from le_sup_right)
            (leftABC • wholeL) :=
          projectors.project_reindexSupAssoc_right (leftABC • wholeL)
        _ = projectors.projectRight (leftABC • wholeL) := rfl
        _ = rightTransformation • projectors.projectRight wholeL :=
          locality.project_right_product_action leftAB rightTransformation hAB_C wholeL
        _ = rightTransformation •
          projectors.project
            (show Subsystem C (Composite (Composite A B) C) from le_sup_right)
            wholeL := by rfl
        _ = rightTransformation •
            projectors.project
              (show Subsystem C (Composite A (Composite B C)) from
                le_sup_right.trans le_sup_right)
              (reindex State (sup_assoc A B C) wholeL) := by
          rw [projectors.project_reindexSupAssoc_right wholeL]
        _ = rightTransformation •
            projectors.project
              (show Subsystem C (Composite A (Composite B C)) from
                le_sup_right.trans le_sup_right)
              wholeR := by
          rw [whole_roundtrip]
        _ = rightTransformation •
            projectors.projectRight (projectors.projectRight wholeR) := by
          rw [projectors.projectRight_projectRight wholeR]
        _ = projectors.projectRight (rightBC • projectors.projectRight wholeR) :=
          (locality.project_right_product_action middleTransformation rightTransformation hBC
            (projectors.projectRight wholeR)).symm
        _ = projectors.projectRight
            (projectors.projectRight (rightABC • wholeR)) := by
          apply congrArg (projectors.projectRight (A := B) (B := C))
          exact (locality.project_right_product_action leftTransformation rightBC hA_BC
            wholeR).symm

end TransformationProduct

end Associativity

end RR2021.Dynamics
