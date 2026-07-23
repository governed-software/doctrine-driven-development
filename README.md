# Doctrine-Driven Development · D³

**An engineering discipline in which architectural decisions earn authority through observable evidence.**

It does not replace Domain-Driven Design, TDD, SDD, or ADRs. It governs how questions become
experiments, evidence, and eventually doctrine.

These are **skills that run the discipline inside your coding agent** — Claude Code, Codex, Gemini,
Cursor. Try one in 30 seconds.

---

## Try it now (any agent)

Paste this into your agent, then ask it to build a feature:

```
Before writing any code for a build/implement/add request, frame it first (D³ governed-discovery):
1. What architectural question are we really answering? (architectural = its answer changes the BUILD ORDER; if it wouldn't reorder anything, keep digging)
2. What claim would be too big for the evidence we have?
3. What is the minimal slice that could REFUTE the idea? (not ship the feature — the smallest thing that, if it fails, proves the framing wrong)
4. What observable result would count as evidence? (a red/green, a number, a reproducible diff — "it works" doesn't count)
5. What is explicitly out of scope, and what decision are we deferring (no evidence yet)?
Then ask: "Is my first move still the first?" If it changed, proceed to the reordered slice. Do not write code until this frame exists.
```

The agent will frame the question before it writes code. That's the whole idea — you feel the
discipline before you read a word of theory.

## Install (Claude Code)

```sh
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/install.sh | bash
```

Drops the three skills into `~/.claude/skills/`. They trigger on their own — no flags, no config.
Other agents (Codex, Gemini, Cursor): use the paste snippet above until native adapters land.

## The skills

| Skill | Fires when… | What it does |
|---|---|---|
| **`governed-discovery`** | you ask to build / implement / add | turns the request into the architectural question, the falsifiable hypothesis, and the minimal slice that could refute it |
| **`governed-close`** | you're about to call it done | settles what the slice *actually* proved — and refuses to claim a gram more |
| **`governed-review`** | you review a change or a claim | adversarial: hunts unproven claims, duplicate authorities, silent failures, tautological evidence, hidden exceptions |

## Did it change your agent's behavior?

That's the only test that matters. Before running `governed-discovery`, note the implementation you
were about to start. After: **is it still the first thing you'd build?** If it moved, the discipline
earned its minute. If it didn't, say so plainly — refusing to fake a result is the discipline too.

---

<details>
<summary><b>Why this exists</b> (the part a dev doesn't need to read to use it)</summary>

### The loop

```
Question → Hypothesis → Slice → Adversarial review → Evidence → Doctrine → Next question
```

Most methodologies begin at planning. D³ begins earlier — it protects a project from making its
first important decision too soon, and spends the first hour producing *better questions* instead of
a backlog. The costliest decisions are rarely wrong implementations; they are **correct answers to
the wrong question**.

### The three inversions

1. **Discovery asks questions, not solutions.** A Discovery that produces only answers is fake — it
   should *open* relevant uncertainty, not close it prematurely.
2. **A question is *architectural* only when its answer changes the order of construction.** Anything
   else is interesting, not load-bearing.
3. **An ADR is not an initial decision — it is the crystallization of what a slice proved.** *Today
   we proved that…*, never *we think that…*.

### Status — honest, on purpose

The skills ship as **`Status: hypothesis`**, not settled tooling: the method defers agents and tools
until it earns them. The central adoption claim (**H-001**) is *unproven and refutable* — see
[`hypotheses.md`](hypotheses.md). Every datapoint so far is internal; the one that would ratify it is
a stranger running `governed-discovery` on their own project. If a skill never changes anyone's first
move, the skill is refuted — not the doctrine.

### What's in this repo

- [`constitution.md`](constitution.md) — the principles (the law).
- [`hypotheses.md`](hypotheses.md) — H-001, and exactly how it dies.
- [`questions.md`](questions.md) — the Discovery of D³ on D³.
- [`decision-log.md`](decision-log.md) — decided (with evidence) and deferred (honestly).
- [`lab-log.md`](lab-log.md) — the tools and datapoints harvested from running D³ for real.
- [`skills/`](skills/) — executable D³ (the trio above). `install.sh` puts them in your agent.

### Provenance

D³ emerged independently across three unrelated stacks — a PHP framework (**Milpa**), a live-broadcast
system (**OverlayKit**), and **DOM Protocol**. Same discipline, three languages. It earned its
independence by surviving the language; it will not be re-caged in one — which is why it lives here, in
a company-neutral home, and not inside any one of its implementations.

### What D³ refuses to do

- It never writes your code — it frames the question and judges the evidence.
- It never claims more than a slice has proven.
- It never lets memory or conversation become law — only the written record is law.
- It never forces the whole loop when the *front* of the pipeline is what's still unproven.

</details>

---

Apache-2.0 · © Rodrigo Vicente — TeamX Agency · [governed.software](https://governed.software)
