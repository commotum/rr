import RR2021.Dynamics.StateProduct

/-!
# Indexed dynamics: state-product coherence

Binary commutativity and triple definedness/associativity are derived from
actual common extensions.  No coherence law is stored in `StateProduct`.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v

section Binary

variable {System : Type u} [SemilatticeSup System] [OrderBot System]
variable {State : System → Type v}
variable {projectors : ProjectorFamily System State}

/-- Compatibility is symmetric after reindexing a common extension by `sup_comm`. -/
theorem compatible_swap {A B : System} {left : State A} {right : State B}
    (compatible : Compatible projectors left right) :
    Compatible projectors right left := by
  obtain ⟨hsep, whole, left_eq, right_eq⟩ := compatible
  refine ⟨hsep.symm, reindex State (sup_comm A B) whole, ?_, ?_⟩
  · calc
      projectors.projectLeft (reindex State (sup_comm A B) whole) =
          projectors.projectRight whole :=
        projectors.projectLeft_reindexSupComm whole
      _ = right := right_eq
  · calc
      projectors.projectRight (reindex State (sup_comm A B) whole) =
          projectors.projectLeft whole :=
        projectors.projectRight_reindexSupComm whole
      _ = left := left_eq

/--
Corrected Theorem 3.5: a defined product commutes after the named system-index
reindex, with compatibility and separation evidence explicit.
-/
theorem StateProduct.product_comm (products : StateProduct projectors)
    {A B : System} (left : State A) (right : State B) (hsep : Separated A B)
    (compatible : Compatible projectors left right) :
    reindex State (sup_comm A B)
        (products.product left right hsep compatible) =
      products.product right left hsep.symm (compatible_swap compatible) := by
  symm
  apply products.product_eq_common_extension
  · calc
      projectors.projectLeft
          (reindex State (sup_comm A B)
            (products.product left right hsep compatible)) =
          projectors.projectRight (products.product left right hsep compatible) :=
        projectors.projectLeft_reindexSupComm _
      _ = right := products.project_right left right hsep compatible
  · calc
      projectors.projectRight
          (reindex State (sup_comm A B)
            (products.product left right hsep compatible)) =
          projectors.projectLeft (products.product left right hsep compatible) :=
        projectors.projectRight_reindexSupComm _
      _ = left := products.project_left left right hsep compatible

end Binary

section Triple

variable {System : Type u} [DistribLattice System] [OrderBot System]
variable {State : System → Type v}
variable {projectors : ProjectorFamily System State}

/-- Pairwise separation gives separation of the left composite from `C`. -/
def leftOuterSeparated {A B C : System} (hAC : Separated A C)
    (hBC : Separated B C) : Separated (Composite A B) C :=
  hAC.sup_left hBC

/-- Pairwise separation gives separation of `A` from the right composite. -/
def rightOuterSeparated {A B C : System} (hAB : Separated A B)
    (hAC : Separated A C) : Separated A (Composite B C) :=
  hAB.sup_right hAC

/-- The `B ⊔ C` subsystem inside the left-associated triple. -/
def subsystemBCLeftAssoc (A B C : System) :
    Subsystem (Composite B C) (Composite (Composite A B) C) :=
  sup_le (le_sup_right.trans le_sup_left) le_sup_right

/-- The `A ⊔ B` subsystem inside the right-associated triple. -/
def subsystemABRightAssoc (A B C : System) :
    Subsystem (Composite A B) (Composite A (Composite B C)) :=
  sup_le le_sup_left (le_sup_left.trans le_sup_right)

/-- The left-nested product is defined through inner then outer compatibility. -/
def StateProduct.LeftDefined (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (_hAC : Separated A C)
    (_hBC : Separated B C) (a : State A) (b : State B) (c : State C) : Prop :=
  ∃ hab : Compatible projectors a b,
    Compatible projectors (products.product a b hAB hab) c

/-- The right-nested product is defined through inner then outer compatibility. -/
def StateProduct.RightDefined (products : StateProduct projectors)
    {A B C : System} (_hAB : Separated A B) (_hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C) : Prop :=
  ∃ hbc : Compatible projectors b c,
    Compatible projectors a (products.product b c hBC hbc)

/-- Left-definedness supplies an actual extension from which right-definedness follows. -/
theorem StateProduct.leftDefined_to_rightDefined (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C) :
    products.LeftDefined hAB hAC hBC a b c →
      products.RightDefined hAB hAC hBC a b c := by
  rintro ⟨hab, hab_c⟩
  obtain ⟨whole, wholeAB_eq, wholeC_eq⟩ := hab_c.2
  let wholeBC : State (Composite B C) :=
    projectors.project (subsystemBCLeftAssoc A B C) whole
  have wholeBC_left : projectors.projectLeft wholeBC = b := by
    calc
      projectors.projectLeft wholeBC =
          projectors.project
            (show Subsystem B (Composite (Composite A B) C) from
              le_sup_left.trans (subsystemBCLeftAssoc A B C))
            whole := by
        simpa only [wholeBC, ProjectorFamily.projectLeft] using
          projectors.nested
            (show Subsystem B (Composite B C) from le_sup_left)
            (subsystemBCLeftAssoc A B C) whole
      _ = projectors.project
          (show Subsystem B (Composite (Composite A B) C) from
            le_sup_right.trans le_sup_left)
          whole := rfl
      _ = projectors.projectRight
          (projectors.projectLeft (A := Composite A B) (B := C) whole) :=
        (projectors.projectRight_projectLeft whole).symm
      _ = projectors.projectRight (products.product a b hAB hab) :=
        congrArg (projectors.projectRight (A := A) (B := B)) wholeAB_eq
      _ = b := products.project_right a b hAB hab
  have wholeBC_right : projectors.projectRight wholeBC = c := by
    calc
      projectors.projectRight wholeBC =
          projectors.project
            (show Subsystem C (Composite (Composite A B) C) from
              le_sup_right.trans (subsystemBCLeftAssoc A B C))
            whole := by
        simpa only [wholeBC, ProjectorFamily.projectRight] using
          projectors.nested
            (show Subsystem C (Composite B C) from le_sup_right)
            (subsystemBCLeftAssoc A B C) whole
      _ = projectors.projectRight (A := Composite A B) (B := C) whole := rfl
      _ = c := wholeC_eq
  have hbc : Compatible projectors b c :=
    ⟨hBC, wholeBC, wholeBC_left, wholeBC_right⟩
  have productBC_eq : products.product b c hBC hbc = wholeBC :=
    products.product_eq_common_extension b c hBC hbc wholeBC
      wholeBC_left wholeBC_right
  let wholeR : State (Composite A (Composite B C)) :=
    reindex State (sup_assoc A B C) whole
  have wholeR_left : projectors.projectLeft wholeR = a := by
    calc
      projectors.projectLeft wholeR =
          projectors.project
            (show Subsystem A (Composite (Composite A B) C) from
              le_sup_left.trans le_sup_left)
            whole := by
        simpa only [wholeR, ProjectorFamily.projectLeft] using
          projectors.project_reindexSupAssoc_left whole
      _ = projectors.projectLeft
          (projectors.projectLeft (A := Composite A B) (B := C) whole) :=
        (projectors.projectLeft_projectLeft whole).symm
      _ = projectors.projectLeft (products.product a b hAB hab) :=
        congrArg (projectors.projectLeft (A := A) (B := B)) wholeAB_eq
      _ = a := products.project_left a b hAB hab
  have wholeR_right :
      projectors.projectRight wholeR = products.product b c hBC hbc := by
    calc
      projectors.projectRight wholeR =
          projectors.project (subsystemBCLeftAssoc A B C) whole := by
        simpa only [wholeR] using projectors.projectRight_reindexSupAssoc whole
      _ = wholeBC := rfl
      _ = products.product b c hBC hbc := productBC_eq.symm
  exact ⟨hbc, rightOuterSeparated hAB hAC, wholeR, wholeR_left, wholeR_right⟩

/-- Right-definedness supplies an actual extension from which left-definedness follows. -/
theorem StateProduct.rightDefined_to_leftDefined (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C) :
    products.RightDefined hAB hAC hBC a b c →
      products.LeftDefined hAB hAC hBC a b c := by
  rintro ⟨hbc, ha_bc⟩
  obtain ⟨whole, wholeA_eq, wholeBC_eq⟩ := ha_bc.2
  let wholeAB : State (Composite A B) :=
    projectors.project (subsystemABRightAssoc A B C) whole
  have wholeAB_left : projectors.projectLeft wholeAB = a := by
    calc
      projectors.projectLeft wholeAB =
          projectors.project
            (show Subsystem A (Composite A (Composite B C)) from
              le_sup_left.trans (subsystemABRightAssoc A B C))
            whole := by
        simpa only [wholeAB, ProjectorFamily.projectLeft] using
          projectors.nested
            (show Subsystem A (Composite A B) from le_sup_left)
            (subsystemABRightAssoc A B C) whole
      _ = projectors.projectLeft (A := A) (B := Composite B C) whole := rfl
      _ = a := wholeA_eq
  have wholeAB_right : projectors.projectRight wholeAB = b := by
    calc
      projectors.projectRight wholeAB =
          projectors.project
            (show Subsystem B (Composite A (Composite B C)) from
              le_sup_right.trans (subsystemABRightAssoc A B C))
            whole := by
        simpa only [wholeAB, ProjectorFamily.projectRight] using
          projectors.nested
            (show Subsystem B (Composite A B) from le_sup_right)
            (subsystemABRightAssoc A B C) whole
      _ = projectors.project
          (show Subsystem B (Composite A (Composite B C)) from
            le_sup_left.trans le_sup_right)
          whole := rfl
      _ = projectors.projectLeft
          (projectors.projectRight (A := A) (B := Composite B C) whole) :=
        (projectors.projectLeft_projectRight whole).symm
      _ = projectors.projectLeft (products.product b c hBC hbc) :=
        congrArg (projectors.projectLeft (A := B) (B := C)) wholeBC_eq
      _ = b := products.project_left b c hBC hbc
  have hab : Compatible projectors a b :=
    ⟨hAB, wholeAB, wholeAB_left, wholeAB_right⟩
  have productAB_eq : products.product a b hAB hab = wholeAB :=
    products.product_eq_common_extension a b hAB hab wholeAB
      wholeAB_left wholeAB_right
  let wholeL : State (Composite (Composite A B) C) :=
    reindex State (sup_assoc A B C).symm whole
  have wholeL_left :
      projectors.projectLeft wholeL = products.product a b hAB hab := by
    calc
      projectors.projectLeft wholeL =
          projectors.project (subsystemABRightAssoc A B C) whole := by
        simpa only [wholeL] using projectors.projectLeft_reindexSupAssocInv whole
      _ = wholeAB := rfl
      _ = products.product a b hAB hab := productAB_eq.symm
  have wholeL_right : projectors.projectRight wholeL = c := by
    calc
      projectors.projectRight wholeL =
          projectors.projectRight
            (projectors.projectRight (A := A) (B := Composite B C) whole) := by
        simpa only [wholeL] using projectors.projectRight_reindexSupAssocInv whole
      _ = projectors.projectRight (products.product b c hBC hbc) :=
        congrArg (projectors.projectRight (A := B) (B := C)) wholeBC_eq
      _ = c := products.project_right b c hBC hbc
  exact ⟨hab, leftOuterSeparated hAC hBC, wholeL, wholeL_left, wholeL_right⟩

/-- Triple definedness is equivalent in both nestings, proved from actual extensions. -/
theorem StateProduct.leftDefined_iff_rightDefined (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C) :
    products.LeftDefined hAB hAC hBC a b c ↔
      products.RightDefined hAB hAC hBC a b c :=
  ⟨products.leftDefined_to_rightDefined hAB hAC hBC a b c,
    products.rightDefined_to_leftDefined hAB hAC hBC a b c⟩

/--
Corrected triple associativity: both inner and outer compatibility witnesses
are explicit, and the two codomains are compared through `sup_assoc` reindexing.
-/
theorem StateProduct.product_assoc (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C)
    (hab : Compatible projectors a b)
    (hab_c : Compatible projectors (products.product a b hAB hab) c)
    (hbc : Compatible projectors b c)
    (ha_bc : Compatible projectors a (products.product b c hBC hbc)) :
    reindex State (sup_assoc A B C)
        (products.product (products.product a b hAB hab) c
          (leftOuterSeparated hAC hBC) hab_c) =
      products.product a (products.product b c hBC hbc)
        (rightOuterSeparated hAB hAC) ha_bc := by
  let whole : State (Composite (Composite A B) C) :=
    products.product (products.product a b hAB hab) c
      (leftOuterSeparated hAC hBC) hab_c
  let wholeBC : State (Composite B C) :=
    projectors.project (subsystemBCLeftAssoc A B C) whole
  have wholeBC_left : projectors.projectLeft wholeBC = b := by
    calc
      projectors.projectLeft wholeBC =
          projectors.project
            (show Subsystem B (Composite (Composite A B) C) from
              le_sup_left.trans (subsystemBCLeftAssoc A B C))
            whole := by
        simpa only [wholeBC, ProjectorFamily.projectLeft] using
          projectors.nested
            (show Subsystem B (Composite B C) from le_sup_left)
            (subsystemBCLeftAssoc A B C) whole
      _ = projectors.project
          (show Subsystem B (Composite (Composite A B) C) from
            le_sup_right.trans le_sup_left)
          whole := rfl
      _ = projectors.projectRight
          (projectors.projectLeft (A := Composite A B) (B := C) whole) :=
        (projectors.projectRight_projectLeft whole).symm
      _ = projectors.projectRight (products.product a b hAB hab) := by
        apply congrArg (projectors.projectRight (A := A) (B := B))
        exact products.project_left _ c (leftOuterSeparated hAC hBC) hab_c
      _ = b := products.project_right a b hAB hab
  have wholeBC_right : projectors.projectRight wholeBC = c := by
    calc
      projectors.projectRight wholeBC =
          projectors.project
            (show Subsystem C (Composite (Composite A B) C) from
              le_sup_right.trans (subsystemBCLeftAssoc A B C))
            whole := by
        simpa only [wholeBC, ProjectorFamily.projectRight] using
          projectors.nested
            (show Subsystem C (Composite B C) from le_sup_right)
            (subsystemBCLeftAssoc A B C) whole
      _ = projectors.projectRight (A := Composite A B) (B := C) whole := rfl
      _ = c := products.project_right _ c (leftOuterSeparated hAC hBC) hab_c
  have productBC_eq : products.product b c hBC hbc = wholeBC :=
    products.product_eq_common_extension b c hBC hbc wholeBC
      wholeBC_left wholeBC_right
  let wholeR : State (Composite A (Composite B C)) :=
    reindex State (sup_assoc A B C) whole
  have wholeR_left : projectors.projectLeft wholeR = a := by
    calc
      projectors.projectLeft wholeR =
          projectors.project
            (show Subsystem A (Composite (Composite A B) C) from
              le_sup_left.trans le_sup_left)
            whole := by
        simpa only [wholeR, ProjectorFamily.projectLeft] using
          projectors.project_reindexSupAssoc_left whole
      _ = projectors.projectLeft
          (projectors.projectLeft (A := Composite A B) (B := C) whole) :=
        (projectors.projectLeft_projectLeft whole).symm
      _ = projectors.projectLeft (products.product a b hAB hab) := by
        apply congrArg (projectors.projectLeft (A := A) (B := B))
        exact products.project_left _ c (leftOuterSeparated hAC hBC) hab_c
      _ = a := products.project_left a b hAB hab
  have wholeR_right :
      projectors.projectRight wholeR = products.product b c hBC hbc := by
    calc
      projectors.projectRight wholeR =
          projectors.project (subsystemBCLeftAssoc A B C) whole := by
        simpa only [wholeR] using projectors.projectRight_reindexSupAssoc whole
      _ = wholeBC := rfl
      _ = products.product b c hBC hbc := productBC_eq.symm
  exact (products.product_eq_common_extension
    a (products.product b c hBC hbc) (rightOuterSeparated hAB hAC) ha_bc
    wholeR wholeR_left wholeR_right).symm

/--
Corrected Theorem 3.7 for a left-nested product: equality with a whole state is
equivalent to its three direct projections, with all definedness explicit.
-/
theorem StateProduct.leftNestedProduct_eq_iff_direct_projections
    (products : StateProduct projectors)
    {A B C : System} (hAB : Separated A B) (hAC : Separated A C)
    (hBC : Separated B C) (a : State A) (b : State B) (c : State C)
    (hab : Compatible projectors a b)
    (hab_c : Compatible projectors (products.product a b hAB hab) c)
    (whole : State (Composite (Composite A B) C)) :
    products.product (products.product a b hAB hab) c
        (leftOuterSeparated hAC hBC) hab_c = whole ↔
      projectors.project
          (show Subsystem A (Composite (Composite A B) C) from
            le_sup_left.trans le_sup_left)
          whole = a ∧
        projectors.project
            (show Subsystem B (Composite (Composite A B) C) from
              le_sup_right.trans le_sup_left)
            whole = b ∧
          projectors.project
              (show Subsystem C (Composite (Composite A B) C) from le_sup_right)
              whole = c := by
  constructor
  · intro equality
    subst whole
    constructor
    · calc
        projectors.project
            (show Subsystem A (Composite (Composite A B) C) from
              le_sup_left.trans le_sup_left)
            (products.product (products.product a b hAB hab) c
              (leftOuterSeparated hAC hBC) hab_c) =
            projectors.projectLeft
              (projectors.projectLeft
                (products.product (products.product a b hAB hab) c
                  (leftOuterSeparated hAC hBC) hab_c)) :=
          (projectors.projectLeft_projectLeft _).symm
        _ = projectors.projectLeft (products.product a b hAB hab) := by
          apply congrArg (projectors.projectLeft (A := A) (B := B))
          exact products.project_left _ c (leftOuterSeparated hAC hBC) hab_c
        _ = a := products.project_left a b hAB hab
    · constructor
      · calc
          projectors.project
              (show Subsystem B (Composite (Composite A B) C) from
                le_sup_right.trans le_sup_left)
              (products.product (products.product a b hAB hab) c
                (leftOuterSeparated hAC hBC) hab_c) =
              projectors.projectRight
                (projectors.projectLeft
                  (products.product (products.product a b hAB hab) c
                    (leftOuterSeparated hAC hBC) hab_c)) :=
            (projectors.projectRight_projectLeft _).symm
          _ = projectors.projectRight (products.product a b hAB hab) := by
            apply congrArg (projectors.projectRight (A := A) (B := B))
            exact products.project_left _ c (leftOuterSeparated hAC hBC) hab_c
          _ = b := products.project_right a b hAB hab
      · exact products.project_right _ c (leftOuterSeparated hAC hBC) hab_c
  · rintro ⟨wholeA_eq, wholeB_eq, wholeC_eq⟩
    apply (products.product_eq_iff_projections
      (products.product a b hAB hab) c (leftOuterSeparated hAC hBC) hab_c whole).2
    constructor
    · apply products.eq_of_projections hAB
      · calc
          projectors.projectLeft
              (projectors.projectLeft (A := Composite A B) (B := C) whole) =
              projectors.project
                (show Subsystem A (Composite (Composite A B) C) from
                  le_sup_left.trans le_sup_left)
                whole := projectors.projectLeft_projectLeft whole
          _ = a := wholeA_eq
          _ = projectors.projectLeft (products.product a b hAB hab) :=
            (products.project_left a b hAB hab).symm
      · calc
          projectors.projectRight
              (projectors.projectLeft (A := Composite A B) (B := C) whole) =
              projectors.project
                (show Subsystem B (Composite (Composite A B) C) from
                  le_sup_right.trans le_sup_left)
                whole := projectors.projectRight_projectLeft whole
          _ = b := wholeB_eq
          _ = projectors.projectRight (products.product a b hAB hab) :=
            (products.project_right a b hAB hab).symm
    · simpa only [ProjectorFamily.projectRight] using wholeC_eq

end Triple

end RR2021.Dynamics
