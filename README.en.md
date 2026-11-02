# How to start with Claude Code in a project: a 15-minute checklist (Ctrl+IA)

The Spanish version is at the repository root and in [README.md](README.md); the English files are in `en/`.

Your first 15 minutes with Claude Code in a new or freshly cloned project: review the folder before trusting it, mode, model and effort, `/init` and a short CLAUDE.md, the permissions you'll need, `/context` and a first task with evidence.

Full page: https://ctrlia.dev/en/recetas/empezar-claude-code-15-minutos.html (Español: https://ctrlia.dev/recetas/empezar-claude-code-15-minutos.html)

## What's inside
| File | What for |
| --- | --- |
| `en/checklist.md` | The minute-by-minute list, to print or tick |
| `en/minuto-0.sh` | Before opening Claude: shows the configuration the folder brings and the git status and, if you give it a name, creates the working branch |
| `en/settings.ejemplo.json` | Minimal `.claude/settings.json` to get started (Node; replace the commands with yours) |
| `en/primer-encargo.md` | First task template: task, goal, what done means, constraints and evidence |

## How to use it
```bash
cd ~/projects/my-repo
/path/to/ctrlia-empezar-claude-code-15-minutos/en/minuto-0.sh claude/first-task   # without an argument it doesn't create a branch
claude                                                                       # and read the trust dialog before accepting it
```

## Tested
With Claude Code 2.1.316 on Linux: `claude doctor` and the untrusted allow rules warning, and `minuto-0.sh` inside a repo (from a subfolder, creating the branch) and outside a repo (it exits with code 1). The in-session steps (`/init`, `/model`, `/context`…) come from the official docs (see the page).

## License
MIT. Copyright (c) 2026 Ctrl+IA (Carlos P.).
