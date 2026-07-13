# RR2021 Lean formalization

This repository is a pinned Lean 4/mathlib reconstruction and audit of Paul
Raymond-Robichaud's 2021 paper, *The Equivalence of Local-Realistic and
No-Signalling Theories*.

The formalization does **not** prove an unconditional equivalence. It proves a
family of separately named constructions with every assumption and any changed
transformation family visible in the Lean type.

## Main verified results

- Forward: every full `LocalRealisticTheory` yields a `NoSignallingTheory` on
  the same transformations and phenomenal states.
- General raw reverse: no-signalling + existential invertibility + raw
  transformation separation + contextual phenomenal faithfulness yields a
  full local-realistic theory retaining the input transformations.
- General quotient reverse: no-signalling + existential invertibility + raw
  transformation separation yields a full local-realistic theory over the
  Appendix-B action-kernel quotient transformations. It needs neither global
  transitivity nor phenomenal faithfulness.
- Transitive reverse: the corresponding explicit-reference construction is
  available with global transitivity, in raw- and quotient-transformation
  variants.
- Appendices A and B: Appendix A descends the phenomenal action and separated
  transformation product; Appendix B descends both actions, the transformation
  product, phenomenalization equivariance, and locality.
- Operational preservation: forwarding either raw-transformation reverse
  output preserves the source phenomenal projectors and separated
  transformation product. No same-signature theorem is asserted for quotient
  outputs.
- Quantum subset: a corrected finite complex matrix version of Appendix C's
  common-middle-unitary theorem is proved, together with the exact
  full-operator-algebra phase ambiguity. A complete density-operator/
  partial-trace quantum no-signalling instance is not claimed.

The public theorem-family names are in
[`Correspondence/Theorems.lean`](formal/RR2021/Correspondence/Theorems.lean).
The detailed claim matrix and caveats are in
[`goal-1/final-report.md`](goal-1/final-report.md).

## Pinned build

- Lean: `v4.31.0`
- mathlib: `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`

From a checkout with `elan` and Git installed:

```sh
cd formal
lake update
lake build
```

`formal/lean-toolchain` pins Lean, `formal/lakefile.lean` pins the direct
mathlib commit, and `formal/lake-manifest.json` records the complete dependency
graph. `lake exe cache get` is an optional build-speed optimization.

Useful release checks:

```sh
cd formal
lake build RR2021.API RR2021
lake build RR2021.Correspondence.Audit RR2021.Quantum.Audit RR2021.Models.Examples RR2021.Models.Audit
cd ..
python3 scripts/check_stage1_docs.py
git diff --check
```

## Public modules

Import the entire stable library with:

```lean
import RR2021.API
```

Or use a narrower layer:

| Import | Purpose |
|---|---|
| `RR2021.Systems.API` | Boolean system algebra and named dependent reindexing |
| `RR2021.Dynamics.API` | indexed actions/maps, projectors, honest partial products, locality |
| `RR2021.Theories.API` | phenomenal, no-signalling, pre-faithful, and full local-realistic structures |
| `RR2021.Forward.API` | state-level no-signalling theorem and forward constructor |
| `RR2021.Faithfulness.API` | Appendix-A and Appendix-B quotients |
| `RR2021.Reverse.API` | transitive and general reverse constructions |
| `RR2021.Correspondence.API` | exact public theorem family and operational preservation |
| `RR2021.Quantum.API` | proved finite Appendix-C and operator-algebra phase subset |
| `RR2021.Models.API` | stable finite trivial end-to-end model |

`Examples.lean` and `Audit.lean` files are diagnostic-only modules and are not
re-exported by stable APIs.

## Design conventions and extension points

- Systems are indexed by a mathlib `BooleanAlgebra`; cheap generic declarations
  expose weaker typeclass assumptions where possible.
- Transformations and both state families are system-indexed. Multiplication
  acts right-to-left through ordinary `MulAction` laws.
- State products accept explicit `Separated` and `Compatible` evidence. There
  is no incompatible-input fallback value.
- Quotients start from named equivalence/congruence theorems; representative-
  sensitive maps cannot silently descend.
- `LocalRealisticCore` deliberately omits noumenal action faithfulness;
  `LocalRealisticTheory` adds exactly that field.
- Reverse postulates—`InvertibleDynamics`, `TransformationSeparation`,
  `PhenomenallyFaithful`, and `GloballyTransitive`—are separate predicates, not
  hidden fields of `NoSignallingTheory`.

To add a new operational model, implement the narrow Systems/Dynamics APIs,
construct `NoSignallingTheory` or `LocalRealisticCore`, prove each extra reverse
predicate separately, and consume the desired constructor from
`RR2021.Correspondence.API`. Use `RR2021.Models.Trivial` as a small compiling
fixture, not as a shortcut for nontrivial model laws.

## Audit scope

The source inventory contains 149 stable entries and the correction log has 20
items. Initial-disposition rows in the ledger are historical; append-only stage
realization tables record checked declarations and evidence.

Philosophical, metaphysical, sociological, and empirical conclusions are not
encoded as mathematical theorems. The two main open boundaries are:

- unconditional preservation of raw transformation separation through the
  Appendix-A phenomenal quotient (`RR-C013`); and
- the full system-indexed quantum instance, including density operators,
  partial trace, contextual phase completeness, quotient separation, and
  pure-state transitivity.

See [`source-ledger.md`](goal-1/source-ledger.md),
[`corrections.md`](goal-1/corrections.md), and
[`12-RELEASE.md`](goal-1/12-RELEASE.md) for the complete evidence trail.
