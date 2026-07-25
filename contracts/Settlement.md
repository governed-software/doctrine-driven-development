# Settlement

> Produced by **`governed-close`** (Recorder) · consumed by **`governed-adr`** — *only* if it carries a candidate

What the slice **proved**, what it did **not**, and the next question. The Settlement is where a claim
gets shrunk to the size of its evidence, before it has a chance to harden into architecture.

## Required

| Field | Meaning |
|---|---|
| `proved` | *today we proved that…* — the exact claim the observable evidence supports, no wider |
| `notProved[]` | the limits, said out loud: sample size, the host it ran on, the case not tested |
| `adrCandidate` | the deferred decision this slice earned into a decision — **or `null`** |
| `nextQuestion` | the question the loop continues with |
| `stillDeferred[]` | what must not become architecture yet |

## Invariants

- **`proved` is measured against the SliceSpec's `evidence` line, not against effort.** "I built it" is
  not "the slice proved it."
- **The overstatement check runs.** Read `proved` back against the raw output. If a skeptic reading only
  the artifact — not your effort, not your intent — could not reach that claim, **shrink it until they
  could.**
- **`adrCandidate: null` is the common and correct outcome.** Promoting a deferred decision on thin
  evidence costs the project its ability to trust its own record. Leaving it deferred one more slice
  costs nothing.
- **A slice that proved nothing is a valid Settlement.** Say so plainly; do not dress a non-result as
  insight.
- **`nextQuestion` is the deliverable, not an afterthought.** The loop continues here.

## Invalid when

- `proved` is wider than the [`EvidenceBundle`](EvidenceBundle.md) supports.
- `adrCandidate` is set without evidence behind it.
- `notProved` is empty because it was inconvenient.
- The Settlement writes the ADR. It **nominates**; crystallizing is `governed-adr`'s job.
- A green check, a filled field, or a passing test was treated as proof that a claim is true.

## Lands at

`.governance/decision-log.md`

## Shape

```text
PROVED       Today we proved that two concurrent appends with the same sequence number
             produce two ledger rows — server-side ordering is NOT currently safe.
NOT PROVED   Nothing about three or more concurrent writers. Ran on Postgres 15 only.
             Says nothing about whether the fix belongs on the server or the device.
CANDIDATE    null — the slice refuted an assumption; it did not earn a decision.
NEXT         What is the cheapest ordering guarantee that survives N writers?
DEFERRED     Retention window. Device-side CRDT. The operator UI.
```
