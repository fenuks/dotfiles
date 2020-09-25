if exists('b:did_openapi_ftplugin')
    finish
endif
let b:did_openapi_ftplugin = 1
setlocal foldlevelstart=2
setlocal suffixesadd=.yaml,.yml
setlocal include='\\zs[^#]\\+\\ze#
setlocal define=^\\s*\\ze\\i:
nnoremap <buffer> <c-]> ]<C-i>
