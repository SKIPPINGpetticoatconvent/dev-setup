---
name: git-profiles
description: Manage multiple Git identities based on repository directory. Supports GitHub Work/Dark, Codeberg, GitLab, Bitbucket with auto SSH key switching.
---

# Git Profiles

## Overview

Automatically switch Git identities based on repository directory. Supports:
- GitHub Work (`~/Work/`)
- GitHub Dark (`~/Dark/`)
- Codeberg
- GitLab
- Bitbucket

## SSH Configuration

SSH keys are configured in `~/.ssh/config`:
- `id_ed25519_work` → github-work host
- `id_ed25519_dark` → github-dark host
- `id_ed25519_forge` → Codeberg / GitLab
- `id_ed25519_bitbucket` → Bitbucket

## Git Identity Management

### Auto Switch Before Push

Before running `git push`, automatically set the correct identity:

```bash
REPO_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")"

if [[ "$REPO_DIR" == ~/Work/* ]]; then
    git config user.name "SKIPPINGpetticoatconvent"
    git config user.email "146918156+SKIPPINGpetticoatconvent@users.noreply.github.com"
    git config core.sshCommand "ssh -i ~/.ssh/id_ed25519_work -o IdentitiesOnly=yes"
elif [[ "$REPO_DIR" == ~/Dark/* ]]; then
    git config user.name "youugiuhiuh"
    git config user.email "260548057+youugiuhiuh@users.noreply.github.com"
    git config core.sshCommand "ssh -i ~/.ssh/id_ed25519_dark -o IdentitiesOnly=yes"
fi
```

### Manual Identity Switch

Use `git use` command to switch identity within a repository:

```bash
git use github-work   # or: git use ghw, git use work
git use github-dark   # or: git use ghd, git use dark
git use codeberg      # or: git use gcb
git use gitlab        # or: git use ggl, git use lab
git use bitbucket     # or: git use gbb, git use bb
git use clear         # or: git use reset - clear local override
```

### Aliases

- `ghw` - GitHub Work
- `ghd` - GitHub Dark
- `gcb` - Codeberg
- `ggl` - GitLab
- `gbb` - Bitbucket
- `gis` - Show current identity status

### Custom Clone Commands

```bash
git clone-work <repo>        # Clone using GitHub Work identity
git clone-dark <repo>         # Clone using GitHub Dark identity
git clone-codeberg <repo>    # Clone using Codeberg identity
git clone-gitlab <repo>      # Clone using GitLab identity
git clone-bitbucket <repo>   # Clone using Bitbucket identity
```

### Check Current Identity

```bash
git whoami
# or
git identity
# or
git status
```

## Identity Configuration

| Provider | Name | Email | SSH Key |
|----------|------|-------|---------|
| GitHub Work | SKIPPINGpetticoatconvent | 146918156+SKIPPINGpetticoatconvent@users.noreply.github.com | id_ed25519_work |
| GitHub Dark | youugiuhiuh | 260548057+youugiuhiuh@users.noreply.github.com | id_ed25519_dark |
| Codeberg | youugiuhiuh | youugiuhiuh@noreply.codeberg.org | id_ed25519_forge |
| GitLab | youugiuhiuh | 35188180-youugiuhiuh@users.noreply.gitlab.com | id_ed25519_forge |
| Bitbucket | youugiuhiuh | youugiuhiuh@protonmail.com | id_ed25519_bitbucket |

## Show Current Profile

```bash
git profile
```

This alias shows current user settings and remotes.

## Scripts

- `show-profile.sh`: Display current Git identity
