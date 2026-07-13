# 2-SYSTEMS

Status: complete (2026-07-12)

## Current Facts

- Stage `1-SURVEY` is complete. The pinned project builds, the source ledger has 149 stable entries, the correction log has 18 entries, and the survey spikes contain no paper theorem.
- The stable public system API does not yet exist; the only related code is the survey-only `RR2021.Survey.SeparatedSystems` probe.
- Source Definition 3.1 explicitly supplies a bounded distributive lattice with unique complement, so mathlib `BooleanAlgebra` is an accurate sufficient carrier interface. Individual lemmas should expose weaker hypotheses where the proof does not need full Boolean strength.
- Definitions 3.2--3.4 respectively use meet equality for subsystem, meet-bottom for disjointness, and join for a composite of disjoint systems.
- PDF inspection corrected the Markdown rendering in Theorem 5.2: the relative complement is `C = Aᶜ ⊓ B`, not `A ⊓ B`.
- Theorem 5.2 will later need `Disjoint A C`, `A ⊔ C = B`, and `C ⊔ Bᶜ = Aᶜ` when `A ≤ B`, plus explicit transports through those system equalities.
- A second source pass exposed two hidden typing premises in that proof: `Disjoint A Bᶜ` and `Disjoint C Bᶜ`. They are required before `I_C × V_{Bᶜ}` can be typed on `Aᶜ` and before the full three-factor product is formed; the PDF states neither premise explicitly.
- The selected indexed-family encoding makes commutativity and associativity of composites propositionally, not definitionally, equal. A named reindex API is therefore required before dynamics code.

## Updated Assumptions

- `Subsystem A B` should be ordinary order `A ≤ B`; its equivalence with `A ⊓ B = A` is a theorem under a semilattice-inf order.
- `Separated A B` should use mathlib `Disjoint`, with a theorem connecting it to `A ⊓ B = ⊥` under a bounded lattice. This gives symmetry and standard order lemmas without redefining a competing relation.
- `Composite A B` is `A ⊔ B`. Separation is not baked into the value, but every product-like operation that requires a physical composite must receive the `Disjoint A B` witness separately.
- Full Boolean algebra is expected only for complement/decomposition results. Empty/global/subsystem and join associativity/commutativity lemmas should state the weaker standard typeclasses Lean accepts.
- Reindexing may be implemented by equality elimination, but raw casts must remain encapsulated in named `reindex` functions with identity, composition, inverse, commutativity, and associativity coherence theorems.
- Finite-set examples are diagnostic instances only; the abstract API must not assume finiteness or atomicity.

## Big Picture Objective

Implement a reusable, source-traceable system algebra and transport layer that expresses empty/global systems, subsystem order, disjointness, composites, complements, and the exact Boolean decompositions needed later, without importing state, dynamics, reconstruction, or quantum assumptions.

## Detailed Implementation Plan

- Add `RR2021.Systems.Core` with standard definitions/notation wrappers for subsystem, separation, composite, empty, and global systems.
- Add `RR2021.Systems.Basic` with minimal-hypothesis characterization, symmetry, bottom/top, join, complement, and relative-complement lemmas.
- Prove the corrected Theorem 5.2 decomposition for `C = Aᶜ ⊓ B`, including the three displayed identities and both hidden disjointness premises used to type reconstruction.
- Add `RR2021.Systems.Transport` with named dependent-family reindexing and coherence laws for equality composition and composite commutativity/associativity.
- Add `RR2021.Systems.Examples` with a finite Boolean algebra exercising nontrivial disjoint systems, bottom/top/complement, relative complements, and a counterexample to the false inference that one disjoint factor must be empty.
- Add a thin `RR2021.Systems.API`, a diagnostic `RR2021.Systems.Audit`, and the thin stable `RR2021.API`; update `RR2021.lean` to export the stable API rather than survey probes.
- Update the source realization log for `RR-S3-D01`--`RR-S3-D04`, `RR-S3-U01`, and the Boolean portion of `RR-S5-T02`/`RR-C009`.

## Build Structure

- `formal/RR2021/Systems/Core.lean`: cheap definitions and source terminology; lowest dependency layer.
- `formal/RR2021/Systems/Basic.lean`: lattice and Boolean proofs; imports only Core plus the required narrow mathlib algebra surface.
- `formal/RR2021/Systems/Transport.lean`: dependent equality/reindex proofs; separate because later indexed consumers need it while algebra-only consumers may not.
- `formal/RR2021/Systems/Examples.lean`: finite positive and negative tests; diagnostic leaf.
- `formal/RR2021/Systems/API.lean`: stable system re-exports only.
- `formal/RR2021/Systems/Audit.lean`: signature and axiom diagnostics; not imported publicly.
- `formal/RR2021/API.lean`: thin stable library re-export; `formal/RR2021.lean` imports it.
- Survey modules remain unchanged and outside the stable public root.
- High-fanout files touched intentionally: the new `Systems.Core`, `Systems.Transport`, `RR2021.API`, and root `RR2021.lean`. Later proof/audit material must not accumulate there.
- Focused builds: `cd formal && lake build RR2021.Systems.Core RR2021.Systems.Basic RR2021.Systems.Transport`.
- Adjacent consumers: `cd formal && lake build RR2021.Systems.Examples RR2021.Systems.API RR2021.Systems.Audit RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- Scan stable system sources for `sorry`, `admit`, placeholder tactics, project `axiom`, `opaque`, and explicit `Classical.choice`.
- Inspect every equality elimination occurrence; only the named `reindex` implementation may expose the primitive, and its coherence laws must compile.
- Confirm no state, action, quotient, reconstruction, correspondence, or quantum module is imported by `RR2021.Systems`.
- Confirm relative-complement identities are proved from explicit Boolean/order hypotheses rather than stored as project axioms.
- Confirm finite examples are not imported by `Systems.API` or used to prove abstract theorems.

## Boundary Checks

- Core/runtime: definitions and cheap algebra only.
- Proof-side: relative-complement and coherence proofs in Basic/Transport.
- Diagnostic: finite examples and axiom/signature commands in leaf modules.
- Public API: Core, Basic, and Transport only; no Survey, Examples, or Audit imports.
- `Composite A B` alone does not certify separation; operations needing a separated pair must retain the witness.
- Boolean-algebra strength is not propagated to lemmas that elaborate under weaker standard structures.

## Completion Requirements

- [x] Stable system definitions compile independently of paper-specific state/dynamics assumptions.
- [x] Exported lemmas state the weakest verified standard algebraic hypotheses and cover bottom, top, complement, disjoint join, associativity, and commutativity.
- [x] Corrected Theorem 5.2 relative-complement identities and the two hidden disjointness premises compile and are source-linked.
- [x] Named reindex identity/composition/inverse and composite commutativity/associativity coherence laws compile.
- [x] Finite examples include both nontrivial positive models and negative overstrengthening regressions.
- [x] Focused, adjacent-consumer, and full builds pass.
- [x] No-cheating/import-boundary scans, axiom audit, documentation check, `git diff --check`, and scoped status/diff review pass.
- [x] Results and exact declarations are folded into `source-ledger.md`, `0-plan.md`, and this record; Stage 3 is left resumable.

## Stage Results

### Stable modules and public surface

- Added `RR2021.Systems.Core` with transparent source terminology: `Subsystem`, `Separated`, `Composite`, `emptySystem`, `globalSystem`, and `complement`.
- Added `RR2021.Systems.Basic`. `subsystem_iff_inf_eq`/`subsystem_iff_sup_eq`, bottom/top facts, component inclusions, composite commutativity/associativity, and disjoint-join laws state their actual standard typeclass requirements. The build caught and corrected an initially overweak `SemilatticeSup` signature: disjointness over joins genuinely needs `DistribLattice`.
- Added `RR2021.Systems.Transport` with `reindex`, identity/composition/inverse laws, commutativity/associativity round trips, explicit short/long four-system paths, `reindexSupAssoc_pentagon`, and an explicit path-independence boundary.
- Added thin `RR2021.Systems.API` and `RR2021.API`; the root `RR2021.lean` now exports the stable API. Survey probes, examples, and audits are not public imports.
- Added diagnostic `RR2021.Systems.Examples` and `RR2021.Systems.Audit` leaves.

### Mathematical results and corrections

- `relativeComplement` is operation-only (`Compl` plus `Min`). Its basic separation result needs only `HeytingAlgebra`; the two covering equalities expose the necessary `BooleanAlgebra` strength.
- `relativeComplement_decomposition_typed` proves the fully typed corrected Theorem 5.2 partition for `C=Aᶜ⊓B`: `A⊥Bᶜ`, `C⊥Bᶜ`, `A⊥C`, `A⊔C=B`, and `C⊔Bᶜ=Aᶜ`.
- `relativeComplementTopPathViaB` and `relativeComplementTopPathViaA` construct the two endpoint equalities to the global system; `reindexRelativeComplement_top_coherent` proves their transports agree only after both equalities are explicit.
- `right_composite_complement` and `left_composite_complement` prove the analogous complement partition for disjoint `A,B`, needed later around Theorem 5.8.
- Finite `Finset (Fin 3)` examples exercise bottom, top, complements, nontrivial separation, commutative/associative transport, the pentagon, and the typed relative-complement path. Negative theorems refute the empty-factor inference, guard the lost-complement-bar regression, show the subsystem premise is necessary, and distinguish adjacent from pairwise separation.
- `source-ledger.md` now has an append-only Stage 2 realization table. `RR-C009` records that the displayed PDF proof also hides pairwise separation and complement-typing premises; this stage proves the Boolean/transport portion, and Stage 7 subsequently completed transformation-product descent.

### Exact verification evidence

Focused stable layer:

```text
$ cd formal && lake build RR2021.Systems.Core RR2021.Systems.Basic RR2021.Systems.Transport
Build completed successfully (362 jobs).
```

Finite tests and adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Systems.Examples RR2021.Systems.API RR2021.Systems.Audit RR2021.API RR2021
Build completed successfully (622 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (366 jobs).
```

The final `Systems.Audit` reported:

- `relativeComplement_disjoint`, `subsystem_separated_complement`, `relativeComplement_separated_complement`, `reindex_comp`, and `reindex_inverse`: no axioms.
- Boolean covering/decomposition results and the relative-complement path coherence: `[propext, Classical.choice, Quot.sound]`, inherited from the standard mathlib Boolean surface.
- Commutativity/associativity round trips and the four-system pentagon: `[propext]` only.
- No result depends on a project-specific axiom.

Boundary scans on the final tree:

```text
$ rg -n '\bsorry\b|\badmit\b|by_contra!|^[[:space:]]*(axiom|opaque)\b' formal/RR2021 formal/RR2021.lean
# no matches (exit 1)

$ rg -n 'Classical\.choice' formal/RR2021/Systems formal/RR2021/API.lean formal/RR2021.lean
# no explicit calls (exit 1)

$ rg -n 'Eq\.(rec|ndrec)|\bcast\b|▸' formal/RR2021/Systems
formal/RR2021/Systems/Transport.lean:18: fun value => h ▸ value

$ rg -n 'Survey|Examples|Audit|Dynamics|Theory|Reconstruction|Quantum' formal/RR2021/Systems/API.lean formal/RR2021/API.lean formal/RR2021.lean
# only the Systems.API documentation sentence saying Examples/Audit are excluded;
# no import leak

$ python3 scripts/check_stage1_docs.py
Stage-1 documentation check passed: 88 distinct numbered source declarations covered.

$ git diff --check
# exit 0, no output
```

The scoped import and source diffs were reviewed. `git status --short` contains only planned Goal 1 changes; generated Lake artifacts remain ignored. All stages are now complete; final release evidence is recorded in `goal-1/12-RELEASE.md`.
