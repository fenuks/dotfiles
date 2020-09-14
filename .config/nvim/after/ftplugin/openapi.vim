if exists('b:did_openapi_ftplugin')
    finish
endif
let b:did_openapi_ftplugin = 1
setlocal suffixesadd=.yaml,.yml
