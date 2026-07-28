#!/usr/bin/env bash
# Anchors a file's existence to a time nobody here controls.
#
#   tools/timestamp.sh REFUTATION.md.asc
#
# Writes <file>.digicert.tsr and <file>.sectigo.tsr — RFC 3161 timestamp tokens
# from two independent authorities.
#
# Why this exists: a signature says who, not when. The "when" of a promulgation
# was signed by the same key it constrains, so the authority was certifying its
# own date — consistent, and not independent. A key compromised later could
# promulgate law backdated to before the compromise, and nothing in the record
# would contradict it.
#
# Why two: one timestamping authority is one party to trust, which is the
# problem restated at a different address. Two, chaining to different roots,
# have to agree — and an attacker needs both.
#
# Why these two: DigiCert and Sectigo chain to roots already in every standard
# trust store, so a stranger verifies with the openssl they already have and
# downloads nothing. FreeTSA was tested and dropped: it requires importing its
# own root first, and a verification step most people will skip is a
# verification step that does not exist.
#
# What to timestamp: the SIGNATURE, not the document. A token over the .asc
# proves the signature existed by then, which implies the document existed AND
# had been signed — strictly more than proving the document existed.
set -euo pipefail

TARGET="${1:-}"
[ -n "$TARGET" ] || { echo "usage: tools/timestamp.sh <file>" >&2; exit 2; }
[ -f "$TARGET" ] || { echo "no such file: $TARGET" >&2; exit 2; }

command -v openssl >/dev/null || { echo "openssl is required" >&2; exit 2; }

request="$(mktemp)"
trap 'rm -f "$request"' EXIT

# -cert asks the TSA to embed its certificate chain in the token, so verifying
# needs the file and a trust store — nothing fetched at verification time.
openssl ts -query -data "$TARGET" -sha256 -cert -out "$request" 2>/dev/null

stamp() {
  local name="$1" url="$2" out="$TARGET.$1.tsr"

  if ! curl -fsS -H "Content-Type: application/timestamp-query" \
       --data-binary "@$request" "$url" -o "$out" --max-time 30; then
    echo "  ✗ $name did not answer" >&2
    rm -f "$out"
    return 1
  fi

  # Verify before keeping it. An unverifiable token is worse than none: it
  # looks like an anchor in the directory listing and holds nothing.
  if ! openssl ts -verify -data "$TARGET" -in "$out" -CApath /etc/ssl/certs >/dev/null 2>&1; then
    echo "  ✗ $name returned a token that does not verify — discarded" >&2
    rm -f "$out"
    return 1
  fi

  local when
  when="$(openssl ts -reply -in "$out" -text 2>/dev/null | sed -n 's/^Time stamp: //p')"
  echo "  ✓ $name  $when"
}

ok=0
stamp digicert http://timestamp.digicert.com && ok=$((ok + 1))
stamp sectigo  http://timestamp.sectigo.com  && ok=$((ok + 1))

# One token is a single party to trust; the point of this script is not having
# one. Refuse rather than quietly ship half the guarantee.
#
# And take the survivor with it. The first version left the successful token on
# disk while refusing, so the directory showed an anchor the script had just
# declined to stand behind — a refusal that leaves its artifact lying around is
# read as success by everyone who does not check the exit code.
if [ "$ok" -lt 2 ]; then
  rm -f "$TARGET".digicert.tsr "$TARGET".sectigo.tsr
  echo "REFUSING: $ok of 2 authorities answered with a verifiable token." >&2
  echo "A single timestamp is one party to trust, which is what this replaces." >&2
  echo "No token was kept — half the guarantee is not a smaller guarantee." >&2
  exit 1
fi
