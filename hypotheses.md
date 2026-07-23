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
