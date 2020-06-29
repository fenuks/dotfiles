" autozimu/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'swift': ['sourcekit-lsp'],
    \ 'haskell': ['hie-wrapper'],
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

" prabirshrestha/vim-lsp
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/vim-lsp.log')

augroup vim_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })

    autocmd FileType rust setlocal omnifunc=lsp#complete
augroup END
    
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
endfunction

function! CocInstallSources() abort
    " call coc#add_extension('coc-json', 'coc-flutter')
    CocInstall coc-flutter
    CocInstall coc-json
    CocInstall coc-yaml
endfunction

command! CocInstallSources call CocInstallSources()
