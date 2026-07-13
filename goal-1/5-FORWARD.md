# 5-FORWARD

Status: complete

## Current Facts

- Stages 1--4 are complete and the pinned full build passes. The public root
  now exposes stable Systems, Dynamics, and Theories layers.
- `LocalRealisticCore` contains every corrected Section 3 field except
  noumenal action faithfulness. In particular it already supplies a surjective
  equivariant phenomenalization map, compatible noumenal/phenomenal
  projectors, the honest noumenal state product, a raw separated
  transformation product, and locality.
- `LocalRealisticTheory` adds exactly noumenal action effectivity. Stage 4
  derives its transformation-product multiplication, identity, symmetry, and
  associativity laws.
- Theorem 3.12's remote phenomenal marginal argument uses surjectivity to lift
  an arbitrary phenomenal composite state, equivariance to cross both actions,
  projector compatibility to cross both projections, and noumenal locality for
  the central marginal equation. It does not use action effectivity.
- Building the complete source `NoSignallingTheory` additionally needs the
  four Axiom 4.6 product laws, which Stage 3 derives from locality only when the
  noumenal action is effective. Thus the stage must split the state-level
  theorem from the full structure constructor.
- No inverse, transformation-separation, phenomenal-faithfulness, global-
  transitivity, quotient, or quantum assumption occurs in the forward proof.

## Updated Assumptions

- The strongest assumption-minimal state theorem should take
  `LocalRealisticCore`, not `LocalRealisticTheory`.
- The full structure constructor should take `LocalRealisticTheory`, reuse the
  same phenomenal state/transformation families and projector/product data,
  and fill the five Axiom 4.6 fields only with proved Stage 3/5 laws.
- Surjectivity may eliminate an existential into the equality proof. No state
  representative may be selected to define output data.
- A separate conversion to `PhenomenalTheory` should use the already-derived
  phenomenal nonemptiness and phenomenal-projector surjectivity; those facts
  must not be reintroduced as assumptions.

## Big Picture Objective

Prove the assumption-minimal forward no-signalling marginal theorem from a
pre-faithful local-realistic core, then assemble the complete source
no-signalling structure from a full local-realistic theory.

## Detailed Implementation Plan

1. Add a narrow proof module with `LocalRealisticCore.noSignallingAxiom`,
   proving Theorem 3.12 for every separated pair, both transformations, and
   every phenomenal composite state.
2. Add `LocalRealisticCore.toPhenomenalTheory` from derived phenomenal
   nonemptiness/projector surjectivity.
3. Add `LocalRealisticTheory.toNoSignallingTheory`, reusing the core theorem
   and the four already-derived transformation-product laws.
4. Add a pre-faithful example exercising the state-level theorem and a full
   example exercising the structure constructor. Include a compile-time
   assumption audit showing no reverse predicate is an argument.
5. Add thin API/audit leaves, update the stable root, and record the exact
   source realization/axiom footprint.

## Build Structure

- `formal/RR2021/Forward/Core.lean`: state-level Theorem 3.12 and phenomenal
  core conversion; depends only on raw theory fields.
- `formal/RR2021/Forward/Construction.lean`: full no-signalling constructor;
  imports the theory-level transformation-law proofs.
- `formal/RR2021/Forward/Examples.lean`: pre-faithful and faithful constructor
  tests; diagnostic leaf.
- `formal/RR2021/Forward/API.lean`: thin stable re-export.
- `formal/RR2021/Forward/Audit.lean`: exact signatures and axiom prints.
- `formal/RR2021/API.lean`: intentionally touched after the Forward API is
  stable.
- Focused proof: `cd formal && lake build RR2021.Forward.Core`.
- Constructor/examples:
  `cd formal && lake build RR2021.Forward.Construction RR2021.Forward.Examples`.
- Adjacent consumers:
  `cd formal && lake build RR2021.Forward.API RR2021.Forward.Audit RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- Inspect the exact theorem and constructor signatures for
  `InvertibleDynamics`, `TransformationSeparation`, `PhenomenallyFaithful`,
  `GloballyTransitive`, `IndexedGroup`, quotient, and quantum assumptions;
  none may occur.
- Confirm the state-level theorem takes `LocalRealisticCore` and never accesses
  `noumenalActionFaithful`.
- Confirm the proof uses phenomenalization surjectivity only to prove a
  proposition and does not define output data from a chosen representative.
- Confirm every action/projection transition is justified by the named
  equivariance, projector-compatibility, or locality field.
- Confirm the constructor reuses the existing transformation product rather
  than postulating a new product or any Axiom 4.6 law.
- Scan for proof holes, project axioms/opaque declarations, explicit choice,
  defaults, quotient lifting, raw casts/transports, and later-stage imports.

## Boundary Checks

- Proof boundary: remote phenomenal marginal from pre-faithful core.
- Construction boundary: complete Axiom 4.6 package from full faithfulness.
- Direction boundary: no reverse-construction predicate or object is imported
  or consumed.
- Data boundary: the forward map forgets noumenal data; it does not quotient,
  reconstruct, or alter transformations/phenomenal states.
- Diagnostic boundary: examples and audit output remain outside the public API.

## Completion Requirements

- [x] The state-level no-signalling theorem compiles for
  `LocalRealisticCore` with every source quantifier explicit.
- [x] The phenomenal-core conversion and full no-signalling constructor
  compile without new axioms or fields.
- [x] The constructor signature contains no reverse or quantum assumption.
- [x] Pre-faithful and full examples exercise the theorem/constructor and
  distinguish their assumption strengths.
- [x] Focused, adjacent, and full builds; no-cheating/import scans; axiom
  audit; documentation check; `git diff --check`; and scoped review pass.
- [x] Results are folded into `source-ledger.md`, `0-plan.md`, and this file;
  Stage 6 is resumable.

## Stage Results

### Assumption-minimal theorem and constructor

- `LocalRealisticCore.noSignallingAxiom` proves Theorem 3.12 with the exact
  target `NoSignallingAxiom theory.phenomenalProjectors
  theory.transformationProducts`. Its structure argument lacks Axiom 3.7.
- For an arbitrary phenomenal state of `A⊔B`, the proof obtains a noumenal
  preimage from phenomenalization surjectivity. That existential is eliminated
  only into the target equality. The proof then uses, in order, composite
  equivariance, projector compatibility, the arbitrary-whole noumenal locality
  equation, local equivariance, and projector compatibility again.
- `LocalRealisticCore.toPhenomenalTheory` forgets the noumenal data and fills
  state nonemptiness/projector surjectivity with the Stage 4 derived results.
- `LocalRealisticTheory.toNoSignallingTheory` preserves the phenomenal state
  family, transformation family, projectors, and raw transformation product.
  It fills Axiom 4.6 with the core theorem and the four already-derived
  multiplication, identity, symmetry, and associativity laws. No new operation
  or law is postulated.

### Assumption and dependency audit

The final public signatures contain only:

- the Boolean system algebra;
- the indexed transformation monoids;
- the noumenal and phenomenal actions; and
- `LocalRealisticCore` for the marginal theorem or `LocalRealisticTheory` for
  the full constructor.

They contain no `InvertibleDynamics`, `TransformationSeparation`,
`PhenomenallyFaithful`, `GloballyTransitive`, `IndexedGroup`, quotient,
reconstruction, or quantum argument.

A scoped review found that the first implementation was semantically clean but
still reached reverse declarations at import granularity because Stage 4 had
placed them beside the target structures. Theories were refactored so
`Theories.Postulates` now exclusively owns invertibility, transformation
separation, contextual phenomenal faithfulness, global transitivity, and the
inverse-product theorems. Neither the transitive import chain of
`Forward.Core` nor that of `Forward.Construction` reaches this leaf. This turns
the direction boundary into an import-graph property.

`Forward.Examples` builds a `LocalRealisticCore` with natural-number
transformations acting trivially on Boolean states and proves that its
noumenal action is not faithful before applying the state-level theorem. A
separate singleton-transformation model supplies full action effectivity and
exercises the complete constructor.

### Exact verification evidence

Focused state-level theorem:

```text
$ cd formal && lake build RR2021.Forward.Core
Build completed successfully (384 jobs).
```

Constructor and strength-boundary examples:

```text
$ cd formal && lake build RR2021.Forward.Construction RR2021.Forward.Examples
Build completed successfully (639 jobs).
```

Adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Forward.API RR2021.Forward.Audit RR2021.API RR2021
Build completed successfully (397 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (396 jobs).
```

`Forward.Audit` prints the exact theorem/conversion/constructor signatures and
reports `[propext, Classical.choice, Quot.sound]`, inherited from the source-
level mathlib Boolean-algebra/order surface. No project-specific axiom or
explicit choice/quotient operation occurs. Final scans find no proof hole,
`axiom`/`opaque`, `Classical.choice`, quotient lift, default/`Inhabited`, raw
cast/transport, later-stage import, or reverse-postulate name in the Forward
implementation/API chain. The documentation checker, `git diff --check`, and
the post-refactor scoped review pass.

All stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
