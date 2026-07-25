# SliceSpec

> Produced by **`governed-plan`** (Planner) · consumed by **`governed-slice`** (Builder)

The contract for **one** slice. The Builder receives this and nothing else, so it must stand alone.
`governed-discovery` produces this same shape in compressed form, which is why a Starter user can hand
work to a Builder without ever running the Planner.

## Required

| Field | Meaning |
|---|---|
| `name` | what to call it |
| `question` | the [`ArchitectureQuestion`](ArchitectureQuestion.md) it attacks |
| `refutes` | the result that would prove the framing **wrong** |
| `evidence` | the observable result that counts — a red/green, a number, a reproducible diff |
| `notNow` | what this slice must not build, however tempting |

## Invariants

- **`evidence` is observable by someone else.** "It works" is never a valid evidence line. If you cannot
  write an observable result, the slice is not ready to hand off.
- **`refutes` names a result, not an activity.** "Test the sync layer" is an activity. "The ledger
  accepts two concurrent appends with the same sequence number" is a result that can fail.
- **The slice exists to kill a hypothesis**, not to ship a feature. Shipping is a side effect that
  sometimes happens.
- **`notNow` is filled.** Scope discipline that is not written down is a preference, and preferences
  lose to momentum.

## Invalid when

- Any of the five fields is missing → the Builder **stops and says so**. Guessing a refutation target
  produces a slice that cannot fail, which is the same as no slice at all.
- `evidence` cannot be evaluated without asking the author what they meant.
- The spec contains implementation instructions rather than a target.

## Lands at

`.governance/slices/S-000N.md` — as the header of the file the Builder then fills with its
[`EvidenceBundle`](EvidenceBundle.md).

## Shape

```text
SLICE       S-0001 · merge-ledger append under concurrent writes
QUESTION    Does conflict resolution belong on the device or on the server?
REFUTES     Two devices appending the same logical entry produce two ledger rows,
            or the second append is silently dropped.
EVIDENCE    A test that drives two concurrent appends and asserts exactly one row
            with both device IDs in its provenance. Red before, green after.
NOT NOW     The retention window. The operator UI. Any device-side CRDT.
```
