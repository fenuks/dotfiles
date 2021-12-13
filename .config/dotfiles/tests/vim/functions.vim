let s:suite = themis#suite('functions.vim test')
let s:assert = themis#helper('assert')

profile start /tmp/vim-profile.txt
profile! file ~/.config/nvim/init.vim
profile! file ~/.config/nvim/custom/functions.vim

source ~/.config/nvim/init.vim

function! s:suite.GetSessionName()
    call s:assert.equals(GetSessionName(), 'vim.vim')
endfunction

function! s:suite.SubstituteNoHs()
    let @/ = 'test'
    call SubstituteNoHs('abc')
    call s:assert.equals(@/, 'test')
endfunction

function! s:suite.Execute()
    let g:test = ''
    let s:command = ['let g:test.="a"', 'let g:test.="b"']
    call Execute(s:command, 1)
    call s:assert.equals(g:test, 'ab')
    let g:test = ''
    call Execute(s:command, 2)
    call s:assert.equals(g:test, 'abab')
    let g:test = ''
    call Execute(s:command, 0)
    call s:assert.equals(g:test, '')
    call Execute([], 2)
    call s:assert.equals(g:test, '')
endfunction
