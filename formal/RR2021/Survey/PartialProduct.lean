import RR2021.Survey.Systems

/-!
# Compatibility-indexed partial-product encoding spike

`product` cannot be called without a compatibility witness.  In particular,
this API contains no value, default, or branch for an incompatible pair.
-/

namespace RR2021.Survey

universe u v

/-- A partial product whose domain is witnessed compatibility. -/
structure PartialProduct (System : Type u) [BooleanAlgebra System]
    (State : System → Type v) where
  Compatible : {A B : System} → State A → State B → Prop
  product : {A B : System} → (left : State A) → (right : State B) →
    Compatible left right → State (A ⊔ B)

/-- The honest domain of a partial product for a fixed pair of systems. -/
def CompatibilityDomain {System : Type u} [BooleanAlgebra System]
    {State : System → Type v} (operations : PartialProduct System State)
    (A B : System) :=
  { pair : State A × State B // operations.Compatible pair.1 pair.2 }

/-- Evaluation on the compatibility-indexed domain; there is no off-domain case. -/
def productOn {System : Type u} [BooleanAlgebra System]
    {State : System → Type v} (operations : PartialProduct System State)
    {A B : System} (input : CompatibilityDomain operations A B) : State (A ⊔ B) :=
  operations.product input.1.1 input.1.2 input.2

@[simp]
theorem productOn_mk {System : Type u} [BooleanAlgebra System]
    {State : System → Type v} (operations : PartialProduct System State)
    {A B : System} (left : State A) (right : State B)
    (compatible : operations.Compatible left right) :
    productOn operations ⟨(left, right), compatible⟩ =
      operations.product left right compatible :=
  rfl

end RR2021.Survey
