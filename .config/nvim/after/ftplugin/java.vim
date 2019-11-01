if exists('b:did_java_ftplugin')
    finish
endif
let b:did_java_ftplugin = 1

call ConfigureYcm()
let g:ycm_semantic_triggers.java = ['.', '@', '::']
let g:JavaComplete_EnableDefaultMappings = 0

" autocmd FileType java setlocal makeprg=mvn errorformat='[%tRROR]\ %f:[%l]\ %m,%-G%.%#'
nnoremap <buffer> <silent> <Leader>ii <Plug>(JavaComplete-Imports-AddSmart)
nnoremap <buffer> <silent> <Leader>iI <Plug>(JavaComplete-Imports-Add)
nnoremap <buffer> <silent> <Leader>ia <Plug>(JavaComplete-Imports-AddMissing)
nnoremap <buffer> <silent> <Leader>id <Plug>(JavaComplete-Imports-RemoveUnused)

nnoremap <buffer> <silent> <Leader>am <Plug>(JavaComplete-Generate-AbstractMethods)
nnoremap <buffer> <silent> <Leader>aA <Plug>(JavaComplete-Generate-Accessors)
nnoremap <buffer> <silent> <Leader>as <Plug>(JavaComplete-Generate-AccessorSetter)
nnoremap <buffer> <silent> <Leader>ag <Plug>(JavaComplete-Generate-AccessorGetter)
nnoremap <buffer> <silent> <Leader>aa <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nnoremap <buffer> <silent> <Leader>ats <Plug>(JavaComplete-Generate-ToString)
nnoremap <buffer> <silent> <Leader>aeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nnoremap <buffer> <silent> <Leader>aI <Plug>(JavaComplete-Generate-Constructor)
nnoremap <buffer> <silent> <Leader>ai <Plug>(JavaComplete-Generate-DefaultConstructor)
nnoremap <buffer> <silent> <Leader>ac <Plug>(JavaComplete-Generate-NewClass)
nnoremap <buffer> <silent> <Leader>aC <Plug>(JavaComplete-Generate-ClassInFile)

