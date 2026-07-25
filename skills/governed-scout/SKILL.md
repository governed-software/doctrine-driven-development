---
name: governed-scout
description: Use BEFORE framing or deciding anything, whenever you or the agent are about to describe what a codebase, system, or domain does — from memory instead of from the artifact. Sweeps the ground and returns Findings, where every claim carries a citation (file and line, command output, quoted doc) and every unknown is named out loud. It explores; it never recommends. First station of the D³ pipeline (Doctrine-Driven Development).
---

# governed-scout

> Describing a system from memory is how overstatement is born. Go look.

The **Scout** — first station of the D³ pipeline. It does not frame, decide, or recommend. It goes
and looks, and comes back with what is actually true today plus an honest list of what it could not
determine.

**Announce:** "Running governed-scout — sweeping the ground before we frame anything. Findings only, no recommendations."

## When this fires

Before any framing, plan, or decision that rests on "how the system currently works." Especially when
the answer feels obvious: a confident description with no artifact behind it is the single most common
source of the overstatement the rest of the pipeline exists to catch.

Also fires when a review, a close, or a stakeholder question turns on a fact nobody has verified.

## The one rule

**Report only what you read.** Every finding carries a citation — a file and line, the output of a
command you ran, a quoted line of a document. A sentence you cannot cite is not a finding; it is a
belief, and it belongs in the unknowns.

## Step 1 — Scope the sweep (one line)

> **Sent to answer:** "______."

Without this, a sweep becomes a tour. The scope is what makes the unknowns meaningful — you can only
declare "I could not determine X" against a question you were actually asked.

## Step 2 — Sweep from more than one angle

One angle finds what that angle is shaped to find. Use at least two, and say which you used:

- **By structure** — the files, modules, and boundaries that exist.
- **By behavior** — what actually runs. Execute it, read the output, read the logs.
- **By contract** — the interfaces, schemas, types, and configs that constrain it.
- **By history** — what the commits, migrations, and changelogs say happened, and when.

## Step 3 — Findings

Each finding is one line of claim plus its citation. Nothing else.

```text
FINDING   <what is true today>
SOURCE    <file:line | command + its output | "quoted doc line">
```

Rank by how load-bearing they are, not by the order you found them.

## Step 4 — The unknowns (never skip)

What the sweep could **not** determine, and — for each — what would determine it. An unknown with no
route to an answer is a finding in itself: it tells the Architect where the risk lives.

## Step 5 — The contradiction check

Where do two sources disagree? Docs vs code, config vs runtime, a comment vs the behavior. Contradictions
are the highest-value output a Scout produces, because every one of them is a belief someone holds that
the artifact refuses. Report both sides and do not resolve them — resolving is not your job.

## Handoff

- **Consumes** — a question or a hunch.
- **Produces** — a [`ScoutReport`](../../contracts/ScoutReport.md): cited findings, named unknowns, contradictions.
- **Next station** — `governed-sdd` (Architect), which turns unknowns into architectural questions.

## The test (this is the whole point)

> **Did a finding change a question someone would have asked?**

- **Yes** → the sweep earned its time; hand the Findings forward.
- **No, ever** → the sweep confirmed what everyone already knew. **Say so plainly** — a confirmed prior
  is a cheap, valid result. But if Scout *never* produces a contradiction or a surprise across many
  runs, it is ceremony, and the skill is refuted — not the doctrine.

## What this refuses

- It never recommends, ranks options, or proposes a solution. That is the Architect's and Planner's job.
- It never states a claim it cannot cite — the claim moves to the unknowns instead.
- It never resolves a contradiction it found; it reports both sides.
- It never lets "I know this codebase" substitute for reading it.
- It never hides an unknown to make the report look complete.

## Pairs with

`governed-sdd` — the station that consumes Findings. `governed-review` — the same skepticism, pointed
at claims instead of at ground.

---

> **Grounded in** [`pipeline.md`](../../pipeline.md) (the station contract — Scout consumes a question,
> produces Findings, and refuses to recommend) + [`constitution.md`](../../constitution.md) (evidence
> before assertion; a Discovery that produces only answers is fake). This skill *executes* that
> doctrine; if the wording here diverges, the canonical docs win.
>
> **Status: hypothesis, not settled doctrine.** Professional-tier stations are transcribed from a
> pipeline that ran by hand across three stacks and produced real ADRs — the *stations* have that
> evidence; the *skills that execute them* do not yet. Scout's specific claim is that a cited sweep
> prevents the memory-sourced overstatement documented in [`lab-log.md`](../../lab-log.md), where four
> of five claims written from memory failed against their artifacts. If a Scout run never surfaces a
> contradiction or an unknown that changes a downstream question, the skill is refuted.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
