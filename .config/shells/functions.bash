function ssh-plasma() {
  ssh-agent -a "${SSH_AUTH_SOCK}"
  ssh-add ~/.ssh/id_!(*.pub) </dev/null
}

dir_bash() {
  local selected="$(fzf_dir)"
  selected="$(escape_path "${selected}")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gf_bash() {
  local selected="$(gf)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gs_bash() {
  local selected="$(gs)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gb_bash() {
  local selected="$(gb)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gt_bash() {
  local selected="$(gt)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gh_bash() {
  local selected="$(gh)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

gr_bash() {
  local selected="$(gr)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}
