---
name: shell-lint
description: Lint and format Shell scripts using ShellCheck and shfmt with indentation 2. Use when writing, reviewing, or refactoring bash/sh scripts to ensure code quality, consistency, and adherence to best practices.
---

# Shell Lint

## Quick Start

Run ShellCheck and shfmt on shell scripts:

```bash
shellcheck your-script.sh
shfmt -i 2 -w -s your-script.sh
```

## Tools

### ShellCheck
Static analysis tool for shell scripts. Detects bugs, stylistic issues, and suspicious constructs.

### shfmt
Shell formatter that normalizes indentation and style. Uses:
- `-i 2`: 2-space indentation
- `-w`: Write output to file (in-place)
- `-s`: Simplify the code

## Workflow

1. Run ShellCheck to identify issues:
   ```bash
   shellcheck -S error your-script.sh
   ```

2. Fix all ShellCheck warnings and errors

3. Format with shfmt:
   ```bash
   shfmt -i 2 -w -s your-script.sh
   ```

4. Re-run ShellCheck to verify

## Common ShellCheck Fixes

- Use `[[ ]]` instead of `[ ]` for tests
- Quote variables: `"$var"` not `$var`
- Use `$()` instead of backticks
- Declare variables with `local` in functions
- Use `set -euo pipefail` for error handling

## Scripts

- `lint.sh`: Lint and format a shell script
