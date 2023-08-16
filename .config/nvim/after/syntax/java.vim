if exists('b:did_java_syntax')
    finish
endif
let b:did_java_syntax = 1

syn keyword javaExternal native package
syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end=+^\s*$+ transparent fold keepend
syn region javadoc start="^\s*/\*\*" end="^.*\*/" transparent fold keepend

setlocal foldmethod=expr
setlocal foldlevelstart=0
setlocal foldlevel=0

