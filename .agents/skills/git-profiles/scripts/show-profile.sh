#!/usr/bin/env bash
set -euo pipefail

git config --show-origin --get-regexp '^(user\.|core\.sshCommand|remote\.pushDefault)' 2>/dev/null || true
echo
git remote -v
