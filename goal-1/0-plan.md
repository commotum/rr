# Goal 1: Formalize Raymond-Robichaud 2021 in Lean 4

Shorthand: `RR2021`

## Big-Picture Objective

Build a pinned, compiling Lean 4 and mathlib library that independently reconstructs the mathematical content of Paul Raymond-Robichaud's “The Equivalence of Local-Realistic and No-Signalling Theories.” The library must expose reusable abstractions for compositional operational theories, prove precisely scoped versions of the paper's valid claims, make every assumption visible, and document corrections, exclusions, and unresolved obligations.

The goal is not a line-by-line transcription and not a formal endorsement of the paper's philosophical conclusions. Completion means that the abstract theory and the two directions actually justified by the source have been checked in Lean, quotient and partial-operation obligations have been discharged explicitly, the resulting public API has been audited, and any remaining quantum application or source claim is classified honestly.

## Non-Negotiable Constraints and No-Cheating Rules

- Treat the paper as a fallible source, not a specification. Independently check every definition, axiom, construction, equivalence relation, quotient, action, projection, product, and proof dependency.
- Do not encode philosophical, metaphysical, interpretative, or empirical conclusions unless explicit mathematical assumptions and a precise proposition have first been stated.
- Do not claim an unqualified equivalence between local realism and no-signalling. State separately the forward construction, the reverse model-existence result, both faithfulness quotients, removal of global transitivity, and any quantum instance.
- Do not add an axiom merely to make a target theorem pass. Legitimate abstract hypotheses must be named, documented, minimized where feasible, and visible in exported theorem signatures.
- Completed modules may contain no `sorry`, `admit`, `by_contra!` used as a placeholder, or unexplained project-specific `axiom`/`opaque` declarations.
- Never use `Classical.choice`, quotient lifting, representative selection, casts, or proof irrelevance to hide a missing existence, compatibility, invariance, or well-definedness argument. Use such tools only when their mathematical premises have been proved and documented.
- Represent genuinely partial products honestly, for example by a compatibility-indexed domain or a proposition plus witness. Arbitrary off-domain values may not influence later results.
- Prove explicitly that every relation used for quotienting is an equivalence and that projections, actions, products, maps, and composition respect it.
- Keep dependent transports caused by equal system expressions explicit enough to audit. Add coherence lemmas rather than relying on brittle simplification accidents.
- Prefer mathlib structures only after confirming that their laws, composition orientation, and coercions match the mathematics.
- Keep the abstract theorem independent of the finite-dimensional quantum application. Do not begin substantial quantum infrastructure before the abstract construction is stable.
- Work incrementally and keep `lake build` passing at each completed stage.
- Treat the repository-root `BUILD-PLAN.md` as the required Lean build and module-organization policy for every implementation stage. Specialize its `GOAL_DIR` placeholders to `goal-1`, record focused and adjacent-consumer build commands in each stage file, and depart from its defaults only with documented evidence.
- Preserve traceability from source locations to Lean declarations and maintain a correction log with downstream consequences.
- A blocked proof becomes a recorded obligation, minimized counterexample search, repaired statement, infrastructure task, or explicit unresolved item—never a fabricated proof or silent weakening.

## Current Facts

- The source corpus is local at `raymond-robichaud-2021/` and includes the 3,014-line Markdown conversion, the original PDF, nine extracted diagrams, and `deutsch-x.md`.
- The Markdown source identifies arXiv `1710.01380v2`, manuscript date February 5, 2021, and contains the mathematical framework in Sections 3–5 plus faithfulness and quantum appendices A–C.
- The source explicitly discusses systems, noumenal and phenomenal states, transformations and two actions, a surjective equivariant noumenal–phenomenal map, projectors, compatibility, state and transformation products, and no-signalling.
- Its reverse construction is presented first with global transitivity and then with an enlarged-state construction intended to remove that postulate.
- The source also contains substantial conceptual and philosophical discussion that is not automatically formalizable mathematics.
- Stage `1-SURVEY` bootstrapped the Lean project in `formal/`: `lean-toolchain` pins Lean `4.31.0`, `lakefile.lean` pins mathlib commit `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`, and the committed manifest records the resolved dependency graph.
- The repository-root `BUILD-PLAN.md` is an exact copy of the supplied generic Lean goal build plan. It requires low-dependency core modules, narrow proof/audit leaves, thin public API modules, import hygiene, focused builds, adjacent-consumer builds, boundary checks, and evidence-based stage fold-back.
- No existing `goal-*` folder preceded this scaffold, so this operating folder is `goal-1/`.
- The initial 2026-07-12 inspection established the pre-bootstrap baseline: root `lake build` failed because no Lake configuration existed. The repository pin now resolves Lean `4.31.0` at commit `68218e876d2a38b1985b8590fff244a83c321783`, and the checked-out mathlib dependency is exactly the pinned commit.
- The initial Git worktree was clean at commit `ce8fa8e`, and the source Markdown is exactly 3,014 lines with nine extracted diagram images.
- `goal-1/source-ledger.md` now contains 149 stable items: 89 numbered-label occurrences, 45 material unnumbered claims/constructions, and 15 outside-scope or interpretative entries. All have source locations, initial statuses, dependencies, and target stages/modules.
- `goal-1/corrections.md` records 20 conversion defects, source defects, scope corrections, and explicit proof obligations with conservative repairs and downstream consequences.
- Stage 1 compiled four narrow probes: Boolean-algebra system/disjointness, standard indexed `MulAction` orientation, explicit `Setoid`/`Quotient.lift` descent through a named congruence theorem, and compatibility-indexed partial products with no off-domain result.
- Final Stage 1 verification passed focused builds (374 jobs), adjacent API/audit/root builds (378 jobs), and full `lake build` (377 jobs). No `sorry`, `admit`, placeholder tactic, project `axiom`, or `opaque` declaration occurs in Lean sources.
- The source audit found central qualifications that later stages must preserve: separation is still required by Theorem 5.8; phenomenal quotienting does not automatically preserve separation; Appendix A Theorem A.2 pairs the wrong hypotheses; iterated partial-product definedness is argued circularly; Section 5.1 omits most descent/coherence proofs; and Appendix C needs finite-dimensional/nonzero-factor hypotheses.
- Stage `2-SYSTEMS` now provides the stable `RR2021.Systems` layer: source-facing subsystem/separation/composite terminology, minimal-hypothesis lattice lemmas, Boolean complement decompositions, named dependent reindexing, four-object associativity coherence, and finite regression/counterexamples.
- The system carrier remains mathlib `BooleanAlgebra`, matching Definition 3.1, while cheap declarations expose weaker assumptions (`LE`, `Max`, semilattices, bounded order, `DistribLattice`, or `HeytingAlgebra`) where verified.
- The corrected Theorem 5.2 system obligations are stronger than the source states explicitly. For `C=Aᶜ⊓B` and `A≤B`, Lean now proves `A⊥Bᶜ`, `C⊥Bᶜ`, `A⊥C`, `A⊔C=B`, and `C⊔Bᶜ=Aᶜ`, plus coherence of the two paths from `(A⊔C)⊔Bᶜ` to `⊤`.
- Stage 2 also proves the complement decompositions silently used later around Theorem 5.8: for disjoint `A,B`, `B⊔(A⊔B)ᶜ=Aᶜ` and `A⊔(A⊔B)ᶜ=Bᶜ`.
- Final Stage 2 verification passed focused builds (362 jobs), finite examples plus adjacent API/audit/root builds (622 jobs), and full `lake build` (366 jobs). Stable system sources contain no proof holes, project axioms, explicit choice calls, or raw equality elimination outside the named `reindex` implementation.
- Stage `3-DYNAMICS` now provides the stable `RR2021.Dynamics` layer: indexed monoid/group/action families, function-only indexed maps with separate properties, nested projectors with derived self-projection, honest compatibility-indexed state products, noncircular binary/triple coherence, raw transformation products, and explicit locality.
- Axiom 3.12's domain is repaired to be exactly separated compatibility. The product has no incompatible-input value; compatibility-proof independence, projections, reconstruction, common-extension equality, and composite uniqueness are derived without choice.
- The circular triple-definedness argument in `RR-C006` is replaced by conversions between explicit left- and right-bracketed definedness propositions, each built from actual common extensions. State-product commutativity and associativity expose `sup_comm`/`sup_assoc` transports and require pairwise separation.
- Transformation-product multiplication, identity, symmetry, and associativity are separate predicates derived from locality plus explicit action effectivity. No group assumption is used for these Section 3 laws.
- Final Stage 3 verification passed focused builds (382 jobs), concrete examples plus adjacent API/audit/root builds (660 jobs), and full `lake build` (387 jobs). The audit reports no axioms for binary state/product and basic locality laws; transport-sensitive coherence uses `[propext]` only, with no choice or quotient axioms.
- Stage `4-THEORIES` now provides the stable `RR2021.Theories` layer. `PhenomenalTheory` captures Axioms 4.1--4.5, while `NoSignallingTheory` adds the precise state-level marginal proposition and the four Axiom 4.6 transformation-product laws without any noumenal or reverse-construction data.
- `LocalRealisticCore` contains every corrected Section 3 requirement except Axiom 3.7; `LocalRealisticWithoutFaithfulness` names that boundary, and `LocalRealisticTheory` adds exactly noumenal action effectivity. Phenomenal state nonemptiness and phenomenal-projector surjectivity are derived rather than stored redundantly.
- Invertible dynamics, transformation separation, contextual phenomenal faithfulness, noumenal faithfulness, and global transitivity are distinct predicates. Transformation separation exposes pairwise system separation plus the permutation/associativity transports suppressed by the source's `ABC` notation.
- Theory-level validation proves transformation-product uniqueness and Theorems 3.8--3.11 from full local-realistic data. Theorem 4.1 is checked both as a two-sided inverse construction and an inverse-uniqueness equality, using only product multiplicativity/unitality and component inverse witnesses.
- A non-boundary no-signalling example with natural-number transformations and Boolean states proves failure of invertibility, phenomenal faithfulness, and global transitivity, mechanically guarding against reverse-postulate field creep.
- Final Stage 4 verification passed focused structure builds (383 jobs), validation/example builds (637 jobs), adjacent API/audit/root builds (393 jobs), and a full pinned build. Constructor prints confirm the intended field boundaries; completed theory sources contain no proof holes, project axioms, explicit choice/quotient operations, defaults, or later-stage imports.
- Stage `5-FORWARD` proves the source's state-level no-signalling equation already from `LocalRealisticCore`, without noumenal action faithfulness. Phenomenalization surjectivity is eliminated only inside the proof, and every action/projection transition is justified by equivariance, projector compatibility, or noumenal locality.
- `LocalRealisticCore.toPhenomenalTheory` forgets the noumenal layer using derived phenomenal nonemptiness/projector surjectivity. `LocalRealisticTheory.toNoSignallingTheory` is the complete forward constructor and fills Axiom 4.6 with the core marginal theorem plus the four previously derived product laws.
- Reverse assumptions and inverse-product results now live in the isolated `Theories.Postulates` leaf. The transitive import graphs of `Forward.Core` and `Forward.Construction` do not reach that module, so the forward direction is separated both semantically and at dependency level.
- A natural-number/trivial-action example proves the pre-faithful core is genuinely non-effective while still satisfying the state-level theorem; a separate faithful singleton model exercises the full constructor.
- Final Stage 5 verification passed the focused core build (384 jobs), constructor/example build (639 jobs), adjacent API/audit/root build (397 jobs), and full build (396 jobs). Principal forward declarations audit with the standard Boolean-algebra foundations `[propext, Classical.choice, Quot.sound]` and no project axiom or explicit choice/quotient operation.
- Stage `6-FAITHFUL` independently verifies both source quotient constructions. Appendix A's contextual relation is an explicit setoid/monoid congruence; its action and separated product descend through Theorems A.1 and A.3, and all five no-signalling laws are re-proved on the quotient. The output is contextually `PhenomenallyFaithful`, with no unsupported local-action effectivity claim.
- Appendix A preserves invertibility and preserves/reflects global transitivity. Transformation separation is proved only from the explicit `TransformationSeparationModuloPhenomenalEquivalence` repair; raw separation alone is not claimed to survive, preserving `RR-C013` as a genuine source gap.
- Appendix B's noumenal action-kernel relation is an explicit setoid/congruence. Both actions, the transformation product, phenomenalization equivariance, and locality descend, while states, projectors, the phenomenalization map, and the compatibility-indexed state product remain unchanged. `LocalRealisticCore.toNoumenallyFaithfulQuotient` returns a directly consumable full `LocalRealisticTheory` using a theory-tagged quotient family.
- Theorems 4.2--4.3 are checked at full contextual strength. Natural-number trivial-action regressions prove distinct raw transformations collapse under each quotient, and consumer probes exercise field projection, derived product laws, and the forward constructor after Appendix B.
- Final Stage 6 verification passed focused cores (460 jobs), constructor/example builds (672 jobs), adjacent API/audit/root builds (476 jobs), and full build (473 jobs). Both audit leaves report only the established Boolean/quotient foundations, with no explicit representative choice or project axiom.
- Stage `7-TRANSITIVE` verifies the source's first reverse construction from a no-signalling theory with explicit existential invertibility, raw transformation separation, global transitivity, and a chosen global reference state. Contextual phenomenal faithfulness is needed only by the full original-transformation wrapper, after a complete `LocalRealisticCore` already exists.
- The fundamental relation is a proved setoid on global transformations. Corrected Theorem 5.2 uses `Aᶜ⊓B` and named path coherence; Theorem 5.8 uses one global right-inverse witness and the raw separation postulate. Invertibility is not strengthened to a group, and no unconditional quotient-preservation claim is made for separation.
- Compatibility is equivalent to sharing a global representative, and `[W]_A⊙[W]_B=[W]_{A⊔B}` is checked. Because compatibility stores existence in `Prop`, one named `Classical.choose` realizes the already-proved unique common extension; there is no incompatible-state value or representative extraction.
- Theorems 5.10--5.14 compile with all triple-product and projector transports explicit. `RR-C020` corrects the PDF's ill-typed Theorem 5.13 proof path. Global transitivity appears only in phenomenalization surjectivity.
- `theoryAtReference` retains the input transformations under phenomenal faithfulness. `faithfulQuotientAtReference` implements the transitive `RR-C017` route without phenomenal faithfulness by applying Appendix B only after reverse postulates have been consumed.
- Final Stage 7 verification passed focused relation/action builds (391 jobs), product/map/constructor examples (471 jobs), adjacent API/audit/root builds (485 jobs), and full build (484 jobs). Public consumer probes and three scoped reviews pass.
- Stage `8-GENERAL` removes global transitivity by pairing each fundamental
  quotient state with a global phenomenal-state label. Action and projection
  preserve that label, and enlarged compatibility is proved equivalent to
  label equality plus fundamental compatibility.
- The enlarged state product reuses Stage 7's compatibility-only product,
  adds no new choice or off-domain value, and proves both arbitrary
  reconstruction and Theorem 5.15's direct shared-representative formula.
- The corrected `RR-C010` phenomenal map applies the descended quotient-state
  map at the stored label. Equivariance, projection compatibility, and
  Theorem 5.16 surjectivity are explicit; the last uses only input projector
  surjectivity, not global transitivity.
- `General.core` requires no-signalling, existential invertibility, and raw
  transformation separation. `General.theory` additionally requires
  contextual phenomenal faithfulness to retain the original transformations;
  `General.faithfulQuotient` instead changes transformations through Appendix
  B and requires neither phenomenal faithfulness nor global transitivity.
- `RR-C011`'s omitted Section 5.1 laws and the general `RR-C017` route are now
  verified. Separation and invertibility remain explicit, so the result is
  not an unconditional equivalence.
- Final Stage 8 verification passed focused state/product/locality builds (396
  jobs), map/constructor/example builds (475 jobs), adjacent API/audit/root
  builds (491 jobs), and full build (490 jobs). Stable consumer probes, static
  boundary scans, and three scoped reviews pass.
- Stage `9-CORRESPONDENCE` exposes seven separate public constructors rather
  than an equivalence object: forward, the two faithfulness quotients, raw and
  quotient transitive reverse outputs, and raw and quotient general reverse
  outputs. Every assumption and changed transformation family is visible in
  its signature.
- `SameOperationalData` compares no-signalling theories only after fixing the
  same transformations, phenomenal states, monoid, and action. Forwarding the
  raw transitive or general reverse output preserves the source phenomenal
  projectors and separated transformation product. Quotient outputs have no
  such same-signature theorem.
- The weakest-premise full general reverse constructor verified here requires
  no-signalling, existential invertibility, and raw transformation separation;
  it needs neither global transitivity nor phenomenal faithfulness, but its
  output uses the Appendix-B transformation quotient. Retaining raw
  transformations additionally requires contextual phenomenal faithfulness.
- No logical minimality, model category, two-sided inverse relationship between
  the forward and reverse constructions, uniqueness, canonicity, universal
  property, observation semantics, or empirical equivalence is proved. The
  quantum instance was carried into Stage 10 and remains explicitly deferred.
- Final Stage 9 verification passed the focused theorem-family build (484
  jobs), consumer/audit build (487 jobs), adjacent API/root build (492 jobs),
  and full build (492 jobs). Exact signature/axiom checks, import scans,
  documentation/whitespace checks, and three independent reviews pass.
- Stage 10 source/mathlib audit finds that Appendix C's unrestricted
  endomorphism-basis argument is invalid outside finite dimensions and its
  final `V^C` sentence both misnames `V^B` and omits unitarity reflection.
  The honest repair uses finite complex matrices, explicit tensor association,
  and nonempty outer factors.
- Pinned mathlib provides matrix Kronecker products, finite matrix-algebra
  tensor equivalences, conjugate transpose, and unitary groups. It does not
  provide a density-operator or partial-trace abstraction, so a complete
  system-indexed quantum `NoSignallingTheory` would require substantial new
  state/projector/coherence infrastructure rather than a wrapper.
- Mathlib separately proves that two unitary isometries induce equal
  conjugation automorphisms on the full continuous-operator algebra exactly
  when they differ by a unitary scalar. This is a checked nearby phase theorem,
  not yet the source's contextual equivalence on density states and separated
  extensions.
- Stage `10-QUANTUM` verifies the finite Appendix-C core over `ℂ` without the
  source's unrestricted basis argument. `commonMiddleFactor` proves both
  factorizations from an explicit six-index overlap equation and nonempty
  outer factors; `mem_unitary_of_kronecker_one` reflects both unitary equations;
  `commonMiddleUnitaryFactor` constructs the correctly named unitary `VB`.
- Empty-left and empty-right coordinate regressions show why the two outer
  nonempty premises cannot be erased. The corrected theorem actually needs
  only `VBC` unitarity, so the paper's unused `VAB`-unitarity premise is not
  retained.
- `conjugation_eq_iff_unitaryPhase` exports the exact full-operator-algebra
  phase theorem. The density-state contextual characterization, phase-quotient
  separation, pure-state transitivity, and complete quantum no-signalling
  instance remain explicit deferrals; no project axiom or placeholder stands
  in for them.
- Final Stage 10 verification passed the focused finite-matrix build (1686
  jobs), phase/consumer/audit build (2356 jobs), adjacent API/root build (2409
  jobs), and full build (2409 jobs). Exact signature/axiom checks, import and
  no-instance scans, documentation/whitespace checks, empty-factor regressions,
  and three independent reviews pass.
- Stage `11-MODELS` exports a stable complete singleton-state/
  singleton-transformation model over the nontrivial Boolean algebra
  `Finset (Fin 2)`. It constructs every local-realistic field directly,
  forwards to no-signalling, proves all four reverse predicates, consumes both
  general reverse outputs, and checks one-sided operational preservation for
  the raw output.
- A separate consumer imports only root `RR2021.API` and exercises model fields,
  forward/reverse constructors, inferred faithful actions, derived product
  laws, and `SameOperationalData`. Models API contains no audit/example leaf.
- Consolidated regressions now cover composition orientation, absent
  cross-system equality, incompatible partial-product inputs, three separate
  non-implications from base no-signalling, raw distinctness and collapse in
  both faithfulness quotients, impossibility of representative-sensitive raw
  recovery, and empty left/right tensor cancellation.
- The Nat/Bool boundary model is not called a pairwise independence family,
  and the generic quotient descent failure is not presented as a countermodel
  to `RR-C013`; raw-separation preservation through Appendix A remains
  open/unsupported.
- Final Stage 11 verification passed the focused model build (692 jobs),
  root-only consumer/audit build (2417 jobs), adjacent API/root build (2411
  jobs), and full build (2411 jobs). Axiom/import/no-cheating scans,
  documentation/whitespace checks, and three independent reviews pass.
- Stage `12-RELEASE` reconciled the README, final report, architecture,
  corrections, ledger, and all stage statuses. A clean-state rebuild completed
  all 2,411 targets after rebuilding one transiently missing mathlib artifact;
  all 13 audit modules then passed at 2,432 jobs and all 10 example modules at
  2,419 jobs. Exact pins, clean mathlib status, 87 Lean sources/545 top-level
  declarations, no-cheating/import scans, 149-item ledger disposition, local
  links, documentation coverage, whitespace, and scoped worktree inventory
  were rechecked independently.

## Historical Initial Assumptions to Test, Not Trust

These Stage-1 questions are retained as design history. Later current-fact
bullets and completed-stage evidence record which were resolved or deferred.

- A Boolean algebra may be the clearest system algebra because the arguments use bottom, top, complement, disjointness, joins, and decompositions; the exact required typeclass hierarchy must be determined from actual proof use.
- Transformations may need group structure for the reverse theorem while the forward framework may need only a monoid action. These layers should be separated rather than globally strengthening all dynamics.
- System-indexed state types will make equalities such as `A ⊔ B = B ⊔ A` create transports. A bundled reindexing/coherence API or carefully normalized indices may be preferable to ad hoc casts.
- Compatibility-indexed products are likely more faithful than total products.
- Observational equality is likely best represented first by a `Setoid` and then by quotient types with explicit descent lemmas, but bundled equivariant maps or orbit constructions may simplify particular stages.
- The paper's word “faithful” may sometimes mean equality modulo the kernel of an action rather than injectivity of the raw transformation representation; every occurrence needs classification.
- The global-transitivity construction and the general enlarged-state construction may share a reusable core, but this must emerge from verified obligations rather than be assumed.
- The finite-dimensional quantum appendix may require infrastructure disproportionate to the abstract theorem. It remains a separate stage whose proved, assumed, or deferred status must be explicit.

## Success Metrics and Global Verification

- A Lean project pins exact Lean 4 and mathlib revisions and builds from a clean checkout with documented commands.
- Public modules separate general system/dynamics infrastructure, local-realistic theory, no-signalling theory, quotients, reconstruction, examples, and the optional quantum layer.
- Module ownership, import layering, focused build commands, adjacent consumer verification, and high-fanout edit decisions are recorded according to `BUILD-PLAN.md` in every implementation stage.
- Every principal source item appears in a traceability table with one of: as stated, corrected, split, additional assumptions, partial, intentionally excluded, or unresolved.
- Every correction records source location, original claim, defect, corrected formulation, justification, and effects on dependent results.
- The forward theorem proves that a suitably defined local-realistic structure induces a no-signalling structure without importing reverse-direction assumptions.
- The reverse theorem constructs a local-realistic model from a no-signalling structure under an inspectable, dependency-audited hypothesis list and verifies all representative independence and coherence laws.
- Separate results cover phenomenal faithfulness, noumenal faithfulness, the transitive construction, and the general enlarged-state construction; their relationships and preservation guarantees are explicit.
- Products and projections on quotient objects are proved well-defined, and partial compatibility domains are not silently totalized.
- Representative small models or countermodels exercise the API and distinguish non-equivalent assumption packages where useful.
- `lake build`, focused tests/examples, source scans for forbidden placeholders, documentation-link checks, and whitespace/diff checks pass.
- An axiom audit using `#print axioms` or an equivalent checked mechanism shows only Lean/mathlib foundations and the explicit hypotheses expected for each principal exported result.
- The final report states what was proved, exact major signatures, module organization, assumptions, corrections, exclusions, unresolved items, quantum status, build/audit results, and import/extension guidance.

## Stage Index

1. `1-SURVEY` — source ledger, project bootstrap, and formalization boundary
2. `2-SYSTEMS` — system algebra, disjointness, decomposition, and transport API
3. `3-DYNAMICS` — indexed states, transformations, actions, maps, projectors, and partial products
4. `4-THEORIES` — modular local-realistic and no-signalling structure definitions
5. `5-FORWARD` — local-realistic structures induce no-signalling structures
6. `6-FAITHFUL` — observational equivalence and both faithfulness quotient constructions
7. `7-TRANSITIVE` — reverse construction under global transitivity
8. `8-GENERAL` — enlarged-state reverse construction without global transitivity
9. `9-CORRESPONDENCE` — precise central theorem family and assumption minimization
10. `10-QUANTUM` — audit and, where feasible, finite-dimensional unitary instance
11. `11-MODELS` — representative examples, countermodels, and API hardening
12. `12-RELEASE` — traceability completion, correction report, axiom audit, and clean build

## Stage Status

| Stage | Status | Evidence / next obligation |
|---|---|---|
| `1-SURVEY` | complete | `goal-1/1-SURVEY.md`; pinned build, 149-entry ledger, correction log (now 20 entries), architecture ADR, compiling probes and audit |
| `2-SYSTEMS` | complete | `goal-1/2-SYSTEMS.md`; stable Systems API, typed relative-complement partitions, finite regressions, reindex/coherence audit |
| `3-DYNAMICS` | complete | `goal-1/3-DYNAMICS.md`; stable Dynamics API, exact-domain partial products, repaired triple coherence, locality-derived transformation laws, finite/trivial examples, and axiom/import audit |
| `4-THEORIES` | complete | `goal-1/4-THEORIES.md`; modular phenomenal/no-signalling and pre-faithful/faithful local-realistic structures, separate reverse postulates, source matrix, positive and negative constructor models, axiom/import audit |
| `5-FORWARD` | complete | `goal-1/5-FORWARD.md`; assumption-minimal Theorem 3.12, phenomenal forgetful map, full forward constructor, literal reverse-import isolation, pre-faithful/full examples, signature/axiom audit |
| `6-FAITHFUL` | complete | `goal-1/6-FAITHFUL.md`; both setoids/quotients, all action/product/locality descent, contextual 4.2--4.3, conditional C013 separation repair, non-vacuous collapse examples, consumer and axiom audits |
| `7-TRANSITIVE` | complete | `goal-1/7-TRANSITIVE.md`; fundamental setoid, corrected projectors, honest unique-choice state product, locality, reference-state map, exact hypothesis audit, original and C017 full constructors |
| `8-GENERAL` | complete | `goal-1/8-GENERAL.md`; label-enlarged states, exact compatibility, inherited honest product, corrected map, transitivity-free surjectivity, exact original-family and Appendix-B constructors, consumer/axiom audits |
| `9-CORRESPONDENCE` | complete | `goal-1/9-CORRESPONDENCE.md`; seven exact constructor names, raw-versus-quotient boundary, one-sided operational-data preservation, claim-status matrix, consumer/import/axiom audit |
| `10-QUANTUM` | complete | `goal-1/10-QUANTUM.md`; finite matrix tensor equivalence, corrected overlap factorization, explicit nonempty cancellation, derived middle unitarity, scoped operator-algebra phase theorem, full-instance deferral audit |
| `11-MODELS` | complete | `goal-1/11-MODELS.md`; stable end-to-end finite trivial model, root-only consumer, both general reverse outputs, operational preservation, consolidated partiality/transport/assumption/quotient/tensor regressions |
| `12-RELEASE` | complete | `goal-1/12-RELEASE.md`; final report/README reconciliation, independent claim and documentation reviews, clean-state 2,411-job build, all-audit 2,432-job build, all-example 2,419-job build, final static/reproducibility gates |

## 1-SURVEY

### Big Picture Objective

Establish a reproducible Lean project and an authoritative mathematical ledger before committing to abstractions.

### Detailed Implementation Plan

- Read Sections 3–5 and Appendices A–C against the PDF where conversion ambiguity matters.
- Inventory every numbered axiom, postulate, definition, lemma, theorem, appendix construction, and mathematically operative unnumbered claim.
- Create traceability and correction-log documents with stable source identifiers and status fields.
- Extract a dependency graph separating definitions, assumptions, derived claims, reverse-construction hypotheses, quantum claims, and interpretative material.
- Create and pin the Lean/mathlib project; record environment and build commands.
- Specialize `BUILD-PLAN.md` into a proposed low-dependency module graph for this library, including core definitions, basic lemmas, heavy proof leaves, audit/example leaves, and thin public re-export modules.
- Probe relevant mathlib APIs for Boolean algebras, disjointness, group/monoid actions, equivariant maps, setoids, quotients, dependent casts, and finite-dimensional linear algebra.
- Write an architecture decision record comparing plausible system and indexed-family encodings with tiny compiling spikes.

### Completion Requirements

- The project builds with pinned versions from the documented command.
- The source ledger covers all mathematical sections and assigns every item an initial status and dependency.
- Interpretative exclusions are identified separately from unresolved mathematics.
- Encoding spikes compile and justify the initial system, action, quotient, and partial-product choices.
- The architecture record identifies high-fanout modules to protect and supplies the focused and adjacent-consumer build pattern required by `BUILD-PLAN.md`.
- No main theorem is declared yet, and no source assumption is silently embedded in a definition.

## 2-SYSTEMS

### Big Picture Objective

Implement the reusable algebra of systems and prove the lattice identities actually needed by later constructions.

### Detailed Implementation Plan

- Choose the weakest accurate mathlib hierarchy for systems, testing whether a Boolean algebra is necessary or merely sufficient.
- Define or standardize subsystem order, empty/global systems, complement, separation/disjointness, composite systems, and compatibility witnesses.
- Prove decomposition and complement lemmas used by the paper, including all hidden distributivity or complement assumptions.
- Design an index-normalization and transport API for commutative/associative composite equalities.
- Add finite system-algebra examples and negative examples that expose overstrong inferred laws.
- Update the correction log wherever a paper proof uses an unstated Boolean identity.

### Completion Requirements

- The system API compiles without paper-specific state assumptions.
- Each exported lemma states the minimal verified algebraic hypotheses.
- Tests/examples cover bottom, top, complement, disjoint join, associativity, commutativity, and representative transport paths.
- Later modules can express `A` separated from `B` and the composite `A ⊔ B` without ad hoc axioms.
- Traceability identifies exactly which source steps require Boolean-algebra strength.

## 3-DYNAMICS

### Big Picture Objective

Build general indexed dynamical infrastructure without prematurely bundling either theory.

### Detailed Implementation Plan

- Define system-indexed phenomenal and noumenal state families.
- Represent transformation families with monoid/group layers and fix composition/action orientation through executable laws.
- Bundle actions and equivariant noumenal–phenomenal maps; separate surjectivity from equivariance.
- Define projectors/restrictions with identity, nesting, and separated-system coherence laws, distinguishing stored fields from derived results.
- Define state and transformation products on honest compatibility domains, with typed codomains and transport lemmas.
- Develop reusable lemmas for equivariance, projection-product interaction, associativity/commutativity up to indexed equality, and compatibility preservation.

### Completion Requirements

- Tiny examples demonstrate the chosen action composition convention and fail if it is reversed.
- No product has arbitrary observable behavior outside its compatibility domain.
- All dependent transports used by basic composite laws are encapsulated in named, tested lemmas.
- Surjectivity, injectivity/faithfulness, and kernel equivalence remain distinct properties.
- The module is reusable without importing either paper-specific theory structure.

## 4-THEORIES

### Big Picture Objective

Define modular local-realistic and no-signalling structures whose field boundaries expose the paper's true assumptions.

### Detailed Implementation Plan

- Translate the source axioms and postulates into a matrix of fields versus derived propositions.
- Define a minimal phenomenal operational theory and extend it with explicit no-signalling data/laws.
- Define local-realistic data with noumenal states, phenomenal images, locality/projectors, products, and actions.
- Factor invertibility, separation, phenomenal faithfulness, noumenal faithfulness, global transitivity, and product existence into named mixins or standalone predicates.
- State validation lemmas connecting bundled laws to source formulations.
- Record all reordered, split, strengthened, or weakened source declarations.

### Completion Requirements

- The structures compile and their constructors reveal assumptions directly.
- No reverse-construction postulate contaminates the basic no-signalling definition.
- No-signalling is a precise mathematical proposition with the relevant system separation and transformation scope explicit.
- Each paper axiom/postulate maps to a field, theorem, corrected item, exclusion, or unresolved obligation.
- Example skeletons show that the structures are inhabitable without circular fields.

## 5-FORWARD

### Big Picture Objective

Prove that the appropriate local-realistic structure induces a no-signalling structure, using only forward-direction assumptions.

### Detailed Implementation Plan

- Construct the phenomenal no-signalling data by forgetting or mapping the noumenal layer.
- Prove separated transformations cannot change the remote phenomenal projection using locality and equivariance.
- Track whether surjectivity of the noumenal–phenomenal map is required for the chosen formulation.
- Split alternate strengths of the forward result if the paper conflates state-level and transformation-level claims.
- Add an assumption-minimality audit and a small model exercising the theorem.

### Completion Requirements

- A named exported construction/theorem builds the no-signalling structure and passes `#print axioms` audit.
- Its signature contains no global transitivity, reverse quotient, or quantum assumptions.
- The proof covers arbitrary states and allowed separated transformations in the formal definition.
- Any mismatch with the paper's stated Axiom 3.12 or related conclusion is documented with downstream effects.

## 6-FAITHFUL

### Big Picture Objective

Formalize observational equivalence and verify the phenomenal and noumenal faithfulness quotient constructions independently.

### Detailed Implementation Plan

- Identify each kernel/observational relation on transformations and states and prove reflexivity, symmetry, and transitivity.
- Construct phenomenal transformation quotients and show composition and action descend.
- Construct the related noumenal quotient only under the exact invariance assumptions it needs.
- Prove representative independence for every descended operation and map.
- Distinguish faithful actions from equality in a quotient and prove the correct universal or preservation statements when useful.
- Test whether products and projectors descend; isolate extra congruence hypotheses rather than assuming them globally.

### Completion Requirements

- Both quotient results have separate exported statements and assumption lists.
- All uses of `Quotient.lift`/`liftOn` have nearby, named well-definedness lemmas.
- Composition, action, products, projections, and phenomenal maps descend only where proved congruent.
- Faithfulness claims are stated as injectivity/effective action or quotient equality precisely, not terminologically.
- Appendix A and B claims are fully mapped and any gaps are logged.

## 7-TRANSITIVE

### Big Picture Objective

Reconstruct and verify the local-realistic model of a no-signalling theory under explicit invertibility, separation, faithfulness, and global-transitivity hypotheses.

### Detailed Implementation Plan

- Re-derive the source's candidate noumenal states and fundamental equivalence relation from the operational data.
- Prove the relation is an equivalence without using the target theorem or an unstated orbit fact.
- Define noumenal projectors, action, product, and noumenal–phenomenal map by quotient descent.
- Prove representative independence for each definition before proving higher coherence.
- Establish locality, action laws, projection nesting, compatibility/product laws, surjectivity, and equivariance.
- Compare each proof dependency with Section 5 and record circularity, missing hypotheses, or repaired statements.

### Completion Requirements

- A compiling constructor returns a local-realistic model from a no-signalling structure plus an explicit transitive hypothesis package.
- The fundamental relation is a proved `Setoid`.
- Projectors, actions, products, and the phenomenal map each have explicit well-definedness theorems.
- No construction relies on arbitrary values for incompatible states.
- The result states exactly what phenomenal behavior is preserved and does not assert uniqueness or categorical equivalence without proof.

## 8-GENERAL

### Big Picture Objective

Verify the enlarged-state construction intended to remove global transitivity and characterize what it actually preserves.

### Detailed Implementation Plan

- Independently reconstruct the Section 5.1 enlarged noumenal state space rather than mechanically adapting the transitive proof.
- Identify orbit labels, auxiliary global states, or other data needed to make the construction total and surjective.
- Reprove the fundamental equivalence, action, projectors, partial products, and phenomenal map on the enlarged representation.
- Factor shared lemmas with the transitive construction only after their hypotheses align.
- Prove the relationship between the transitive special case and the general construction where meaningful.
- Search for counterexamples or missing closure assumptions if the general construction fails.

### Completion Requirements

- Either a compiling general constructor removes global transitivity under a precise replacement hypothesis package, or the exact minimal failed obligation is isolated and documented with the strongest proved nearby theorem.
- All quotient descent and coherence requirements meet the Stage 7 standard.
- The result's preservation claim and any non-canonicity are explicit.
- The correction log explains any change to the paper's Section 5.1 claim and its effect on the central theorem.

## 9-CORRESPONDENCE

### Big Picture Objective

Assemble the exact theorem family supported by the formal development and minimize its assumptions without overclaiming equivalence.

### Detailed Implementation Plan

- Export separate named statements for the forward implication, transitive reverse construction, general reverse construction, and the two faithfulness quotients.
- Define a precise notion of model correspondence or observational preservation only if needed and prove exactly that relation.
- Use Lean signatures, dependency inspection, and targeted generalization to remove unused hypotheses.
- Check whether uniqueness, canonicity, definitional equivalence, categorical equivalence, and empirical equivalence follow; omit or refute them when they do not.
- Produce machine-checked examples showing why distinct claims must remain separate.

### Completion Requirements

- The central public theorem(s) expose all assumptions in their signatures and have documented `#print axioms` output.
- Documentation never abbreviates the result as an unconditional equivalence.
- Each of the six claims identified in the goal prompt has an independent status and declaration link or explicit deferral.
- Assumption minimization has been attempted and its evidence recorded.

## 10-QUANTUM

### Big Picture Objective

Audit the quantum appendix separately and formalize a finite-dimensional unitary instance only to the extent supported by verified mathematics and available Lean infrastructure.

### Detailed Implementation Plan

- Check tensor-factor order, dimensions, bases, scalar field, partial traces/restrictions, unitary conventions, and the inference that the middle operator is unitary.
- Map required quantum facts to existing mathlib APIs and distinguish reusable missing infrastructure from mathematical gaps.
- First prove small supporting lemmas and an accurately scoped finite-dimensional model.
- Instantiate the abstract no-signalling structure and each reverse-construction postulate only after explicit proofs.
- If the complete instance is infeasible, formalize the strongest useful subset and record exact remaining obligations without importing them as unexplained axioms.

### Completion Requirements

- Appendix C and Section 4.2 receive item-by-item statuses and corrections.
- Every quantum result distinguishes proved facts from explicit assumptions or future work.
- Any completed instance compiles and states finite-dimensional, scalar-field, factorization, and unitary hypotheses explicitly.
- The disputed middle-operator inference is either proved with sufficient hypotheses or recorded as a precise failed obligation/corrected lemma.
- Deferral of the full quantum instance, if necessary, does not weaken completion claims for the abstract library.

## 11-MODELS

### Big Picture Objective

Stress-test usability and logical boundaries through small models, countermodels, and downstream imports.

### Detailed Implementation Plan

- Implement finite classical/trivial examples covering systems, actions, projectors, products, and both directions where applicable.
- Construct countermodels or independence examples for assumptions that the paper may conflate, such as transitivity, faithfulness, and invertibility.
- Add import-level examples using only the intended public API.
- Refactor leaky internals, brittle casts, and overly bundled hypotheses exposed by examples.
- Benchmark build complexity and remove unnecessary dependencies.

### Completion Requirements

- At least one nonempty small model builds through the public API.
- Tests detect reversed composition, invalid cross-system transport, incompatible products, and improper quotient descent.
- Important additional assumptions are illustrated or justified rather than merely asserted to be necessary.
- Public import paths and extension points are documented and compile independently.

## 12-RELEASE

### Big Picture Objective

Deliver a clean, reproducible, auditable library and final report whose claims match the checked code.

### Detailed Implementation Plan

- Finish the traceability matrix and correction log, including consequences for dependent results.
- Document module organization, conventions, design choices, public theorem signatures, and extension guidance.
- Classify philosophical exclusions, unresolved mathematics, missing Lean infrastructure, and omitted quantum work separately.
- Run the full build, focused examples, forbidden-token scans, documentation checks, whitespace/diff checks, and axiom audit.
- Verify the pinned build in a clean or equivalently isolated environment.
- Reconcile every final-report sentence against compiled declarations and audit evidence.

### Completion Requirements

- `lake build` succeeds from the documented pinned environment.
- Completed modules contain no `sorry`, `admit`, unexplained `axiom`, or hidden fallback implementation.
- Axiom-audit results for every principal exported theorem are captured and explained.
- The source ledger has no unclassified material claim in scope.
- The final report includes all items requested in the objective: formalized content, structures/constructions/signatures, organization, assumptions, corrections, exclusions, unresolved claims, quantum status, build/audit results, and import/extension guidance.
- Any open issue is explicit next work with evidence and does not appear inside a completed claim.
