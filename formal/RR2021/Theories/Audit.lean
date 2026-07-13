import RR2021.Theories.API

/-!
# Operational-theory signature and axiom audit

This file checks the public Stage 4 surface, prints the four principal theory
structures so their field boundaries remain visible, and reports the logical
foundations of the central derived laws.
-/

#check RR2021.Theories.IndexedNonempty
#check RR2021.Theories.NoumenallyFaithful
#check RR2021.Theories.InvertibleDynamics

#check RR2021.Theories.PhenomenalTheory
#check RR2021.Theories.NoSignallingAxiom
#check RR2021.Theories.NoSignallingTheory
#check RR2021.Theories.NoSignallingTheory.PhenomenallyEquivalent
#check RR2021.Theories.NoSignallingTheory.PhenomenallyFaithful
#check RR2021.Theories.NoSignallingTheory.GloballyTransitive
#check RR2021.Theories.NoSignallingTheory.TransformationSeparation

#check RR2021.Theories.LocalRealisticCore
#check RR2021.Theories.LocalRealisticWithoutFaithfulness
#check RR2021.Theories.LocalRealisticTheory
#check RR2021.Theories.LocalRealisticCore.phenomenalNonempty
#check RR2021.Theories.LocalRealisticCore.phenomenalProjectorsSurjective

#check RR2021.Theories.NoSignallingTheory.noSignallingRight
#check RR2021.Theories.NoSignallingTheory.productOfInverses
#check RR2021.Theories.NoSignallingTheory.productInverse_eq
#check RR2021.Theories.NoSignallingTheory.productInvertible
#check RR2021.Theories.LocalRealisticCore.noumenalProjectSelf
#check RR2021.Theories.LocalRealisticCore.phenomenalProjectSelf
#check RR2021.Theories.LocalRealisticTheory.transformationProduct_unique
#check RR2021.Theories.LocalRealisticTheory.productMultiplicative
#check RR2021.Theories.LocalRealisticTheory.productUnital
#check RR2021.Theories.LocalRealisticTheory.productSymmetric
#check RR2021.Theories.LocalRealisticTheory.productAssociative

#print RR2021.Theories.PhenomenalTheory
#print RR2021.Theories.NoSignallingTheory
#print RR2021.Theories.LocalRealisticCore
#print RR2021.Theories.LocalRealisticTheory

#print axioms RR2021.Theories.IndexedNonempty
#print axioms RR2021.Theories.NoumenallyFaithful
#print axioms RR2021.Theories.InvertibleDynamics
#print axioms RR2021.Theories.LocalRealisticCore.phenomenalNonempty
#print axioms RR2021.Theories.LocalRealisticCore.phenomenalProjectorsSurjective
#print axioms RR2021.Theories.NoSignallingTheory.noSignallingRight
#print axioms RR2021.Theories.NoSignallingTheory.productOfInverses
#print axioms RR2021.Theories.NoSignallingTheory.productInverse_eq
#print axioms RR2021.Theories.NoSignallingTheory.productInvertible
#print axioms RR2021.Theories.LocalRealisticCore.noumenalProjectSelf
#print axioms RR2021.Theories.LocalRealisticCore.phenomenalProjectSelf
#print axioms RR2021.Theories.LocalRealisticTheory.transformationProduct_unique
#print axioms RR2021.Theories.LocalRealisticTheory.productMultiplicative
#print axioms RR2021.Theories.LocalRealisticTheory.productUnital
#print axioms RR2021.Theories.LocalRealisticTheory.productSymmetric
#print axioms RR2021.Theories.LocalRealisticTheory.productAssociative
