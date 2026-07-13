# 6-FAITHFUL

Status: complete

## Current Facts

- Appendix A quotients transformations by contextual phenomenal
  equivalence: identity extensions of two transformations must act equally on
  every state of every separated enlargement.
- Appendix B quotients transformations by the kernel of their noumenal
  action: two transformations are related exactly when they act equally on
  every noumenal state at their own system.
- These are different relations with different proof obligations.  They are
  therefore implemented and audited independently rather than hidden behind
  a generic quotient constructor.
- Appendix A Theorem A.2 has the hypothesis-pairing error recorded as
  `RR-C012`; composition congruence uses corresponding outer and inner
  representatives.
- The Appendix A statement that transformation separation automatically
  survives quotienting has the gap recorded as `RR-C013`: quotient equality
  is contextual observational equivalence, while the source separation
  postulate requires raw equality before it can be applied.
- Appendix B is the repaired route recorded as `RR-C017`: it starts from a
  complete local-realistic core lacking only noumenal action effectivity,
  retains the state/projector/product/map data, and quotients the
  transformation action kernel to obtain a full local-realistic theory.
- Every quotient operation must be defined through a nearby named
  congruence theorem.  No representative is selected to define an action,
  product, or map.

## Updated Assumptions

- The phenomenal quotient starts from a `NoSignallingTheory`; it must prove
  that the contextual relation is a setoid and that multiplication, local
  phenomenal action, and separated transformation product respect it.
- Preservation of `InvertibleDynamics` and `GloballyTransitive` requires no
  representative choice: existential raw witnesses can be mapped into
  quotient classes.
- Preservation of transformation separation is exported only under a
  quotient-stable replacement premise stated at the exact observational
  strength needed by the quotient conclusion.  Raw
  `TransformationSeparation` is not silently strengthened.
- The noumenal quotient starts from `LocalRealisticCore`, not the already
  faithful extension.  Pointwise action equality supplies multiplication
  congruence directly; equivariance plus phenomenalization surjectivity
  supplies phenomenal-action congruence; locality plus state-product
  extensionality supplies product congruence.
- State families, projectors, noumenal state product, and phenomenalization do
  not themselves need quotienting in Appendix B.  Only transformations and
  their two actions/product are replaced.

## Big Picture Objective

Formalize both source faithfulness quotients with all relation and descent
obligations explicit, prove their precise faithful-action conclusions, and
turn the Appendix A separation-preservation overclaim into an inspectable
conditional boundary.

## Detailed Implementation Plan

1. Define contextual phenomenal equivalence as an indexed setoid and prove
   its equivalence laws and local-action consequence (Theorem A.1).
2. Prove corrected multiplication congruence (Theorem A.2) and separated
   transformation-product congruence (Theorem A.3).
3. Define the phenomenal quotient monoids, phenomenal actions, and
   transformation products only through those named descent lemmas; construct
   the quotient no-signalling theory and prove contextual phenomenal
   faithfulness (Theorem A.4 and associated unnumbered claims).
4. Prove preservation results for the postulates that genuinely descend and
   expose the exact additional modulo-equivalence separation premise needed
   for any separation result.
5. Define noumenal action equivalence as an indexed setoid and prove
   phenomenal-action, multiplication, and transformation-product congruence
   (Theorems B.1--B.3).
6. Define the noumenal quotient monoids, both descended actions, and descended
   transformation product.  Reuse the original state/projector/product/map
   data, prove quotient locality (Theorem B.4), and construct a
   `LocalRealisticTheory` whose noumenal action is effective.
7. Add diagnostic examples and an audit leaf, thin API re-export, traceability
   updates, and exact build/no-cheating evidence.

## Build Structure

- `formal/RR2021/Faithfulness/PhenomenalCore.lean`: Appendix A setoid,
  Theorems A.1--A.2, quotient monoid, and descended action.
- `formal/RR2021/Faithfulness/PhenomenalProduct.lean`: transport-explicit
  Theorem A.3 product congruence.
- `formal/RR2021/Faithfulness/PhenomenalConstruction.lean`: descended product,
  all five Axiom 4.6 laws, no-signalling constructor, and contextual
  faithfulness.
- `formal/RR2021/Faithfulness/PhenomenalPreservation.lean`: invertibility,
  global transitivity, and the conditional separation boundary.
- `formal/RR2021/Faithfulness/NoumenalCore.lean`: Appendix B action-kernel
  setoid/congruence, quotient monoid/action, and effectivity.
- `formal/RR2021/Faithfulness/NoumenalPhenomenal.lean`: Theorem B.1,
  phenomenal-action descent, and quotient equivariance.
- `formal/RR2021/Faithfulness/NoumenalProduct.lean`: Theorem B.3, quotient
  transformation product, and Theorem-B.4 locality descent.
- `formal/RR2021/Faithfulness/NoumenalContextual.lean`: Theorems 4.2--4.3 at
  full contextual strength.
- `formal/RR2021/Faithfulness/Noumenal.lean`: theory-tagged transformation
  family and directly consumable Appendix B constructor.
- `formal/RR2021/Faithfulness/Examples.lean`: quotient regressions and
  assumption-strength diagnostics.
- `formal/RR2021/Faithfulness/API.lean`: thin stable re-export.
- `formal/RR2021/Faithfulness/Audit.lean`: signatures and axiom prints.
- Focused core builds:
  `cd formal && lake build RR2021.Faithfulness.PhenomenalCore RR2021.Faithfulness.NoumenalCore RR2021.Faithfulness.NoumenalContextual`.
- Quotient construction/example builds:
  `cd formal && lake build RR2021.Faithfulness.PhenomenalPreservation RR2021.Faithfulness.Noumenal RR2021.Faithfulness.Examples`.
- Adjacent consumers:
  `cd formal && lake build RR2021.Faithfulness.API RR2021.Faithfulness.Audit RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- Every quotient relation has an explicit `Setoid` with proved reflexivity,
  symmetry, and transitivity.
- Every `Quotient.lift` or `Quotient.map` is adjacent to a named
  representative-independence theorem; quotient induction is used for laws,
  never representative selection.
- The Appendix B constructor takes `LocalRealisticCore`, and its output
  faithfulness theorem is derived from `Quotient.sound` rather than assumed.
- The Appendix A constructor does not accept or manufacture raw
  transformation separation.  Any preservation theorem names its stronger
  modulo-equivalence premise in the signature.
- Scan for proof holes, project axioms/opaque declarations, explicit
  `Classical.choice`, defaults/`Inhabited`, arbitrary off-domain state
  products, and raw equality elimination outside the established reindex API.

## Boundary Checks

- Relation boundary: contextual phenomenal equality and noumenal action-kernel
  equality remain distinct public notions.
- State boundary: Appendix A retains phenomenal states; Appendix B retains
  both state families and never quotients state representatives.
- Partiality boundary: the retained Appendix B noumenal product has exactly
  its original compatibility-indexed domain.
- Assumption boundary: Appendix B creates only the missing action
  effectivity; Appendix A's separation gap remains visible.
- Direction boundary: these are normalization constructions, not either
  reverse model construction and not an unqualified equivalence theorem.

## Completion Requirements

- [x] Both relations are proved equivalence relations and exported as
  indexed setoids.
- [x] Every monoid, action, and transformation-product operation has a named
  congruence theorem and compiles on the quotient.
- [x] The phenomenal quotient supplies a faithful no-signalling theory at
  exactly the proved strength and records the separation gap.
- [x] The noumenal quotient constructs a full `LocalRealisticTheory` from
  `LocalRealisticCore`, with locality and action effectivity proved.
- [x] Appendix A/B ledger entries and `RR-C002`, `RR-C012`--`RR-C014`, and
  `RR-C017` are updated with exact realizations.
- [x] Focused, adjacent, and full builds; scans; axiom audit; documentation
  check; `git diff --check`; and scoped review pass.

## Stage Results

### Appendix A

- `phenomenalSetoid` proves corrected contextual phenomenal equivalence is an
  equivalence relation. `phenomenallyEquivalent_action_eq` proves Theorem A.1
  through the explicit empty-system extension and no-signalling marginal.
- `phenomenallyEquivalent_mul` implements corrected Theorem A.2 (`RR-C012`)
  with corresponding outer and inner representatives. The `Con` built from
  this theorem supplies the quotient monoid; Theorem A.1 supplies its action.
- `phenomenallyEquivalent_product` proves Theorem A.3 with all identity,
  associativity, symmetry, and reindex transports exposed. It is exactly the
  representative-independence proof used by `phenomenalTransformationProduct`.
- `phenomenalQuotientTheory` proves no-signalling plus multiplication,
  identity, symmetry, and associativity separately. Its faithfulness theorem
  is the source's contextual `PhenomenallyFaithful`, not the unsupported
  stronger claim that equality of local actions alone determines a class.
- Invertibility descends, and global transitivity is preserved and reflected.
  Separation descends only from
  `TransformationSeparationModuloPhenomenalEquivalence`. The source's claim
  that raw separation automatically survives remains the confirmed `RR-C013`
  gap.

### Appendix B

- `NoumenallyEquivalent` is pointwise equality of the noumenal action.
  `noumenalActionSetoid` and `noumenalActionCon` expose its equivalence and
  multiplication-congruence proofs. The quotient noumenal action is effective
  by `Con.eq`; no faithfulness premise is stored.
- Surjective equivariance proves Theorem B.1. B.3 is proved for an arbitrary
  composite state by comparing both locality marginals and using honest
  `StateProduct.eq_of_projections`; it does not assume every arbitrary factor
  pair has a product.
- Both actions, the transformation product, phenomenalization equivariance,
  and full `Locality` descend. The state families, projectors,
  phenomenalization, and compatibility-indexed noumenal state product are
  reused unchanged.
- `noumenallyEquivalent_contextuallyPhenomenallyEquivalent` checks the full
  refinement claim, not merely local action equality.
  `noumenallyFaithful_of_contextualPhenomenalFaithfulness` is Theorem 4.3 at
  the noncircular pre-faithful-core boundary.
- `LocalRealisticCore.toNoumenallyFaithfulQuotient` returns a full
  `LocalRealisticTheory`. Its theory-tagged transformation family makes the
  quotient monoid and both actions inferable after construction; regression
  tests project fields, derive product laws, and run the forward constructor
  without reinstalling hidden local instances.

### Audit and examples

The natural-number/trivial-Boolean-action model proves raw `1 ≠ 2`, while
both quotient relations identify the corresponding classes. Thus neither
quotient example is vacuous. The two audit leaves report the standard
foundation `[propext, Classical.choice, Quot.sound]` on transport-sensitive
principal declarations. The `Classical.choice` dependency is inherited from
mathlib's Boolean-algebra-to-order instance path already present in earlier
stages; no explicit representative choice occurs in Faithfulness sources.

### Exact verification evidence

Focused quotient cores:

```text
$ cd formal && lake build RR2021.Faithfulness.PhenomenalCore RR2021.Faithfulness.NoumenalCore RR2021.Faithfulness.NoumenalContextual
Build completed successfully (460 jobs).
```

Constructors and non-vacuous regressions:

```text
$ cd formal && lake build RR2021.Faithfulness.PhenomenalPreservation RR2021.Faithfulness.Noumenal RR2021.Faithfulness.Examples
Build completed successfully (672 jobs).
```

Adjacent public/audit consumers:

```text
$ cd formal && lake build RR2021.Faithfulness.API RR2021.Faithfulness.Audit RR2021.API RR2021
Build completed successfully (476 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (473 jobs).
```

Final source scans find no proof hole, project `axiom`/`opaque`, explicit
`Classical.choice`, quotient representative extraction, default/`Inhabited`,
or raw equality elimination in the Faithfulness layer. Every lift/map is
adjacent to A.1, A.3, B.1, B.3, or a named action-kernel congruence. The
88-declaration documentation checker, `git diff --check`, downstream consumer
probes, and two independent scoped reviews pass.

Stages 7--11 subsequently completed both reverse constructions, the exact
public theorem family, the finite Appendix-C repair, and the consolidated model
suite. All stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
