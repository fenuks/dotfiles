" Shougo/deoplete
let g:deoplete#sources#jedi#show_docstring=1

" natebosch/vim-lsc'
let g:lsc_server_commands = {
 \  'c': 'clangd',
 \  'javascript': {
 \    'command': 'typescript-language-server --stdio',
 \    'suppress_stderr': v:true,
 \  },
 \ 'dart': 'dart_language_server --lsp',
 \ 'haskell': 'haskell-language-server-wrapper --lsp',
 \ 'html': 'dart_language_server',
 \ 'lua': 'lua-language-server',
 \ 'python': 'pyls',
 \ 'rust': {
 \    'command': 'rust-analyzer',
 \  },
 \}
let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:true
let g:lsc_reference_highlights = v:true

function! ConfigureYcm() abort
    nnoremap <silent> <buffer> <Leader>ck :YcmShowDetailedDiagnostic<CR>
    nnoremap <silent> <buffer> <Leader>cK :YcmShowDetailedDiagnostic<CR>
    nnoremap <silent> <buffer> <Leader>cc :YcmCompleter FixIt<CR>
    nnoremap <silent> <buffer> <Leader>ci :YcmCompleter OrganizeImports<CR>
    nnoremap <silent> <buffer> g% :YcmCompleter GoToInclude<CR>
    nnoremap <silent> <buffer> <C-]> :YcmCompleter GoTo<CR>
    nnoremap <silent> <buffer> gd :YcmCompleter GoToDefinition<CR>
    nnoremap <silent> <buffer> gD :YcmCompleter GoToDeclaration<CR>
    nnoremap <silent> <buffer> gy :YcmCompleter GoToImplementation<CR>
    nnoremap <silent> <buffer> <Leader>gu :YcmCompleter GoToReferences<CR>
    nnoremap <silent> <buffer> <Leader>K :YcmCompleter GetType<CR>
    nnoremap <silent> <buffer> K :YcmCompleter GetDoc<CR>
    nnoremap <silent> <buffer> <Leader>rn :YcmCompleter RefactorRename
    nnoremap <buffer> <silent> gw :YcmCompleter Format<CR>
    vnoremap <buffer> <silent> gw :YcmCompleter Format<CR>
    call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction

" Valloric/YoutCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_semantic_triggers =  {}
let g:ycm_language_server = []

function! ConfigureLsc() abort
    call deoplete#custom#buffer_option('auto_complete', v:false)
    LSClientEnable
    nnoremap <silent> <buffer> <C-]>                   :LSClientGoToDefinition<CR>
    nnoremap <silent> <buffer> <C-W>]                  :LSClientGoToDefinitionSplit<CR>
    nnoremap <silent> <buffer> <C-W><C-]>              :LSClientGoToDefinitionSplit<CR>
    nnoremap <silent> <buffer> gr                      :LSClientFindReferences<CR>
    nnoremap <silent> <buffer> <C-n>                   :LSClientNextReference<CR>
    nnoremap <silent> <buffer> <C-p>                   :LSClientPreviousReference<CR>
    nnoremap <silent> <buffer> gI                      :LSClientFindImplementations<CR>
    nnoremap <silent> <buffer> go                      :LSClientDocumentSymbol<CR>
    nnoremap <silent> <buffer> gS                      :LSClientWorkspaceSymbol<CR>
    nnoremap <silent> <buffer> ga                      :LSClientFindCodeActions<CR>
    nnoremap <silent> <buffer> gR                      :LSClientRename<CR>
    nnoremap <silent> <buffer> gm                      :LSClientSignatureHelp<CR>
    " LSClientAllDiagnostics
    " LSClientWindowDiagnostics
    " LSClientLineDiagnostics
    setlocal keywordprg=:LSClientShowHover
    setlocal shortmess-=F
endfunction

function! ConfigureDeoplete() abort
    if has('nvim')
        lua require('cmp').setup.buffer { enabled = false }
    endif
    call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

command! -nargs=* Agp
\ call fzf#vim#ag(<q-args>, '2> /dev/null',
\                 fzf#vim#with_preview({'left':'90%'},'up:60%'))

imap <silent> <unique> <c-x><c-f> <Plug>(fzf-complete-path)
