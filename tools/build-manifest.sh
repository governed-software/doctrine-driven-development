#!/usr/bin/env bash
# Builds SHA256SUMS — the manifest the installer verifies every download against.
#
# Covers install.sh and every file the installer can fetch. Run it from the repo
# root before cutting a release; the result is committed, tagged, and signed.
#
# Reproducible on purpose: same tree in, same bytes out. Anyone can rerun this
# against the tag and compare, which is the only reason to trust the manifest at
# all — a digest nobody can regenerate is a number, not a check.
#
# KEYS.asc and SHA256SUMS.asc are deliberately NOT covered, and this is not an
# oversight to fix later. A signature cannot appear inside the thing it signs,
# and listing the public key here would be circular: the key is what verifies
# this manifest, so a digest of the key stored in the manifest guarantees
# nothing an attacker who rewrote both could not also rewrite. Their integrity
# comes from elsewhere — the signed tag, and the fingerprint published on a
# host we do not serve.
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

# LC_ALL=C so the sort order does not depend on the builder's locale. Without it
# the same tree yields different manifests on different machines, and "verify by
# rebuilding" stops working for exactly the people who bothered to try.
files=$(LC_ALL=C find install.sh skills -type f | LC_ALL=C sort)

if [ -z "$files" ]; then
  echo "REFUSING: no files to hash — wrong directory?" >&2
  exit 1
fi

# shellcheck disable=SC2086
sha256sum $files > SHA256SUMS

printf 'SHA256SUMS: %s file(s)\n' "$(wc -l < SHA256SUMS)"
