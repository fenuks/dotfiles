let g:foldmethods = {
\ 'manual': 'indent',
\ 'indent': 'expr',
\ 'expr': 'marker',
\ 'marker': 'syntax',
\ 'syntax': 'diff',
\ 'diff': 'manual'
\}

let g:auxiliary_buffers = ['qf',  'fugitive', 'fugitiveblame', 'nerdtree']
" buffer types to close
let g:extra_auxiliary_buffers = ['ale-fix-suggest', 'help', 'git', 'vim-plug', '', 'man']

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

function! DK() abort
    let l:count = v:count
    if l:count is# 0
        let l:count = 1
    endif
    execute 'normal D' . l:count . 'k' . l:count . 'ddk'
endfunction

function! DJ() abort
    let l:count = v:count
    if l:count is# 0
        let l:count = 1
    endif
    execute 'normal Dj' . l:count . 'dd'
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
        let l:buftype = getbufvar(l:bufnr, '&buftype')
        if index(g:auxiliary_buffers, l:filetype) is# -1 && index(g:extra_auxiliary_buffers, l:filetype) is# -1 && l:buftype isnot# 'nofile'
            continue
        endif

        execute 'bdelete ' . bufnr
    endfor
    pclose
endfunction

function! DiffOrig() abort
    let l:original_filetype=&filetype
    vert new
    setlocal buftype=nofile
    setlocal nobuflisted
    execute 'setlocal filetype=' . l:original_filetype
    read #
    normal 0d_
    diffthis
    wincmd p
    diffthis
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

function! ReadSkeletonFile() abort
    let l:skeleton_file = g:nvim_dir_path . 'templates/skeleton.' . &filetype
    if filereadable(l:skeleton_file)
        execute (line('.') - 1) . 'read ' . l:skeleton_file
    else
        echo 'Skeleton file ' . l:skeleton_file . " doesn't exist"
    endif
endfunction

function! SearchMan(page, prefix) abort
    let l:cursor_word = expand('<cWORD>')
    execute 'Man ' . a:page
    call search('\C\(\s\{2,\}\)\@<=' . a:prefix . l:cursor_word)
endfunction

function! SearchWeb() abort
    let l:text = expand('<cWORD>')
    call jobstart(['firefox', 'https://duckduckgo.com?q=' . l:text])
endfunction

function! OpenUrl() abort
    let l:text = expand('<cWORD>')
    call jobstart(['firefox', l:text])
endfunction

function! OpenUrlVisual() abort
    let l:text = GetVisualSelection()
    call jobstart(['firefox', l:text])
endfunction

function! SearchWebVisual() abort
    let l:text = GetVisualSelection()
    call jobstart(['firefox', 'https://duckduckgo.com?q=' . l:text])
endfunction

function! GetVisualSelection() abort
    let [l:line_start, l:column_start] = getpos("'<")[1:2]
    let [l:line_end, l:column_end] = getpos("'>")[1:2]
    let l:lines = getline(line_start, line_end)
    if len(l:lines) == 0
        return ''
    endif

    let l:lines[-1] = l:lines[-1][: l:column_end - 1]
    let l:lines[0] = l:lines[0][l:column_start - 1:]
    return join(l:lines, "\n")
endfunction

let g:mycolors = []
let g:my_colorscheme=g:colors_name
let g:my_airline_themes = []
let g:user_background=&background

" Set list of color scheme names that we will use, except
function! SetColors() abort
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let g:mycolors = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
    " call RemoveSublist(g:mycolors, ['blue', 'darkblue', 'delek', 'elflord', 'evening', 'industry', 'koehler', 'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'solarized8_high', 'slate', 'torte', 'zellner'])
endfunction

function RemoveSublist(list, sublist) abort
    for l:value in a:sublist
        let l:index = index(a:list, l:value)
        if l:index != -1
            call remove(a:list, l:index)
        endif
    endfor
endfunction

function! NextColor(dir) abort
  let l:colors_no = len(g:mycolors)
  if l:colors_no == 0
    call SetColors()
    let l:colors_no = len(g:mycolors)
  endif
  let l:current = index(g:mycolors, g:my_colorscheme)
  let l:next = l:current + a:dir
  if a:dir == -1
      if l:next < 0
          let l:next = l:colors_no - 1
      endif
  elseif l:next >= l:colors_no
    let l:next = 0
  endif
  try
      let &background=g:user_background
      execute 'colorscheme '.g:mycolors[l:next]
      redraw
      let g:my_colorscheme=g:mycolors[l:next]
      echo g:colors_name
  catch /E185:/
      echo 'missing colorscheme ' . g:mycolors[l:next]
  endtry
endfunction

function NextAirlineTheme(dir)
  let l:number = len(g:my_airline_themes)
  if l:number == 0
    let g:my_airline_themes=airline#util#themes('')
    let l:number = len(g:my_airline_themes)
  endif
  let l:current = index(g:my_airline_themes, g:airline_theme)
  let l:next = l:current + a:dir
  if a:dir == -1
      if l:next < 0
          let l:next = l:number - 1
      endif
  elseif l:next >= l:number
    let l:next = 0
  endif
  let g:airline_theme=g:my_airline_themes[l:next]
  AirlineRefresh
  echo g:my_airline_themes[l:next]
endfunction

function! SortOperator(type) abort
    call OperatorFunc('!sort', a:type)
endfunction

function! LeftAlignOperator(type) abort
    call OperatorFunc('left', a:type)
endfunction

function! RightAlignOperator(type) abort
    call OperatorFunc('right', a:type)
endfunction

function! CenterAlignOperator(type) abort
    call OperatorFunc('center', a:type)
endfunction

function! JustifyOperator(type) abort
    call OperatorFunc('Justify', a:type)
endfunction

function! OperatorFunc(excommand, type) abort
    if a:type == 'line'
        execute "'[,']" . a:excommand
    else
        echo 'unhandled type ' . a:type
    endif
endfunction


nnoremap <unique> <silent> <F8> :call NextColor(1)<CR>
nnoremap <unique> <silent> <F20> :call NextColor(-1)<CR> " <S-F8>
nnoremap <unique> <silent> <F9> :call NextAirlineTheme(1)<CR>
nnoremap <unique> <silent> <F21> :call NextAirlineTheme(-1)<CR> " <S-F9>
