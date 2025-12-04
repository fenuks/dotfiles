if exists('b:did_rust_ftplugin')
    finish
endif
let b:did_rust_ftplugin = 1

nnoremap <unique> <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
nnoremap <unique> <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)

compiler cargo

if has('nvim')
  vnoremap <silent> <buffer> J :RustJoinLines<CR>
endif
