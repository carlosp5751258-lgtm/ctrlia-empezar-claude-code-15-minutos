# How to start with Claude Code in a project: 15-minute checklist


### Minute 0-2: before opening Claude, look at the folder
When you open `claude` in a new folder the trust dialog appears, and what you accept there turns on the allow rules and additional directories in the project's `.claude/settings.json`. Before that, the project's hooks can already run (with `claude -p` they always do, even if you never trusted the folder: we checked it on this PC).

- [ ] **If the repo isn't yours, look at its configuration before opening Claude.**
  - Why: the repo's hooks, `env`, allow rules and MCP servers can act on your machine.
  - How to check it: `ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md` and read `.claude/settings.json` (hooks, env, allow), the skills in `.claude/skills/` and the servers in `.mcp.json`. The [permissions checklist](https://ctrlia.dev/en/recetas/checklist-permisos-claude-code.html) explains what to look for.
- [ ] **Commit or open a new branch.**
  - Why: `/rewind` undoes the edits Claude makes with its file tools, but not changes made only with Bash commands or by subagents: git is your safety net.
  - How to check it: a clean `git status` and `git switch -c claude/first-task`.
- [ ] **Open `claude` at the project root, not in your home folder.**
  - Why: if you start in your home folder, trust lasts only for that session and isn't saved.
  - How to check it: `git rev-parse --show-toplevel` should match the folder where you launch `claude`.
- [ ] **Read the trust dialog before accepting it.**
  - Why: it lists the rules and folders the repo would grant you.
  - How to check it: accept only if they make sense to you. If you've never seen it in that folder, `claude doctor` warns you about allow rules that are on hold.

The repository's `en/minuto-0.sh` script does this minute for you (it shows the configuration and the git status and, if you give it a name, creates the branch):

```bash
cd ~/projects/my-repo
ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md 2>/dev/null   # what configuration does it bring?
git status && git switch -c claude/first-task              # safety net
claude doctor                                               # valid settings? rules on hold?
claude                                                      # open at the root and read the trust dialog
```

### Minute 2-4: check mode, model and effort
Without configuring anything, today you don't start the way you did a few months ago.

- [ ] **Check the mode.**
  - Why: since 2.1.283, if your account and model support it, interactive sessions in the terminal and in VS Code start in **auto**: a classifier reviews commands and network requests and Claude doesn't ask you about routine things.
  - How to check it: you see it in the indicator at the bottom and change it with `Shift+Tab`. In code you don't know, start in **plan** (`/plan` or `Shift+Tab`): Claude explores and proposes without editing until you approve the plan.
- [ ] **Check the model.**
  - Why: the "Default" model is **Opus 5.5** on Pro, Max, Ultra, Team, Enterprise and the API (since 2.1.280).
  - How to check it: `/model` changes it and saves it for new sessions; in the picker, the `s` key changes it for this session only.
- [ ] **Check the effort.**
  - Why: Opus 5.5, Sonnet 5.5 and Haiku 5.5 come with **medium** effort. Phrases like "think hard" or "be thorough" are ordinary text: they don't raise the effort; `ultrathink` does ask for deeper reasoning on that turn.
  - How to check it: `/effort status` to see it, `/effort high` for hard tasks.
- [ ] **Confirm version, account and connection.**
  - Why: it's the first thing worth knowing if something doesn't behave as you expect.
  - How to check it: `/status` shows version, model, account and connection. If something doesn't load as expected, `/doctor` checks the installation, settings and CLAUDE.md, and suggests fixes it applies if you confirm.

### Minute 4-8: /init and a CLAUDE.md that doesn't get in the way
CLAUDE.md is loaded in every session and every line takes a bit of Claude's attention away in every task. The [official guide](https://code.claude.com/docs/en/best-practices) sums it up: write only what Claude can't find by reading the repo, or what it would have to look up again in every session.

- [ ] **Run `/init`.**
  - Why: Claude analyzes the code and creates a CLAUDE.md with the build and test commands and the conventions it finds. If one already exists, it suggests improvements instead of overwriting it. If it finds Codex or Gemini CLI configuration, it offers to bring it in with `/import`.
  - Guided mode: if you want a walkthrough that also proposes skills, hooks and a personal `CLAUDE.local.md`, export `CLAUDE_CODE_NEW_INIT=1` before running `/init`: it asks what you want to create and shows you a proposal before writing anything.
- [ ] **Trim what isn't needed.**
  - Why: keep the test command (the most useful line, according to the official guide), team decisions, the deployment process, required environment variables and what shouldn't be touched. Remove the folder and architecture description (Claude reads it on its own) and the capitals or "IMPORTANT".
  - How to check it: every line passes the test "would Claude find this by reading the code?". More in [a CLAUDE.md that works](https://ctrlia.dev/en/recetas/claude-md-que-funciona.html).
- [ ] **If there's already an AGENTS.md, decide how it lives with CLAUDE.md.**
  - Why: since 2.1.277 Claude Code reads AGENTS.md (from Codex or Cursor) when there's no CLAUDE.md. If you create a CLAUDE.md, AGENTS.md stops loading.
  - How to check it: if you want both, put an `@AGENTS.md` line inside the CLAUDE.md.
- [ ] **Review what gets loaded.**
  - Why: personal stuff shouldn't end up in git.
  - How to check it: `/memory` opens the loaded files for editing. Personal notes go in `CLAUDE.local.md`, out of git.

### Minute 8-10: the permissions you'll need
In Manual, approving `npm test` ten times leads you to approve without reading; in auto, you want sensitive actions to always ask.

- [ ] **Look at the active rules.**
  - Why: knowing where each rule comes from avoids surprises.
  - How to check it: `/permissions` shows the active rules and which file each comes from.
- [ ] **Add what the team always uses to `.claude/settings.json`.**
  - Why: tests and lint in **allow**, `git push` and installing packages in **ask**, and secrets in **deny** (`Read(./.env)`, `Read(./.env.*)`). Remember the order: deny → ask → allow, and an ask asks even in auto. The [permissions](https://ctrlia.dev/en/recetas/permisos-claude-code.html) recipe has the full template.
  - How to check it: if a project allow rule doesn't work, `claude doctor` in the folder tells you with "Ignoring N permissions.allow entries … this workspace has not been trusted": you still need to accept trust. And if the JSON is broken, you'll see "Invalid settings".

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": ["Bash(npm test *)", "Bash(npm run lint *)"],
    "ask": ["Bash(git push *)", "Bash(npm install *)"],
    "deny": ["Read(./.env)", "Read(./.env.*)"]
  }
}
```

It's the minimum to get started in Node (`en/settings.ejemplo.json` in the repository); replace the commands with yours.

- [ ] **Put your personal locks in `~/.claude/settings.json`.**
  - Why: they apply in every project: `deny` for `~/.ssh` and `~/.aws`, and `"disableBypassPermissionsMode": "disable"` if you don't want to slip into bypass by accident.
  - How to check it: `python3 -m json.tool ~/.claude/settings.json` and, in the session, `/permissions`.
- [ ] **Been approving the same things for days? Use `/fewer-permission-prompts`.**
  - Why: it reviews your sessions and proposes a list of read-only commands to allow in the project.
  - How to check it: review the list before accepting it.

### Minute 10-11: check /context before you start
Before your first message, the session already contains the system prompt, the tools, the MCP servers, the skills, the plugins and your CLAUDE.md files. Knowing how much space that takes saves you usage on every message.

- [ ] **Run `/context`.**
  - Why: you'll see a colored grid with usage by category, which CLAUDE.md and memory files were loaded, and suggestions when a tool or memory takes too much space.
  - If something is heavy for no reason: MCP servers you don't use in this project, turn them off in `/mcp`; skills you don't use, `/skills` and the `t` key sorts them by tokens, and `/skill-doctor` shows their cost and how much they're used; plugins, in `/plugin` the "Not used recently" heading groups the ones you don't use; a long CLAUDE.md, trim it or split the rules by folder in `.claude/rules/`.
- [ ] **Use `/clear` between tasks.**
  - Why: current models work with a 1M-token window and compact on their own around 967K, so running out of context is rare; even so, the official guide recommends `/clear` between tasks, because a focused context gives better answers and costs less. We explain it in [/clear or /compact](https://ctrlia.dev/en/recetas/clear-vs-compact.html).
  - How to check it: for your plan's usage, `/usage`.

### Minute 11-15: the first task, done right
Claude stops when the work **looks** finished. If it has nothing to run that says whether it's really finished, you become the test suite. The official guide puts it this way: give it something it can run that returns pass or fail.

- [ ] **Pick a small, real task.**
  - Why: a scoped bug or a missing test can be checked; "improve the project" can't.
  - How to check it: you can say in one sentence what "done" means.
- [ ] **Write a specific prompt.**
  - Why: which file, which symptom, what "fixed" means and how to check it. The official example replaces "fix the login bug" with: "users report that login fails after session timeout; check the token refresh in src/auth/, write a test that reproduces it, then fix it".
  - How to check it: use the first task template below (`en/primer-encargo.md` in the repository; the Spanish one is `primer-encargo.md` at the root).
- [ ] **Ask for the evidence.**
  - Why: "All tests pass" without output tells you almost nothing.
  - How to check it: the answer includes the command it ran and its output.
- [ ] **If you're not sure what you want, ask it to interview you.**
  - Why: "interview me until you can write the spec in SPEC.md", then start a clean session with that file.
  - How to check it: there's a SPEC.md you've read and approved.
- [ ] **Review before accepting anything.**
  - Why: `/diff` shows the working tree changes and `/code-review` reviews the diff in a subagent that didn't see the conversation.
  - How to check it: before merging, follow the [checklist before merging](https://ctrlia.dev/en/recetas/checklist-revisar-codigo-ia.html). Switching tasks? `/clear`.

```text
Task: <what and where: file or folder>
Symptom / goal: <what happens today and what should happen>
Done means: <test that must pass, command that must return 0, screenshot that must show>
Constraints: <no new dependencies, don't touch X, follow the pattern in Y>
At the end: paste the command you ran and its output.
```

Inside the session, in order:

```text
/status                 version, model, account
/model                  Default = Opus 5.5 (s = this session only)
/effort status          medium by default on Opus/Sonnet/Haiku 5.5
/init                   creates or improves CLAUDE.md (CLAUDE_CODE_NEW_INIT=1 for guided mode)
/memory                 review and trim what gets loaded
/permissions            active rules and which file they come from
/context                how much everything takes before you start
/plan <task>            explore without editing until you approve
/diff                   review what changed
/code-review            review in a subagent that didn't see the conversation
/clear                  when switching tasks
```

If you're going to leave the project set up for the whole team, the [project template](https://ctrlia.dev/en/recetas/plantilla-claude-code.html) has all of this in place already.

---
Full version, with common mistakes and FAQ: https://ctrlia.dev/en/recetas/empezar-claude-code-15-minutos.html · Tested with Claude Code 2.1.316 · MIT
