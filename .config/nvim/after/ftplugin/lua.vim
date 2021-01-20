if exists('b:did_lua_ftplugin')
    finish
endif
let b:did_lua_ftplugin = 1


if has('nvim-0.5')
call ConfigureNvimLsp()
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" Show diagnostic popup on cursor hold
augroup lua_lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
augroup END
else
call ConfigureLsc()
endif
