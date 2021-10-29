if exists('b:did_diff_ftplugin') | finish | endif
let b:did_diff_ftplugin = 1

" setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~# '^\(diff\|---\|+++\|@@\) '
    return 1
  elseif line[0] =~# '[-+ ]'
    return 2
  else
    return 0
  endif
endfunction

