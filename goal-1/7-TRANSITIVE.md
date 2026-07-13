# 7-TRANSITIVE

Status: complete

## Current Facts

- The source's fundamental relation at system `A` is an orbit relation on
  transformations of the global system: two global transformations differ by
  left multiplication with an identity-on-`A` transformation supported on
  `Aᶜ`.
- `InvertibleDynamics` supplies existential two-sided inverse witnesses and is
  sufficient for symmetry of this relation; a globally selected inverse
  function or `IndexedGroup` is not automatically justified by that
  postulate.
- Every source expression `U_A × I_{Aᶜ}` or `I_A × V_{Aᶜ}` initially lives at
  `A ⊔ Aᶜ`; its use as a global transformation requires the explicit
  `composite_complement A` reindex.
- Theorem 5.2 uses the corrected relative complement `Aᶜ ⊓ B`, not the
  conversion's printed `A ⊓ B` (`RR-C009`). Stage 2 already proves the three
  separation facts, two decompositions, and coherence of both paths to the
  global system.
- Theorem 5.8 is the only product-uniqueness step: equivalence at separated
  `A` and `B` must imply equivalence at `A ⊔ B`. It consumes invertibility of
  the compared global representative and the explicit transformation-
  separation postulate.
- The existing `Compatible` predicate stores common-extension existence in
  `Prop`, while `StateProduct.product` returns data. Constructing that product
  from compatibility therefore requires a documented unique-choice boundary
  unless the stable dynamics API is redesigned. Choice is legitimate only
  after Theorem 5.8 proves all common extensions yield the same quotient
  state; it may not conceal product existence or uniqueness.
- The reference global phenomenal state used by `φ` is an explicit
  constructor argument. Global transitivity then proves surjectivity without
  selecting a hidden default state.
- PDF printed page 47 confirms that Theorem 5.13's penultimate displayed line
  applies `φ^A_ρ` to the `B`-indexed class `[W]^B`. The corrected typed path
  goes through `[W]^A` before applying `φ^A_ρ` (`RR-C020`).

## Big Picture Objective

Reconstruct the source's first reverse model under explicit invertibility,
transformation separation, contextual phenomenal faithfulness, global
transitivity, and a chosen reference global state, with every quotient,
transport, compatibility, and representative-independence obligation checked.

## Initial Implementation Plan

1. Define the two canonical extensions of a local transformation to the
   global system and prove identity, multiplication, commutation, symmetry,
   associativity, and reindex-coherence lemmas from Axiom 4.6.
2. Define the fundamental relation, prove reflexivity/symmetry/transitivity
   from existential invertibility, expose its `Setoid`, and define the indexed
   quotient noumenal state family.
3. Prove corrected Theorem 5.2 and descend nested/surjective noumenal
   projectors.
4. Descend the local noumenal action and prove its action laws. Prove its
   contextual phenomenal refinement and obtain action effectivity only from
   the explicit phenomenal-faithfulness postulate.
5. Prove Theorem 5.8 with all complement decompositions, cancellation, and
   transformation-separation transports explicit. Use it to prove uniqueness
   of compatible common extensions before introducing the one documented
   unique-choice operation that realizes the honest `StateProduct` interface.
6. Prove product reconstruction, projection laws, compatibility preservation,
   and Theorems 5.9--5.10/locality.
7. For an explicit global reference state, descend `φ_A([W]) = π_A(Wρ)`, then
   prove well-definedness, equivariance, projection compatibility, and
   surjectivity from projector surjectivity plus global transitivity
   (Theorems 5.11--5.14).
8. Assemble first a pre-faithful `LocalRealisticCore`, then the full
   `LocalRealisticTheory`; add stable-API consumer examples, audits, API, and
   exact source/correction updates.

## No-Cheating Checks

- Do not replace `InvertibleDynamics` by `IndexedGroup` unless an explicit
  separate stronger theorem is stated.
- Do not cancel a global representative without obtaining and using the
  appropriate inverse witness.
- Do not use quotient equality where `TransformationSeparation` requires raw
  equality.
- Do not define projectors, actions, products, or `φ` before their relation-
  preservation theorem compiles.
- If unique choice is required by the stable `StateProduct` signature, isolate
  it in one named definition after proving existence and quotient uniqueness;
  audit its exact premise and axiom footprint.
- Do not select the reference phenomenal state through `Classical.choice`.
- Keep all complement/relative-complement and triple-system transports named
  and inspectable.

## Build Structure

- `formal/RR2021/Reverse/Extension.lean`: canonical local/complement global
  extensions and phenomenal marginal lemmas.
- `formal/RR2021/Reverse/Transitive/Relation.lean`: Definition 5.1, Theorem
  5.1, setoid, and quotient state family.
- `formal/RR2021/Reverse/Transitive/Projection.lean`: corrected Theorem 5.2,
  quotient projectors, nesting, and surjectivity.
- `formal/RR2021/Reverse/Transitive/Action.lean`: action descent and action
  laws, Theorems 5.5--5.7.
- `formal/RR2021/Reverse/Transitive/Intersection.lean`: fully transported
  Theorem 5.8.
- `formal/RR2021/Reverse/Transitive/Product.lean`: unique compatible gluing,
  explicit unique-choice boundary, and Theorem 5.9 state product.
- `formal/RR2021/Reverse/Transitive/Locality.lean`: product-action
  factorization, compatibility preservation, and Theorem 5.10.
- `formal/RR2021/Reverse/Transitive/Phenomenalization.lean`: Theorems
  5.11--5.14 and corrected `RR-C020` path.
- `formal/RR2021/Reverse/Transitive/Construction.lean`: pre-faithful core,
  original-transformation full theory, and repaired Appendix-B route.
- `formal/RR2021/Reverse/Transitive/API.lean`: thin stable re-export.
- `formal/RR2021/Reverse/Transitive/Examples.lean` and `Audit.lean`: consumer
  and diagnostic leaves.
- `formal/RR2021/Reverse/API.lean`: completed reverse-layer re-export.
- Focused relation/projection/action build:
  `cd formal && lake build RR2021.Reverse.Transitive.Relation RR2021.Reverse.Transitive.Projection RR2021.Reverse.Transitive.Action`.
- Product/map/constructor build:
  `cd formal && lake build RR2021.Reverse.Transitive.Locality RR2021.Reverse.Transitive.Phenomenalization RR2021.Reverse.Transitive.Construction RR2021.Reverse.Transitive.Examples`.
- Adjacent consumers:
  `cd formal && lake build RR2021.Reverse.Transitive.API RR2021.Reverse.Transitive.Audit RR2021.Reverse.API RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## Completion Requirements

- [x] The fundamental relation is a proved setoid and the quotient state
  family is exported.
- [x] Both global-extension operations and every descent theorem compile.
- [x] Corrected Theorems 5.2 and 5.8 discharge projector and product
  representative independence.
- [x] The honest compatibility-indexed state product and locality compile,
  with any unique-choice boundary explicitly documented and audited.
- [x] The reference-state phenomenalization is well-defined, equivariant,
  projection-compatible, and surjective under global transitivity.
- [x] A constructor returns the promised local-realistic model under exactly
  the visible reverse hypotheses, with no unqualified equivalence claim.
- [x] Focused, adjacent, full-build, source-scan, axiom, documentation,
  whitespace, and scoped-review gates pass.

## Stage Results

### Fundamental quotient, projectors, and action

- `extendSystem` and `extendComplement` reindex the input product from
  `A⊔Aᶜ` to `⊤`. Their identity, multiplication, commutation, and phenomenal
  marginal laws are proved from the input `NoSignallingTheory` only.
- `FundamentallyEquivalent` uses the source's left-action orientation.
  `fundamentalSetoid` proves Theorem 5.1 using product laws for
  reflexivity/transitivity and one existential complementary inverse for
  symmetry. No group structure or global inverse choice is added.
- Corrected Theorem 5.2 is `FundamentallyEquivalent.mono`. Its proof uses
  `C=Aᶜ⊓B`, the Stage 2 typed decomposition, associativity/unitality, and the
  named coherence theorem for both paths to `⊤`. The quotient projectors are
  then nested and surjective.
- The local quotient action is representative-independent because local and
  complement-supported global extensions commute. Its identity and
  multiplication laws use the standard left-action orientation.

### Product, locality, and the exact choice boundary

- `FundamentallyEquivalent.intersection` is Theorem 5.8 with every transport
  visible. It cancels the common global representative using an existential
  right inverse, rewrites the two complement witnesses at the canonical
  triple system, and calls raw `TransformationSeparation` once.
- `compatible_iff_exists_globalRepresentative` verifies the source's
  unnumbered compatibility claim. `stateProduct_mk_mk` states Definition 5.6
  directly: `[W]_A⊙[W]_B=[W]_{A⊔B}`.
- `compatible_uniqueCommonExtension` proves `∃!` before
  `chosenCommonExtension` applies the stage's sole explicit
  `Classical.choose`. Existence comes from the supplied `Compatible` proof and
  uniqueness from Theorem 5.8. There is no value or branch for incompatible
  inputs and no quotient representative is selected.
- `stateProduct` proves Theorem 5.9. The two global-extension factorization
  theorems then give component projections of a transformed composite,
  compatibility preservation, and the complete Theorem-5.10 `Locality`.

### Phenomenalization and final constructors

- For explicit `reference : PhenomenalState ⊤`, `phenomenalization` sends
  `[W]_A` to `π_A(W•reference)`. No-signalling proves Theorems 5.11--5.12.
  Projector nesting proves Theorem 5.13 through the PDF-confirmed corrected
  `[W]^B→[W]^A→φ^A` path. Only Theorem 5.14 consumes global transitivity.
- `coreAtReference` assembles every local-realistic field except action
  effectivity without phenomenal faithfulness. `actionEffectiveAtReference`
  applies the already-checked contextual Theorem 4.2 only after that core is
  complete; input `PhenomenallyFaithful` is used once to obtain raw equality.
- `theoryAtReference` is the source-faithful transitive constructor retaining
  the input transformation family. `faithfulQuotientAtReference` is the
  transitive `RR-C017` repair: it consumes invertibility and separation before
  applying Appendix B and therefore needs no phenomenal-faithfulness premise
  or quotient preservation of reverse postulates.
- Stable-API consumer regressions confirm inferable actions, ordinary theory
  field projection, and derived product laws for both full outputs. Three
  independent reviews found no mathematical, representative-independence,
  typeclass, or import-boundary issue.

### Exact verification evidence

Focused relation/projection/action/intersection:

```text
$ cd formal && lake build RR2021.Reverse.Transitive.Relation RR2021.Reverse.Transitive.Projection RR2021.Reverse.Transitive.Action RR2021.Reverse.Transitive.Intersection
Build completed successfully (391 jobs).
```

Product, map, constructors, and consumers:

```text
$ cd formal && lake build RR2021.Reverse.Transitive.Locality RR2021.Reverse.Transitive.Phenomenalization RR2021.Reverse.Transitive.Construction RR2021.Reverse.Transitive.Examples
Build completed successfully (471 jobs).
```

Adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Reverse.Transitive.API RR2021.Reverse.Transitive.Audit RR2021.Reverse.API RR2021.API RR2021
Build completed successfully (485 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (484 jobs).
```

The audit reports `[propext, Classical.choice, Quot.sound]`, the same
Boolean/order and quotient foundations visible in earlier stages. Since that
footprint cannot distinguish inherited choice from the deliberate unique-
choice boundary, a static scan separately confirms exactly one explicit data
selection: `Classical.choose` in `chosenCommonExtension`, plus its two
`choose_spec` projections. Final scans find no proof hole, project
`axiom`/`opaque`, off-domain default, `Inhabited`, quotient representative
extraction, raw cast, or unexplained equality eliminator. The documentation
checker, PDF visual check, `git diff --check`, public-consumer probes, and
scoped reviews pass.

Stages 8--11 subsequently completed the general construction, exact theorem
family, finite Appendix-C repair, and consolidated model suite. All stages are
now complete; final release evidence is recorded in `goal-1/12-RELEASE.md`.
