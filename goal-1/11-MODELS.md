# 11-MODELS

Status: complete

## Current Facts

- Concrete finite or trivial examples already exist at every earlier layer,
  but most are diagnostic leaves importing implementation modules. The reverse
  and correspondence examples consume stable layer APIs generically; no
  concrete end-to-end classical model imports only the root `RR2021.API`.
- Existing regressions already detect reversed action order, incompatible
  identity-projector states, missing pairwise separation, lost complement
  notation, failure of invertibility/phenomenal faithfulness/global
  transitivity in a valid no-signalling theory, and nontrivial collapse under
  both faithfulness quotients.
- The finite quantum examples additionally show that tensor cancellation fails
  when either outer coordinate type is empty.
- The existing boundary no-signalling model fails three reverse assumptions at
  once. It proves that none is implied by the base no-signalling structure; it
  does not establish pairwise logical independence, and Stage 11 must not
  describe it that way.
- A representative-sensitive raw-value function should be shown unable to
  descend through the noumenal quotient once raw `1` and `2` are identified.
  This supplies the missing negative quotient-descent regression.

## Updated Assumptions

- Promote one singleton-state/singleton-transformation model to a stable
  `Models` module. Keep richer countermodels in audit/example leaves so the
  public model API stays small.
- Build the stable model over a nontrivial finite Boolean system algebra and
  expose its full local-realistic theory, forward no-signalling image, exact
  reverse postulates, and both general reverse outputs.
- Use a root-API-only consumer leaf to verify the public import path. It may not
  reach previous internal Examples modules.
- Consolidate prior regressions by exact theorem references rather than
  duplicating their proofs or broadening their claims.

## Big Picture Objective

Stress-test the complete stable API with a concrete nonempty classical model
and consolidate machine-checked countermodels for the major representation,
transport, partiality, quotient, and assumption boundaries.

## Detailed Implementation Plan

1. Add a finite Boolean-system trivial model with explicit projectors, honest
   state product, transformation product, locality, phenomenalization, full
   local-realistic theory, and forward no-signalling image.
2. Prove its invertibility, raw transformation separation, contextual
   phenomenal faithfulness, and global transitivity; instantiate both general
   reverse outputs and the raw reverse/forward operational-data theorem.
3. Add a consumer importing only `RR2021.API`, exercising the stable model,
   forward construction, both general reverse families, and public field/
   instance inference.
4. Add a diagnostic boundary audit importing earlier Examples leaves. Recheck
   composition order, distinct-system transport premise, incompatible product,
   reverse-assumption failures, quotient collapse, non-descending raw-value
   extraction, and both empty tensor factors.
5. Fold the exact model/countermodel inventory into the plan and release report
   without claiming pairwise independence not established by the examples.

## Build Structure

- `formal/RR2021/Models/Trivial.lean`: stable concrete end-to-end model.
- `formal/RR2021/Models/API.lean`: thin stable re-export.
- `formal/RR2021/Models/Examples.lean`: root-API-only public consumer.
- `formal/RR2021/Models/Audit.lean`: consolidated diagnostic boundaries and
  axiom/signature checks; imports earlier Examples leaves.
- `formal/RR2021/API.lean`: re-export the stable Models API.
- Focused build: `cd formal && lake build RR2021.Models.Trivial`.
- Consumer/audit build:
  `cd formal && lake build RR2021.Models.Examples RR2021.Models.Audit`.
- Adjacent public build:
  `cd formal && lake build RR2021.Models.API RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- The stable model must construct every field; no project axiom, opaque
  placeholder, or imported earlier example may supply it.
- The model's state product remains compatibility-indexed even though all
  singleton states happen to be compatible.
- The public consumer must import only `RR2021.API`.
- A no-signalling model failing several assumptions may prove each
  non-implication from no-signalling, but may not be called a pairwise
  independence family.
- The quotient negative test must derive contradiction from an already-proved
  quotient equality; it may not inspect a quotient representative.

## Boundary Checks

- A distinct-system regression proves the required system equality is absent;
  it does not attempt to write an ill-typed raw cross-index equality.
- Incompatible-product detection remains a negated `Compatible` proposition,
  not an arbitrary off-domain product evaluation.
- Quotient collapse and the impossibility of raw-value descent are kept
  separate from the valid quotient constructors.
- Models API imports no diagnostic Examples or Audit leaf.

## Completion Requirements

- [x] A nonempty finite classical model compiles and exercises forward plus
  both general reverse outputs through stable public declarations.
- [x] A consumer importing only `RR2021.API` compiles and infers all required
  instances and derived laws.
- [x] Consolidated regressions cover reversed composition, invalid transport
  premise, incompatible products, quotient collapse/improper descent, reverse
  assumption non-implications, and empty tensor cancellation.
- [x] Claims distinguish non-implication from pairwise independence and exact
  compatibility from off-domain behavior.
- [x] Focused, adjacent, full-build, scan, axiom, documentation, whitespace,
  and independent-review gates pass.

## Stage Results

- `Models.Trivial` uses custom singleton state/transformation values over
  `Finset (Fin 2)`, avoiding leaked `Unit` instances while retaining a
  nontrivial four-element Boolean system algebra. It constructs projectors,
  their surjectivity, a compatibility-indexed state product, transformation
  product, locality, phenomenalization, a full local-realistic theory, and its
  forward no-signalling image.
- The stable model separately proves existential invertibility, raw
  transformation separation, contextual phenomenal faithfulness, and global
  transitivity. `generalRawTheory` and `generalQuotientTheory` consume the two
  general reverse results, and only the raw output receives the checked
  `generalRaw_forward_sameOperationalData` theorem.
- `Models.Examples` imports exactly `RR2021.API`. It consumes the concrete full
  model, forward output, raw and quotient reverse outputs, derived product
  laws, ordinary faithful-action inference, and operational-data preservation
  without any internal import or explicit instance argument.
- `Models.Audit` consolidates the earlier machine checks:
  - noncommuting permutations reject reversed action order;
  - distinct finite system indices lack the equality required by `reindex`;
  - distinct identity-projector states are not compatible, so no off-domain
    product is evaluated;
  - one valid no-signalling theory separately refutes invertibility,
    phenomenal faithfulness, and global transitivity;
  - raw natural representatives are distinct and collapse in both Appendix-A
    and Appendix-B quotients;
  - `rawValueCannotDescend` proves a raw-value recovery function on the
    noumenal quotient impossible solely by `congrArg` on quotient equality;
  - empty left and right tensor factors refute identity-tensor injectivity.
- The Bool/Nat boundary model establishes three non-implications from base
  no-signalling, not pairwise independence. The generic quotient descent
  regression does not settle Appendix A separation preservation: `RR-C013`
  remains open/unsupported, with no countermodel claimed.
- Three independent reviews found no model-field, partiality, mathematical,
  typeclass, import, or claim-scope defect. Their one concrete coverage request
  was discharged by exporting/checking both quotient-collapse equalities in
  the consolidated audit.

## Exact Verification Evidence

Focused stable model:

```text
$ cd formal && lake build RR2021.Models.Trivial
Build completed successfully (692 jobs).
```

Root-only consumer and consolidated diagnostic audit:

```text
$ cd formal && lake build RR2021.Models.Examples RR2021.Models.Audit
Build completed successfully (2417 jobs).
```

Adjacent public consumers:

```text
$ cd formal && lake build RR2021.Models.API RR2021.API RR2021
Build completed successfully (2411 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (2411 jobs).
```

The stable model/reverse audit reports only `[propext, Classical.choice,
Quot.sound]`; the representative-sensitive non-descent theorem uses
`[propext, Quot.sound]`. Static scans find no proof hole, project axiom,
`opaque`, `unsafe`, explicit choice, quotient representative extraction, or
default fallback in Models or the new descent theorem. Models API excludes
Examples/Audit; Trivial excludes prior Examples, Quantum, and root API. The
documentation checker, `git diff --check`, consumer regressions, and scoped
reviews pass.

All stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
