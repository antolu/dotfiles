## Code Best Practices

### Python

- Always type hint python code
- Always use `from __future__ import annotations`
- Use class literals as types
- Use `|` for union types
- Do not add unnecessary print statements in the code unless asked for, especially in notebooks
- Do not add code comments when the code is already readable
- When committing code and pytests are available, ensure all tests pass before commits are finalized
- In python code, prefer `import xxx.yyy` and use as `xxx.yyy.Zzz`, rather than `from xxx.yyy import Zzz` when using third-party libraries. Intra-package, `from xxx.yyy import Zzz` is preferred. Never use wildcard imports
- All imports should always be at the top of the file, unless there is an explicit reason
- When running ruff check for linting, always run as `ruff check --fix --unsafe-fixes --preview`
- In python projects, never make class based tests (class TestSomething), but prefer functional tests (def test_something), unless class-based provides an advantage for the specific tests

### General development

- Keep commit messages simple, only mentioning things that are new, have changed, or have been removed
- When making newlines in the code, you should not add whitespace in the empty lines
- Never use formal tone in coding, comments, documentation, READMEs, etc, unless explicitly asked for. Words like comprehensive, enhanced, etc are not allowed
- When adding a new feature to the code, do not plan for backwards compatibility unless explicitly asked for
- Do not under any circumstance make code that is xxx_new, xxx_unified, xxx_refactor or xxx_jax. Just write xxx and replace the old code
- Avoid phrases like "comprehensive", "key features", or similar cliché language in documentation, comments, and communications about code
- when removing files you have to use rm -f to not have to not have to provide interactive confirmation
- Always ensure pre-commit passes before attempting git commit
- NEVER FINALIZE A COMMIT WITH --no-verify IF PRE-COMMIT FAILS!!! Unless the user asks for it!
- NEVER automatically commit unless the user expliclity asks it for the specific message.
- never revert a change without the user explicitly asking for it
- don't add comments unless the user asks for it
- IMPORTANT: do not run cd unless you absolutely have to. if you run cd, immediately run pwd after to remember where you are
- avoid running mypy and ruff standalone, unless the user asks for it. prefer using pre-commit if it is configured in pyproject.toml;
- NEVER USE git add -A!!!
- Use conventional commits for commit messages, and prefer using logical or even better atomic commits if possible.
- Avoid using sed to read files. Use the Read tool with selective lines instead.

Always use:

- context7 mcp for up to date documentation on third party code
- sequential thinking mcp for any decision making
- context_mempry for searching the repository.

## Testing and Debugging Protocol

### 1. Zero Blanket Test Runs

- NEVER execute broad test suite commands (e.g., `pytest`, `npm test`, or running entire test directories) during the debugging phase.
- Do not attempt to create, write, or redirect test output to custom external log files (to avoid triggering permission prompts).

### 2. Evidence-Based Debugging via Cache

- Leverage the test runner's internal state machine to fetch previous errors.
- Always execute the "Last Failed Only" command first to inspect the current error stack:
  <!-- UPDATE THIS LINE FOR YOUR RUNNER (e.g., vitest run --changedSince=HEAD) -->
  - Command: `pytest --lf`

### 3. Isolated Verification

- When verifying a code fix, run *only* the specific file or individual test case that was broken.
- Use explicit targeting to keep the execution under 1 second:
  <!-- UPDATE THESE EXAMPLES FOR YOUR RUNNER -->
  - Single File: `pytest tests/unit/test_auth.py`
  - Single Test: `pytest tests/unit/test_auth.py::test_login_failure`

### 4. Final Gate

- You are permitted to run the full, unrestricted test suite exactly ONCE at the very end of your task, only after you are confident all isolated tests pass.
