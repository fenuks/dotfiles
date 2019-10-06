let g:foldmethods = {
\ 'manual': 'indent',
\ 'indent': 'expr',
\ 'expr': 'marker',
\ 'marker': 'syntax',
\ 'syntax': 'diff',
\ 'diff': 'manual'
\}

let g:ignored_buffers = ['nerdtree', 'qf']

function! GetSessionName() abort
    " return g:vim_sesssions_dir . '/' . fnamemodify(getcwd(), ':p:h:t') . '.vim'
    return fnamemodify(getcwd(), ':p:h:t') . '.vim'
endfunction

function! WrapListCommand(command, wrapping_command) abort
    try
        execute a:command
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:wrapping_command
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        echo 'No errors'
    endtry
endfunction

function! Execute(commands) abort
    """Executes array of commands respecting count""""
    let l:count = v:count
    if l:count == 0
        let l:count = 1
    endif
    let l:command = join(a:commands, '|')
    for i in range(1, l:count)
        execute l:command
    endfor
endfunction

function! Conflict(reverse) abort
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

function! ConfigurePkgbuild() abort
    setlocal makeprg=makepkg
    nnoremap <buffer> <Leader>mi :make -i<CR>
    nnoremap <buffer> <Leader>mb :make<CR>
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal filetype=sh
endfunction

function! ConfigureLanguageClient() abort
    nnoremap <silent> <buffer> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> <buffer> <Leader>gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <buffer> <Leader>rn :call LanguageClient_textDocument_rename()<CR>
    nnoremap <silent> <buffer> <Leader>gt :call LanguageClient_workspace_symbol()<CR>
    nnoremap <silent> <buffer> <Leader>gT :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <silent> <buffer> <Leader>lu :call LanguageClient_textDocument_references()<CR>
    nnoremap <silent> <buffer> <Leader>lq :call LanguageClient_textDocument_formatting()<CR>
    nnoremap <silent> <buffer> <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
    " setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
    " setlocal omnifunc=LanguageClient#complete
endfunction

function! ConfigureCoc() abort
    nnoremap <silent> K :call CocAction('doHover')<CR>
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> <leader>rn <Plug>(coc-rename)
endfunction

function! ToggleFoldmethod() abort
    let l:next_foldmethod = g:foldmethods[&foldmethod]
    execute 'setlocal foldmethod=' . l:next_foldmethod
    setlocal foldmethod?
endfunction

function! ChangeBuffer(next) abort
    if index(g:ignored_buffers, &filetype) !=# -1
        return
    endif
    if a:next ==# 1
        bnext
    else
        bprevious
    endif
endfunction
