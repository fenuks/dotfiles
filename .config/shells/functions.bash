function ssh-plasma() {
  ssh-agent -a "${SSH_AUTH_SOCK}"
  ssh-add ~/.ssh/id_!(*.pub) </dev/null
}
