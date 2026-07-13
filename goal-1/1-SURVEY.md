# 1-SURVEY

Status: complete (2026-07-12)

## Current Facts

- Inspection on 2026-07-12 found no Lean sources, `formal/` directory, Lake configuration, repository toolchain pin, stage report, source ledger, correction log, or architecture record.
- `lake build` at repository root fails with `no configuration file with a supported extension`; this is positive evidence that the project is not yet bootstrapped.
- The ambient toolchain is Lean `4.31.0`, commit `68218e876d2a38b1985b8590fff244a83c321783`, with Lake `5.0.0-src+68218e8`. It is resolved from the user's global `stable` default and is not repository evidence.
- A compatible local mathlib checkout is at exact commit `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`; its checked-in `lean-toolchain` is `leanprover/lean4:v4.31.0`.
- The primary converted source is 3,014 lines. The mathematical scope for this stage is Sections 3--5 and Appendices A--C; operative claims outside those sections must still receive an explicit scope classification.
- The initial worktree was clean at commit `ce8fa8e`.

## Updated Assumptions

- A Boolean algebra is a justified *initial sufficient* system interface because the source explicitly assumes bounded distributive lattice operations and a unique complement. Stage 2 must still minimize hypotheses theorem by theorem; Stage 1 does not claim Boolean strength is necessary everywhere.
- Paper composition is written so that `(U \u2218 V)` acts as `U` after `V`. Lean's standard left `MulAction` convention is expected to match this orientation, but the spike must compile an explicit witness law before this is trusted.
- System-indexed state spaces will be represented as families `System \u2192 Type`; equality-induced reindexing must be isolated behind named helpers and later coherence lemmas rather than scattered casts.
- Quotient encodings may use `Setoid` and `Quotient` only after explicit equivalence and congruence proofs. The spike must contain a named representative-independence theorem next to each descent.
- A partial state product should consume evidence of compatibility (for example, a compatible-pair structure carrying a common extension). It must not return an arbitrary value for incompatible inputs.
- Finite-dimensional quantum infrastructure is not imported by abstract or Stage 1 modules.

## Big Picture Objective

Establish a reproducible, pinned Lean/mathlib project and an authoritative, dependency-aware mathematical ledger before declaring any paper theorem or committing later stages to high-fanout abstractions.

## Detailed Implementation Plan

- Create `goal-1/source-ledger.md` with stable identifiers, source locations, statuses, dependencies, intended stages, and notes for every numbered item and materially operative unnumbered claim in Sections 3--5 and Appendices A--C.
- Create `goal-1/corrections.md`, separating confirmed defects, conversion ambiguities, obligations needing proof, and interpretative exclusions.
- Create `goal-1/architecture.md` with the dependency graph, encoding comparison, selected initial choices, protected high-fanout modules, and concrete build patterns.
- Bootstrap `formal/` with exact Lean and mathlib pins and a thin `RR2021` library root.
- Add narrow survey-only compiling spikes for systems/disjointness, indexed families and action orientation, explicit quotient descent, and compatibility-indexed partial products.
- Add an audit leaf that inspects the spike declarations without exporting paper theorems.
- Update this record and `0-plan.md` from exact build, scan, and diff evidence.

## Build Structure

- `formal/RR2021/Survey/Systems.lean`: low-dependency system-algebra and indexed-family spike.
- `formal/RR2021/Survey/IndexedAction.lean`: indexed standard-`MulAction` orientation spike.
- `formal/RR2021/Survey/Quotient.lean`: explicit `Setoid` and representative-independent descent spike.
- `formal/RR2021/Survey/PartialProduct.lean`: compatibility-witnessed product spike with no off-domain branch.
- `formal/RR2021/Survey/API.lean`: thin survey re-export.
- `formal/RR2021/Survey/Audit.lean`: diagnostic `#check`/axiom inspection; not imported by the public root.
- `formal/RR2021.lean`: thin current library root importing only the stage API.
- Later stable modules will live below `Systems`, `Dynamics`, `Theory`, `Quotient`, `Reconstruction`, `Correspondence`, `Quantum`, `Examples`, and `Audit`; survey spikes are probes, not frozen public API.
- Protected high-fanout files once introduced: `RR2021.lean`, `RR2021/API.lean`, `Theory/Core.lean`, and foundational `Systems/Core.lean`. Heavy proofs, diagnostics, reconstruction variants, and quantum work belong in leaves.
- Focused build commands: `cd formal && lake build RR2021.Survey.Systems RR2021.Survey.IndexedAction RR2021.Survey.Quotient RR2021.Survey.PartialProduct`.
- Adjacent-consumer build commands: `cd formal && lake build RR2021.Survey.API RR2021.Survey.Audit RR2021`.
- Full verification command: `cd formal && lake build`.

These filenames reflect the compiled import graph; the action and quotient names were made singular and explicit during the probe.

## No-Cheating Checks

- Search completed Lean sources for `sorry`, `admit`, project `axiom`, suspicious `opaque`, placeholder tactics, `Classical.choice`, and arbitrary fallback branches.
- Inspect every `Quotient.lift`/`Quotient.map` occurrence and require a nearby named congruence theorem.
- Inspect the partial-product signature to ensure compatibility evidence is an input and that no value exists for an incompatible pair.
- Confirm the survey modules contain no declaration purporting to prove the paper's forward, reverse, equivalence, faithfulness, or quantum claims.
- Confirm source assumptions occur only as explicit structure/typeclass parameters in spikes, not as hidden project axioms or global instances.

## Boundary Checks

- Survey declarations are encoding probes, not the stable paper API.
- The public root must not import the diagnostic audit leaf.
- The abstract spikes must not import finite-dimensional linear algebra or quantum modules.
- Interpretative and philosophical conclusions are documentation exclusions, not Lean propositions.
- Boolean-algebra strength is provisionally selected as a sufficient carrier interface and remains subject to Stage 2 minimization.

## Completion Requirements

- [x] The exact-pinned project builds from the documented commands.
- [x] The ledger covers every numbered and operative mathematical item in Sections 3--5 and Appendices A--C, with initial status and dependencies.
- [x] Material mathematical claims outside the main scope and interpretative exclusions are classified separately from unresolved mathematics.
- [x] All four encoding spikes compile and their signatures justify the initial choices without a main theorem.
- [x] The architecture record supplies the dependency graph, encoding tradeoffs, protected high-fanout modules, focused builds, and adjacent-consumer builds.
- [x] Full build, no-cheating scans, audit checks, documentation checks, `git diff --check`, status, and scoped diff review are recorded below.
- [x] Results are folded back into `0-plan.md`, including the next incomplete stage and any revised assumptions.

## Stage Results

### Artifacts and decisions

- Created a pinned Lake project in `formal/`. `lean-toolchain` is exactly `leanprover/lean4:v4.31.0`; `lakefile.lean` pins mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`; `lake-manifest.json` resolves that exact revision and all inherited dependencies.
- Created `goal-1/source-ledger.md` with 149 unique stable entries: 89 numbered-label occurrences, 45 material unnumbered items, and 15 operative/excluded items outside the core sections. `scripts/check_stage1_docs.py` mechanically covers 88 distinct numbered labels; the 89th occurrence is the source's duplicate `Theorem B.2` label, represented by two stable ledger IDs.
- Created `goal-1/corrections.md` with 18 entries and a required-field mapping. Confirmed editorial defects remain separate from unproved mathematical repairs.
- Created `goal-1/architecture.md` with the mathematical dependency graph, proposed import graph, encoding comparisons, protected high-fanout modules, quotient/product boundaries, and incremental build pattern.
- Added `RR2021.Survey.Systems`, `IndexedAction`, `Quotient`, and `PartialProduct`, plus thin `Survey.API` and `RR2021` roots and a diagnostic `Survey.Audit` leaf. No paper theorem or paper-specific axiom is declared.
- The standard `MulAction` law verifies the source composition convention: `(g * h) • x = g • (h • x)`. The quotient spike uses `observation_congr` adjacent to `Quotient.lift`. The partial-product spike requires a `Compatible` proof and has no incompatible-input branch.

### Source findings folded forward

- PDF inspection resolved Theorem 5.2's apparent `C = A ⊓ B` error as a Markdown conversion loss: the PDF has `C = Aᶜ ⊓ B`. Stage 2 must prove the required Boolean decompositions and Stage 7 must carry their transports explicitly.
- Appendix A Theorem A.2 has genuinely mismatched hypothesis pairs; quotient composition will use the corrected cross-pair hypotheses.
- Phenomenal quotienting need not preserve separation because quotients can enlarge intersections. Reconstruction must assume/prove quotient-level separation or use the repaired route: construct all local-realistic laws except noumenal faithfulness from the original separated group theory, then apply the Appendix B kernel quotient.
- Lemma 3.4 circularly invokes lemmas that already assume nested-product definedness; Stage 3 must construct compatibility witnesses from a common `N_{ABC}`.
- Section 5.1's “easy to verify” paragraph leaves every major well-definedness/coherence law open. Theorem 5.15 and 5.16 alone are not a constructor proof.
- Appendix C requires finite-dimensional tensor/endomorphism identifications, nonzero-factor cancellation hypotheses, and a proof that the middle factor is unitary; its final `V^C` is a typo for `V^B`.

### Exact verification evidence

The authoritative pre-change failure was:

```text
$ lake build
error: [root]: no configuration file with a supported extension
```

The final pinned environment and dependency checks were:

```text
$ cd formal && lake env lean --version
Lean (version 4.31.0, x86_64-apple-darwin24.6.0,
commit 68218e876d2a38b1985b8590fff244a83c321783, Release)

$ git -C formal/.lake/packages/mathlib rev-parse HEAD
fabf563a7c95a166b8d7b6efca11c8b4dc9d911f
```

Builds on the final tree:

```text
$ cd formal && lake build RR2021.Survey.Systems RR2021.Survey.IndexedAction RR2021.Survey.Quotient RR2021.Survey.PartialProduct
Build completed successfully (374 jobs).

$ cd formal && lake build RR2021.Survey.API RR2021.Survey.Audit RR2021
Build completed successfully (378 jobs).

$ cd formal && lake build
Build completed successfully (377 jobs).
```

`RR2021.Survey.Audit` reported:

- `IndexedLeftAction.act_mul`, `observation_congr`, and `descendObservation_mk`: no axioms.
- `SeparatedSystems.swap_left` and `productOn_mk`: only `[propext, Classical.choice, Quot.sound]`, inherited Lean/mathlib foundations; there are no explicit choice calls or project-specific axioms.

Boundary and documentation checks:

```text
$ rg -n '\bsorry\b|\badmit\b|by_contra!|^[[:space:]]*(axiom|opaque)\b' formal/RR2021 formal/RR2021.lean
# no matches (exit 1)

$ rg -n 'Classical\.choice|Quotient\.(lift|liftOn|map)' formal/RR2021 formal/RR2021.lean
formal/RR2021/Survey/Quotient.lean:36: Quotient.lift ... observation_congr ...

$ rg -n '\bdefault\b|Inhabited|Classical\.choice|dite|ite|match' formal/RR2021/Survey/PartialProduct.lean
# one documentation hit saying there is no default/off-domain branch; no code hit

$ rg -n '^import .*Quantum|RR2021\.Quantum' formal/RR2021/Survey formal/RR2021.lean
# no matches (exit 1)

$ python3 scripts/check_stage1_docs.py
Stage-1 documentation check passed: 88 distinct numbered source declarations covered.

$ git diff --check
# exit 0, no output
```

`git status --short` was reviewed and contains only the Stage 1 implementation/documentation changes plus the planned root README and ignore updates; the generated `formal/.lake/` tree is ignored. All stages are now complete; final release evidence is recorded in `goal-1/12-RELEASE.md`.
