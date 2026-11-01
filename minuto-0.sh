#!/usr/bin/env bash
# Minuto 0, antes de abrir Claude Code: ./minuto-0.sh [rama-nueva]
# Muestra la configuración de Claude que trae la carpeta y el estado de git.
# Si le das un nombre de rama (por ejemplo claude/primera-tarea), la crea: es tu red de seguridad.
set -euo pipefail
git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "Esto no es un repositorio git: haz git init y un primer commit antes de empezar." >&2; exit 1; }
cd "$(git rev-parse --show-toplevel)"   # abre Claude en la raíz, no en tu carpeta personal
echo "Raíz del proyecto: $PWD"

echo; echo "== ¿Qué configuración de Claude trae? (si el repo no es tuyo, léela antes de confiar)"
ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md 2>/dev/null || true

echo; echo "== git status"
git status --short --branch

if [ -n "${1:-}" ]; then
  git switch -c "$1"
fi

echo; echo "Siguiente: abre «claude» en esta carpeta y lee el diálogo de confianza antes de aceptarlo."
