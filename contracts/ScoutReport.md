# ScoutReport

> Produced by **`governed-scout`** (Scout) · consumed by **`governed-sdd`** (Architect)

What is true about the ground **today**, with a citation behind every claim — and an honest list of what
could not be determined. It is the only artifact in the chain that is pure observation.

## Required

| Field | Meaning |
|---|---|
| `question` | one line: the scope the sweep was sent to answer |
| `angles` | which angles were swept — structure · behavior · contract · history. **At least two.** |
| `findings[]` | `claim` + `source`, ranked by how load-bearing they are |
| `findings[].source` | `file:line`, a command **and its output**, or a quoted document line |
| `unknowns[]` | `what` could not be determined + `howToDetermine` it |
| `contradictions[]` | two sources that disagree, both quoted, left unresolved |

## Invariants

- **Every `claim` carries a `source`.** A sentence you cannot cite is a belief; it moves to `unknowns`.
- **No recommendation.** Not a ranked option list, not a "we should", not a preferred approach. The
  Scout's authority comes from having looked, and it evaporates the moment it starts choosing.
- **Contradictions are reported, never resolved.** Resolving is the Architect's job, and a contradiction
  is the highest-value thing a sweep produces — every one is a belief the artifact refuses.
- **`unknowns` is never empty for convenience.** An omitted unknown makes the report look complete and
  makes the next station invent a fact.

## Invalid when

- A `finding` has no `source` → it is an unknown, not a finding.
- Only one angle was swept → one angle finds only what it is shaped to find.
- The report contains a recommendation, a ranking, or a proposed solution.
- A contradiction was silently resolved in favor of one side.
- "I know this codebase" was used in place of reading it.

## Lands at

`.governance/findings/F-000N.md`

## Shape

```text
QUESTION   Can the current sync layer survive an offline device rejoining after 48h?
ANGLES     behavior · contract

FINDING    Sync retries are capped at 5 attempts, then the queue entry is dropped.
SOURCE     src/sync/queue.ts:118

FINDING    The 48h case has never been exercised in tests.
SOURCE     rg -l "48h|two.day" tests/ → no matches

UNKNOWN    What the server does with a device clock skewed by more than the retry window.
HOW        Run one device with a skewed clock against staging and read the ledger.

CONTRADICTION
  docs/sync.md:44  "entries are retried until acknowledged"
  src/sync/queue.ts:118  drops after 5 attempts
```
