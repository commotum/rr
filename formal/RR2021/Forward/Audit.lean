import RR2021.Forward.API

/-!
# Forward-construction signature and axiom audit

The printed signatures expose the direction of construction: the source is a
local-realistic core or theory, and no reverse-construction hypotheses occur.
-/

#check RR2021.Theories.LocalRealisticCore.noSignallingAxiom
#check RR2021.Theories.LocalRealisticCore.toPhenomenalTheory
#check RR2021.Theories.LocalRealisticTheory.toNoSignallingTheory

#print RR2021.Theories.LocalRealisticCore.noSignallingAxiom
#print RR2021.Theories.LocalRealisticCore.toPhenomenalTheory
#print RR2021.Theories.LocalRealisticTheory.toNoSignallingTheory

#print axioms RR2021.Theories.LocalRealisticCore.noSignallingAxiom
#print axioms RR2021.Theories.LocalRealisticCore.toPhenomenalTheory
#print axioms RR2021.Theories.LocalRealisticTheory.toNoSignallingTheory
