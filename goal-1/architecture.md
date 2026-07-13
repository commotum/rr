# RR2021 Architecture Decision Record

Date: 2026-07-12  
Stage: `1-SURVEY`, finalized at `12-RELEASE`  
Status: finalized; the original decisions were validated and the realized graph is recorded below

## Decision Scope

This record specializes the generic repository-root `BUILD-PLAN.md` for the RR2021 library. It does not modify the generic policy and does not assert any theorem from the paper. Its purpose is to choose low-risk encodings, expose assumptions, and define an incremental import/build graph.

The following invariants control all later choices:

1. Abstract theory code is independent of the optional quantum layer.
2. Forward assumptions do not import reconstruction assumptions.
3. Group structure, separation, faithfulness, and transitivity are mixins or theorem parameters, not fields of the minimal operational theory.
4. Partial products have a typed domain containing compatibility evidence.
5. Quotient operations descend only through named congruence results.
6. Equality of system expressions is handled by named reindexing/coherence lemmas, not unreviewed casts.
7. Audit, example, and counterexample modules are diagnostic-only and excluded
   from stable APIs; heavy reconstruction proofs stay outside high-fanout cores.

## Mathematical Dependency Graph

The graph records dependency, not equivalence.

```text
bounded distributive/complemented system algebra
  -> subsystem, disjointness, complement, composite
  -> indexed state and transformation families
       -> monoid actions and equivariant phenomenal maps
       -> nested projectors
       -> compatibility witnesses and partial state products
       -> products of separated transformations

system + phenomenal states/actions/projectors + transformation product laws
  -> minimal phenomenal operational theory
  -> no-signalling predicate / no-signalling theory

minimal phenomenal operational theory
  + noumenal states/actions/projectors
  + surjective equivariant phenomenal map
  + compatible noumenal product laws
  + local transformation product law
  -> LocalRealisticCore
       -> core state-level no-signalling theorem
  + effective noumenal action
  -> LocalRealisticTheory
       -> full local-realistic-to-no-signalling constructor

no-signalling theory
  + phenomenal observational Setoid
  + composition/action/product congruence
  -> phenomenally faithful quotient theory

local-realistic theory without effective noumenal action
  + noumenal kernel Setoid
  + composition/noumenal-action/phenomenal-action/product congruence
  -> noumenally faithful quotient theory

no-signalling theory
  + existentially invertible dynamics
  + raw transformation separation
  + explicit global reference state
  + global transitivity
  -> transitive pre-faithful reverse core
       + contextual phenomenal faithfulness -> full raw-transformation theory
       + noumenal action-kernel quotient -> full quotient-transformation theory

no-signalling theory
  + existentially invertible dynamics
  + raw transformation separation
  + enlarged noumenal state carrying a global phenomenal-state label
  -> general pre-faithful reverse core without global transitivity
       + contextual phenomenal faithfulness -> full raw-transformation theory
       + noumenal action-kernel quotient -> full quotient-transformation theory

phenomenal-faithfulness quotient
  + a separately proved quotient-stable separation hypothesis
  -> may feed either reverse construction

original no-signalling theory with separation and existential invertibility
  -> reverse construction satisfying all local-realistic laws except effective
     noumenal action
  + noumenal-action-kernel quotient with all descent laws
  -> alternative faithful local-realistic model route

finite-dimensional complex Hilbert-space facts
  -> finite coordinate common-middle-unitary theorem
  -> full-operator-algebra unitary-phase theorem
  -> no complete density/partial-trace operational instance (explicit boundary)
```

Interpretative statements about what physical theories *are*, metaphysical locality, empirical equivalence, or uniqueness have no edge into the Lean graph unless a later stage first supplies a precise mathematical predicate.

## Stage-1 proposed Lean module graph (historical)

`formal/` is the Lake project root. `RR2021.lean` is a thin public root. Internal modules import downward or sideways only when the dependency is explicit.

```text
RR2021/
  Survey/                 Stage-1 encoding probes; not permanent theorem API
    Systems.lean
    IndexedAction.lean
    Quotient.lean
    PartialProduct.lean
    API.lean
    Audit.lean
  Systems/
    Core.lean             carrier operations and predicates
    Basic.lean            lattice/disjointness/decomposition lemmas
    Transport.lean        named reindexing and coherence
    API.lean
  Dynamics/
    Core.lean             indexed families, transformations, actions, maps
    Projection.lean       projector interfaces and nesting
    Product.lean          compatibility domains and partial products
    Basic.lean            inexpensive reusable laws
    API.lean
  Theory/
    Operational.lean      minimal phenomenal operational data
    NoSignalling.lean     no-signalling proposition/structure
    LocalRealistic.lean   noumenal extension
    Mixins.lean           invertibility, separation, faithfulness, transitivity
    API.lean
  Forward/
    Core.lean             assumption-minimal forward proof
    Audit.lean
    API.lean
  Quotient/
    Observational.lean    Setoids and equivalence proofs
    Phenomenal.lean       phenomenal quotient descent
    Noumenal.lean         noumenal quotient descent
    Audit.lean
    API.lean
  Reconstruction/
    Core.lean             shared relation/descent lemmas only when hypotheses align
    Transitive.lean       global-transitivity construction
    General.lean          enlarged-state construction
    Audit.lean
    API.lean
  Correspondence/
    Theorems.lean         separate exported theorem family
    Audit.lean
    API.lean
  Quantum/
    LinearAlgebra.lean    isolated finite-dimensional supporting facts
    Operational.lean
    Separation.lean
    Audit.lean
    API.lean
  Examples/
    Trivial.lean
    FiniteClassical.lean
    Independence.lean
    PublicImport.lean
  Audit/
    Axioms.lean
    Signatures.lean
  API.lean                stable re-exports only
RR2021.lean               public library root importing RR2021.API
```

Files are introduced only when a stage has a real declaration to own. The graph is a placement policy, not permission to create empty scaffolding.

## Realized release module graph

The final source tree follows the original layering but uses the names that
emerged from checked obligations:

```text
RR2021/
  Systems/              Core, Basic, Transport, API, Examples, Audit
  Dynamics/             indexed core/map/reindex, Projection,
                        StateProduct*, TransformationProduct*, Locality,
                        API, Examples, Audit
  Theories/             Core, LocalRealistic, NoSignalling, Postulates,
                        Basic, API, Examples, Audit
  Forward/              Core, Construction, API, Examples, Audit
  Faithfulness/         Phenomenal* and Noumenal* quotient/descent modules,
                        API, Examples, Audit leaves
  Reverse/
    Transitive/         relation, projectors, action, product, locality,
                        phenomenalization, construction, API/audit/examples
    General/            enlarged state, product, locality,
                        phenomenalization, construction, API/audit/examples
    API.lean
  Correspondence/       Theorems, API, Examples, Audit
  Quantum/              FiniteMatrix, Phase, API, Examples, Audit
  Models/               Trivial, API, root-only Examples, consolidated Audit
  Survey/               historical Stage-1 probes only
  API.lean              stable aggregate; excludes examples/audits
RR2021.lean              imports only RR2021.API
```

The abstract layers through Correspondence have no Quantum or Models import.
`RR2021.Quantum.API` exports only the proved finite/operator-algebra subset,
and diagnostic leaves remain outside all stable APIs.

## Encoding Decisions

### ADR-001: Systems

Candidates considered:

| Candidate | Advantages | Risks | Decision |
| --- | --- | --- | --- |
| An abstract `BooleanAlgebra System` | Directly supplies `\u22a5`, `\u22a4`, `\u2293`, `\u2294`, complement, distributivity, and mathlib `Disjoint`; close to Definition 3.1 | Stronger than many individual lemmas need; complement uniqueness is bundled | Use as the initial carrier-level sufficient interface; minimize hypotheses on individual Stage-2 lemmas |
| A custom six-field paper lattice | Textually close to the source | Reimplements standard laws, increases proof surface, and may silently omit order/coherence laws | Reject unless a checked source mismatch with `BooleanAlgebra` appears |
| Finite sets of atoms | Concrete equality/normalization and easy examples | Illegitimately assumes atomicity and finiteness in the abstract theorem | Examples only |
| A normalized syntax of system expressions | Definitional associativity can reduce transports | Equality/normalization proof becomes a second algebra and risks changing the source semantics | Reject for core; possibly a test fixture |

`Subsystem A B` will initially be ordinary order `A \u2264 B`, equivalent in a lattice to `A \u2293 B = A`. `Separated A B` will use `Disjoint A B`, and a composite is `A \u2294 B` together with the separation witness where an operation requires it. Global and empty systems are `\u22a4` and `\u22a5`.

### ADR-002: Indexed state and transformation families

Candidates considered:

| Candidate | Advantages | Risks | Decision |
| --- | --- | --- | --- |
| Families `System \u2192 Type` | Makes system indices and mismatches visible; standard dependent functions | Equal composite expressions require transport | Select; add a named reindexing API in `Systems.Transport` |
| One unindexed type plus a system tag | Fewer casts | Permits invalid cross-system operations unless every function rechecks tags | Reject for stable API |
| A category/fibration encoding | Strong abstract coherence tools | Premature complexity and heavy dependencies before actual obligations are known | Defer; reconsider only if Stage 2/3 coherence cannot be localized |

The family universe is not assumed uniform beyond what Lean declarations state. Nonemptiness is an explicit field or parameter only where the source uses it.

### ADR-003: Actions and composition orientation

Use mathlib/Lean `MulAction` over an indexed monoid throughout. Reconstruction
adds the separate `InvertibleDynamics` predicate, giving an existential
two-sided inverse for each transformation without globally selecting inverses
or installing an indexed `Group`. Standard left-action law is
`(g * h) \u2022 x = g \u2022 (h \u2022 x)`, matching the paper's convention that
composition `UV` applies `V` and then `U`; a compiled noncommutative regression
pins this orientation.

Equivariance and surjectivity of the noumenal--phenomenal map remain separate predicates. Faithfulness/effectivity is expressed as injectivity of the action homomorphism or the explicit pointwise implication needed by a theorem, never by overloading surjectivity.

### ADR-004: Reindexing and coherence

Use dependent equality elimination only inside named helpers such as `reindex`, with identity and composition lemmas. Commutativity/associativity of `\u2294` may produce propositionally equal indices; public theorems state the equality or use the helper rather than relying on reducibility of raw `Eq.rec` terms. `Classical.choice` is not a transport mechanism.

### ADR-005: Quotients

Start each observational relation as a named predicate, prove `refl`, `symm`, and `trans`, then package a `Setoid`. Define quotient maps/actions/products with `Quotient.lift`/`Quotient.map` only beside named congruence theorems. Representative independence is a first-class theorem and is audited by source search. Quotients are not used to hide an unproved existence or compatibility fact.

In particular, Appendix A's assertion that phenomenal quotienting preserves the separation postulate is not accepted as automatic: quotients can enlarge intersections of embedded transformation subgroups. A phenomenally faithful quotient may enter reconstruction only with a proved quotient-level separation theorem or an explicit quotient-stability hypothesis. The alternative route is to reconstruct the noumenal layer before imposing effective action, then apply the independently verified Appendix B quotient.

### ADR-006: Partial products

The source's noumenal product is defined only for compatible states, although
Axiom 3.12 describes reconstruction from a composite state. The realized
`Compatible` predicate is the existence of a common composite state with the
two required projections. `StateProduct.product` accepts explicit `Separated`
and `Compatible` evidence and returns a composite-indexed state; its laws prove
proof independence, both projections, reconstruction, and coherence. No
arbitrary result exists for an incompatible pair.

Transformation products are a different operation: the source treats them as total for a *separated pair of systems*. Their system-separation witness remains explicit even though each transformation pair is total inside that domain.

## Historical Mathlib API Probe Targets

The Stage-1 compiling probes established availability and convention for:

- `BooleanAlgebra`, `Disjoint`, bounded lattice notation, complement, and lattice simp lemmas;
- `Monoid`, `Group`, `MulAction`, `mul_smul`, and `one_smul`;
- dependent families, `cast`/equality elimination, and named reindex helpers;
- `Setoid`, `Quotient`, `Quotient.lift`/`Quotient.map`, and explicit congruence arguments;
- `Function.Surjective` and `Function.Injective` as separate properties;
- later only: finite-dimensional modules, tensor products, continuous linear maps, unitary operators, and partial trace APIs.

The quantum APIs were surveyed but intentionally not imported into Stage-1
spikes. Stage 10 found usable finite-matrix and continuous-operator APIs, but
no ready density-operator/partial-trace abstraction for the full instance.

## Protected High-Fanout Modules

Once created, edits to these modules require explicit stage justification and adjacent-consumer builds:

- `RR2021.lean` and `RR2021/API.lean`;
- `RR2021/Systems/Core.lean` and `RR2021/Systems/Transport.lean`;
- `RR2021/Dynamics/Core.lean`;
- `RR2021/Theories/Core.lean` and `RR2021/Theories/LocalRealistic.lean`.

Heavy proofs must not move into these files for convenience. Quotient diagnostics, counterexamples, theorem axiom prints, and quantum experiments remain in leaf modules.

## Incremental Build Policy

From `formal/`:

```text
lake build RR2021.Survey.Systems
lake build RR2021.Survey.IndexedAction
lake build RR2021.Survey.Quotient
lake build RR2021.Survey.PartialProduct
lake build RR2021.Survey.API RR2021.Survey.Audit RR2021
lake build
```

For later stages, build the touched leaf first, then its stage `API`, then `RR2021` only when the public import graph changes. The project loop additionally requires a full `lake build` at every completed stage.

## Boundary and Audit Policy

- `RR2021/Survey/Audit.lean` may import the survey API, but the survey API and public root do not import the audit leaf.
- Abstract modules do not import `RR2021.Quantum`.
- A scan for `sorry|admit|axiom|opaque|Classical.choice` is reviewed semantically; documentation policy text is not a code violation, while Lean hits require classification or removal.
- Every quotient construction is paired with a search for `Quotient.` and manual inspection of its congruence proof.
- Every state product signature is inspected for an explicit compatibility witness.
- Principal theorem modules later receive `#print axioms` evidence in an audit leaf. Stage 1 has only definitions and small encoding lemmas, so its audit demonstrates foundations without pretending to audit a nonexistent main theorem.

## Consequences and Revisit Triggers

- Boolean-algebra use is sufficient but not yet minimal. Stage 2 must record which lemmas need only semilattice, distributive lattice, bounded lattice, or complement laws.
- Dependent families create transport obligations intentionally; if named transport laws do not control them, Stage 2 may reconsider a bundled indexed-equivalence API, with a migration record.
- Standard `MulAction` fixes composition orientation. A mismatch discovered in a paper formula becomes a correction, not a custom reversed global action.
- Compatibility witnesses can carry proof data. If proof equality affects definitional behavior, product laws must be propositionally proved independent of witness; proof irrelevance may be used only after the mathematical output is already fixed by explicit equalities.
- The general reverse construction and Appendix C contain known audit-sensitive obligations. No architecture choice assumes those obligations are already valid.
