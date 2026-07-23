# Decision log — D³

The value of Discovery is measured here: not by decisions made, but by decisions **honestly deferred**.

## Deferred (no evidence yet)
- **The tool's name.** Almácigo stays for *where people germinate* (Academy/mentorship). The CLI wants
  an operative name so `xxx init` reads "I'm starting a project," not "I'm entering a philosophy."
  Decide after the method proves itself.
- **The CLI / any automation.** The method is built by hand first; automate only what the by-hand runs
  prove is worth automating.
- **The governance compiler.** It will be a piece (evidence: OverlayKit already ships one), but not
  until the front of the pipeline earns it.
- **The later stages** (SDD → Slice → Review → Evidence → ADR) and their per-stage agents. v1 is only
  the front: Constitution + Discovery.
- **Distribution shape** (CLI vs agent-kit vs GitHub App). Deferred until "what a dev installs" is
  answered by use.

## Decided (with evidence)
- **D³ lives apart — not inside Milpa.** Evidence: the doctrine already runs in three stacks/domains
  (Milpa, OverlayKit, DOM Protocol). Caging it in PHP would contradict that evidence.
- **New projects first; retrofit later (v2).** Evidence: retrofit is reverse-engineering an implicit
  constitution — a distinct, harder capability.
