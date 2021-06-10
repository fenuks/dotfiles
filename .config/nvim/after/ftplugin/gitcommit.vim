if exists('b:did_gitcommit_ftplugin') | finish | endif
let b:did_gitcommit_ftplugin = 1
setlocal colorcolumn=72 " show vertical line at column
setlocal formatprg=par\ w71 " gq formatting program
call ConfigureLanguage()
