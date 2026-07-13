import RR2021.Dynamics.Map
import RR2021.Systems.Transport

/-!
# Indexed dynamics: equality coherence

These lemmas expose how standard monoid operations, scalar actions, and indexed
maps commute with a proved equality of system indices.  They add no mathematical
axiom: every proof is equality elimination after the endpoint equality is given.
-/

namespace RR2021.Dynamics

open RR2021.Systems

universe u v w x

variable {System : Type u}
variable {Transformation : System → Type v}
variable {Source : System → Type w} {Target : System → Type x}

/-- Reindexing preserves the identity transformation. -/
@[simp]
theorem reindex_one [IndexedMonoid System Transformation]
    {A B : System} (h : A = B) :
    reindex Transformation h (1 : Transformation A) =
      (1 : Transformation B) := by
  subst B
  rfl

/-- Reindexing preserves transformation multiplication. -/
@[simp]
theorem reindex_mul [IndexedMonoid System Transformation]
    {A B : System} (h : A = B) (g k : Transformation A) :
    reindex Transformation h (g * k) =
      reindex Transformation h g * reindex Transformation h k := by
  subst B
  rfl

/-- Reindexing a state and transformation preserves their scalar action. -/
@[simp]
theorem reindex_smul [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation Source]
    {A B : System} (h : A = B) (g : Transformation A) (state : Source A) :
    reindex Source h (g • state) =
      reindex Transformation h g • reindex Source h state := by
  subst B
  rfl

/-- Every indexed map is coherent with equality reindexing of both families. -/
@[simp]
theorem IndexedMap.reindex_apply (map : IndexedMap System Source Target)
    {A B : System} (h : A = B) (state : Source A) :
    reindex Target h (map.toFun state) =
      map.toFun (reindex Source h state) := by
  subst B
  rfl

end RR2021.Dynamics
