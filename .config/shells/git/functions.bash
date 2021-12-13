set -euo pipefail

function amr {
  url="$(url $@)"
  curl -sL "${url}.patch" | git am
}

function ar {
  url="$(url $@)"
  curl -sL "${url}.diff" | git apply
}

function url {
  if [[ $# -eq 0 ]]; then
    exit 1
  fi
  remote="origin"
  pull_id=""
  if [[ $# -eq 1 ]]; then
    if [[ "${1:0:4}" == "http" ]]; then
      echo "${1}"
      return
    else
      remote="origin"
      pull_id="$1"
    fi
  fi
  if [[ $# -eq 2 ]]; then
    remote="$1"
    pull_id="$2"
  fi
  remote_url="$(git remote get-url "${remote}")"
  if [[ "${remote_url:0:3}" == 'git' ]]; then
    pr="${remote_url#*:}"
    pr="${pr%.*}"
    pr="https://github.com/${pr}/pull/${pull_id}"
  else
    pr="${remote_url}/pull/${pull_id}"
  fi
  echo "${pr}"
}
