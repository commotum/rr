import RR2021.Reverse.Transitive.API

/-!
# Transitive reverse-construction signature and axiom audit

The checks expose the two inverse uses, the unique-choice boundary, the
reference-state/transitivity boundary, and both final faithfulness routes.
-/

#check RR2021.Reverse.extendSystem
#check RR2021.Reverse.extendComplement
#check RR2021.Reverse.Transitive.FundamentallyEquivalent
#check RR2021.Reverse.Transitive.fundamentalSetoid
#check RR2021.Reverse.Transitive.NoumenalState
#check RR2021.Reverse.Transitive.FundamentallyEquivalent.mono
#check RR2021.Reverse.Transitive.FundamentallyEquivalent.intersection
#check RR2021.Reverse.Transitive.NoumenalState.projectors
#check RR2021.Reverse.Transitive.NoumenalState.indexedMulAction
#check RR2021.Reverse.Transitive.NoumenalState.compatible_uniqueCommonExtension
#check RR2021.Reverse.Transitive.NoumenalState.compatible_iff_exists_globalRepresentative
#check RR2021.Reverse.Transitive.NoumenalState.stateProduct_mk_mk
#check RR2021.Reverse.Transitive.NoumenalState.chosenCommonExtension
#check RR2021.Reverse.Transitive.NoumenalState.stateProduct
#check RR2021.Reverse.Transitive.NoumenalState.locality
#check RR2021.Reverse.Transitive.NoumenalState.phenomenalization
#check RR2021.Reverse.Transitive.NoumenalState.phenomenalization_surjective
#check RR2021.Reverse.Transitive.coreAtReference
#check RR2021.Reverse.Transitive.actionEffectiveAtReference
#check RR2021.Reverse.Transitive.theoryAtReference
#check RR2021.Reverse.Transitive.faithfulQuotientAtReference

#print axioms RR2021.Reverse.Transitive.FundamentallyEquivalent.symm
#print axioms RR2021.Reverse.Transitive.FundamentallyEquivalent.mono
#print axioms RR2021.Reverse.Transitive.FundamentallyEquivalent.intersection
#print axioms RR2021.Reverse.Transitive.NoumenalState.compatible_uniqueCommonExtension
#print axioms RR2021.Reverse.Transitive.NoumenalState.chosenCommonExtension
#print axioms RR2021.Reverse.Transitive.NoumenalState.stateProduct
#print axioms RR2021.Reverse.Transitive.NoumenalState.locality
#print axioms RR2021.Reverse.Transitive.NoumenalState.phenomenalization_surjective
#print axioms RR2021.Reverse.Transitive.coreAtReference
#print axioms RR2021.Reverse.Transitive.actionEffectiveAtReference
#print axioms RR2021.Reverse.Transitive.theoryAtReference
#print axioms RR2021.Reverse.Transitive.faithfulQuotientAtReference
