---
name: governed-plan
description: Use when you hold architectural questions and need the build order — converts them into an ordered sequence of refuting slices with dependencies, each slice carrying its refutation target, its evidence contract, and what it must not build. Orders by blast radius, putting first the slice whose failure would invalidate the most downstream work, not the slice that is easiest or most exciting. It sequences; it never builds. Third station of the D³ pipeline (Doctrine-Driven Development).
---

# governed-plan

> The right first slice is the one whose failure would hurt the most later. Build that one now.

The **Planner** — third station of the D³ pipeline. It turns architectural questions into an ordered
sequence of slices, each one specified well enough that a Builder can execute it without guessing and
a Reviewer can judge it without asking.

**Announce:** "Running governed-plan — ordering slices by what could refute us soonest."

## When this fires

After `governed-sdd`, or whenever you have real questions and are about to start building the piece
you find most appealing. Also fires when a roadmap exists but nobody can say *why* item 3 comes after
item 2.

## The one rule

**Order by blast radius, not by ease.** The first slice is the one whose refutation would invalidate
the most downstream work. Building the comfortable slice first is how a project accumulates work that
a later refutation throws away.

## Step 1 — One line per question

For each architectural question from the SDD: what its answer would reorder. If you cannot say what it
reorders, it should have been cut at the previous station — send it back rather than planning around it.

## Step 2 — The minimal refuting slice per question

Not the slice that ships the feature. The **smallest thing that, if it fails, tells us the framing is
wrong.** A slice exists to kill a hypothesis; shipping is a side effect that sometimes happens.

If a slice cannot fail, it is a task, not a slice. Rewrite it or drop it.

## Step 3 — Dependencies

Which slice's *answer* is an input to another slice? Draw the real edges — dependency on an answer, not
on convenience. Two slices with no edge between them are independent and their order is free; say so,
rather than implying an order that does not exist.

## Step 4 — The blast-radius sort

For each slice, count what its refutation would invalidate: how many downstream slices, decisions, or
design commitments assume its answer. **Sort descending.** Cheapness breaks ties; it never leads.

State the resulting order and — in one line each — why slice 1 is before slice 2. An order nobody can
justify is a list.

## Step 5 — Write each slice's spec

The Builder receives this and nothing else, so it must stand alone:

```text
SLICE       <name>
QUESTION    <the architectural question it attacks>
REFUTES     <what result would prove the framing wrong>
EVIDENCE    <the observable result that would count — red/green, a number, a reproducible diff>
NOT NOW     <what this slice must not build, however tempting>
```

"It works" is never a valid EVIDENCE line. If you cannot write an observable result, the slice is not
ready to hand off.

## Step 6 — Declare the plan's decay

State it plainly: **everything after slice 1 is provisional.** The first slice's evidence may reorder
the rest, and that is the plan working, not failing. A plan that survives its own first slice untouched
usually means the slice proved nothing.

## Handoff

- **Consumes** — **Architectural questions** from `governed-sdd`.
- **Produces** — **Slice sequence**, each slice specified as above, with the order justified.
- **Next station** — `governed-slice` (Builder), which executes exactly one.

## The test

> **Is the produced order different from the order the questions arrived in?**

- **Different** → the blast-radius sort did work; the plan earned its time.
- **Identical, every time** → the Planner numbered a list. Say so plainly and check whether Step 4 was
  actually applied, or whether the questions were pre-sorted upstream.

## What this refuses

- It never builds, and it never writes implementation detail into a slice spec.
- It never plans a slice larger than its refutation target.
- It never presents an order it cannot justify slice-by-slice.
- It never treats "easiest first" or "most valuable first" as an ordering principle — those are tiebreakers.
- It never presents the post-slice-1 sequence as settled.

## Pairs with

`governed-sdd` (produces the questions this consumes) and `governed-slice` (executes one spec at a time).

---

> **Grounded in** [`pipeline.md`](../../pipeline.md) (the station contract — the Planner refuses to
> build) + [`constitution.md`](../../constitution.md) (never claim more than a slice proved; decisions
> deferred until evidence deserves them) + [`README.md`](../../README.md) (the slice exists to refute,
> not to demonstrate). This skill *executes* that doctrine; if the wording here diverges, the canonical
> docs win.
>
> **Status: hypothesis, not settled doctrine.** The station has by-hand evidence; the skill does not.
> Its specific claim is that a blast-radius sort produces a different — and cheaper-to-be-wrong — build
> order than intuition does. If the sort never changes the order, or if projects following it discard
> as much work to late refutations as projects that did not, the skill is refuted.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
