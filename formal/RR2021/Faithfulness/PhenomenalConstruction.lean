import RR2021.Faithfulness.PhenomenalProduct

/-!
# Phenomenal faithfulness: quotient no-signalling theory

The separated transformation product is descended only through Theorem A.3.
The five parts of Axiom 4.6 are then proved independently before assembling the
quotient theory.  Phenomenal states and projectors are unchanged, so there is
no state-representative obligation to hide.
-/

namespace RR2021.Faithfulness

open Systems Dynamics Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Appendix A's separated product on phenomenal-equivalence classes.  The
nearby binary congruence is exactly Theorem A.3. -/
def phenomenalTransformationProduct
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    TransformationProduct System (PhenomenalTransformation theory) where
  product := fun {A B} left right hAB =>
    Quotient.liftOn₂' left right
      (fun leftRepresentative rightRepresentative =>
        PhenomenalTransformation.mk theory
          (theory.transformationProducts.product
            leftRepresentative rightRepresentative hAB))
      (fun _ _ _ _ leftRelated rightRelated =>
        (theory.phenomenalCon (Composite A B)).eq.mpr
          (theory.phenomenallyEquivalent_product hAB leftRelated rightRelated))

@[simp]
theorem phenomenalTransformationProduct_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (left : Transformation A) (right : Transformation B)
    (hAB : Separated A B) :
    (phenomenalTransformationProduct theory).product
        (PhenomenalTransformation.mk theory left)
        (PhenomenalTransformation.mk theory right) hAB =
      PhenomenalTransformation.mk theory
        (theory.transformationProducts.product left right hAB) :=
  rfl

/-- Theorem A.4: the quotient product satisfies the no-signalling marginal
law. -/
theorem phenomenalQuotient_noSignalling
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    NoSignallingAxiom theory.projectors
      (phenomenalTransformationProduct theory) := by
  intro A B left right hAB state
  induction left using Quotient.inductionOn with
  | _ left =>
    induction right using Quotient.inductionOn with
    | _ right => exact theory.noSignalling left right hAB state

/-- Axiom 4.6 multiplication descends to the quotient product. -/
theorem phenomenalQuotient_productMultiplicative
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalTransformationProduct theory).Multiplicative := by
  intro A B hAB leftOuter leftInner rightOuter rightInner
  induction leftOuter using Quotient.inductionOn with
  | _ leftOuter =>
    induction leftInner using Quotient.inductionOn with
    | _ leftInner =>
      induction rightOuter using Quotient.inductionOn with
      | _ rightOuter =>
        induction rightInner using Quotient.inductionOn with
        | _ rightInner =>
          exact congrArg (PhenomenalTransformation.mk theory)
            (theory.productMultiplicative hAB
              leftOuter leftInner rightOuter rightInner)

/-- Axiom 4.6 identity preservation descends to the quotient product. -/
theorem phenomenalQuotient_productUnital
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalTransformationProduct theory).Unital := by
  intro A B hAB
  exact congrArg (PhenomenalTransformation.mk theory)
    (theory.productUnital hAB)

/-- Axiom 4.6 symmetry descends, with the quotient reindex computation made
explicit. -/
theorem phenomenalQuotient_productSymmetric
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalTransformationProduct theory).Symmetric := by
  intro A B hAB left right
  induction left using Quotient.inductionOn with
  | _ left =>
    induction right using Quotient.inductionOn with
    | _ right =>
      change reindex (PhenomenalTransformation theory) (sup_comm A B)
          (PhenomenalTransformation.mk theory
            (theory.transformationProducts.product left right hAB)) =
        PhenomenalTransformation.mk theory
          (theory.transformationProducts.product right left hAB.symm)
      rw [PhenomenalTransformation.reindex_mk]
      exact congrArg (PhenomenalTransformation.mk theory)
        (theory.productSymmetric hAB left right)

/-- Axiom 4.6 associativity descends, with the quotient reindex computation
made explicit. -/
theorem phenomenalQuotient_productAssociative
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalTransformationProduct theory).Associative := by
  intro A B C hAB hAC hBC left middle right
  induction left using Quotient.inductionOn with
  | _ left =>
    induction middle using Quotient.inductionOn with
    | _ middle =>
      induction right using Quotient.inductionOn with
      | _ right =>
        change reindex (PhenomenalTransformation theory) (sup_assoc A B C)
            (PhenomenalTransformation.mk theory
              (theory.transformationProducts.product
                (theory.transformationProducts.product left middle hAB) right
                (composite_separated_of_pairwise hAC hBC))) =
          PhenomenalTransformation.mk theory
            (theory.transformationProducts.product left
              (theory.transformationProducts.product middle right hBC)
              (separated_composite_of_pairwise hAB hAC))
        rw [PhenomenalTransformation.reindex_mk]
        exact congrArg (PhenomenalTransformation.mk theory)
          (theory.productAssociative hAB hAC hBC left middle right)

/-- The complete Appendix A quotient as a no-signalling theory.  The
phenomenal state family and projector family are copied unchanged. -/
def phenomenalQuotientTheory
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    NoSignallingTheory System (PhenomenalTransformation theory) PhenomenalState where
  stateNonempty := theory.stateNonempty
  projectors := theory.projectors
  projectorsSurjective := theory.projectorsSurjective
  transformationProducts := phenomenalTransformationProduct theory
  noSignalling := phenomenalQuotient_noSignalling theory
  productMultiplicative := phenomenalQuotient_productMultiplicative theory
  productUnital := phenomenalQuotient_productUnital theory
  productSymmetric := phenomenalQuotient_productSymmetric theory
  productAssociative := phenomenalQuotient_productAssociative theory

/-- The quotient is faithful in the source's contextual sense.  This does not
claim `ActionEffective`: equality of local actions alone need not recover the
contextual relation used by Definition 4.1. -/
theorem phenomenalQuotientTheory_phenomenallyFaithful
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalQuotientTheory theory).PhenomenallyFaithful := by
  intro A left right equivalent
  revert equivalent
  refine Quotient.inductionOn₂ left right ?_
  intro leftRepresentative rightRepresentative equivalent
  apply (theory.phenomenalCon A).eq.mpr
  intro B hAB state
  exact equivalent hAB state

end RR2021.Faithfulness
