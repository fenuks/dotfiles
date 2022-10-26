if exists('b:did_openapi_ftplugin') | finish | endif
let b:did_openapi_ftplugin = 1
setlocal foldlevelstart=2
setlocal suffixesadd=.yaml,.yml
setlocal include='\\zs[^#]\\+\\ze#
let &l:define='^\s*\ze\i\+:'
nnoremap <unique> <buffer> <silent> <c-]> :call <SID>SearchDefIgnoreCase()<CR>
nmap <unique> <silent> <buffer> <Leader>gu :call <SID>Usages()<CR>
let b:tagbar_type_yaml = {
                    \  'ctagstype': 'openapi',
                    \  'kinds': [
                    \          'p:path',
                    \          'd:schema',
                    \          'P:parameter',
                    \          'R:response',
                    \          ]
                    \ }

function! s:Usages() abort
    let l:word = expand('<cword>')
    execute 'Grepper -tool rg -open -switch -noprompt -query "/components/.+/(' . l:word . ")'" . '"'
endfunction

" make jump to define case insensitive; unfortunately, it seems that only
" option to configure it is to use ignorecase, which is very useful in
" interactive use;
function! s:SearchDefIgnoreCase()
  " do not abort execution on purpose
  let l:ignorecase = &ignorecase
  let &ignorecase = 0
  set noignorecase
  call feedkeys("[\<C-d>", 'x')
  let &ignorecase = l:ignorecase
endfunction
