# aliases compatible with POSIX shell syntax

alias vd='vim $(find_up docker-compose.yml)'
alias vD='vim $(find_up Dockerfile)'
alias vgs='vim $(gs)'
alias vg='vim $(gf)'
alias vm='vim $(find_up Makefile)'
alias vp='vim $(find_up PKGBUILD)'
alias vrd='vim $(find_up requirements-dev.txt)'
alias vr='vim $(find_up requirements.txt)'

if command -v delta >/dev/null; then
  if [[ "${TERM_BG_BRIGHT}" -ne 1 ]]; then
    alias delta='delta --plus-color="#274916" --minus-color="#5e1b1b"'
    export GIT_PAGER='delta --plus-color="#274916" --minus-color="#5e1b1b"'
  else
    export GIT_PAGER=delta
  fi
fi
