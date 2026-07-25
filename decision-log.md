# Decision log — D³

The value of Discovery is measured here: not by decisions made, but by decisions **honestly deferred**.

## Deferred (no evidence yet)
- **The tool's name.** Almácigo stays for *where people germinate* (Academy/mentorship). The CLI wants
  an operative name so `xxx init` reads "I'm starting a project," not "I'm entering a philosophy."
  Decide after the method proves itself.
- **The CLI / any automation.** The method is built by hand first; automate only what the by-hand runs
  prove is worth automating.
- **The governance compiler and any CI gate.** It will be a piece — evidence: OverlayKit already ships
  one, `.overlaykit/governance/` (compiled `plan.json`, typed actors and mechanisms bound to CI jobs,
  change contracts, attested evidence). Still deferred, and the reasons sharpened by looking at it:
  that compiler is bound to one stack (TypeScript workspace + npm scripts) while D³ is stack-agnostic,
  and nothing yet establishes *which* artifact deserves enforcement. Compiling a convention nobody has
  run by hand automates an assumption. See [`pipeline.md`](pipeline.md).
- ~~**The later stages** (SDD → Slice → Review → Evidence → ADR) and their per-stage agents.~~
  **Activated** — see *The later stages ship as skills* below. Superseded; that entry is now the authority.
- **Distribution shape** (CLI vs agent-kit vs GitHub App) — *partially* answered below. What remains
  deferred: whether a CLI or a GitHub App ever earns a place beside the agent-kit.
- **`governed-governance`** — constitution authoring as a skill. It is a project-founding act, not a
  station in the build chain, and its only evidence is internal to two of our own projects. Deferred
  until a project that is not ours runs it. Recorded in [`pipeline.md`](pipeline.md) as *not a station*.

## Decided (with evidence)
- **D³ lives apart — not inside Milpa.** Evidence: the doctrine already runs in three stacks/domains
  (Milpa, OverlayKit, DOM Protocol). Caging it in PHP would contradict that evidence.
- **New projects first; retrofit later (v2).** Evidence: retrofit is reverse-engineering an implicit
  constitution — a distinct, harder capability.
- **Artifacts land in `.governance/`, as markdown, in the repository they govern.** Evidence: the
  handoff contract already names an artifact per station, and a named artifact with no destination is a
  conversation — the one thing the constitution refuses to treat as law. Deliberately narrow: this
  decides the **location and the format**, nothing else. The schema, the compiler, and any CI
  enforcement stay deferred above. Layout in [`pipeline.md`](pipeline.md).
- **The later stages ship as skills — and only as skills.** Supersedes the deferral above.
  Evidence that earned the promotion: `governed-review` was *inside* that deferral and shipped anyway,
  then produced the strongest datapoint of the three — four of five claims written from memory failed
  against their artifacts ([`lab-log.md`](lab-log.md)). A station rendered as a skill carried real
  weight, so the deferral was already refuted in practice; leaving it standing was the drift.
  **Scope of the promotion, stated narrowly:** the *stations* have by-hand evidence across three stacks
  and real ADRs; the *skills that execute them* do not, and ship as hypotheses (H-002). The CLI, the
  governance compiler, and any CI gate remain deferred and are untouched by this entry.
- **Distribution is an agent-kit, in two tiers — Starter (3) and Professional (8).** Evidence:
  `install.sh` installs natively into five agents today with no daemon, key, or project config, and the
  tier split answers a real observed failure — a practitioner who already thinks in D³ experiences the
  teaching skills as friction and asks for the station, not the lesson. **Still deferred:** CLI and
  GitHub App shapes. The tiers are additive on purpose — Professional includes Starter — because the
  author kept using `governed-discovery` while working at Professional depth, which refutes replacing it.
