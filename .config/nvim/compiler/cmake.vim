if exists('current_compiler') | finish | endif
let current_compiler = 'cmake'

CompilerSet errorformat=
      \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
      \%*[^\"]\"%f\"%*\\D%l:\ %m,
      \\"%f\"%*\\D%l:%c:\ %m,
      \\"%f\"%*\\D%l:\ %m,
      \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
      \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
      \%f:%l:%c:\ %trror:\ %m,
      \%f:%l:%c:\ %tarning:\ %m,
      \%f:%l:\ %trror:\ %m,
      \%f:%l:\ %tarning:\ %m,
      \%-G%.%#%\\%#%\\%#%\\%#%.%#,
      \%f:%l:%c:\ %m,
      \%f:%l:\ %m,
      \%f:\\(%*[^\\)]\\):\ %m,
      \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
      \%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
      \%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
      \%D%*\\a:\ Entering\ directory\ %*[`']%f',
      \%X%*\\a:\ Leaving\ directory\ %*[`']%f',
      \%DMaking\ %*\\a\ in\ %f,
      \%-Gcc1plus:\ all\ warnings\ being\ treated\ as\ errors

if filereadable('build/Makefile')
    CompilerSet makeprg=make\ -C\ build
else
    CompilerSet makeprg=make
endif
CompilerSet shellpipe=2>&1\ >/dev/null\ \|tee
