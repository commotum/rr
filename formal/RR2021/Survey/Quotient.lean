import Mathlib.Logic.Relation

/-!
# Setoid and quotient-descent encoding spike

The observation kernel is built as an explicit `Setoid`.  The observation map
descends only through the named congruence proof below.
-/

namespace RR2021.Survey

universe u v

/-- Equality after observation, packaged with its equivalence proof. -/
def observationSetoid {α : Type u} {β : Type v} (observe : α → β) : Setoid α where
  r a b := observe a = observe b
  iseqv := {
    refl := fun _ => rfl
    symm := fun h => h.symm
    trans := fun h₁ h₂ => h₁.trans h₂
  }

/-- The representative-independence proof used by `descendObservation`. -/
theorem observation_congr {α : Type u} {β : Type v} (observe : α → β)
    {a b : α} (related : (observationSetoid observe).r a b) :
    observe a = observe b :=
  related

/-- The quotient of representatives by observational equality. -/
abbrev ObservationQuotient {α : Type u} {β : Type v} (observe : α → β) :=
  Quotient (observationSetoid observe)

/-- Observation descended to the observational quotient. -/
def descendObservation {α : Type u} {β : Type v} (observe : α → β) :
    ObservationQuotient observe → β :=
  Quotient.lift observe (fun _ _ related => observation_congr observe related)

@[simp]
theorem descendObservation_mk {α : Type u} {β : Type v} (observe : α → β)
    (representative : α) :
    descendObservation observe (Quotient.mk _ representative) = observe representative :=
  rfl

end RR2021.Survey
