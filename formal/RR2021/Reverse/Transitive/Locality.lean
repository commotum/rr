import RR2021.Reverse.Transitive.Product
import RR2021.Dynamics.Locality

/-!
# Transitive reverse construction: compatibility preservation and locality

The existing no-signalling transformation product acts componentwise on the
constructed quotient-state product.  The main bookkeeping result factors its
canonical global extension into a local extension and an extension supported
on the complementary system.  Quotient projection then discards precisely
that complementary factor.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Equality transport of a local transformation is coherent with its
canonical global extension. -/
theorem extendSystem_reindex
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (indexEquality : A = B)
    (transformation : Transformation A) :
    extendSystem theory A transformation =
      extendSystem theory B
        (reindex Transformation indexEquality transformation) := by
  subst B
  rfl

omit [IndexedMonoid System Transformation] in
/-- Forward reindexing of the right input to a raw transformation product.
This is equality elimination, not a product naturality assumption. -/
theorem transformationProduct_reindex_right_forward
    (products : TransformationProduct System Transformation)
    {A B B' : System} (rightIndexEquality : B = B')
    (left : Transformation A) (right : Transformation B)
    (sourceSeparated : Separated A B) (targetSeparated : Separated A B') :
    reindex Transformation
        (congrArg (fun X => Composite A X) rightIndexEquality)
        (products.product left right sourceSeparated) =
      products.product left
        (reindex Transformation rightIndexEquality right) targetSeparated := by
  subst B'
  rfl

/-- The global extension of a separated transformation product differs from
the left local extension only by a transformation supported on the left
system's complement. -/
theorem extendProduct_factor_left
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (separated : Separated A B)
    (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) :
    ∃ remote : Transformation (complement A),
      extendSystem theory (Composite A B)
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) =
        extendComplement theory A remote *
          extendSystem theory A leftTransformation := by
  let C : System := complement (Composite A B)
  have separatedAC : Separated A C :=
    subsystem_separated_complement
      (show Subsystem A (Composite A B) from le_sup_left)
  have separatedBC : Separated B C :=
    subsystem_separated_complement
      (show Subsystem B (Composite A B) from le_sup_right)
  have separatedAB_C : Separated (Composite A B) C :=
    separated_complement (Composite A B)
  have separatedA_BC : Separated A (Composite B C) :=
    separated_composite_of_pairwise separated separatedAC
  let rightComplementPath : Composite B C = complement A :=
    right_composite_complement separated
  let remote : Transformation (complement A) :=
    reindex Transformation rightComplementPath
      (theory.transformationProducts.product rightTransformation
        (1 : Transformation C) separatedBC)
  refine ⟨remote, ?_⟩
  calc
    extendSystem theory (Composite A B)
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated) =
      reindex Transformation (composite_complement (Composite A B))
        (theory.transformationProducts.product
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated)
          (1 : Transformation C) separatedAB_C) := rfl
    _ = reindex Transformation
        ((sup_assoc A B C).trans (tripleGlobalPathViaLeft separated))
        (theory.transformationProducts.product
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated)
          (1 : Transformation C) separatedAB_C) :=
      reindex_path_independent Transformation _ _ _
    _ = reindex Transformation (tripleGlobalPathViaLeft separated)
        (reindex Transformation (sup_assoc A B C)
          (theory.transformationProducts.product
            (theory.transformationProducts.product
              leftTransformation rightTransformation separated)
            (1 : Transformation C) separatedAB_C)) := by
      rw [reindex_comp]
    _ = reindex Transformation (tripleGlobalPathViaLeft separated)
        (theory.transformationProducts.product leftTransformation
          (theory.transformationProducts.product rightTransformation
            (1 : Transformation C) separatedBC)
          separatedA_BC) := by
      apply congrArg (reindex Transformation (tripleGlobalPathViaLeft separated))
      exact theory.productAssociative separated separatedAC separatedBC
        leftTransformation rightTransformation (1 : Transformation C)
    _ = reindex Transformation (composite_complement A)
        (reindex Transformation
          (congrArg (fun X => Composite A X) rightComplementPath)
          (theory.transformationProducts.product leftTransformation
            (theory.transformationProducts.product rightTransformation
              (1 : Transformation C) separatedBC)
            separatedA_BC)) := by
      unfold tripleGlobalPathViaLeft rightComplementPath
      rw [reindex_comp]
    _ = reindex Transformation (composite_complement A)
        (theory.transformationProducts.product leftTransformation remote
          (separated_complement A)) := by
      apply congrArg (reindex Transformation (composite_complement A))
      exact transformationProduct_reindex_right_forward
        theory.transformationProducts rightComplementPath leftTransformation
        (theory.transformationProducts.product rightTransformation
          (1 : Transformation C) separatedBC)
        separatedA_BC (separated_complement A)
    _ = reindex Transformation (composite_complement A)
        (theory.transformationProducts.product leftTransformation
            (1 : Transformation (complement A)) (separated_complement A) *
          theory.transformationProducts.product (1 : Transformation A)
            remote (separated_complement A)) := by
      apply congrArg (reindex Transformation (composite_complement A))
      calc
        theory.transformationProducts.product leftTransformation remote
            (separated_complement A) =
          theory.transformationProducts.product
            (leftTransformation * 1) (1 * remote)
            (separated_complement A) := by simp
        _ = theory.transformationProducts.product leftTransformation
              (1 : Transformation (complement A)) (separated_complement A) *
            theory.transformationProducts.product (1 : Transformation A)
              remote (separated_complement A) :=
          (theory.productMultiplicative (separated_complement A)
            leftTransformation 1 1 remote).symm
    _ = extendSystem theory A leftTransformation *
        extendComplement theory A remote := by
      rw [reindex_mul]
      rfl
    _ = extendComplement theory A remote *
        extendSystem theory A leftTransformation :=
      extendSystem_extendComplement_commute theory A leftTransformation remote

/-- Symmetric factorization at the right subsystem. -/
theorem extendProduct_factor_right
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (separated : Separated A B)
    (leftTransformation : Transformation A)
    (rightTransformation : Transformation B) :
    ∃ remote : Transformation (complement B),
      extendSystem theory (Composite A B)
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) =
        extendComplement theory B remote *
          extendSystem theory B rightTransformation := by
  obtain ⟨remote, factorization⟩ :=
    extendProduct_factor_left theory separated.symm
      rightTransformation leftTransformation
  refine ⟨remote, ?_⟩
  calc
    extendSystem theory (Composite A B)
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated) =
      extendSystem theory (Composite B A)
        (reindex Transformation (sup_comm A B)
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated)) :=
      extendSystem_reindex theory (sup_comm A B)
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated)
    _ = extendSystem theory (Composite B A)
        (theory.transformationProducts.product
          rightTransformation leftTransformation separated.symm) := by
      rw [theory.productSymmetric separated leftTransformation rightTransformation]
    _ = extendComplement theory B remote *
        extendSystem theory B rightTransformation := factorization

namespace NoumenalState

/-- The left quotient projection of the product action is the local action on
the left quotient projection. -/
theorem project_smul_product_left
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (separated : Separated A B)
    (leftTransformation : Transformation A)
    (rightTransformation : Transformation B)
    (whole : NoumenalState theory invertible (Composite A B)) :
    project theory invertible
        (show Subsystem A (Composite A B) from le_sup_left)
        (smul theory invertible
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) whole) =
      smul theory invertible leftTransformation
        (project theory invertible
          (show Subsystem A (Composite A B) from le_sup_left) whole) := by
  refine Quotient.inductionOn whole ?_
  intro representative
  change mk theory invertible A
      (extendSystem theory (Composite A B)
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated) * representative) =
    mk theory invertible A
      (extendSystem theory A leftTransformation * representative)
  apply (mk_eq_mk_iff theory invertible A _ _).2
  obtain ⟨remote, factorization⟩ :=
    extendProduct_factor_left theory separated
      leftTransformation rightTransformation
  refine ⟨remote, ?_⟩
  calc
    extendSystem theory (Composite A B)
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) * representative =
      (extendComplement theory A remote *
        extendSystem theory A leftTransformation) * representative := by
          rw [factorization]
    _ = extendComplement theory A remote *
        (extendSystem theory A leftTransformation * representative) :=
      mul_assoc _ _ _

/-- The analogous right quotient projection equation. -/
theorem project_smul_product_right
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (separated : Separated A B)
    (leftTransformation : Transformation A)
    (rightTransformation : Transformation B)
    (whole : NoumenalState theory invertible (Composite A B)) :
    project theory invertible
        (show Subsystem B (Composite A B) from le_sup_right)
        (smul theory invertible
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) whole) =
      smul theory invertible rightTransformation
        (project theory invertible
          (show Subsystem B (Composite A B) from le_sup_right) whole) := by
  refine Quotient.inductionOn whole ?_
  intro representative
  change mk theory invertible B
      (extendSystem theory (Composite A B)
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated) * representative) =
    mk theory invertible B
      (extendSystem theory B rightTransformation * representative)
  apply (mk_eq_mk_iff theory invertible B _ _).2
  obtain ⟨remote, factorization⟩ :=
    extendProduct_factor_right theory separated
      leftTransformation rightTransformation
  refine ⟨remote, ?_⟩
  calc
    extendSystem theory (Composite A B)
          (theory.transformationProducts.product
            leftTransformation rightTransformation separated) * representative =
      (extendComplement theory B remote *
        extendSystem theory B rightTransformation) * representative := by
          rw [factorization]
    _ = extendComplement theory B remote *
        (extendSystem theory B rightTransformation * representative) :=
      mul_assoc _ _ _

/-- Theorem 5.10's hidden definedness obligation: the separated product
transformation maps compatible quotient factors to compatible quotient
factors. -/
def mapCompatible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (leftTransformation : Transformation A)
    (rightTransformation : Transformation B)
    (left : NoumenalState theory invertible A)
    (right : NoumenalState theory invertible B)
    (compatible : Compatible (projectors theory invertible) left right) :
    Compatible (projectors theory invertible)
      (smul theory invertible leftTransformation left)
      (smul theory invertible rightTransformation right) := by
  obtain ⟨separated, whole, whole_left, whole_right⟩ := compatible
  refine ⟨separated,
    smul theory invertible
      (theory.transformationProducts.product
        leftTransformation rightTransformation separated) whole, ?_, ?_⟩
  · calc
      (projectors theory invertible).projectLeft
          (smul theory invertible
            (theory.transformationProducts.product
              leftTransformation rightTransformation separated) whole) =
        smul theory invertible leftTransformation
          ((projectors theory invertible).projectLeft whole) := by
            simpa only [ProjectorFamily.projectLeft, projectors] using
              project_smul_product_left theory invertible separated
                leftTransformation rightTransformation whole
      _ = smul theory invertible leftTransformation left :=
        congrArg (smul theory invertible leftTransformation) whole_left
  · calc
      (projectors theory invertible).projectRight
          (smul theory invertible
            (theory.transformationProducts.product
              leftTransformation rightTransformation separated) whole) =
        smul theory invertible rightTransformation
          ((projectors theory invertible).projectRight whole) := by
            simpa only [ProjectorFamily.projectRight, projectors] using
              project_smul_product_right theory invertible separated
                leftTransformation rightTransformation whole
      _ = smul theory invertible rightTransformation right :=
        congrArg (smul theory invertible rightTransformation) whole_right

/-- Theorem 5.10 packaged as the stable `Locality` interface.  The original
transformation product acts componentwise on the unique-choice realization of
the quotient-state product. -/
noncomputable def locality
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation) :
    @Locality System _ _ Transformation (NoumenalState theory invertible)
      _ (indexedMulAction theory invertible)
      (projectors theory invertible)
      (stateProduct theory invertible transformationSeparation)
      theory.transformationProducts where
  mapCompatible := mapCompatible theory invertible
  act_product := by
    intro A B leftTransformation rightTransformation left right separated compatible
    let products := stateProduct theory invertible transformationSeparation
    let originalWhole := products.product left right separated compatible
    let transformedWhole :=
      smul theory invertible
        (theory.transformationProducts.product
          leftTransformation rightTransformation separated) originalWhole
    have transformed_left :
        (projectors theory invertible).projectLeft transformedWhole =
          smul theory invertible leftTransformation left := by
      dsimp only [transformedWhole]
      calc
        (projectors theory invertible).projectLeft
            (smul theory invertible
              (theory.transformationProducts.product
                leftTransformation rightTransformation separated)
              originalWhole) =
          smul theory invertible leftTransformation
            ((projectors theory invertible).projectLeft originalWhole) := by
              simpa only [ProjectorFamily.projectLeft, projectors] using
                project_smul_product_left theory invertible separated
                  leftTransformation rightTransformation originalWhole
        _ = smul theory invertible leftTransformation left :=
          congrArg (smul theory invertible leftTransformation)
            (products.project_left left right separated compatible)
    have transformed_right :
        (projectors theory invertible).projectRight transformedWhole =
          smul theory invertible rightTransformation right := by
      dsimp only [transformedWhole]
      calc
        (projectors theory invertible).projectRight
            (smul theory invertible
              (theory.transformationProducts.product
                leftTransformation rightTransformation separated)
              originalWhole) =
          smul theory invertible rightTransformation
            ((projectors theory invertible).projectRight originalWhole) := by
              simpa only [ProjectorFamily.projectRight, projectors] using
                project_smul_product_right theory invertible separated
                  leftTransformation rightTransformation originalWhole
        _ = smul theory invertible rightTransformation right :=
          congrArg (smul theory invertible rightTransformation)
            (products.project_right left right separated compatible)
    change transformedWhole =
      products.product
        (smul theory invertible leftTransformation left)
        (smul theory invertible rightTransformation right) separated _
    exact (products.product_eq_common_extension
      (smul theory invertible leftTransformation left)
      (smul theory invertible rightTransformation right) separated _
      transformedWhole transformed_left transformed_right).symm

end NoumenalState

end RR2021.Reverse.Transitive
