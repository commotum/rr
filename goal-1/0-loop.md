# Goal 1 Execution Loop

Use this protocol for every stage in `goal-1/0-plan.md`. The plan is authoritative but revisable when the source, Lean, mathlib, proofs, examples, or counterexamples establish new facts. Apply the repository-root `BUILD-PLAN.md` throughout, with `GOAL_DIR` specialized to `goal-1`; this loop adds project-specific mathematical checks to that generic Lean build policy.

## Repeatable Loop

1. Sync current state with actual files and tests. Read `BUILD-PLAN.md`, the relevant source passages, current Lean declarations, stage records, traceability ledger, correction log, build configuration, and recent diff. Do not rely on conversational memory.
2. Update `goal-1/0-plan.md` with current facts before starting the next stage. Clearly distinguish proved facts, observed API behavior, hypotheses, and speculation.
3. Select the first incomplete stage. If it is too broad for one coherent implementation pass, divide its work inside the stage file without weakening its completion requirements.
4. Create or refresh `goal-1/[INDEX]-[SHORTHAND].md` from the stage template below. Preserve prior evidence when refreshing it.
5. Implement only that stage. Keep the project compiling in small increments and avoid importing later-layer assumptions into earlier abstractions.
6. Add verification and no-cheating checks. In this project that includes representative-independence obligations, compatibility-domain honesty, assumption visibility, source traceability, and checks against circular proof dependencies.
7. Run focused tests, full verification, and whitespace/diff checks appropriate to the repo. At minimum run the relevant focused Lean files, `lake build`, forbidden-placeholder scans, axiom checks for new principal results, `git diff --check`, and a scoped diff review.
8. Record results in the stage file, including exact commands, outcomes, declarations added, source issues found, failed approaches, remaining uncertainty, and audit output.
9. Fold results back into `goal-1/0-plan.md`. Update current facts, assumptions, stage status, dependencies, corrections, and later completion requirements before proceeding.
10. Continue toward the original objective. If stopping for the session, leave the goal resumable with current evidence, the first incomplete obligation, next experiments, unblock actions, and assumptions to challenge.

## Invariants

- Do not narrow the user's objective without saying so.
- Do not mark a stage complete without evidence.
- Do not use tests or green checks as evidence unless they cover the requirement.
- Prefer small, low-complexity stages that narrow uncertainty.
- Convert blockers into work items: decompose them, route around them, or turn them into proof and verification tasks.
- Preserve the distinction between implementation, verifier, diagnostic, and fallback paths.
- Treat the paper as a source of claims to audit, not an oracle or a formal specification.
- Keep axioms, postulates, definitions, derived theorems, implementation conveniences, and interpretations visibly distinct.
- Never silently strengthen or weaken a theorem. When repair is needed, preserve the original in the correction log and state downstream consequences.
- Never mark quotient work complete until every operation used later has a proved congruence or representative-independence theorem.
- Never make a partial product total unless off-domain values are formally sealed off from every theorem and clearly documented.
- Keep abstract infrastructure independent of the quantum layer.
- A Lean elaboration success is not by itself mathematical verification; check that types express the intended systems, action direction, compatibility, and correspondence.
- An unresolved claim is acceptable evidence only when the exact obligation, attempted repairs, and strongest nearby proved result are recorded. It is not a completed theorem.

## Standard Verification Checklist

- Read the exact paper passage and its dependencies; compare the Markdown conversion with the PDF when notation or diagrams are ambiguous.
- Compile the smallest affected module, then run `lake build`.
- Inspect the public signature with `#check`/`#print`; inspect foundations of principal results with `#print axioms` or the project audit command.
- Search completed Lean sources for `sorry`, `admit`, project `axiom`, suspicious `opaque`, and temporary placeholders; classify any legitimate occurrence.
- For quotients, locate the equivalence proof and each descent proof for composition, actions, projections, products, and maps.
- For products, verify the compatibility witness is present and used and that no arbitrary off-domain value leaks into results.
- For indexed equalities, test associativity/commutativity transports on concrete terms rather than assuming simplification coherence.
- Update the traceability ledger and correction log in the same stage as the corresponding code.
- Run `git diff --check`, inspect `git status --short`, and review the scoped diff without modifying unrelated user work.

## Stage File Template

```markdown
# [INDEX]-[SHORTHAND]

## Current Facts

- Facts from current code, tests, docs, and previous stage results.

## Updated Assumptions

- Assumptions that still look valid.
- Assumptions that changed.
- Assumptions that need tests before being trusted.

## Big Picture Objective

- Restate the stage objective, adjusted for current facts.

## Detailed Implementation Plan

- Concrete code/doc/test changes for this stage.
- Files expected to change.
- New tests or commands required.

## Build Structure

- New or touched Lean modules and why each owns its declarations.
- High-fanout modules intentionally avoided.
- Focused build command.
- Adjacent consumer builds required.

## No-Cheating Checks

- Explicit checks proving the implementation does not route through forbidden fallback paths.

## Boundary Checks

- Runtime/API/proof-side boundaries relevant to this stage.
- Forbidden shortcuts and how they will be checked.

## Completion Requirements

- Requirement-by-requirement checks.
- Required test commands.
- Documentation updates required.

## Stage Results

- Fill in at the end of the stage.
- Include tests run and outcomes.
- Include what was learned.
- Include what should change in `0-plan.md` before the next stage.
```

## Session Handoff Minimum

Before any pause, record:

- last known passing build command and result;
- files and declarations changed;
- current source location and traceability status;
- first incomplete proof or design obligation, with its exact Lean goal when available;
- approaches attempted and why they failed;
- next one to three bounded actions;
- assumptions most likely to be false or overstrong;
- whether the blocker is mathematical, source ambiguity, Lean encoding, or missing library infrastructure.
