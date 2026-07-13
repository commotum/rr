# 12-RELEASE

Status: complete

## Current Facts

- Stages 1--11 are complete. The root stable API imports Systems, Dynamics,
  Theories, Forward, both Faithfulness quotients, both Reverse constructions,
  Correspondence, the proved Quantum subset, and the stable Models fixture.
- The pinned environment is Lean `4.31.0` and mathlib commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`; the manifest records the full
  resolved graph.
- The source ledger contains 149 stable entries plus append-only checked
  realization tables for Stages 2--11. Initial-disposition rows are historical
  audit inputs; later realization rows provide the current proof status.
- Twenty correction/obligation entries distinguish conversion defects, source
  typos, repaired statements, proof gaps, and claim-scope corrections.
- The strongest verified general reverse result still requires raw
  transformation separation and existential invertibility. It removes global
  transitivity through the enlarged-state construction and phenomenal
  faithfulness by changing transformations through Appendix B; the
  raw-transformation result additionally needs contextual phenomenal
  faithfulness.
- The finite complex Appendix-C factor theorem is proved, but no density/
  partial-trace quantum `NoSignallingTheory` instance exists. Appendix A raw
  separation preservation remains open/unsupported absent the stronger modulo
  premise or a countermodel.

## Big Picture Objective

Deliver a reproducible final library and report in which every public claim,
assumption, correction, exclusion, deferral, import path, and audit statement
is reconciled with compiled Lean declarations.

## Detailed Implementation Plan

1. Refresh the root README with final status, pinned commands, public module
   map, main signatures, assumptions, conventions, extension guidance, and
   links to detailed evidence.
2. Write a comprehensive final report covering formalized content, exact
   theorem family, source corrections, philosophical exclusions, unresolved
   mathematics, quantum status, models/countermodels, axiom footprints, and
   reproducibility.
3. Reconcile stale historical wording in architecture, correction, and
   realization documents without rewriting the ledger's explicitly historical
   initial-disposition table.
4. Run final targeted consumers/audits, root/full builds, documentation and
   whitespace checks, import/no-cheating scans, status/link checks, and a
   clean-equivalent pinned-environment verification.
5. Complete the plan/status tables and independently review every final-report
   claim against actual signatures and evidence.

## Build Structure

- No new mathematical module is planned. Release edits are documentation and
  diagnostics only unless an audit exposes a real defect.
- Root stable build: `cd formal && lake build RR2021.API RR2021`.
- Principal audits/consumers:
  `cd formal && lake build RR2021.Correspondence.Audit RR2021.Quantum.Audit RR2021.Models.Examples RR2021.Models.Audit`.
- Full default verification: `cd formal && lake build`.
- Documentation: `python3 scripts/check_stage1_docs.py` and release link/status
  scans from the repository root.

## No-Cheating Checks

- Scan every project Lean source, not only the final-stage files, for proof
  holes, project axioms, unsafe/opaque declarations, explicit representative
  extraction, hidden defaults, and unexplained choice.
- Classify the sole explicit data choice in Stage 7 separately from inherited
  foundation footprints.
- Verify APIs exclude Examples/Audit leaves and earlier abstract layers do not
  import Quantum or Models.
- Do not convert a deferred quantum instance, unsupported Appendix-A
  preservation sentence, philosophical exclusion, or source adequacy claim
  into a completed result through summary wording.

## Completion Requirements

- [x] Root README and final report cover organization, signatures,
  assumptions, corrections, exclusions, unresolved claims, quantum status,
  verification, and extension guidance.
- [x] Traceability/correction/architecture/status documents agree with all
  completed stages while preserving explicitly historical initial statuses.
- [x] Principal targeted builds, root build, full build, documentation,
  whitespace, import, no-cheating, and axiom gates pass.
- [x] Pinned environment and clean-equivalent reproducibility are verified and
  documented.
- [x] Independent release reviews find no unsupported final claim or untracked
  in-scope obligation.

## Stage Results

### Final public surface and documentation

- `README.md` now gives the qualified theorem family, exact pins, public module
  map, design conventions, extension guidance, and the two principal open
  boundaries without claiming an unconditional equivalence.
- `goal-1/final-report.md` records all eight public correspondence declarations,
  both raw operational-preservation theorems, exact assumptions, corrections,
  exclusions, quantum scope, model regressions, axiom/choice footprint, and
  reproducibility commands.
- The architecture, correction log, source ledger, master plan, and eleven
  earlier stage tails were reconciled with the realized modules and final
  statuses. Historical initial-disposition rows remain explicitly historical.
- Every one of the 149 ledger entries has a checked realization or explicit
  exclusion/deferral boundary. The correction log retains `RR-C013` as open
  and `RR-C018` as partial rather than converting either into a theorem.
- Two independent documentation/claim reviews and one independent static-code
  review found no unsupported theorem signature or unclassified in-scope
  claim. Their wording hardening and stale-path findings were incorporated.

### Pinned and clean-state verification

```text
$ lake env lean --version
Lean (version 4.31.0, x86_64-apple-darwin24.6.0,
  commit 68218e876d2a38b1985b8590fff244a83c321783, Release)

$ lake --version
Lake version 5.0.0-src+68218e8 (Lean version 4.31.0)

$ git -C .lake/packages/mathlib rev-parse HEAD
fabf563a7c95a166b8d7b6efca11c8b4dc9d911f

$ git -C .lake/packages/mathlib status --short
# exit 0, no output
```

`lake clean` removed all generated project artifacts, including the orphaned
deleted dependency probe. The first clean-state `lake build` encountered a
transient missing `Mathlib/Data/Ineq.olean` even though Lake had previously
reported that dependency built. The recovery remained inside the clean state:

```text
$ lake build Mathlib.Data.Ineq
Build completed successfully (5 jobs).

$ lake build
Build completed successfully (2411 jobs).

$ lake build RR2021.API RR2021
Build completed successfully (2411 jobs).
```

No pre-clean project artifact was restored or reused.

### Complete diagnostics and consumers

The release built every audit module, not only the principal leaves:

```text
$ lake build RR2021.Survey.Audit RR2021.Systems.Audit \
    RR2021.Dynamics.Audit RR2021.Theories.Audit RR2021.Forward.Audit \
    RR2021.Faithfulness.PhenomenalAudit \
    RR2021.Faithfulness.NoumenalAudit RR2021.Faithfulness.Audit \
    RR2021.Reverse.Transitive.Audit RR2021.Reverse.General.Audit \
    RR2021.Correspondence.Audit RR2021.Quantum.Audit RR2021.Models.Audit
Build completed successfully (2432 jobs).
```

It also built all ten example modules:

```text
$ lake build RR2021.Systems.Examples RR2021.Dynamics.Examples \
    RR2021.Theories.Examples RR2021.Forward.Examples \
    RR2021.Faithfulness.Examples RR2021.Reverse.Transitive.Examples \
    RR2021.Reverse.General.Examples RR2021.Correspondence.Examples \
    RR2021.Quantum.Examples RR2021.Models.Examples
Build completed successfully (2419 jobs).
```

The audit output confirms the expected foundation footprint
`[propext, Classical.choice, Quot.sound]`, or a subset, and no project axiom.

### Static, documentation, and worktree gates

- The final tree contains 87 Lean sources (86 under `formal/RR2021/` plus the
  thin root) and 545 top-level declarations.
- Semantic source review found no `sorry`, tactic `admit`, project declaration
  `axiom`, `opaque`, `unsafe`, representative extraction, hidden default, or
  totalized incompatible product. Two raw scan hits for “axiom” are English
  comments. The only explicit data choice is the documented
  `Classical.choose` after `compatible_uniqueCommonExtension : ∃!`, with its
  two `choose_spec` facts.
- No stable API imports an Audit/Examples module. Abstract layers through
  Correspondence import neither Quantum nor Models; `RR2021.lean` imports only
  `RR2021.API`.
- The local Markdown-link checker reports that every link resolves. The source
  documentation checker passes with 88 distinct numbered declarations; all
  149 ledger entries have a final classification.
- `git diff --check` exits with no output. `git status --short`, the scoped
  tracked diff, and `git ls-files --others --exclude-standard` were reviewed:
  every change is a planned Goal-1 source, build pin, diagnostic, report, or
  ignore entry, and generated `.lake` content remains ignored.
