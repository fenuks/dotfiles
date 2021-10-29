if exists('current_compiler') | finish | endif
let current_compiler = 'flake8'

CompilerSet makeprg=flake8
CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m,%-G%.%#
