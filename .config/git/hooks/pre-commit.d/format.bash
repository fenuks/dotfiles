#!/usr/bin/env bash
set -uo pipefail

GREEN='\033[1;32m'
RED='\033[0;31m'
RESET='\033[0m'
IFS=$'\n'

function format() {
  files="$1"
  name="$2"
  filter="$3"
  formatter="$4"
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
  ${formatter} "${supported_files}"
  git add ${supported_files}
  set +e
}

function format_sh() {
  shfmt -i 2 -p -w ${1}
}

function format_bash() {
  shfmt -i 2 -w ${1}
}

function format_clang() {
  clang-format -i ${1}
}

function format_lua() {
  stylua --config-path ~/.config/stylua/stylua.toml ${1}
}

function format_prettier() {
  prettier -w ${1}
}

function format_python() {
  black ${1}
}

function format_rust() {
  rustfmt ${1}
}

function format_zig() {
  zig fmt ${1}
}

function format_java() {
  RELEASE=1.10.0
  JAR_NAME="google-java-format-${RELEASE}-all-deps.jar"
  RELEASES_URL=https://github.com/google/google-java-format/releases/download/
  JAR_URL="${RELEASES_URL}/v${RELEASE}/${JAR_NAME}"

  CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
  FILE="${CACHE_DIR}/google-java-format-${RELEASE}.jar"

  if [[ ! -f "${FILE}" ]]; then
    if command -v wget >/dev/null; then
      wget "${JAR_URL}" -O "${FILE}".tmp
    elif command -v curl >/dev/null; then
      curl -L "${JAR_URL}" -o "${FILE}.tmp"
    else
      exit 1
    fi
    mv "${FILE}"{.tmp,}
  fi
  java -jar "${FILE}" --replace --set-exit-if-changed ${supported_files}
}

changed_files=$(git diff --cached --name-only --diff-filter=ACMRTUXB)

format "${changed_files}" 'shfmt (sh)' '\.sh$' 'format_bash'
format "${changed_files}" 'shfmt (bash)' '\.bash$' 'format_bash'
format "${changed_files}" 'clang-format' '\.(c|h|cpp|cc|hpp)$' 'format_clang'
format "${changed_files}" 'google-java-format' '\.java$' 'format_java'
format "${changed_files}" 'stylua' '\.lua$' 'format_lua'
format "${changed_files}" 'prettier' '^.+\.(md|json|js|jsx|ts|css|ya?ml|html)$' 'format_prettier'
format "${changed_files}" 'black' '\.py$' 'format_python'
format "${changed_files}" 'rustfmt' '\.rs$' 'format_rust'
format "${changed_files}" 'zig fmt' '\.zig$' 'format_zig'
