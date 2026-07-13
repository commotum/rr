import RR2021.Models.API
import RR2021.Systems.Examples
import RR2021.Dynamics.Examples
import RR2021.Theories.Examples
import RR2021.Faithfulness.Examples
import RR2021.Quantum.Examples

/-!
# Consolidated model and countermodel audit

This diagnostic leaf reuses the exact earlier regressions.  The natural-number
no-signalling model proves three separate non-implications from the base
structure; it is not described as a pairwise independence family.
-/

namespace RR2021.Models.Audit

/-- Noncommuting permutations detect the wrong action/composition order. -/
def compositionOrderRegression :=
  RR2021.Dynamics.Examples.reversed_action_order_is_wrong

/-- The two concrete system indices are unequal, so `reindex` cannot be called
without an unavailable equality premise. -/
theorem invalidTransportPremiseRegression :
    RR2021.Systems.Examples.leftAtom ≠ RR2021.Systems.Examples.rightAtom := by
  decide

/-- Distinct constant-family states have no common extension and therefore no
honest product input. -/
def incompatibleProductRegression :=
  RR2021.Dynamics.Examples.unequal_states_incompatible

/-- Base no-signalling does not imply invertibility in the boundary model. -/
def noSignallingDoesNotImplyInvertibility :=
  RR2021.Theories.Examples.boundary_not_invertible

/-- Base no-signalling does not imply contextual phenomenal faithfulness in
the boundary model. -/
def noSignallingDoesNotImplyPhenomenalFaithfulness :=
  RR2021.Theories.Examples.boundary_not_phenomenallyFaithful

/-- Base no-signalling does not imply global transitivity in the boundary
model. -/
def noSignallingDoesNotImplyGlobalTransitivity :=
  RR2021.Theories.Examples.boundary_not_globallyTransitive

/-- The quotient-collapse regression is nonvacuous at the raw level. -/
def quotientRepresentativesAreDistinct :=
  RR2021.Faithfulness.Examples.raw_one_ne_two

/-- Appendix B's noumenal action quotient identifies the two distinct raw
representatives. -/
def noumenalQuotientRepresentativesCollapse
    (A : RR2021.Forward.Examples.ExampleSystem) :=
  RR2021.Faithfulness.Examples.noumenalQuotient_one_eq_two A

/-- Appendix A's contextual phenomenal quotient independently identifies the
same two raw representatives. -/
def phenomenalQuotientRepresentativesCollapse
    (A : RR2021.Forward.Examples.ExampleSystem) :=
  RR2021.Faithfulness.Examples.phenomenalQuotient_one_eq_two A

/-- A raw-value recovery function cannot descend through the noumenal
quotient. -/
def rawValueCannotDescend
    (A : RR2021.Forward.Examples.ExampleSystem) :=
  RR2021.Faithfulness.Examples.noumenalRawValue_cannot_descend A

/-- Right identity-tensor cancellation fails on an empty outer factor. -/
def emptyRightTensorCancellationFails :=
  RR2021.Quantum.Examples.empty_right_factor_not_injective

/-- Left identity-tensor cancellation fails on an empty outer factor. -/
def emptyLeftTensorCancellationFails :=
  RR2021.Quantum.Examples.empty_left_factor_not_injective

end RR2021.Models.Audit

#check RR2021.Models.Trivial.theory
#check RR2021.Models.Trivial.noSignallingTheory
#check RR2021.Models.Trivial.generalRawTheory
#check RR2021.Models.Trivial.generalQuotientTheory
#check RR2021.Models.Trivial.generalRaw_forward_sameOperationalData
#check RR2021.Models.Audit.compositionOrderRegression
#check RR2021.Models.Audit.invalidTransportPremiseRegression
#check RR2021.Models.Audit.incompatibleProductRegression
#check RR2021.Models.Audit.noSignallingDoesNotImplyInvertibility
#check RR2021.Models.Audit.noSignallingDoesNotImplyPhenomenalFaithfulness
#check RR2021.Models.Audit.noSignallingDoesNotImplyGlobalTransitivity
#check RR2021.Models.Audit.quotientRepresentativesAreDistinct
#check RR2021.Models.Audit.noumenalQuotientRepresentativesCollapse
#check RR2021.Models.Audit.phenomenalQuotientRepresentativesCollapse
#check RR2021.Models.Audit.rawValueCannotDescend
#check RR2021.Models.Audit.emptyRightTensorCancellationFails
#check RR2021.Models.Audit.emptyLeftTensorCancellationFails

#print axioms RR2021.Models.Trivial.theory
#print axioms RR2021.Models.Trivial.noSignallingTheory
#print axioms RR2021.Models.Trivial.generalRawTheory
#print axioms RR2021.Models.Trivial.generalQuotientTheory
#print axioms RR2021.Models.Trivial.generalRaw_forward_sameOperationalData
#print axioms RR2021.Models.Audit.rawValueCannotDescend
