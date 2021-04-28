if exists('b:did_java_ftplugin')
    finish
endif
let b:did_java_ftplugin = 1

setlocal softtabstop=2
setlocal shiftwidth=2

" fold imports and comments
function! FoldJavaExpr(lineno) abort
    return getline(a:lineno) =~# '^import\|^\s*\(\*\|\/\*\)'
endfunction

setlocal foldexpr=FoldJavaExpr(v:lnum)
setlocal foldmethod=expr

setlocal includeexpr=substitute(v:fname,'\\.','/','g') " expression to change gf filename mapping
setlocal colorcolumn=100

if exists(':YcmCompleter')
call ConfigureYcm()
let g:ycm_semantic_triggers.java = ['.', '@', '::']
let g:JavaComplete_EnableDefaultMappings = 0
endif

" autocmd FileType java setlocal makeprg=mvn errorformat='[%tRROR]\ %f:[%l]\ %m,%-G%.%#'
nnoremap <unique> <buffer> <silent> <Leader>ii <Plug>(JavaComplete-Imports-AddSmart)
nnoremap <unique> <buffer> <silent> <Leader>iI <Plug>(JavaComplete-Imports-Add)
nnoremap <unique> <buffer> <silent> <Leader>ia <Plug>(JavaComplete-Imports-AddMissing)
nnoremap <unique> <buffer> <silent> <Leader>id <Plug>(JavaComplete-Imports-RemoveUnused)

nnoremap <unique> <buffer> <silent> <Leader>am <Plug>(JavaComplete-Generate-AbstractMethods)
nnoremap <unique> <buffer> <silent> <Leader>aA <Plug>(JavaComplete-Generate-Accessors)
nnoremap <unique> <buffer> <silent> <Leader>as <Plug>(JavaComplete-Generate-AccessorSetter)
nnoremap <unique> <buffer> <silent> <Leader>ag <Plug>(JavaComplete-Generate-AccessorGetter)
nnoremap <unique> <buffer> <silent> <Leader>aa <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nnoremap <unique> <buffer> <silent> <Leader>ats <Plug>(JavaComplete-Generate-ToString)
nnoremap <unique> <buffer> <silent> <Leader>aeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nnoremap <unique> <buffer> <silent> <Leader>aI <Plug>(JavaComplete-Generate-Constructor)
nnoremap <unique> <buffer> <silent> <Leader>ai <Plug>(JavaComplete-Generate-DefaultConstructor)
nnoremap <unique> <buffer> <silent> <Leader>ac <Plug>(JavaComplete-Generate-NewClass)
nnoremap <unique> <buffer> <silent> <Leader>aC <Plug>(JavaComplete-Generate-ClassInFile)

