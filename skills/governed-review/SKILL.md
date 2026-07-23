---
name: governed-review
description: Use to review a change, document, PR, or set of claims adversarially — not for style. Defaults to skepticism and tries to REFUTE each load-bearing claim against the artifact behind it, hunting five defect classes — unproven claims, duplicate authorities, silent failures, tautological evidence, hidden exceptions. A claim survives only if an active attempt to break it fails. Executable D³ (Doctrine-Driven Development).
---

# governed-review

> If a claim cannot be refuted, it is not doctrine. So try to refute it.

The adversarial verifier of the D³ loop. Not a cosmetic review — it does not care about naming or
formatting. It goes for the load-bearing claims and tries to break them against the artifacts behind
them. Verifier ≠ producer: run it as an independent skeptic, even on your own work.

**Announce:** "Running governed-review — adversarial, against the artifacts, default skeptical."

## When this fires

Reviewing a PR, a design doc, an evidence table, a "done" claim, a spec — anything that asserts
something is true, safe, or finished. Especially when it looks convincing: a polished claim earns the
hardest look.

## The one rule

**Default to refuted.** A claim survives only if your active attempt to break it fails. "It looks
right" is not a verdict. For every load-bearing claim: find the artifact, read it, and try to reach a
*different* conclusion than the one asserted.

## The five lenses

Hunt these, in rough order of how often they hide:

1. **Unproven claims.** An assertion with no artifact behind it — or one claiming more than the
   artifact shows. "Refuted X" when the artifact says "reframed X." Quote the artifact; shrink the
   claim to what it actually supports, or mark it unproven.
2. **Duplicate authorities.** Two places that both claim to decide one thing — two "canonical" docs, a
   value set in both code and config, a rule restated in prose *and* re-legislated in a tool. One
   authority per decision; name which one wins, or the drift is already there.
3. **Silent failures.** An error path that swallows — catch-and-continue, an empty key that skips the
   check, a fallback that hides the real failure, a default that masks a missing value. Trace the
   unhappy path: when it fires, does anyone hear it?
4. **Tautological evidence.** Evidence that proves itself — verifier == producer, a test that exercises
   its own mock, "it passed because I assert it passes," presence mistaken for proof. A filled field, a
   green check, a written test are structure, not truth. Ask: could this evidence exist even if the
   claim were false?
5. **Hidden exceptions.** A carve-out that bypasses the contract — an `if special_case` that dodges the
   rule, a disabled check with a TODO, a "temporary" flag that became load-bearing. The law is the
   compiled contract; an exception in the margins is a second, unwritten law.

## Output

Findings ranked by severity, not by order found. Each: where it is (artifact + location), which lens,
and *why the claim fails* — with the quote that refutes it. Then the honest verdict per claim:
**confirmed** (survived an active attempt to break it), **overstated** (real core, inflated wording),
**unproven** (no artifact), or **refuted** (the artifact contradicts it). Say plainly what you could
NOT break — a claim that survived a real attempt is stronger for it.

## What this refuses

- It never reviews for style, naming, or taste while a load-bearing claim is unchecked.
- It never accepts effort or intent as evidence — only the artifact counts.
- It never lets "the tests pass" stand in for "the claim is true" without asking what the tests prove.
- It never rubber-stamps its own side: verifier ≠ producer, even when the producer is you.

## Pairs with

`governed-discovery` (frames the claim) and `governed-close` (settles what a slice proved). This is the
skill that checks both honestly, from the outside.

---

> **Grounded in** `constitution.md` (if a claim cannot be refuted it is not doctrine; one authority per
> decision; evidence before assertion) and `lab-log.md` (verifier ≠ producer; a demo-transport test
> does not satisfy the producer/consumer binding). This skill *executes* that doctrine; if the wording
> here diverges from the canonical docs, the docs win.
>
> **Status: hypothesis — but with the strongest datapoint of the three.** Its core move (adversarial
> refutation of claims against artifacts) was run for real on this project's own launch evidence table
> and refuted four of five rows the author had written from memory — see `lab-log.md`. That datapoint
> covers lens 1 (unproven / overstated claims); the other four lenses are not yet independently tested.
> If a review ever confirms a claim the artifact contradicts, the skill is refuted, not the doctrine.
>
> Apache-2.0 · © Rodrigo Vicente — TeamX Agency
