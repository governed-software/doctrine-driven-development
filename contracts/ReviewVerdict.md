# ReviewVerdict

> Produced by **`governed-review`** (Reviewer) · consumed by **the station that produced the claim**

The result of an **active attempt to break** a load-bearing claim against the artifact behind it. Not an
opinion about the claim — a record of what was tried.

This is the one type that is not a link in the chain: it can be pointed at any station's output,
including the pipeline's own artifacts.

## Required

| Field | Meaning |
|---|---|
| `claim` | the load-bearing assertion under test, quoted |
| `artifact` | where the evidence for it lives — file, location, command |
| `lens` | which defect class was hunted — unproven · duplicate authority · silent failure · tautological evidence · hidden exception |
| `attempt` | **what you actually did to try to reach a different conclusion** |
| `verdict` | `confirmed` · `overstated` · `unproven` · `refuted` |
| `quote` | the line from the artifact that supports the verdict |

## Invariants

- **Default to refuted.** A claim survives only if an active attempt to break it fails. "It looks right"
  is not a verdict.
- **`attempt` is non-empty for every verdict, including `confirmed`.** A confirmation with no attempt
  behind it is a rubber stamp wearing a verdict's clothes.
- **The artifact was read.** A verdict on a claim whose artifact nobody opened is itself unproven.
- **What survived is stated explicitly.** A claim that withstood a real attempt is stronger for it, and
  saying so is part of the output.
- **Ranked by severity, not by order found.**

## Invalid when

- The reviewer fixed the defect. A reviewer who patches becomes the producer and the evidence goes
  tautological — that is lens 4, applied to the review itself.
- Style, naming or taste was reviewed while a load-bearing claim went unchecked.
- "The tests pass" was accepted without asking what the tests prove.
- The verdict rubber-stamps the reviewer's own work.

## Lands at

`.governance/reviews/R-000N.md`

## Shape

```text
CLAIM      "The benchmark refuted THR-017."
ARTIFACT   .governance/slices/S-0004.md · lab notes, run 3
LENS       unproven claims
ATTEMPT    Read the raw run output looking for a result that contradicts THR-017.
           Found none — the run reframed the threshold, it never contradicted it.
VERDICT    overstated
QUOTE      "connection ceiling shifts; R-011 wins under the revised model"

CLAIM      "Tenant isolation is enforced at the database layer."
LENS       tautological evidence
ATTEMPT    Checked whether the isolation test could pass with the policy disabled.
           It could not — the test drops the policy and asserts the leak.
VERDICT    confirmed   ← survived a real attempt; stronger for it
```
