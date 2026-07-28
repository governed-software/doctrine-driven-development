#!/usr/bin/env bash
# Doctrine-Driven Development (D³) — skill installer
# https://github.com/governed-software/doctrine-driven-development
#
# Installs the governed-* skills into your engineering agent.
# Native support: Claude Code (~/.claude/skills), Codex
# ($CODEX_HOME/skills, or ~/.codex/skills), Pi
# ($PI_CODING_AGENT_DIR/skills, or ~/.pi/agent/skills),
# Kimi Code ($KIMI_CODE_HOME/skills, or ~/.kimi-code/skills), and
# OpenCode ($OPENCODE_HOME/skills, or ~/.config/opencode/skills).
#
# Usage:
#   Claude Code (default):
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash
#   Codex:
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash -s -- --codex
#   Pi:
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash -s -- --pi
#   Kimi Code:
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash -s -- --kimi
#   OpenCode:
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash -s -- --opencode
#   All five:
#     curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/v0.1.2/install.sh | bash -s -- --all
#
# Two distributions. Starter is the default; add --pro for the full pipeline.
# The agent flag and the tier flag combine, in either order:
#     ... | bash -s -- --codex --pro
#
#   Starter (3)       discovery · review · close
#                     Changes your first move. For anyone new to D³.
#   Professional (8)  Starter + scout · sdd · plan · slice · adr
#                     The whole station chain. For someone already working this way.
set -euo pipefail

# The ref this installer pulls from. A tag, never a branch: `main` moves, so a
# digest taken against it is stale by the next commit and a reader who verified
# yesterday verified something else. Override to test an unreleased tree.
D3_REF="${D3_REF:-v0.1.2}"
RAW="${D3_RAW_BASE:-https://raw.githubusercontent.com/governed-software/doctrine-driven-development/$D3_REF}"

# The fingerprint that promulgates this distribution. Printed on every run so
# what you are trusting is on screen, not implied.
D3_SIGNING_KEY="${D3_SIGNING_KEY:-7D72DEBDA1D36D34}"
STARTER_SKILLS=(governed-discovery governed-review governed-close)
PRO_ONLY_SKILLS=(governed-scout governed-sdd governed-plan governed-slice governed-adr)
SKILLS=("${STARTER_SKILLS[@]}")
TIER="starter"
CLAUDE_SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$CODEX_ROOT/skills}"
PI_AGENT_DIR="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"
PI_SKILLS_DIR="${PI_SKILLS_DIR:-$PI_AGENT_DIR/skills}"
KIMI_ROOT="${KIMI_CODE_HOME:-$HOME/.kimi-code}"
KIMI_SKILLS_DIR="${KIMI_SKILLS_DIR:-$KIMI_ROOT/skills}"
OPENCODE_ROOT="${OPENCODE_HOME:-$HOME/.config/opencode}"
OPENCODE_SKILLS_DIR="${OPENCODE_SKILLS_DIR:-$OPENCODE_ROOT/skills}"

SCRIPT_DIR=""
script_path="${BASH_SOURCE[0]:-}"
if [ -n "$script_path" ] && [ -f "$script_path" ]; then
  SCRIPT_DIR="$(cd -- "$(dirname -- "$script_path")" && pwd)"
fi
LOCAL_SOURCE_ROOT=""
if [ -z "${D3_RAW_BASE:-}" ] \
  && [ -n "$SCRIPT_DIR" ] \
  && [ -f "$SCRIPT_DIR/skills/governed-discovery/SKILL.md" ]; then
  LOCAL_SOURCE_ROOT="$SCRIPT_DIR"
fi

say() { printf '%s\n' "$*"; }

remove_paths() {
  local path
  for path in "$@"; do
    [ -z "$path" ] || rm -rf "$path" || true
  done
}

# ---------------------------------------------------------------------------
# Provenance and integrity
#
# Two different questions, deliberately kept apart because they fail apart:
#
#   integrity  — are these the bytes the manifest names?  Needs no key, costs
#                nothing, so it is never optional.
#   provenance — did an authority you recognize promulgate that manifest?  Needs
#                the public key, and it is the question ADR-19 is actually
#                about: before obeying, check that what claims to govern you
#                belongs to someone you know.
#
# Collapsing them is how a script ends up "verified" because a checksum matched
# a file the attacker also wrote. So: a bad digest always refuses; a bad
# signature always refuses; and a signature we cannot check at all is UNPROVEN —
# it does not silently pass, it asks you to say out loud that you accept it.
# ---------------------------------------------------------------------------

MANIFEST_FILE=""
PROVENANCE="unproven"

digest_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    return 1
  fi
}

refuse() {
  say ""
  say "  ✗ $1"
  shift
  local line
  for line in "$@"; do say "    $line"; done
  exit 1
}

load_manifest() {
  # Installing from a checkout you already hold: nothing crossed the network, so
  # there is nothing for this installer to attest that `git verify-tag` does not
  # attest better. Say so rather than printing a green check we did not earn.
  if [ -n "$LOCAL_SOURCE_ROOT" ]; then
    PROVENANCE="local"
    say "  · source: $LOCAL_SOURCE_ROOT (local tree, not verified here)"
    return 0
  fi

  local dir
  dir="$(mktemp -d)" || refuse "Could not create a temporary directory."
  MANIFEST_FILE="$dir/SHA256SUMS"

  curl -fsSL "$RAW/SHA256SUMS" -o "$MANIFEST_FILE" 2>/dev/null \
    || refuse "Could not download the manifest for $D3_REF." \
              "Every file this installer writes is checked against it," \
              "so it will not continue without one."

  if ! command -v gpg >/dev/null 2>&1; then
    PROVENANCE="unproven"
    return 0
  fi

  if ! curl -fsSL "$RAW/SHA256SUMS.asc" -o "$dir/SHA256SUMS.asc" 2>/dev/null; then
    PROVENANCE="unproven"
    return 0
  fi

  # gpg exits non-zero both for "bad signature" and for "I do not have that
  # key". Only the first is an attack; the second is a stranger's first run.
  # Telling them apart is the whole reason this is not a one-liner.
  local output
  output="$(gpg --status-fd 1 --verify "$dir/SHA256SUMS.asc" "$MANIFEST_FILE" 2>/dev/null)" || true
  if printf '%s' "$output" | grep -q '^\[GNUPG:\] BADSIG'; then
    refuse "The manifest signature is INVALID." \
           "This is not a missing key — the signature is present and does not" \
           "match. Do not run this installer. Report it at" \
           "https://github.com/governed-software/doctrine-driven-development/issues"
  fi
  if printf '%s' "$output" | grep -q '^\[GNUPG:\] GOODSIG'; then
    PROVENANCE="verified"
  else
    PROVENANCE="unproven"
  fi
  return 0
}

announce_provenance() {
  case "$PROVENANCE" in
    verified)
      say "  ✓ manifest signed by $D3_SIGNING_KEY — provenance VERIFIED"
      ;;
    local)
      ;;
    *)
      say "  · manifest downloaded, signature NOT checked — provenance UNPROVEN"
      say ""
      say "    D³ teaches an agent to verify what claims to govern it before"
      say "    obeying. Its own installer holds itself to that. To check this"
      say "    one, import the key that promulgates it and run again:"
      say ""
      say "      gpg --locate-keys rodrigo@teamx.agency"
      say ""
      say "    That fetches the key over Web Key Directory from teamx.agency —"
      say "    the domain in the key's own address, and an origin separate from"
      say "    the one serving this installer. Two hosts have to be compromised"
      say "    at once to agree on a lie, which is the whole point."
      say ""
      say "    If WKD is blocked, the key also ships in the tag, though that is"
      say "    weaker: it comes from the same place as what it authenticates."
      say ""
      say "      curl -fsSL $RAW/KEYS.asc | gpg --import"
      say ""
      say "    To install anyway, say so:"
      say ""
      say "      D3_ACCEPT_UNPROVEN=1 <the same command>"
      if [ "${D3_ACCEPT_UNPROVEN:-0}" != "1" ]; then
        say ""
        exit 1
      fi
      say ""
      say "    Continuing: D3_ACCEPT_UNPROVEN=1 is set."
      ;;
  esac
}

verify_digest() {
  local relative_path="$1"
  local file="$2"
  [ -n "$MANIFEST_FILE" ] || return 0

  local expected actual
  expected="$(awk -v p="$relative_path" '$2 == p || $2 == "*" p {print $1; exit}' "$MANIFEST_FILE")"
  if [ -z "$expected" ]; then
    refuse "$relative_path is not in the manifest for $D3_REF." \
           "The installer only writes files the manifest names."
  fi

  actual="$(digest_of "$file")" \
    || refuse "No sha256sum or shasum on this machine." \
              "Without one, nothing downloaded can be checked."

  if [ "$expected" != "$actual" ]; then
    refuse "$relative_path does not match the manifest." \
           "expected $expected" \
           "got      $actual" \
           "Nothing was installed."
  fi
}

fetch_file() {
  local relative_path="$1"
  local destination="$2"
  if [ -n "$LOCAL_SOURCE_ROOT" ]; then
    cp "$LOCAL_SOURCE_ROOT/$relative_path" "$destination"
  else
    curl -fsSL "$RAW/$relative_path" -o "$destination" || return 1
    verify_digest "$relative_path" "$destination"
  fi
}

usage() {
  say "Usage: install.sh [--claude|--codex|--pi|--kimi|--opencode|--all] [--starter|--pro]"
  say ""
  say "Agent:"
  say "  --claude   Install for Claude Code (default)"
  say "  --codex    Install for Codex"
  say "  --pi       Install for Pi"
  say "  --kimi     Install for Kimi Code"
  say "  --opencode Install for OpenCode"
  say "  --all      Install for Claude Code, Codex, Pi, Kimi Code, and OpenCode"
  say ""
  say "Distribution:"
  say "  --starter  3 skills — discovery, review, close (default)"
  say "             Changes your first move. Start here."
  say "  --pro      8 skills — Starter plus scout, sdd, plan, slice, adr"
  say "             The whole station chain, for someone already working this way."
}

SOURCE_FILES=()
TARGET_FILES=()
AGENT_LABELS=()
AGENT_DIRS=()

queue_portable_skills() {
  local label="$1"
  local target_dir="$2"
  AGENT_LABELS+=("$label")
  AGENT_DIRS+=("$target_dir")
  local s
  for s in "${SKILLS[@]}"; do
    SOURCE_FILES+=("skills/$s/SKILL.md")
    TARGET_FILES+=("$target_dir/$s/SKILL.md")
  done
}

queue_codex_skills() {
  AGENT_LABELS+=("Codex")
  AGENT_DIRS+=("$CODEX_SKILLS_DIR")
  local s
  for s in "${SKILLS[@]}"; do
    SOURCE_FILES+=("skills/$s/SKILL.md")
    TARGET_FILES+=("$CODEX_SKILLS_DIR/$s/SKILL.md")
    SOURCE_FILES+=("skills/$s/agents/openai.yaml")
    TARGET_FILES+=("$CODEX_SKILLS_DIR/$s/agents/openai.yaml")
  done
}

install_queued_files() {
  local -a staged_files=()
  local -a backup_files=()
  local -a backup_dirs=()
  local -a target_existed=()
  local count="${#SOURCE_FILES[@]}"
  local i j parent temporary backup backup_dir skill

  # Stage every source beside its destination so each promotion is an atomic rename.
  for ((i = 0; i < count; i++)); do
    parent="$(dirname -- "${TARGET_FILES[$i]}")"
    if ! mkdir -p "$parent"; then
      remove_paths "${staged_files[@]}"
      say "  ✗ Could not create $parent"
      return 1
    fi
    if ! temporary="$(mktemp "$parent/.d3-stage.XXXXXX")"; then
      remove_paths "${staged_files[@]}"
      say "  ✗ Could not stage ${TARGET_FILES[$i]}"
      return 1
    fi
    staged_files[$i]="$temporary"
    if ! fetch_file "${SOURCE_FILES[$i]}" "$temporary" \
      || ! chmod 0644 "$temporary"; then
      remove_paths "${staged_files[@]}"
      say "  ✗ ${SOURCE_FILES[$i]}  (install failed)"
      return 1
    fi
  done

  # Snapshot every current file before publishing any staged file. Backup
  # directories preserve regular files and symlinks, including broken links.
  for ((i = 0; i < count; i++)); do
    if [ -e "${TARGET_FILES[$i]}" ] || [ -L "${TARGET_FILES[$i]}" ]; then
      parent="$(dirname -- "${TARGET_FILES[$i]}")"
      if ! backup_dir="$(mktemp -d "$parent/.d3-backup.XXXXXX")"; then
        remove_paths "${staged_files[@]}" "${backup_dirs[@]}"
        say "  ✗ Could not preserve ${TARGET_FILES[$i]}"
        return 1
      fi
      backup="$backup_dir/original"
      if cp -Pp "${TARGET_FILES[$i]}" "$backup"; then
        backup_files[$i]="$backup"
        backup_dirs[$i]="$backup_dir"
        target_existed[$i]=1
      else
        remove_paths "$backup_dir" "${staged_files[@]}" "${backup_dirs[@]}"
        say "  ✗ Could not preserve ${TARGET_FILES[$i]}"
        return 1
      fi
    else
      backup_files[$i]=""
      backup_dirs[$i]=""
      target_existed[$i]=0
    fi
  done

  # Publish as a transaction; a failed rename restores every affected target.
  for ((i = 0; i < count; i++)); do
    # Portable mv follows a destination symlink to a directory. Unlink symlinks
    # first so the staged file replaces the link itself, never its referent.
    if [ -L "${TARGET_FILES[$i]}" ] && ! rm -f "${TARGET_FILES[$i]}"; then
      for ((j = i - 1; j >= 0; j--)); do
        if [ "${target_existed[$j]}" -eq 1 ]; then
          mv -f "${backup_files[$j]}" "${TARGET_FILES[$j]}"
          rmdir "${backup_dirs[$j]}" || true
          backup_dirs[$j]=""
        else
          rm -f "${TARGET_FILES[$j]}"
        fi
      done
      remove_paths "${staged_files[@]}" "${backup_dirs[@]}"
      say "  ✗ Could not replace ${TARGET_FILES[$i]}; previous files restored"
      return 1
    fi

    if mv -f "${staged_files[$i]}" "${TARGET_FILES[$i]}"; then
      staged_files[$i]=""
    else
      for ((j = i; j >= 0; j--)); do
        if [ "${target_existed[$j]}" -eq 1 ]; then
          mv -f "${backup_files[$j]}" "${TARGET_FILES[$j]}"
          rmdir "${backup_dirs[$j]}" || true
          backup_dirs[$j]=""
        else
          rm -f "${TARGET_FILES[$j]}"
        fi
      done
      remove_paths "${staged_files[@]}" "${backup_dirs[@]}"
      say "  ✗ Could not publish ${TARGET_FILES[$i]}; previous files restored"
      return 1
    fi
  done

  remove_paths "${backup_dirs[@]}"

  for ((i = 0; i < ${#AGENT_LABELS[@]}; i++)); do
    say "→ ${AGENT_LABELS[$i]}  (${AGENT_DIRS[$i]})"
    for skill in "${SKILLS[@]}"; do say "  ✓ $skill"; done
  done
}

note_other_agents() {
  local found=()
  [ -d "$HOME/.gemini" ] && found+=("Gemini")
  [ -d "$HOME/.cursor" ] && found+=("Cursor")
  if [ "${#found[@]}" -gt 0 ]; then
    say ""
    say "→ Also detected: ${found[*]}"
    say "  Native adapters aren't here yet. Until they are, the skills run"
    say "  anywhere as plain instructions — paste the snippet from the README"
    say "  into the agent's context. Same discipline, no install."
  fi
}

target=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --claude|--codex|--pi|--kimi|--opencode|--all)
      if [ -n "$target" ] && [ "$target" != "$1" ]; then
        say "Pick one agent flag — got $target and $1."
        say ""
        usage
        exit 2
      fi
      target="$1"
      ;;
    --starter) TIER="starter" ;;
    --pro) TIER="pro" ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 2
      ;;
  esac
  shift
done
[ -n "$target" ] || target="--claude"

if [ "$TIER" = "pro" ]; then
  SKILLS=("${STARTER_SKILLS[@]}" "${PRO_ONLY_SKILLS[@]}")
  TIER_LABEL="Professional"
else
  TIER_LABEL="Starter"
fi

say "Doctrine-Driven Development · $TIER_LABEL distribution (${#SKILLS[@]} skills)"
say "  · ref: $D3_REF"
load_manifest
announce_provenance
say ""
case "$target" in
  --claude) queue_portable_skills "Claude Code" "$CLAUDE_SKILLS_DIR" ;;
  --codex) queue_codex_skills ;;
  --pi) queue_portable_skills "Pi" "$PI_SKILLS_DIR" ;;
  --kimi) queue_portable_skills "Kimi Code" "$KIMI_SKILLS_DIR" ;;
  --opencode) queue_portable_skills "OpenCode" "$OPENCODE_SKILLS_DIR" ;;
  --all)
    queue_portable_skills "Claude Code" "$CLAUDE_SKILLS_DIR"
    queue_codex_skills
    queue_portable_skills "Pi" "$PI_SKILLS_DIR"
    queue_portable_skills "Kimi Code" "$KIMI_SKILLS_DIR"
    queue_portable_skills "OpenCode" "$OPENCODE_SKILLS_DIR"
    ;;
esac
install_queued_files
note_other_agents
say ""
if [ "$TIER" = "pro" ]; then
  say "Done. Start a new agent session. The chain:"
  say ""
  say "  scout → sdd → plan → slice → review → close → adr"
  say ""
  say "Enter wherever the artifact you already hold matches a station's input;"
  say "leave as soon as the question is answered. governed-discovery stays as"
  say "the one-minute compression of scout + sdd when the chain would be ceremony."
else
  say "Done. Start a new agent session, then ask it to build a feature —"
  say "governed-discovery frames the question before it writes code."
  say "Then ask: \"is your first move still the first?\""
  say ""
  say "Already work this way? --pro adds the other five stations."
fi
