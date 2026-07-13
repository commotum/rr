import RR2021.Dynamics.Reindex

/-!
# Indexed dynamics: raw products of separated transformations

`TransformationProduct` contains only the operation supplied by Axiom 3.13:
for an explicitly separated pair of systems, a pair of transformations gives
a transformation of the composite.  Multiplication, identity, symmetry, and
associativity are deliberately separate predicates.  They are not properties
of arbitrary raw product data and will later be derived only from the required
locality and action-effectivity hypotheses.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v

/-- A total product on transformation pairs whose system indices are separated. -/
structure TransformationProduct (System : Type u) [SemilatticeSup System]
    [OrderBot System] (Transformation : System → Type v) where
  product : {A B : System} → Transformation A → Transformation B →
    Separated A B → Transformation (Composite A B)

namespace TransformationProduct

section Basic

variable {System : Type u} [SemilatticeSup System] [OrderBot System]
variable {Transformation : System → Type v}

/-- The raw product is independent of the proof witnessing system separation. -/
theorem product_separation_irrelevant
    (products : TransformationProduct System Transformation)
    {A B : System} (left : Transformation A) (right : Transformation B)
    (first second : Separated A B) :
    products.product left right first = products.product left right second := by
  have proof_eq : first = second := Subsingleton.elim _ _
  subst proof_eq
  rfl

/-- Optional Theorem-3.8-style componentwise multiplication law. -/
def Multiplicative [IndexedMonoid System Transformation]
    (products : TransformationProduct System Transformation) : Prop :=
  ∀ {A B : System} (hsep : Separated A B)
    (leftOuter leftInner : Transformation A)
    (rightOuter rightInner : Transformation B),
    products.product leftOuter rightOuter hsep *
        products.product leftInner rightInner hsep =
      products.product (leftOuter * leftInner) (rightOuter * rightInner) hsep

/-- Optional Theorem-3.9-style identity law. -/
def Unital [IndexedMonoid System Transformation]
    (products : TransformationProduct System Transformation) : Prop :=
  ∀ {A B : System} (hsep : Separated A B),
    products.product (1 : Transformation A) (1 : Transformation B) hsep =
      (1 : Transformation (Composite A B))

/-- Optional Theorem-3.10-style symmetry, with the target reindex explicit. -/
def Symmetric (products : TransformationProduct System Transformation) : Prop :=
  ∀ {A B : System} (hsep : Separated A B)
    (left : Transformation A) (right : Transformation B),
    reindex Transformation (sup_comm A B) (products.product left right hsep) =
      products.product right left hsep.symm

end Basic

section Associativity

variable {System : Type u} [DistribLattice System] [OrderBot System]
variable {Transformation : System → Type v}

/--
Optional Theorem-3.11-style associativity.  Pairwise separation supplies both
separation witnesses for the nested products, and `sup_assoc` is visible in
the result rather than hidden by implicit transport.
-/
def Associative (products : TransformationProduct System Transformation) : Prop :=
  ∀ {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (left : Transformation A)
    (middle : Transformation B) (right : Transformation C),
    reindex Transformation (sup_assoc A B C)
        (products.product (products.product left middle hAB) right
          (composite_separated_of_pairwise hAC hBC)) =
      products.product left (products.product middle right hBC)
        (separated_composite_of_pairwise hAB hAC)

end Associativity

end TransformationProduct

end RR2021.Dynamics
