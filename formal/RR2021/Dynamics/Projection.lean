import RR2021.Dynamics.Map
import RR2021.Systems.Transport

/-!
# Indexed dynamics: projectors

The minimal projector family stores only projection and nesting.  Surjectivity
is a separate predicate, and self-projection identity is derived from those two
ingredients.  Domain transports use the named `Systems.reindex` operation.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v w

/-- System-indexed projectors with only the nested-projection law stored. -/
structure ProjectorFamily (System : Type u) [Preorder System]
    (State : System → Type v) where
  project : {A B : System} → Subsystem A B → State B → State A
  nested : ∀ {A B C : System} (hAB : Subsystem A B) (hBC : Subsystem B C)
    (state : State C),
    project hAB (project hBC state) = project (hAB.trans hBC) state

namespace ProjectorFamily

variable {System : Type u}
variable {State : System → Type v}

/-- Surjectivity is deliberately not a field of `ProjectorFamily`. -/
def Surjective [Preorder System] (projectors : ProjectorFamily System State) : Prop :=
  ∀ {A B : System} (hAB : Subsystem A B),
    Function.Surjective (projectors.project hAB)

/-- Self-projection identity derived from nesting plus explicit surjectivity. -/
theorem project_self [Preorder System] (projectors : ProjectorFamily System State)
    (surjective : projectors.Surjective) {A : System} (state : State A) :
    projectors.project (A := A) (B := A) le_rfl state = state := by
  obtain ⟨preimage, hpreimage⟩ :=
    surjective (A := A) (B := A) le_rfl state
  calc
    projectors.project le_rfl state =
        projectors.project le_rfl (projectors.project le_rfl preimage) :=
      congrArg (projectors.project (A := A) (B := A) le_rfl) hpreimage.symm
    _ = projectors.project (le_rfl.trans le_rfl) preimage :=
      projectors.nested le_rfl le_rfl preimage
    _ = state := by simpa only using hpreimage

/-- Projection is independent of the proof of a fixed subsystem relation. -/
theorem project_proof_irrelevant [Preorder System]
    (projectors : ProjectorFamily System State)
    {A B : System} (first second : Subsystem A B) (state : State B) :
    projectors.project first state = projectors.project second state := by
  have proof_eq : first = second := Subsingleton.elim _ _
  subst second
  rfl

/-- Project a composite state to its left component. -/
def projectLeft [SemilatticeSup System] (projectors : ProjectorFamily System State)
    {A B : System} : State (Composite A B) → State A :=
  projectors.project le_sup_left

/-- Project a composite state to its right component. -/
def projectRight [SemilatticeSup System] (projectors : ProjectorFamily System State)
    {A B : System} : State (Composite A B) → State B :=
  projectors.project le_sup_right

theorem projectLeft_surjective [SemilatticeSup System]
    (projectors : ProjectorFamily System State) (surjective : projectors.Surjective)
    {A B : System} : Function.Surjective (projectors.projectLeft (A := A) (B := B)) := by
  change Function.Surjective
    (projectors.project (show Subsystem A (Composite A B) from le_sup_left))
  exact surjective le_sup_left

theorem projectRight_surjective [SemilatticeSup System]
    (projectors : ProjectorFamily System State) (surjective : projectors.Surjective)
    {A B : System} : Function.Surjective (projectors.projectRight (A := A) (B := B)) := by
  change Function.Surjective
    (projectors.project (show Subsystem B (Composite A B) from le_sup_right))
  exact surjective le_sup_right

/-- Reindex an upper-domain subsystem proof through equality of domains. -/
def reindexSubsystemDomain [Preorder System] {A B C : System} (domainEq : B = C)
    (hAB : Subsystem A B) : Subsystem A C :=
  reindex (fun domain => Subsystem A domain) domainEq hAB

/-- Projection is coherent with named reindexing of its domain. -/
theorem project_reindex_domain [Preorder System]
    (projectors : ProjectorFamily System State)
    {A B C : System} (domainEq : B = C) (hAB : Subsystem A B)
    (state : State B) :
    projectors.project (reindexSubsystemDomain domainEq hAB)
        (reindex State domainEq state) =
      projectors.project hAB state := by
  subst C
  rfl

/-- Projection is coherent when both its source and target system indices are
reindexed by already-proved equalities. -/
theorem project_reindex [Preorder System]
    (projectors : ProjectorFamily System State)
    {A A' B B' : System} (targetEq : A = A') (domainEq : B = B')
    (hAB : Subsystem A B) (hA'B' : Subsystem A' B') (state : State B) :
    projectors.project hA'B' (reindex State domainEq state) =
      reindex State targetEq (projectors.project hAB state) := by
  subst A'
  subst B'
  exact projectors.project_proof_irrelevant _ _ state

/-- Swapping a composite domain exchanges the left and right projection views. -/
theorem projectRight_reindexSupComm [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B : System}
    (state : State (Composite A B)) :
    projectors.projectRight (A := B) (B := A)
        (reindex State (sup_comm A B) state) =
      projectors.projectLeft (A := A) (B := B) state := by
  simpa only [projectRight, projectLeft] using
    project_reindex_domain projectors (sup_comm A B)
      (show Subsystem A (Composite A B) from le_sup_left) state

/-- Swapping a composite domain also sends its left view to the old right view. -/
theorem projectLeft_reindexSupComm [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B : System}
    (state : State (Composite A B)) :
    projectors.projectLeft (A := B) (B := A)
        (reindex State (sup_comm A B) state) =
      projectors.projectRight (A := A) (B := B) state := by
  simpa only [projectLeft, projectRight] using
    project_reindex_domain projectors (sup_comm A B)
      (show Subsystem B (Composite A B) from le_sup_right) state

/-- Two successive left projections equal the corresponding direct projection. -/
theorem projectLeft_projectLeft [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite (Composite A B) C)) :
    projectors.projectLeft (A := A) (B := B)
        (projectors.projectLeft (A := Composite A B) (B := C) state) =
      projectors.project
        (show Subsystem A (Composite (Composite A B) C) from
          le_sup_left.trans le_sup_left)
        state := by
  simpa only [projectLeft] using
    projectors.nested
      (show Subsystem A (Composite A B) from le_sup_left)
      (show Subsystem (Composite A B) (Composite (Composite A B) C) from le_sup_left)
      state

/-- Right-after-left projection equals the corresponding direct projection. -/
theorem projectRight_projectLeft [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite (Composite A B) C)) :
    projectors.projectRight (A := A) (B := B)
        (projectors.projectLeft (A := Composite A B) (B := C) state) =
      projectors.project
        (show Subsystem B (Composite (Composite A B) C) from
          le_sup_right.trans le_sup_left)
        state := by
  simpa only [projectLeft, projectRight] using
    projectors.nested
      (show Subsystem B (Composite A B) from le_sup_right)
      (show Subsystem (Composite A B) (Composite (Composite A B) C) from le_sup_left)
      state

/-- Left-after-right projection equals the corresponding direct projection. -/
theorem projectLeft_projectRight [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite A (Composite B C))) :
    projectors.projectLeft (A := B) (B := C)
        (projectors.projectRight (A := A) (B := Composite B C) state) =
      projectors.project
        (show Subsystem B (Composite A (Composite B C)) from
          le_sup_left.trans le_sup_right)
        state := by
  simpa only [projectLeft, projectRight] using
    projectors.nested
      (show Subsystem B (Composite B C) from le_sup_left)
      (show Subsystem (Composite B C) (Composite A (Composite B C)) from le_sup_right)
      state

/-- Two successive right projections equal the corresponding direct projection. -/
theorem projectRight_projectRight [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite A (Composite B C))) :
    projectors.projectRight (A := B) (B := C)
        (projectors.projectRight (A := A) (B := Composite B C) state) =
      projectors.project
        (show Subsystem C (Composite A (Composite B C)) from
          le_sup_right.trans le_sup_right)
        state := by
  simpa only [projectRight] using
    projectors.nested
      (show Subsystem C (Composite B C) from le_sup_right)
      (show Subsystem (Composite B C) (Composite A (Composite B C)) from le_sup_right)
      state

/-- Reassociating a triple domain preserves projection to its leftmost system. -/
theorem project_reindexSupAssoc_left [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite (Composite A B) C)) :
    projectors.project
        (show Subsystem A (Composite A (Composite B C)) from le_sup_left)
        (reindex State (sup_assoc A B C) state) =
      projectors.project
        (show Subsystem A (Composite (Composite A B) C) from
          le_sup_left.trans le_sup_left)
        state := by
  simpa only using
    project_reindex_domain projectors (sup_assoc A B C)
      (show Subsystem A (Composite (Composite A B) C) from
        le_sup_left.trans le_sup_left)
      state

/-- Reassociating a triple domain preserves projection to its rightmost system. -/
theorem project_reindexSupAssoc_right [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite (Composite A B) C)) :
    projectors.project
        (show Subsystem C (Composite A (Composite B C)) from
          le_sup_right.trans le_sup_right)
        (reindex State (sup_assoc A B C) state) =
      projectors.project
        (show Subsystem C (Composite (Composite A B) C) from le_sup_right)
        state := by
  simpa only using
    project_reindex_domain projectors (sup_assoc A B C)
      (show Subsystem C (Composite (Composite A B) C) from le_sup_right)
      state

/-- After reassociation, the outer right projection is the old direct `B ⊔ C` view. -/
theorem projectRight_reindexSupAssoc [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite (Composite A B) C)) :
    projectors.projectRight (A := A) (B := Composite B C)
        (reindex State (sup_assoc A B C) state) =
      projectors.project
        (show Subsystem (Composite B C) (Composite (Composite A B) C) from
          sup_le (le_sup_right.trans le_sup_left) le_sup_right)
        state := by
  simpa only [projectRight] using
    project_reindex_domain projectors (sup_assoc A B C)
      (show Subsystem (Composite B C) (Composite (Composite A B) C) from
        sup_le (le_sup_right.trans le_sup_left) le_sup_right)
      state

/-- Reverse reassociation sends the outer left projection to the old direct `A ⊔ B` view. -/
theorem projectLeft_reindexSupAssocInv [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite A (Composite B C))) :
    projectors.projectLeft (A := Composite A B) (B := C)
        (reindex State (sup_assoc A B C).symm state) =
      projectors.project
        (show Subsystem (Composite A B) (Composite A (Composite B C)) from
          sup_le le_sup_left (le_sup_left.trans le_sup_right))
        state := by
  simpa only [projectLeft] using
    project_reindex_domain projectors (sup_assoc A B C).symm
      (show Subsystem (Composite A B) (Composite A (Composite B C)) from
        sup_le le_sup_left (le_sup_left.trans le_sup_right))
      state

/-- Reverse reassociation preserves the rightmost projection through nesting. -/
theorem projectRight_reindexSupAssocInv [SemilatticeSup System]
    (projectors : ProjectorFamily System State) {A B C : System}
    (state : State (Composite A (Composite B C))) :
    projectors.projectRight (A := Composite A B) (B := C)
        (reindex State (sup_assoc A B C).symm state) =
      projectors.projectRight (A := B) (B := C)
        (projectors.projectRight (A := A) (B := Composite B C) state) := by
  calc
    projectors.projectRight
        (reindex State (sup_assoc A B C).symm state) =
      projectors.project
        (show Subsystem C (Composite A (Composite B C)) from
          le_sup_right.trans le_sup_right)
        state := by
      simpa only [projectRight] using
        project_reindex_domain projectors (sup_assoc A B C).symm
          (show Subsystem C (Composite A (Composite B C)) from
            le_sup_right.trans le_sup_right)
          state
    _ = projectors.projectRight
        (projectors.projectRight (A := A) (B := Composite B C) state) :=
      (projectors.projectRight_projectRight state).symm

end ProjectorFamily

/-- Compatibility of an indexed map with two independently supplied projectors. -/
def ProjectionCompatible {System : Type u} [Preorder System]
    {Source : System → Type v} {Target : System → Type w}
    (map : IndexedMap System Source Target)
    (sourceProjectors : ProjectorFamily System Source)
    (targetProjectors : ProjectorFamily System Target) : Prop :=
  ∀ {A B : System} (hAB : Subsystem A B) (state : Source B),
    map.toFun (sourceProjectors.project hAB state) =
      targetProjectors.project hAB (map.toFun state)

end RR2021.Dynamics
