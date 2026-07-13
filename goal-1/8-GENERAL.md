# 8-GENERAL

Status: complete

## Current Facts

- Section 5.1 enlarges each Stage 7 fundamental state with a global
  phenomenal-state label. Projection and action preserve the label; a product
  is defined only when both labels agree and the fundamental components are
  compatible.
- The enlarged construction still requires existential invertibility to form
  the fundamental setoid and raw transformation separation for Theorem 5.8 / 
  the compatibility-indexed product. Its purpose is only to remove global
  transitivity.
- The new phenomenalization is state-dependent:
  `ϕ_A(N_A,ρ)=φ^A_ρ(N_A)`. The source/PDF instead writes the raw
  representative `W` as the argument of `φ`, the `RR-C010` type error. The
  corrected class-valued definition is required for representative
  independence.
- Compatibility of enlarged pair states must be proved equivalent to equality
  of their labels plus compatibility of their fundamental components. This is
  a theorem, not an extra premise silently embedded in the product.
- The enlarged product can reuse Stage 7's already-defined honest partial
  product. It therefore needs no second choice operation and has no
  incompatible-input branch.
- Surjectivity no longer needs transitivity: lift any target phenomenal state
  to a global label through projector surjectivity and pair that label with
  the identity fundamental class (Theorem 5.16).

## Big Picture Objective

Verify every omitted Section 5.1 descent/coherence law and construct a
local-realistic core without global transitivity, then expose both the
source-faithful wrapper under phenomenal faithfulness and the repaired
Appendix-B wrapper without it.

## Initial Implementation Plan

1. Define the enlarged state family, action, and projectors as label-preserving
   lifts of the completed Stage 7 data; prove all computation, nesting, and
   surjectivity laws.
2. Prove the exact compatibility characterization for pair states. Define the
   enlarged state product from the fundamental product and prove Theorem 5.15
   reconstruction without new choice.
3. Lift Stage 7 locality componentwise, proving compatibility preservation and
   the full action/product equation with inert labels.
4. Define corrected `ϕ_A(N_A,ρ)=φ^A_ρ(N_A)`; prove equivariance, projector
   compatibility, and Theorem 5.16 surjectivity without transitivity.
5. Assemble the pre-faithful core from only no-signalling, invertibility, and
   raw transformation separation. Add raw-transform effectivity only from
   contextual phenomenal faithfulness, or apply Appendix B for the repaired
   `RR-C017` result.
6. Add public API, consumer examples, axiom/choice/import audits, source
   realization updates, and final verification evidence.

## No-Cheating Checks

- No declaration or constructor may accept `GloballyTransitive`.
- The global label must be preserved definitionally by projection and action,
  and compatibility must force the two input labels equal.
- The product must reuse Stage 7's compatibility-only operation; it may not
  totalize incompatible labels or introduce another `Classical.choose`.
- The phenomenal map must consume a fundamental quotient state, not a raw
  global representative (`RR-C010`).
- Prove every “easy to verify” Section 5.1 field separately, including
  equivariance, projector compatibility, locality, and consumer instance
  inference (`RR-C011`).
- Keep the original-transformation and Appendix-B outputs separate and do not
  claim removal of transformation separation.

## Build Structure

- `formal/RR2021/Reverse/General/State.lean`: enlarged pair family, inferable
  label-preserving action, projectors, nesting, and surjectivity.
- `formal/RR2021/Reverse/General/Product.lean`: exact pair compatibility,
  enlarged product, and Theorem 5.15 reconstruction.
- `formal/RR2021/Reverse/General/Locality.lean`: compatibility preservation and
  lifted locality.
- `formal/RR2021/Reverse/General/Phenomenalization.lean`: corrected map,
  equivariance, projector compatibility, and Theorem 5.16.
- `formal/RR2021/Reverse/General/Construction.lean`: pre-faithful core and the
  two full-theory wrappers.
- `formal/RR2021/Reverse/General/API.lean`: thin stable re-export.
- `formal/RR2021/Reverse/General/Examples.lean` and `Audit.lean`: stable
  consumer and diagnostic leaves.
- `formal/RR2021/Reverse/API.lean`: re-exports both completed reverse layers.
- Focused state/product/locality build:
  `cd formal && lake build RR2021.Reverse.General.State RR2021.Reverse.General.Product RR2021.Reverse.General.Locality`.
- Map/constructor/example build:
  `cd formal && lake build RR2021.Reverse.General.Phenomenalization RR2021.Reverse.General.Construction RR2021.Reverse.General.Examples`.
- Adjacent consumers:
  `cd formal && lake build RR2021.Reverse.General.API RR2021.Reverse.General.Audit RR2021.Reverse.API RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## Completion Requirements

- [x] Enlarged actions/projectors and their laws compile without transitivity.
- [x] Enlarged compatibility is characterized exactly and the honest product
  proves Theorem 5.15 with no new choice/default.
- [x] Locality and corrected phenomenalization descend with every
  representative/coherence obligation explicit.
- [x] Theorem 5.16 surjectivity consumes only input projector surjectivity.
- [x] Constructors expose exact raw-transformation and Appendix-B assumption
  packages, neither containing global transitivity.
- [x] Focused, adjacent, full-build, scan, axiom, documentation, whitespace,
  and scoped-review gates pass.

## Stage Results

- `EnlargedNoumenalState` is the source pair of a fundamental quotient state
  and a global phenomenal-state label. Its inferable action and projectors
  operate only on the fundamental component; computation, action, nesting,
  and projector-surjectivity laws prove that the label is preserved.
- `compatible_iff_label_eq_and_fundamental_compatible` proves the exact
  enlarged compatibility domain. `stateProduct` reuses Stage 7's honest
  partial product, makes no new selection, and has no incompatible-input
  value. `representedCompatibility` and `stateProduct_ofRepresentative`
  state Theorem 5.15 directly on a shared representative and label.
- `locality` lifts the Stage 7 componentwise action/product equation and its
  compatibility-preservation obligation while leaving the common label
  inert.
- `phenomenalization` implements the corrected `RR-C010` equation by applying
  the descended class-valued map at the stored label. Its equivariance and
  projection compatibility are explicit. `phenomenalization_surjective`
  proves Theorem 5.16 from phenomenal-projector surjectivity and the identity
  fundamental class, with no global-transitivity premise.
- `core` requires exactly the input no-signalling theory, existential
  invertibility, and raw transformation separation. `theory` additionally
  uses contextual phenomenal faithfulness to retain the original
  transformation family. `faithfulQuotient` instead applies Appendix B to the
  completed core, requires neither phenomenal faithfulness nor global
  transitivity, and deliberately changes the transformation family.
- Stable API consumer checks exercise inferred actions and ordinary theory
  laws for both full outputs. Three independent reviews found no mathematical,
  source-coverage, assumption-boundary, typeclass, or import-layer defect; the
  one source-surface suggestion from review was discharged by adding the
  direct Theorem 5.15 declaration before final verification.

## Exact Verification Evidence

Focused state, product, and locality:

```text
$ cd formal && lake build RR2021.Reverse.General.State RR2021.Reverse.General.Product RR2021.Reverse.General.Locality
Build completed successfully (396 jobs).
```

Phenomenalization, constructors, and stable consumer:

```text
$ cd formal && lake build RR2021.Reverse.General.Phenomenalization RR2021.Reverse.General.Construction RR2021.Reverse.General.Examples
Build completed successfully (475 jobs).
```

Adjacent public and audit consumers:

```text
$ cd formal && lake build RR2021.Reverse.General.API RR2021.Reverse.General.Audit RR2021.Reverse.API RR2021.API RR2021
Build completed successfully (491 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (490 jobs).
```

The audit reports `[propext, Classical.choice, Quot.sound]`, exactly the
inherited Boolean/quotient footprint from Stage 7. Static scans find no
`GloballyTransitive` dependency, explicit choice/default, quotient
representative extraction, proof hole, project axiom, `opaque`, or `unsafe`
declaration in the General layer. The documentation checker,
`git diff --check`, stable consumer probes, and scoped reviews pass.

Stages 9--11 subsequently completed the exact theorem family, finite
Appendix-C repair, and consolidated model suite. All stages are now complete;
final release evidence is recorded in `goal-1/12-RELEASE.md`.
