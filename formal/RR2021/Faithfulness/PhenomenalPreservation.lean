import RR2021.Faithfulness.PhenomenalConstruction

/-!
# Phenomenal faithfulness: preservation boundaries

Invertibility and global transitivity descend without additional assumptions.
Transformation separation does not: equality of quotient classes supplies only
phenomenal equivalence of raw supported products.  The named modulo-equivalence
predicate below is the precise extra premise used to repair Appendix A's
unsupported preservation sentence (`RR-C013`).
-/

namespace RR2021

open Systems Dynamics

namespace Theories.NoSignallingTheory

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The exact representative-free strengthening of Postulate 4.1 needed after
phenomenal quotienting.  Its premise and conclusion use contextual phenomenal
equivalence at the common triple-composite index. -/
def TransformationSeparationModuloPhenomenalEquivalence
    (theory : NoSignallingTheory System Transformation PhenomenalState) : Prop :=
  ∀ {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (transformationBC : Transformation (Composite B C))
    (transformationAC : Transformation (Composite A C)),
    theory.PhenomenallyEquivalent
      (theory.transformationProducts.product (1 : Transformation A) transformationBC
        (separated_composite_of_pairwise hAB hAC))
      (reindex Transformation (swapFirstTwoPath A B C)
        (theory.transformationProducts.product (1 : Transformation B) transformationAC
          (separated_composite_of_pairwise hAB.symm hBC))) →
    ∃ transformationC : Transformation C,
      theory.PhenomenallyEquivalent
        (theory.transformationProducts.product (1 : Transformation A) transformationBC
          (separated_composite_of_pairwise hAB hAC))
        (reindex Transformation (sup_assoc A B C)
          (theory.transformationProducts.product
            (1 : Transformation (Composite A B)) transformationC
            (composite_separated_of_pairwise hAC hBC)))

/-- Ordinary raw separation implies the modulo version only when phenomenal
equivalence can already be converted back to raw equality. -/
theorem transformationSeparationModulo_of_faithful
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (separation : theory.TransformationSeparation)
    (faithful : theory.PhenomenallyFaithful) :
    theory.TransformationSeparationModuloPhenomenalEquivalence := by
  intro A B C hAB hAC hBC transformationBC transformationAC equivalent
  let left := theory.transformationProducts.product
    (1 : Transformation A) transformationBC
    (separated_composite_of_pairwise hAB hAC)
  let right := reindex Transformation (swapFirstTwoPath A B C)
    (theory.transformationProducts.product (1 : Transformation B) transformationAC
      (separated_composite_of_pairwise hAB.symm hBC))
  have rawEquality : left = right :=
    faithful (Composite A (Composite B C)) left right equivalent
  obtain ⟨transformationC, factorization⟩ :=
    separation hAB hAC hBC transformationBC transformationAC rawEquality
  refine ⟨transformationC, ?_⟩
  rw [factorization]
  exact theory.phenomenallyEquivalent_refl _

end Theories.NoSignallingTheory

namespace Faithfulness

open Theories

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Invertible dynamics survives the phenomenal quotient.  Quotient induction
uses a supplied representative; no representative is selected globally. -/
theorem phenomenalQuotient_invertibleDynamics
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    InvertibleDynamics (PhenomenalTransformation theory) := by
  intro A transformation
  refine Quotient.inductionOn transformation ?_
  intro representative
  obtain ⟨inverse, rightInverse, leftInverse⟩ := invertible A representative
  exact ⟨PhenomenalTransformation.mk theory inverse,
    congrArg (PhenomenalTransformation.mk theory) rightInverse,
    congrArg (PhenomenalTransformation.mk theory) leftInverse⟩

/-- Global transitivity survives because the state family is unchanged and a
raw witness acts exactly as its quotient class. -/
theorem phenomenalQuotient_globallyTransitive
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (transitive : theory.GloballyTransitive) :
    (phenomenalQuotientTheory theory).GloballyTransitive := by
  intro initial target
  obtain ⟨transformation, acts⟩ := transitive initial target
  exact ⟨PhenomenalTransformation.mk theory transformation, acts⟩

/-- Global transitivity is in fact reflected as well as preserved: every
quotient transformation has a representative, eliminated locally. -/
theorem phenomenalQuotient_globallyTransitive_iff
    (theory : NoSignallingTheory System Transformation PhenomenalState) :
    (phenomenalQuotientTheory theory).GloballyTransitive ↔
      theory.GloballyTransitive := by
  constructor
  · intro transitive initial target
    obtain ⟨transformation, acts⟩ := transitive initial target
    revert acts
    refine Quotient.inductionOn transformation ?_
    intro representative acts
    exact ⟨representative, acts⟩
  · exact phenomenalQuotient_globallyTransitive theory

/-- Repaired separation preservation: the quotient satisfies raw
transformation separation under the explicitly stronger modulo-equivalence
premise.  No theorem derives this premise from raw separation alone. -/
theorem phenomenalQuotient_transformationSeparation
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (separationModulo :
      theory.TransformationSeparationModuloPhenomenalEquivalence) :
    (phenomenalQuotientTheory theory).TransformationSeparation := by
  intro A B C hAB hAC hBC transformationBC transformationAC quotientEquality
  revert quotientEquality
  refine Quotient.inductionOn₂ transformationBC transformationAC ?_
  intro representativeBC representativeAC quotientEquality
  let rawLeft := theory.transformationProducts.product
    (1 : Transformation A) representativeBC
    (separated_composite_of_pairwise hAB hAC)
  let rawRight := reindex Transformation (NoSignallingTheory.swapFirstTwoPath A B C)
    (theory.transformationProducts.product (1 : Transformation B) representativeAC
      (separated_composite_of_pairwise hAB.symm hBC))
  change PhenomenalTransformation.mk theory rawLeft =
    reindex (PhenomenalTransformation theory)
      (NoSignallingTheory.swapFirstTwoPath A B C)
      (PhenomenalTransformation.mk theory
        (theory.transformationProducts.product (1 : Transformation B) representativeAC
          (separated_composite_of_pairwise hAB.symm hBC))) at quotientEquality
  rw [PhenomenalTransformation.reindex_mk] at quotientEquality
  have classEquality :
      PhenomenalTransformation.mk theory rawLeft =
        PhenomenalTransformation.mk theory rawRight := by
    exact quotientEquality
  have rawEquivalent : theory.PhenomenallyEquivalent rawLeft rawRight :=
    (theory.phenomenalCon (Composite A (Composite B C))).eq.mp classEquality
  obtain ⟨representativeC, factorization⟩ :=
    separationModulo hAB hAC hBC representativeBC representativeAC rawEquivalent
  refine ⟨PhenomenalTransformation.mk theory representativeC, ?_⟩
  change PhenomenalTransformation.mk theory rawLeft =
    reindex (PhenomenalTransformation theory) (sup_assoc A B C)
      (PhenomenalTransformation.mk theory
        (theory.transformationProducts.product
          (1 : Transformation (Composite A B)) representativeC
          (composite_separated_of_pairwise hAC hBC)))
  rw [PhenomenalTransformation.reindex_mk]
  exact (theory.phenomenalCon (Composite A (Composite B C))).eq.mpr factorization

end Faithfulness

end RR2021
