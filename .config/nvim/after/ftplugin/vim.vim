if exists('b:did_vim_ftplugin') | finish | endif
let b:did_vim_ftplugin = 1
let g:vimsyn_embed='lP' " add syntax highlighting for lua and python snippets
nnoremap <unique> <buffer> <silent> K :help <C-r><C-w><CR>
