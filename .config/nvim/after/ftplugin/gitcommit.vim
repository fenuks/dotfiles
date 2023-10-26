if exists('b:did_gitcommit_ftplugin') | finish | endif
let b:did_gitcommit_ftplugin = 1
setlocal colorcolumn=72 " show vertical line at column
setlocal textwidth=72 " max line width
setlocal formatprg=par\ w72 " gq formatting program
call ConfigureLanguage()
