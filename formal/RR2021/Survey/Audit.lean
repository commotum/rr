import RR2021.Survey.API

/-!
# Stage 1 survey audit

These commands exercise the public signatures and report the axiom footprint
of the small proved laws and quotient descent.
-/

#check RR2021.Survey.SeparatedSystems
#check MulAction
#check mul_smul
#check RR2021.Survey.IndexedLeftAction
#check RR2021.Survey.ObservationQuotient
#check RR2021.Survey.descendObservation
#check RR2021.Survey.PartialProduct
#check RR2021.Survey.CompatibilityDomain
#check RR2021.Survey.productOn

#print axioms RR2021.Survey.SeparatedSystems.swap_left
#print axioms RR2021.Survey.IndexedLeftAction.act_mul
#print axioms RR2021.Survey.observation_congr
#print axioms RR2021.Survey.descendObservation_mk
#print axioms RR2021.Survey.productOn_mk
