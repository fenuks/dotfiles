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
    setlocal spelllang=pl,en
    let l:spellfiles = map(split(&spelllang, ','), 'g:nvim_dir_path .. "/spell/" .. v:val .. ".utf-8.add"')
    let l:filetype_spellfiles = map(split(&filetype, '\.'), 'g:nvim_dir_path .. "/spell/filetype/" .. v:val .. ".utf-8.add"')
    call extend(l:spellfiles, l:filetype_spellfiles)
    " call add(l:spellfiles, g:nvim_dir_path .. '/spell/filetype/' . &filetype . '.utf-8.add'))
    let &spellfile=join(l:spellfiles, ',')
    setlocal spell dictionary+=/usr/share/dict/polish
    setlocal spelllang=pl,en_gb
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
