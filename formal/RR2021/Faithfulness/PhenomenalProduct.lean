import RR2021.Faithfulness.PhenomenalCore

/-!
# Phenomenal faithfulness: product congruence

This proof leaf establishes Theorem A.3 with every commutativity and
associativity transport exposed.  It supplies the representative-independence
theorem required by the separated transformation product on quotient classes.
-/

namespace RR2021.Theories.NoSignallingTheory

open RR2021.Systems RR2021.Dynamics

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Extending phenomenally equivalent transformations by an identity on the
right preserves phenomenal equivalence at the composite index. -/
theorem phenomenallyEquivalent_product_one
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hAB : Separated A B)
    {left right : Transformation A}
    (equivalent : theory.PhenomenallyEquivalent left right) :
    theory.PhenomenallyEquivalent
      (theory.transformationProducts.product left (1 : Transformation B) hAB)
      (theory.transformationProducts.product right (1 : Transformation B) hAB) := by
  intro C hAB_C state
  let hAC : Separated A C := hAB_C.mono_left le_sup_left
  let hBC : Separated B C := hAB_C.mono_left le_sup_right
  let hA_BC : Separated A (Composite B C) :=
    separated_composite_of_pairwise hAB hAC
  let canonicalAB_C : Separated (Composite A B) C :=
    composite_separated_of_pairwise hAC hBC
  let reassociate := sup_assoc A B C
  let stateRight : PhenomenalState (Composite A (Composite B C)) :=
    reindex PhenomenalState reassociate state
  have associate (transformation : Transformation A) :
      reindex Transformation reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product transformation
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C) =
        theory.transformationProducts.product transformation
          (1 : Transformation (Composite B C)) hA_BC := by
    calc
      reindex Transformation reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product transformation
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C) =
          reindex Transformation reassociate
            (theory.transformationProducts.product
              (theory.transformationProducts.product transformation
                (1 : Transformation B) hAB)
              (1 : Transformation C) canonicalAB_C) := by
        apply congrArg (reindex Transformation reassociate)
        exact theory.transformationProducts.product_separation_irrelevant _ _ _ _
      _ = theory.transformationProducts.product transformation
          (theory.transformationProducts.product
            (1 : Transformation B) (1 : Transformation C) hBC) hA_BC :=
        theory.productAssociative hAB hAC hBC transformation
          (1 : Transformation B) (1 : Transformation C)
      _ = theory.transformationProducts.product transformation
          (1 : Transformation (Composite B C)) hA_BC := by
        rw [theory.productUnital hBC]
  have transported :
      reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product left
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state) =
        reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product right
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state) := by
    calc
      reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product left
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state) =
          reindex Transformation reassociate
              (theory.transformationProducts.product
                (theory.transformationProducts.product left
                  (1 : Transformation B) hAB)
                (1 : Transformation C) hAB_C) • stateRight := by
        rw [reindex_smul]
      _ = theory.transformationProducts.product left
          (1 : Transformation (Composite B C)) hA_BC • stateRight := by
        rw [associate left]
      _ = theory.transformationProducts.product right
          (1 : Transformation (Composite B C)) hA_BC • stateRight :=
        equivalent hA_BC stateRight
      _ = reindex Transformation reassociate
              (theory.transformationProducts.product
                (theory.transformationProducts.product right
                  (1 : Transformation B) hAB)
                (1 : Transformation C) hAB_C) • stateRight := by
        rw [associate right]
      _ = reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product right
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state) := by
        rw [reindex_smul]
  calc
    theory.transformationProducts.product
        (theory.transformationProducts.product left
          (1 : Transformation B) hAB)
        (1 : Transformation C) hAB_C • state =
      reindex PhenomenalState reassociate.symm
        (reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product left
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state)) :=
      (reindex_inverse PhenomenalState reassociate _).symm
    _ = reindex PhenomenalState reassociate.symm
        (reindex PhenomenalState reassociate
          (theory.transformationProducts.product
            (theory.transformationProducts.product right
              (1 : Transformation B) hAB)
            (1 : Transformation C) hAB_C • state)) :=
      congrArg (reindex PhenomenalState reassociate.symm) transported
    _ = theory.transformationProducts.product
        (theory.transformationProducts.product right
          (1 : Transformation B) hAB)
        (1 : Transformation C) hAB_C • state :=
      reindex_inverse PhenomenalState reassociate _

/-- The symmetric identity extension, derived through the explicit
`sup_comm` transport and Axiom 4.6 symmetry. -/
theorem phenomenallyEquivalent_one_product
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hAB : Separated A B)
    {left right : Transformation B}
    (equivalent : theory.PhenomenallyEquivalent left right) :
    theory.PhenomenallyEquivalent
      (theory.transformationProducts.product (1 : Transformation A) left hAB)
      (theory.transformationProducts.product (1 : Transformation A) right hAB) := by
  have extended : theory.PhenomenallyEquivalent
      (theory.transformationProducts.product left (1 : Transformation A) hAB.symm)
      (theory.transformationProducts.product right (1 : Transformation A) hAB.symm) :=
    theory.phenomenallyEquivalent_product_one
      (A := B) (B := A) hAB.symm (equivalent := equivalent)
  have transported : theory.PhenomenallyEquivalent
      (reindex Transformation (sup_comm B A)
        (theory.transformationProducts.product left (1 : Transformation A) hAB.symm))
      (reindex Transformation (sup_comm B A)
        (theory.transformationProducts.product right (1 : Transformation A) hAB.symm)) :=
    theory.phenomenallyEquivalent_reindex
    (A := Composite B A) (B := Composite A B) (sup_comm B A) extended
  intro C hsep state
  simpa only [theory.productSymmetric hAB.symm left (1 : Transformation A),
    theory.productSymmetric hAB.symm right (1 : Transformation A)] using
    transported hsep state

/-- Theorem A.3: the separated transformation product respects phenomenal
equivalence in both representatives. -/
theorem phenomenallyEquivalent_product
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hAB : Separated A B)
    {left left' : Transformation A} {right right' : Transformation B}
    (leftEquivalent : theory.PhenomenallyEquivalent left left')
    (rightEquivalent : theory.PhenomenallyEquivalent right right') :
    theory.PhenomenallyEquivalent
      (theory.transformationProducts.product left right hAB)
      (theory.transformationProducts.product left' right' hAB) := by
  have leftExtended : theory.PhenomenallyEquivalent
      (theory.transformationProducts.product left (1 : Transformation B) hAB)
      (theory.transformationProducts.product left' (1 : Transformation B) hAB) :=
    theory.phenomenallyEquivalent_product_one
      (A := A) (B := B) hAB (equivalent := leftEquivalent)
  have rightExtended : theory.PhenomenallyEquivalent
      (theory.transformationProducts.product (1 : Transformation A) right hAB)
      (theory.transformationProducts.product (1 : Transformation A) right' hAB) :=
    theory.phenomenallyEquivalent_one_product
      (A := A) (B := B) hAB (equivalent := rightEquivalent)
  have decompose (leftTransformation : Transformation A)
      (rightTransformation : Transformation B) :
      theory.transformationProducts.product leftTransformation rightTransformation hAB =
        theory.transformationProducts.product leftTransformation
            (1 : Transformation B) hAB *
          theory.transformationProducts.product (1 : Transformation A)
            rightTransformation hAB := by
    simpa only [mul_one, one_mul] using
      (theory.productMultiplicative hAB leftTransformation
        (1 : Transformation A) (1 : Transformation B) rightTransformation).symm
  intro C hsep state
  rw [decompose left right, decompose left' right']
  exact theory.phenomenallyEquivalent_mul leftExtended rightExtended hsep state

end RR2021.Theories.NoSignallingTheory
