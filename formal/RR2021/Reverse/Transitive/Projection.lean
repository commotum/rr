import RR2021.Reverse.Transitive.Relation

/-!
# Transitive reverse construction: quotient projectors

Theorem 5.2 is proved with the corrected relative complement
`Aᶜ ⊓ B`.  Its three separatedness obligations and both paths to the
global system remain explicit.  The quotient projector is then identity on
global representatives, with representative independence supplied exactly by
that theorem.
-/

namespace RR2021.Reverse.Transitive

open RR2021.Systems RR2021.Dynamics RR2021.Theories RR2021.Reverse

universe u v w

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

namespace FundamentallyEquivalent

/-- Reindexing the left input system of a separated transformation product
reindexes its output along the induced composite equality. -/
private theorem reindex_product_left
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A A' B : System} (indexEq : A = A')
    (left : Transformation A) (right : Transformation B)
    (hsep : Separated A B) (hsep' : Separated A' B) :
    reindex Transformation
        (congrArg (fun X => Composite X B) indexEq)
        (theory.transformationProducts.product left right hsep) =
      theory.transformationProducts.product
        (reindex Transformation indexEq left) right hsep' := by
  subst A'
  simp only [reindex_id]

/-- Reindexing the right input system of a separated transformation product
reindexes its output along the induced composite equality. -/
private theorem reindex_product_right
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B B' : System} (indexEq : B = B')
    (left : Transformation A) (right : Transformation B)
    (hsep : Separated A B) (hsep' : Separated A B') :
    reindex Transformation
        (congrArg (fun X => Composite A X) indexEq)
        (theory.transformationProducts.product left right hsep) =
      theory.transformationProducts.product left
        (reindex Transformation indexEq right) hsep' := by
  subst B'
  simp only [reindex_id]

/-- Corrected Theorem 5.2 (`RR-C009`): equivalence at a containing system
implies equivalence at every subsystem.  The complementary witness is the
product of the identity on `Aᶜ ⊓ B` with the original witness on `Bᶜ`,
transported to `Aᶜ`.

No invertibility, transformation separation, phenomenal faithfulness, or
global transitivity is used here. -/
theorem mono
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hAB : Subsystem A B)
    {left right : Transformation globalSystem}
    (equivalent : FundamentallyEquivalent theory B left right) :
    FundamentallyEquivalent theory A left right := by
  obtain ⟨remoteB, left_eq⟩ := equivalent
  let C : System := relativeComplement A B
  have hA_Bc : Separated A (complement B) :=
    subsystem_separated_complement hAB
  have hC_Bc : Separated C (complement B) := by
    exact relativeComplement_separated_complement A B
  have hA_C : Separated A C := by
    exact relativeComplement_disjoint A B
  have hAC_B : Composite A C = B := composite_relativeComplement hAB
  have hCBc_Ac : Composite C (complement B) = complement A :=
    relativeComplement_composite_complement hAB
  let remoteA : Transformation (complement A) :=
    reindex Transformation hCBc_Ac
      (theory.transformationProducts.product
        (1 : Transformation C) remoteB hC_Bc)
  let triple : Transformation
      (Composite (Composite A C) (complement B)) :=
    theory.transformationProducts.product
      (theory.transformationProducts.product
        (1 : Transformation A) (1 : Transformation C) hA_C)
      remoteB (composite_separated_of_pairwise hA_Bc hC_Bc)

  have viaB :
      reindex Transformation (relativeComplementTopPathViaB hAB) triple =
        extendComplement theory B remoteB := by
    calc
      reindex Transformation (relativeComplementTopPathViaB hAB) triple =
          reindex Transformation (composite_complement B)
            (reindex Transformation
              (congrArg (fun X => Composite X (complement B)) hAC_B)
              triple) := by
        exact (reindex_comp Transformation
          (congrArg (fun X => Composite X (complement B)) hAC_B)
          (composite_complement B) triple).symm
      _ = reindex Transformation (composite_complement B)
          (theory.transformationProducts.product
            (reindex Transformation hAC_B
              (theory.transformationProducts.product
                (1 : Transformation A) (1 : Transformation C) hA_C))
            remoteB (separated_complement B)) := by
        apply congrArg (reindex Transformation (composite_complement B))
        exact reindex_product_left theory hAC_B
          (theory.transformationProducts.product
            (1 : Transformation A) (1 : Transformation C) hA_C)
          remoteB (composite_separated_of_pairwise hA_Bc hC_Bc)
          (separated_complement B)
      _ = reindex Transformation (composite_complement B)
          (theory.transformationProducts.product
            (1 : Transformation B) remoteB (separated_complement B)) := by
        rw [theory.productUnital hA_C, reindex_one]
      _ = extendComplement theory B remoteB := rfl

  have viaA :
      reindex Transformation (relativeComplementTopPathViaA hAB) triple =
        extendComplement theory A remoteA := by
    let hA_CBc : Separated A (Composite C (complement B)) :=
      separated_composite_of_pairwise hA_C hA_Bc
    calc
      reindex Transformation (relativeComplementTopPathViaA hAB) triple =
          reindex Transformation (composite_complement A)
            (reindex Transformation
              (congrArg (fun X => Composite A X) hCBc_Ac)
              (reindex Transformation (sup_assoc A C (complement B))
                triple)) := by
        rw [reindex_comp, reindex_comp]
      _ = reindex Transformation (composite_complement A)
          (reindex Transformation
            (congrArg (fun X => Composite A X) hCBc_Ac)
            (theory.transformationProducts.product
              (1 : Transformation A)
              (theory.transformationProducts.product
                (1 : Transformation C) remoteB hC_Bc)
              hA_CBc)) := by
        apply congrArg (reindex Transformation (composite_complement A))
        apply congrArg
          (reindex Transformation
            (congrArg (fun X => Composite A X) hCBc_Ac))
        exact theory.productAssociative hA_C hA_Bc hC_Bc
          (1 : Transformation A) (1 : Transformation C) remoteB
      _ = reindex Transformation (composite_complement A)
          (theory.transformationProducts.product
            (1 : Transformation A) remoteA (separated_complement A)) := by
        apply congrArg (reindex Transformation (composite_complement A))
        exact reindex_product_right theory hCBc_Ac
          (1 : Transformation A)
          (theory.transformationProducts.product
            (1 : Transformation C) remoteB hC_Bc)
          hA_CBc (separated_complement A)
      _ = extendComplement theory A remoteA := rfl

  have extensions_equal :
      extendComplement theory A remoteA = extendComplement theory B remoteB := by
    calc
      extendComplement theory A remoteA =
          reindex Transformation (relativeComplementTopPathViaA hAB) triple :=
        viaA.symm
      _ = reindex Transformation (relativeComplementTopPathViaB hAB) triple :=
        (reindexRelativeComplement_top_coherent
          Transformation hAB triple).symm
      _ = extendComplement theory B remoteB := viaB
  refine ⟨remoteA, ?_⟩
  rw [extensions_equal]
  exact left_eq

end FundamentallyEquivalent

namespace NoumenalState

/-- Definition 5.4: a quotient state at `B` projects to the class of the same
global representative at `A`.  Theorem 5.2 is exactly the map congruence. -/
def project
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B) :
    NoumenalState theory invertible B → NoumenalState theory invertible A :=
  Quotient.map id (fun {_ _} equivalent =>
    FundamentallyEquivalent.mono theory hAB equivalent)

@[simp]
theorem project_mk
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hAB : Subsystem A B)
    (transformation : Transformation globalSystem) :
    project theory invertible hAB
        (mk theory invertible B transformation) =
      mk theory invertible A transformation :=
  rfl

/-- The constructed quotient projectors, with nesting proved on raw global
representatives rather than by quotient representative selection. -/
def projectors
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    ProjectorFamily System (NoumenalState theory invertible) where
  project := project theory invertible
  nested := by
    intro A B C hAB hBC state
    induction state using Quotient.inductionOn with
    | _ representative => rfl

/-- Theorem 5.3: every quotient projector is surjective, because any class at
`A` is the projection of the class of the same global representative at `B`. -/
theorem projectors_surjective
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation) :
    (projectors theory invertible).Surjective := by
  intro A B hAB state
  induction state using Quotient.inductionOn with
  | _ representative =>
      exact ⟨mk theory invertible B representative, rfl⟩

end NoumenalState

end RR2021.Reverse.Transitive
