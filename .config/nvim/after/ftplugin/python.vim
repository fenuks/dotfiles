if exists('b:did_python_ftplugin') | finish | endif
let b:did_python_ftplugin = 1
" disable buggy https://github.com/Vimjas/vim-python-pep8-indent/
let b:did_indent = 1
" let g:python_recommended_style=0

let b:neoformat_run_all_formatters = 1
" pytest or pyunit compiler
