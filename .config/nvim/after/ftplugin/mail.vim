if exists('b:did_mail_ftplugin') | finish | endif
let b:did_mail_ftplugin = 1

setlocal spell
setlocal textwidth=72
setlocal formatprg=par\ w77 " gq formatting program
setlocal colorcolumn=73
setlocal formatoptions=awq
setlocal comments+=nb:>
match ErrorMsg '\s\+$'
call ConfigureLanguage()
