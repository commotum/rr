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
- The repository currently contains no Lean source files, `lakefile`, or `lean-toolchain`; project creation and version pinning are required.
- The repository-root `BUILD-PLAN.md` is an exact copy of the supplied generic Lean goal build plan. It requires low-dependency core modules, narrow proof/audit leaves, thin public API modules, import hygiene, focused builds, adjacent-consumer builds, boundary checks, and evidence-based stage fold-back.
- No existing `goal-*` folder preceded this scaffold, so this operating folder is `goal-1/`.

## Initial Assumptions to Test, Not Trust

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
- The reverse theorem constructs a local-realistic model from a no-signalling structure under an inspectable, minimized list of hypotheses and verifies all representative independence and coherence laws.
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
