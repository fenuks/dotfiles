set spelllang=pl,en_gb
set thesaurus+=/usr/share/thes/polish
if exists('&spelloptions')
    set spelloptions=camel
endif
digraph !! 8252 " ‼
digraph ?! 8264 " ⁈
digraph !? 8265 " ⁉
set spellcapcheck=

augroup natural_language
    autocmd!
    autocmd FileType hgcommit,markdown,org,help,yaml call ConfigureLanguage()
augroup END

function! ConfigureLanguage() abort
    setlocal spelllang=pl,en_gb
    let l:spellfiles = map(split(&spelllang, ','), '$HOME .. "/.config/nvim/spell/" .. v:val .. ".utf-8.add"')
    call add(l:spellfiles, expand('~/.config/nvim/spell/filetype/' . &filetype . '.utf-8.add'))
    let &spellfile=join(l:spellfiles, ',')
    setlocal spell dictionary+=/usr/share/dict/polish
    " call airline#extensions#whitespace#disable()
endfunction

function! Mkspell() abort
    for spellfile in split(glob('~/.config/nvim/spell/**/*.add'), '\n')
        execute 'mkspell! ' . spellfile
    endfor
endfunction
command! Mkspell call Mkspell()

" rhysd/vim-grammarous
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#use_vim_spelllang = 1
