---
name: git-profiles
description: Manage multiple Git identities (work, personal, etc.) based on repository directory. Uses Git's includeIf directive to automatically switch user.name and user.email based on where the repository is located.
---

# Git Profiles

## Overview

Automatically switch Git identities based on repository directory using Git's conditional includes.

## Configuration

### Main ~/.gitconfig

```gitconfig
[includeIf "gitdir:~/work/"]
    path = ~/.gitconfig-work

[includeIf "gitdir:~/personal/"]
    path = ~/.gitconfig-personal
```

### Profile ~/.gitconfig-work

```gitconfig
[user]
    name = Your Work Name
    email = you@example.com
```

### Profile ~/.gitconfig-personal

```gitconfig
[user]
    name = Your Personal Name
    email = personal@example.com
```

## Usage

Place repositories in their respective directories:
- `~/work/` → uses work identity
- `~/personal/` → uses personal identity
- Other directories → uses default identity

## Show Current Profile

```bash
git profile
```

This alias shows current user settings and remotes.

## Scripts

- `show-profile.sh`: Display current Git identity
