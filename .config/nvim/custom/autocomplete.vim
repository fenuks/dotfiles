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
 \  'rust': {
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

" Shougo/deoplete
" let g:deoplete#omni#input_patterns = {} " faster, called by deoplete
" let g:deoplete#omni#input_patterns._ = '.+'
" let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
" let g:deoplete#omni#input_patterns.javascript = ''
" let g:deoplete#omni#input_patterns.cpp = ['[^. *\t]\.\w*', '[^. *\t]\::\w*', '[^. *\t]\->\w*', '[<"].*/']
" let g:deoplete#omni#input_patterns.python = '.+'
" let g:deoplete#omni_patterns = {}  " slower, called by vim, https://github.com/Shougo/deoplete.nvim/issues/190
" let g:deoplete#omni_patterns._ = '.+'
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = tern#Complete
" let g:deoplete#omni#functions.python = 'jedi#completions'
" let g:deoplete#omni#functions.python = 'RopeCompleteFunc'
" DEOPLETE PLUGINS
" Plug 'tweekmonster/deoplete-clang2', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
" Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
" let g:deoplete#sources#ternjs#types = 1
" let g:deoplete#sources#ternjs#docs = 1
" deoplete-jedi

let g:deoplete#sources#jedi#show_docstring=1

" NVIM COMPLETION MANAGER
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
" Plug 'ncm2/ncm2-pyclang', { 'for': ['c', 'cpp'] }
" Plug 'ncm2/ncm2-cssomni', { 'for': ['html', 'css', 'jsx'] }
" Plug 'ncm2/ncm2-html-subscope', { 'for': 'html' }
" Plug 'ncm2/ncm2-tern',  { 'do': 'npm install', 'for': 'javascript' }
" augroup NCM
"     autocmd BufEnter * call ncm2#enable_for_buffer()
" augroup END

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


function! ConfigureCoc() abort
    nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
    nmap <buffer> <silent> gd <Plug>(coc-definition)
    nmap <buffer> <silent> gD <Plug>(coc-declaration)
    nmap <buffer> <silent> gy <Plug>(coc-type-definition)
    nmap <buffer> <silent> gy <Plug>(coc-implementation)
    nmap <buffer> <silent> <Leader>gu <Plug>(coc-references)
    vmap <buffer> <silent> gw <Plug>(coc-format-selected)
    nmap <buffer> <silent> gw <Plug>(coc-format-selected)
    nmap <buffer> <silent> <Leader>gw <Plug>(coc-format)
    nmap <buffer> <silent> <Leader>rn <Plug>(coc-rename)
    nmap <buffer> <silent> <Leader>rN <Plug>(coc-refactor)
    nmap <buffer> <silent> <Leader>cc <Plug>(coc-fix-current)
    " trigger autocomplete
    inoremap <buffer> <silent> <expr> <c-space> coc#refresh()
    " confirm completion with enter
    " disable deoplete
    call deoplete#custom#buffer_option('auto_complete', v:false)
    CocEnable
    " <Plug>(coc-diagnostic-next) 
    " <Plug>(coc-diagnostic-prev) 
    " <Plug>(coc-diagnostic-next-error)
    " <Plug>(coc-diagnostic-prev-error)
    " <Plug>(coc-codeaction)
    " <Plug>(coc-codeaction-selected)
    " <Plug>(coc-float-hide)
    " <Plug>(coc-float-jump)
    " <Plug>(coc-range-select)
    " <Plug>(coc-range-select-backward)
    " xmap if <Plug>(coc-funcobj-i)
    " xmap af <Plug>(coc-funcobj-a)
    " omap if <Plug>(coc-funcobj-i)
    " omap af <Plug>(coc-funcobj-a)
    " 
    " " Use <TAB> for selections ranges.
    " nmap <silent> <TAB> <Plug>(coc-range-select)
    " xmap <silent> <TAB> <Plug>(coc-range-select)

endfunction

function! CocInstallSources() abort
    " call coc#add_extension('coc-json', 'coc-flutter')
    CocInstall coc-flutter
    CocInstall coc-json
    CocInstall coc-yaml
endfunction

command! CocInstallSources call CocInstallSources()

function! ConfigureNvimLsp() abort
    call deoplete#custom#buffer_option('auto_complete', v:false)
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> <buffer> <Leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
    " vim.lsp.util.show_line_diagnostics()
    nnoremap <buffer> <silent> g[ <cmd>vim.lsp.diagnostic.goto_prev()<cr>
    nnoremap <buffer> <silent> g] <cmd>vim.lsp.diagnostic.goto_next()<cr>
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
