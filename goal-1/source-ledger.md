# RR2021 Source Ledger

This ledger inventories the mathematical content of Paul Raymond-Robichaud,
“The Equivalence of Local-Realistic and No-Signalling Theories,” arXiv
`1710.01380v2`. The canonical local text is
`raymond-robichaud-2021/raymond-robichaud-2021.md`; line numbers below refer to
that file. The supplied PDF was checked directly when typography, labels, or
formula structure were ambiguous. Corrections and downstream consequences live
in `goal-1/corrections.md`.

## Reading and status conventions

- Scope read closely: Sections 3–5 (`L269–2399`) and Appendices A–C
  (`L2419–2950`). The abstract, Sections 1–2, Section 6, and `deutsch-x.md`
  were also screened for mathematically operative or interpretative claims.
- `as stated` means the source statement is a coherent initial formalization
  candidate. It does **not** mean that Lean has verified it.
- `corrected` means the intended candidate is recorded only with a documented
  textual/type correction.
- `split` means one source item must become several definitions, hypotheses, or
  theorems so that assumptions remain visible.
- `additional assumptions` means the stated claim needs hypotheses not visible
  in the source statement.
- `partial` means only part of a bundled construction or proof is supplied.
- `unresolved` means a mathematical or well-definedness obligation remains open.
- `intentionally excluded` means the item is interpretative, metaphysical,
  sociological, empirical, or dependent on an external theory and is not a
  theorem of the abstract library.

The statuses are initial source dispositions. No item counts as proved until a
Lean declaration and its build/axiom evidence are linked here.

## Realized stage/module abbreviations

| Code | Intended owner |
|---|---|
| `S2/Sys` | Stage 2, `RR2021.Systems.Core`, `RR2021.Systems.Basic`, or `RR2021.Systems.Transport` |
| `S3/Dyn` | Stage 3, `RR2021.Dynamics.Core`, `Projection`, `StateProduct*`, `TransformationProduct*`, or `Locality` |
| `S4/Thy` | Stage 4, `RR2021.Theories.Core`, `LocalRealistic`, `NoSignalling`, `Postulates`, or `Basic` |
| `S5/Fwd` | Stage 5, `RR2021.Forward` |
| `S6/PQ` | Stage 6, `RR2021.Faithfulness.Phenomenal*` |
| `S6/NQ` | Stage 6, `RR2021.Faithfulness.Noumenal*` |
| `S7/RecT` | Stage 7, `RR2021.Reverse.Transitive` |
| `S8/RecG` | Stage 8, `RR2021.Reverse.General` |
| `S9/API` | Stage 9, `RR2021.Correspondence` and thin public APIs |
| `S10/Q` | Stage 10, `RR2021.Quantum` and `RR2021.Quantum.Audit` |
| `S11/Ex` | Stage 11, examples, countermodels, and audit leaves |
| `Docs` | Traceability/correction documentation only |

These codes originated as ownership targets and now name the realized module
families. Exact declarations and evidence appear in the realization log.

## Coverage summary

The numbered inventory contains 89 source-label occurrences: 40 in Section 3,
14 in Section 4, 23 in Section 5, 4 in Appendix A, 6 in Appendix B (including
the second, conflicting `Theorem B.2` label), and 2 in Appendix C. A further 45
material unnumbered constructions or dependency claims from those sections and
15 operative/excluded claims elsewhere are listed separately. Thus this version
contains 149 stable ledger entries.

## Section 3 — local-realistic theories

### Numbered items (40)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S3-D01` | Definition 3.1, `L295–320` | Systems form a Boolean lattice with global/empty systems, join, meet, and complement. | split | — | `S2/Sys` |
| `RR-S3-A01` | Axiom 3.1, `L325` | A local-realistic theory carries the system lattice. | as stated | `RR-S3-D01` | `S4/Thy` |
| `RR-S3-D02` | Definition 3.2, `L331` | `A` is a subsystem of `B` iff `A ⊓ B = A`. | as stated | `RR-S3-D01` | `S2/Sys` |
| `RR-S3-D03` | Definition 3.3, `L334–337` | Disjointness means meet is the empty system. | as stated | `RR-S3-D01` | `S2/Sys` |
| `RR-S3-D04` | Definition 3.4, `L340–346` | A composite of disjoint systems is their join, with commutative/associative notation. | split | `RR-S3-D01`, `RR-S3-D03` | `S2/Sys` |
| `RR-S3-A02` | Axiom 3.2, `L368–374` | Each system has a nonempty noumenal state space. | as stated | `RR-S3-A01` | `S4/Thy` |
| `RR-S3-A03` | Axiom 3.3, `L377–383` | Each system has a nonempty phenomenal state space. | as stated | `RR-S3-A01` | `S4/Thy` |
| `RR-S3-D05` | Definition 3.5, `L396–416` | Transformation monoid and right-to-left composition convention. | as stated | — | `S3/Dyn` |
| `RR-S3-D06` | Definition 3.6, `L422–425` | A transformation monoid is a group when every element has a two-sided inverse. | as stated | `RR-S3-D05` | `S3/Dyn` |
| `RR-S3-A04` | Axiom 3.4, `L431–440` | Each system has a transformation monoid. | as stated | `RR-S3-D05`, `RR-S3-A01` | `S4/Thy` |
| `RR-S3-D07` | Definition 3.7, `L446–452` | Left monoid action with `(UV)⋆s = U⋆(V⋆s)`. | as stated | `RR-S3-D05` | `S3/Dyn` |
| `RR-S3-A05` | Axiom 3.5, `L458–464` | Transformations act on noumenal states. | as stated | `RR-S3-A02`, `RR-S3-A04`, `RR-S3-D07` | `S4/Thy` |
| `RR-S3-A06` | Axiom 3.6, `L467–473` | Transformations act on phenomenal states. | as stated | `RR-S3-A03`, `RR-S3-A04`, `RR-S3-D07` | `S4/Thy` |
| `RR-S3-D08` | Definition 3.8, `L479` | An action is faithful when equality on every state implies equality of transformations. | as stated | `RR-S3-D07` | `S3/Dyn` |
| `RR-S3-A07` | Axiom 3.7, `L485–488` | Noumenal actions are faithful. | as stated | `RR-S3-A05`, `RR-S3-D08` | `S4/Thy` |
| `RR-S3-D09` | Definition 3.9, `L501–509` | A noumenal–phenomenal homomorphism is equivariant. | as stated | `RR-S3-A05`, `RR-S3-A06` | `S3/Dyn` |
| `RR-S3-D10` | Definition 3.10, `L512` | A noumenal–phenomenal epimorphism is a surjective equivariant map. | split | `RR-S3-D09` | `S3/Dyn` |
| `RR-S3-A08` | Axiom 3.8, `L515–521` | Each system has a noumenal–phenomenal epimorphism. | as stated | `RR-S3-D10` | `S4/Thy` |
| `RR-S3-A09` | Axiom 3.9, `L578–595` | Surjective noumenal projectors compose along subsystem chains. | split | `RR-S3-D02`, `RR-S3-A02` | `S3/Dyn` |
| `RR-S3-A10` | Axiom 3.10, `L604–610` | Phenomenal projectors satisfy the analogous surjectivity/composition laws. | corrected (`RR-C003`) | `RR-S3-D02`, `RR-S3-A03`, `RR-S3-A09` | `S3/Dyn` |
| `RR-S3-T01` | Theorem 3.1, `L627–654` | A noumenal self-projector is the identity. | as stated | `RR-S3-A09` | `S3/Dyn` |
| `RR-S3-T02` | Theorem 3.2, `L657–667` | A phenomenal self-projector is the identity. | as stated | `RR-S3-A10` | `S3/Dyn` |
| `RR-S3-A11` | Axiom 3.11, `L673–676` | Phenomenalization commutes with subsystem projection. | split | `RR-S3-A08`, `RR-S3-A09`, `RR-S3-A10` | `S4/Thy` |
| `RR-S3-D11` | Definition 3.11, `L716–720` | Two subsystem states are compatible iff they are projections of one composite state. | as stated | `RR-S3-D04`, `RR-S3-A09` | `S3/Dyn` |
| `RR-S3-A12` | Axiom 3.12, `L725–742` | A partial noumenal product reconstructs a composite from compatible projections. | corrected (`RR-C004`) | `RR-S3-D11`, `RR-S3-A09` | `S3/Dyn`, `S4/Thy` |
| `RR-S3-T03` | Theorem 3.3, `L745–759` | Projections of a compatible noumenal product recover its factors. | as stated | `RR-S3-D11`, `RR-S3-A12` | `S3/Dyn` |
| `RR-S3-T04` | Theorem 3.4, `L762–781` | Product equals a given composite iff the factors are its projections. | as stated | `RR-S3-T03`, `RR-S3-A12` | `S3/Dyn` |
| `RR-S3-T05` | Theorem 3.5, `L784–797` | Noumenal product is commutative with swapped system indices. | corrected (`RR-C019`) | `RR-S3-T03`, `RR-S3-A12`, `RR-S3-D04` | `S3/Dyn` |
| `RR-S3-L01` | Lemma 3.1, `L803–829` | A defined left-associated triple product has the stated three projections. | corrected (`RR-C005`) | `RR-S3-A09`, `RR-S3-T03` | `S3/Dyn` |
| `RR-S3-L02` | Lemma 3.2, `L832–838` | The analogous projection fact for a right-associated triple product. | corrected (`RR-C005`) | `RR-S3-A09`, `RR-S3-T03` | `S3/Dyn` |
| `RR-S3-L03` | Lemma 3.3, `L841–869` | The product of `A` and `B` projections of an `ABC` state is its `AB` projection. | as stated | `RR-S3-A09`, `RR-S3-A12` | `S3/Dyn` |
| `RR-S3-L04` | Lemma 3.4, `L872–903` | Both bracketings of the three projections reconstruct an `ABC` state. | unresolved | `RR-S3-L03`, `RR-S3-A12` | `S3/Dyn`, `S11/Ex` |
| `RR-S3-T06` | Theorem 3.6, `L906–912` | Definedness and value of the two triple-product bracketings agree. | unresolved | `RR-S3-L01`–`RR-S3-L04` | `S3/Dyn` |
| `RR-S3-T07` | Theorem 3.7, `L915–924` | A triple product equals a composite exactly when factors are its projections. | unresolved | `RR-S3-L01`, `RR-S3-L04`, `RR-S3-T06` | `S3/Dyn` |
| `RR-S3-A13` | Axiom 3.13, `L934–940` | Product transformations act componentwise on compatible product states. | as stated | `RR-S3-A07`, `RR-S3-A12` | `S3/Dyn`, `S4/Thy` |
| `RR-S3-T08` | Theorem 3.8, `L956–1005` | Product of transformations preserves composition componentwise. | as stated | `RR-S3-A07`, `RR-S3-A13` | `S3/Dyn` |
| `RR-S3-T09` | Theorem 3.9, `L1008–1035` | Product of identity transformations is the composite identity. | corrected (`RR-C008`) | `RR-S3-A07`, `RR-S3-A13` | `S3/Dyn` |
| `RR-S3-T10` | Theorem 3.10, `L1038–1077` | Transformation product is commutative under the `AB = BA` reindexing. | as stated | `RR-S3-T05`, `RR-S3-A07`, `RR-S3-A13` | `S3/Dyn` |
| `RR-S3-T11` | Theorem 3.11, `L1080–1136` | Transformation product is associative under composite-system reindexing. | as stated | `RR-S3-T06`, `RR-S3-A07`, `RR-S3-A13` | `S3/Dyn` |
| `RR-S3-T12` | Theorem 3.12, `L1159–1236` | Local-realistic data imply the remote phenomenal marginal is independent of the remote transformation. | as stated | `RR-S3-A08`, `RR-S3-A11`, `RR-S3-A12`, `RR-S3-A13` | `S5/Fwd` |

### Material unnumbered items (7)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S3-U01` | `L337–346` | Empty-system, commutative-composite, and associative-composite consequences of the Boolean lattice. | as stated | `RR-S3-D01`–`RR-S3-D04` | `S2/Sys` |
| `RR-S3-U02` | Abstract trace, `L691–706` | Define tracing out `B` as projection to `A`; this is notation, not a linear trace. | as stated | `RR-S3-A09`, `RR-S3-A10` | `S3/Dyn` |
| `RR-S3-U03` | `L781` | Every bipartite noumenal state has unique projected factors whose product is the state. | as stated | `RR-S3-T04` | `S3/Dyn` |
| `RR-S3-U04` | `L924` | Every tripartite noumenal state has unique projected factors. | corrected (`RR-C005`) | `RR-S3-T07` | `S3/Dyn` |
| `RR-S3-U05` | `L937–940` | Faithfulness makes transformation products unique and yields component projections after action. | split | `RR-S3-A07`, `RR-S3-A13`, `RR-S3-T03` | `S3/Dyn` |
| `RR-S3-U06` | Mathematical note, `L1146` | Without faithful action, product laws hold only modulo the action kernel. | as stated | `RR-S3-D08`, `RR-S3-A13` | `S6/NQ`, `S11/Ex` |
| `RR-S3-U07` | `L1236–1254` | State-level no-signalling implies the usual marginal-probability independence when observations/probabilities are supplied. | additional assumptions | `RR-S3-T12` plus an observation model | `S5/Fwd`, `S11/Ex` |

## Section 4 — no-signalling theories

### Numbered items (14)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S4-A01` | Axiom 4.1, `L1270` | A no-signalling theory carries the system lattice. | as stated | `RR-S3-D01` | `S4/Thy` |
| `RR-S4-A02` | Axiom 4.2, `L1273` | Each system has a nonempty phenomenal state space. | as stated | `RR-S4-A01` | `S4/Thy` |
| `RR-S4-A03` | Axiom 4.3, `L1279` | Each system has a transformation monoid. | as stated | `RR-S3-D05`, `RR-S4-A01` | `S4/Thy` |
| `RR-S4-A04` | Axiom 4.4, `L1282` | Transformations act on phenomenal states. | as stated | `RR-S3-D07`, `RR-S4-A02`, `RR-S4-A03` | `S4/Thy` |
| `RR-S4-A05` | Axiom 4.5, `L1285–1302` | Surjective phenomenal projectors compose along subsystem chains. | split | `RR-S3-D02`, `RR-S4-A02` | `S4/Thy` |
| `RR-S4-A06` | Axiom 4.6, `L1311–1345` | Transformation products satisfy no-signalling, associativity, composition, identity, and symmetry. | split | `RR-S4-A01`–`RR-S4-A05` | `S4/Thy` |
| `RR-S4-P01` | Postulate 4.1, `L1364–1375` | Separation/intersection law for transformations supported on overlapping complements. | as stated | `RR-S4-A06`, Boolean decompositions | `S4/Thy`, `S7/RecT` |
| `RR-S4-P02` | Postulate 4.2, `L1378–1381` | Each transformation monoid is a group. | as stated | `RR-S4-A03`, `RR-S3-D06` | `S4/Thy` |
| `RR-S4-T01` | Theorem 4.1, `L1387–1421` | Inverse of a transformation product is the product of inverses. | as stated | `RR-S4-A06`, `RR-S4-P02` | `S3/Dyn` |
| `RR-S4-D01` | Definition 4.1, `L1435–1446` | Phenomenal equivalence compares `U×I_B` and `V×I_B` on every extension state. | corrected (`RR-C007`) | `RR-S4-A06` | `S6/PQ` |
| `RR-S4-P03` | Postulate 4.3, `L1452–1458` | Phenomenal equivalence implies equality of transformations. | as stated | `RR-S4-D01` | `S4/Thy` |
| `RR-S4-T02` | Theorem 4.2, `L1464–1510` | Equality of noumenal actions implies phenomenal equivalence. | as stated | local-realistic axioms except `RR-S3-A07`; `RR-S4-D01` | `S6/NQ` |
| `RR-S4-T03` | Theorem 4.3, `L1516–1522` | Phenomenal faithfulness implies noumenal faithfulness. | as stated | `RR-S4-T02`, `RR-S4-P03` | `S6/NQ`, `S7/RecT` |
| `RR-S4-P04` | Postulate 4.4, `L1528` | The global phenomenal action is transitive. | as stated | `RR-S4-A04` | `S4/Thy`, `S7/RecT` |

### Material unnumbered items (6)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S4-U01` | `L1355` | Every local-realistic theory yields a no-signalling theory by forgetting noumenal data and using derived laws. | split | `RR-S3-T08`–`RR-S3-T12` | `S5/Fwd` |
| `RR-S4-U02` | `L1443` | Phenomenal equivalence is an equivalence relation. | as stated | `RR-S4-D01` | `S6/PQ` |
| `RR-S4-U03` | `L1522` | Phenomenal faithfulness is used only to recover noumenal faithfulness in the reverse construction. | unresolved | `RR-S4-T03`, all Stage 7 dependencies | `S7/RecT`, `S9/API` |
| `RR-S4-U04` | Quantum dictionary, `L1541–1559` | Density operators, unitary conjugation, partial trace, and tensor products instantiate the six no-signalling axioms. | additional assumptions | finite-dimensional quantum infrastructure | `S10/Q` |
| `RR-S4-U05` | `L1568` | Unitaries are phenomenally equivalent exactly up to phase, and the phenomenal quotient supplies faithfulness. | unresolved | `RR-S4-D01`, Appendix A, quantum action | `S10/Q` |
| `RR-S4-U06` | `L1571` | Restricting global phenomenal states to pure states makes the unitary action transitive. | additional assumptions | fixed nonzero Hilbert space; unit vectors/rays convention | `S10/Q` |

## Section 5 — reverse constructions

### Numbered items (23)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S5-D01` | Definition 5.1, `L1617–1624` | `W ∼_A W′` iff they differ by a transformation on the complement of `A`. | as stated | `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T01` | Theorem 5.1, `L1627–1712` | The fundamental relation is an equivalence relation. | as stated | `RR-S5-D01`, `RR-S4-P02` | `S7/RecT` |
| `RR-S5-D02` | Definition 5.2, `L1718–1730` | Fundamental equivalence class `[W]_A`. | corrected (`RR-C001`) | `RR-S5-T01` | `S7/RecT` |
| `RR-S5-D03` | Definition 5.3, `L1733–1744` | Noumenal states are fundamental classes of global transformations. | as stated | `RR-S5-D02` | `S7/RecT` |
| `RR-S5-D04` | Definition 5.4, `L1747–1759` | Project `[W]_B` to `[W]_A` when `A ≤ B`. | as stated | `RR-S5-D03` | `S7/RecT` |
| `RR-S5-T02` | Theorem 5.2, `L1762–1798` | Fundamental equivalence for `B` implies equivalence for subsystem `A`. | corrected (`RR-C009`) | `RR-S5-D01`, Boolean relative complement, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T03` | Theorem 5.3, `L1816–1822` | Constructed noumenal projectors are surjective. | as stated | `RR-S5-D03`, `RR-S5-D04` | `S7/RecT` |
| `RR-S5-T04` | Theorem 5.4, `L1825–1861` | Constructed projectors compose along subsystem chains. | as stated | `RR-S5-D04` | `S7/RecT` |
| `RR-S5-D05` | Definition 5.5, `L1864–1876` | Noumenal action is left multiplication by `U×I` on representatives. | as stated | `RR-S5-D03`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T05` | Theorem 5.5, `L1879–1900` | The constructed action is representative-independent. | as stated | `RR-S5-D01`, `RR-S5-D05`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T06` | Theorem 5.6, `L1912–1951` | The constructed noumenal action respects composition. | as stated | `RR-S5-D05`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T07` | Theorem 5.7, `L1954–1970` | The constructed noumenal action respects identity. | as stated | `RR-S5-D05`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-D06` | Definition 5.6, `L1979–1988` | Product compatible classes sharing a representative by `[W]_A⊙[W]_B=[W]_{AB}`. | as stated | `RR-S5-D03`, compatibility | `S7/RecT` |
| `RR-S5-T08` | Theorem 5.8, `L1991–1997` | Equivalence on both `A` and `B` implies equivalence on `AB`. | as stated | `RR-S4-P01`, `RR-S4-P02`, `RR-S5-D01` | `S7/RecT` |
| `RR-S5-T09` | Theorem 5.9, `L2003–2016` | Constructed product reconstructs every composite class. | as stated | `RR-S5-D04`, `RR-S5-D06` | `S7/RecT` |
| `RR-S5-T10` | Theorem 5.10, `L2022–2053` | Existing transformation product acts componentwise on constructed noumenal products. | as stated | `RR-S5-D05`, `RR-S5-D06`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-D07` | Definition 5.7, `L2056–2074` | For global state `ρ`, map `[W]_A` to phenomenal projection `π_A(Wρ)`. | as stated | `RR-S5-D03`, `RR-S4-A04`, `RR-S4-A05` | `S7/RecT` |
| `RR-S5-T11` | Theorem 5.11, `L2077–2101` | The phenomenal map is representative-independent. | as stated | `RR-S5-D01`, `RR-S4-A06` no-signalling | `S7/RecT` |
| `RR-S5-T12` | Theorem 5.12, `L2116–2172` | The phenomenal map is equivariant. | as stated | `RR-S5-D05`, `RR-S5-D07`, `RR-S4-A06` | `S7/RecT` |
| `RR-S5-T13` | Theorem 5.13, `L2178–2221` | The phenomenal map commutes with projectors. | corrected (`RR-C020`) | `RR-S5-D04`, `RR-S5-D07`, `RR-S4-A05` | `S7/RecT` |
| `RR-S5-T14` | Theorem 5.14, `L2227–2255` | Global transitivity makes every `φ^A_ρ` surjective, hence an epimorphism. | as stated | `RR-S4-A05`, `RR-S4-P04`, `RR-S5-T12` | `S7/RecT` |
| `RR-S5-T15` | Theorem 5.15, `L2330–2367` | The enlarged-state product reconstructs every enlarged composite state. | partial | `RR-S5-T09`, enlarged definitions | `S8/RecG` |
| `RR-S5-T16` | Theorem 5.16, `L2373–2393` | The enlarged-state phenomenal map is surjective without global transitivity. | as stated | `RR-S4-A05`, enlarged phenomenal map | `S8/RecG` |

### Material unnumbered items (13)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-S5-U01` | `L1578–1614` | Reverse-construction input/output inventory: no-signalling plus separation, invertibility, and phenomenal faithfulness; transitivity only for the first epimorphism. | split | Section 4 axioms/postulates | `S7/RecT`, `S8/RecG` |
| `RR-S5-U02` | `L1614` | Global transitivity is claimed to occur only in Theorem 5.14. | unresolved | complete dependency audit | `S7/RecT`, `S9/API` |
| `RR-S5-U03` | `L1712` | Invertibility is claimed to occur only in symmetry of `∼_A` and product well-definedness. | unresolved | complete dependency audit | `S7/RecT`, `S9/API` |
| `RR-S5-U04` | `L1976` | Compatibility of constructed `A`/`B` classes is equivalent to having a common global representative. | as stated | `RR-S5-D03`, `RR-S3-D11` | `S7/RecT` |
| `RR-S5-U05` | `L2255` | Fixing a global state completes the transitive local-realistic model construction. | partial | `RR-S5-T01`–`RR-S5-T14`, `RR-S4-T03` | `S7/RecT` |
| `RR-S5-U06` | `L2262–2274` | Enlarged noumenal states are pairs `([W]_A,ρ)` with a global phenomenal-state label. | as stated | `RR-S5-D03`, `RR-S4-A02` | `S8/RecG` |
| `RR-S5-U07` | `L2277–2286` | Enlarged projection changes only the class component. | as stated | `RR-S5-D04`, `RR-S5-U06` | `S8/RecG` |
| `RR-S5-U08` | `L2289–2303` | Enlarged product is defined only for equal labels and compatible class components. | as stated | `RR-S5-D06`, `RR-S5-U06` | `S8/RecG` |
| `RR-S5-U09` | `L2306–2313` | Enlarged action changes only the class component. | as stated | `RR-S5-D05`, `RR-S5-U06` | `S8/RecG` |
| `RR-S5-U10` | `L2316–2324` | Enlarged phenomenal map evaluates `φ^A_ρ` on the class component. | corrected (`RR-C010`) | `RR-S5-D07`, `RR-S5-U06` | `S8/RecG` |
| `RR-S5-U11` | `L2327` | All enlarged definitions are well-defined and satisfy the local-realistic axioms. | unresolved | every Stage 8 descent/coherence obligation | `S8/RecG`, `S11/Ex` |
| `RR-S5-U12` | `L2370` | The enlarged phenomenal map is asserted “obviously” equivariant. | unresolved | `RR-S5-T12`, `RR-S5-U09`, `RR-S5-U10` | `S8/RecG` |
| `RR-S5-U13` | `L2396` | The enlarged construction completes the general reverse model without transitivity. | unresolved | `RR-S5-T15`, `RR-S5-T16`, `RR-S5-U11`, `RR-S5-U12` | `S8/RecG`, `S9/API` |

## Appendix A — phenomenal faithfulness

### Numbered items (4)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AA-T01` | Theorem A.1, `L2428–2464` | Phenomenal equivalence implies equal action on local phenomenal states. | as stated | `RR-S4-D01`, `RR-S4-A05`, `RR-S4-A06` | `S6/PQ` |
| `RR-AA-T02` | Theorem A.2, `L2470–2506` | Phenomenal equivalence is a congruence for composition. | corrected (`RR-C012`) | `RR-S4-D01`, `RR-S4-A06` | `S6/PQ` |
| `RR-AA-T03` | Theorem A.3, `L2512–2540` | Phenomenal equivalence is a congruence for transformation products. | as stated | `RR-S4-D01`, `RR-S4-A06` | `S6/PQ` |
| `RR-AA-T04` | Theorem A.4, `L2605–2636` | The quotient transformation product satisfies no-signalling. | as stated | `RR-AA-T01`–`RR-AA-T03`, `RR-S4-A06` | `S6/PQ` |

### Material unnumbered items (8)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AA-U01` | `L2422` | Quotienting phenomenal equivalence is claimed to make any no-signalling theory phenomenally faithful. | partial | all Appendix A items | `S6/PQ` |
| `RR-AA-U02` | `L2561–2567` | Define phenomenal equivalence classes `[U]_A`. | as stated | `RR-S4-U02` | `S6/PQ` |
| `RR-AA-U03` | `L2570–2578` | Define new transformations as phenomenal equivalence classes. | as stated | `RR-AA-U02` | `S6/PQ` |
| `RR-AA-U04` | `L2581–2584` | Quotient composition is well-defined and forms a monoid. | partial | `RR-AA-T02` | `S6/PQ` |
| `RR-AA-U05` | `L2587–2596` | Quotient phenomenal action is well-defined, is an action, and is faithful. | partial | `RR-AA-T01`, `RR-S4-U02` | `S6/PQ` |
| `RR-AA-U06` | `L2599–2602` | Quotient product is well-defined and is asserted to satisfy all five Axiom 4.6 laws. | partial | `RR-AA-T03`, `RR-AA-T04` | `S6/PQ` |
| `RR-AA-U07` | `L2639` | Invertibility, separation, and global transitivity are all asserted to survive the quotient. | unresolved | quotient congruences; quotient-stable separation | `S6/PQ`, `S11/Ex` |
| `RR-AA-U08` | `L2642` | The quotient construction yields a phenomenally faithful no-signalling theory. | partial | `RR-AA-U03`–`RR-AA-U07` | `S6/PQ` |

## Appendix B — noumenal faithfulness

### Numbered-label occurrences (6)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AB-D01` | Definition B.1, `L2652–2655` | Noumenal equivalence is pointwise equality of the noumenal action. | as stated | local-realistic action without faithfulness | `S6/NQ` |
| `RR-AB-T01` | Theorem B.1, `L2658–2666` | Noumenal equivalence implies equal phenomenal action. | as stated | `RR-S4-T02`, `RR-AA-T01` | `S6/NQ` |
| `RR-AB-T02a` | first Theorem B.2, `L2669–2695` | Noumenal equivalence is a congruence for composition. | as stated | `RR-AB-D01` | `S6/NQ` |
| `RR-AB-T03` | Theorem B.3, `L2698–2719` | Noumenal equivalence is a congruence for transformation products. | as stated | `RR-AB-D01`, `RR-S3-A12`, `RR-S3-A13` | `S6/NQ` |
| `RR-AB-T02b` | second Theorem B.2, `L2775–2778` | Quotient composition is well-defined and the quotient transformations form a monoid. | corrected (`RR-C014`) | `RR-AB-T02a` | `S6/NQ` |
| `RR-AB-T04` | Theorem B.4, `L2811–2834` | Quotient transformation products act componentwise on noumenal product states. | as stated | `RR-AB-T03`, quotient action/product | `S6/NQ` |

### Material unnumbered items (9)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AB-U01` | `L2655` | Noumenal equivalence is an equivalence relation and refines phenomenal equivalence. | partial | `RR-AB-D01`, `RR-S4-T02` | `S6/NQ` |
| `RR-AB-U02` | `L2722–2749` | The quotient keeps systems, states, projectors, noumenal product, and phenomenal map while replacing transformations/actions/products. | split | Appendix B construction | `S6/NQ` |
| `RR-AB-U03` | `L2752–2758` | Define noumenal equivalence classes `[U]_A`. | as stated | `RR-AB-U01` | `S6/NQ` |
| `RR-AB-U04` | `L2761–2769` | Define new transformations as noumenal equivalence classes. | as stated | `RR-AB-U03` | `S6/NQ` |
| `RR-AB-U05` | `L2772–2778` | Define quotient composition and identity. | partial | `RR-AB-T02a` | `S6/NQ` |
| `RR-AB-U06` | `L2781–2790` | Quotient noumenal action is well-defined and faithful. | corrected (`RR-C014`) | `RR-AB-D01`, `RR-AB-U04` | `S6/NQ` |
| `RR-AB-U07` | `L2793–2802` | Quotient phenomenal action is well-defined. | partial | `RR-AB-T01` | `S6/NQ` |
| `RR-AB-U08` | `L2805–2808` | Quotient transformation product is well-defined. | as stated | `RR-AB-T03` | `S6/NQ` |
| `RR-AB-U09` | `L2837` | All local-realistic axioms survive and the quotient yields faithful noumenal action. | unresolved | every Appendix B descent law | `S6/NQ`, `S11/Ex` |

## Appendix C — quantum separation

### Numbered items (2)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AC-D01` | Definition C.1, `L2858–2868` | Product of endomorphism-space bases is the set of simple tensor products. | additional assumptions | tensor/endomorphism identifications | `S10/Q` |
| `RR-AC-T01` | Theorem C.1, `L2874–2949` | If `V_AB⊗I_C = I_A⊗V_BC`, both factor through a unitary on `B`. | additional assumptions | `RR-AC-D01`; finite-dimensional/nonzero factors; unitarity reflection | `S10/Q` |

### Material unnumbered items (2)

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-AC-U01` | `L2847–2855` | Endomorphisms `L(V)` form a vector space. | as stated | field and vector space | `S10/Q` |
| `RR-AC-U02` | `L2868` | The product basis is a basis of `L(V₁⊗V₂)`. | additional assumptions | finite-dimensional algebraic tensor identification | `S10/Q`, `RR2021.Quantum.Audit` |

## Operative claims outside Sections 3–5 and Appendices A–C (15)

These entries prevent introductory, concluding, or later-added prose from being
mistaken for already formalized results.

| Stable ID | Source | Content | Initial status | Dependencies | Stage/module |
|---|---|---|---|---|---|
| `RR-OUT-A01` | Abstract, `L19–23` | Every local-realistic theory is no-signalling; every invertible-dynamics no-signalling theory has a local-realistic model; quantum theory is an instance. | split | forward theorem, reverse hypotheses/quotients, quantum audit | `S5/Fwd`, `S8/RecG`, `S9/API`, `S10/Q` |
| `RR-OUT-I01` | Introduction, `L48` | The source axioms describe all local-realistic and all no-signalling theories. | unresolved | adequacy/completeness notion not defined | `Docs`, `S9/API` |
| `RR-OUT-I02` | Introduction, `L51–57` | Claims about interpretations, local hidden variables, non-local boxes, and earlier quantum models. | intentionally excluded | external literature and interpretative premises | `Docs` |
| `RR-OUT-I03` | Introduction, `L60–63` | Forward implication and qualified reverse model-existence claim. | split | Sections 3–5 | `S5/Fwd`, `S7/RecT`, `S8/RecG`, `S9/API` |
| `RR-OUT-I04` | Introduction, `L63–69` | The reverse construction applies to unitary quantum theory and extends earlier work. | unresolved | Appendix C, phase quotient, full quantum instance | `S10/Q` |
| `RR-OUT-C01` | Section 2.1, `L79–101` | Realism, noumenal/phenomenal interpretation, perceptibility, and laws-of-Nature prose. | intentionally excluded | metaphysical/interpretative premises | `Docs` |
| `RR-OUT-C02` | Section 2.1, `L101–139` | Informal surjective noumenal-to-phenomenal map and noumenal action. | split | later Axioms 3.2, 3.3, 3.5, 3.8 | `S3/Dyn`, `S4/Thy` |
| `RR-OUT-C03` | Section 2.2, `L149–204` | A phenomenal action is argued to descend from noumenal dynamics and the map is equivariant. | additional assumptions | invariance of phenomenal fibers under every transformation | `S3/Dyn`, `S6/NQ` |
| `RR-OUT-C04` | Section 2.3, `L208–212` | Leibniz injectivity would collapse the two state levels; no such quantum model exists. | intentionally excluded | external result [18], precise quantum/model scope absent | `Docs`, optional `S10/Q` audit |
| `RR-OUT-C05` | Section 2.4, `L215–248` | Eight informal principles motivate systems, decomposition, states, observables, evolution, and locality. | split | formal axioms in Section 3 | `Docs`, `S2/Sys`–`S4/Thy` |
| `RR-OUT-C06` | Section 2.5, `L252–265` | Separated operations commute and affect only their own subsystem state. | split | transformation product/action/locality laws | `S3/Dyn`, `S4/Thy` |
| `RR-OUT-Z01` | Conclusion, `L2403` | The headline “invertible dynamics” reverse result omits the still-used separation hypothesis and quotient caveats. | corrected (`RR-C017`) | `RR-AA-U07`, `RR-S5-U13` | `S9/API`, `Docs` |
| `RR-OUT-Z02` | Conclusion, `L2406` | Removing invertibility is conjectural/speculative future work. | intentionally excluded | no theorem supplied | `Docs` |
| `RR-OUT-Z03` | Conclusion, `L2409–2415` | Model existence is said to establish physical locality and answer a metaphysical question. | intentionally excluded | interpretative premises | `Docs` |
| `RR-OUT-DX01` | `deutsch-x.md:L16–32,L52` | Social endorsement and the summary “any theory with reversible dynamics.” | corrected (`RR-C017`) | source theorem also needs no-signalling and an audited separation/faithfulness route | `Docs`, `S9/API` |

## Interpretative exclusions versus unresolved mathematics

### Intentionally excluded

- Metaphysical definitions of realism, appearance, reality, observation, and
  locality as a property of a physical theory: `RR-OUT-C01`, `RR-OUT-Z03`.
- Sociological endorsement, patronage, priority, and claims that other research
  is obsolete: the nonmathematical parts of `RR-OUT-DX01`.
- Comparisons with local-hidden-variable interpretations and non-local boxes
  unless a later, separately scoped formal example is requested: `RR-OUT-I02`.
- The cited no-go result for a quantum model satisfying Leibniz’s principle,
  absent a precise imported statement: `RR-OUT-C04`.
- The conjectural removal of invertibility has no supplied theorem:
  `RR-OUT-Z02`.

### Unresolved mathematics or formalization obligations

- The unconditional Appendix-A separation-preservation sentence remains
  unresolved as stated (`RR-AA-U07`); Stage 6 proves the exact conditional
  result from separation modulo contextual phenomenal equivalence instead.
- The full quantum operational claims `RR-S4-U04`–`RR-S4-U06` still need
  density states, partial trace, coherent subsystem tensor factorizations, the
  contextual phase theorem, and pure-state transitivity. Stage 10 verifies the
  corrected finite-matrix Appendix-C core (`RR-AC-D01`, `RR-AC-T01`, and
  `RR-AC-U02`) but makes no infinite-dimensional extension.
- Any unconditional phrase “all no-signalling theories with invertible
  dynamics”: `RR-OUT-A01`, `RR-OUT-Z01`, and `RR-OUT-DX01` remain split or
  corrected because the verified general route still requires raw
  transformation separation and its no-faithfulness output changes the
  transformation family.
- The “all theories” adequacy/completeness claim has no mathematical semantics
  or declaration (`RR-OUT-I01`).
- The probability-level consequence `RR-S3-U07` needs an observation and
  probability model not present in the abstract library.

## Final traceability policy

The inventory tables above preserve their initial source dispositions and are
not rewritten retroactively. Current proof/deferral status is recorded in the
append-only realization log below, with exact Lean declarations, build/axiom
evidence, and final disposition rows. Stable IDs are never recycled even when
source labels are corrected or declarations are split.

## Lean realization log

This append-only log records checked realizations without rewriting the initial
source-disposition tables above.

### Stage 2 — systems (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S3-D01` | Standard mathlib `BooleanAlgebra`; `RR2021.Systems.emptySystem`, `globalSystem`, `complement` in `Systems.Core` | Carrier choice matches the source's explicit Boolean lattice; operation wrappers compile without paper state assumptions. |
| `RR-S3-D02` | `Subsystem`, `subsystem_iff_inf_eq`, `subsystem_iff_sup_eq`, `empty_subsystem`, `subsystem_global`, `left_subsystem_composite`, `right_subsystem_composite` | Proved under `LE`, semilattice, or bounded-order hypotheses no stronger than each signature displays. |
| `RR-S3-D03` | `Separated`, `separated_iff_inf_eq_bot`, symmetry and empty/global lemmas | Implemented with mathlib `Disjoint`; the source meet-bottom formulation is proved equivalent under `SemilatticeInf`/`OrderBot`. |
| `RR-S3-D04`, `RR-S3-U01` | `Composite`, `composite_comm`, `composite_assoc`, empty/global lemmas, `composite_separated_iff`, `separated_composite_iff` | Join is unbundled from the separation witness; disjoint-join regrouping correctly exposes `DistribLattice`, while plain commutativity/associativity needs only `SemilatticeSup`. |
| `RR-S5-T02`, `RR-C009` (system-algebra portion only) | `relativeComplement`, `relativeComplement_decomposition_typed`, `right_composite_complement`, `left_composite_complement` in `Systems.Basic`; `relativeComplementTopPathViaB`, `relativeComplementTopPathViaA`, `reindexRelativeComplement_top_coherent` in `Systems.Transport` | Proves `C=Aᶜ⊓B`, all three pairwise separation facts needed by the typed product, `A⊔C=B`, `C⊔Bᶜ=Aᶜ`, and equality of the two explicit transports to `⊤`. Stage 7 subsequently completed the transformation-product/descent theorem. |
| Section 3 iterated-composite uses and Theorems 3.10–3.11 (transport infrastructure only) | `reindex`, identity/composition/inverse laws, `reindexSupComm_twice`, `reindexSupAssoc_inverse`, and `reindexSupAssoc_pentagon` | Named coherence layer proved; no state/product theorem is claimed at this stage. |

Focused `Systems.Core`/`Basic`/`Transport`, finite `Systems.Examples`, adjacent
API/audit/root, and full builds passed. `Systems.Audit` records exact signatures
and axiom footprints; the Stage 2 command transcript is in `goal-1/2-SYSTEMS.md`.

### Stage 3 — indexed dynamics (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S3-D05`, `RR-S3-D06`, `RR-S3-D07` | `IndexedMonoid`, `IndexedGroup`, `IndexedMulAction`, `one_act`, and `mul_act` in `Dynamics.Core` | Standard mathlib `Monoid`, optional `Group`, and `MulAction` layers compile. `Dynamics.Examples.reversed_action_order_is_wrong` uses noncommuting permutations to fix the source's right-to-left composition convention. |
| `RR-S3-D08`–`RR-S3-D10` | `ActionEffective`; function-only `IndexedMap` with separate `Equivariant`, `Surjective`, and `Injective` predicates in `Dynamics.Map` | The map properties are not bundled or inferred from one another. Theory-specific noumenal/phenomenal carriers and epimorphisms remain Stage 4 fields. |
| `RR-S3-A09`, `RR-S3-A10`, `RR-S3-T01`, `RR-S3-T02`, `RR-S3-U02` (generic infrastructure) | `ProjectorFamily`, separate `ProjectorFamily.Surjective`, derived `project_self`, composite projection helpers, and named commutative/associative reindex lemmas in `Dynamics.Projection` | Projector identity is derived from nesting plus explicit surjectivity and has no axiom dependencies. Distinct noumenal and phenomenal projector instances remain Stage 4 work. |
| `RR-S3-D11`, `RR-S3-A12`, `RR-S3-T03`, `RR-S3-T04`, `RR-S3-U03`, `RR-C004`, `RR-C019` | `Compatible`, `canonicalCompatibility`, minimal `StateProduct`, `product_eq_common_extension`, `project_left`, `project_right`, `eq_of_projections`, and `product_eq_iff_projections` in `Dynamics.StateProduct` | The product exists exactly on the explicit separated compatibility domain; there is no incompatible-input output. Compatibility witnesses are eliminated only into proofs, while the structure field supplies product data. These binary results have no axiom dependencies. |
| `RR-S3-T05`, `RR-S3-L01`–`RR-S3-L04`, `RR-S3-T06`, `RR-S3-T07`, `RR-S3-U04`, `RR-C005`, `RR-C006`, `RR-C019` | `compatible_swap`, `StateProduct.product_comm`, `LeftDefined`, `RightDefined`, both definedness conversions, `leftDefined_iff_rightDefined`, `product_assoc`, and `leftNestedProduct_eq_iff_direct_projections` in `Dynamics.StateProductCoherence` | The corrected proof constructs both nested compatibility witnesses from actual common extensions before comparing products, so it does not cite a conclusion as its own definedness premise. Pairwise separation and `sup_comm`/`sup_assoc` transports are explicit. The transport-sensitive results audit with `[propext]` only. |
| `RR-S3-A13`, `RR-S3-U05` | Raw `TransformationProduct`; optional `Multiplicative`, `Unital`, `Symmetric`, and `Associative`; `Locality.mapCompatible` and `Locality.act_product`; derived marginal and remote-unchanged lemmas | Axiom 3.13's hidden compatibility-preservation obligation is explicit. Raw transformation products do not contain the four later algebra laws, and locality alone yields the component marginal equations without faithfulness. |
| `RR-S3-T08`–`RR-S3-T11`, `RR-C008` | `TransformationProduct.multiplicative_of_locality`, `unital_of_locality`, `symmetric_of_locality`, and `associative_of_locality` in `Dynamics.TransformationProductDerived` | Each law is derived from `Locality` plus explicit `ActionEffective`; no group assumption is used. Multiplication and identity have no axiom dependencies; symmetry and associativity use `[propext]` for indexed equality transport. The trivial complete model in `Dynamics.Examples` instantiates all four laws. |

Focused dynamics builds, concrete examples, adjacent API/audit/root consumers,
and the full pinned build passed. `Dynamics.Audit` records the exact public
signatures and axiom footprints; the Stage 3 command transcript and boundary
scan are in `goal-1/3-DYNAMICS.md`.

### Stage 4 — modular theory structures (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S3-A01`, `RR-S3-A04`–`RR-S3-A06` | Visible `[BooleanAlgebra System]`, `IndexedMonoid`, and two `IndexedMulAction` parameters of `LocalRealisticCore` | The shared system, transformation, and action data are explicit structure parameters rather than hidden fields or reverse assumptions. |
| `RR-S3-A02`, `RR-S3-A03` | `LocalRealisticCore.noumenalNonempty`; derived `phenomenalNonempty` | Only noumenal nonemptiness is stored. The phenomenal result is derived constructively through the phenomenalization map and uses no axioms or selected default. |
| `RR-S3-A07` | `NoumenallyFaithful`; the sole added field `LocalRealisticTheory.noumenalActionFaithful` | `LocalRealisticCore`/`LocalRealisticWithoutFaithfulness` deliberately omit Axiom 3.7 for Theorems 4.2--4.3 and Appendix B. The full source-facing structure adds exactly action effectivity. |
| `RR-S3-A08` | `phenomenalization` plus separate `phenomenalizationEquivariant` and `phenomenalizationSurjective` fields | Definition 3.9 and Definition 3.10 remain separate properties of a function-only `IndexedMap`. |
| `RR-S3-A09`, `RR-S3-A10`, `RR-S3-A11` | Separate noumenal/phenomenal `ProjectorFamily` fields, noumenal surjectivity, `phenomenalizationProjectionCompatible`; derived `phenomenalProjectorsSurjective`, `noumenalProjectSelf`, and `phenomenalProjectSelf` | Phenomenal projector surjectivity is derived from map surjectivity, noumenal projector surjectivity, and projector compatibility, so Axiom 3.10 is not redundantly stored. |
| `RR-S3-A12`, `RR-S3-A13`, `RR-S3-U05` | `noumenalProduct`, `transformationProducts`, and `locality` fields of `LocalRealisticCore`; `LocalRealisticTheory.transformationProduct_unique` | The corrected compatibility-indexed state product remains noumenal-only. Locality includes compatibility preservation. Full action effectivity proves the raw transformation product satisfying Axiom 3.13 is unique. |
| `RR-S3-T08`–`RR-S3-T11` | Theory-facing `productMultiplicative`, `productUnital`, `productSymmetric`, and `productAssociative` | These are derived from the full local-realistic structure and are not duplicated as fields; the pre-faithful core cannot claim them. The corrected Stage 3 Theorems 3.1--3.7 remain generic reusable results. |
| `RR-S4-A01`–`RR-S4-A05` | Visible Boolean/monoid/action parameters and `PhenomenalTheory.stateNonempty`, `projectors`, `projectorsSurjective` | This phenomenal-only core contains no noumenal carrier, phenomenal product, locality, faithfulness, group, separation, or transitivity assumption. |
| `RR-S4-A06` | `NoSignallingAxiom`; `NoSignallingTheory.transformationProducts`, `noSignalling`, `productMultiplicative`, `productUnital`, `productSymmetric`, and `productAssociative`; derived `noSignallingRight` | The left marginal is a standalone proposition quantified over separated systems, both transformations, and every composite phenomenal state. Symmetry derives the right marginal through explicit reindexing. The four product laws are fields here because Section 4 assumes them. |
| `RR-S4-P01` | `NoSignallingTheory.TransformationSeparation` and named `swapFirstTwoPath` | The three pairwise separation witnesses and both permutation/associativity transports hidden by the source's `ABC` notation are explicit. The predicate is not a `NoSignallingTheory` field. |
| `RR-S4-P02`, `RR-S4-T01` | `InvertibleDynamics`, `NoSignallingTheory.productOfInverses`, and `productInvertible` | Invertibility is relative to the existing indexed monoid operations and chooses no global inverse function. Products of component inverse witnesses are proved two-sided inverses using only multiplicativity and unitality. |
| `RR-S4-D01`, `RR-S4-P03`, `RR-C007` | `NoSignallingTheory.PhenomenallyEquivalent` and separate `PhenomenallyFaithful` | The unused remote-transformation quantifier is removed, but equivalence remains contextual over every separated identity extension and composite state; it is not conflated with local `ActionEffective`. Stage 6 subsequently completed the setoid and quotient descent. |
| `RR-S4-P04` | separate `NoSignallingTheory.GloballyTransitive` | Reachability is quantified only on the global phenomenal state space and is absent from the base no-signalling structure. |

Focused structure/proof builds, finite/trivial constructors, adjacent
API/audit/root consumers, and the full pinned build passed. `Theories.Audit`
prints the four constructors so the field boundary is mechanically visible;
the Stage 4 transcript and source matrix are in `goal-1/4-THEORIES.md`.

### Stage 5 — forward no-signalling construction (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S3-T12` | `LocalRealisticCore.noSignallingAxiom` in `Forward.Core` | Proved for the pre-faithful core. For an arbitrary phenomenal composite state, the proof eliminates phenomenalization surjectivity only inside the equality proof, crosses the composite action by equivariance, crosses the projector by Axiom 3.11 compatibility, applies the arbitrary-whole noumenal locality marginal, and crosses back. No Axiom 3.7 or reverse assumption is consumed. |
| `RR-S4-U01` | `LocalRealisticCore.toPhenomenalTheory` and `LocalRealisticTheory.toNoSignallingTheory` | The first forgets noumenal data while using the derived phenomenal nonemptiness/projector surjectivity. The second reuses the same phenomenal states, transformations, projectors, and transformation product, filling Axiom 4.6 from the core marginal theorem plus the four locality/effectivity-derived product laws. |
| `RR-OUT-A01`, `RR-OUT-I03` (forward part only) | `LocalRealisticTheory.toNoSignallingTheory` | The forward implication is now a checked structure constructor. This does not establish either reverse direction, faithfulness quotient, or quantum claim contained in the same split source summaries. |

`Forward.Core` and `Forward.Construction` have a transitive import graph that
does not reach `Theories.Postulates`; reverse-only predicates and Theorem 4.1
were moved to that separate leaf after scoped review. A non-effective
natural-number example exercises the core theorem, while a faithful singleton
example exercises the complete constructor. Focused, adjacent, and full build
evidence plus the axiom/import audit are recorded in `goal-1/5-FORWARD.md`.

### Stage 6 — faithfulness quotients (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-AA-T01`, `RR-AA-U02`–`RR-AA-U05` | `NoSignallingTheory.phenomenalSetoid`, `phenomenallyEquivalent_action_eq`, corrected `phenomenallyEquivalent_mul`, `phenomenalCon`, `PhenomenalTransformation`, and its descended indexed monoid/action in `Faithfulness.PhenomenalCore` | Contextual phenomenal equivalence is proved reflexive, symmetric, and transitive. Theorem A.1 justifies action descent. Corrected A.2 pairs corresponding outer/inner representatives (`RR-C012`). The quotient deliberately makes no unsupported local `ActionEffective` claim. |
| `RR-AA-T03` | `phenomenallyEquivalent_product_one`, `phenomenallyEquivalent_one_product`, and `phenomenallyEquivalent_product` in `Faithfulness.PhenomenalProduct` | Theorem A.3 is proved through explicit associativity, symmetry, identity, and system-index transports. This is the named representative-independence theorem for the quotient product. |
| `RR-AA-T04`, `RR-AA-U01`, `RR-AA-U06`, `RR-AA-U08` | `phenomenalTransformationProduct`, the five separate `phenomenalQuotient_*` descent laws, `phenomenalQuotientTheory`, and `phenomenalQuotientTheory_phenomenallyFaithful` | Appendix A's no-signalling constructor and contextual faithfulness conclusion compile. Phenomenal states/projectors remain unchanged; quotient induction, never representative selection, proves all laws. |
| `RR-AA-U07`, `RR-C013` | `phenomenalQuotient_invertibleDynamics`, `phenomenalQuotient_globallyTransitive_iff`, `TransformationSeparationModuloPhenomenalEquivalence`, and conditional `phenomenalQuotient_transformationSeparation` | Invertibility descends and global transitivity is preserved/reflected. Raw separation is not claimed to descend. A faithful raw theory plus raw separation implies the stronger modulo premise, and only that premise yields quotient separation. The paper's unconditional sentence remains a documented gap. |
| `RR-AB-D01`, `RR-AB-T02a`, `RR-AB-T02b`, `RR-AB-U03`–`RR-AB-U06`, `RR-C014` | `NoumenallyEquivalent`, `noumenalActionSetoid`, `noumenalActionCon`, `NoumenalQuotientTransformation`, quotient indexed monoid/noumenal action, and `quotientNoumenalActionEffective` in `Faithfulness.NoumenalCore` | Definition B.1 is an explicit setoid and monoid congruence. The duplicate printed B.2 labels remain separate ledger items. The descended action is faithful by `Con.eq` and quotient induction. |
| `RR-S4-T02`, `RR-S4-T03`, `RR-AB-T01`, `RR-AB-U01`, `RR-AB-U07` | `noumenallyEquivalent_phenomenal_smul` plus `noumenallyEquivalent_contextuallyPhenomenallyEquivalent`, source-facing full-theory bridge, and `noumenallyFaithful_of_contextualPhenomenalFaithfulness` | Surjective equivariance proves local phenomenal-action congruence; product congruence upgrades it to the full contextual relation. Theorem 4.3 is stated noncircularly for a pre-faithful core with contextual phenomenal faithfulness. |
| `RR-AB-T03`, `RR-AB-T04`, `RR-AB-U02`, `RR-AB-U08`, `RR-AB-U09`, `RR-C017` (Appendix-B step) | `noumenallyEquivalent_transformationProduct`, `quotientTransformationProducts`, `quotientLocality`, theory-tagged `LocalRealisticCore.NoumenalFaithfulTransformation`, and `LocalRealisticCore.toNoumenallyFaithfulQuotient` | B.3 uses locality marginals and honest state-product projection uniqueness for arbitrary composite states. B.4/locality descends without totalizing the partial state product. The constructor changes only transformations and their operations and returns a directly consumable full `LocalRealisticTheory` from `LocalRealisticCore`. Stages 7 and 8 verify the transitive and general pre-faithful routes before this Appendix-B step. |

`Faithfulness.Examples` non-vacuously proves raw `1 ≠ 2` while both the
noumenal and phenomenal quotients identify their classes in the natural-number
trivial-action model. It also checks ordinary downstream projections and
derived product laws on the theory-tagged Appendix B output. Focused,
adjacent, audit, scan, and full-build evidence is recorded in
`goal-1/6-FAITHFUL.md`.

### Stage 7 — transitive reverse construction (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S5-D01`–`RR-S5-D03`, `RR-S5-T01`, `RR-C001` | `Reverse.extendSystem`, `extendComplement`; `Transitive.FundamentallyEquivalent`, `fundamentalSetoid`, `NoumenalState`, and `NoumenalState.mk` | Both local/global support transports are explicit. Reflexivity and transitivity use input product unitality/multiplicativity; symmetry uses only an existential inverse on `Aᶜ`. No `IndexedGroup` or selected inverse function is introduced. |
| `RR-S5-D04`, `RR-S5-T02`–`RR-S5-T04`, `RR-C009` | `FundamentallyEquivalent.mono`, `NoumenalState.project`, `projectors`, and `projectors_surjective` | Corrected Theorem 5.2 uses `Aᶜ⊓B`, all three separation facts, both Boolean decompositions, product associativity/unitality, and coherence of the two named paths to `⊤`. Quotient projectors are identity on global representatives, nested, and surjective. |
| `RR-S5-D05`, `RR-S5-T05`–`RR-S5-T07` | `FundamentallyEquivalent.extendSystem_mul`, `NoumenalState.smul`, `smul_mk`, and inferable `indexedMulAction` | Local extensions commute with complement-supported extensions, supplying exact action representative independence. The multiplication orientation and identity law are checked on quotient representatives. |
| `RR-S5-T08`, `RR-S5-U03` | `FundamentallyEquivalent.symm`, `right_cancel_of_invertible`, and `FundamentallyEquivalent.intersection` | Existential inverse witnesses are consumed directly in symmetry of the fundamental relation and in the right-cancellation step of Theorem 5.8/product well-definedness. The latter reindexes complement witnesses through `B⊔C=Aᶜ` and `A⊔C=Bᶜ` and invokes `TransformationSeparation` exactly once. The `invertible` parameter is then carried by the dependent quotient-state family; no global group or selected inverse function is introduced. |
| `RR-S5-U04`, `RR-S5-D06`, `RR-S5-T09`, `RR-C019` | `compatible_iff_exists_globalRepresentative`, `compatible_uniqueCommonExtension`, `representedCompatibility`, `stateProduct_mk_mk`, and `stateProduct` | Compatibility is proved equivalent to sharing a raw global representative; the source formula `[W]_A⊙[W]_B=[W]_{A⊔B}` compiles. The state product exists only on the stable compatibility domain. One named `Classical.choose` extracts the already-proved unique common extension; there is no incompatible branch or selected quotient representative. |
| `RR-S5-T10` | `extendProduct_factor_left/right`, product-action projection lemmas, `mapCompatible`, and `NoumenalState.locality` | Theorem 5.10's suppressed triple products/reindexes are explicit. The input no-signalling product acts componentwise on the chosen unique common extension, and compatibility preservation is a separate proof. |
| `RR-S5-D07`, `RR-S5-T11`–`RR-S5-T14`, `RR-S5-U02`, `RR-C020` | `globalProjection_smul_eq_of_fundamentallyEquivalent`, `phenomenalization`, `phenomenalization_equivariant`, corrected `phenomenalization_projectionCompatible`, and `phenomenalization_surjective` | The reference global state is an explicit argument. No-signalling proves quotient descent/equivariance; projector nesting proves the corrected typed Theorem 5.13 path; global transitivity occurs only in Theorem 5.14 surjectivity. |
| `RR-S4-U03`, `RR-S5-U01`, `RR-S5-U05` | `coreAtReference`, `actionEffectiveAtReference`, and `theoryAtReference` | The pre-faithful core consumes invertibility, raw transformation separation, an explicit reference state, and global transitivity. Only after the core is complete does input contextual phenomenal faithfulness add noumenal action effectivity. This is the complete source transitive constructor, not the general theorem. |
| `RR-C017` (transitive special case) | `faithfulQuotientAtReference` | Reverse postulates are consumed before applying Appendix B, yielding a full theory without input phenomenal faithfulness and without asserting postulate preservation through the quotient. Stage 8 verifies the corresponding non-transitive construction. |

`Transitive.Examples` imports the stable API and checks ordinary field
projection, action-instance inference, and derived product laws for both full
outputs. `Transitive.Audit` exposes all signatures and the unique-choice
boundary. Focused, adjacent, full-build, scan, PDF, and independent-review
evidence is recorded in `goal-1/7-TRANSITIVE.md`.

### Stage 8 — general reverse construction (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S5-U06`, `RR-S5-U07`, `RR-S5-U09` | `General.EnlargedNoumenalState`, `mk`, `ofRepresentative`, inferable `indexedMulAction`, `project`, `projectors`, and `projectors_surjective` | Enlarged states are exactly a fundamental quotient state paired with a global phenomenal label. Action and projection preserve that label; all computation, action, nesting, and surjectivity laws compile without global transitivity. |
| `RR-S5-U08`, `RR-S5-T15` | `compatible_iff_label_eq_and_fundamental_compatible`, `representedCompatibility`, `stateProduct`, `stateProduct_mk_mk`, and `stateProduct_ofRepresentative` | Compatibility is equivalent to equality of labels plus Stage 7 fundamental compatibility. The enlarged product reuses Stage 7's compatibility-only product, introduces no new choice/default, reconstructs arbitrary composite pair states, and proves the displayed shared-representative formula directly. |
| `RR-S5-T10`, `RR-S5-U11` (locality fields) | `General.EnlargedNoumenalState.mapCompatible` and `locality` | Compatibility preservation and the full componentwise action/product law lift with the common label inert. No incompatible-input branch is introduced. |
| `RR-S5-U10`, `RR-S5-U12`, `RR-C010` | Corrected `phenomenalize`, `phenomenalization`, `phenomenalization_equivariant`, and `phenomenalization_projectionCompatible` | The map applies the descended `A`-class map at the stored global label, never the raw representative. Representative computation, equivariance, and projector compatibility are separate checked theorems. |
| `RR-S5-T16` | `phenomenalization_surjective` | Every local target is lifted through phenomenal-projector surjectivity and paired with the identity fundamental class. The theorem has no global-transitivity hypothesis. |
| `RR-S5-U01`–`RR-S5-U03`, `RR-S5-U11`–`RR-S5-U13`, `RR-C011` | `General.core`, `actionEffective`, and `theory` | The complete pre-faithful core requires exactly no-signalling, existential invertibility, and raw transformation separation. Contextual phenomenal faithfulness is used only afterward to retain the raw transformation family in a full theory. Global transitivity is absent from the entire General layer. |
| `RR-C017` (general route), `RR-OUT-A01`, `RR-OUT-Z01`, `RR-OUT-DX01` | `General.faithfulQuotient` | Appendix B is applied only after the general core has consumed invertibility and separation. The result needs neither global transitivity nor phenomenal faithfulness, but it retains raw separation as an input and changes the transformation family; therefore it does not justify the source's unconditional headline wording. |

`General.Examples` exercises inferred actions and ordinary derived theory laws
through the stable API for both full outputs. `General.Audit` prints the exact
constructor signatures and the inherited `[propext, Classical.choice,
Quot.sound]` footprint. Focused, adjacent, full-build, scan, and three
independent-review gates are recorded in `goal-1/8-GENERAL.md`.

### Stage 9 — exact correspondence theorem family (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-OUT-A01`, `RR-OUT-I03` (forward part) | `Correspondence.forward` | Every full local-realistic theory yields a no-signalling theory on the same transformations and phenomenal states without reverse postulates. The constructor retains the phenomenal projectors and separated transformation product. |
| `RR-AA-U01`–`RR-AA-U08`, `RR-AB-U01`–`RR-AB-U09` (public theorem-family surface) | `phenomenalFaithfulnessQuotient`, `phenomenalFaithfulnessQuotient_faithful`, and `noumenalFaithfulnessQuotient` | The two faithfulness repairs are exported independently. Appendix A changes transformations to contextual phenomenal-equivalence classes and does not gain raw separation without the stronger modulo premise. Appendix B changes transformations to noumenal action-kernel classes and needs only an already-complete pre-faithful core. |
| `RR-S4-U03`, `RR-S5-U01`, `RR-S5-U13`, `RR-OUT-I03` (qualified reverse part) | `transitiveReverseRetainingTransformations`, `generalReverseRetainingTransformations`, `transitiveReverse_forward_sameOperationalData`, and `generalReverse_forward_sameOperationalData` | The general same-signature output requires no-signalling, existential invertibility, raw separation, and contextual phenomenal faithfulness; the transitive special case additionally takes an explicit reference and global transitivity. Forwarding either raw-transformation output preserves the source phenomenal projectors and transformation product. This is one-sided operational-data preservation, not equivalence, uniqueness, or canonicity. |
| `RR-S5-U02` | Transitive `phenomenalization_surjective` and public transitive constructors; `generalReverseRetainingTransformations` and `generalReverseWithFaithfulQuotient` | Dependency inspection confirms global transitivity is consumed by Theorem 5.14 in the transitive core and is absent from the complete General layer. This is a dependency audit, not a theorem that global transitivity is logically necessary for every possible transitive presentation. |
| `RR-C017`, `RR-OUT-A01`, `RR-OUT-Z01`, `RR-OUT-DX01` (corrected general route) | `generalReverseWithFaithfulQuotient` | The weakest-premise verified full reverse constructor requires no-signalling, existential invertibility, and raw transformation separation, with neither global transitivity nor phenomenal faithfulness. Its output transformations are the Appendix-B action-kernel quotient, so it is not a same-signature model and has no `SameOperationalData` theorem. The abstract/conclusion/Deutsch summaries therefore remain split or corrected; Stage 10 separately proved only the finite Appendix-C subset and deferred the full quantum clause. |
| `RR-OUT-I01` and uniqueness/categorical/empirical readings | no declaration by design | No adequacy/completeness semantics for “all theories,” category of models, functors, isomorphism, universal property, observation/probability model, or empirical-equivalence predicate has been defined. The theorem family makes none of those claims. |

`Correspondence.Examples` consumes the forward, general quotient, general raw,
and transitive raw signatures through the stable API. `Correspondence.Audit`
prints all seven constructors, both operational-data theorems, the conditional
Appendix-A separation route, and the common foundation-only axiom footprint.
Focused, adjacent, full-build, import, scan, and three independent-review
gates are recorded in `goal-1/9-CORRESPONDENCE.md`.

### Stage 10 — finite quantum audit and Appendix-C repair (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-AC-U01` | mathlib's `Matrix`/`Module` instances over `ℂ` | Finite complex matrix endomorphism spaces carry the required vector-space structure. No claim about bounded operators on arbitrary Hilbert spaces is inferred. |
| `RR-AC-D01`, `RR-AC-U02`, `RR-C015` | `Quantum.finiteMatrixTensorEquiv` and `finiteMatrixTensorEquiv_tmul` | The canonical finite matrix-space tensor equivalence is explicit and sends simple tensors to Kronecker products. This is the finite-coordinate replacement for the unrestricted product-basis sentence; the later factor proof works entrywise and does not assume basis surjectivity. |
| `RR-AC-T01`, `RR-C015` | `OverlappingExtensionsAgree`, `commonMiddleFactorAt`, and `commonMiddleFactor` | The associativity-corrected six-index equation for `V_AB⊗I_C=I_A⊗V_BC` produces a common `VB` with both exact Kronecker factorizations. The scalar field is `ℂ`; nonempty outer factors are explicit. |
| `RR-AC-T01`, `RR-C016` | `kroneckerOneRight_injective`, `mem_unitary_of_kronecker_one`, and `commonMiddleUnitaryFactor` | The undefined printed `V^C` is corrected to `V^B`. Unitarity of the common middle factor is derived from unitarity of `V_BC=V_B⊗I_C` by reflecting both star-inverse equations through a nonempty finite `C`; it is not assumed. |
| `RR-S4-U05`, `RR-C018` (operator-algebra portion only) | `conjugation_eq_iff_unitaryPhase` | Equality of conjugation star-algebra equivalences on all continuous endomorphisms is equivalent to differing by a unitary complex scalar. The theorem does not identify the source's contextual relation on density states/extensions and is not used to claim phase-quotient separation. |
| `RR-S4-U04`, `RR-S4-U06`, `RR-OUT-A01` (quantum clause), `RR-OUT-I04` | no full instance by design | Pinned mathlib has no density-operator or partial-trace abstraction, and the source delegates the operational construction to [18]. Density closure/nonemptiness, partial-trace nesting/surjectivity/no-signalling, coherent Boolean-system tensor indexing, contextual phase completeness, and pure-state transitivity remain explicit future work. No `NoSignallingTheory` quantum constructor or unconditional quantum corollary is exported. |

`Quantum.Examples` exercises corrected Theorem C.1 on one-dimensional identity
matrices and proves tensoring with an empty identity factor is not injective.
`Quantum.Audit` prints the finite hypotheses, phase theorem boundary, and
foundation-only axiom footprints. Focused, adjacent, full-build, scan, and
independent-review evidence is recorded in `goal-1/10-QUANTUM.md`.

### Stage 11 — public model and boundary regressions (2026-07-12)

| Source IDs | Checked realization | Status and evidence |
|---|---|---|
| `RR-S3-A01`–`RR-S3-A13`, `RR-S4-U01`, qualified reverse theorem family | `Models.Trivial.core`, `theory`, `noSignallingTheory`, `generalRawTheory`, `generalQuotientTheory`, and `generalRaw_forward_sameOperationalData` | A nonempty singleton-state/singleton-transformation model over the nontrivial finite Boolean algebra `Finset (Fin 2)` constructs every local-realistic field directly, forwards to no-signalling, satisfies invertibility/separation/phenomenal faithfulness/transitivity, and consumes both general reverse outputs. Its state product remains compatibility-indexed. A separate consumer imports only root `RR2021.API`. |
| `RR-S3-D05`, `RR-S3-D07` | `Models.Audit.compositionOrderRegression` | Noncommuting finite permutations mechanically distinguish right-to-left monoid action from the reversed convention. |
| `RR-S3-D11`, `RR-S3-A12`, `RR-C004`, `RR-C019` | `Models.Audit.incompatibleProductRegression` | Two distinct states under identity projectors have no `Compatible` witness. The regression negates the domain proposition and never evaluates an off-domain product. |
| `RR-C009` and indexed transport boundary | `Models.Audit.invalidTransportPremiseRegression`, plus existing typed transport examples | Two concrete finite system indices are unequal, so the equality premise required by `reindex` is unavailable. Valid commutative/associative and relative-complement paths remain exercised separately. |
| `RR-S4-P02`–`RR-S4-P04` | `noSignallingDoesNotImplyInvertibility`, `noSignallingDoesNotImplyPhenomenalFaithfulness`, and `noSignallingDoesNotImplyGlobalTransitivity` | One valid Bool/Nat no-signalling theory refutes each predicate. This proves three non-implications from base no-signalling; it is not a pairwise independence family and says nothing about logical necessity of constructor premises. |
| Appendix A/B quotient boundaries | `quotientRepresentativesAreDistinct`, `noumenalQuotientRepresentativesCollapse`, `phenomenalQuotientRepresentativesCollapse`, and `rawValueCannotDescend` | Raw `1` and `2` are distinct but collapse in both checked quotient relations. Any function recovering the raw natural from the noumenal quotient would turn the quotient equality into `1=2`; the proof uses `congrArg` and never extracts a representative. This generic descent regression does not settle `RR-C013`. |
| `RR-C015`, `RR-C016` nonempty-factor boundary | `emptyRightTensorCancellationFails` and `emptyLeftTensorCancellationFails` | Tensoring with an identity matrix on an empty factor loses all matrix information, mechanically justifying both outer nonempty premises in the finite Appendix-C repair. |

`Models.API` exports only the stable trivial model. `Models.Examples` imports
exactly root `RR2021.API`; `Models.Audit` alone imports the diagnostic leaves.
Focused, adjacent, full-build, scan, and independent-review evidence is
recorded in `goal-1/11-MODELS.md`.

### Release — final dispositions for remaining unnumbered claims (2026-07-12)

| Source IDs | Final disposition | Evidence / boundary |
|---|---|---|
| `RR-S3-U06` | verified as a quotient distinction | `NoumenallyEquivalent`, `NoumenalQuotientTransformation`, `toNoumenallyFaithfulQuotient`, and Stage-11 collapse/non-descent regressions show that without action effectivity, transformation laws identify only action-kernel classes. |
| `RR-S3-U07` | deferred with additional semantics | The abstract library proves state-level marginal equality. Translating it to observation probabilities requires an observation/probability model not supplied by the source framework or this project. |
| `RR-OUT-C02` | split and realized mathematically | Indexed noumenal/phenomenal state families, indexed actions, `IndexedMap`, equivariance, and surjectivity are explicit in Dynamics/Theories. The surrounding interpretative language remains excluded. |
| `RR-OUT-C03` | partially realized, general prose claim not asserted | Equivariance is explicit wherever an action/map is constructed, and both selected quotients have named action congruence proofs. No general theorem derives a phenomenal action merely from an informal fiber-invariance premise. |
| `RR-OUT-C05` | split across the abstract APIs | Systems, decomposition, states, evolution, phenomenalization, and locality have precise declarations in Systems/Dynamics/Theories. Informal principles about observation or physical interpretation are not theorems. |
| `RR-OUT-C06` | realized only at the mathematical locality boundary | Separated transformation products, commutation/coherence, `Locality`, componentwise action, and marginal equations are verified. No metaphysical conclusion called “physical locality” is inferred. |
| `RR-OUT-Z02` | intentionally excluded | Removing invertibility is stated only as conjectural future work; the verified reverse constructors retain `InvertibleDynamics`. |
| `RR-OUT-I01` | unresolved/undefined by design | No adequacy semantics, category of all models, or completeness theorem is defined, so the claim that the axioms describe “all theories” has no Lean declaration. |

All 149 stable ledger entries now have an initial disposition and either a
checked realization row or an explicit final exclusion/deferral boundary.
