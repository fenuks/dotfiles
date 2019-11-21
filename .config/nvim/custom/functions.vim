let g:foldmethods = {
\ 'manual': 'indent',
\ 'indent': 'expr',
\ 'expr': 'marker',
\ 'marker': 'syntax',
\ 'syntax': 'diff',
\ 'diff': 'manual'
\}

let g:auxiliary_buffers = ['qf', 'fugitiveblame', 'nerdtree']
let g:extra_auxiliary_buffers = ['ale-fix-suggest', 'help', 'git', '']

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
    if l:count is# 0
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

function! ToggleFoldmethod() abort
    let l:next_foldmethod = g:foldmethods[&foldmethod]
    execute 'setlocal foldmethod=' . l:next_foldmethod
    setlocal foldmethod?
endfunction

function! ChangeBuffer(next) abort
    if index(g:auxiliary_buffers, &filetype) !=# -1
        return
    endif
    if a:next is# 1
        bnext
    else
        bprevious
    endif
endfunction

function! CloseAuxiliaryWindows() abort
    for window in getwininfo()
        let l:bufnr = l:window['bufnr']
        let l:filetype = getbufvar(l:bufnr, '&filetype')
        if index(g:auxiliary_buffers, l:filetype) is# -1 && index(g:extra_auxiliary_buffers, l:filetype) is# -1
            continue
        endif

        execute 'bdelete ' . bufnr
    endfor
    pclose
endfunction

function! DeleteBuffers(buffers_nr) abort
    if !empty(a:buffers_nr)
        execute 'bdelete ' . join(a:buffers_nr)
    endif
endfunction

function! DeleteHiddenBuffers() abort
    let buffers=filter(getbufinfo(), 'empty(v:val.windows)')
    let buffers_nr=map(l:buffers, 'v:val.bufnr')
    call DeleteBuffers(l:buffers_nr)
endfunction

function! DeleteNamelessBuffers() abort
    let buffers=filter(getbufinfo(), 'v:val.name is# ""')
    let buffers_nr=map(l:buffers, 'v:val.bufnr')
    call DeleteBuffers(l:buffers_nr)
endfunction
