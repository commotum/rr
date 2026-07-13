import RR2021.API

/-!
# Root-API-only model consumers

This file intentionally imports exactly the root stable API.  It verifies that
the concrete model, forward constructor, both general reverse outputs, derived
laws, and ordinary instance inference remain usable without internal imports.
-/

namespace RR2021.Models.Examples

open RR2021.Dynamics RR2021.Theories

example :
    LocalRealisticTheory Trivial.System Trivial.Transformation
      Trivial.State Trivial.State :=
  Trivial.theory

example : NoSignallingTheory Trivial.System Trivial.Transformation Trivial.State :=
  Trivial.noSignallingTheory

example : Trivial.noSignallingTheory.transformationProducts.Multiplicative :=
  Trivial.noSignallingTheory.productMultiplicative

example : Trivial.generalRawTheory.transformationProducts.Multiplicative :=
  Trivial.generalRawTheory.productMultiplicative

example :
    NoumenallyFaithful
      (RR2021.Reverse.General.core Trivial.noSignallingTheory
        Trivial.invertible Trivial.transformationSeparation).NoumenalFaithfulTransformation
      (RR2021.Reverse.General.EnlargedNoumenalState
        Trivial.noSignallingTheory Trivial.invertible) :=
  Trivial.generalQuotientTheory.noumenalActionFaithful

example : Trivial.generalQuotientTheory.transformationProducts.Multiplicative :=
  Trivial.generalQuotientTheory.productMultiplicative

example :
    RR2021.Correspondence.SameOperationalData
      (RR2021.Correspondence.forward Trivial.generalRawTheory)
      Trivial.noSignallingTheory :=
  Trivial.generalRaw_forward_sameOperationalData

end RR2021.Models.Examples
