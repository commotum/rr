# 9-CORRESPONDENCE

Status: complete

## Current Facts

- The forward constructor needs only a full `LocalRealisticTheory` and retains
  its transformations, phenomenal states, phenomenal action, projectors, and
  separated transformation product.
- The general repaired reverse result is already assumption-minimal within the
  verified construction: no-signalling, existential invertibility, and raw
  transformation separation produce a full theory after Appendix B. Global
  transitivity and phenomenal faithfulness are absent, but the output
  transformation family is an action-kernel quotient.
- Retaining the original transformation family in the general reverse output
  additionally requires contextual phenomenal faithfulness. The transitive
  special case additionally takes a global reference state and global
  transitivity.
- Appendix A and Appendix B solve different faithfulness problems and both
  change transformations. Appendix A does not preserve raw transformation
  separation without the stronger modulo-equivalence premise `RR-C013`.
- No category, functor, model isomorphism, observation/probability semantics,
  or empirical-equivalence notion exists in the library. The completed
  constructors do not prove uniqueness or canonicity of reconstructed models.

## Updated Assumptions

- Keep every constructor premise as a visible argument; do not bundle a broad
  reverse-hypothesis package that could hide which outputs use faithfulness or
  global transitivity.
- Compare exact operational data only when both no-signalling theories share
  the same transformation and phenomenal-state families. For this fixed type,
  equality of phenomenal projectors and transformation products captures the
  remaining non-proof operational fields.
- Do not apply that comparison to either quotient output, whose transformation
  family differs by construction.
- Treat the explicit reference in the transitive result as a noncanonical
  construction parameter. Input state nonemptiness proves a reference exists,
  but selecting one in the public theorem would conceal that choice.

## Big Picture Objective

Expose the exact checked theorem family—forward, both reverse variants, and
both faithfulness quotients—under inspectable minimized hypotheses, and prove
only the operational preservation actually supported by the raw-transformation
reverse constructors.

## Detailed Implementation Plan

1. Add seven explicitly named correspondence constructors: forward, both
   faithfulness quotients, transitive reverse with raw or quotient
   transformations, and general reverse with raw or quotient transformations.
2. Define `SameOperationalData` for no-signalling theories over the same
   indexed transformations and phenomenal states. Prove that forwarding each
   raw-transformation reverse output has the same source projectors and
   transformation product.
3. Add stable API consumer examples for the major assumption packages and an
   audit leaf printing exact signatures and axiom footprints.
4. Update root APIs, traceability/correction documents, and the plan with the
   exact claim-status matrix. State explicitly why the results are neither a
   categorical equivalence nor a uniqueness/canonicity theorem.

## Build Structure

- `formal/RR2021/Correspondence/Theorems.lean`: public constructor aliases,
  the exact operational-data relation, and its two preservation theorems.
- `formal/RR2021/Correspondence/API.lean`: thin stable re-export.
- `formal/RR2021/Correspondence/Examples.lean`: downstream assumption and
  preservation consumers through the stable API.
- `formal/RR2021/Correspondence/Audit.lean`: signature and axiom diagnostics.
- `formal/RR2021/API.lean`: re-export the completed correspondence API.
- Focused build:
  `cd formal && lake build RR2021.Correspondence.Theorems`.
- Consumer/audit build:
  `cd formal && lake build RR2021.Correspondence.Examples RR2021.Correspondence.Audit`.
- Adjacent public build:
  `cd formal && lake build RR2021.Correspondence.API RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- No declaration named “equivalence,” “empirical equivalence,” “canonical,” or
  “unique model” may be introduced without a corresponding proved structure.
- The central general quotient result must visibly retain invertibility and raw
  separation and visibly return the quotient transformation family.
- The raw-family general result must visibly retain phenomenal faithfulness;
  the transitive results must visibly retain their reference/transitivity
  premises.
- Operational preservation may compare only fixed, common transformation and
  phenomenal-state families and must mention both projectors and the separated
  transformation product.
- The public import closure must not reach Quantum, Examples, or Audit leaves.

## Boundary Checks

- Forward remains independent of every reverse postulate.
- Appendix A separation is exposed only conditionally through
  `TransformationSeparationModuloPhenomenalEquivalence`.
- Appendix B is applied only after the reverse core consumes invertibility and
  separation; no postulate-preservation claim is made for its quotient.
- Pointwise uniqueness of Stage 7's compatible product value is not promoted
  to uniqueness or canonicity of a reconstructed theory.

## Completion Requirements

- [x] All seven constructor names elaborate with the exact audited premise and
  output families.
- [x] Both raw reverse/forward composites prove `SameOperationalData`.
- [x] Stable consumers distinguish raw and quotient transformation outputs and
  compile without hidden extra hypotheses.
- [x] Audit, focused, adjacent, full-build, import, scan, documentation,
  whitespace, and scoped-review gates pass.
- [x] The six high-level claim statuses and every caveat are folded into the
  source ledger, correction log, plan, and final-stage inputs.

## Stage Results

- `Correspondence.forward` names the full forward constructor with no reverse
  premises. `phenomenalFaithfulnessQuotient` and
  `noumenalFaithfulnessQuotient` expose Appendices A and B independently and
  make both changed transformation families visible in their result types.
- The two transitive reverse names distinguish retaining raw transformations
  under contextual phenomenal faithfulness from applying Appendix B without
  it. Both still expose the reference state and global-transitivity premise.
- The two general reverse names remove the reference and global transitivity.
  `generalReverseRetainingTransformations` needs contextual phenomenal
  faithfulness; `generalReverseWithFaithfulQuotient` is the weakest-premise
  full reverse constructor verified in this development and needs only
  existential invertibility plus raw transformation separation beyond the
  no-signalling source, but its transformation family is the Appendix-B
  quotient.
- `SameOperationalData` compares no-signalling theories already fixed over
  the same transformations, phenomenal states, indexed monoid, and phenomenal
  action. Its explicit fields are projector equality and separated
  transformation-product equality. Both raw reverse/forward composites prove
  this relation definitionally; no analogous theorem is stated for quotient
  outputs of a different type.
- The exact source-status matrix is now:
  1. forward construction — proved;
  2. qualified same-signature reverse construction — proved with invertibility,
     raw separation, and contextual phenomenal faithfulness;
  3. phenomenal-faithfulness quotient — proved, with raw separation preserved
     only from the stronger modulo premise;
  4. noumenal-faithfulness quotient — proved from any completed pre-faithful
     core;
  5. removal of global transitivity — proved by the general construction, with
     raw-versus-quotient transformation outputs kept separate;
  6. quantum application — Stage 10 subsequently proved the finite complex
     Appendix-C repair and nearby operator-algebra phase theorem; the full
     density/partial-trace `NoSignallingTheory` instance remains deferred.
- No model category, two-sided inverse, model isomorphism, uniqueness,
  canonicity, universal property, observational semantics, or empirical
  equivalence is defined or claimed. Pointwise uniqueness of Stage 7's product
  value is not promoted to any global uniqueness statement.
- Three independent reviews found no theorem, assumption-boundary, consumer,
  or import-layer defect. Their single wording concern was repaired: the
  general quotient result is described as the weakest-premise constructor
  proved here, not as logically minimal or a same-signature realization.

## Exact Verification Evidence

Focused theorem-family build:

```text
$ cd formal && lake build RR2021.Correspondence.Theorems
Build completed successfully (484 jobs).
```

Stable consumers and signature/axiom audit:

```text
$ cd formal && lake build RR2021.Correspondence.Examples RR2021.Correspondence.Audit
Build completed successfully (487 jobs).
```

Adjacent public consumers:

```text
$ cd formal && lake build RR2021.Correspondence.API RR2021.API RR2021
Build completed successfully (492 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (492 jobs).
```

The audit prints all exact signatures and reports only `[propext,
Classical.choice, Quot.sound]`, the established Boolean/quotient foundation.
Static scans find no proof hole, project axiom, `opaque`, `unsafe`, explicit
choice/default, or quotient representative extraction in Correspondence. The
stable API import closure has no Quantum, Examples, or Audit dependency. The
88-declaration documentation checker, `git diff --check`, stable consumers,
and scoped reviews pass.

Stages 10 and 11 subsequently completed the finite Appendix-C repair, scoped
phase audit, and consolidated model suite. All stages are now complete; final
release evidence is recorded in `goal-1/12-RELEASE.md`.
