if exists('b:did_lua_ftplugin')
    finish
endif
let b:did_lua_ftplugin = 1


if has('nvim-0.5')
call ConfigureNvimLsp()

lua << EOF
    local config = require('lspconfig')

    -- function to attach completion and diagnostics
    -- when setting up lsp
    local on_attach = function(client)
        require('completion').on_attach(client)
    end

    config.sumneko_lua.setup({ 
        on_attach=on_attach
    })
EOF
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" Show diagnostic popup on cursor hold
augroup lua_lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer>
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", aligned = true, only_current_line = false }
augroup END
else
call ConfigureLsc()
endif
