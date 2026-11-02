# First task template

Copy it, fill it in and paste it into Claude Code.

```text
Task: <what and where: file or folder>
Symptom / goal: <what happens today and what should happen>
Done means: <test that must pass, command that must return 0, screenshot that must show>
Constraints: <no new dependencies, don't touch X, follow the pattern in Y>
At the end: paste the command you ran and its output.
```

Example from the official best practices guide: instead of "fix the login bug", write
"users report that login fails after session timeout; check the token refresh in src/auth/,
write a test that reproduces it, then fix it".
