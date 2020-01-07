set spelllang=pl,en_gb
digraph !! 8252 " ‼
digraph ?! 8264 " ⁈
digraph !? 8265 " ⁉
set spellcapcheck=

augroup natural_language
    autocmd!
    autocmd FileType gitcommit,hgcommit,org,help setlocal spell dictionary+=/usr/share/dict/polish
augroup END

function! Mkspell() abort
    for spellfile in split(glob('~/.config/nvim/spell/*.add'), '\n')
        execute 'mkspell! ' . spellfile
    endfor
endfunction
command! Mkspell call Mkspell()

" rhysd/vim-grammarous
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#use_vim_spelllang = 1
