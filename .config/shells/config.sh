if [ "${TERMINIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

set -o vi

if [[ -x $(command -v fortune) ]]; then
    fortune
fi
