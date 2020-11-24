if exists('b:did_javascript_ftplugin')
    finish
endif
let b:did_javascript_ftplugin = 1

nnoremap <unique> <buffer> <silent> gd :TernDef<CR>
nnoremap <unique> <buffer> <silent> <Leader>u :TernRefs<CR>
nnoremap <unique> <buffer> <silent> <Leader>r :TernRename<CR>
setlocal softtabstop=2 shiftwidth=2
" setlocal path=.,src,node_modules
setlocal suffixesadd=.js,.jsx

" ternjs/tern_for_vim
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
