if exists('b:did_python_ftplugin')
    finish
endif
let b:did_python_ftplugin = 1

nnoremap <buffer> <silent> <Leader>U :YcmCompleter GoToReferences<CR>
let b:neoformat_run_all_formatters = 1
" call deoplete#custom#buffer_option('auto_complete', v:false)
