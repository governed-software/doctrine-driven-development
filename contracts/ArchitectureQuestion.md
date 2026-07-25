# ArchitectureQuestion

> Produced by **`governed-sdd`** (Architect) · consumed by **`governed-plan`** (Planner)

A question whose **answer changes the order of construction**. Anything else is interesting, not
load-bearing. The Architect emits a set of these plus the design shape they live in.

## Required

| Field | Meaning |
|---|---|
| `question` | the question itself, in one line |
| `reorderProof` | literally: *if the answer were A we would build ___ first; if B, ___ first* |
| `origin` | which `unknown` or `contradiction` in the ScoutReport it came from |
| `deferred` | the decision this question keeps deferred until it is answered |

The surrounding **SDD envelope** carries:

| Field | Meaning |
|---|---|
| `seams` | where the system must be able to change once a question is answered |
| `invariants` | what holds true regardless of how the questions resolve |
| `answerShapedHoles` | the places the design deliberately leaves open |
| `cut[]` | candidate questions **rejected** by the reorder test, with why. **At least one.** |

## Invariants

- **`reorderProof` names two different first moves.** Same first move under either answer → the question
  is not architectural. Cut it.
- **At least one candidate is cut.** A run where every question survives means the filter did not filter.
  The `cut[]` list is the evidence that Step 3 actually ran.
- **The question never carries its own answer.** Choosing is what a slice's evidence does; an Architect
  that answers has become a Builder with an opinion.
- **Every question traces to an `origin` in the ScoutReport.** A question drawn from a *known* is a fact
  nobody wrote down yet. A question drawn from nowhere is an invented fact — send it back to Scout.
- **The SDD is written around the questions, not around assumed answers.** An SDD built on assumed
  answers must be rewritten when the real answer lands, and in practice never is — it just quietly
  becomes wrong.

## Invalid when

- `reorderProof` shows the same first move for both answers.
- `cut[]` is empty.
- The artifact proposes a build order — that is the Planner's job.
- A statement rests on a fact absent from the ScoutReport.
- An assumption appears in the SDD without being marked as one.

## Lands at

`.governance/questions.md` · `.governance/sdd.md`

## Shape

```text
QUESTION   Does conflict resolution belong on the device or on the server?
REORDER    server → build the merge ledger first, device stays dumb
           device → build the local CRDT first, server becomes a relay
ORIGIN     ScoutReport F-0003 contradiction (docs say retry-forever, code drops at 5)
DEFERRED   the retention window for superseded entries — no evidence yet

CUT        "Which JSON serializer?"  — same first move either way. Interesting, not load-bearing.
```
