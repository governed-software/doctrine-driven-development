# The stations — D³'s pipeline and its handoff contract

> A station is not a command. It is a **role that refuses the next role's job.**

This document is the single authority for **what each station consumes and what it produces**. The
skills in [`skills/`](skills/) *execute* these stations; if a skill's wording ever diverges from this
document or from [`constitution.md`](constitution.md), the canonical docs win.

It exists because a pipeline is not a collection of prompts that happen to share a prefix. What makes
the `governed-*` skills a pipeline is that **one station's output is exactly the next station's
input** — a contract, not a convention.

## The chain

```text
Scout        →  Architect  →  Planner  →  Builder  →  Reviewer  →  Recorder
governed-    →  governed-  →  governed-→  governed-→  governed-  →  governed-close
scout           sdd           plan        slice       review        governed-adr
```

`governed-discovery` is not a station. It is the **compression of Scout + Architect** into a single
minute, for the person who does not yet run the full chain — and for the moment when a question is
small enough that the chain would be ceremony. See [`README.md`](README.md) for the two distributions.

## The handoff contract

Each station consumes one named artifact and produces one named artifact. Nothing else crosses the
boundary — not intent, not effort, not conversation.

| Station | Skill | Consumes | Produces |
|---|---|---|---|
| Scout | `governed-scout` | a question or a hunch | **Findings** — observed facts with citations, plus the named unknowns |
| Architect | `governed-sdd` | Findings | **Architectural questions** (each passing the reorder test) + the SDD + explicit deferrals |
| Planner | `governed-plan` | Architectural questions | **Slice sequence** — ordered, each slice carrying its refutation target and evidence contract |
| Builder | `governed-slice` | one slice spec | **Evidence** — the observable result the slice contracted for, and what it could not produce |
| Reviewer | `governed-review` | any claim + its artifact | **Verdicts** — confirmed · overstated · unproven · refuted |
| Recorder | `governed-close` | Evidence + the slice's evidence contract | **Settlement** — proved / not proved / ADR candidate / next question / still deferred |
| Recorder | `governed-adr` | a Settlement carrying an ADR candidate | **ADR** — *today we proved that…*, and the decision moves from deferred to decided |

Read the table as a chain of types. If Scout hands the Architect a recommendation instead of Findings,
the chain is already broken — the Architect is now reasoning about someone's opinion, not about the
codebase.

## The invariant — one station, one refusal

Every station's authority comes from what it **hands off**, not from how much it does. So each one
refuses the next one's job:

- **Scout** never recommends. It reports what is true today and names what it could not determine.
- **Architect** never plans the build order. It produces the questions whose *answers* determine it.
- **Planner** never builds. It orders slices and writes each one's refutation target.
- **Builder** builds exactly one slice and never reviews its own work.
- **Reviewer** never fixes. A reviewer who patches becomes the producer, and the evidence goes
  tautological — see `constitution.md`, *one authority per decision*.
- **Close** never writes the ADR. It settles what was proved and merely *nominates* a candidate.
- **ADR** never opens the next question. Close already did; the ADR crystallizes, it does not explore.

This is the difference between a pipeline and one agent doing everything at once, badly. A station
that quietly does the next station's job produces work that looks complete and cannot be refuted —
which is the failure mode D³ exists to prevent.

## Entering and leaving mid-chain

The chain is a contract, not a ceremony. You do not owe it all seven stations.

- Enter wherever the artifact you already hold matches a station's **Consumes** column.
- Leave as soon as the question is answered. An unfinished chain is honest; a fabricated one is not.
- Repeating a station is normal. Refuted evidence sends you back to the Architect, not forward.

The only rule that never relaxes: **do not skip a station by having another one do its job.** Skipping
Scout means the Architect invents facts. Skipping Review means Close settles against unverified
evidence. If you skip, say you skipped — that is a declared limit, and limits are allowed. Silent
substitution is not.

## Where the artifacts land — `.governance/`

A handoff into a conversation is not a handoff. Every station's output must land in a **file, in the
repository it governs**, or the contract above describes something that does not exist. The convention
is a top-level `.governance/` directory, and it has the same two tiers as the distributions.

**Starter** — the four artifacts of the H-001 experiment, nothing more:

```text
.governance/
  constitution.md     what kind of system is this          founding act, not a station
  discovery.md        the frame                            governed-discovery
  questions.md        the open architectural questions     governed-discovery
  decision-log.md     deferred and decided                 governed-close · governed-adr
```

**Professional** — adds one directory per station that produces a series:

```text
.governance/
  constitution.md
  questions.md
  sdd.md                     the shape around the questions   governed-sdd
  plan.md                    the slice sequence               governed-plan
  decision-log.md
  findings/F-0001.md         cited sweep + unknowns           governed-scout
  slices/S-0001.md           spec · raw evidence · ledger     governed-slice
  reviews/R-0001.md          verdicts per claim               governed-review
  decisions/ADR-0001.md      what a slice proved · how it dies  governed-adr
```

Three rules, and they are the whole convention:

1. **Sequential IDs, never reused and never deleted.** A refuted finding stays in `findings/`. Deleting
   it deletes the evidence that it was once believed, which is the only reason the record is worth
   keeping.
2. **Every file names the station that produced it and the artifact it consumed.** That line is the
   audit trail; without it the folder is a pile.
3. **Markdown, readable without a tool.** The record must survive the disappearance of whatever wrote it.

> **Exception, declared:** this repository keeps `constitution.md`, `questions.md`, and
> `decision-log.md` at its root rather than under `.governance/`. Here the record *is* the product.
> Consuming projects use `.governance/`.

### What `.governance/` is not — the compiler stays deferred

Prior art exists and is considerably further along: **OverlayKit** ships `.overlaykit/governance/` — a
compiled `plan.json` with typed actors (human · agent · CI, with roles), artifacts carrying
`producedBy` / `sourceDecision` / `tier: enforced`, mechanisms bound to specific CI jobs by locator and
expected command, typed change contracts, and a workflow that records evidence and attests its
provenance. That is the **compiled tier**. A project graduates to it; it does not start there.

D³ does not ship that, and [`decision-log.md`](decision-log.md) keeps it deferred, for two reasons that
are still true:

1. That compiler is bound to one stack — a TypeScript workspace driven by npm scripts. D³ is
   stack-agnostic and would be caging itself.
2. Nothing yet establishes **which** of these artifacts deserves enforcement. Compiling a convention
   nobody has run by hand would be automating an assumption — the precise failure this pipeline exists
   to prevent.

So `.overlaykit/governance/` counts as evidence that the shape scales, **not** as a reason to ship it.
Its namespaced prefix is also the right instinct: a tool that compiles governance should own its own
directory and leave `.governance/` to the plain, portable record.

## What is not a station — deferred, on purpose

- **Constitution authoring** (`governed-governance`). It is a project-founding act, not a station in
  the build chain, and its only evidence today is internal. Deferred until a project that is not ours
  runs it.
- **The governance compiler and any CI gate.** Recorded as deferred in
  [`decision-log.md`](decision-log.md); nothing here promotes it.
- **Retrofit onto an existing implicit constitution.** A different animal — see
  [`questions.md`](questions.md) Q6.

---

Apache-2.0 · © Rodrigo Vicente — TeamX Agency
