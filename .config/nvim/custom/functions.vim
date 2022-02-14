let g:foldmethods = {
\ 'manual': 'indent',
\ 'indent': 'expr',
\ 'expr': 'marker',
\ 'marker': 'syntax',
\ 'syntax': 'diff',
\ 'diff': 'manual'
\}

let g:my_colours = []
let g:my_colourscheme=g:colors_name
let g:my_airline_themes = []
let g:user_background=&background
let g:ignored_colours = ['blue', 'darkblue', 'default', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler', 'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner']
call extend(g:ignored_colours, ['corvine', 'flattened_dark']) " ignore dark colours

let g:auxiliary_buffers = ['qf',  'fugitive', 'fugitiveblame', 'nerdtree', 'help']
" buffer types to close
let g:extra_auxiliary_buffers = ['ale-fix-suggest', 'help', 'git', 'vim-plug', 'man']

function GetSessionName() abort
    return fnamemodify(getcwd(), ':p:h:t') . '.vim'
endfunction

" Run command until exception, then write second one
" useful for commands linke `lnext` and `lfirst`
function WrapListCommand(command, wrapping_command) abort
    try
        execute a:command
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:wrapping_command
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        echo 'No errors'
    endtry
endfunction

" Run substitude with not hlsearch, useful for for mappings
function SubstituteNoHs(query) abort range
    try
        execute a:query
    catch /E486/
        echo 'no substitude match'
    endtry
endfunction

" Executes array of commands respecting count
function Execute(commands, count) abort
    let l:command = join(a:commands, '|')
    for i in range(1, a:count)
        execute l:command
    endfor
endfunction

" delete with count, but respecting cursor column at current line
function DK() abort
    execute 'normal D' . v:count1 . 'k' . v:count1 . 'ddk'
endfunction

" delete with count, but respecting cursor column at current line
function DJ() abort
    execute 'normal Dj' . v:count1 . 'dd'
endfunction

" search for vcs conflict marker
function Conflict(reverse) abort
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

" toggles between fold methods
function ToggleFoldmethod() abort
    let l:next_foldmethod = g:foldmethods[&foldmethod]
    execute 'setlocal foldmethod=' . l:next_foldmethod
    setlocal foldmethod?
endfunction

" changes buffer, but ignores special ones like help, fugitive, etc.
function ChangeBuffer(next) abort
    if index(g:auxiliary_buffers, &filetype) !=# -1
      if a:next is# 1
        execute 'wincmd w'
      else
        execute 'wincmd W'
      endif
      return
    endif
    if a:next is# 1
        bnext
    else
        bprevious
    endif
endfunction

function CommandOnBuffer(cmd) abort
    if index(g:auxiliary_buffers, &filetype) !=# -1
        return
    endif
    if index(g:extra_auxiliary_buffers, &filetype) !=# -1
        return
    endif
    execute a:cmd
endfunction

function ChecktimeFileBuffer() abort
    if &buftype !=# 'nofile'
        checktime
    endif
endfunction

" close special buffers
function CloseAuxiliaryWindows() abort
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

" diff current buffer contents with contents on the filesystem
function DiffOrig() abort
    let l:original_filetype=&filetype
    vert new
    setlocal buftype=nofile
    setlocal nobuflisted
    execute 'setlocal filetype=' . l:original_filetype
    read #
    normal! 0d_
    diffthis
    wincmd p
    diffthis
endfunction
command! -nargs=0 DiffOrig call DiffOrig()

" delete all buffer by their ids
function DeleteBuffers(buffers_nr) abort
    if !empty(a:buffers_nr)
        execute 'bdelete ' . join(a:buffers_nr)
    endif
endfunction

" delete all hidden buffers
function DeleteHiddenBuffers() abort
    let buffers=filter(getbufinfo(), 'empty(v:val.windows)')
    let buffers_nr=map(l:buffers, 'v:val.bufnr')
    call DeleteBuffers(l:buffers_nr)
endfunction

" delete all buffers without name
function DeleteNamelessBuffers() abort
    let buffers=filter(getbufinfo(), 'v:val.name is# ""')
    let buffers_nr=map(l:buffers, 'v:val.bufnr')
    call DeleteBuffers(l:buffers_nr)
endfunction

function DeleteBufsOnLeft() abort
    let l:cur_buf = bufnr()
    let l:buffers = []
    for buf in getbufinfo({'buflisted': 1})
        let l:buf_nr = l:buf.bufnr
        if l:buf_nr ==# l:cur_buf
            if !empty(l:buffers)
                execute 'bdelete ' . join(l:buffers)
            endif
            break
        endif
        call insert(l:buffers, l:buf_nr)
    endfor
endfunction

function DeleteBufsOnRight() abort
    let l:cur_buf = bufnr()
    let l:buffers = []
    for buf in reverse(getbufinfo({'buflisted': 1}))
        let l:buf_nr = l:buf.bufnr
        if l:buf_nr ==# l:cur_buf
            if !empty(l:buffers)
                execute 'bdelete ' . join(l:buffers)
            endif
            break
        endif
        call insert(l:buffers, l:buf_nr)
    endfor
endfunction

" read skeleton file for given filetype
function ReadSkeletonFile() abort
    let l:skeleton_file = g:nvim_dir_path . 'templates/skeleton.' . &filetype
    if filereadable(l:skeleton_file)
        execute (line('.') - 1) . 'read ' . l:skeleton_file
    else
        echo 'Skeleton file ' . l:skeleton_file . " doesn't exist"
    endif
endfunction

" search manual for cmake filetypes
function SearchCmakeMan() abort
    let l:cursor_word = expand('<cword>')
    if IsUpper(l:cursor_word)
        call SearchMan('cmake-variables', '<cfile>')
    else
        call SearchMan('cmake-commands', '<cfile>')
    endif
endfunction

" returns true if string is in uppercase
function IsUpper(string) abort
    echom a:string
    return toupper(a:string) ==# a:string
endfunction

" search for word at curson in specific man page
function SearchMan(page, prefix, expr) abort
    let l:cursor_word = expand(a:expr)
    execute 'Man ' . a:page
    call search('\C\(\s\{2,\}\)\@<=' . a:prefix . l:cursor_word)
endfunction

" search for word under cursor in search engine
function SearchWeb() abort
    let l:text = expand('<cWORD>')
    call jobstart(['firefox', 'https://duckduckgo.com?q=' . l:text])
endfunction

" search for selected text in search engine
function SearchWebVisual() abort
    let l:text = GetVisualSelection()
    call jobstart(['firefox', 'https://duckduckgo.com?q=' . l:text])
endfunction

" open URL under cursor in web browser
function OpenUrl() abort
    let l:text = expand('<cfile>')
    call jobstart(['firefox', l:text])
endfunction

" open selected text as URL
function OpenUrlVisual() abort
    let l:text = GetVisualSelection()
    call jobstart(['firefox', l:text])
endfunction

" gets text between two marks
function GetSelection(left, right) abort
    let [l:line_start, l:column_start] = getpos("'" . a:left)[1:2]
    let [l:line_end, l:column_end] = getpos("'". a:right)[1:2]
    let l:lines = getline(line_start, line_end)
    if len(l:lines) == 0
        return ''
    endif

    let l:lines[-1] = l:lines[-1][: l:column_end - 1]
    let l:lines[0] = l:lines[0][l:column_start - 1:]
    return join(l:lines, "\n")
endfunction

" gets visual selection
function GetVisualSelection() abort
    return GetSelection('<', '>')
endfunction

" gets visual selection
function GetOperatorSelection() abort
    return GetSelection('[', ']')
endfunction

" Set list of colour scheme names that we will use, except
function SetColours() abort
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let g:my_colours = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
    call RemoveSublist(g:my_colours, g:ignored_colours)
endfunction

function RemoveSublist(list, sublist) abort
    for l:value in a:sublist
        let l:index = index(a:list, l:value)
        if l:index != -1
            call remove(a:list, l:index)
        endif
    endfor
endfunction

function Rand(max) abort
    if has('vim')
        return rand() % a:max
    elseif has('nvim')
        return luaeval('math.random(0, _A.max)', {'max':a:max - 1})
    end
endfunction

function ChangeColourscheme(name) abort
  try
      let &background=g:user_background
      execute 'colorscheme ' . a:name
      redraw
      let g:my_colourscheme=a:name
      echo g:colors_name
  catch /E185:/
      echo 'missing colourscheme ' . a:name
  endtry
endfunction

function RandomColour() abort
  let l:colours_no = len(g:my_colours)
  if l:colours_no == 0
    call SetColours()
    let l:colours_no = len(g:my_colours)
  endif
  let l:next = Rand(l:colours_no)
  call ChangeColourscheme(g:my_colours[l:next])
endfunction

function NextColour(dir) abort
  let l:colours_no = len(g:my_colours)
  if l:colours_no == 0
    call SetColours()
    let l:colours_no = len(g:my_colours)
  endif
  let l:current = index(g:my_colours, g:my_colourscheme)
  let l:next = l:current + a:dir
  if a:dir == -1
      if l:next < 0
          let l:next = l:colours_no - 1
      endif
  elseif l:next >= l:colours_no
    let l:next = 0
  endif
  call ChangeColourscheme(g:my_colours[l:next])
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

function SortOperator(type) abort
    call ExOperatorFunc('!sort -h', a:type)
endfunction

function SortOperatorUnique(type) abort
    call ExOperatorFunc('!sort -hu', a:type)
endfunction

function PandocJiraOperator(type) abort
  call PandocConverter(a:type, 'jira')
endfunction

function PandocCommand(to) abort
  return '!pandoc --from ' . &filetype . ' --to ' . a:to
endfunction

function PandocFzf() abort
  call fzf#run({'source': 'pandoc --list-output-formats', 'sink': function('PandocFzfCallback')})
endfunction

function PandocFzfCallback(format) abort
  let l:command = PandocCommand(a:format)
  execute ',$' . l:command
endfunction

function PandocConverter(type, to) abort
  let l:command = PandocCommand(a:to)
  call ExOperatorFunc(l:command, a:type)
endfunction

function PandocUniversalOperator(type) abort
  let l:command = PandocCommand(input('Output type?: '))
  call ExOperatorFunc(l:command, a:type)
endfunction

function LeftAlignOperator(type) abort
    call ExOperatorFunc('left', a:type)
endfunction

function RightAlignOperator(type) abort
    call ExOperatorFunc('right', a:type)
endfunction

function CenterAlignOperator(type) abort
    call ExOperatorFunc('center', a:type)
endfunction

function JustifyOperator(type) abort
    call ExOperatorFunc('Justify', a:type)
endfunction

function JoinOperatorWithSpaces(type) abort
    call JoinWrapper(a:type, ' ')
endfunction

function JoinOperator(type) abort
    call JoinWrapper(a:type, '')
endfunction

function JoinWrapper(type, wrapper) abort
    let l:name = input('Enter separator: ')
    call ExOperatorFunc('Join "' . a:wrapper . l:name . a:wrapper . '"', a:type)
endfunction

function RunShellOperator(type) abort
    let l:command = GetOperatorSelection()
    call ExOperatorFunc('read !' . l:command, a:type)
endfunction

function FilterShellOperator(type) abort
    let l:command = GetOperatorSelection()
    call ExOperatorFunc('!' . l:command, a:type)
endfunction

function FunctionOperator(Fun) abort
    let l:reg_save = @a
    let @a = a:Fun(GetOperatorSelection())
    execute 'normal! `[v`]"ap'
    let @a = l:reg_save
endfunction

function UnescapeSelection() abort
  let l:query = substitute(@/, '\\V', '', '')
  let l:query = substitute(l:query, '\\<', '', '')
  let l:query = substitute(l:query, '\\>', '', '')
  return l:query
endfunction

function CopySelection() abort
  let l:query = UnescapeSelection()
  let @" = l:query
endfunction

function ExOperatorFunc(excommand, type) abort
    if a:type ==# 'line'
        " execute "'<,'>" . a:excommand
        execute "'[,']" . a:excommand
    elseif a:type ==# 'char'
        execute "'[,']" . a:excommand
    else
        echo 'unhandled type ' . a:type
    endif
endfunction

function OpenMan()
    try
        call man#open_page(v:count, v:count1, 'tabs', 'dirent')
    catch
        call man#open_page(v:count, v:count1, 'tabs', 'dirent.h')
    catch
    endtry
endfunction

function NewlinePaste(p_key, newline_key) abort
    let l:text = @
    let l:chars = strchars(l:text)
    let l:has_newline = strcharpart(l:text, l:chars - 1) is# "\n"
    echo v:register
    if l:has_newline
        execute 'normal "' . v:register . a:p_key
    else
        execute 'normal ' . a:newline_key . "\<ESC>\"" . v:register . a:p_key
    endif
endfunction

function DiffCurrentQuickfixEntry() abort
  cc
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    for i in reverse(range(len(diff)))
      exe (i ? 'rightbelow' : 'leftabove') 'vert diffsplit' fnameescape(diff[i].filename)
      wincmd p
    endfor
  endif
endfunction


function CustomSyntax() abort
    " highlight all trailing spaces
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+\%#\@<!$/
    " highlight VCS conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
endfunction

" taken from https://jdhao.github.io/2020/11/15/nvim_text_objects/
function URLTextObj() abort
  if match(&runtimepath, 'vim-highlighturl') != -1
    " Note that we use https://github.com/itchyny/vim-highlighturl to get the URL pattern.
    let url_pattern = highlighturl#default_pattern()
  else
    let url_pattern = expand('<cfile>')
    " Since expand('<cfile>') also works for normal words, we need to check if
    " this is really URL using heuristics, e.g., URL length.
    if len(url_pattern) <= 10
      return
    endif
  endif

  " We need to find all possible URL on this line and their start, end idx.
  " Then find where current cursor is, and decide if cursor is on one of the
  " URLs.
  let line_text = getline('.')
  let url_infos = []

  let [_url, _idx_start, _idx_end] = matchstrpos(line_text, url_pattern)
  while _url !=# ''
    let url_infos += [[_url, _idx_start+1, _idx_end]]
    let [_url, _idx_start, _idx_end] = matchstrpos(line_text, url_pattern, _idx_end)
  endwhile

  " echo url_infos
  " If no URL is found, do nothing.
  if len(url_infos) == 0
    return
  endif

  let [start_col, end_col] = [-1, -1]
  " If URL is found, find if cursor is on it.
  let [buf_num, cur_row, cur_col] = getcurpos()[0:2]
  for url_info in url_infos
    " echo url_info
    let [_url, _idx_start, _idx_end] = url_info
    if cur_col >= _idx_start && cur_col <= _idx_end
      let start_col = _idx_start
      let end_col = _idx_end
      break
    endif
  endfor

  " Cursor is not on a URL, do nothing.
  if start_col == -1
    return
  endif

  " now set the '< and '> mark
  call setpos("'<", [buf_num, cur_row, start_col, 0])
  call setpos("'>", [buf_num, cur_row, end_col, 0])
  normal! gv
endfunction

function VisualBlockOperation(operation) abort
    let l:text = input('Tekst: ')
    execute "'<,'>normal " . a:operation  . l:text
endfunction

function GatherSearchResults() abort
  let l:pattern = @/
  if !empty(l:pattern)
    let save_cursor = getpos('.')
    let orig_ft = &filetype
    " append search hits to results list
    let results = []
    execute 'g/' . l:pattern . "/call add(results, getline('.'))"
    call setpos('.', save_cursor)
    if !empty(results)
      " put list in new scratch buffer
      new
      setlocal buftype=nofile bufhidden=hide noswapfile
      execute 'setlocal filetype='.orig_ft
      call append(1, results)
      1d  " delete initial blank line
    endif
  endif
endfunction

function GoToOpenFold1(direction)
  if (a:direction ==# 1)
    normal! zj
    let start = line('.')
    while foldclosed(start) != -1
      let start = start + 1
    endwhile
  else
    normal! zk
    let start = line('.')
    while foldclosed(start) != -1
      let start = start - 1
    endwhile
  endif
  call cursor(start, 0)
endfunction

function GoToOpenFold(direction)
    let l:orig = getpos('.')
    if a:direction == 1
        normal! zj
    else
        normal! zk
    endif
    let l:line = line('.')
    while foldclosed(l:line) != -1
      let l:line = l:line + a:direction
    endwhile

    if l:line >= line('$')
        call cursor(l:orig[1], l:orig[2])
    else
        call cursor(l:line, 0)
    endif
endfunction

function CaptureEx(cmd) abort
    let l:old = @a
    redir @a
    execute 'silent ' . a:cmd
    redir END
    new
    0put a
    $delete
    0delete
    let @a = l:old
endfunction

command! -nargs=1 -complete=command CaptureEx call CaptureEx(<f-args>)

let s:roman_numbers = [
            \ [1000, 'M'], [900, 'CM'], [500, 'D'], [400, 'CD'],
            \ [100, 'C'], [90, 'XC'], [50, 'L'], [40, 'XL'],
            \ [10, 'X'], [9, 'IX'], [5, 'V'], [4, 'IV'], [1, 'I']]

function RomanNumber(number) abort
  let l:n = a:number
  let l:roman_number = ''
  for [l:arabic, l:roman] in s:roman_numbers
    while n >= l:arabic
      let l:roman_number .= l:roman
      let n -= l:arabic
    endwhile
  endfor
  return l:roman_number
endfunction

function ToBase(number, base)
    if a:number == 0
        return [0]
    endif
    let l:n = a:number
    let l:digits = []
    while l:n > 0
        let l:remainder = l:n % a:base
        let l:digits = [l:remainder] + l:digits
        let l:n /= a:base
    endwhile
    return l:digits
endfunction

function AlphaNumber(number, base, start) abort
    let l:digits = ToBase(a:number, a:base)
    if len(l:digits) > 1
        let l:digits[0] = l:digits[0] - 1
    endif
    return join(map(l:digits, 'nr2char(v:val + a:start)'), '')
endfunction


function VimFootnoteType(footnumber, type)
    if (a:type ==# 'arabic')
        return a:footnumber
    elseif a:type ==# 'roman'
        return tolower(RomanNumber(a:footnumber))
    elseif a:type ==# 'alpha'
        return AlphaNumber(a:footnumber-1, 26, 97)
    endif
endfunction

" add a footnote at the cursor position
function VimFootnotes(type)
  if exists('b:vimfootnotenumber')
      if line('.') == line('$')
        " jump back to where footnote was inserted
        execute "normal! \<C-o>a"
        return
      endif
    let b:vimfootnotenumber = b:vimfootnotenumber + 1
    let b:vimfootnotemark = VimFootnoteType(b:vimfootnotenumber, a:type)
    let l:cr = ''
  else
    let b:vimfootnotenumber = 1
    let b:vimfootnotemark = VimFootnoteType(b:vimfootnotenumber, a:type)
    let l:cr = "\<CR>"
  endif
  execute 'normal a['.b:vimfootnotemark."]\<Esc>"
  normal! G
  execute 'normal! ' . 'o' . l:cr . '[' . b:vimfootnotemark . '] '
endfunction

" TODO load directory contents into quickfix, diff conflicts, spell errors,
" buffers
" text object inner/around space

