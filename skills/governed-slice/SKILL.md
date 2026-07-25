---
name: governed-slice
description: Use to build exactly ONE slice from its spec and nothing adjacent — writes the observation before the implementation, builds the minimum that lets the observation run, records the raw output verbatim including failure, and keeps a scope ledger of everything it was tempted to add and did not. It is named slice, not implement, because it builds a refutation target rather than a feature. It produces evidence; it never declares success. Fourth station of the D³ pipeline (Doctrine-Driven Development).
---

# governed-slice

> It is called a slice, not a feature. Its job is to be capable of failing.

The **Builder** — fourth station of the D³ pipeline. One slice. The spec's refutation target, the
observation that measures it, and the raw result — whatever the result is.

**Announce:** "Running governed-slice — building one slice against its evidence contract, nothing adjacent."

## When this fires

When a slice spec exists and it is time to build. Also fires the moment a build request arrives already
scoped ("just add X") and you are about to start — because that is exactly when adjacent work sneaks in.

If no slice spec exists, stop: run `governed-plan`, or at minimum `governed-discovery`, first. Building
from an unspecified request is how a slice becomes a feature.

## The one rule

**Build the refutation target, nothing adjacent.** The slice is done when the evidence contract can be
*evaluated* — not when the code is complete, not when it is nice, not when the obvious next thing is
also done.

## Step 1 — Restate the spec, or stop

In your own words:

```text
REFUTES     <what result would prove the framing wrong>
EVIDENCE    <the observable result that counts>
NOT NOW     <what this slice must not build>
```

If you cannot restate all three, the spec is incomplete. **Say so and stop.** Guessing at a refutation
target produces a slice that cannot fail, which is the same as no slice at all.

## Step 2 — Write the observation first

Before the implementation, write the thing that will produce the evidence: the test, the measurement,
the probe, the query, the benchmark. Run it now and watch it fail or return nothing.

This ordering is not a testing preference. It is what stops the evidence contract from being quietly
rewritten to match whatever got built.

## Step 3 — Build the minimum that lets the observation run

Not the minimum that works. The minimum that lets the observation produce a real result. Every line
beyond that is adjacent work wearing the slice's badge.

## Step 4 — Run it and record the raw output verbatim

Paste the actual output — the numbers, the failures, the stack trace, the diff. Do not summarize it,
do not clean it up, and above all do not omit a failure.

**A failed slice is a successful slice.** It refuted the framing, which is the outcome the whole
pipeline is built to buy cheaply. Report it with the same tone as a pass.

## Step 5 — The scope ledger

Two honest lists:

- **Tempted, did not build** — everything you wanted to add. This is the discipline made visible, and
  it is also the Planner's next input.
- **Built anyway, out of scope** — anything that crossed the NOT NOW line. Declare it. Undeclared scope
  creep is what makes a later review unable to tell what the evidence actually covers.

## Handoff

- **Consumes** — one **slice spec** from `governed-plan` (or a `governed-discovery` frame).
- **Produces** — **Evidence** (raw, reproducible) + the scope ledger + what it could not produce.
- **Next station** — `governed-review` (adversarial), then `governed-close` (settlement).

## The test

> **Could someone else reproduce the observation and get the same result?**

- **Yes** → the slice happened.
- **No** → the slice did not happen, regardless of how much code was written. Code is not evidence;
  a reproducible observation is.

## What this refuses

- It never reviews or judges its own output — verifier ≠ producer, even when both are you.
- It never declares success. It produces evidence and hands it to `governed-close`.
- It never builds the next slice because it was "right there."
- It never edits the evidence contract to match what got built.
- It never omits, softens, or summarizes away a failing result.
- It never lets effort spent stand in for evidence produced.

## Pairs with

`governed-plan` (writes the spec this consumes), `governed-review` (breaks the claims), `governed-close`
(settles what the evidence proved).

---

> **Grounded in** [`pipeline.md`](../../pipeline.md) (the station contract — the Builder never reviews
> its own work) + [`constitution.md`](../../constitution.md) (evidence before assertion; never claim
> more than you can prove today) + [`README.md`](../../README.md) (the slice exists to refute, not to
> demonstrate cleverness). This skill *executes* that doctrine; if the wording here diverges, the
> canonical docs win.
>
> **Status: hypothesis, not settled doctrine.** The station has by-hand evidence; the skill does not.
> Its specific claim is that observation-first plus a scope ledger keeps a slice from silently becoming
> a feature. If slices run under it routinely exceed their NOT NOW line, or their evidence turns out
> not to be reproducible by anyone else, the skill is refuted — not the doctrine.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
