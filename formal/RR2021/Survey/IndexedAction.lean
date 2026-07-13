import Mathlib.Algebra.Group.Action.Defs

/-!
# Indexed-family and left-action encoding spike

The multiplication law fixes the convention explicitly: `g * h` acts by
first applying `h`, then applying `g`.  No invertibility is assumed.
-/

namespace RR2021.Survey

universe u v w

/-- A family of state types indexed by systems. -/
abbrev StateFamily (System : Type u) := System → Type v

/-- A standard `MulAction` for every member of an indexed family. -/
structure IndexedLeftAction (System : Type u) (G : Type v) [Monoid G]
    (State : System → Type w) where
  toMulAction : (A : System) → MulAction G (State A)

namespace IndexedLeftAction

variable {System : Type u} {G : Type v} [Monoid G]
variable {State : System → Type w}

/-- Apply the standard scalar action selected at an index. -/
def act (action : IndexedLeftAction System G State) {A : System}
    (g : G) (state : State A) : State A := by
  letI := action.toMulAction A
  exact g • state

@[simp]
theorem act_one (action : IndexedLeftAction System G State) {A : System}
    (state : State A) : action.act 1 state = state := by
  letI := action.toMulAction A
  exact one_smul G state

/-- The exported equation recording the chosen left-action orientation. -/
theorem act_mul (action : IndexedLeftAction System G State) {A : System}
    (g h : G) (state : State A) :
    action.act (g * h) state = action.act g (action.act h state) := by
  letI := action.toMulAction A
  exact mul_smul g h state

end IndexedLeftAction

end RR2021.Survey
