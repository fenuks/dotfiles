if exists('b:did_haskell_ftplugin') | finish | endif
let b:did_haskell_ftplugin = 1

compiler stack
setlocal makeprg=stack\ build
setlocal suffixesadd=.hs
setlocal path+=src

nnoremap <unique> <buffer> <silent> ]m /^\s*\w[^:=$]*\(::\\|\n\s*::\)<CR>
nnoremap <unique> <buffer> <silent> [m ?^\s*\w[^:=$]*\(::\\|\n\s*::\)<CR>

" let g:haskell_classic_highlighting = 1
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

if v:false && has('nvim-0.5')
call ConfigureNvimLsp()

lua << EOF
    local nvim_lsp = require('lspconfig')

    -- function to attach completion and diagnostics
    -- when setting up lsp
    local on_attach = function(client)
        require('completion').on_attach(client)
    end

    nvim_lsp.hls.setup({ on_attach=on_attach })
EOF
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
setlocal updatetime=300
" Show diagnostic popup on cursor hold

augroup haskell_lsp
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer>
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", aligned = true, only_current_line = false }
augroup END

" Goto previous/next diagnostic warning/error
else
" call ConfigureLanguageClient()
call ConfigureCoc()
endif
