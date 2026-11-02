#!/usr/bin/env bash
# Minute 0, before opening Claude Code: ./minuto-0.sh [new-branch]
# Shows the Claude configuration the folder brings and the git status.
# If you give it a branch name (for example claude/first-task), it creates it: that's your safety net.
set -euo pipefail
git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "This isn't a git repository: run git init and make a first commit before you start." >&2; exit 1; }
cd "$(git rev-parse --show-toplevel)"   # open Claude at the root, not in your home folder
echo "Project root: $PWD"

echo; echo "== What Claude configuration does it bring? (if the repo isn't yours, read it before trusting it)"
ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md 2>/dev/null || true

echo; echo "== git status"
git status --short --branch

if [ -n "${1:-}" ]; then
  git switch -c "$1"
fi

echo; echo "Next: open \"claude\" in this folder and read the trust dialog before accepting it."
