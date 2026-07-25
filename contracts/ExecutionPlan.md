# ExecutionPlan

> Produced by **`governed-plan`** (Planner) · consumed by **`governed-slice`** (Builder)

An **ordered** sequence of [`SliceSpec`](SliceSpec.md)s, where the order is justified by blast radius —
not by ease, not by value, not by what is most appealing to build.

## Required

| Field | Meaning |
|---|---|
| `slices[]` | the ordered SliceSpecs |
| `slices[].blastRadius` | how many downstream slices, decisions, or design commitments assume this slice's answer |
| `dependencies[]` | `from` → `to`, where one slice's **answer** is an input to another |
| `orderJustification` | one line per adjacent pair: why slice N comes before slice N+1 |
| `decay` | the explicit statement that everything after slice 1 is provisional |

## Invariants

- **Sorted descending by `blastRadius`.** Cheapness breaks ties; it never leads. Building the
  comfortable slice first is how a project accumulates work a later refutation throws away.
- **Every slice can fail.** A slice that cannot fail is a task. Rewrite it or drop it.
- **Dependencies are answer-dependencies, not convenience.** Two slices with no edge between them are
  independent — say so, rather than implying an order that does not exist.
- **The order is justified pairwise.** An order nobody can justify is a list with numbers on it.
- **`decay` is declared, not implied.** A plan that survives its own first slice untouched usually means
  the slice proved nothing.

## Invalid when

- The order was not produced by the blast-radius sort (if it matches the arrival order, say so plainly
  and check whether the sort was actually applied).
- A slice is larger than its refutation target.
- Implementation detail leaked into a slice spec — the Planner does not build.
- The post-slice-1 sequence is presented as settled.

## Lands at

`.governance/plan.md`

## Shape

```text
ORDER   S-0001 → S-0002 → S-0003     (blast radius 4 · 2 · 0)

S-0001  Merge-ledger append under concurrent device writes        blast 4
        before S-0002 because S-0002, S-0003 and the retention design all assume
        the ledger's ordering guarantee. If it fails, three slices are void.

S-0002  Device reconnect after a 48h gap                          blast 2
        before S-0003 because S-0003 reuses its reconnect fixture.

S-0003  Operator-facing sync status view                          blast 0
        independent — order is free, placed last because nothing depends on it.

DEPENDENCIES  S-0001.answer → S-0002 ; S-0002.fixture → S-0003
DECAY         Everything after S-0001 is provisional. S-0001's evidence may reorder the rest.
```
