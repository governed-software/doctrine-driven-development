---
name: governed-adr
description: Use only when a close produced an ADR candidate — writes the Architecture Decision Record that crystallizes what a slice PROVED, in past tense, with the evidence cited and its limits carried over intact. Requires a refutation condition, the observation that would invalidate this ADR, and refuses to write one without it. Moves the entry from deferred to decided and names what it supersedes so only one authority owns the decision. Final station of the D³ pipeline (Doctrine-Driven Development).
---

# governed-adr

> An ADR is not what we decided to do. It is what a slice proved, written down so it stops being renegotiated.

The **Recorder's second act** — final station of the D³ pipeline. `governed-close` settled what the
evidence proved and *nominated* a candidate. This station crystallizes it into law, or refuses to.

**Announce:** "Running governed-adr — crystallizing what the slice proved, with its refutation condition."

## When this fires

Only after `governed-close` produced an ADR candidate. Also fires when a decision is being made twice —
relitigated in a thread, or re-explained to someone new — which means it never became law.

## The one rule

**Past tense, cited, limited.** An ADR states *today we proved that…*, never *we think that…* and never
*we will…*. If the sentence works in future tense, it is a plan, not a decision.

## The refusal gate — check this first

**Refuse to write the ADR if any of these is true:**

- The Settlement has no evidence, or the evidence does not support the claim as stated.
- You cannot name the observation that would invalidate the ADR (Step 5).
- Another ADR already owns this decision — amend or supersede that one instead of adding a second authority.

Refusing is a valid, common outcome. A deferred decision that stays deferred one more slice costs
nothing; a decision promoted on thin evidence costs the project its ability to trust its own record.

## The record

### 1. The decision — one sentence, past tense

> *Today we proved that ______, therefore ______.*

Nothing wider than the evidence. If `governed-close` shrank the claim, the ADR inherits the shrunk one.

### 2. The evidence — cited and reproducible

The artifact, where it lives, and how someone else re-runs it. A link to a conversation is not evidence.
Raw numbers and outputs beat descriptions of them.

### 3. The limits — carried over intact

Copy the Settlement's *what it did not prove* into the ADR. This is the section that stops the decision
from being cited later for something it never covered. It travels with the decision permanently.

### 4. What this closes

Which deferred entry moves from **deferred** to **decided**, and what this ADR **supersedes**. One
authority per decision — if two documents now claim to decide this, name the loser explicitly.

### 5. How it dies (required)

> **What observation would invalidate this ADR?**

A number crossing a threshold, a benchmark reversing, a constraint disappearing, a scale we have not
reached. **An ADR without a refutation condition is a preference wearing formal clothing** — if you
cannot write this section, return to the refusal gate.

### 6. What it does NOT decide

The neighboring decisions that stay deferred, so momentum does not smuggle them in on this ADR's authority.

## Step 7 — Move the record

Update the decision log: the entry moves out of *deferred* and into *decided (with evidence)*, pointing
at this ADR. From this moment the ADR is the authority — the conversation that produced it is not.

## Handoff

- **Consumes** — a [`Settlement`](../../contracts/Settlement.md) from `governed-close` carrying an ADR candidate.
- **Produces** — a [`DecisionRecord`](../../contracts/DecisionRecord.md), plus the decision-log entry moved from deferred to decided.
- **Next station** — none. The loop returns to `governed-scout` or `governed-sdd` with the next question
  that `governed-close` already opened.

## The test

> **Can you write Step 5?**

- **Yes** → the decision is earned by evidence, and it stays refutable. That is doctrine.
- **No** → it is a preference. Do not write the ADR; leave the decision deferred and say why.

## What this refuses

- It never writes an ADR from a Settlement without evidence.
- It never states a decision in future or conditional tense.
- It never claims wider than the evidence, and never drops the limits section.
- It never opens the next question — `governed-close` already did that.
- It never creates a second authority for a decision another ADR owns.
- It never lets the conversation stand as the record; only the written ADR is law.

## Pairs with

`governed-close` (nominates the candidate this crystallizes) and `governed-review` (the skeptic to run
against the ADR's own claims before it becomes law).

---

> **Grounded in** [`pipeline.md`](../../pipeline.md) (the station contract — the Recorder crystallizes,
> it does not explore) + [`constitution.md`](../../constitution.md) (an ADR is not an initial decision,
> it is the crystallization of what a slice proved; one authority per decision; the law is the compiled,
> immutable contract; if a claim cannot be refuted it is not doctrine). This skill *executes* that
> doctrine; if the wording here diverges, the canonical docs win.
>
> **Status: hypothesis, not settled doctrine.** The station has by-hand evidence — real ADRs written
> this way across three stacks. The skill does not. Its specific claim is that the required refutation
> condition (Step 5) filters out preferences that would otherwise enter the record as decisions. If
> every candidate passes Step 5 effortlessly, the gate is not gating and the skill is refuted.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
