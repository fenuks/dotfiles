if exists('b:did_cpp_ftplugin')
    finish
endif
let b:did_cpp_ftplugin = 1

if !has('nvim-0.5')
call ConfigureLanguageClient()
endif
setlocal commentstring=/*%s*/
