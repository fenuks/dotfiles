if exists('b:did_rust_ftplugin')
    finish
endif
let b:did_rust_ftplugin = 1

nnoremap <unique> <buffer> <silent> gd <Plug>(rust-def)
nnoremap <unique> <buffer> <silent> <C-]> <Plug>(rust-def)
nnoremap <unique> <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
nnoremap <unique> <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)
nnoremap <unique> <buffer> <silent> K <Plug>(rust-doc)

if !has('nvim-0.5')
call ConfigureLsc()
endif
