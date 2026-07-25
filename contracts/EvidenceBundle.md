# EvidenceBundle

> Produced by **`governed-slice`** (Builder) · consumed by **`governed-review`** and **`governed-close`**

What the slice actually produced — raw, reproducible, and including the failure. This is the artifact
the whole pipeline exists to buy cheaply.

## Required

| Field | Meaning |
|---|---|
| `sliceRef` | the [`SliceSpec`](SliceSpec.md) this answers |
| `observation` | the test, measurement, probe or query — **written before the implementation** |
| `raw` | the verbatim output: numbers, failures, stack traces, the diff |
| `reproduce` | the exact command someone else runs to get the same result |
| `ledger.tempted[]` | everything you wanted to add and did not |
| `ledger.builtAnyway[]` | anything that crossed the `notNow` line — declared |
| `couldNotProduce` | what the slice was unable to produce, and why |

## Invariants

- **`raw` is verbatim.** Not summarized, not cleaned up, and above all not missing the failure.
- **A failed slice is a successful slice.** It refuted the framing, which is the outcome the pipeline is
  built to buy. Report it in the same tone as a pass.
- **`observation` was written first.** This is not a testing preference — it is what stops the evidence
  contract from being quietly rewritten to match whatever got built.
- **`reproduce` runs for someone who is not you.** Code is not evidence; a reproducible observation is.
- **`ledger.builtAnyway` is declared, never hidden.** Undeclared scope creep makes a later review unable
  to tell what the evidence actually covers.

## Invalid when

- There is no reproducible observation → **the slice did not happen**, regardless of how much code was
  written.
- The `evidence` line of the SliceSpec was edited to match the result.
- A failing result was omitted, softened, or summarized away.
- The bundle contains a verdict on itself. The Builder never reviews its own work — verifier ≠ producer,
  even when both are you.

## Lands at

`.governance/slices/S-000N.md`

## Shape

```text
SLICE       S-0001
OBSERVATION tests/ledger/concurrent-append.test.ts — asserts one row, two provenance IDs

RAW
  ✗ concurrent append › produces a single row
    expected 1 row, received 2
    rows: [{seq: 8, device: "a"}, {seq: 8, device: "b"}]
    at ledger/append.ts:64

REPRODUCE   npx vitest run tests/ledger/concurrent-append.test.ts

TEMPTED     add a unique index on (seq) — that decides the question instead of testing it
BUILT ANYWAY  (none)
COULD NOT   run it against Postgres 16; the fixture only starts 15. Limit declared.
```

> The example above is a **refutation**, and it is the most valuable outcome on this page: the framing
> assumed server-side ordering was already safe. It was not, and one slice bought that answer.
