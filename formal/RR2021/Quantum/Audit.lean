import RR2021.Quantum.API

/-!
# Quantum subset signature and axiom audit

This leaf prints only the proved finite-matrix and operator-algebra results.
There is intentionally no project declaration constructing a quantum
`NoSignallingTheory`: density operators, partial trace, coherent subsystem
factorizations, and the contextual phase theorem remain separately recorded
obligations.
-/

#check RR2021.Quantum.finiteMatrixTensorEquiv
#check RR2021.Quantum.finiteMatrixTensorEquiv_tmul
#check RR2021.Quantum.OverlappingExtensionsAgree
#check RR2021.Quantum.commonMiddleFactorAt
#check RR2021.Quantum.commonMiddleFactor
#check RR2021.Quantum.kroneckerOneRight_injective
#check RR2021.Quantum.mem_unitary_of_kronecker_one
#check RR2021.Quantum.commonMiddleUnitaryFactor
#check RR2021.Quantum.conjugation_eq_iff_unitaryPhase

#print axioms RR2021.Quantum.finiteMatrixTensorEquiv_tmul
#print axioms RR2021.Quantum.commonMiddleFactor
#print axioms RR2021.Quantum.kroneckerOneRight_injective
#print axioms RR2021.Quantum.mem_unitary_of_kronecker_one
#print axioms RR2021.Quantum.commonMiddleUnitaryFactor
#print axioms RR2021.Quantum.conjugation_eq_iff_unitaryPhase
