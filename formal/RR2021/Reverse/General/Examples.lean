import RR2021.Reverse.General.API

/-!
# General reverse-construction consumer regressions

These generic checks exercise the stable API, confirm ordinary action
inference, and confirm that both full outputs expose derived laws without any
global-transitivity argument.
-/

namespace RR2021.Reverse.General.Examples

open RR2021.Systems RR2021.Dynamics RR2021.Theories

universe u v w

noncomputable section

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {PhenomenalState : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation PhenomenalState]

variable (source : NoSignallingTheory System Transformation PhenomenalState)
variable (invertible : InvertibleDynamics Transformation)
variable (transformationSeparation : source.TransformationSeparation)

/-- The general core retains the input transformation product. -/
example :
    (core source invertible transformationSeparation).transformationProducts =
      source.transformationProducts :=
  rfl

/-- The source-faithful wrapper is directly consumable. -/
example (phenomenallyFaithful : source.PhenomenallyFaithful) :
    NoumenallyFaithful Transformation
      (EnlargedNoumenalState source invertible) :=
  (theory source invertible transformationSeparation
    phenomenallyFaithful).noumenalActionFaithful

/-- Derived product laws are available on the original-family output. -/
example (phenomenallyFaithful : source.PhenomenallyFaithful) :
    (theory source invertible transformationSeparation
      phenomenallyFaithful).transformationProducts.Multiplicative :=
  (theory source invertible transformationSeparation
    phenomenallyFaithful).productMultiplicative

/-- Appendix B supplies an inferable faithful quotient action without
phenomenal faithfulness or global transitivity. -/
example :
    NoumenallyFaithful
      (core source invertible
        transformationSeparation).NoumenalFaithfulTransformation
      (EnlargedNoumenalState source invertible) :=
  (faithfulQuotient source invertible
    transformationSeparation).noumenalActionFaithful

/-- Transformation-bearing derived laws remain directly consumable from the
general repaired output. -/
example :
    (faithfulQuotient source invertible
      transformationSeparation).transformationProducts.Multiplicative :=
  (faithfulQuotient source invertible
    transformationSeparation).productMultiplicative

end

end RR2021.Reverse.General.Examples
