#!/usr/bin/env bash
set -uo pipefail

GREEN='\033[1;32m'
RED='\033[0;31m'
RESET='\033[0m'
IFS=$'\n'

function lint() {
  files="$1"
  name="$2"
  filter="$3"
  linter="$4"
  supported_files=$(echo "$files" | grep -P "${filter}")
  if [[ $? -ne 0 ]]; then
    return
  fi
  partially_staged=$(git status --short ${supported_files} | grep -P "^(\w)[^ ]")
  if [[ $? -eq 0 ]]; then
    echo -e "${RED}Wystąpł błąd"
    echo -e "Nie można formatować plików częściowo dodanych do rewizji${RESET}"
    echo "${partially_staged}"
    exit 1
  fi

  set -e
  echo -e "${GREEN}Formatowanie używając ${name}${RESET}"
  ${linter} "${supported_files}"
  git add ${supported_files}
  set +e
}

function lint_md() {
  lychee --offline ${1}
}


changed_files=$(git diff --cached --name-only --diff-filter=ACMRTUXB)
lint "${changed_files}" 'lychee (md)' '\.md$' 'lint_md'
