if exists('b:did_javascript_ftplugin')
    finish
endif
let b:did_javascript_ftplugin = 1

setlocal softtabstop=2 shiftwidth=2
" setlocal path=.,src,node_modules
setlocal suffixesadd=.js,.jsx

if !has('nvim-0.5')
call ConfigureYcm()
endif
