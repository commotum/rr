import RR2021.Reverse.Transitive.API

/-!
# Transitive reverse construction: consumer regressions

These lightweight checks deliberately remain generic.  They verify that both
the original-transformation constructor and the repaired Appendix-B output
carry inferable action instances and can be consumed through ordinary theory
field projections.  This diagnostic leaf is not part of the public API.
-/

namespace RR2021.Reverse.Transitive.Examples

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

noncomputable section

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

variable (theory : NoSignallingTheory System Transformation PhenomenalState)
variable (invertible : InvertibleDynamics Transformation)
variable (transformationSeparation : theory.TransformationSeparation)
variable (reference : PhenomenalState globalSystem)
variable (globallyTransitive : theory.GloballyTransitive)

/-- The pre-faithful core exposes the input transformation product unchanged. -/
example :
    (coreAtReference theory invertible transformationSeparation reference
      globallyTransitive).transformationProducts = theory.transformationProducts :=
  rfl

/-- Consumer check for the original-transformation constructor. -/
example (phenomenallyFaithful : theory.PhenomenallyFaithful) :
    NoumenallyFaithful Transformation (NoumenalState theory invertible) :=
  (theoryAtReference theory invertible transformationSeparation reference
    globallyTransitive phenomenallyFaithful).noumenalActionFaithful

/-- Derived transformation-product laws remain directly available on the
original-transformation output. -/
example (phenomenallyFaithful : theory.PhenomenallyFaithful) :
    (theoryAtReference theory invertible transformationSeparation reference
      globallyTransitive phenomenallyFaithful).transformationProducts.Multiplicative :=
  (theoryAtReference theory invertible transformationSeparation reference
    globallyTransitive phenomenallyFaithful).productMultiplicative

/-- The theory-tagged Appendix-B family recovers its effective action without
any caller-supplied local instance. -/
example :
    NoumenallyFaithful
      (coreAtReference theory invertible transformationSeparation reference
        globallyTransitive).NoumenalFaithfulTransformation
      (NoumenalState theory invertible) :=
  (faithfulQuotientAtReference theory invertible transformationSeparation
    reference globallyTransitive).noumenalActionFaithful

/-- A transformation-bearing derived field is also directly consumable from
the repaired output. -/
example :
    (faithfulQuotientAtReference theory invertible transformationSeparation
      reference globallyTransitive).transformationProducts.Multiplicative :=
  (faithfulQuotientAtReference theory invertible transformationSeparation
    reference globallyTransitive).productMultiplicative

end

end RR2021.Reverse.Transitive.Examples
