# 10-QUANTUM

Status: complete

## Current Facts

- Section 4.2 supplies only a dictionary: density operators, unitary
  conjugation, partial trace, and tensor product. It delegates the full
  no-signalling instance to external reference [18].
- Appendix C's proof of transformation separation is not valid as stated for
  arbitrary Hilbert spaces. Its product-of-endomorphism-bases step needs
  finite-dimensional algebraic tensor identifications (`RR-C015`).
- The final printed sentence names an undefined `V^C`; the intended operator
  is `V^B`. Even after that typo is fixed, unitarity of the middle factor must
  be reflected through a nonzero identity tensor factor (`RR-C016`).
- The phase-equivalence assertion in Section 4.2 is not proved for the source's
  contextual equivalence relation and does not repair Appendix A separation
  preservation (`RR-C018`).
- Pinned mathlib has finite matrix Kronecker products, associativity/reindexing,
  conjugate transpose, unitary matrix groups, Kronecker preservation of
  unitarity, and finite matrix-algebra tensor equivalences. A complete density
  operator/partial-trace indexed theory is a distinct, substantially larger
  construction.

## Updated Assumptions

- Use explicitly finite coordinate spaces over `ℂ` for the corrected Appendix
  C theorem. Require finite index types, decidable equality, and nonempty outer
  factors where an identity-tensor component must be inspected.
- State the overlap equation entrywise on `A × B × C`; this makes the
  associativity reindex between `(A × B) × C` and `A × (B × C)` explicit
  without pretending the two matrix types are definitionally equal.
- Treat the full unitary quantum no-signalling theory, the phase theorem, and
  pure-state transitivity as separate obligations. Do not instantiate the
  abstract `NoSignallingTheory` until density-state closure, partial trace,
  tensor-product laws, and every reverse postulate have independent proofs.

## Big Picture Objective

Repair and verify the finite-dimensional algebraic core of Appendix C, map the
remaining Section 4.2 claims to exact missing infrastructure, and classify the
full quantum instance honestly without importing any quantum claim as an
axiom.

## Detailed Implementation Plan

1. Define the explicit finite-matrix overlap equation corresponding to
   `V_AB ⊗ I_C = I_A ⊗ V_BC` with the associativity index visible.
2. Prove a common-middle-factor theorem from nonempty outer indices, avoiding
   the source's invalid arbitrary-Hilbert-space basis argument.
3. Prove that unitarity of `V_B ⊗ I_C` reflects to `V_B` for a nonempty finite
   `C`, then combine it with factorization to prove corrected Theorem C.1 over
   finite complex matrices.
4. Add finite concrete consumers and an audit leaf for signatures, axioms, and
   the exact mathlib boundary. Record the full no-signalling instance, phase
   characterization, and pure-state transitivity as explicit deferrals if they
   remain unimplemented.
5. Update the source ledger, `RR-C015`/`RR-C016`/`RR-C018`, plan, and release
   inputs with item-by-item statuses and downstream limits.

## Build Structure

- `formal/RR2021/Quantum/FiniteMatrix.lean`: finite complex matrix overlap,
  factorization, unitarity reflection, and corrected Theorem C.1.
- `formal/RR2021/Quantum/Phase.lean`: exact operator-algebra conjugation/phase
  theorem, explicitly separated from contextual density-state equivalence.
- `formal/RR2021/Quantum/API.lean`: thin stable re-export of proved quantum
  mathematics only.
- `formal/RR2021/Quantum/Examples.lean`: concrete finite-index consumers.
- `formal/RR2021/Quantum/Audit.lean`: signatures, axioms, and deferral boundary.
- `formal/RR2021/API.lean`: re-export the completed proved quantum subset.
- Focused build: `cd formal && lake build RR2021.Quantum.FiniteMatrix`.
- Consumer/audit build:
  `cd formal && lake build RR2021.Quantum.Examples RR2021.Quantum.Audit`.
- Adjacent public build:
  `cd formal && lake build RR2021.Quantum.API RR2021.API RR2021`.
- Full verification: `cd formal && lake build`.

## No-Cheating Checks

- No infinite-dimensional theorem may be inferred from a finite matrix result.
- No basis-product surjectivity is assumed; the proof must work directly from
  matrix entries or a checked finite-dimensional equivalence.
- Nonemptiness used for tensor cancellation must be a visible premise, not an
  arbitrary default index.
- The middle factor's unitarity must be proved, not added to the existential
  conclusion as an assumption.
- No project axiom may stand in for density operators, partial trace, phase
  equivalence, pure-state transitivity, or the full quantum theory structure.

## Boundary Checks

- The abstract Stages 2--9 must remain independent of `RR2021.Quantum`.
- The stable quantum API exports only compiled finite results, not audit
  propositions masquerading as a full instance.
- The phase quotient is not composed with the reverse constructor unless the
  conditional separation premise required by `RR-C013` is separately proved.
- “Quantum theory is an instance” remains split unless all `NoSignallingTheory`
  fields and the intended reverse-postulate package compile.

## Completion Requirements

- [x] `RR-C015` is repaired by a finite complex matrix theorem with explicit
  index/nonempty hypotheses.
- [x] `RR-C016`'s middle factor is correctly named and its unitarity is derived
  through a proved tensor-reflection lemma.
- [x] Section 4.2 and Appendix C receive item-by-item proved/assumed/deferred
  statuses, including `RR-C018`.
- [x] Examples and audits compile through a thin API without constructing an
  unsupported full quantum no-signalling theory.
- [x] Focused, adjacent, full-build, scan, axiom, documentation, whitespace,
  and independent-review gates pass.

## Stage Results

- `finiteMatrixTensorEquiv` records the finite complex matrix-space tensor
  equivalence omitted by the unrestricted Appendix-C basis argument, and
  `finiteMatrixTensorEquiv_tmul` proves its simple tensors are Kronecker
  products. This is a finite replacement, not a verbatim arbitrary-Hilbert-
  space product-basis theorem.
- `OverlappingExtensionsAgree` states the triple-system equality entrywise on
  six indices, making the `(A×B)×C` versus `A×(B×C)` association explicit.
  `commonMiddleFactorAt` and `commonMiddleFactor` construct `VB` directly from
  diagonal slices and prove both exact factorizations from visible nonempty
  outer factors.
- `kroneckerOneRight_injective` isolates the missing tensor-cancellation step.
  `mem_unitary_of_kronecker_one` reflects both `star U * U = 1` and
  `U * star U = 1`. `commonMiddleUnitaryFactor` therefore proves corrected
  Theorem C.1 with the intended `VB`; it needs only the source's `VBC`
  unitarity, so the unused `VAB`-unitarity premise is minimized away.
- `conjugation_eq_iff_unitaryPhase` checks the exact phase ambiguity for
  conjugation on the full continuous-operator algebra of a complex Hilbert
  space. It does not prove Definition 4.1's contextual relation on density
  states and separated extensions and is not composed with Appendix A.
- The source-status boundary is:
  - `RR-AC-D01`, `RR-AC-U02`, and `RR-C015`: finite matrix tensor-equivalence
    replacement proved; unrestricted infinite-dimensional basis claim not
    claimed;
  - `RR-AC-T01` and `RR-C016`: corrected finite complex factorization and
    middle-unitary reflection proved;
  - `RR-S4-U05` and `RR-C018`: operator-algebra phase theorem proved nearby,
    contextual density-state characterization and phase-quotient separation
    deferred;
  - `RR-S4-U04`, `RR-S4-U06`, and the abstract/introduction quantum clauses:
    full density/partial-trace no-signalling instance and pure-state
    transitivity deferred.
- The deferral is infrastructural and mathematical, not an admitted axiom.
  Pinned mathlib has no density-operator or partial-trace abstraction, and the
  source supplies no coherent Boolean-system family of finite Hilbert factors.
  Required future work includes density closure/nonemptiness, partial-trace
  nesting/surjectivity/no-signalling, tensor associator/commutor coherence, the
  contextual phase converse, quotient separation, and a pure-state/ray
  transitivity carrier.
- Unit identity matrices exercise corrected C.1. Empty-left and empty-right
  regressions prove why both outer nonempty premises matter. Three independent
  reviews found no mathematical, source-scope, API, import, or no-cheating
  defect.

## Exact Verification Evidence

Focused finite Appendix-C build:

```text
$ cd formal && lake build RR2021.Quantum.FiniteMatrix
Build completed successfully (1686 jobs).
```

Phase theorem, consumers, and audit:

```text
$ cd formal && lake build RR2021.Quantum.Phase RR2021.Quantum.Examples RR2021.Quantum.Audit
Build completed successfully (2356 jobs).
```

Adjacent public consumers:

```text
$ cd formal && lake build RR2021.Quantum.API RR2021.API RR2021
Build completed successfully (2409 jobs).
```

Full default build:

```text
$ cd formal && lake build
Build completed successfully (2409 jobs).
```

The audit reports only `[propext, Classical.choice, Quot.sound]`, the standard
mathlib foundation footprint. Static scans find no proof hole, project axiom,
`opaque`, `unsafe`, explicit choice/default coordinate, or quotient extraction
in Quantum. No Stage 2--9 module imports Quantum; the thin Quantum API imports
neither Examples nor Audit; and no quantum `NoSignallingTheory` declaration is
present. The documentation checker, `git diff --check`, consumer regressions,
and scoped reviews pass.

Stage 11 subsequently completed the consolidated model and boundary suite. All
stages are now complete; final release evidence is recorded in
`goal-1/12-RELEASE.md`.
