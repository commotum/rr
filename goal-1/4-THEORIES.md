# 4-THEORIES

Status: complete

## Current Facts

- Stages 1--3 are complete. `RR2021.Systems.API` and
  `RR2021.Dynamics.API` are the stable foundations; the last full pinned build
  passed with 387 jobs.
- Source Axioms 3.1--3.13 mix ordinary operational data with noumenal
  faithfulness. Theorem 4.2 explicitly needs the same data *without*
  faithfulness, so the reusable local-realistic core must not make effectivity
  inseparable from the remaining fields.
- Source Axioms 4.1--4.5 are a phenomenal operational core: nonempty indexed
  states, indexed monoids/actions, and surjective nested projectors. Axiom 4.6
  adds a separated transformation product, its four algebra/coherence laws,
  and the phenomenal no-signalling marginal equation.
- Stage 3 already supplies the exact reusable ingredients: `IndexedMonoid`,
  `IndexedMulAction`, `ProjectorFamily` plus separate surjectivity,
  `TransformationProduct` plus separate law predicates, `IndexedMap` plus
  separate map predicates, `StateProduct`, `Locality`, and `ActionEffective`.
- A no-signalling theory has no phenomenal state product. Adding one would
  contradict the source's intended boundary and contaminate the reverse
  construction.
- Postulates 4.1--4.4 are not part of the definition of a no-signalling
  theory. They must remain named predicates/mixins: transformation separation,
  invertible dynamics, phenomenal faithfulness, and global transitivity.
- Correction `RR-C007` removes the unused transformation quantified in
  Definition 4.1. Phenomenal equivalence still compares identity-extended
  transformations on every separated extension state, not merely their local
  action.

## Updated Assumptions

- Theory structures will be parameterized by `System`, indexed transformation
  and state families, and the already-selected standard monoid/action
  instances. This keeps operations usable without storing shadow typeclass
  data and makes every carrier/instance visible in the structure type.
- A `PhenomenalTheory` will own only nonemptiness and the phenomenal projector
  data required by Axioms 4.2 and 4.5. `NoSignallingTheory` will extend it with
  Axiom 4.6 data and laws.
- `LocalRealisticCore` contains Axioms 3.1--3.6 and 3.8--3.13 at the corrected
  Stage 3 strength. `LocalRealisticWithoutFaithfulness` is its source-facing
  alias, while `LocalRealisticTheory` adds the Axiom 3.7 `ActionEffective`
  field. This is the exact boundary used by Theorems 4.2--4.3 and the later
  repaired reverse route.
- Only noumenal nonemptiness and noumenal-projector surjectivity need be stored
  in the local-realistic core. Phenomenal nonemptiness follows by mapping a
  noumenal witness, while phenomenal-projector surjectivity follows from
  phenomenalization surjectivity, noumenal-projector surjectivity, and Axiom
  3.11 compatibility. Both derivations compile without selecting a witness.
- Invertibility should initially be a proposition asserting a two-sided
  inverse under the already-fixed indexed monoid operations. Installing an
  unrelated `Group` instance could silently change multiplication; later work
  may derive a coherent group wrapper only if needed.
- Global transitivity will be stated only at `globalSystem` and will include
  the source's explicit reachability equation.
- The transformation separation postulate will expose all three pairwise
  separation premises and every permutation/associativity reindex needed to
  compare its differently parenthesized products.

## Big Picture Objective

Define constructor-visible, reusable local-realistic and no-signalling theory
bundles while keeping faithfulness and reverse-construction postulates as
separate, inspectable assumptions.

## Detailed Implementation Plan

1. Add a common core with indexed nonemptiness and named noumenal
   faithfulness/effectivity, and isolate invertibility with the other
   reverse-only assumptions in a separate postulate leaf.
2. Define `PhenomenalTheory` for Axioms 4.1--4.5 and
   `NoSignallingTheory` for Axiom 4.6. Keep no-signalling itself as an explicit
   marginal equation quantified over separated systems, both transformations,
   and every composite phenomenal state.
3. Define corrected phenomenal equivalence and separate phenomenal-faithfulness,
   global-transitivity, and transformation-separation predicates. Add only
   cheap validation/transport lemmas needed to show their exact scopes.
4. Define `LocalRealisticCore` with nonempty noumenal states,
   separate projector families and surjectivity, the equivariant/surjective/
   projection-compatible noumenal--phenomenal map, honest noumenal product,
   raw transformation product, and locality.
5. Define `LocalRealisticTheory` by adding noumenal action effectivity. Prove
   validation lemmas that recover the four transformation-product law
   predicates from the full structure without adding them as fields.
6. Add finite/trivial constructor examples for the phenomenal,
   no-signalling, pre-local-realistic, and faithful local-realistic layers.
   Include boundary examples showing the base no-signalling bundle does not
   require group dynamics, global transitivity, or either faithfulness
   predicate.
7. Add thin API and diagnostic audit leaves, update `RR2021.API`, and append a
   source field/derived/predicate matrix with exact declaration links.

## Build Structure

- `formal/RR2021/Theories/Core.lean`: indexed nonemptiness and noumenal
  effectivity only; lowest Stage 4 dependency.
- `formal/RR2021/Theories/NoSignalling.lean`: phenomenal core,
  no-signalling structure, exact Axiom 4.6 fields, and reverse-only predicates.
- `formal/RR2021/Theories/LocalRealistic.lean`: pre-faithful and faithful
  local-realistic structures.
- `formal/RR2021/Theories/Basic.lean`: validation and derived laws; proof leaf
  kept out of the structure definitions.
- `formal/RR2021/Theories/Postulates.lean`: reverse-only invertibility,
  transformation separation, contextual phenomenal faithfulness, global
  transitivity, and Theorem 4.1; isolated from forward dependencies.
- `formal/RR2021/Theories/Examples.lean`: inhabitation and negative boundary
  tests; diagnostic only.
- `formal/RR2021/Theories/API.lean`: thin stable re-export excluding examples
  and audits.
- `formal/RR2021/Theories/Audit.lean`: structure signatures, field matrix, and
  `#print axioms` diagnostics.
- `formal/RR2021/API.lean`: intentionally touched high-fanout public root after
  the Stage 4 API is stable.
- Focused definitions:
  `cd formal && lake build RR2021.Theories.Core RR2021.Theories.NoSignalling RR2021.Theories.LocalRealistic`.
- Focused proofs/examples:
  `cd formal && lake build RR2021.Theories.Basic RR2021.Theories.Examples`.
- Adjacent consumers:
  `cd formal && lake build RR2021.Theories.API RR2021.Theories.Audit RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- Inspect structure constructors and confirm every source axiom is either a
  field, an existing Dynamics theorem, or a separately named predicate; no
  reverse postulate may appear in `NoSignallingTheory`.
- Confirm `PhenomenalTheory` and `NoSignallingTheory` contain no noumenal
  carrier, map, projector, product, compatibility, or locality field.
- Confirm `PreLocalRealisticTheory` contains no hidden effectivity field and
  `LocalRealisticTheory` adds exactly that missing assumption.
- Confirm no phenomenal state product is introduced.
- Confirm no transformation-product algebra law is duplicated in a
  local-realistic structure; those laws must be derived from locality plus
  explicit noumenal effectivity.
- Scan for proof holes, project axioms/opaque declarations, choice, defaults,
  quotient operations, raw casts/transports, and imports from Stages 5--10.
- Inspect all separation-postulate products and require named equality paths
  before any indexed comparison.

## Boundary Checks

- Data boundary: families and standard monoid/action instances are parameters;
  theory-specific projectors, maps, products, and laws are fields.
- Faithfulness boundary: noumenal action effectivity, phenomenal equivalence
  faithfulness, and ordinary action injectivity are distinct propositions.
- Direction boundary: no-signalling structures do not know about a noumenal
  model; pre-local-realistic structures do not know about reverse construction.
- Product boundary: state products occur only in the noumenal structure and
  retain their exact compatibility domain; transformation products remain
  total only for explicitly separated systems.
- Diagnostic boundary: finite/trivial models and axiom prints are excluded
  from `Theories.API` and the stable root.

## Completion Requirements

- [x] Constructor-visible phenomenal, no-signalling, pre-local-realistic, and
  faithful local-realistic structures compile.
- [x] Axioms 3.1--3.13 and 4.1--4.6 have an exact field/derived/predicate map.
- [x] No-signalling is an explicit state-level marginal equation with system
  separation and both transformations in scope.
- [x] Invertibility, transformation separation, phenomenal faithfulness,
  noumenal faithfulness, and global transitivity compile as separate packages.
- [x] Full local-realistic data derive the four transformation-product laws;
  the pre-faithful core does not claim them.
- [x] Trivial examples inhabit every layer without circular fields and
  boundary checks demonstrate the absence of reverse-only requirements.
- [x] Focused, adjacent, and full builds; no-cheating/import scans; axiom
  audit; documentation check; `git diff --check`; and scoped review pass.
- [x] Results are folded into `source-ledger.md`, `corrections.md` if needed,
  `0-plan.md`, and this file; Stage 5 is resumable.

## Stage Results

### Stable structures and exact boundaries

- `Theories.Core` adds only `IndexedNonempty` and `NoumenallyFaithful`.
  `Theories.Postulates` owns `InvertibleDynamics` and every reverse-only
  Section 4 predicate. Invertibility is a two-sided-existence proposition
  relative to the already-fixed indexed monoid; it installs no competing group
  operations and selects no inverse function.
- `PhenomenalTheory` captures Axioms 4.1--4.5 through visible Boolean-system,
  monoid, and action parameters plus only three fields: state nonemptiness,
  nested projectors, and projector surjectivity.
- `NoSignallingAxiom` is a standalone proposition quantified over separated
  `A,B`, transformations on both systems, and every state of `A⊔B`.
  `NoSignallingTheory` extends the phenomenal core with the raw transformation
  product, that proposition, and the four Axiom 4.6 algebra/coherence laws.
  The right marginal is derived as `noSignallingRight` using symmetry and
  explicit `sup_comm` reindexing.
- `LocalRealisticCore` contains every corrected Section 3 requirement except
  Axiom 3.7: noumenal nonemptiness, the function-only phenomenalization map
  with separate equivariance/surjectivity, independent noumenal/phenomenal
  projectors, projector compatibility, the honest noumenal state product, the
  raw transformation product, and locality. It contains no faithfulness,
  group, transformation-separation, transitivity, or reverse-construction
  field.
- `phenomenalNonempty` derives Axiom 3.3. `phenomenalProjectorsSurjective`
  derives the surjectivity portion of Axiom 3.10 from Axioms 3.8, 3.9, and
  3.11. `noumenalProjectSelf` and `phenomenalProjectSelf` validate Theorems
  3.1--3.2 at the theory level.
- `LocalRealisticTheory` extends the core with exactly
  `noumenalActionFaithful`. The four Section 3 transformation-product laws and
  `transformationProduct_unique` are derived from locality plus that field;
  they are not duplicated in the constructor.

### Separate postulates and source matrix

| Source declaration | Stage 4 realization | Classification |
|---|---|---|
| Axioms 3.1, 3.4--3.6 | Boolean algebra, indexed monoid, and two action parameters | visible parameters |
| Axioms 3.2--3.3 | `noumenalNonempty`; `phenomenalNonempty` | field; derived |
| Axiom 3.7 | `NoumenallyFaithful`; sole extension field | separate mixin/full layer |
| Axiom 3.8 | `phenomenalization` plus equivariance and surjectivity | three independent fields |
| Axioms 3.9--3.11 | two projector families, noumenal surjectivity, map/projector compatibility; phenomenal surjectivity derived | fields plus derived law |
| Axioms 3.12--3.13 | honest `noumenalProduct`, raw `transformationProducts`, `locality` | corrected fields |
| Theorems 3.1--3.7 | existing generic Dynamics results | derived, with Stage 3 corrections |
| Theorems 3.8--3.11 | four `LocalRealisticTheory.product*` lemmas | derived only with Axiom 3.7 |
| Axioms 4.1--4.5 | parameters and `PhenomenalTheory` | base phenomenal layer |
| Axiom 4.6 | `NoSignallingAxiom` and five `NoSignallingTheory` fields | no-signalling layer |
| Postulate 4.1 | `TransformationSeparation`, `swapFirstTwoPath` | separate predicate, explicit pairwise separation/transports |
| Postulate 4.2, Theorem 4.1 | `InvertibleDynamics`, `productOfInverses`, `productInvertible` | separate predicate and derived result |
| Definition 4.1, Postulate 4.3 | corrected `PhenomenallyEquivalent`, separate `PhenomenallyFaithful` | contextual predicate; quotient subsequently completed in Stage 6 |
| Postulate 4.4 | `GloballyTransitive` | separate global-only predicate |

`PhenomenallyEquivalent` implements `RR-C007`: it omits the printed unused
remote-transformation variable but still compares identity extensions on every
separated environment state. It is deliberately not local action effectivity.
`TransformationSeparation` chooses `A⊔(B⊔C)` as its canonical index and exposes
three pairwise separation proofs, `swapFirstTwoPath`, and `sup_assoc`.

The finite/trivial diagnostic model over `Finset (Fin 2)` inhabits
`PhenomenalTheory`, `NoSignallingTheory`, `LocalRealisticCore`, and
`LocalRealisticTheory`; it separately instantiates invertibility, phenomenal
faithfulness, global transitivity, and transformation separation. A second
model uses natural-number transformations acting trivially on Boolean states;
it is a valid no-signalling theory but proves the negations of invertibility,
phenomenal faithfulness, and global transitivity. Thus the constructor boundary
is tested semantically as well as by structure-field inspection.

### Exact verification evidence

Focused structure layer:

```text
$ cd formal && lake build RR2021.Theories.Core RR2021.Theories.NoSignalling RR2021.Theories.LocalRealistic
Build completed successfully (383 jobs).
```

Derived validations and constructor examples:

```text
$ cd formal && lake build RR2021.Theories.Basic RR2021.Theories.Examples
Build completed successfully (637 jobs).
```

Adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Theories.API RR2021.Theories.Audit RR2021.API RR2021
Build completed successfully (393 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (392 jobs).
```

`Theories.Audit` prints all four constructors. The printout confirms that
`NoSignallingTheory` contains no noumenal/product/locality or reverse-postulate
field and that `LocalRealisticTheory` adds exactly one field to its core. The
axiom report gives no axioms for the common predicates or derived phenomenal
nonemptiness. The theory-facing theorems over the full source Boolean algebra
report `[propext, Classical.choice, Quot.sound]`, inherited from mathlib's
standard Boolean-algebra/order surface; the underlying Stage 3 non-Boolean
lemmas retain their smaller footprints. No project-specific axiom or explicit
choice/quotient operation occurs.

Final scans found no proof hole, `axiom`/`opaque`, `Classical.choice`, quotient
lift, default/`Inhabited`, raw cast/transport, or later-stage import in
`Theories`. `NoSignalling.lean` has no noumenal, state-product, compatibility,
locality, or reverse-postulate declaration/import; those postulates live only
in `Theories.Postulates`. `Theories.API` and the stable root exclude
examples/audits. The documentation checker and `git diff --check` pass, and a
scoped source/API review found no remaining correctness defect.

All stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
