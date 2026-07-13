import RR2021.Dynamics.Map

/-!
# Operational theories: common assumption predicates

These declarations keep carrier nonemptiness and action effectivity explicit.
Reverse-construction postulates live in the separate `Theories.Postulates`
leaf so forward modules do not import them.
-/

namespace RR2021.Theories

open RR2021.Dynamics

universe u v w

/-- Every carrier in an indexed family is inhabited, without selecting a
distinguished element. -/
def IndexedNonempty {System : Type u} (Family : System → Type v) : Prop :=
  ∀ A : System, Nonempty (Family A)

/-- Source-facing name for pointwise effectivity of a noumenal action. -/
def NoumenallyFaithful {System : Type u}
    (Transformation : System → Type v) (NoumenalState : System → Type w)
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation NoumenalState] : Prop :=
  ActionEffective Transformation NoumenalState

end RR2021.Theories
