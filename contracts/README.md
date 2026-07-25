# Contracts — the D³ artifact types

> The contract matters more than the skill. A skill is one implementation of a station; the contract is
> what any implementation must produce for the next station to be able to consume it.

This directory is the **authority for the shape of each artifact**. It answers one question per type:
*what must be true of this thing for the next station to accept it?*

The division of authority is strict, because two documents deciding one thing is the defect
`governed-review` hunts for:

| Document | Decides |
|---|---|
| [`constitution.md`](../constitution.md) | the law — what kind of system this is |
| [`pipeline.md`](../pipeline.md) | the **chain** — station order, the refusals, where artifacts land |
| `contracts/` (here) | the **shape** — required fields, invariants, what makes an artifact invalid |
| [`skills/`](../skills/) | one **implementation** per station |

If a skill's wording ever diverges from a contract, the contract wins. If a contract diverges from the
constitution, the constitution wins.

## The chain, by type

```text
question or hunch
      ↓  governed-scout
ScoutReport ─────────────→ governed-sdd
      ↓
ArchitectureQuestion ────→ governed-plan
      ↓
ExecutionPlan  (n × SliceSpec) ──→ governed-slice
      ↓
EvidenceBundle ──┬────────→ governed-review  →  ReviewVerdict ──┐
                 │                                              │ back to the
                 └────────→ governed-close                      │ producing station
      ↓                                                         ┘
Settlement ──────────────→ governed-adr   (only if it carries a candidate)
      ↓
DecisionRecord            the law. The loop returns to the next question.
```

## The types

| Type | Produced by | Consumed by |
|---|---|---|
| [`ScoutReport`](ScoutReport.md) | `governed-scout` | `governed-sdd` |
| [`ArchitectureQuestion`](ArchitectureQuestion.md) | `governed-sdd` | `governed-plan` |
| [`ExecutionPlan`](ExecutionPlan.md) | `governed-plan` | `governed-slice` |
| [`SliceSpec`](SliceSpec.md) | `governed-plan` | `governed-slice` |
| [`EvidenceBundle`](EvidenceBundle.md) | `governed-slice` | `governed-review` · `governed-close` |
| [`ReviewVerdict`](ReviewVerdict.md) | `governed-review` | the station that produced the claim |
| [`Settlement`](Settlement.md) | `governed-close` | `governed-adr` |
| [`DecisionRecord`](DecisionRecord.md) | `governed-adr` | the project |

## How to read a contract

Each file has the same four sections:

- **Required** — the fields. Absent field, invalid artifact.
- **Invariants** — what must hold across the fields. This is where the doctrine bites.
- **Invalid when** — the refusal conditions. A station handed an invalid artifact **stops and says so**;
  it does not guess the missing field. Guessing a refutation target produces a slice that cannot fail,
  which is the same as no slice at all.
- **Lands at** — the file under `.governance/`, per [`pipeline.md`](../pipeline.md).

Contracts are written as markdown field tables rather than JSON Schema on purpose. The record must be
readable by a human without a tool, and D³ has no evidence yet about which fields deserve machine
enforcement — see the compiler deferral in [`decision-log.md`](../decision-log.md).

## Status

**Hypothesis, like everything else here.** These types are transcribed from a pipeline that ran by hand
across three stacks. They are refuted the day a station routinely has to rewrite the artifact it was
handed before it can use it — that is H-002's *broken handoff* condition
([`hypotheses.md`](../hypotheses.md)).

---

Apache-2.0 · © Rodrigo Vicente — TeamX Agency
