if exists('b:did_rust_ftplugin')
    finish
endif
let b:did_rust_ftplugin = 1

nnoremap <buffer> <silent> gd <Plug>(rust-def)
nnoremap <buffer> <silent> <C-]> <Plug>(rust-def)
nnoremap <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
nnoremap <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)
nnoremap <buffer> <silent> K <Plug>(rust-doc)


if has('nvim-0.5')
call ConfigureNvimLsp()

lua << EOF
    local nvim_lsp = require('nvim_lsp')

    -- function to attach completion and diagnostics
    -- when setting up lsp
    local on_attach = function(client)
        require('completion').on_attach(client)
        require('diagnostic').on_attach(client)
    end

    nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
EOF
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
setlocal updatetime=300
" Show diagnostic popup on cursor hold

augroup rust_lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer>
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", aligned = true, only_current_line = false }
augroup END

" Goto previous/next diagnostic warning/error
else
call ConfigureLsc()
endif
