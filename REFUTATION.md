# The refutation condition of D³ itself

> Pre-registration. Written **2026-07-27** (America/Mexico_City), before any external datapoint
> existed, signed, and timestamped by two independent authorities.
> [`REFUTATION.md.asc`](REFUTATION.md.asc) is the detached signature; the key is the one that
> promulgates every release — `gpg --locate-keys rodrigo@teamx.agency`.
>
> The timestamp tokens read **2026-07-28T02:33Z**, which is the same moment: every date in this file
> is local, every token is UTC, and the six-hour offset is the whole of the difference. All deadlines
> below are dates in that same local zone.

The [constitution](constitution.md) commits to this in one line: *the methodology applies to itself; if
a claim cannot be refuted, it is not doctrine.* That line has been true of everything D³ asks of a
project and, until this document, not of D³.

The published position — *if neither condition happens, the skills are refuted, not the doctrine* — is
correct and also the most comfortable sentence in the project. It is correct because a failed
implementation genuinely does not refute a theory. It is comfortable because, left alone, it never
expires: every failure lands on the implementation, a new implementation is always possible, and the
doctrine is defended forever by a distinction that was honest when it was made. That is a protective
belt, and the moment to cut its length is now, while the number is cheap and there is no data to make
it convenient.

## What is being pre-registered

**Attempt.** One implementation of the stations, exposed publicly, with the evidence channel open.
The current `governed-*` skills are attempt **#1**.

**Materially distinct.** A second attempt counts only if it changes the **station boundaries or the
artifact contracts** — what each station refuses to do, or what it must produce. Rewording prompts,
adding agents, or renaming skills is the same attempt with a new coat. This is checkable against
[`contracts/`](contracts/) and [`pipeline.md`](pipeline.md), not a matter of opinion.

**Honest report.** An entry in [`EVIDENCE.md`](EVIDENCE.md) from someone with **no prior contact with
the author**, who used it on real work. Reports from colleagues, clients and friends are recorded and
do not count toward this threshold — they are a weaker datapoint and the ledger keeps them separate.

## The condition

On **2027-07-27**, twelve months after the evidence channel opened, exactly one of three verdicts is
published in `EVIDENCE.md`. Which one it is follows from the count, not from an argument made that day.

**1 · The attempt is refuted.** ≥ 10 honest reports, of which ≥ 8 say *nothing changed* or *it got in
the way*, and none report either ratifying outcome.

The doctrine survives this — once. It survives only if a **materially distinct** second attempt is
published within the following twelve months. If no second attempt is made by **2028-07-27**, the
doctrine is refuted too. Declining to try again is a verdict: an idea whose author will not build a
second implementation after the first failed is not being protected by the skills/doctrine
distinction, it is being retired quietly.

If a second attempt is made and reaches the same verdict, the doctrine is refuted — no third belt.

**2 · The claim survives, narrowed.** ≥ 10 honest reports with at least one ratifying outcome. The
published claim is then rewritten to say only what was observed, per distribution. If Starter's first
move changed for strangers and Professional's station refusals never mattered to anyone, that is what
gets published — not the pair.

**3 · Untested, and the distribution is what failed.** Fewer than 10 honest reports. This is **not** a
refutation of the doctrine and **not** a pass. It is published in those words, because silence has two
causes and only one of them is about the idea: people tried it and nothing happened, or nobody tried.
A threshold that ignores the difference lets obscurity look like refutation, and — worse — hands the
author a permanent excuse that no evidence can ever take away.

Verdict 3 may be declared **at most twice**. After the second, D³ stops being asserted publicly: the
landing drops the ratification claim and says the hypothesis could not be tested. Not refuted —
withdrawn. A hypothesis that stays pending indefinitely while advertising its own falsifiability is
running the protective belt by other means, and this clause is what stops that from being available.

## What this document does not decide

- **It does not judge any single report.** Counting is mechanical; the labels come from the reporter's
  own answers.
- **It does not set a bar for the skills' quality.** A skill can be bad and the doctrine sound. That is
  the distinction this document limits, not one it abolishes.
- **It does not cover the artifact contracts** in `contracts/`. Those are refuted the ordinary way — by
  a station that cannot produce what the next one needs.

## Its own death condition

This pre-registration is void if its numbers are edited after an external report exists. The git
history and the signature over this file are what make that checkable: any change to N, to the dates,
or to what counts as an honest report, made after the first entry in `EVIDENCE.md`, invalidates the
pre-registration and must be published as such. Moving the goalposts is permitted; **moving them
quietly is not.**

### The date does not rest on our word

A signature says *who*, not *when*. Signed alone, the date above would be certified by the same key it
constrains — consistent, and not independent: a key compromised later could promulgate law backdated
to before the compromise, and nothing in the record would contradict it.

So the signature over this file carries two **RFC 3161** timestamp tokens, from authorities with no
relationship to this project and none to each other:

```bash
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/REFUTATION.md
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/REFUTATION.md.asc
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/REFUTATION.md.asc.digicert.tsr
curl -fsSLO https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/REFUTATION.md.asc.sectigo.tsr

gpg --verify REFUTATION.md.asc REFUTATION.md                      # who
openssl ts -verify -data REFUTATION.md.asc \
  -in REFUTATION.md.asc.digicert.tsr -CApath /etc/ssl/certs       # when, per DigiCert
openssl ts -verify -data REFUTATION.md.asc \
  -in REFUTATION.md.asc.sectigo.tsr  -CApath /etc/ssl/certs       # when, per Sectigo
```

Both chain to roots already in a standard trust store, so nothing extra is fetched to check them. Two
rather than one because a single timestamping authority is a single party to trust, which is the
problem restated at a different address; backdating this document now requires DigiCert and Sectigo to
be wrong together.

They attest that the signature existed by that instant — never that it did not exist earlier. A
timestamp bounds the late side only. What it forecloses is precisely what matters here: adding this
pre-registration, or quietly adjusting its numbers, after the data arrived.

---

Apache-2.0 © Rodrigo Vicente - TeamX Agency
