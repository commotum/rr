import RR2021.Reverse.Transitive.Relation

/-!
# Transitive reverse construction: intersection of fundamental relations

Theorem 5.8 is the key representative-independence result for the later
noumenal product.  The source suppresses all transports among the three
presentations of the global system; they are explicit here.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w x

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

omit [BooleanAlgebra System] in
/-- Reindexing along an equality is injective. -/
theorem reindex_injective {Family : System → Sort x} {A B : System}
    (indexEquality : A = B) : Function.Injective (reindex Family indexEquality) := by
  intro left right equality
  have transported := congrArg (reindex Family indexEquality.symm) equality
  simpa only [reindex_inverse] using transported

omit [IndexedMonoid System Transformation] in
/-- Reindexing the right input system of a raw transformation product agrees
with reindexing the resulting composite.  This is equality elimination, not
an additional naturality postulate. -/
theorem transformationProduct_reindex_right
    (products : TransformationProduct System Transformation)
    {A B B' : System} (rightIndexEquality : B = B')
    (left : Transformation A) (right : Transformation B')
    (sourceSeparated : Separated A B) (targetSeparated : Separated A B') :
    reindex Transformation
        (congrArg (fun X => Composite A X) rightIndexEquality)
        (products.product left
          (reindex Transformation rightIndexEquality.symm right)
          sourceSeparated) =
      products.product left right targetSeparated := by
  subst B'
  simp only [reindex_id]

/-- The path from `A ⊔ (B ⊔ (A ⊔ B)ᶜ)` to the global system obtained by first
recognizing `B ⊔ (A ⊔ B)ᶜ` as `Aᶜ`. -/
def tripleGlobalPathViaLeft {A B : System} (separated : Separated A B) :
    Composite A (Composite B (complement (Composite A B))) = globalSystem :=
  (congrArg (fun X => Composite A X)
    (right_composite_complement separated)).trans (composite_complement A)

/-- The path from `B ⊔ (A ⊔ (A ⊔ B)ᶜ)` to the global system obtained by first
recognizing `A ⊔ (A ⊔ B)ᶜ` as `Bᶜ`. -/
def tripleGlobalPathViaRight {A B : System} (separated : Separated A B) :
    Composite B (Composite A (complement (Composite A B))) = globalSystem :=
  (congrArg (fun X => Composite B X)
    (left_composite_complement separated)).trans (composite_complement B)

/-- A complementary extension at `A` can be presented on the canonical
three-system index `A ⊔ (B ⊔ (A ⊔ B)ᶜ)`. -/
theorem reindex_tripleProduct_eq_extendComplement_left
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (separated : Separated A B)
    (remote : Transformation (complement A)) :
    reindex Transformation (tripleGlobalPathViaLeft separated)
        (theory.transformationProducts.product (1 : Transformation A)
          (reindex Transformation (right_composite_complement separated).symm remote)
          (separated_composite_of_pairwise separated
            (subsystem_separated_complement
              (show Subsystem A (Composite A B) from le_sup_left)))) =
      extendComplement theory A remote := by
  unfold tripleGlobalPathViaLeft extendComplement
  calc
    reindex Transformation
        ((congrArg (fun X => Composite A X)
          (right_composite_complement separated)).trans
          (composite_complement A)) _ =
      reindex Transformation (composite_complement A)
        (reindex Transformation
          (congrArg (fun X => Composite A X)
            (right_composite_complement separated)) _) :=
        (reindex_comp Transformation _ _ _).symm
    _ = reindex Transformation (composite_complement A)
        (theory.transformationProducts.product (1 : Transformation A) remote
          (separated_complement A)) := by
      apply congrArg (reindex Transformation (composite_complement A))
      exact transformationProduct_reindex_right theory.transformationProducts
        (right_composite_complement separated) (1 : Transformation A) remote
        (separated_composite_of_pairwise separated
          (subsystem_separated_complement
            (show Subsystem A (Composite A B) from le_sup_left)))
        (separated_complement A)

/-- The analogous canonical three-system presentation at `B`. -/
theorem reindex_tripleProduct_eq_extendComplement_right
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (separated : Separated A B)
    (remote : Transformation (complement B)) :
    reindex Transformation (tripleGlobalPathViaRight separated)
        (theory.transformationProducts.product (1 : Transformation B)
          (reindex Transformation (left_composite_complement separated).symm remote)
          (separated_composite_of_pairwise separated.symm
            (subsystem_separated_complement
              (show Subsystem B (Composite A B) from le_sup_right)))) =
      extendComplement theory B remote := by
  unfold tripleGlobalPathViaRight extendComplement
  calc
    reindex Transformation
        ((congrArg (fun X => Composite B X)
          (left_composite_complement separated)).trans
          (composite_complement B)) _ =
      reindex Transformation (composite_complement B)
        (reindex Transformation
          (congrArg (fun X => Composite B X)
            (left_composite_complement separated)) _) :=
        (reindex_comp Transformation _ _ _).symm
    _ = reindex Transformation (composite_complement B)
        (theory.transformationProducts.product (1 : Transformation B) remote
          (separated_complement B)) := by
      apply congrArg (reindex Transformation (composite_complement B))
      exact transformationProduct_reindex_right theory.transformationProducts
        (left_composite_complement separated) (1 : Transformation B) remote
        (separated_composite_of_pairwise separated.symm
          (subsystem_separated_complement
            (show Subsystem B (Composite A B) from le_sup_right)))
        (separated_complement B)

omit [BooleanAlgebra System] in
/-- Right cancellation obtained from the existential invertibility postulate;
no cancellative monoid or selected global inverse is assumed. -/
theorem right_cancel_of_invertible
    (invertible : InvertibleDynamics Transformation)
    {A : System} {left middle right : Transformation A}
    (equality : left * right = middle * right) : left = middle := by
  obtain ⟨rightInverse, right_mul, _⟩ := invertible A right
  calc
    left = left * 1 := (mul_one left).symm
    _ = left * (right * rightInverse) := by rw [right_mul]
    _ = (left * right) * rightInverse :=
      (mul_assoc left right rightInverse).symm
    _ = (middle * right) * rightInverse := by rw [equality]
    _ = middle * (right * rightInverse) := mul_assoc middle right rightInverse
    _ = middle * 1 := by rw [right_mul]
    _ = middle := mul_one middle

/-- Theorem 5.8: agreement modulo the complements of both separated factors
implies agreement modulo the complement of their composite. -/
theorem FundamentallyEquivalent.intersection
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    (transformationSeparation : theory.TransformationSeparation)
    {A B : System} (separated : Separated A B)
    {left right : Transformation globalSystem}
    (equivalentLeft : FundamentallyEquivalent theory A left right)
    (equivalentRight : FundamentallyEquivalent theory B left right) :
    FundamentallyEquivalent theory (Composite A B) left right := by
  obtain ⟨remoteLeft, left_eq⟩ := equivalentLeft
  obtain ⟨remoteRight, right_eq⟩ := equivalentRight
  have extensions_equal :
      extendComplement theory A remoteLeft =
        extendComplement theory B remoteRight := by
    apply right_cancel_of_invertible invertible
    rw [← left_eq, ← right_eq]

  let C := complement (Composite A B)
  let transformationBC : Transformation (Composite B C) :=
    reindex Transformation (right_composite_complement separated).symm remoteLeft
  let transformationAC : Transformation (Composite A C) :=
    reindex Transformation (left_composite_complement separated).symm remoteRight
  have separatedAC : Separated A C :=
    subsystem_separated_complement
      (show Subsystem A (Composite A B) from le_sup_left)
  have separatedBC : Separated B C :=
    subsystem_separated_complement
      (show Subsystem B (Composite A B) from le_sup_right)

  have separationPremise :
      theory.transformationProducts.product (1 : Transformation A) transformationBC
          (separated_composite_of_pairwise separated separatedAC) =
        reindex Transformation (NoSignallingTheory.swapFirstTwoPath A B C)
          (theory.transformationProducts.product (1 : Transformation B)
            transformationAC
            (separated_composite_of_pairwise separated.symm separatedBC)) := by
    apply reindex_injective (Family := Transformation)
      (tripleGlobalPathViaLeft separated)
    calc
      reindex Transformation (tripleGlobalPathViaLeft separated)
          (theory.transformationProducts.product (1 : Transformation A)
            transformationBC
            (separated_composite_of_pairwise separated separatedAC)) =
        extendComplement theory A remoteLeft := by
          exact reindex_tripleProduct_eq_extendComplement_left theory separated remoteLeft
      _ = extendComplement theory B remoteRight := extensions_equal
      _ = reindex Transformation (tripleGlobalPathViaRight separated)
          (theory.transformationProducts.product (1 : Transformation B)
            transformationAC
            (separated_composite_of_pairwise separated.symm separatedBC)) := by
          exact (reindex_tripleProduct_eq_extendComplement_right
            theory separated remoteRight).symm
      _ = reindex Transformation (tripleGlobalPathViaLeft separated)
          (reindex Transformation (NoSignallingTheory.swapFirstTwoPath A B C)
            (theory.transformationProducts.product (1 : Transformation B)
              transformationAC
              (separated_composite_of_pairwise separated.symm separatedBC))) := by
          rw [reindex_comp]

  obtain ⟨remoteComposite, separationConclusion⟩ :=
    transformationSeparation separated separatedAC separatedBC
      transformationBC transformationAC separationPremise
  refine ⟨remoteComposite, ?_⟩
  calc
    left = extendComplement theory A remoteLeft * right := left_eq
    _ = reindex Transformation (tripleGlobalPathViaLeft separated)
          (theory.transformationProducts.product (1 : Transformation A)
            transformationBC
            (separated_composite_of_pairwise separated separatedAC)) * right := by
          rw [reindex_tripleProduct_eq_extendComplement_left theory separated remoteLeft]
    _ = reindex Transformation (tripleGlobalPathViaLeft separated)
          (reindex Transformation (sup_assoc A B C)
            (theory.transformationProducts.product
              (1 : Transformation (Composite A B)) remoteComposite
              (composite_separated_of_pairwise separatedAC separatedBC))) * right := by
          rw [separationConclusion]
    _ = extendComplement theory (Composite A B) remoteComposite * right := by
      congr 1
      unfold extendComplement C
      rw [reindex_comp]

end RR2021.Reverse.Transitive
