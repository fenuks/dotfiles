" Shougo/deoplete
let g:deoplete#sources#jedi#show_docstring=1

" autozimu/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'swift': ['sourcekit-lsp'],
    \ 'haskell': ['haskell-language-server-wrapper', '--lsp'],
    \ 'java': ['jdtls', '-javaagent:/usr/share/java/lombok/lombok.jar', '-Xbootclasspath/p:/usr/share/java/lombok/lombok.jar'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'xml': ['lsp4xml'],
    \ 'yaml': ['yaml-language-server', '--stdio'],
    \ 'mvn_pom': ['lsp4xml'],
    \ 'vue': ['vls'],
    \ }
    " \ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],
    " \ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],

let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile='/tmp/lc.log'
let g:LanguageClient_serverStderr = '/tmp/ls.log'

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

function! ConfigureLanguageClient() abort
    nnoremap <silent> <buffer> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> <buffer> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <buffer> gD :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent> <buffer> <C-w>d :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
    nnoremap <silent> <buffer> <C-w><C-d> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
    nnoremap <silent> <buffer> <Leader>rn :call LanguageClient_textDocument_rename()<CR>
    nnoremap <silent> <buffer> <Leader>gt :call LanguageClient_workspace_symbol()<CR>
    nnoremap <silent> <buffer> <Leader>gT :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <silent> <buffer> <Leader>gu :call LanguageClient_textDocument_references()<CR>
    nnoremap <silent> <buffer> <Leader>lq :call LanguageClient_textDocument_formatting()<CR>
    nnoremap <silent> <buffer> <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
    " LanguageClient_textDocument_implementation()
    " setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
    " setlocal omnifunc=LanguageClient#complete
    LanguageClientStart
endfunction

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
