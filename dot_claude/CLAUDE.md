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

- If pre-commit hooks are configured, ensure pre-commit passes before finalizing commits
- Large commits can be divided into smaller subcommits
- Keep commit messages simple, only mentioning things that are new, have changed, or have been removed
- Avoid using the term "key points" or "key anything" in documentation or comments
- When making newlines in the code, you should not add whitespace in the empty lines
- Never use formal tone in coding, comments, documentation, READMEs, etc, unless explicitly asked for. Words like comprehensive, enhanced, etc are not allowed
- Always ensure pre-commit passes before attempting git commit
- When adding a new feature to the code, do not plan for backwards compatibility unless explicitly asked for
- Do not under any circumstance make code that is xxx_new, xxx_unified, xxx_refactor or xxx_jax. Just write xxx and replace the old code
- Avoid phrases like "comprehensive", "key features", or similar cliché language in documentation, comments, and communications about code
- never commit with --no-verify to skip pre-commit hooks unless requested by the user
- when removing files you have to use rm -f to not have to not have to provide interactive confirmation
- NEVER FINALIZE A COMMIT WITH --no-verify IF PRE-COMMIT FAILS!!! Unless the user asks for it!
- Stop saying "You're absolutely right", ever. That phrase is banned. If you want to affirm agreement, find another term to use. Critisize the user's ideas if you think they are bad, don't just agree to everything.
- NEVER automatically commit unless the user expliclity asks it for the specific message.
- never revert a change without the user explicitly asking for it
- don't add comments unless the user asks for it
- never make summary documents of your work
- IMPORTANT: do not run cd unless you absolutely have to. if you run cd, immediately run pwd after to remember where you are
- IMPORTANT!!! NEVER COMMIT UNLESS THE USER ASKS FOR IT
- never create markdown files to document your work unless the user asks for it
- avoid running mypy and ruff standalone, unless the user asks for it. prefer using pre-commit if it is configured in pyproject.toml;
- NEVER USE git add -A!!!
- Use conventional commits for commit messages

Always use:

- context7 mcp for up to date documentation on third party code
- sequential thinking mcp for any decision making
