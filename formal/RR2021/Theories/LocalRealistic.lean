import RR2021.Theories.Core
import RR2021.Dynamics.Locality

/-!
# Local-realistic theories

`LocalRealisticCore` contains every corrected Section 3 requirement except
Axiom 3.7.  This boundary is required by Theorems 4.2--4.3 and Appendix B.
`LocalRealisticTheory` adds exactly noumenal action effectivity.
-/

namespace RR2021.Theories

open RR2021.Dynamics

universe u v w x

/-- All local-realistic data and laws except noumenal faithfulness. -/
structure LocalRealisticCore (System : Type u) [BooleanAlgebra System]
    (Transformation : System → Type v) (NoumenalState : System → Type w)
    (PhenomenalState : System → Type x)
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation NoumenalState]
    [IndexedMulAction System Transformation PhenomenalState] where
  noumenalNonempty : IndexedNonempty NoumenalState
  phenomenalization : IndexedMap System NoumenalState PhenomenalState
  phenomenalizationEquivariant :
    phenomenalization.Equivariant (Transformation := Transformation)
  phenomenalizationSurjective : phenomenalization.Surjective
  noumenalProjectors : ProjectorFamily System NoumenalState
  noumenalProjectorsSurjective : noumenalProjectors.Surjective
  phenomenalProjectors : ProjectorFamily System PhenomenalState
  phenomenalizationProjectionCompatible :
    ProjectionCompatible phenomenalization noumenalProjectors phenomenalProjectors
  noumenalProduct : StateProduct noumenalProjectors
  transformationProducts : TransformationProduct System Transformation
  locality : Locality noumenalProjectors noumenalProduct transformationProducts

/-- Source-facing name for the Appendix-B input: all local-realistic structure
except Axiom 3.7. -/
abbrev LocalRealisticWithoutFaithfulness := LocalRealisticCore

/-- A local-realistic theory in the source's full sense, adding exactly Axiom 3.7. -/
structure LocalRealisticTheory (System : Type u) [BooleanAlgebra System]
    (Transformation : System → Type v) (NoumenalState : System → Type w)
    (PhenomenalState : System → Type x)
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation NoumenalState]
    [IndexedMulAction System Transformation PhenomenalState]
    extends LocalRealisticCore System Transformation NoumenalState PhenomenalState where
  noumenalActionFaithful : NoumenallyFaithful Transformation NoumenalState

namespace LocalRealisticCore

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/-- Axiom 3.3 follows from noumenal nonemptiness and phenomenalization. -/
theorem phenomenalNonempty
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState) :
    IndexedNonempty PhenomenalState := by
  intro A
  exact (theory.noumenalNonempty A).map
    (fun state => theory.phenomenalization.toFun state)

/-- Axiom 3.10 surjectivity follows from Axioms 3.8, 3.9, and 3.11. -/
theorem phenomenalProjectorsSurjective
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState) :
    theory.phenomenalProjectors.Surjective := by
  intro A B hAB phenomenalState
  obtain ⟨noumenalA, image_eq⟩ :=
    theory.phenomenalizationSurjective A phenomenalState
  obtain ⟨noumenalB, projection_eq⟩ :=
    theory.noumenalProjectorsSurjective hAB noumenalA
  refine ⟨theory.phenomenalization.toFun noumenalB, ?_⟩
  rw [← theory.phenomenalizationProjectionCompatible hAB noumenalB,
    projection_eq, image_eq]

end LocalRealisticCore

end RR2021.Theories
