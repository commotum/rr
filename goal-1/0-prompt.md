# Goal 1 Continuation Prompt

```text
Work autonomously through `goal-1/0-plan.md` using the repeatable protocol and stage template in `goal-1/0-loop.md`, and follow the repository-root `BUILD-PLAN.md` as the required Lean module-organization and incremental-build policy with `GOAL_DIR` set to `goal-1`.

The objective is to build a pinned, compiling Lean 4/mathlib library that independently reconstructs and verifies the mathematical content of Raymond-Robichaud's “The Equivalence of Local-Realistic and No-Signalling Theories,” using the local source corpus in `raymond-robichaud-2021/`. Prioritize reusable abstractions, prove the local-realistic-to-no-signalling direction and the precisely qualified reverse model constructions, verify all quotient and partial-operation well-definedness, and maintain complete traceability and a correction log.

Treat the paper as fallible. Do not invent proofs, add unjustified axioms, silently alter claims, totalize genuinely partial products, hide missing coherence behind casts or representative choice, encode philosophical conclusions as mathematics, or describe the result as an unconditional equivalence. Keep the abstract theorem separate from the optional finite-dimensional quantum instance. Completed modules must contain no `sorry`, `admit`, or unexplained project-specific axioms, and principal exported results require build and axiom-audit evidence.

At each iteration: inspect actual files, source, tests, and diffs; update `goal-1/0-plan.md` with current facts; select the first incomplete stage; create or refresh its stage file from `goal-1/0-loop.md`; implement only that stage; add no-cheating and mathematical checks; run focused and full verification; record exact results; fold discoveries back into the plan; and continue. When a claim fails, isolate the exact obligation, prove the strongest useful corrected result, document the defect and downstream consequences, and distinguish unresolved mathematics from missing Lean infrastructure.

Do not stop after planning. Continue stage by stage as far as the environment permits. Completion means the original objective is genuinely achieved; any open issue must remain explicit, evidenced next work rather than being hidden inside a completion claim. Finish with the requested report on formalized content, public signatures and organization, actual assumptions, corrections, exclusions, unresolved claims, quantum status, build/axiom audits, and extension guidance.
```
