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

alias cdc="cd ${XDG_CACHE_DIR:-${HOME}/.cache}"
alias cdd="cd ${XDG_DOCUMENTS_DIR:-${HOME}/Documents}"
alias cdf="cd ${XDG_VIDEOS_DIR:-${HOME}/Videos}"
alias cdg="cd ${HOME}/Gry"
alias cdk="cd ${HOME}/Kod"
alias cdm="cd ${XDG_MUSIC_DIR:-${HOME}/Music}"
alias cdn="cd ${XDG_DOCUMENTS_DIR:-${HOME}/Documents}/notatki"
alias cdp="cd ${XDG_DOWNLOAD_DIR:-${HOME}/Downloads}"
alias edit="${EDITOR}"
alias kitty-themes="cd ${HOME}/.config/kitty/themes/ && ls *.conf | fzf --preview 'head -n 40 {} && kitty @ set-colors -a -c {}'; cd -"

if command -v delta >/dev/null; then
  export GIT_PAGER=delta
fi

if command -v /usr/lib/jvm/default/bin/jshell >/dev/null; then
  alias jshell="/usr/lib/jvm/default/bin/jshell"
fi

if command -v exa >/dev/null; then
  alias l='exa'
elif command -v lsd >/dev/null; then
  alias l='lsd'
else
  alias l='ls --color --classify --human-readable'
fi

if ! command -v mutt >/dev/null; then
  alias mutt='neomutt'
fi
