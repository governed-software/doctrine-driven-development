# Lab Log — the tool, harvested from doing

> The lab is not designed up front. It is the **residue** of running D³ by hand on real
> projects. Every entry below records a Discovery done manually, what it reordered (the H-001
> datapoint), and the tools it revealed we needed — discovered *behind* the method, never ahead of
> it. A candidate tool earns its place here only when a real project's friction demanded it.

---

## 2026-07-22 · a client project (first real Discovery)

**What it was.** A mature, offline-first, multi-institution PWA — an existing codebase with a large
front-end and a **47-document corpus** that already
practiced a *proto-D³*: a canonical document index with precedence rules, the explicit
obligation / product-decision / current-state / objective distinction, a traceability chain
`SOURCE → REQ → US → TASK → ADR → TEST → EVID`, a risk register, and a brutally honest
consolidated-state doc (yellow/red — demo, not releasable). The discipline was in prose; it was
not yet a contract. We ran D³ Discovery over it — five domain readers in parallel, then a
synthesis — and produced the genesis: `constitution.md` (12 principles), `questions.md`
(28 questions ranked by reorder-impact, 3 marked 🔑), `decision-log.md` (11 deferred, 16 decided).

**H-001 datapoint (does the Discovery reorder construction?).**
- *Before Discovery,* the first implementation was going to be **continuing the build** — either
  more front-end, or a backend on an existing framework that the project's legacy specs had
  declared closed in discovery.
- *After Discovery,* the first move is **neither**. It is resolving the first two architectural
  questions — which backend stack (and is the assumed framework actually discarded?), and
  server-revision vs. client-timestamp sync (a contradiction the demo client already silently
  resolved against the legacy contract). Every downstream task reorders behind those two.
- The order changed → **H-001 survives this datapoint.** Second datapoint on record, after
  D³-on-D³. Distinct from the first: here the corpus had *already made* the decisions D³ moved
  back to deferred — reordering by **demotion**, not by opening a blank.

**What the corpus proved about the method.** You don't *impose* D³ on a disciplined project — you
**compile** the discipline that's already implicit. The strongest lab signals below are **gates and
validators**, not scaffolding or generators. The method wants *enforcement of what a team already
believes*, more than it wants code generation. That is the sharpest steer this Discovery gave the
lab.

### Harvested lab backlog (candidate D³ tools, each with the real friction it would have prevented)

**Traceability & completeness**
- **Traceability linter** over `SOURCE → REQ/NFR → US → TASK → ADR/CONTRACT → TEST → EVID` —
  flags orphaned and missing links as `PENDING`, never as implicit evidence. *Surfaced in all 5
  clusters — the single strongest signal.*
- **Normative front-matter validator** (`document_id`, `owner`, `approvers`, `status`, `version`,
  `effective_date`, `last_verified`, `next_review`, `supersedes`, `classification`,
  `canonical_for`) — alerts on `last_verified > next_review` and expired validity in a doc-CI.
- **Handoff agent** that populates/objects the handoff checklist against the *real* repo/infra
  state (git present, timestamped backups, gates with evidence) instead of taking prose on faith.

**Evidence & immutability**
- **Append-only enforcement** for ledgers / ADRs / project ledger: rejects deletes, reorders and
  destructive diffs; forces a dated "corrects → X" entry; adds hash-chaining (the ledger itself
  admits Markdown is not an immutable log).
- **Evidence verifier**: rejects entries with no SHA-256, no custodian, or verifier == producer
  before they can be marked `accepted`; recomputes export-manifest hashes (already specified as an
  "independent verifier").
- **`content_hash`** over a canonical serialization of every artifact version + children, computed
  and compared on each build.

**Gates before anything is called "productive"**
- **Portable-path preflight** — would have caught a build-check broken by **hardcoded absolute
  paths** and a missing fixtures dir: the kind of thing that both blocks the build and leaks a real
  filesystem layout in a shared/public artifact. The cheapest, most concrete win in the corpus.
- **Sync contract-test runner** + its production gate for the sync surface — a test using the demo
  transport does NOT satisfy the producer/consumer binding.
- **Capability gate** that runs the SDD §12 twelve mandatory checks before anything may be declared
  productive.
- **Data-schema gate** (pre-commit) — rejects new columns lacking purpose / owner / classification /
  retention / access-rules.

**Citation & regulatory provenance**
- **Citation-criterion validator** for any source used in UI / template / rule (authority · title ·
  date · cycle · URL · consulted-on · validity-state) before a cited-source record is
  accepted.
- **Regulatory-watch agent** that consumes the master source registry + maintenance cycle,
  regenerates the regulatory matrix, and files a task when a review window expires.

**Transactional lifecycle**
- **A transactional `close-task` command** — atomically runs the close-out steps today scattered
  across several files; one reusable state machine for ADR / risk / exception (proposal → evidence →
  approval → effectivity → close).
- **`exceptions list --expired`** + automatic ADR link/metadata/ID verifier (the project already
  declared this missing).

### Gaps this Discovery could NOT close (need a human or a primary artifact, not distillation)
- The security/audit/governance cluster returned **zero evidence-backed decisions** — all its force
  is in principles and inconsistencies, none in proven facts.
- No evidence the documentary corrections were applied to the real product — the
  requirement-vs-implementation gap stays an open question.
- Primary artifacts to close deferrals are absent: load model, institution-year baseline, restore
  drill, engine PoC, identity PoC — all cited as pending, none present.
- A precedence conflict between `effective` docs that lean on `review` docs — a human-authority
  call; the lab can only flag it, never resolve it.

**Steer for the lab's first slice.** Build the **traceability linter** first: it appeared in every
cluster, it is stack-agnostic (it reads the link graph, not the code), and it is the tool that most
directly compiles the discipline the corpus already believes in. The portable-path preflight is the
cheapest concrete win if a warm-up is wanted before it.

---

## 2026-07-23 · governed.software content-gate (first skill-run Discovery)

**What it was.** The first Discovery run *through a skill* rather than by hand: `governed-discovery`
(`skills/governed-discovery/`), the first executable D³ artifact, applied to a real feature —
"build the content-contract gate for governed.software" (a CI gate every page's front-matter must
pass: `question`, `evidence`, `open`).

> Note on order: the steer above names the **traceability linter** as the lab's first *enforcement*
> tool, harvested from a mature corpus. `governed-discovery` is a different axis — the **adoption
> front** of the pipeline — and it is *not* in that backlog. It enters the repo as a hypothesis
> (its own `Status: hypothesis`), earned by the datapoint below, not by decree.

**H-001 datapoint (does the Discovery reorder construction?).**
- *Before Discovery,* the first implementation was going to be **a script that fails the build when a
  front-matter field is missing** (a presence check).
- *After Discovery,* the first move is **neither**: prove the gate can tell an honest page from one
  whose `evidence` does not resolve to a real artifact — and declare, up front, that the gate is
  necessarily **partial**. A mechanical gate can enforce presence and artifact-resolution; it cannot
  detect *overstatement* — that is delegated to adversarial review. A decision was deferred: the full
  front-matter schema, no evidence yet it is needed.
- The order changed → **H-001 survives this datapoint.** Third on record (after D³-on-D³ and
  the client project), and the first produced by a skill-encoded Discovery rather than by hand.

**What it proved about the method.** The evidence a mechanical gate can enforce (presence,
link-resolution) is not the same as the evidence that a *claim is honest*. The site's own launch
audit had already shown it: four of five evidence rows had the field filled and still overstated. So
the gate ships knowing what it cannot do — overstatement goes to adversarial review, not faked by a
green check. Limit, honest: n=1, run by the author, not yet by an external developer.

---

## 2026-07-23 · governed-close on the governed-discovery slice (the pair closes)

**What it was.** `governed-close` (`skills/governed-close/`), the back of the loop, run on the slice
that had just finished: "author `governed-discovery` and ratify it." The friction that earned it: the
front skill *opens* a loop, but nothing *closes* it — a slice can finish and quietly overstate its
result, the exact failure the launch audit had already caught (four of five evidence rows filled and
still overstated).

**What the close surfaced (its own success test).**
- *Proved:* running `governed-discovery` once, on a real feature, reordered construction — datapoint
  #3 for H-001, the first Discovery produced by a skill rather than by hand. No wider.
- *Not proved:* that it reorders for an **external** developer. n=1, author-run — and the author
  already knew the doctrine, which makes them the **weakest** possible test of "experience before
  knowing the name." The close forced that limit into the open; it was the sentence most likely to be
  glossed. That is the datapoint `governed-close` earned its place with.
- *Deferred, not activated:* both skills stay `Status: hypothesis`. Promoting them on internal,
  author-run runs would be the overstatement they exist to prevent.
- *Next open question:* does a skill-run Discovery reorder the first move for someone who has never
  seen D³, on their own project? That is the missing datapoint — external, not meta.
- *Not built yet:* CLI, compiler, and any skill beyond the discovery/close pair — deferred until an
  external datapoint earns them.

**Honest note.** Every lab datapoint so far is internal — D³-on-D³, one client corpus, and now two
skill-on-skill runs. The method's central hypothesis (H-001) still waits on the one datapoint no
internal run can supply: a stranger, on their own project.

---

## 2026-07-23 · governed-review on the skill pair (verifier ≠ producer, and it bit)

**What it was.** `governed-review` (`skills/governed-review/`), the adversarial verifier, run against
the two skills already committed (`governed-discovery`, `governed-close`) and itself — an independent
skeptic turned on the producer's own work.

**Its strongest datapoint (prior, real).** The core move — adversarial refutation of claims against
artifacts — had already run on this project's launch evidence table and refuted four of five rows the
author wrote from memory. That covers lens 1 (unproven / overstated claims); the other four lenses are
not yet independently tested. Honest scope: governed-review is the *most* proven of the three, not
fully proven.

**What the review found on the pair.**
- **Duplicate-authority / drift (fixed).** The skills restated the constitution's rules in their own
  words without citing the source — if the doctrine changes, a skill goes stale silently, and two
  authorities exist for one rule (lens 2). Fixed: each skill now carries a `Grounded in` line naming
  the canonical docs and stating that if the wording diverges, the docs win. The skill *executes* the
  doctrine; it does not re-legislate it.
- **Tautological ratification (acknowledged, not fixable here).** The discovery/close success tests are
  author-judged — verifier == producer (lens 4). The ratifications so far are the producer certifying
  their own work. governed-review is the structural answer, but it cannot repair its own author-run
  status: the missing datapoint is still an external reviewer.
- **What survived:** no silent failures (the skills explicitly forbid dressing a non-result as
  insight), no hidden exceptions (no carve-outs for "trivial" work).

**Honest note.** A verifier that shares the producer's context is a weaker verifier. This run improved
the artifacts — the drift fix is real — but the strongest test of governed-review is still someone with
no stake reviewing work they did not write.
