if exists('b:did_rust_ftplugin')
    finish
endif
let b:did_rust_ftplugin = 1

nnoremap <unique> <buffer> <silent> gd <Plug>(rust-def)
nnoremap <unique> <buffer> <silent> <C-]> <Plug>(rust-def)
nnoremap <unique> <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
nnoremap <unique> <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)
nnoremap <unique> <buffer> <silent> K <Plug>(rust-doc)


if has('nvim-0.5')
call ConfigureNvimLsp()

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
setlocal updatetime=300
" Show diagnostic popup on cursor hold

augroup rust_lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer>
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", aligned = true, only_current_line = false }
augroup END
else
call ConfigureLsc()
endif
