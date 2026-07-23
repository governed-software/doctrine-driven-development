#!/usr/bin/env bash
# Doctrine-Driven Development (D³) — skill installer
# https://github.com/governed-software/doctrine-driven-development
#
# Installs the governed-* skills into your coding agent.
# Native support today: Claude Code (~/.claude/skills). Other agents: paste the
# snippet from the README — the skills are just instructions, they run anywhere.
#
# Usage:  curl -fsSL https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main/install.sh | bash
set -euo pipefail

RAW="https://raw.githubusercontent.com/governed-software/doctrine-driven-development/main"
SKILLS=(governed-discovery governed-close governed-review)
CLAUDE_SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

say() { printf '%s\n' "$*"; }

install_claude_code() {
  say "→ Claude Code  (${CLAUDE_SKILLS_DIR})"
  mkdir -p "$CLAUDE_SKILLS_DIR"
  local s
  for s in "${SKILLS[@]}"; do
    mkdir -p "$CLAUDE_SKILLS_DIR/$s"
    if curl -fsSL "$RAW/skills/$s/SKILL.md" -o "$CLAUDE_SKILLS_DIR/$s/SKILL.md"; then
      say "  ✓ $s"
    else
      say "  ✗ $s  (download failed)"; return 1
    fi
  done
}

note_other_agents() {
  local found=()
  [ -d "$HOME/.codex" ]  && found+=("Codex")
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

say "Doctrine-Driven Development · installing the governed-* skills"
say ""
install_claude_code
note_other_agents
say ""
say "Done. In Claude Code, ask it to build a feature — governed-discovery frames"
say "the question before it writes code. Then ask: \"is your first move still the first?\""
