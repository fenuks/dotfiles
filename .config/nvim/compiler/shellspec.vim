if exists('current_compiler') | finish | endif
let b:current_compiler = 'shellspec'

CompilerSet makeprg=shellspec\ --format\ f\ %
