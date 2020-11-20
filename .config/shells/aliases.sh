# aliases compatible with POSIX shell syntax

alias vg='vim $(gf)'
alias vd='vim $(find-up docker-compose.yml)'
alias vD='vim $(find-up Dockerfile)'
alias vm='vim $(find-up Makefile)'
alias vp='vim $(find-up PKGBUILD)'
alias vr='vim $(find-up requirements.txt)'
alias vrd='vim $(find-up requirements-dev.txt)'

if command -v delta > /dev/null; then
    if [[ "${TERM_BG_BRIGHT}" -ne 1 ]]; then
        alias delta='delta --plus-color="#274916" --minus-color="#5e1b1b"'
        export GIT_PAGER='delta --plus-color="#274916" --minus-color="#5e1b1b"'
    else
        export GIT_PAGER=delta
    fi
fi
