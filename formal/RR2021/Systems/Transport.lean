import RR2021.Systems.Basic

/-!
# Systems: named reindexing and coherence

Dependent equality elimination is exposed only through `reindex`.  The
remaining declarations state the identity, composition, inverse, join
commutativity, and join associativity paths used by indexed consumers.
-/

namespace RR2021.Systems

universe u v

/-- Transport an indexed value along equality of its system indices. -/
def reindex {System : Type u} (Family : System → Sort v) {A B : System}
    (h : A = B) : Family A → Family B :=
  fun value => h ▸ value

@[simp]
theorem reindex_id {System : Type u} (Family : System → Sort v) {A : System}
    (value : Family A) : reindex Family rfl value = value :=
  rfl

/-- Any reindexing around a loop is the identity (equality proofs are irrelevant). -/
@[simp]
theorem reindex_self {System : Type u} (Family : System → Sort v) {A : System}
    (h : A = A) (value : Family A) : reindex Family h value = value := by
  have proof_eq : h = rfl := Subsingleton.elim _ _
  subst proof_eq
  rfl

/-- Successive transports agree with transport along equality composition. -/
theorem reindex_comp {System : Type u} (Family : System → Sort v)
    {A B C : System} (hAB : A = B) (hBC : B = C) (value : Family A) :
    reindex Family hBC (reindex Family hAB value) =
      reindex Family (hAB.trans hBC) value := by
  subst B
  subst C
  rfl

/-- Reindexing along an equality and then its inverse returns the input. -/
@[simp]
theorem reindex_inverse {System : Type u} (Family : System → Sort v)
    {A B : System} (h : A = B) (value : Family A) :
    reindex Family h.symm (reindex Family h value) = value := by
  subst B
  rfl

/-- The opposite order of the inverse law. -/
@[simp]
theorem reindex_inverse_rev {System : Type u} (Family : System → Sort v)
    {A B : System} (h : A = B) (value : Family B) :
    reindex Family h (reindex Family h.symm value) = value := by
  subst B
  rfl

/-- Transport depends only on its endpoints, once both endpoint equalities have
been proved explicitly.  This is the named proof-irrelevance boundary for
coherence checks; it is not used to manufacture an endpoint equality. -/
theorem reindex_path_independent {System : Type u} (Family : System → Sort v)
    {A B : System} (first second : A = B) (value : Family A) :
    reindex Family first value = reindex Family second value := by
  have paths_equal : first = second := Subsingleton.elim _ _
  subst second
  rfl

/-- Reindex a composite-indexed value using commutativity of join. -/
def reindexSupComm {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B : System} :
    Family (Composite A B) → Family (Composite B A) :=
  reindex Family (sup_comm A B)

/-- Reindex a composite-indexed value using associativity of join. -/
def reindexSupAssoc {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B C : System} :
    Family (Composite (Composite A B) C) → Family (Composite A (Composite B C)) :=
  reindex Family (sup_assoc A B C)

/-- Reindex in the reverse associativity direction. -/
def reindexSupAssocInv {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B C : System} :
    Family (Composite A (Composite B C)) → Family (Composite (Composite A B) C) :=
  reindex Family (sup_assoc A B C).symm

/-- Applying the standard commutativity path twice is coherent with identity. -/
@[simp]
theorem reindexSupComm_twice {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B : System}
    (value : Family (Composite A B)) :
    reindexSupComm (A := B) (B := A) Family (reindexSupComm Family value) = value := by
  unfold reindexSupComm
  rw [reindex_comp]
  exact reindex_self Family _ value

/-- Forward then reverse associativity transport is coherent with identity. -/
@[simp]
theorem reindexSupAssoc_inverse {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B C : System}
    (value : Family (Composite (Composite A B) C)) :
    reindexSupAssocInv Family (reindexSupAssoc Family value) = value :=
  reindex_inverse Family (sup_assoc A B C) value

/-- Reverse then forward associativity transport is coherent with identity. -/
@[simp]
theorem reindexSupAssoc_inverse_rev {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B C : System}
    (value : Family (Composite A (Composite B C))) :
    reindexSupAssoc Family (reindexSupAssocInv Family value) = value :=
  reindex_inverse_rev Family (sup_assoc A B C) value

/-- The short two-associator path for four composite systems. -/
def supAssocPathShort {System : Type u} [SemilatticeSup System]
    (A B C D : System) :
    Composite (Composite (Composite A B) C) D =
      Composite A (Composite B (Composite C D)) :=
  (sup_assoc (Composite A B) C D).trans (sup_assoc A B (Composite C D))

/-- The long three-associator path for four composite systems. -/
def supAssocPathLong {System : Type u} [SemilatticeSup System]
    (A B C D : System) :
    Composite (Composite (Composite A B) C) D =
      Composite A (Composite B (Composite C D)) :=
  (congrArg (fun X => Composite X D) (sup_assoc A B C)).trans
    ((sup_assoc A (Composite B C) D).trans
      (congrArg (fun X => Composite A X) (sup_assoc B C D)))

/-- The associativity pentagon transports every indexed value identically. -/
theorem reindexSupAssoc_pentagon {System : Type u} [SemilatticeSup System]
    (Family : System → Sort v) {A B C D : System}
    (value : Family (Composite (Composite (Composite A B) C) D)) :
    reindex Family (supAssocPathShort A B C D) value =
      reindex Family (supAssocPathLong A B C D) value :=
  reindex_path_independent Family _ _ value

/-- First explicit path from the corrected Theorem 5.2 decomposition to `⊤`:
reconstruct `B`, then adjoin `Bᶜ`. -/
def relativeComplementTopPathViaB {System : Type u} [BooleanAlgebra System]
    {A B : System} (h : Subsystem A B) :
    Composite (Composite A (relativeComplement A B)) (complement B) =
      globalSystem :=
  (congrArg (fun X => Composite X (complement B))
    (composite_relativeComplement h)).trans (composite_complement B)

/-- Second explicit path to `⊤`: reassociate, reconstruct `Aᶜ`, then adjoin it
to `A`. -/
def relativeComplementTopPathViaA {System : Type u} [BooleanAlgebra System]
    {A B : System} (h : Subsystem A B) :
    Composite (Composite A (relativeComplement A B)) (complement B) =
      globalSystem :=
  (composite_assoc A (relativeComplement A B) (complement B)).trans
    ((congrArg (fun X => Composite A X)
      (relativeComplement_composite_complement h)).trans
      (composite_complement A))

/-- The two fully typed relative-complement decomposition paths transport an
indexed value identically. -/
theorem reindexRelativeComplement_top_coherent
    {System : Type u} [BooleanAlgebra System]
    (Family : System → Sort v) {A B : System} (h : Subsystem A B)
    (value : Family
      (Composite (Composite A (relativeComplement A B)) (complement B))) :
    reindex Family (relativeComplementTopPathViaB h) value =
      reindex Family (relativeComplementTopPathViaA h) value :=
  reindex_path_independent Family _ _ value

end RR2021.Systems
