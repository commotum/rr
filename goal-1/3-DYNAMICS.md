# 3-DYNAMICS

Status: complete

## Current Facts

- Stages 1 and 2 are complete; `RR2021.Systems.API` is the stable public foundation and the full pinned build passes.
- The Stage 1 action and partial-product declarations remain survey probes only. They are not imported by the stable root and do not prove source action/product laws.
- Source Definition 3.5 and Definition 3.7 use the standard left-action convention: the composite `UV` applies `V` first and then `U`. Stage 2 transport already fixes the relevant composite-index equality paths.
- Source Axioms 3.9/3.10 store surjective nested projectors; Theorems 3.1/3.2 derive self-projection identity from surjectivity plus nesting. The stable projector API should preserve that field/derived distinction.
- Definition 3.11 makes compatibility existential: subsystem states are compatible when they are projections of a common composite state.
- Correction `RR-C004` classifies Axiom 3.12 as a genuinely partial state operation, not a transformation. The operation must take compatibility evidence and prove reconstruction/output independence; it may not select an arbitrary incompatible result.
- A second logical defect is now isolated: Axiom 3.12 says compatibility is only *necessary* for definedness, while Theorems 3.3 onward use the product on every compatible pair. The stable repair makes the domain exactly the compatibility proposition. Theorem 3.5 must also add the omitted compatibility premise before stating commutativity.
- Correction `RR-C006` shows that the paper's triple-product definedness proof is circular. Associativity must construct compatibility witnesses from actual common extensions before comparing products.
- Axiom 3.13 relates a separated transformation product to noumenal actions and state products. Its compatibility-preservation premise is implicit in the prose and must be explicit in Lean.
- Theorems 3.8--3.11 use faithful action to derive composition, identity, symmetry, and associativity of transformation products. Those laws must therefore be separate mixins/predicates at this infrastructure stage, not unconditional fields of the raw product operation.

## Updated Assumptions

- State and transformation carriers will be system-indexed families `System → Type`.
- Per-system transformation monoids and actions should reuse standard `Monoid`/`MulAction`; group structure remains a separate later mixin.
- An indexed state map contains only functions. Equivariance, surjectivity, injectivity, and projector compatibility remain distinct predicates/structures so theorem signatures reveal which are used.
- A projector family stores projection and nesting. Surjectivity is separate; self-projection identity is derived from nesting plus surjectivity, matching Theorems 3.1/3.2.
- Compatibility is a `Prop` asserting a common composite extension with both projection equations. A state-product structure supplies the partial operation and its laws, so no choice is used to obtain a composite.
- Product output must be independent of compatibility proof. Proof irrelevance may discharge equality between proofs only after compatibility existence and the mathematical output laws are explicit.
- State-product commutativity and associativity should be derived from projection/reconstruction plus named reindex coherence, not stored as unexplained axioms. If a genuinely additional projector/reindex premise is needed, expose it as a named coherence structure.
- A raw separated transformation product, its monoid/coherence laws, and its componentwise action/locality law are separate structures.

## Big Picture Objective

Build reusable indexed dynamics infrastructure that faithfully types states, transformations, actions, maps, projectors, honest partial state products, separated transformation products, and their coherence laws without importing either the local-realistic or no-signalling theory bundles.

## Detailed Implementation Plan

1. Add indexed family aliases and a standard per-system monoid/action wrapper whose executable example distinguishes the chosen composition orientation from the reversed convention.
2. Add indexed state maps with independent equivariance, surjectivity, injectivity, and effective-action predicates; prove inexpensive preservation lemmas.
3. Add projector families with nesting, separate surjectivity, derived self-projection identity, composite left/right helpers, and named domain-reindex coherence.
4. Define compatibility from a common composite extension and a partial state-product interface requiring a separation witness and compatibility proof. Prove projections, reconstruction, compatibility-proof independence, and uniqueness of a composite from its factors.
5. Derive product commutativity via `sup_comm` and, using common-extension witnesses rather than circular assumptions, derive the strongest correctly typed associativity/definedness results available.
6. Add a raw separated transformation product, optional monoid/coherence law packages, and a componentwise-action package that explicitly maps compatible pairs to compatible pairs.
7. Add finite/trivial examples and negative boundary tests for reversed action order, cross-system transport, incompatible products, and omitted pairwise separation.
8. Add thin API/audit leaves, update the stable root, and append exact source realization links for Section 3 definitions/axioms/theorems covered in this stage.

## Build Structure

- `formal/RR2021/Dynamics/Core.lean`: indexed families, per-index standard monoids/actions, and cheap action helpers.
- `formal/RR2021/Dynamics/Map.lean`: indexed maps and separate property predicates.
- `formal/RR2021/Dynamics/Reindex.lean`: named equality coherence for monoid operations, actions, and indexed maps.
- `formal/RR2021/Dynamics/Projection.lean`: nested projectors, surjectivity predicate, derived identity, and reindex-domain coherence.
- `formal/RR2021/Dynamics/StateProduct.lean`: compatibility and honest partial state product; binary projection/reconstruction/uniqueness laws.
- `formal/RR2021/Dynamics/StateProductCoherence.lean`: commutativity and repaired triple-product compatibility/associativity proofs; heavy proof leaf.
- `formal/RR2021/Dynamics/TransformationProduct.lean`: raw separated product plus optional monoid/symmetry/associativity law packages.
- `formal/RR2021/Dynamics/Locality.lean`: explicit compatibility preservation and componentwise action law.
- `formal/RR2021/Dynamics/TransformationProductDerived.lean`: Theorems 3.8--3.11 derived from locality and effective action; heavy proof leaf.
- `formal/RR2021/Dynamics/Examples.lean`: executable orientation, positive models, and negative boundary tests.
- `formal/RR2021/Dynamics/API.lean`: stable re-exports excluding examples/audit.
- `formal/RR2021/Dynamics/Audit.lean`: signature and axiom diagnostics.
- Update `formal/RR2021/API.lean`; the public root remains thin.
- Protected high-fanout modules: `Dynamics.Core`, `Dynamics.Projection`, `Dynamics.StateProduct`, and the existing `RR2021.API`. Triple coherence and diagnostics stay in leaves.
- Focused builds proceed in dependency order, beginning with `lake build RR2021.Dynamics.Core RR2021.Dynamics.Map RR2021.Dynamics.Projection`.
- Product builds: `lake build RR2021.Dynamics.StateProduct RR2021.Dynamics.StateProductCoherence RR2021.Dynamics.TransformationProduct RR2021.Dynamics.Locality`.
- Adjacent consumers: `lake build RR2021.Dynamics.Examples RR2021.Dynamics.API RR2021.Dynamics.Audit RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- Scan stable dynamics code for proof holes, project axioms/opaque declarations, explicit `Classical.choice`, arbitrary defaults, and later-layer imports.
- Inspect every state-product signature: separation and compatibility evidence must be inputs, with no off-domain branch.
- Inspect every existential compatibility use: no representative is selected unless a structure field already supplies the operation or the witness is eliminated only to prove a proposition.
- Inspect every reindex occurrence and require a named system equality/coherence lemma.
- Confirm self-projection identity is proved from nesting plus explicit surjectivity, not stored in the minimal projector structure.
- Confirm raw transformation product laws are not asserted without their mixin and that componentwise action exposes compatibility preservation.
- Confirm no local-realistic, no-signalling, faithfulness-quotient, reconstruction, or quantum module is imported.

## Boundary Checks

- Core/runtime: indexed carriers/actions, maps, projectors, and raw operations.
- Proof-side: projector identity, product uniqueness, and state-product coherence.
- Optional law packages: transformation product algebra and locality; neither contaminates raw definitions.
- Diagnostic: concrete examples, negative tests, and axiom prints.
- Public API excludes examples/audit and does not export survey probes.
- Surjectivity, injectivity/effectivity, transitivity, and kernel equivalence remain distinct.

## Completion Requirements

- [x] Standard action orientation is encoded and a concrete noncommuting example distinguishes it from the reversed convention.
- [x] Indexed maps compile with separately auditable equivariance, surjectivity, injectivity, and action-effectivity properties.
- [x] Projector nesting/surjectivity compile and self-projection identity is derived; composite/domain reindex coherence is named and tested.
- [x] State product has no incompatible-input value; compatibility, projection laws, reconstruction, proof independence, and composite uniqueness compile.
- [x] Commutativity and the strongest noncircular triple-product associativity/definedness results compile with explicit transports and pairwise separation.
- [x] Raw transformation products, optional algebra/coherence laws, and explicit componentwise-action/compatibility preservation compile independently.
- [x] Positive and negative examples exercise action order, cross-index transports, honest partiality, and pairwise-separation boundaries.
- [x] Focused, adjacent, and full builds; no-cheating/import scans; axiom audit; documentation links; `git diff --check`; and scoped review pass.
- [x] Exact results/corrections are folded into `source-ledger.md`, `corrections.md`, `0-plan.md`, and this file; Stage 4 is resumable.

## Stage Results

### Stable modules and public surface

- `Dynamics.Core` provides per-index standard `Monoid`, optional `Group`, and
  `MulAction` layers. `Dynamics.Map` keeps component functions independent of
  equivariance, surjectivity, injectivity, and action effectivity.
- `Dynamics.Projection` stores only projection and nesting. Surjectivity is a
  separate predicate; `project_self` is derived. Named projector/reindex lemmas
  cover both endpoints of `sup_comm` and `sup_assoc`, including the direct
  middle-system path used by the associativity proof.
- `Dynamics.StateProduct` exposes an honest dependent operation requiring
  separation and `Compatible` evidence. Its only stored mathematical law is
  reconstruction; compatibility-proof independence, projection laws, common-
  extension equality, and composite extensionality are derived.
- `Dynamics.StateProductCoherence` proves swapped compatibility and product
  commutativity. For triples it defines the two bracketed definedness
  propositions, constructs each from the other using actual common extensions,
  proves their equivalence, proves associativity with explicit `sup_assoc`
  transport, and gives the corrected three-direct-projection characterization.
- `Dynamics.TransformationProduct` stores only a separated raw product. The
  four algebra/coherence laws are optional predicates. `Dynamics.Locality`
  makes compatibility preservation explicit and proves the two arbitrary-
  whole marginal equations and remote invariance.
- `Dynamics.TransformationProductDerived` derives multiplication, identity,
  symmetry, and associativity from locality plus `ActionEffective`. The
  associativity proof compares the direct `A`, `B`, and `C` projections after a
  named state/action reindex; it assumes no group operations or extra product
  field.
- Thin `Dynamics.API` and diagnostic `Dynamics.Audit` leaves were added.
  `RR2021.API` now re-exports the stable Systems and Dynamics layers; neither
  examples nor audits enter the public root.

### Examples and repaired source claims

- A `Fin 3` permutation action proves that standard multiplication acts
  right-to-left and that the reversed convention produces a different state.
- Identity projectors plus the equality state product give a positive partial
  model. Equal values are compatible; unequal values are proved incompatible,
  so there is no off-domain test value to inspect.
- Binary commutativity and triple associativity are instantiated with explicit
  compatibility witnesses. A finite-set counterexample shows adjacent
  separation does not manufacture the missing pairwise premise.
- A singleton transformation model supplies raw transformation products,
  effective action, and locality, then instantiates all four derived laws.
- `RR-C004` and `RR-C019` are closed by the exact compatibility-domain API and
  corrected commutativity signature. `RR-C006` is closed by the two explicit
  nested-definedness conversions. `source-ledger.md` links the Stage 3
  declarations to Definitions 3.5--3.11, Axioms 3.9--3.13 infrastructure, and
  Theorems 3.1--3.11 at the precise strength checked.

### Exact verification evidence

Focused stable layer:

```text
$ cd formal && lake build RR2021.Dynamics.Core RR2021.Dynamics.Map RR2021.Dynamics.Reindex RR2021.Dynamics.Projection RR2021.Dynamics.StateProduct RR2021.Dynamics.StateProductCoherence RR2021.Dynamics.TransformationProduct RR2021.Dynamics.Locality RR2021.Dynamics.TransformationProductDerived
Build completed successfully (382 jobs).
```

Concrete tests and adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Dynamics.Examples RR2021.Dynamics.API RR2021.Dynamics.Audit RR2021.API RR2021
Build completed successfully (660 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (387 jobs).
```

The final `Dynamics.Audit` reported:

- No axioms for indexed group-to-monoid conversion, basic action/map laws,
  action reindexing, projector identity/basic reindexing, binary compatibility
  and state-product laws, locality marginals/remote invariance, or the derived
  multiplication and identity laws.
- `[propext]` only for commutative/associative projector transports, state-
  product commutativity/triple coherence, and derived transformation-product
  symmetry/associativity.
- No choice or quotient axiom occurs in any Stage 3 result.

Boundary scans on the final tree found no Lean proof holes or project
`axiom`/`opaque` declarations; the only textual matches for `axiom`/`admit`
were explanatory comments. There are no explicit `Classical.choice`, quotient
lifting, arbitrary defaults, `Eq.rec`, `cast`, or raw `▸` transports in the
Dynamics sources. The public import scan found no Survey, Examples, Audit,
theory, reconstruction, or quantum leak. The Stage 1 documentation checker and
`git diff --check` both pass. A scoped Stage 3 source/API review found no
remaining correctness defect.

All stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
