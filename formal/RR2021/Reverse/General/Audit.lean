import RR2021.Reverse.General.API

/-!
# General reverse-construction signature and axiom audit

The checks expose exact pair compatibility, absence of global transitivity,
and the two final faithfulness routes.
-/

#check RR2021.Reverse.General.EnlargedNoumenalState
#check RR2021.Reverse.General.EnlargedNoumenalState.indexedMulAction
#check RR2021.Reverse.General.EnlargedNoumenalState.projectors
#check RR2021.Reverse.General.EnlargedNoumenalState.compatible_iff_label_eq_and_fundamental_compatible
#check RR2021.Reverse.General.EnlargedNoumenalState.stateProduct
#check RR2021.Reverse.General.EnlargedNoumenalState.representedCompatibility
#check RR2021.Reverse.General.EnlargedNoumenalState.stateProduct_ofRepresentative
#check RR2021.Reverse.General.EnlargedNoumenalState.locality
#check RR2021.Reverse.General.EnlargedNoumenalState.phenomenalization
#check RR2021.Reverse.General.EnlargedNoumenalState.phenomenalization_equivariant
#check RR2021.Reverse.General.EnlargedNoumenalState.phenomenalization_projectionCompatible
#check RR2021.Reverse.General.EnlargedNoumenalState.phenomenalization_surjective
#check RR2021.Reverse.General.core
#check RR2021.Reverse.General.actionEffective
#check RR2021.Reverse.General.theory
#check RR2021.Reverse.General.faithfulQuotient

#print axioms RR2021.Reverse.General.EnlargedNoumenalState.compatible_iff_label_eq_and_fundamental_compatible
#print axioms RR2021.Reverse.General.EnlargedNoumenalState.stateProduct
#print axioms RR2021.Reverse.General.EnlargedNoumenalState.locality
#print axioms RR2021.Reverse.General.EnlargedNoumenalState.phenomenalization_surjective
#print axioms RR2021.Reverse.General.core
#print axioms RR2021.Reverse.General.actionEffective
#print axioms RR2021.Reverse.General.theory
#print axioms RR2021.Reverse.General.faithfulQuotient
