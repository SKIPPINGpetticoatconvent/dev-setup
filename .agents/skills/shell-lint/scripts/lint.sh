#!/usr/bin/env bash
set -euo pipefail

usage() {
    printf 'Usage: %s <script.sh>\n' "$0"
    exit 1
}

(( "$#" )) || usage

script="$1"
if [[ ! -f "$script" ]]; then
    printf 'Error: %s not found\n' "$script" >&2
    exit 1
fi

printf 'Running ShellCheck on %s...\n' "$script"
shellcheck -S error "$script"

printf 'Formatting with shfmt...\n' 
shfmt -i 2 -w -s "$script"

printf 'Running ShellCheck again...\n'
shellcheck -S error "$script"

printf 'Done. Script is clean.\n'
