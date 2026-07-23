# D³ — Doctrine-Driven Development

> **The artifact is not code. It is the question the developer didn't know to ask.**

**Good software starts with better questions. Doctrine turns those questions into architecture.**

---

## What this is

D³ is a discipline for **starting** software projects.

Most methodologies begin at planning. D³ begins earlier — it protects a project from making its
first important decision too soon. Its core move: **intelligently defer the decisions that don't yet
deserve to become architecture**, and spend the first hour producing *better questions* instead of a
backlog.

It is not a way to write better code. It is a way to **begin**.

## Status — honest, on purpose

This repository is the **method, built by hand**, plus **hypotheses under test**. There is no CLI and
no compiler yet — those are deferred until the method earns them (`decision-log.md`). The **first
executable skill** (`skills/governed-discovery/`) ships as an experiment, not settled tooling: it
carries its own refutation test and is marked `Status: hypothesis`. Everything else — more skills, a
CLI, a compiler — stays deferred until the method earns it.

D³ applies its own discipline to itself: **if the central claim can't be refuted, it isn't doctrine.**

- **H-001**, the adoption hypothesis, is *unproven* and *refutable* — see `hypotheses.md`.
- The genesis of *this very repo* was produced by running D³'s Discovery **on D³** — dogfooding from
  commit zero. The act of writing these files changed the order in which D³ itself would be built
  (the tool moved *behind* the method). That is the first datapoint for H-001; `lab-log.md` records
  the ones that followed.

## The three inversions

The full loop is `Constitution → Discovery → User Story → SDD → architectural question → Slice →
Review → Evidence → ADR → Roadmap → next question`. Three moves make it D³ and not the rest:

1. **Discovery asks questions, not solutions.** A Discovery that produces only answers is fake — it
   should *open* relevant uncertainty, not close it prematurely.
2. **SDD stops asking "how do we implement the story?" and asks "what is the next architectural
   question?"** A question is *architectural* only when its answer **changes the order of
   construction**. Anything else is interesting, not load-bearing.
3. **An ADR is not an initial decision. It is the crystallization of what a slice proved.** The
   constitution says *never claim more than you can prove*; the ADR says *today we proved that…*.

## Run the Discovery by hand (this is the whole v1)

No tool required. Produce four artifacts — nothing more:

| Artifact | Answers |
|---|---|
| `constitution.md` | *What kind of system is this?* Not how. Not yet. |
| `discovery.md` | Questions about the problem — who has it, why it exists, what happens if we do nothing. |
| `questions.md` | The questions worth answering (architectural = reorders construction). |
| `decision-log.md` | The decisions you are **deferring**, and why (no evidence yet). **This is where value is measured.** |

Then run the refutation:

- **Before Discovery:** *"What was your first implementation going to be?"*
- **After Discovery:** *"Is it still the first?"*
- If **no** → the Discovery earned its hour. If **always yes** → H-001 is refuted; change the
  Discovery, not the doctrine.

## What's in this repo

- **`constitution.md`** — D³'s own constitution (what kind of system, not how).
- **`hypotheses.md`** — H-001, the experiment, and exactly how it dies.
- **`questions.md`** — the Discovery of D³ on D³.
- **`decision-log.md`** — what D³ has decided (with evidence) and deferred (honestly).
- **`lab-log.md`** — the tools harvested from running D³ by hand on real projects.
- **`skills/`** — executable D³: skills that run the method inside a coding agent. First one:
  `governed-discovery` (hypothesis-bearing; carries its own refutation test).

## Provenance

D³ is the name for a discipline that emerged, independently, across three unrelated stacks and
domains — a PHP framework (**Milpa**), a live-broadcast production system (**OverlayKit**), and
**DOM Protocol**. Same discipline, three languages. It earned its independence by surviving the
language; it will not be re-caged in one.

## What D³ refuses to do

The guardrail against becoming the heavy methodology it means to replace:

- It never writes your code — it frames the question and judges the evidence.
- It never claims more than a slice has proven.
- It never lets memory or conversation become law — only the compiled contract is law.
- It never forces the whole loop when the *front* of the pipeline is what's still unproven.

---

Apache-2.0 · © Rodrigo Vicente — TeamX Agency
