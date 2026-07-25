# Hypotheses

## H-001 — The adoption hypothesis
> A guided Discovery produces a **relevant architectural uncertainty the developer had not identified,
> and whose answer changes the order in which the project's decisions would be made.**

Status: **unproven.** It must remain possible to refute it.

### Experiment (the whole MVP)
A developer runs the guided Discovery on a project (new). It produces **only** four artifacts:
`constitution.md → discovery.md → questions.md → decision-log.md`.
No ADR. No slices. No compiler. No CI. No tool beyond the questions.

### How H-001 dies (refutation)
Before Discovery, ask: **"What was your first implementation going to be?"**
After Discovery, ask: **"Is it still the first?"**

- **No** → the Discovery changed the decision *order* → H-001 survives this run.
- **Yes, always** → the Discovery produced curiosity, not architecture → **H-001 is refuted.**
  Then we change the Discovery — not the doctrine.

**Secondary signal:** at least one decision moved into `decision-log.md` as *deferred (no evidence yet)*.
A question is "architectural" only when its answer reorders construction; anything else is interesting,
not load-bearing.

---

## H-002 — The practitioner hypothesis
> For someone who **already** practices the discipline, a chain of **role-separated stations** produces
> better work than a single framing skill — because the separation is what stops one agent from doing
> every job at once, badly, and calling it done.

Status: **unproven.** H-001 is about the newcomer; this one is about the practitioner, and they can
fail independently. H-001 could survive while H-002 dies, and the Professional tier would be dead
weight around a working Starter.

### What is and is not claimed
The **stations** have evidence: they ran by hand across three stacks and produced real ADRs. The
**skills that execute them** have none. This hypothesis is about the skills, not the stations — the
same footing `governed-discovery` shipped on.

### Experiment
A practitioner runs a real question through the chain: `scout → sdd → plan → slice → review → close`
(→ `adr` only if the close nominates one). Record, per station, whether its output was usable by the
next station **without rework**.

### How H-002 dies (refutation)
Any of these refutes it:

- **Collapse.** Practitioners install Professional and in practice run only `governed-discovery` and
  `governed-slice`, skipping the rest. The chain is then ceremony around the two skills that work.
- **Broken handoff.** A station's output routinely needs rewriting before the next station can consume
  it. The contract in `pipeline.md` is then a description, not a contract.
- **No refusal ever fires.** If Scout never declines to recommend, Review never declines to fix, and
  Close never declines to nominate an ADR, the separation is decorative — the stations are one agent
  wearing seven names.

**Secondary signal:** at least one station **refuses** the next station's job in a real run, and the
person notices the refusal was right. Each station carries its own narrower test in its `SKILL.md`;
those can die one at a time without taking H-002 with them.

### The datapoint that would ratify it
Same standard as H-001, one level up: a practitioner **we have never met** runs the chain on their own
project and reports that a station's refusal changed the outcome. Every datapoint today is internal.
