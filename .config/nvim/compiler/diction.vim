if exists('current_compiler') | finish | endif
let current_compiler = 'diction'

CompilerSet errorformat=%f:%l:\ %m
CompilerSet makeprg=diction\ -s\ %
