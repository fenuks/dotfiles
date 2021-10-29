" formatting variations documented at
" https://clang.llvm.org/docs/UsersManual.html#formatting-of-diagnostics
"
" It should be possible to make this work for the combination of
" -fno-show-column and -fcaret-diagnostics as well with multiline
" and %p, but I was too lazy to figure it out.
"
" The %D and %X patterns are not clang per se. They capture the
" directory change messages from (GNU) 'make -w'. I needed this
" for building a project which used recursive Makefiles.
if exists('current_compiler') | finish | endif
let current_compiler = 'clang'

CompilerSet errorformat=
	\%f:%l%c:{%*[^}]}{%*[^}]}:\ %trror:\ %m,
	\%f:%l%c:{%*[^}]}{%*[^}]}:\ %tarning:\ %m,
	\%f:%l:%c:\ %trror:\ %m,
	\%f:%l:%c:\ %tarning:\ %m,
	\%f(%l,%c)\ :\ %trror:\ %m,
	\%f(%l,%c)\ :\ %tarning:\ %m,
	\%f\ +%l%c:\ %trror:\ %m,
	\%f\ +%l%c:\ %tarning:\ %m,
	\%f:%l:\ %trror:\ %m,
	\%f:%l:\ %tarning:\ %m,
	\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
	\%D%*\\a:\ Entering\ directory\ %*[`']%f',
	\%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
	\%X%*\\a:\ Leaving\ directory\ %*[`']%f',
	\%DMaking\ %*\\a\ in\ %f

CompilerSet makeprg=make
