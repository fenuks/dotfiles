if [ "${TERMINIX_ID:-}" ] || [ "${VTE_VERSION:-}" ]; then
    source /etc/profile.d/vte.sh
fi

set -o vi
# set -o nounset # error when unset variable is referenced
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

if [[ -x $(command -v fortune) ]]; then
    if [[ -x $(command -v cowsay) ]]; then
        fortune | cowsay
    else
        fortune
    fi
fi
