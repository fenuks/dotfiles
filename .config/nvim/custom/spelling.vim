set spelllang=pl,en_gb
set dictionary+=/usr/share/dict/british,/usr/share/dict/polish
set thesaurus+=/usr/share/thesaurus/moby-thesaurus.txt
digraph !! 8252 " ‼
digraph ?! 8264 " ⁈
digraph !? 8265 " ⁉

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
