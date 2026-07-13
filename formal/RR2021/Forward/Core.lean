import RR2021.Theories.LocalRealistic
import RR2021.Theories.NoSignalling

/-!
# Forward construction: the state-level no-signalling theorem

The remote phenomenal marginal follows already from `LocalRealisticCore`.
Noumenal action effectivity, inverse dynamics, and every reverse-construction
assumption are deliberately absent from this module.
-/

namespace RR2021.Theories

open RR2021.Systems RR2021.Dynamics

universe u v w x

namespace LocalRealisticCore

variable {System : Type u} [BooleanAlgebra System]
variable {Transformation : System → Type v}
variable {NoumenalState : System → Type w}
variable {PhenomenalState : System → Type x}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation NoumenalState]
variable [IndexedMulAction System Transformation PhenomenalState]

/--
Theorem 3.12 at its assumption-minimal boundary.  An arbitrary phenomenal
composite state is lifted only inside this proof; equivariance, compatibility
of the two projector families, and noumenal locality then identify its left
marginal after a separated product transformation.
-/
theorem noSignallingAxiom
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState) :
    NoSignallingAxiom theory.phenomenalProjectors theory.transformationProducts := by
  intro A B leftTransformation rightTransformation hsep phenomenalState
  obtain ⟨noumenalState, rfl⟩ :=
    theory.phenomenalizationSurjective (Composite A B) phenomenalState
  change theory.phenomenalProjectors.project le_sup_left
      (theory.transformationProducts.product leftTransformation
          rightTransformation hsep • theory.phenomenalization.toFun noumenalState) =
    leftTransformation •
      theory.phenomenalProjectors.project le_sup_left
        (theory.phenomenalization.toFun noumenalState)
  rw [← theory.phenomenalizationEquivariant
      (theory.transformationProducts.product leftTransformation
        rightTransformation hsep) noumenalState,
    ← theory.phenomenalizationProjectionCompatible le_sup_left]
  change theory.phenomenalization.toFun
      (theory.noumenalProjectors.projectLeft
        (theory.transformationProducts.product leftTransformation
          rightTransformation hsep • noumenalState)) =
    leftTransformation •
      theory.phenomenalProjectors.projectLeft
        (theory.phenomenalization.toFun noumenalState)
  rw [theory.locality.project_left_product_action,
    theory.phenomenalizationEquivariant]
  exact congrArg (fun state => leftTransformation • state)
    (theory.phenomenalizationProjectionCompatible le_sup_left noumenalState)

/-- Forget the noumenal data while retaining the derived phenomenal
nonemptiness and projector surjectivity required by Axioms 4.1--4.5. -/
def toPhenomenalTheory
    (theory : LocalRealisticCore System Transformation NoumenalState PhenomenalState) :
    PhenomenalTheory System Transformation PhenomenalState where
  stateNonempty := theory.phenomenalNonempty
  projectors := theory.phenomenalProjectors
  projectorsSurjective := theory.phenomenalProjectorsSurjective

end LocalRealisticCore

end RR2021.Theories
