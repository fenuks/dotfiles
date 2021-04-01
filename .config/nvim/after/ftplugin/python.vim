if exists('b:did_python_ftplugin') | finish | endif
let b:did_python_ftplugin = 1
" let g:python_recommended_style=0

let b:neoformat_run_all_formatters = 1

" davidhalter/jedi-vim
let g:jedi#completions_command = '<C-space>'
let g:jedi#goto_command = 'gd'
let g:jedi#goto_definitions_command = 'gD'
let g:jedi#rename_command = '<Leader>rn'
let g:jedi#show_call_signatures = '2'
let g:jedi#usages_command = '<Leader>u'

let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ''

" python-rope/ropevim
let g:ropevim_enable_shortcuts = 0

" fix truncated documenation in floating window problem
call deoplete#custom#source('jedi', 'max_info_width', 0)

" pytest or pyunit compiler
