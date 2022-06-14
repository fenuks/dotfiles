if exists('b:did_openapi_ftplugin') | finish | endif
let b:did_openapi_ftplugin = 1
setlocal foldlevelstart=2
setlocal suffixesadd=.yaml,.yml
setlocal include='\\zs[^#]\\+\\ze#
let &l:define='^\s*\ze\i\+:'
nnoremap <unique> <buffer> <c-]> [<C-d>
nmap <unique> <silent> <buffer> <Leader>gu :call <SID>Usages()<CR>

function! s:Usages() abort
    let l:word = expand('<cword>')
    execute 'Grepper -tool rg -open -switch -noprompt -query "/components/.+/(' . l:word . ")'" . '"'
endfunction
