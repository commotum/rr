import Mathlib.Algebra.Group.Action.Defs

/-!
# Indexed dynamics: core carriers and actions

Transformations form a standard `Monoid` separately at every system index, and
states carry the corresponding standard `MulAction`.  No inverse or group
structure is assumed here.
-/

namespace RR2021.Dynamics

universe u v w

/-- A type family indexed by systems. -/
abbrev IndexedFamily (System : Type u) :=
  System → Type v

/-- Source-facing alias for a system-indexed state carrier. -/
abbrev StateFamily (System : Type u) :=
  IndexedFamily.{u, v} System

/-- Source-facing alias for a system-indexed transformation carrier. -/
abbrev TransformationFamily (System : Type u) :=
  IndexedFamily.{u, v} System

/-- A standard monoid instance at every system index. -/
class IndexedMonoid (System : Type u) (Transformation : System → Type v) where
  monoid (A : System) : Monoid (Transformation A)

attribute [reducible] IndexedMonoid.monoid
attribute [instance] IndexedMonoid.monoid

/-- A separate stronger layer supplying a standard group at every index.  The
minimal dynamics below require only `IndexedMonoid`; reverse constructions may
ask for this layer without strengthening all theories. -/
class IndexedGroup (System : Type u) (Transformation : System → Type v) where
  group (A : System) : Group (Transformation A)

attribute [reducible] IndexedGroup.group
attribute [instance] IndexedGroup.group

/-- Every indexed group family canonically supplies the weaker monoid layer. -/
@[reducible, instance]
def IndexedGroup.toIndexedMonoid (System : Type u)
    (Transformation : System → Type v)
    [groups : IndexedGroup System Transformation] :
    IndexedMonoid System Transformation where
  monoid A := (groups.group A).toMonoid

/-- A standard left `MulAction` at every system index. -/
class IndexedMulAction (System : Type u) (Transformation : System → Type v)
    (State : System → Type w) [IndexedMonoid System Transformation] where
  mulAction (A : System) : MulAction (Transformation A) (State A)

attribute [reducible] IndexedMulAction.mulAction
attribute [instance] IndexedMulAction.mulAction

variable {System : Type u} {Transformation : System → Type v}
variable {State : System → Type w}
variable [IndexedMonoid System Transformation]
variable [IndexedMulAction System Transformation State]

/-- The identity transformation acts trivially at every index. -/
@[simp]
theorem one_act {A : System} (state : State A) :
    (1 : Transformation A) • state = state :=
  one_smul (Transformation A) state

/--
The standard left-action orientation: `g * h` first applies `h`, then `g`.
-/
theorem mul_act {A : System} (g h : Transformation A) (state : State A) :
    (g * h) • state = g • (h • state) :=
  mul_smul g h state

end RR2021.Dynamics
