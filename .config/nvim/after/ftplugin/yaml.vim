if exists('b:did_yaml_ftplugin')
    finish
endif
let b:did_yaml_ftplugin = 1

if search('openapi:', '', 0)
    setlocal foldlevelstart=2
    setlocal filetype+=.openapi
    setlocal foldmethod=indent
endif

setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal formatoptions+=t
setlocal formatoptions-=l
" call ConfigureCoc()
" setlocal foldmethod=indent
