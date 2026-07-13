import RR2021.Dynamics.Projection

/-!
# Indexed dynamics: honest partial state products

Compatibility contains both system separation and a concrete common extension.
The product operation therefore has no value at an incompatible input.  Triple
products, commutativity, and associativity belong to later coherence leaves.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v

variable {System : Type u} [SemilatticeSup System] [OrderBot System]
variable {State : System → Type v}

/-- Two states are compatible when separated systems admit a common extension. -/
def Compatible (projectors : ProjectorFamily System State) {A B : System}
    (left : State A) (right : State B) : Prop :=
  Separated A B ∧
    ∃ whole : State (Composite A B),
      projectors.projectLeft whole = left ∧ projectors.projectRight whole = right

/-- The projections of any state on a separated composite are canonically compatible. -/
theorem canonicalCompatibility (projectors : ProjectorFamily System State)
    {A B : System} (hsep : Separated A B) (whole : State (Composite A B)) :
    Compatible projectors (projectors.projectLeft whole)
      (projectors.projectRight whole) :=
  ⟨hsep, whole, rfl, rfl⟩

/--
Raw partial product data.  Both separation and compatibility evidence are
required.  The only stored law is Axiom-3.12-style reconstruction of every
whole state from its own projections; projection laws are derived below.
-/
structure StateProduct (projectors : ProjectorFamily System State) where
  product : {A B : System} → (left : State A) → (right : State B) →
    Separated A B → Compatible projectors left right → State (Composite A B)
  reconstruct : ∀ {A B : System} (hsep : Separated A B)
    (whole : State (Composite A B)),
    product (projectors.projectLeft whole) (projectors.projectRight whole) hsep
      (canonicalCompatibility projectors hsep whole) = whole

namespace StateProduct

variable {projectors : ProjectorFamily System State}

/-- Product output is independent of the proof witnessing system separation. -/
theorem product_separation_irrelevant (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B)
    (first second : Separated A B)
    (compatible : Compatible projectors left right) :
    products.product left right first compatible =
      products.product left right second compatible := by
  have proof_eq : first = second := Subsingleton.elim _ _
  subst second
  rfl

/-- Product output is independent of the proof of compatibility. -/
theorem product_compatibility_irrelevant (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (first second : Compatible projectors left right) :
    products.product left right hsep first =
      products.product left right hsep second := by
  have proof_eq : first = second := Subsingleton.elim _ _
  subst proof_eq
  rfl

/-- A product is the common extension supplied by any compatibility witness. -/
theorem product_eq_common_extension (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (compatible : Compatible projectors left right)
    (whole : State (Composite A B))
    (left_eq : projectors.projectLeft whole = left)
    (right_eq : projectors.projectRight whole = right) :
    products.product left right hsep compatible = whole := by
  subst left
  subst right
  calc
    products.product (projectors.projectLeft whole) (projectors.projectRight whole)
        hsep compatible =
      products.product (projectors.projectLeft whole) (projectors.projectRight whole)
        hsep (canonicalCompatibility projectors hsep whole) :=
      products.product_compatibility_irrelevant _ _ hsep _ _
    _ = whole := products.reconstruct hsep whole

/-- The left projection law follows from compatibility and reconstruction. -/
theorem project_left (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (compatible : Compatible projectors left right) :
    projectors.projectLeft (products.product left right hsep compatible) = left := by
  obtain ⟨whole, left_eq, right_eq⟩ := compatible.2
  calc
    projectors.projectLeft (products.product left right hsep compatible) =
        projectors.projectLeft whole :=
      congrArg (projectors.projectLeft (A := A) (B := B))
        (products.product_eq_common_extension left right hsep compatible whole
          left_eq right_eq)
    _ = left := left_eq

/-- The right projection law follows from compatibility and reconstruction. -/
theorem project_right (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (compatible : Compatible projectors left right) :
    projectors.projectRight (products.product left right hsep compatible) = right := by
  obtain ⟨whole, left_eq, right_eq⟩ := compatible.2
  calc
    projectors.projectRight (products.product left right hsep compatible) =
        projectors.projectRight whole :=
      congrArg (projectors.projectRight (A := A) (B := B))
        (products.product_eq_common_extension left right hsep compatible whole
          left_eq right_eq)
    _ = right := right_eq

/-- A composite state is uniquely determined by its left and right projections. -/
theorem eq_of_projections (products : StateProduct projectors)
    {A B : System} (hsep : Separated A B)
    {first second : State (Composite A B)}
    (left_eq : projectors.projectLeft first = projectors.projectLeft second)
    (right_eq : projectors.projectRight first = projectors.projectRight second) :
    first = second :=
  (products.reconstruct hsep first).symm.trans <|
    products.product_eq_common_extension
      (projectors.projectLeft first) (projectors.projectRight first) hsep
      (canonicalCompatibility projectors hsep first) second left_eq.symm right_eq.symm

/-- A product equals a whole state exactly when that state has the two factors. -/
theorem product_eq_iff_projections (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (compatible : Compatible projectors left right)
    (whole : State (Composite A B)) :
    products.product left right hsep compatible = whole ↔
      projectors.projectLeft whole = left ∧
        projectors.projectRight whole = right := by
  constructor
  · intro equality
    constructor
    · rw [← equality]
      exact products.project_left left right hsep compatible
    · rw [← equality]
      exact products.project_right left right hsep compatible
  · rintro ⟨left_eq, right_eq⟩
    apply products.eq_of_projections hsep
    · calc
        projectors.projectLeft (products.product left right hsep compatible) = left :=
          products.project_left left right hsep compatible
        _ = projectors.projectLeft whole := left_eq.symm
    · calc
        projectors.projectRight (products.product left right hsep compatible) = right :=
          products.project_right left right hsep compatible
        _ = projectors.projectRight whole := right_eq.symm

end StateProduct

end RR2021.Dynamics
