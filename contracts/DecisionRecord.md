# DecisionRecord

> Produced by **`governed-adr`** (Recorder) · consumed by **the project** — this one is the law

An ADR is not what we decided to do. It is **what a slice proved**, written down so it stops being
renegotiated. From the moment it exists, it — and not the conversation that produced it — is the
authority.

## Required

| Field | Meaning |
|---|---|
| `decision` | one sentence, **past tense**: *today we proved that ___, therefore ___* |
| `evidence` | the artifact, where it lives, and how someone else re-runs it |
| `limits` | the Settlement's `notProved`, copied **intact** — it travels with the decision permanently |
| `closes` | which deferred entry moves from *deferred* to *decided* |
| `supersedes` | the record this replaces, if any — one authority per decision |
| `diesWhen` | **the observation that would invalidate this ADR** |
| `doesNotDecide[]` | the neighbouring decisions that stay deferred |

## Invariants

- **Past tense.** If the sentence works in future tense, it is a plan, not a decision.
- **`diesWhen` is required.** An ADR without a refutation condition is a preference wearing formal
  clothing. This is the constitution applied to the record itself: *if a claim cannot be refuted, it is
  not doctrine.*
- **`limits` is inherited, not rewritten.** It is the section that stops the decision from being cited
  later for something it never covered.
- **`decision` is no wider than the evidence.** If `governed-close` shrank the claim, the ADR inherits
  the shrunk one.
- **One authority.** If another record already decides this, amend or supersede it — never add a second.

## Invalid when

- The [`Settlement`](Settlement.md) carries no evidence, or the evidence does not support the claim as
  stated → **refuse to write it.** Refusing is a valid and common outcome.
- `diesWhen` cannot be answered → it is a preference. Leave the decision deferred and say why.
- The record opens the next question — `governed-close` already did that. The ADR crystallizes; it does
  not explore.
- A link to a conversation is offered as evidence.

## Lands at

`.governance/decisions/ADR-000N.md`, and the corresponding entry moves in
`.governance/decision-log.md`.

## Shape

```text
DECISION     Today we proved that server-side sequence ordering does not hold under
             concurrent appends, therefore ordering authority moves to the merge ledger
             and devices remain relays.
EVIDENCE     .governance/slices/S-0001.md · npx vitest run tests/ledger/concurrent-append.test.ts
LIMITS       Two writers only. Postgres 15 only. Nothing about three or more.
CLOSES       decision-log "conflict resolution location" → decided
SUPERSEDES   —
DIES WHEN    A run with ≥3 concurrent writers shows the ledger itself reordering,
             or a Postgres version lands where the original assumption holds.
DOES NOT     Retention window. Device-side CRDT. Operator-facing status.
```
