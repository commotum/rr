import RR2021.Forward.Examples
import RR2021.Faithfulness.Noumenal
import RR2021.Faithfulness.PhenomenalPreservation

/-!
# Faithfulness-quotient regressions

The forward-stage natural-number model has a deliberately trivial and hence
non-effective action.  It is a useful boundary check that distinct raw
transformations collapse in the noumenal quotient and that the Appendix B
constructor nevertheless returns a full local-realistic theory.
-/

namespace RR2021.Faithfulness.Examples

open RR2021.Systems RR2021.Dynamics RR2021.Theories
open RR2021.Forward.Examples

local instance nonfaithfulIndexedMonoid :
    IndexedMonoid ExampleSystem NonfaithfulTransformation where
  monoid _ := inferInstance

local instance nonfaithfulBoolAction : MulAction Nat Bool where
  smul _ state := state
  one_smul _ := rfl
  mul_smul _ _ _ := rfl

local instance nonfaithfulIndexedAction :
    IndexedMulAction ExampleSystem NonfaithfulTransformation ExampleState where
  mulAction _ := inferInstance

/-- The two representatives really are distinct before quotienting. -/
theorem raw_one_ne_two : (1 : Nat) ≠ 2 := by
  omega

/-- The same representatives become equal precisely because their noumenal
actions agree on every Boolean state. -/
theorem noumenalQuotient_one_eq_two (A : ExampleSystem) :
    NoumenalQuotientTransformation.mk
        (Transformation := NonfaithfulTransformation)
        (NoumenalState := ExampleState) (A := A) 1 =
      NoumenalQuotientTransformation.mk
        (Transformation := NonfaithfulTransformation)
        (NoumenalState := ExampleState) (A := A) 2 := by
  apply (NoumenalQuotientTransformation.mk_eq_mk_iff
    (Transformation := NonfaithfulTransformation)
    (NoumenalState := ExampleState) (A := A) 1 2).2
  intro state
  rfl

/-- A representative-sensitive raw-value recovery function cannot descend to
the noumenal action quotient.  The proof uses only the already-checked quotient
equality and never extracts a representative. -/
theorem noumenalRawValue_cannot_descend (A : ExampleSystem) :
    ¬ ∃ recover :
        NoumenalQuotientTransformation
            (Transformation := NonfaithfulTransformation)
            (NoumenalState := ExampleState) A → Nat,
      ∀ raw : Nat,
        recover (NoumenalQuotientTransformation.mk
          (Transformation := NonfaithfulTransformation)
          (NoumenalState := ExampleState) (A := A) raw) = raw := by
  rintro ⟨recover, recovers⟩
  apply raw_one_ne_two
  calc
    1 = recover (NoumenalQuotientTransformation.mk
          (Transformation := NonfaithfulTransformation)
          (NoumenalState := ExampleState) (A := A) 1) := (recovers 1).symm
    _ = recover (NoumenalQuotientTransformation.mk
          (Transformation := NonfaithfulTransformation)
          (NoumenalState := ExampleState) (A := A) 2) :=
      congrArg recover (noumenalQuotient_one_eq_two A)
    _ = 2 := recovers 2

/-- The non-effective core is repaired into a full local-realistic theory. -/
def repairedNonfaithfulTheory :=
  LocalRealisticCore.toNoumenallyFaithfulQuotient nonfaithfulCore

#check repairedNonfaithfulTheory

/-- Consumer regression: the theory-tagged quotient family lets ordinary
field projection recover all three descended instances after construction. -/
theorem repairedNonfaithfulTheory_is_effective :
    NoumenallyFaithful nonfaithfulCore.NoumenalFaithfulTransformation ExampleState :=
  repairedNonfaithfulTheory.noumenalActionFaithful

/-- Consumer regression for a transformation-bearing field. -/
def repairedNonfaithfulTransformationProducts :=
  repairedNonfaithfulTheory.transformationProducts

/-- Downstream derived laws are directly available, not only inside the
constructor's local instance scope. -/
example : repairedNonfaithfulTheory.transformationProducts.Multiplicative :=
  repairedNonfaithfulTheory.productMultiplicative

/-! The same non-effective natural-number model gives a non-vacuous Appendix
A regression.  Its raw transformation product satisfies the Axiom 4.6 laws
because natural-number multiplication is commutative. -/

private theorem reindexNonfaithfulTransformation {A B : ExampleSystem}
    (h : A = B) (transformation : NonfaithfulTransformation A) :
    reindex NonfaithfulTransformation h transformation = transformation := by
  subst B
  rfl

theorem nonfaithfulProductMultiplicative :
    nonfaithfulTransformationProduct.Multiplicative := by
  unfold TransformationProduct.Multiplicative
  intro A B hsep leftOuter leftInner rightOuter rightInner
  change (leftOuter * rightOuter) * (leftInner * rightInner) =
    (leftOuter * leftInner) * (rightOuter * rightInner)
  ac_rfl

theorem nonfaithfulProductUnital :
    nonfaithfulTransformationProduct.Unital := by
  unfold TransformationProduct.Unital
  intros
  rfl

theorem nonfaithfulProductSymmetric :
    nonfaithfulTransformationProduct.Symmetric := by
  unfold TransformationProduct.Symmetric
  intro A B hsep left right
  rw [reindexNonfaithfulTransformation]
  exact Nat.mul_comm left right

theorem nonfaithfulProductAssociative :
    nonfaithfulTransformationProduct.Associative := by
  unfold TransformationProduct.Associative
  intro A B C hAB hAC hBC left middle right
  rw [reindexNonfaithfulTransformation]
  exact Nat.mul_assoc left middle right

def nonfaithfulNoSignallingTheory :
    NoSignallingTheory ExampleSystem NonfaithfulTransformation ExampleState where
  toPhenomenalTheory := nonfaithfulCore.toPhenomenalTheory
  transformationProducts := nonfaithfulTransformationProduct
  noSignalling := by
    intro A B left right hsep state
    rfl
  productMultiplicative := nonfaithfulProductMultiplicative
  productUnital := nonfaithfulProductUnital
  productSymmetric := nonfaithfulProductSymmetric
  productAssociative := nonfaithfulProductAssociative

/-- Appendix A genuinely collapses distinct raw representatives in this
model, independently of the Appendix B quotient. -/
theorem phenomenalQuotient_one_eq_two (A : ExampleSystem) :
    PhenomenalTransformation.mk nonfaithfulNoSignallingTheory
        (A := A) (1 : Nat) =
      PhenomenalTransformation.mk nonfaithfulNoSignallingTheory
        (A := A) (2 : Nat) := by
  apply (nonfaithfulNoSignallingTheory.phenomenalCon A).eq.mpr
  intro B hsep state
  rfl

/-- The Appendix A constructor returns a no-signalling theory on contextual
phenomenal-equivalence classes. -/
def repairedPhenomenalTheory :=
  phenomenalQuotientTheory nonfaithfulNoSignallingTheory

/-- Its exact conclusion is the paper's contextual phenomenal faithfulness
predicate; no local `ActionEffective` claim is made. -/
theorem repairedPhenomenalTheory_is_contextually_faithful :
    repairedPhenomenalTheory.PhenomenallyFaithful :=
  phenomenalQuotientTheory_phenomenallyFaithful nonfaithfulNoSignallingTheory

end RR2021.Faithfulness.Examples
