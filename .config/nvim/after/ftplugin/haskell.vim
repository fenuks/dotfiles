if exists('b:did_haskell_ftplugin') | finish | endif
let b:did_haskell_ftplugin = 1

compiler stack
setlocal makeprg=stack\ build

nnoremap <script> <silent> ]m /^\s*\w[^:=$]*\(::\\|\n\s*::\)<CR>
nnoremap <script> <silent> [m ?^\s*\w[^:=$]*\(::\\|\n\s*::\)<CR>

" let g:haskell_classic_highlighting = 1
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords