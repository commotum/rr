# RR2021 Lean Formalization — Final Report

Date: 2026-07-12  
Lean: `v4.31.0` (`68218e876d2a38b1985b8590fff244a83c321783`)  
mathlib: `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`

## Executive conclusion

The project independently reconstructs the abstract mathematical framework in
Sections 3--5 and Appendices A--B of Raymond-Robichaud 2021, proves a corrected
finite complex version of Appendix C, and exposes an assumption-visible public
theorem family in Lean 4.

It does **not** prove an unconditional equivalence between local realism and
no-signalling. The checked result is a collection of constructors:

- a forward forgetful construction;
- raw- and quotient-transformation reverse constructions;
- transitive and non-transitive reverse variants;
- separate phenomenal- and noumenal-faithfulness quotients; and
- one-sided operational-data preservation for raw-transformation outputs.

The strongest verified general quotient-transformation route requires a
no-signalling theory, existential invertibility, and raw transformation
separation. It needs neither global transitivity nor phenomenal faithfulness,
but it changes the transformation family through Appendix B. Retaining the raw
transformation family additionally requires contextual phenomenal faithfulness.

## Exact public theorem family

The stable declarations are in `RR2021.Correspondence`.

| Declaration | Input beyond ambient indexed structures | Result and qualification |
|---|---|---|
| `forward` | full `LocalRealisticTheory` | `NoSignallingTheory` on the same transformation and phenomenal-state families |
| `phenomenalFaithfulnessQuotient` | `NoSignallingTheory` | changes transformations to contextual phenomenal-equivalence classes |
| `phenomenalFaithfulnessQuotient_faithful` | same source | proves contextual `PhenomenallyFaithful`; does not claim local action effectivity |
| `noumenalFaithfulnessQuotient` | `LocalRealisticCore` | full theory over the noumenal action-kernel quotient transformations |
| `transitiveReverseRetainingTransformations` | no-signalling, invertibility, raw separation, explicit global reference, global transitivity, phenomenal faithfulness | full theory retaining raw transformations |
| `transitiveReverseWithFaithfulQuotient` | no-signalling, invertibility, raw separation, reference, global transitivity | drops phenomenal faithfulness by changing transformations |
| `generalReverseRetainingTransformations` | no-signalling, invertibility, raw separation, phenomenal faithfulness | full raw-transformation theory; no reference or global transitivity |
| `generalReverseWithFaithfulQuotient` | no-signalling, invertibility, raw separation | weakest-premise full reverse constructor proved in this development; quotient transformations |

`SameOperationalData` applies only to no-signalling theories already fixed over
the same transformations, phenomenal states, monoid, and phenomenal action. It
asserts equality of phenomenal projectors and separated transformation
products. Theorems
`transitiveReverse_forward_sameOperationalData` and
`generalReverse_forward_sameOperationalData` prove this for the two raw-family
reverse outputs. They are not categorical equivalences, inverse constructions,
model-isomorphism theorems, or uniqueness results.

## Formalized structures and mathematics

### Systems

- Boolean system algebra with empty/global systems, subsystem order,
  separation, composites, complements, and relative complements.
- Named dependent `reindex` operations with identity, composition, inverse,
  commutativity, associativity, and pentagon/path coherence.
- Corrected relative-complement decompositions used by Theorem 5.2 and
  complement partitions used by Theorem 5.8.

### Indexed dynamics

- System-indexed monoids, optional groups, actions, maps, equivariance,
  surjectivity, and action effectivity.
- Nested surjective projector families with derived self-projection.
- Honest compatibility-indexed state products: both separation and
  compatibility are explicit arguments, with no incompatible-input result.
- Corrected binary and iterated product reconstruction, commutativity,
  definedness conversion, and associativity coherence.
- Separated transformation products and locality, with multiplication,
  identity, symmetry, and associativity derived from locality plus action
  effectivity where appropriate.

### Theory layers and forward direction

- `PhenomenalTheory` for Axioms 4.1--4.5.
- `NoSignallingTheory` for the marginal law plus four transformation-product
  laws, with reverse postulates deliberately absent.
- `LocalRealisticCore` for every corrected Section-3 requirement except
  noumenal action effectivity.
- `LocalRealisticTheory` adding exactly noumenal faithfulness.
- Theorem 3.12 at the `LocalRealisticCore` boundary and the full forward
  constructor without any reverse-postulate import dependency.

### Faithfulness quotients

- Appendix A: contextual phenomenal equivalence is a proved setoid and monoid
  congruence; action and transformation product descend; all no-signalling laws
  are re-established; contextual phenomenal faithfulness holds.
- Appendix B: the noumenal action-kernel relation is a proved setoid/congruence;
  both actions, transformation products, phenomenalization equivariance, and
  locality descend; the output noumenal action is effective.
- Appendix A preserves invertibility and preserves/reflects global
  transitivity. The development proves descent of raw transformation
  separation under the stronger
  `TransformationSeparationModuloPhenomenalEquivalence` premise; descent from
  raw separation alone remains open.

### Reverse constructions

- The fundamental relation on global transformations is a proved setoid using
  only existential inverse witnesses, not a globally selected inverse.
- Quotient projectors, actions, honest partial state products, locality, and
  phenomenal maps have explicit representative-independence/coherence proofs.
- The transitive construction uses an explicit reference global phenomenal
  state; global transitivity occurs only in map surjectivity.
- The general construction pairs each fundamental class with a global
  phenomenal-state label, removing global transitivity. Enlarged compatibility
  is exactly label equality plus fundamental compatibility.
- Both constructions first produce a pre-faithful core. Raw phenomenal
  faithfulness or the Appendix-B quotient is applied only afterward.

## Organization and imports

The aggregate import is:

```lean
import RR2021.API
```

Stable narrow APIs are:

- `RR2021.Systems.API`
- `RR2021.Dynamics.API`
- `RR2021.Theories.API`
- `RR2021.Forward.API`
- `RR2021.Faithfulness.API`
- `RR2021.Reverse.API`
- `RR2021.Correspondence.API`
- `RR2021.Quantum.API`
- `RR2021.Models.API`

Examples and audits are diagnostic-only modules excluded from these APIs. The
abstract layers through Correspondence do not import Quantum or Models. Users
who do not want the heavy quantum dependencies should import
`RR2021.Correspondence.API` or a narrower abstract layer instead of the
aggregate root.

## Assumptions and dependency audit

The reverse predicates remain separate:

- `InvertibleDynamics`: each transformation has an existential two-sided
  inverse; the library does not globally strengthen this to an indexed group.
- `TransformationSeparation`: the raw support-intersection postulate, with all
  pairwise system-separation and reindex paths explicit.
- `PhenomenallyFaithful`: contextual identity-extension equivalence implies raw
  equality.
- `GloballyTransitive`: reachability only on the global phenomenal state.

Dependency inspection establishes which implemented constructors omit a
predicate. It does not prove logical necessity or full pairwise independence.
The Stage-11 Bool/Nat model proves separately that base no-signalling alone
does not imply invertibility, phenomenal faithfulness, or global transitivity;
because one model fails all three, it is not described as a pairwise
independence family.

## Corrections and source defects

The correction log contains 20 entries. Their final disposition is:

- Confirmed and repaired conversion/source/type issues:
  `RR-C001`--`RR-C012`, `RR-C014`, `RR-C017`, `RR-C019`, and `RR-C020`.
  These include lost complement bars, wrong appendix references/state sorts,
  malformed iterated-product formulas, a circular definedness proof, the
  unused Definition-4.1 quantifier, corrected Theorem-A.2 hypotheses, quotient
  label/state typos, the repaired headline route, and typed projector/product
  corrections.
- Scoped finite repairs: `RR-C015` and `RR-C016` are proved for finite complex
  coordinate matrices, with explicit nonempty outer factors and derived middle
  unitarity. No arbitrary/infinite-dimensional Hilbert-space theorem is
  claimed.
- Open/unsupported: `RR-C013`, unconditional raw-separation preservation
  through the Appendix-A phenomenal quotient.
- Partial: `RR-C018`, the quantum phase claim. The full-operator-algebra phase
  theorem is proved, but the contextual density-state relation, phase-quotient
  separation, and full quantum instance are not.

The complete evidence, source lines, conservative repairs, and downstream
effects are in `goal-1/corrections.md`.

## Quantum status

`RR2021.Quantum.API` exports two proved subsets:

1. A finite complex-coordinate Appendix-C repair:
   - finite matrix tensor equivalence and Kronecker computation;
   - a six-index overlap equation exposing tensor association;
   - common-middle factorization with explicit nonempty outer factors;
   - identity-tensor injectivity;
   - reflection of both unitary equations; and
   - corrected `commonMiddleUnitaryFactor` with `VB` unitarity derived from
     `VBC = VB ⊗ I_C`.
2. `conjugation_eq_iff_unitaryPhase`: equality of conjugation star-algebra
   equivalences on all continuous endomorphisms exactly when the unitary
   isometries differ by a unitary complex scalar.

It exports no quantum `NoSignallingTheory`. Explicit future work is:

- density-state carrier, positivity/trace-one closure, and nonemptiness;
- partial-trace projectors, nesting, surjectivity, and no-signalling;
- coherent Boolean-indexed Hilbert factors and tensor associators/commutors;
- Definition-4.1 contextual phase completeness on density states;
- phase-quotient raw separation (`RR-C013`);
- a pure-state/ray carrier and global transitivity;
- a full quantum reverse corollary; and
- any unrestricted infinite-dimensional Appendix-C extension.

## Models and countermodels

`RR2021.Models.Trivial` is a stable complete model over the four-element Boolean
algebra `Finset (Fin 2)`. It constructs every local-realistic field, forwards
to no-signalling, proves all four reverse predicates, consumes both general
reverse outputs, and proves raw operational preservation. A separate consumer
imports only `RR2021.API`.

Diagnostic regressions cover:

- right-to-left composition with noncommuting permutations;
- unavailable equality for distinct system indices;
- genuinely incompatible partial-product inputs;
- the three no-signalling non-implications noted above;
- raw distinct transformations collapsing in both faithfulness quotients;
- impossibility of a representative-sensitive raw-value recovery function on
  the noumenal quotient, proved without representative extraction; and
- failure of identity-tensor cancellation on empty left/right factors.

The last quotient regression is generic and does not settle `RR-C013`.

## Exclusions and unresolved claims

Intentionally excluded:

- metaphysical definitions/conclusions about realism, appearance, observation,
  and physical locality;
- sociological endorsement, priority, and claims that other research is
  obsolete;
- external comparisons with hidden-variable interpretations/non-local boxes;
- the cited Leibniz no-go result without a precise imported theorem; and
- speculative removal of invertibility (`RR-OUT-Z02`).

Not proved or defined:

- categorical or logical equivalence of model classes;
- inverse, canonical, or unique reconstruction;
- adequacy/completeness for “all theories” (`RR-OUT-I01`);
- empirical equivalence or observation/probability semantics; and
- the probability-level consequence `RR-S3-U07` without an observation model.

Still open/unsupported mathematically:

- unconditional Appendix-A raw-separation preservation (`RR-C013`).

Partial/deferred:

- the full quantum operational instance and contextual phase claims described
  above.

## Axiom, choice, and no-cheating audit

Principal exported declarations report only the Lean/mathlib foundation
footprint `[propext, Classical.choice, Quot.sound]`, or a subset. This footprint
is expected from Boolean/order extensionality and quotient infrastructure.

There is exactly one explicit project data-selection site:
`Reverse.Transitive.NoumenalState.chosenCommonExtension`. It applies
`Classical.choose` only after
`compatible_uniqueCommonExtension : ∃!` has been proved, and its two facts are
obtained with `choose_spec`. The General product reuses that operation and adds
no choice.

Final scans find no:

- `sorry`, `admit`, placeholder contradiction tactic, project `axiom`,
  `opaque`, or `unsafe` declaration;
- `Quotient.out`/`Quot.out` representative extraction;
- hidden `default`/`Inhabited` fallback; or
- totalized incompatible state product.

Quotient code uses named lift/map/induction operations beside explicit
congruence results.

## Verification and reproducibility

Pinned-environment commands:

```sh
cd formal
lake update
lake build
```

Release verification includes:

```text
lake build RR2021.API RR2021
lake build RR2021.Survey.Audit RR2021.Systems.Audit RR2021.Dynamics.Audit \
  RR2021.Theories.Audit RR2021.Forward.Audit \
  RR2021.Faithfulness.PhenomenalAudit RR2021.Faithfulness.NoumenalAudit \
  RR2021.Faithfulness.Audit RR2021.Reverse.Transitive.Audit \
  RR2021.Reverse.General.Audit RR2021.Correspondence.Audit \
  RR2021.Quantum.Audit RR2021.Models.Audit
lake build RR2021.Systems.Examples RR2021.Dynamics.Examples \
  RR2021.Theories.Examples RR2021.Forward.Examples \
  RR2021.Faithfulness.Examples RR2021.Reverse.Transitive.Examples \
  RR2021.Reverse.General.Examples RR2021.Correspondence.Examples \
  RR2021.Quantum.Examples RR2021.Models.Examples
lake build
python3 scripts/check_stage1_docs.py
git diff --check
```

The release clean-state sequence ran `lake clean`, then exposed one transient
missing `Mathlib/Data/Ineq.olean` artifact despite Lake having reported that
dependency built. Rebuilding `Mathlib.Data.Ineq` (5 jobs) and rerunning the
full command completed all 2,411 jobs. The explicit root build also completed
2,411 jobs; all 13 audit modules completed 2,432 jobs; all 10 example modules
completed 2,419 jobs. The documentation checker covers 88 distinct numbered
source declarations (the source contains 89 occurrences because “Theorem
B.2” is duplicated and represented by two ledger IDs).

## Extension guidance

For a new operational instance:

1. Choose a `BooleanAlgebra System`.
2. Define indexed transformation, noumenal-state, and phenomenal-state
   families with the required indexed monoid/actions.
3. Implement nested projector families and their surjectivity.
4. Implement an honest `StateProduct` with explicit `Separated` and
   `Compatible` evidence.
5. Implement separated `TransformationProduct` and `Locality`.
6. Assemble `LocalRealisticCore`/`LocalRealisticTheory` or
   `NoSignallingTheory`.
7. Prove reverse predicates independently and invoke the desired declaration
   from `RR2021.Correspondence.API`.
8. Put executable consumers in an Examples leaf and signature/axiom checks in
   an Audit leaf; do not import those diagnostics into a stable API.

`RR2021.Models.Trivial` is the smallest public fixture demonstrating this
shape. Nontrivial instances must still prove their own compatibility,
projection, locality, faithfulness, and separation laws.

## Traceability

- Source inventory and realizations: `goal-1/source-ledger.md`
- Corrections/obligations: `goal-1/corrections.md`
- Architecture and conventions: `goal-1/architecture.md`
- Per-stage command evidence: `goal-1/1-SURVEY.md` through
  `goal-1/12-RELEASE.md`
- Master status and requirements: `goal-1/0-plan.md`

Every one of the 149 stable source-ledger entries has an initial disposition
and either a checked realization row or an explicit final exclusion/deferral
boundary.
