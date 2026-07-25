---
name: governed-sdd
description: Use after a scout sweep or any pile of findings, to convert what is known into the architectural questions that actually determine the build order — and to write the SDD around them. Applies the reorder test to every candidate question and CUTS the ones that would not change construction order, then describes the system's shape in terms of the surviving questions plus the decisions being deferred on purpose. It asks; it never answers its own question. Second station of the D³ pipeline (Doctrine-Driven Development).
---

# governed-sdd

> A design document that answers everything has decided everything — usually too early.

The **Architect** — second station of the D³ pipeline. It takes Findings and produces the small set of
questions whose answers *determine the order of construction*, plus the design shape those questions
live in. It does not choose the answers, and it does not plan the build.

**Announce:** "Running governed-sdd — turning findings into the questions that reorder construction."

## When this fires

After `governed-scout`, or any time you hold a pile of facts and are about to write a design, a spec,
or an SDD. Also fires when a design document already exists and nobody can say which of its statements
are *decisions* and which are *assumptions wearing a decision's clothes*.

## The one rule

**A question is architectural only when its answer changes the order of construction.** Everything else
is interesting, not load-bearing. This is the constitution's rule, and this station is where it is
enforced — by cutting.

## Step 1 — Separate known from unknown

From the Findings: what is now established (cited), and what remains open. **Candidate questions come
from the unknowns, not from the knowns.** A question you can already answer from a Finding is not a
question; it is a fact you have not written down yet.

## Step 2 — Draft candidate questions

Write more than you will keep. Draw them from the unknowns, the contradictions Scout reported, and the
seams where two subsystems must agree. Aim wide; the next step is a filter and a filter needs material.

## Step 3 — The reorder test — cut, don't collect

For each candidate, answer literally:

> **If the answer were A, what would we build first? If it were B, what would we build first?**

- **Different first move** → architectural. Keep it.
- **Same first move either way** → **cut it.** Move it to a "worth knowing, not load-bearing" list, or
  drop it entirely.

**At least one candidate must be cut.** A run where every question survives means the filter did not
filter — go back and draft the questions you were reluctant to write.

## Step 4 — Write the SDD around the surviving questions

The SDD describes the **shape**, not the implementation:

- **Seams and boundaries** — where the system must be able to change when a question gets answered.
- **Invariants** — what must hold true regardless of how the questions resolve.
- **The reordering map** — for each surviving question, one line stating what its answer would change.
- **Answer-shaped holes** — the places the design deliberately leaves open. Naming them is the design.

An SDD written this way stays valid when the answers arrive. One written around assumed answers has to
be rewritten, and usually is not — it just quietly becomes wrong.

## Step 5 — Deferrals, on purpose

Name the decisions that must **not** become architecture yet, and why the evidence does not deserve
them. Intelligently postponing decisions is the point, not a side effect. At least one deferral, stated
with its missing evidence.

## Handoff

- **Consumes** — **Findings** from `governed-scout`.
- **Produces** — **Architectural questions** (each surviving the reorder test) + the SDD + explicit deferrals.
- **Next station** — `governed-plan` (Planner), which orders the slices that attack these questions.

## What this refuses

- It never answers its own question. Choosing the answer is what the slice's evidence does.
- It never plans the build order — it produces the questions whose answers determine it.
- It never keeps a question that fails the reorder test, however interesting it is.
- It never writes a design around an assumed answer without marking it as an assumption.
- It never invents a fact. If it is not in the Findings, it is an unknown — send it back to Scout.

## Pairs with

`governed-scout` (produces the Findings this consumes) and `governed-plan` (consumes these questions).
`governed-discovery` is the compressed one-minute version of Scout + Architect together.

---

> **Grounded in** [`pipeline.md`](../../pipeline.md) (the station contract — the Architect refuses to
> plan the build order) + [`constitution.md`](../../constitution.md) (a question is architectural only
> when its answer reorders construction; decisions are deferred until evidence deserves them; Discovery
> opens uncertainty and never closes it falsely). This skill *executes* that doctrine; if the wording
> here diverges, the canonical docs win.
>
> **Status: hypothesis, not settled doctrine.** The station has by-hand evidence across three stacks;
> the skill that executes it does not. Its specific claim is that forcing a cut in Step 3 keeps an SDD
> honest, where an uncut design document silently promotes assumptions into architecture. If a run
> never cuts a candidate question, or the SDD it produces has to be rewritten the moment a real answer
> lands, the skill is refuted — not the doctrine.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
