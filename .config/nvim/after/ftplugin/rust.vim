if exists('b:did_rust_ftplugin')
    finish
endif
let b:did_rust_ftplugin = 1

nnoremap <buffer> <silent> gd <Plug>(rust-def)
nnoremap <buffer> <silent> <C-]> <Plug>(rust-def)
nnoremap <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
nnoremap <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)
nnoremap <buffer> <silent> K <Plug>(rust-doc)
