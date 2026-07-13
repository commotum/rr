#!/usr/bin/env python3
"""Check mechanical Stage-1 documentation coverage.

This check is intentionally narrower than mathematical review.  It proves that
every numbered source declaration has at least one ledger entry and that the
required audit documents expose their mandatory fields.  Operative unnumbered
claims still require the manual review recorded in 1-SURVEY.md.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "raymond-robichaud-2021" / "raymond-robichaud-2021.md"
LEDGER = ROOT / "goal-1" / "source-ledger.md"
CORRECTIONS = ROOT / "goal-1" / "corrections.md"
ARCHITECTURE = ROOT / "goal-1" / "architecture.md"

LABEL = re.compile(
    r"\*\*(Definition|Axiom|Postulate|Lemma|Theorem) "
    r"((?:\d+\.\d+)|(?:[A-C]\.\d+))(?:\s|\.|\()"
)


def fail(messages: list[str]) -> None:
    for message in messages:
        print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> None:
    errors: list[str] = []
    for path in (SOURCE, LEDGER, CORRECTIONS, ARCHITECTURE):
        if not path.is_file():
            errors.append(f"missing required file: {path.relative_to(ROOT)}")
    if errors:
        fail(errors)

    source_text = SOURCE.read_text(encoding="utf-8")
    ledger_text = LEDGER.read_text(encoding="utf-8")
    corrections_text = CORRECTIONS.read_text(encoding="utf-8")
    architecture_text = ARCHITECTURE.read_text(encoding="utf-8")

    labels = sorted({f"{kind} {number}" for kind, number in LABEL.findall(source_text)})
    missing = [label for label in labels if label not in ledger_text]
    if missing:
        errors.append("ledger is missing numbered labels: " + ", ".join(missing))

    ledger_requirements = {
        "status": ("Initial status",),
        "dependencies": ("Dependencies",),
        "target stage": ("Stage/module",),
        "interpretative exclusions": ("Interpretative exclusions",),
        "unresolved mathematics": ("Unresolved mathematics",),
        "operative unnumbered claims": (
            "Material unnumbered items",
            "Operative claims outside",
        ),
    }
    for description, alternatives in ledger_requirements.items():
        if not all(term.casefold() in ledger_text.casefold() for term in alternatives):
            errors.append(f"source ledger lacks required field/section: {description}")

    correction_requirements = {
        "source location, original claim, and justification": ("Source/evidence",),
        "precise defect": ("Defect",),
        "corrected formulation": ("Conservative repair",),
        "downstream consequences": ("Downstream effects",),
        "resolution status": ("Status",),
        "explicit field mapping": ("Required field mapping",),
    }
    for description, alternatives in correction_requirements.items():
        if not all(term.casefold() in corrections_text.casefold() for term in alternatives):
            errors.append(f"correction log lacks required field: {description}")

    for required in (
        "Mathematical Dependency Graph",
        "Proposed Lean Module Graph",
        "Protected High-Fanout Modules",
        "Incremental Build Policy",
        "Partial products",
        "Quotients",
    ):
        if required.casefold() not in architecture_text.casefold():
            errors.append(f"architecture record lacks required section/topic: {required}")

    if errors:
        fail(errors)

    print(
        "Stage-1 documentation check passed: "
        f"{len(labels)} distinct numbered source declarations covered."
    )


if __name__ == "__main__":
    main()
