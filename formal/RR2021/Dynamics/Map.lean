import RR2021.Dynamics.Core

/-!
# Indexed dynamics: maps and independent properties

An `IndexedMap` stores only its component functions.  Equivariance,
surjectivity, injectivity, and action effectivity are separate propositions so
later theorem signatures expose exactly which facts they consume.
-/

namespace RR2021.Dynamics

universe u v w x

/-- A componentwise map between two system-indexed families. -/
structure IndexedMap (System : Type u) (Source : System → Type v)
    (Target : System → Type w) where
  toFun : {A : System} → Source A → Target A

namespace IndexedMap

variable {System : Type u}
variable {Source : System → Type v} {Middle : System → Type w}
variable {Target : System → Type x}

/-- The identity indexed map. -/
def id (Source : System → Type v) : IndexedMap System Source Source where
  toFun := fun value => value

/-- Componentwise composition of indexed maps. -/
def comp (g : IndexedMap System Middle Target)
    (f : IndexedMap System Source Middle) : IndexedMap System Source Target where
  toFun := fun value => g.toFun (f.toFun value)

@[simp]
theorem id_apply {A : System} (value : Source A) :
    (id Source).toFun value = value :=
  rfl

@[simp]
theorem comp_apply (g : IndexedMap System Middle Target)
    (f : IndexedMap System Source Middle) {A : System} (value : Source A) :
    (g.comp f).toFun value = g.toFun (f.toFun value) :=
  rfl

/-- Equivariance is independent of the underlying component functions. -/
def Equivariant {Transformation : System → Type x}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation Source]
    [IndexedMulAction System Transformation Middle]
    (f : IndexedMap System Source Middle) : Prop :=
  ∀ {A : System} (g : Transformation A) (state : Source A),
    f.toFun (g • state) = g • f.toFun state

/-- Componentwise surjectivity, kept separate from equivariance. -/
def Surjective (f : IndexedMap System Source Middle) : Prop :=
  ∀ A : System, Function.Surjective (f.toFun (A := A))

/-- Componentwise injectivity, kept separate from equivariance and surjectivity. -/
def Injective (f : IndexedMap System Source Middle) : Prop :=
  ∀ A : System, Function.Injective (f.toFun (A := A))

theorem id_equivariant {Transformation : System → Type x}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation Source] :
    Equivariant (Transformation := Transformation) (id Source) := by
  intro A g state
  rfl

theorem comp_equivariant {Transformation : System → Type x}
    [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation Source]
    [IndexedMulAction System Transformation Middle]
    [IndexedMulAction System Transformation Target]
    (g : IndexedMap System Middle Target) (f : IndexedMap System Source Middle)
    (hg : Equivariant (Transformation := Transformation) g)
    (hf : Equivariant (Transformation := Transformation) f) :
    Equivariant (Transformation := Transformation) (g.comp f) := by
  intro A transformation state
  rw [comp_apply, hf transformation state, hg transformation (f.toFun state)]
  rfl

theorem id_surjective : (id Source).Surjective := by
  intro A value
  exact ⟨value, rfl⟩

theorem comp_surjective (g : IndexedMap System Middle Target)
    (f : IndexedMap System Source Middle) (hg : g.Surjective) (hf : f.Surjective) :
    (g.comp f).Surjective := by
  intro A target
  obtain ⟨middle, hmiddle⟩ := hg A target
  obtain ⟨source, hsource⟩ := hf A middle
  exact ⟨source, by simp only [comp_apply, hsource, hmiddle]⟩

theorem id_injective : (id Source).Injective := by
  intro A left right equality
  exact equality

theorem comp_injective (g : IndexedMap System Middle Target)
    (f : IndexedMap System Source Middle) (hg : g.Injective) (hf : f.Injective) :
    (g.comp f).Injective := by
  intro A left right equality
  exact hf A (hg A equality)

end IndexedMap

/-- The action is effective at every index when pointwise equality forces equality. -/
def ActionEffective {System : Type u} (Transformation : System → Type v)
    (State : System → Type w) [IndexedMonoid System Transformation]
    [IndexedMulAction System Transformation State] : Prop :=
  ∀ (A : System) (g h : Transformation A),
    (∀ state : State A, g • state = h • state) → g = h

end RR2021.Dynamics
