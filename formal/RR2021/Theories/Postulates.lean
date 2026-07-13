import RR2021.Theories.NoSignalling

/-!
# Operational theories: reverse-construction postulates

Postulates 4.1--4.4 and their immediate inverse-product consequences are
isolated here.  The forward construction deliberately does not import this
module.
-/

namespace RR2021.Theories

open RR2021.Systems RR2021.Dynamics

universe u v w

/-- Postulate 4.2, relative to the multiplication and identity already fixed
by the indexed monoid family.  Only existence is stored; no inverse is chosen. -/
def InvertibleDynamics {System : Type u}
    (Transformation : System → Type v)
    [IndexedMonoid System Transformation] : Prop :=
  ∀ (A : System) (transformation : Transformation A),
    ∃ inverse : Transformation A,
      transformation * inverse = 1 ∧ inverse * transformation = 1

namespace NoSignallingTheory

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- The explicit permutation path from `B ⊔ (A ⊔ C)` to
`A ⊔ (B ⊔ C)` used to type Postulate 4.1. -/
def swapFirstTwoPath (A B C : System) :
    Composite B (Composite A C) = Composite A (Composite B C) :=
  (sup_assoc B A C).symm.trans <|
    (congrArg (fun X => Composite X C) (sup_comm B A)).trans
      (sup_assoc A B C)

/-- Corrected Definition 4.1: identity-extended transformations agree on
every phenomenal state of every separated extension.  The source's unused
quantifier over a remote transformation is omitted (`RR-C007`). -/
def PhenomenallyEquivalent
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A : System} (left right : Transformation A) : Prop :=
  ∀ {B : System} (hsep : Separated A B)
    (state : PhenomenalState (Composite A B)),
    theory.transformationProducts.product left (1 : Transformation B) hsep • state =
      theory.transformationProducts.product right (1 : Transformation B) hsep • state

/-- Postulate 4.3, kept separate from the definition of a no-signalling theory. -/
def PhenomenallyFaithful
    (theory : NoSignallingTheory System Transformation PhenomenalState) : Prop :=
  ∀ (A : System) (left right : Transformation A),
    theory.PhenomenallyEquivalent left right → left = right

/-- Postulate 4.4: the action is transitive only on the global phenomenal
state space. -/
def GloballyTransitive
    (_theory : NoSignallingTheory System Transformation PhenomenalState) : Prop :=
  ∀ initial target : PhenomenalState globalSystem,
    ∃ transformation : Transformation globalSystem,
      transformation • initial = target

/--
Postulate 4.1 with all pairwise separation and indexed transports exposed.
The premise compares `I_A × V_BC` with `I_B × V_AC` at the canonical index
`A ⊔ (B ⊔ C)`.  The conclusion factors their common value as
`I_AB × V_C`, transported from `(A ⊔ B) ⊔ C` to that same index.
-/
def TransformationSeparation
    (theory : NoSignallingTheory System Transformation PhenomenalState) : Prop :=
  ∀ {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (transformationBC : Transformation (Composite B C))
    (transformationAC : Transformation (Composite A C)),
    theory.transformationProducts.product (1 : Transformation A) transformationBC
        (separated_composite_of_pairwise hAB hAC) =
      reindex Transformation (swapFirstTwoPath A B C)
        (theory.transformationProducts.product (1 : Transformation B) transformationAC
          (separated_composite_of_pairwise hAB.symm hBC)) →
    ∃ transformationC : Transformation C,
      theory.transformationProducts.product (1 : Transformation A) transformationBC
          (separated_composite_of_pairwise hAB hAC) =
        reindex Transformation (sup_assoc A B C)
          (theory.transformationProducts.product
            (1 : Transformation (Composite A B)) transformationC
            (composite_separated_of_pairwise hAC hBC))

/-- Theorem 4.1 at the property level: products of selected component inverses
are two-sided inverses.  Only multiplicativity and unitality are used. -/
theorem productOfInverses
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hsep : Separated A B)
    (left leftInverse : Transformation A)
    (right rightInverse : Transformation B)
    (left_mul : left * leftInverse = 1)
    (leftInverse_mul : leftInverse * left = 1)
    (right_mul : right * rightInverse = 1)
    (rightInverse_mul : rightInverse * right = 1) :
    theory.transformationProducts.product left right hsep *
        theory.transformationProducts.product leftInverse rightInverse hsep = 1 ∧
      theory.transformationProducts.product leftInverse rightInverse hsep *
          theory.transformationProducts.product left right hsep = 1 := by
  constructor
  · calc
      theory.transformationProducts.product left right hsep *
          theory.transformationProducts.product leftInverse rightInverse hsep =
        theory.transformationProducts.product (left * leftInverse)
          (right * rightInverse) hsep :=
        theory.productMultiplicative hsep left leftInverse right rightInverse
      _ = theory.transformationProducts.product 1 1 hsep := by
        rw [left_mul, right_mul]
      _ = 1 := theory.productUnital hsep
  · calc
      theory.transformationProducts.product leftInverse rightInverse hsep *
          theory.transformationProducts.product left right hsep =
        theory.transformationProducts.product (leftInverse * left)
          (rightInverse * right) hsep :=
        theory.productMultiplicative hsep leftInverse left rightInverse right
      _ = theory.transformationProducts.product 1 1 hsep := by
        rw [leftInverse_mul, rightInverse_mul]
      _ = 1 := theory.productUnital hsep

/-- Exact uniqueness form of Theorem 4.1: any two-sided inverse of the product
is the product of the selected component inverses. -/
theorem productInverse_eq
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    {A B : System} (hsep : Separated A B)
    (left leftInverse : Transformation A)
    (right rightInverse : Transformation B)
    (left_mul : left * leftInverse = 1)
    (leftInverse_mul : leftInverse * left = 1)
    (right_mul : right * rightInverse = 1)
    (rightInverse_mul : rightInverse * right = 1)
    (compositeInverse : Transformation (Composite A B))
    (compositeInverse_mul :
      compositeInverse *
        theory.transformationProducts.product left right hsep = 1) :
    compositeInverse =
      theory.transformationProducts.product leftInverse rightInverse hsep := by
  have product_mul_inverse :=
    (theory.productOfInverses hsep left leftInverse right rightInverse
      left_mul leftInverse_mul right_mul rightInverse_mul).1
  calc
    compositeInverse = compositeInverse * 1 := (mul_one compositeInverse).symm
    _ = compositeInverse *
        (theory.transformationProducts.product left right hsep *
          theory.transformationProducts.product leftInverse rightInverse hsep) := by
      rw [product_mul_inverse]
    _ = (compositeInverse *
          theory.transformationProducts.product left right hsep) *
        theory.transformationProducts.product leftInverse rightInverse hsep :=
      (mul_assoc compositeInverse
        (theory.transformationProducts.product left right hsep)
        (theory.transformationProducts.product leftInverse rightInverse hsep)).symm
    _ = 1 * theory.transformationProducts.product leftInverse rightInverse hsep :=
      congrArg
        (fun value =>
          value * theory.transformationProducts.product leftInverse rightInverse hsep)
        compositeInverse_mul
    _ = theory.transformationProducts.product leftInverse rightInverse hsep :=
      one_mul _

/-- Postulate 4.2 is closed under separated transformation products, without
selecting global inverse functions. -/
theorem productInvertible
    (theory : NoSignallingTheory System Transformation PhenomenalState)
    (invertible : InvertibleDynamics Transformation)
    {A B : System} (hsep : Separated A B)
    (left : Transformation A) (right : Transformation B) :
    ∃ inverse : Transformation (Composite A B),
      theory.transformationProducts.product left right hsep * inverse = 1 ∧
        inverse * theory.transformationProducts.product left right hsep = 1 := by
  obtain ⟨leftInverse, left_mul, leftInverse_mul⟩ := invertible A left
  obtain ⟨rightInverse, right_mul, rightInverse_mul⟩ := invertible B right
  exact ⟨theory.transformationProducts.product leftInverse rightInverse hsep,
    theory.productOfInverses hsep left leftInverse right rightInverse
      left_mul leftInverse_mul right_mul rightInverse_mul⟩

end NoSignallingTheory

end RR2021.Theories
