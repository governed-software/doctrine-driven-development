# Doctrine-Driven Development · D³

**Install the engineering discipline, not just the prompt.**

> Programming agents generate code. **Engineering agents generate evidence.**

D³ is a small SDK for engineering agents — **Codex**, **Claude Code**, **Pi**, **Kimi Code**, and
**OpenCode** — that makes them earn architectural decisions with observable evidence: turning a build
request into an architectural question, a refutable slice, and an explicit evidence contract, before
implementation momentum hardens an assumption into architecture.

What it distributes is not instructions. It is **roles, contracts, and a protocol** — seven stations,
each producing a typed artifact the next one consumes. The skills are one implementation of the
stations; [`contracts/`](contracts/) is what any implementation has to satisfy.

> Native skills for Codex, Claude Code, Pi, Kimi Code, and OpenCode · Prompt fallback for any agent ·
> **Status: hypothesis, designed to be refuted**

It complements Domain-Driven Design, TDD, SDD, and ADRs. It governs the step before them:

```text
Question → Hypothesis → Slice → Adversarial review → Evidence → Doctrine → Next question
```

## Before you install: verify what is about to govern you

D³ teaches an agent to check that whatever claims to govern it belongs to an authority it recognizes,
*before* obeying. A method that taught that and then asked you to pipe an unexamined script into your
shell would be refuted by its own first lesson. So this installer is held to it.

**Import the key once.** Every release manifest is signed by it:

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/KEYS.asc | gpg --import
```

That key is not on a keyserver, and importing it from the same place as the manifest proves nothing by
itself — an attacker who controls the source controls both. It is worth exactly as much as the
cross-checks you run against sources we do not serve:

- **GitHub** shows every commit and the release tag as *Verified* under `7D72DEBDA1D36D34` — a check
  GitHub performs, not us.
- **[governed.software](https://governed.software)** publishes the same fingerprint from a different
  host. Two origins have to be compromised at once for them to agree on a lie.

Trusting a key on first sight is a decision, not a proof. This is what we can honestly offer; the
paragraph exists so you can decide with the real terms in front of you.

**Then read the installer before running it** — the recommended path, and the only one that lets you
check the script itself rather than only what it downloads:

```bash
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/SHA256SUMS
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/SHA256SUMS.asc

gpg --verify SHA256SUMS.asc SHA256SUMS   # provenance: who promulgated this list
sha256sum -c SHA256SUMS --ignore-missing # integrity: is this the install.sh it names

less install.sh                          # and then decide for yourself
bash install.sh
```

The one-liners further down still work, and they are not blind any more: the installer pulls from an
immutable tag, verifies every file it writes against the signed manifest, and refuses on a mismatch.
What it cannot do is vouch for itself — a script already running cannot tell you it was the right
script. That is what the block above is for, and why it comes first.

**What each check answers, and what it does when it fails:**

| | Question | On failure |
|---|---|---|
| **Integrity** | Are these the bytes the manifest names? | Always refuses. Needs no key. |
| **Provenance** | Did an authority you recognize promulgate that manifest? | Bad signature always refuses. No key in your keyring is `UNPROVEN` — it stops and asks you to say `D3_ACCEPT_UNPROVEN=1` out loud. |

The two are kept apart because they fail apart. A checksum that matches a file the attacker also wrote
is a green check that proves nothing; that is the exact confusion this table exists to prevent.

**Rebuild the manifest yourself** — a digest nobody can regenerate is a number, not a check:

```bash
git clone --branch v0.1.1 https://github.com/governed-software/doctrine-driven-development
cd doctrine-driven-development
git verify-tag v0.1.1
bash tools/build-manifest.sh && git diff --exit-code SHA256SUMS && echo "reproduced"
```

## Two distributions

They split by **how you already work**, not by feature count.

### Starter — 3 skills (default)

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash
```

`governed-discovery` · `governed-review` · `governed-close`

The loop, compressed: frame the question, break the claims, settle what was proved. Its entire job is
to **change your first move**. Start here even if you are experienced — it is the cheapest way to find
out whether the discipline does anything for you.

### Professional — 8 skills

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash -s -- --pro
```

Starter **plus** `governed-scout` · `governed-sdd` · `governed-plan` · `governed-slice` · `governed-adr`

The full station chain, for someone who already thinks this way and wants the agent to *work* the
process instead of teaching it.

```text
Scout   →  Architect  →  Planner  →  Builder  →  Reviewer  →  Recorder
scout      sdd           plan        slice       review       close → adr
```

Each station consumes one named artifact and produces the next station's input — and refuses to do the
next station's job. That contract is what makes this a pipeline rather than eight prompts sharing a
prefix; it lives in [`pipeline.md`](pipeline.md).

Professional **includes** Starter. `governed-discovery` stays on as the one-minute compression of
Scout + Architect, for when the full chain would be ceremony.

## 30-second quickstart

### Pi

Install the repository as a native Pi package:

```bash
pi install git:github.com/governed-software/doctrine-driven-development
```

Start a new Pi session, then try:

```text
/skill:governed-discovery add offline sync to our app.
```

Pi can also invoke the skill implicitly when a build request matches its description.

> **Note on tiers for Pi.** The native package registers the whole `skills/` directory, so
> `pi install git:…` gives you **all eight** stations regardless of tier. If you want Starter only, use
> the installer instead: `install.sh --pi`.

### Codex

Install the native skills (add `--pro` for the full station chain):

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash -s -- --codex
```

Start a new Codex session, then try:

```text
Use $governed-discovery to frame this before code: add offline sync to our app.
```

Codex can also invoke the skill implicitly when a build request matches its description.

### Claude Code

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash
```

Start a new Claude Code session and ask it to build or add a feature. `governed-discovery` will frame
the request before implementation.

### Kimi Code

Install the native skills (add `--pro` for the full station chain):

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash -s -- --kimi
```

Start a new Kimi Code session, then try:

```text
/skill:governed-discovery add offline sync to our app.
```

Kimi Code can also invoke the skill implicitly when a build request matches its description.

### OpenCode

Install the native skills (add `--pro` for the full station chain):

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash -s -- --opencode
```

Start a new OpenCode session, then try:

```text
add offline sync to our app.
```

OpenCode loads skills on-demand via its native `skill` tool and invokes them implicitly when a
build request matches the skill description. You can also call it explicitly:

```text
use the governed-discovery skill to frame this build request before proposing an implementation.
```

That is the complete runtime setup. Each skill has one canonical, portable `SKILL.md`; Codex adds its
own UI metadata sidecar. There is no daemon, API key, runtime dependency, or project configuration.

## What changes in your head

Instead of jumping from request to implementation, `governed-discovery` produces a compact frame. The
two lines that bracket it are the point — they are written in the first person because what moves is the
engineer's belief, not the agent's output:

```text
Before: the first thing I thought I should build was …

Architectural question   What answer would change the build order?
Overclaim to avoid       What would the current evidence not support?
Refuting slice           What is the smallest slice that could prove us wrong?
Evidence contract        What observable result would count?
Deferred on purpose      What must not become architecture yet?

After: is the original first move still first?
```

If the first move changes, the framing found a load-bearing uncertainty. If it never changes, say so:
the run produced curiosity, not architecture.

## The skills

### Starter

| Skill | Use it when… | Contract |
|---|---|---|
| [`governed-discovery`](skills/governed-discovery/SKILL.md) | starting a build / implement / add request | frame the architectural question and the smallest slice that could refute it |
| [`governed-review`](skills/governed-review/SKILL.md) | reviewing a change, PR, document, or claim | try to break load-bearing claims against their actual artifacts |
| [`governed-close`](skills/governed-close/SKILL.md) | a slice looks done | state exactly what the evidence proved, what it did not, and what stays deferred |

A typical Starter workflow:

```text
governed-discovery → implement the refuting slice → governed-review → governed-close
```

### Professional — the stations

Every station is a **role that refuses the next role's job**. Full contract in
[`pipeline.md`](pipeline.md).

| Role | Consumes | Produces | Implemented by |
|---|---|---|---|
| **Scout** | a question or a hunch | [`ScoutReport`](contracts/ScoutReport.md) — cited facts, named unknowns, contradictions. Never a recommendation. | [`governed-scout`](skills/governed-scout/SKILL.md) |
| **Architect** | `ScoutReport` | [`ArchitectureQuestion`](contracts/ArchitectureQuestion.md) — only what survives the reorder test, plus what was cut | [`governed-sdd`](skills/governed-sdd/SKILL.md) |
| **Planner** | `ArchitectureQuestion` | [`ExecutionPlan`](contracts/ExecutionPlan.md) of [`SliceSpec`](contracts/SliceSpec.md)s, ordered by blast radius | [`governed-plan`](skills/governed-plan/SKILL.md) |
| **Builder** | `SliceSpec` | [`EvidenceBundle`](contracts/EvidenceBundle.md) — raw, reproducible, plus the scope ledger | [`governed-slice`](skills/governed-slice/SKILL.md) |
| **Reviewer** | any claim + its artifact | [`ReviewVerdict`](contracts/ReviewVerdict.md) — confirmed · overstated · unproven · refuted | [`governed-review`](skills/governed-review/SKILL.md) |
| **Recorder** | `EvidenceBundle` + its `SliceSpec` | [`Settlement`](contracts/Settlement.md) — proved, not proved, next question, ADR candidate | [`governed-close`](skills/governed-close/SKILL.md) |
| **Recorder** | a `Settlement` with a candidate | [`DecisionRecord`](contracts/DecisionRecord.md) — *today we proved that…*, with the observation that would kill it | [`governed-adr`](skills/governed-adr/SKILL.md) |

The **role** is the unit, not the skill name. A skill is one implementation of a station; swap it and the
chain still holds, as long as the artifact still satisfies its contract.

You do not owe the chain all seven stations. Enter wherever the artifact you hold matches a station's
**Consumes** column, and leave as soon as the question is answered. The one rule that never relaxes:
do not skip a station by having another one quietly do its job.

### Where the artifacts land

Every station writes to a file in the repository it governs, under `.governance/` — because a handoff
into a conversation is not a handoff. Starter keeps four files (`constitution.md`, `discovery.md`,
`questions.md`, `decision-log.md`); Professional adds `findings/`, `slices/`, `reviews/`, and
`decisions/`. Markdown, sequential IDs, nothing deleted. Layout and rules in
[`pipeline.md`](pipeline.md) — including why the *compiled* form stays deferred.

## Agent support

| Agent | Support | Install / use |
|---|---|---|
| **Codex** | Native skill discovery and UI metadata | `install.sh --codex`, then `$governed-discovery` or implicit invocation |
| **Claude Code** | Native skill discovery | `install.sh` or `install.sh --claude` |
| **Pi** | Native package and skill discovery | `pi install git:github.com/governed-software/doctrine-driven-development` or `install.sh --pi`, then `/skill:governed-discovery` or implicit invocation |
| **Kimi Code** | Native skill discovery | `install.sh --kimi`, then `/skill:governed-discovery` or implicit invocation |
| **OpenCode** | Native skill discovery via `skill` tool | `install.sh --opencode`, then implicit invocation or `use the governed-discovery skill` |
| **Gemini / Cursor** | Portable prompt | paste the no-install prompt below |
| **Any other agent** | Portable prompt | same instructions; no adapter required |

### Install all native variants

```bash
curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.1/install.sh | bash -s -- --all
```

`--all` installs all five variants. The agent flag and the distribution flag combine in either order —
`--all --pro`, `--codex --pro`, `--pro --kimi`. Codex installs to `$CODEX_HOME/skills/`, or
`~/.codex/skills/` when `CODEX_HOME` is unset. Claude Code installs to `~/.claude/skills/`. Pi installs
to `$PI_CODING_AGENT_DIR/skills/`, or `~/.pi/agent/skills/` when the variable is unset; set
`PI_SKILLS_DIR` to override only the installer destination. Kimi Code installs to
`$KIMI_CODE_HOME/skills/`, or `~/.kimi-code/skills/` when `KIMI_CODE_HOME` is unset; set
`KIMI_SKILLS_DIR` to override only the installer destination. OpenCode installs to
`$OPENCODE_HOME/skills/`, or `~/.config/opencode/skills/` when `OPENCODE_HOME` is unset; set
`OPENCODE_SKILLS_DIR` to override only the installer destination.

### Install from a cloned repository

This keeps the operation fully local and easy to inspect:

```bash
git clone https://github.com/governed-software/doctrine-driven-development.git
cd doctrine-driven-development

# Pi: register this clone as a local package; Pi discovers skills/ automatically.
pi install "$PWD"

# Or install a copied variant for any supported agent. When run from the
# clone, the installer reads these local files instead of downloading them.
./install.sh --pi       # use --claude, --codex, --kimi, --opencode, or --all as needed
./install.sh --pi --pro # add --pro for the full station chain
```

Start a new agent session after installing so it reloads the skill catalog.

<details>
<summary><b>No install? Use the portable prompt</b></summary>

Paste this into any agent, then give it a build request:

```text
Before writing any code for a build/implement/add request, frame it first (D³ governed-discovery):
1. What architectural question are we really answering? Architectural means its answer changes the BUILD ORDER; if it would not reorder anything, keep digging.
2. What claim would be too big for the evidence we have?
3. What is the minimal slice that could REFUTE the idea? Not ship the feature — the smallest thing that, if it fails, proves the framing wrong.
4. What observable result would count as evidence? A red/green, a number, or a reproducible diff; "it works" does not count.
5. What is explicitly out of scope, and what decision are we deferring because there is no evidence yet?
Then ask: "Is my first move still the first?" If it changed, proceed to the reordered slice. Do not write code until this frame exists.
```

</details>

## Did it work?

Before running `governed-discovery`, note the implementation you were about to start. After the
frame, ask:

> **Is it still the first thing you would build?**

- **No** — the Discovery changed the decision order; the hypothesis survives this run.
- **Yes, always** — it produced curiosity, not architecture; improve or reject the framing.

Refusing to manufacture a win is part of the discipline. A failed hypothesis is useful evidence.

---

<details>
<summary><b>Why this exists</b></summary>

Most methodologies begin at planning. D³ begins earlier: it protects a project from making its first
important decision too soon. The costliest decisions are often correct implementations of the wrong
question.

### The three inversions

1. **Discovery asks questions, not solutions.** It should expose relevant uncertainty, not close it
   prematurely.
2. **A question is architectural only when its answer changes the order of construction.** Anything
   else may be interesting, but it is not load-bearing.
3. **An ADR is not an initial decision.** It is the crystallization of what a slice proved:
   *today we proved that…*, never *we think that…*.

### Status — honest, on purpose

The skills ship as **hypotheses, not settled tooling**. The central adoption claim, H-001, remains
unproven and refutable; see [`hypotheses.md`](hypotheses.md). Every datapoint so far is internal. If
the skill never changes anyone's first move, the skill is refuted — not the doctrine.

### What D³ refuses

- It never lets implementation effort stand in for evidence.
- It never claims more than a slice proved.
- It never lets memory or conversation become law; only the written record is authoritative.
- It never promotes a deferred decision before evidence earns it.

</details>

## Repository map

- [`constitution.md`](constitution.md) — the principles; the canonical law.
- [`pipeline.md`](pipeline.md) — the stations, the refusals, and where artifacts land; authority for the **chain**.
- [`contracts/`](contracts/) — the typed artifacts (`ScoutReport` → `DecisionRecord`); authority for their **shape**.
- [`hypotheses.md`](hypotheses.md) — H-001, H-002, and exactly how each dies.
- [`questions.md`](questions.md) — D³'s own Discovery.
- [`decision-log.md`](decision-log.md) — evidence-backed and deliberately deferred decisions.
- [`lab-log.md`](lab-log.md) — experiments and harvested datapoints.
- [`skills/`](skills/) — the executable stations.
- [`install.sh`](install.sh) — installer for Codex, Claude Code, Pi, Kimi Code, and OpenCode.

D³ emerged independently across three unrelated stacks — Milpa, OverlayKit, and DOM Protocol. Same
discipline, three languages; that is why it lives in a company-neutral home instead of one
implementation.

---

Apache-2.0 · © Rodrigo Vicente — TeamX Agency · [governed.software](https://governed.software)
