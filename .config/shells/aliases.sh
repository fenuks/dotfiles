# aliases compatible with POSIX shell syntax

alias vd='vim $(find_up docker-compose.yml)'
alias vD='vim $(find_up Dockerfile)'
alias vgs='vim $(gs)'
alias vg='vim $(gf)'
alias vm='vim $(find_up Makefile)'
alias vp='vim $(find_up PKGBUILD)'
alias vrd='vim $(find_up requirements-dev.txt)'
alias vr='vim $(find_up requirements.txt)'
alias vt='vim $(find . -type f -exec grep -Iq . {} \; -print)'
alias vt.='vim $(find . -type f -maxdepth 1 -exec grep -Iq . {} \; -print)'

if command -v delta >/dev/null; then
  export GIT_PAGER=delta
fi
