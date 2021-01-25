if exists('b:did_lua_ftplugin')
    finish
endif
let b:did_lua_ftplugin = 1


if !has('nvim-0.5')
call ConfigureLsc()
endif
