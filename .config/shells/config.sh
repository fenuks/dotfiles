set -o vi
# set -o nounset # error when unset variable is referenced
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber
# set -e # exit on non-zero code
# set -o nounset # error when non-set variable is accessed
set -o pipefail # return code of failed pipeline command
stty susp undef



# it adds 60ms to startup
# if [[ -x $(command -v fortune) ]]; then
#     if [[ -x $(command -v cowsay) ]]; then
#         fortune | cowsay
#     else
#         fortune
#     fi
# fi
