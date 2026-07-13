# RR2021 Correction and Obligation Log

This log records defects found while comparing
`raymond-robichaud-2021/raymond-robichaud-2021.md` with the supplied PDF and
while checking the mathematical dependencies of Sections 3–5 and Appendices
A–C. A correction here is not a Lean proof. “Proposed repair” means the
strongest conservative statement to test; it becomes accepted only after the
relevant stage compiles and its assumptions have been audited.

## Classification

- **Conversion defect:** the PDF is clearer/correct and the Markdown conversion
  lost typography or structure.
- **Source typo:** the defect is visible in the original PDF as well as Markdown.
- **Statement repair:** the mathematical statement needs corrected variables,
  types, scope, or hypotheses.
- **Proof obligation/gap:** the source asserts a law or construction without the
  argument needed for formal descent, definedness, or implication.
- **Claim-scope correction:** summary or interpretative prose says more than the
  checked mathematical route supports.

## Required field mapping

Every entry records the release-plan fields as follows: **Source/evidence** gives
the source location, the original claim, and the evidence justifying the
diagnosis; **Defect** states the precise failure; **Conservative repair** is the
corrected formulation to test; **Downstream effects** records downstream
consequences; and **Status** distinguishes confirmed editorial findings from
unproved mathematical repairs. Thus a proposed repair is never treated as
proved merely because its textual defect is confirmed.

## `RR-C001` — Markdown loses complement bars and class/set typography

- **Classification:** Conversion defect.
- **Source/evidence:** representative losses at Markdown `L289–319`,
  `L1633–1682`, `L1718–1741`, and `L1762–1798`. The PDF visibly has `Ā`,
  `I^{Ā}`, set braces, and class brackets on printed pages 11 and 39–41.
- **Defect:** The Markdown displays complements as the original system in many
  places. For example, reflexivity of `∼_A` appears as `I^A × I^A` rather than
  `I^A × I^{Ā}`. Set-builder delimiters also appear as stray `n`/`o` glyphs.
- **Conservative repair:** Treat the PDF as authoritative for overbars,
  superscripts, brackets, and braces. Encode complements explicitly and never
  infer a same-system identity factor from the converted text.
- **Downstream effects:** System algebra, the fundamental relation, every
  reconstruction action, and representative-independence proof. In
  particular, this correction prevents a false diagnosis of Theorem 5.2; see
  `RR-C009`.
- **Status:** Confirmed by visual PDF inspection and Lean-verified in Stage 7:
  `extendSystem`, `extendComplement`, `FundamentallyEquivalent`, and
  `fundamentalSetoid` use the explicit complement/global reindexes.

## `RR-C002` — noumenal-faithfulness cross-reference points to Appendix A

- **Classification:** Source typo/cross-reference defect.
- **Source/evidence:** `L485–488` says the quotient removing failure of
  noumenal faithfulness is in Appendix A. Appendix A (`L2419–2642`) is the
  phenomenal quotient; Appendix B (`L2646–2837`) is the noumenal quotient.
- **Defect:** Wrong appendix letter.
- **Conservative repair:** Cite Appendix B for noumenal faithfulness and
  Appendix A for phenomenal faithfulness.
- **Downstream effects:** Traceability for Stage 6 and any dependency argument
  using the appropriate quotient.
- **Status:** Confirmed textual correction; both independently named quotient
  constructions now compile in Stage 6.

## `RR-C003` — phenomenal projector prose calls its output noumenal

- **Classification:** Source typo.
- **Source/evidence:** `L604–610`; the variable is `ρ_A` and Axiom 3.10 is the
  phenomenal projector, but `L610` says “the noumenal state.”
- **Defect:** State-sort mismatch in explanatory prose.
- **Conservative repair:** Read “the phenomenal state of subsystem `A` is
  `ρ_A = π_A(ρ_B)`.”
- **Downstream effects:** None to the intended equation, but Lean must use
  separate noumenal and phenomenal projector families.
- **Status:** Confirmed textual correction.

## `RR-C004` — Axiom 3.12 misclassifies a partial state product

- **Classification:** Statement/type repair.
- **Source/evidence:** `L716–742` calls `⊙_{A,B}` a “transformation,” then says
  `N_A ⊙ N_B` is defined only for compatible states.
- **Defect:** The displayed signature is not a transformation in the source’s
  transformation monoid. It is a genuinely partial operation on pairs of
  noumenal states of disjoint systems. A bare partial-function reading also
  leaves witness/output independence implicit.
- **Conservative repair:** Define a compatibility-indexed product (or a function
  taking a compatibility witness) with codomain the `AB` state space. Prove that
  the result is independent of the composite witness/proof where required, and
  state reconstruction only on the compatibility domain. No arbitrary
  off-domain value may enter a theorem.
- **Downstream effects:** Theorems 3.3–3.7, Axiom 3.13, the reverse products in
  Theorems 5.8–5.10, and both quotient constructions.
- **Status:** Repair accepted and compiled in Stage 3. `Dynamics.StateProduct`
  requires both separation and `Compatible` evidence, stores only the product
  and reconstruction operation, and derives witness/proof independence,
  projections, and composite uniqueness. `Dynamics.StateProductCoherence`
  proves commutativity and the repaired triple laws without an off-domain
  branch or representative selection.

## `RR-C005` — malformed formulas in the iterated-product discussion

- **Classification:** Source typos.
- **Source/evidence:** The defects are visible in the PDF on printed pages
  24–25 as well as Markdown:
  - Lemma 3.1 at `L803–806` has `N_Aπ_A(N_{ABC})`, missing `=`.
  - Lemma 3.2 at `L832–835` has malformed parentheses around
    `N_A ⊙ (N_B ⊙ N_C)`.
  - The consequence after Theorem 3.7 at `L924` says the `B` factor is
    `π_B(N_{AB})`, although the ambient state is `N_{ABC}`.
- **Defect:** Local formula/variable errors obscure the intended typed claims.
- **Conservative repair:** Use `N_A = π_A(N_{ABC})`, the right-associated
  product `N_A ⊙ (N_B ⊙ N_C)`, and `π_B(N_{ABC})`.
- **Downstream effects:** The statement layer for Lemmas 3.1–3.2 and the
  three-factor uniqueness corollary. These corrections do not repair the
  separate definedness gap in `RR-C006`.
- **Status:** Confirmed textual corrections.

## `RR-C006` — Lemma 3.4 argues definedness circularly

- **Classification:** Proof gap.
- **Source/evidence:** `L872–909`, PDF printed pages 24–25. Lemma 3.4 says both
  nested products are defined “by Lemmas 3.1 and 3.2,” but those lemmas assume
  the corresponding nested product is already defined.
- **Defect:** The cited lemmas cannot establish their own hypotheses. Therefore
  the source proof does not yet justify the definedness portion used by
  Theorems 3.6 and 3.7.
- **Conservative repair:** Starting from the common composite state `N_{ABC}`,
  use projector nesting and Axiom 3.12 to construct `π_{AB}(N_{ABC})` from its
  `A`/`B` projections and then combine it with the `C` projection; repeat for
  `A` and `BC`. Only after both compatibility witnesses are built should the
  equality proof use reconstruction. Formalize definedness and equality as
  separate lemmas.
- **Downstream effects:** Lemma 3.4, Theorems 3.6–3.7, associativity fields or
  derived laws, and any later unparenthesized noumenal products.
- **Status:** Repair accepted and compiled in Stage 3.
  `StateProduct.leftDefined_to_rightDefined` and its converse build the missing
  nested compatibility witnesses from actual common extensions;
  `leftDefined_iff_rightDefined`, `product_assoc`, and
  `leftNestedProduct_eq_iff_direct_projections` then prove the corrected
  definedness/equality claims. The axiom audit reports `[propext]` only for
  these transport-sensitive results.

## `RR-C007` — Definition 4.1 has an unused quantified transformation

- **Classification:** Source typo/statement repair.
- **Source/evidence:** Definition 4.1 at `L1435–1443`; visual PDF printed page
  35 confirms it quantifies “for all transformation `W` on system `B`” while
  the formula compares `(U × I^B)ρ^{AB}` with `(V × I^B)ρ^{AB}` and never uses
  `W`.
- **Defect:** The quantifier is vacuous. Replacing the identities by `W` would
  be a different, stronger displayed definition and is not what Appendix A’s
  proofs cite.
- **Conservative repair:** Remove the `W` quantifier and retain the displayed
  identity-extension equation for every disjoint `B` and every `ρ^{AB}`.
  Separately prove that this is an equivalence relation.
- **Downstream effects:** Postulate 4.3, Theorems 4.2–4.3, all of Appendix A,
  and the phenomenal quotient API.
- **Status:** Confirmed source correction and compiled at the predicate layer
  in Stage 4 as `NoSignallingTheory.PhenomenallyEquivalent`. The definition
  quantifies over every separated identity extension and composite state but
  not the unused `W`; it is not weakened to local `ActionEffective`.
  Stage 6 subsequently proved `phenomenalSetoid`, the monoid congruence
  `phenomenalCon`, and the complete `phenomenalQuotientTheory` descent.

## `RR-C008` — small transformation-product variable errors

- **Classification:** Source typos.
- **Source/evidence:** In the proof of Theorem 3.9, `L1016–1026` applies `I^A`
  to the `B` state where `I^B` is required. The three-factor example at
  `L1136–1143` ends in `W N_B` rather than `W N_C`.
- **Defect:** Ill-typed identity/action variables in illustrative calculations.
- **Conservative repair:** Use `I^A N_A ⊙ I^B N_B` and
  `U N_A ⊙ V N_B ⊙ W N_C`.
- **Downstream effects:** Executable convention tests for transformation
  products; the theorem statements themselves remain unchanged.
- **Status:** Confirmed by types/context and compiled with the corrected action
  orientation and identity variables in Stage 3. No claim of a separate visual
  PDF confirmation is made for this entry.

## `RR-C009` — Theorem 5.2 relative complement is lost only in Markdown

- **Classification:** Conversion defect, not a paper theorem defect.
- **Source/evidence:** Markdown `L1762–1798` renders `C = A ⊓ B`, which would
  not generally be disjoint from `A` when `A ≤ B`. Visual inspection of PDF
  printed page 41 shows `C = Ā ⊓ B`.
- **Defect:** The complement bar over `A` disappeared during conversion.
- **Conservative repair:** Use the relative complement `C = Aᶜ ⊓ B`; prove
  `A ⊓ C = 0` and `A ⊔ C = B` from the selected Boolean-algebra laws before
  using product associativity. The later expression `I_C × V_{Bᶜ}` also hides
  the required facts `Disjoint A Bᶜ`, `Disjoint C Bᶜ`, and
  `C ⊔ Bᶜ = Aᶜ`; prove all three before treating that product as a
  transformation of `Aᶜ`.
- **Downstream effects:** Monotonicity of the fundamental setoid and
  well-definedness of constructed projectors.
- **Status:** PDF resolves the ambiguity. Stage 2 now proves the Boolean
  decompositions, all three required pairwise separation facts, and coherence
  of the two explicit paths to the global system in
  `RR2021.Systems.relativeComplement_decomposition_typed` and
  `RR2021.Systems.reindexRelativeComplement_top_coherent`. Transformation
  product and quotient-descent steps are now Lean-verified by
  `FundamentallyEquivalent.mono` and `NoumenalState.projectors` in Stage 7.

## `RR-C010` — Section 5.1 phenomenal map applies `φ` to a raw representative

- **Classification:** Source type error.
- **Source/evidence:** `L2316–2324`, confirmed visually on PDF printed page 49,
  defines `ϕ^A([W]_A,ρ) = φ^A_ρ(W)`. Definition 5.7 at `L2056–2068` gives
  `φ^A_ρ` domain `Noumenal-Space_A`, whose elements are classes `[W]_A`, not
  raw global transformations.
- **Defect:** Domain mismatch.
- **Conservative repair:** Define
  `ϕ^A([W]_A,ρ) = φ^A_ρ([W]_A) = π_A(Wρ)`. The second equality is permitted
  only through Theorem 5.11’s representative-independence result.
- **Downstream effects:** Enlarged-map well-definedness, equivariance,
  projection compatibility, and surjectivity in Theorem 5.16.
- **Status:** Confirmed source correction and Lean-verified in Stage 8.
  `General.EnlargedNoumenalState.phenomenalize` consumes the fundamental
  quotient state at the stored global label, while
  `phenomenalize_ofRepresentative` proves the corrected representative
  formula. The equivariance, projection-compatibility, and surjectivity
  theorems all use this class-valued definition rather than applying `φ` to a
  raw `W`.

## `RR-C011` — Section 5.1 omits most well-definedness and structure proofs

- **Classification:** Proof obligations/gap.
- **Source/evidence:** `L2262–2327` defines the enlarged state space,
  projectors, partial product, action, and phenomenal map, then says it is “easy
  to verify” that all are well-defined and satisfy every local-realistic axiom.
  Only a product reconstruction example (Theorem 5.15) and surjectivity
  (Theorem 5.16) follow; equivariance is merely called “obvious” at `L2370`.
- **Defect:** The central no-global-transitivity constructor lacks explicit
  proofs for projector descent/surjectivity/nesting, action descent and laws,
  product domain and coherence, map descent/equivariance, projector-map
  compatibility, and the complete structure assembly.
- **Conservative repair:** Treat each law as an independent Stage 8 theorem.
  Preserve the common global-state label in the compatibility domain and reuse
  Stage 7 results only after matching their hypotheses. Assemble the constructor
  only after every required field compiles.
- **Downstream effects:** Theorem 5.15 is only one field-level check; Theorem
  5.16 alone does not prove the general reverse result. Accordingly the central
  correspondence claims remained unresolved until Stage 8 checked the full
  constructor.
- **Status:** Repair accepted and compiled in Stage 8. The enlarged action and
  projectors have separate computation, law, nesting, and surjectivity
  proofs; `compatible_iff_label_eq_and_fundamental_compatible` exposes the
  exact product domain; `stateProduct`, `stateProduct_ofRepresentative`, and
  its reconstruction field verify Theorem 5.15 without new choice;
  `mapCompatible` and `locality` discharge the action/product obligations;
  and phenomenalization has explicit equivariance, projection compatibility,
  and Theorem 5.16 surjectivity proofs. `General.core` assembles every
  pre-faithful field, `General.theory` adds raw action effectivity from
  contextual phenomenal faithfulness, and `General.faithfulQuotient` instead
  supplies it through Appendix B.

## `RR-C012` — Theorem A.2 pairs the wrong transformations in its statement

- **Classification:** Source typo/statement repair.
- **Source/evidence:** `L2470–2506`. The statement assumes `U₁ ∼ U₂` and
  `V₁ ∼ V₂`, but concludes `U₂∘U₁ ∼ V₂∘V₁`. The proof substitutions at
  `L2487` and `L2492` require `U₁ ∼ V₁` and `U₂ ∼ V₂` instead.
- **Defect:** The printed hypotheses do not support the proof or the quotient
  composition congruence needed later.
- **Conservative repair:** State: if `U₁` is phenomenally equivalent to `V₁`
  and `U₂` is phenomenally equivalent to `V₂`, then `U₂∘U₁` is phenomenally
  equivalent to `V₂∘V₁`.
- **Downstream effects:** Well-defined quotient composition at `L2581–2584`.
- **Status:** Lean-verified as
  `NoSignallingTheory.phenomenallyEquivalent_mul`; quotient multiplication
  uses this corrected congruence.

## `RR-C013` — phenomenal quotient does not automatically preserve separation

- **Classification:** Mathematical gap.
- **Source/evidence:** Appendix A `L2639` says invertibility, separation, and
  global transitivity are all easily preserved by the phenomenal quotient.
  The original separation premise at `L1364–1372` requires **raw equality**
  `I_A×V_{BC} = I_B×V_{AC}`. Equality in the quotient gives only phenomenal
  equivalence of those raw products.
- **Defect:** Original separation cannot be applied to the weaker quotient
  premise. Quotienting may enlarge intersections of the embedded
  transformation images, so this is not a routine congruence consequence and
  can fail without a stability property.
- **Conservative repair:** Either prove a representative-adjustment theorem or
  assume/prove **separation modulo phenomenal equivalence**:
  phenomenal equivalence of the two supported products yields a `C`
  transformation making both phenomenally equivalent to `I_{AB}×V_C`.
  A countermodel search should test necessity.
- **Downstream effects:** The route “phenomenal quotient first, then apply the
  Section 5 constructor” is not currently justified. It also invalidates using
  Appendix A alone to erase phenomenal faithfulness from the headline theorem.
- **Status:** The source's unconditional claim remains open/unsupported.
  Stage 6 formalizes the exact repair as
  `TransformationSeparationModuloPhenomenalEquivalence`, proves quotient
  separation from that premise, and does not derive it from raw separation
  alone. The route avoiding the premise remains `RR-C017`. Stage 11's
  `rawValueCannotDescend` is a generic negative regression for the distinct
  noumenal action quotient; it does **not** supply a countermodel to Appendix
  A separation preservation. No such countermodel is claimed here.

## `RR-C014` — Appendix B has a duplicate theorem label and a state-sort typo

- **Classification:** Source numbering and prose typos.
- **Source/evidence:** PDF printed page 56 and Markdown `L2669` label the
  composition congruence “Theorem B.2.” PDF printed page 58 and Markdown
  `L2775–2778` again label the quotient-monoid sentence “Theorem B.2.” At
  `L2781–2790`, the noumenal-action definition is followed by “phenomenal state
  `ρ_A`” although its displayed argument is `N_A`.
- **Defect:** Stable citation collision and wrong state sort.
- **Conservative repair:** Retain independent ledger IDs `RR-AB-T02a` for
  composition congruence and `RR-AB-T02b` for the quotient-monoid claim; do not
  guess an intended paper number. Read the action paragraph as quantified over
  noumenal states `N_A`.
- **Downstream effects:** Stage 6 declaration naming and source links; no
  mathematical theorem should depend on the ambiguous printed label alone.
- **Status:** Confirmed by visual PDF inspection and implemented with separate
  A/B composition-congruence and quotient-monoid declarations; the descended
  action is correctly typed on noumenal states.

## `RR-C015` — Appendix C basis argument needs finite-dimensional hypotheses

- **Classification:** Missing assumptions/statement repair.
- **Source/evidence:** Definition C.1 and the following claim at `L2858–2868`,
  used in Theorem C.1 at `L2890–2945`. The theorem is stated for arbitrary
  Hilbert spaces.
- **Defect:** For arbitrary infinite-dimensional spaces, the canonical map
  `End(H_A) ⊗ End(H_B) → End(H_A ⊗ H_B)` is not generally onto; simple products
  of bases of the endomorphism spaces therefore do not automatically form a
  basis of all endomorphisms of the tensor product. The proof also mixes
  algebraic vector-space tensors with Hilbert-space tensors without a convention.
- **Conservative repair:** First state a finite-dimensional result over an
  explicit scalar field using the canonical finite-dimensional endomorphism
  tensor equivalence. Require nonzero outer factors where tensor cancellation
  or identity membership is used. Treat any infinite-dimensional extension as
  separate future work.
- **Downstream effects:** Theorem C.1 and the claimed quantum proof of
  Separation Postulate 4.1; Section 4.2 cannot be marked complete from the
  source proof as written.
- **Status:** Repaired and Lean-verified for finite complex coordinate spaces
  in Stage 10. `Quantum.finiteMatrixTensorEquiv` exposes mathlib's canonical
  equivalence from the tensor product of two finite matrix spaces to matrices
  on the product index and computes simple tensors as Kronecker products.
  `Quantum.commonMiddleFactor` then proves the needed factorization directly
  from entries, with `Nonempty A` and `Nonempty C` explicit, so it does not
  assume the source's product-basis expansion. No arbitrary or completed
  infinite-dimensional Hilbert-space version is claimed.

## `RR-C016` — Appendix C names the wrong middle operator and skips unitarity reflection

- **Classification:** Source typo plus proof obligation.
- **Source/evidence:** Theorem C.1 constructs `V^B` at `L2938–2945`; the final
  sentence at `L2949`, visible on PDF printed page 60, says “Because `V^{BC}` is
  unitary, `V^C` must also be unitary.” No `V^C` was defined.
- **Defect:** `V^C` should be `V^B`. Even after that textual correction,
  unitarity of a tensor factor is not established by the preceding coefficient
  argument. It requires reflection/cancellation through a nonzero identity
  tensor factor (and compatible adjoint/tensor conventions).
- **Conservative repair:** Replace `V^C` with `V^B`; under explicit nonzero,
  finite-dimensional Hilbert-space hypotheses, prove from
  `V^{BC}=V^B⊗I^C` and unitarity of `V^{BC}` that both
  `(V^B)†V^B=I^B` and `V^B(V^B)†=I^B`.
- **Downstream effects:** Quantum separation and any statement that unitary
  quantum theory satisfies all reverse-construction postulates.
- **Status:** Typo confirmed and the finite complex repair is Lean-verified.
  `Quantum.kroneckerOneRight_injective` proves identity-tensor cancellation
  from an explicit outer coordinate;
  `Quantum.mem_unitary_of_kronecker_one` reflects both star-inverse equations;
  and `Quantum.commonMiddleUnitaryFactor` constructs the correctly named
  `VB`, proves both factorizations, and derives its unitarity from the unitary
  `BC` factor. `Quantum.Examples.empty_right_factor_not_injective` verifies
  that the nonempty-factor premise cannot simply be dropped.

## `RR-C017` — repaired central route and headline-scope correction

- **Classification:** Claim-scope correction and proposed theorem repair.
- **Source/evidence:** The abstract `L21`, conclusion `L2403`, and
  `deutsch-x.md:L52` summarize the result as applying to no-signalling theories
  (or “any theory”) with reversible/invertible dynamics. But Theorem 5.8
  (`L1991–1997`) still uses Separation Postulate 4.1, and Appendix A’s attempt
  to preserve separation through the phenomenal quotient has the gap in
  `RR-C013`.
- **Defect:** Reversible dynamics alone is not the hypothesis package proved by
  the displayed construction. Phenomenal faithfulness can plausibly be removed,
  but separation has not been removed.
- **Conservative repair:** Prove the following route, with every arrow checked:
  1. From the **original** no-signalling theory with separation and group
     dynamics, run Sections 5/5.1 while omitting the one noumenal-faithfulness
     field, producing a local-realistic structure minus Axiom 3.7.
  2. Apply the Appendix B noumenal quotient to obtain faithful noumenal action.
  This avoids any need for the Appendix A quotient to preserve separation. It
  still does **not** remove separation, and Appendix B’s omitted descent laws
  must be proved.
- **Downstream effects:** Stage 7/8 constructor signatures, Stage 9 theorem
  family, abstract/conclusion wording, and classification of the 2026 Deutsch
  quotation. Social or metaphysical endorsement remains intentionally excluded.
- **Status:** Appendix B's second step is Lean-verified by
  `LocalRealisticCore.toNoumenallyFaithfulQuotient`, including every action,
  product, locality, and consumer-instance obligation. Stage 7 now verifies
  the complete transitive pre-faithful constructor and its composition with
  Appendix B as `faithfulQuotientAtReference`. Stage 8 verifies the general
  non-transitive pre-faithful constructor as `General.core` and the repaired
  composition as `General.faithfulQuotient`. That output requires invertibility
  and raw separation, but neither global transitivity nor phenomenal
  faithfulness, and it changes the transformation family. The original-family
  `General.theory` still requires phenomenal faithfulness. Separation is not
  removed by either route. Stage 9 exposes these results respectively as
  `generalReverseWithFaithfulQuotient` and
  `generalReverseRetainingTransformations`. Only the raw-transformation output
  has the checked `generalReverse_forward_sameOperationalData` theorem. The
  quotient result is a full theory over a different transformation family and
  is not presented as a same-signature model correspondence.

## `RR-C018` — quantum phase-equivalence claim is not yet an instance proof

- **Classification:** Proof obligation/scope repair.
- **Source/evidence:** Section 4.2 `L1568` says unitary operations are
  phenomenally equivalent exactly when they differ by a unit-norm scalar and
  that Appendix A therefore supplies phenomenal faithfulness.
- **Defect:** No proof is supplied for the exact relation under Definition 4.1,
  and the statement leaves dimension/nonzero assumptions, density-operator
  scope, scalar field, phase quotient, and extension-system convention implicit.
  Even a correct phase characterization does not solve Appendix A separation
  preservation (`RR-C013`).
- **Conservative repair:** State and prove a finite-dimensional complex theorem
  for the selected unitary action and state space, then construct the phase
  quotient explicitly. Use it only for claims whose required postulates have
  separately descended.
- **Downstream effects:** Section 4.2, the optional quantum instance, and any
  unconditional quantum corollary of the reverse constructor.
- **Status:** Partially resolved at the strongest checked nearby boundary.
  `Quantum.conjugation_eq_iff_unitaryPhase` proves, using mathlib's Hilbert-space
  operator algebra, that two unitary isometries induce the same conjugation
  automorphism on **all continuous endomorphisms** exactly when they differ by
  a unitary complex scalar. This is not yet Definition 4.1's contextual
  equivalence on density states and separated extensions. Density operators,
  the contextual converse, and quantum-specific separation preservation after
  the phase quotient remain deferred; no Appendix-A/reverse composition is
  claimed from this theorem alone.

## `RR-C019` — partial-product domain is underspecified and later treated as total-on-compatible

- **Classification:** Statement repair and hidden premise.
- **Source/evidence:** Axiom 3.12 at `L725–742` says `N_A ⊙ N_B` is defined
  *only if* the states are compatible, which makes compatibility necessary but
  not sufficient. Theorem 3.3 at `L745–759` immediately applies the product to
  an arbitrary compatible pair, and Theorem 3.5 at `L784–797` states
  commutativity without mentioning compatibility at all.
- **Defect:** The later theorems require a larger definedness domain than the
  axiom actually supplies. Because the operation is partial, Theorem 3.5 is not
  even typed until a compatibility premise is provided (and transported to the
  swapped system order).
- **Conservative repair:** Define the product on exactly the compatibility
  domain: a separation witness, two states, and a proof that they are projections
  of a common composite. State projection/reconstruction laws on that domain.
  Add compatibility explicitly to commutativity and construct the swapped
  compatibility proof before comparing outputs across `A ⊔ B = B ⊔ A`.
- **Downstream effects:** Theorems 3.3–3.7, Axiom 3.13's right-hand product,
  both reverse constructions, and every state-product quotient descent.
- **Status:** Repair accepted and compiled in Stage 3. `Compatible` includes
  separation and a common extension; `StateProduct.product` requires both the
  explicit separation proof and compatibility proof. `compatible_swap` and
  `StateProduct.product_comm` supply the missing swapped-domain evidence and
  explicit `sup_comm` transport. The binary product and projection theorems
  use no axioms; commutativity uses `[propext]` only. Stage 7 retains this
  exact domain. `compatible_iff_exists_globalRepresentative` identifies its
  source meaning, and `chosenCommonExtension` uses one documented unique-choice
  step only after `compatible_uniqueCommonExtension : ∃!` is proved.

## `RR-C020` — Theorem 5.13 proof applies the phenomenal map at the wrong state index

- **Classification:** Source typing/proof-display error.
- **Source/evidence:** Theorem 5.13, Markdown `L2178–2221`, visually confirmed
  on PDF printed page 47. The theorem compares the `A`-projection of
  `φ^B_ρ([W]^B)` with `φ^A_ρ(π_A([W]^B))`. Its proof correctly reaches
  `π_A(Wρ)`, but the penultimate displayed line writes `φ_ρ([W]^B)` with the
  target now implicitly `A`.
- **Defect:** `φ^A_ρ` has domain the constructed noumenal space at `A`, so it
  cannot be applied directly to `[W]^B`. Omitting the system superscript hides
  a genuine index mismatch.
- **Conservative repair:** After projector nesting yields `π_A(Wρ)`, identify
  this with `φ^A_ρ([W]^A)`, and only then use
  `π_A([W]^B) = [W]^A` to obtain
  `φ^A_ρ(π_A([W]^B))`.
- **Downstream effects:** Stage 7 phenomenalization/projector-compatibility
  proof and its source trace. No theorem statement or assumption needs to be
  strengthened.
- **Status:** PDF-confirmed and Lean-verified by
  `NoumenalState.phenomenalization_projectionCompatible`, which explicitly
  changes `[W]^B` to `[W]^A` before applying the `A`-indexed map.

## Final disposition summary

- Confirmed conversion/source defects and completed typed repairs:
  `RR-C001`–`RR-C012`, `RR-C014`, `RR-C017`, `RR-C019`, and `RR-C020`, with
  exact declarations recorded above and in the source-ledger realization log.
- Scoped finite repairs: `RR-C015` and `RR-C016` are proved for finite complex
  coordinate matrices with explicit nonempty outer factors; no unrestricted
  infinite-dimensional Appendix-C theorem is claimed.
- Open/unsupported: `RR-C013`, the unconditional claim that raw
  transformation separation survives the Appendix-A phenomenal quotient.
  Only the stronger modulo-equivalence premise is known to suffice.
- Partial: `RR-C018`. Equality of full operator-algebra conjugations is proved
  equivalent to a unitary scalar phase, but the contextual density-state
  theorem, phase-quotient separation, and full quantum instance remain
  deferred.

Thus every correction is classified at release as confirmed/repaired, scoped,
partial, or open; none is silently promoted through an axiom or summary claim.

## Resolution policy

To close an entry, record:

1. the exact Lean declaration and module;
2. focused and adjacent-consumer build commands and results;
3. `#print axioms` output for principal repaired theorems;
4. any changed hypothesis or downstream claim in `source-ledger.md` and
   `goal-1/0-plan.md`;
5. a source/PDF citation showing that the repair did not silently replace the
   original claim.

Textual corrections may be marked confirmed without a Lean proof, but no
mathematical gap, missing assumption, quotient descent, or constructor claim is
closed by editorial judgment alone.
