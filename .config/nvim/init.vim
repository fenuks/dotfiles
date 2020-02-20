set encoding=utf-8
scriptencoding utf-8

" behaviour
syntax on " syntax highlight on
filetype indent plugin on " enable filetype detection
set synmaxcol=800 " don't highligh longer lines

"" search
set hlsearch " highlight search
set ignorecase " Do case insensitive matching with
set infercase " Do *not* ignore case in autocompletion
set smartcase " Do case sensitive if text contains upper letters
set tagcase=match " Match case in tag search
set incsearch " Search while typing
" set gdefault " Automatically enable the 'g' flag for substitution

"" misc
set modelines=0 " number of lines vim probes to find vi: commands
set history=1000 " Number of things to remember in history
set cmdwinheight=20 " set commandline window height
set undolevels=1000
set autoread " Automatically reload file changed outside vim if not changed in vim
set completeopt=longest,menuone,preview " complete longest common text instead of first word
" scroll autocomplete popup down with <C-f>
inoremap <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<C-f>"
" scroll autocomplete popup up with <C-b>
inoremap <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<C-b>"

" set timeoutlen=150 " Time to wait after ESC (default causes an annoying delay), it affects also leader key, unfortunately
set scrolloff=3 " number of context lines visible near cursor
set sidescrolloff=5 " like 'scrolloff' but for columns
set wildmenu " enhanced command-line mode
set wildignore=*.swp,*.bak,*.pyc,*.class,*.git
set hidden " allow background buffers without saving
" set breakat-=_ " don't break at _
" diff mode
set diffopt+=iwhite " ignore whitespace character changes
set diffopt+=filler,internal,algorithm:histogram,indent-heuristic " use vimproved internal patch
set visualbell " don't beep
set noerrorbells " don't beep
set confirm " Ask to save instead of complaining
set splitright splitbelow " open splits in more natural position
" set matchpairs+=<:> " make % match between < and >

" formatting
set backspace=indent,eol,start " more powerful backspacing"
set formatprg=par\ w79 " gq formatting program
set formatoptions+=j " remove leading comment on J line joining
set linebreak " breaklines *nicely*, virtually
" formatting formatprg, formatexpr, formatoptions, equalprg
set whichwrap=h,l,[,] " specify keys that can wrap next line
set autoindent " align the new line indent with the previous one
" set tabstop=4 " Set the default tabstop
set softtabstop=4 " Insert/delete 4 spaces when hitting TAB/Backspace
set shiftwidth=4 " Set the default shift width for indents
set shiftround " Round indent to multiple of 'shiftwidth'.
set expandtab " Make tabs into spaces (set by tabstop)
set smarttab " Smarter tab levels
" set textwidth=80 " max line width
set commentstring=#\ %s

" display
set t_Co=256
set lazyredraw " redraw only at the end of the macro
set listchars=tab:▸\ ,eol:¬,trail:·
set title " update terminal title
set ruler " show line position on bottom ruler
set laststatus=2 " always show status line
set cursorline " highlight current line
set colorcolumn=80 " show vertical line at column
set showmatch  " Show matching brackets
set showcmd " Display an incomplete command in the lower right corner of the Vim window"
set relativenumber " show relative numbers
set noshowmode " do not show current mode
set number " Show line numbers
set noruler " show line and column numbers
set signcolumn=yes
set termguicolors " use trucolor
" set showbreak='@' " show line continuation sign

let g:vim_dir_path=fnamemodify($MYVIMRC, ':p:h')
let g:nvim_dir_path=expand('~/.config/nvim/')
let g:vim_custom_scripts=g:nvim_dir_path . 'custom/'

if has('unix')
    let g:tmp_dir='/tmp'
    let g:local_share_dir=expand('~/.local/share')

    call plug#begin('~/.config/nvim/plugged')

    if has('mac')
        let g:python_host_prog='/usr/local/bin/python2'
        let g:python3_host_prog='/usr/local/bin/python3'
    else
        let g:python_host_prog='/usr/bin/python2'
        let g:python3_host_prog='/usr/bin/python3'
    endif

else
    call plug#begin(g:vim_dir_path . '/vimfiles/plugged')
    let g:tmp_dir=$TMP
    let g:local_share_dir=$APP_DATA
endif

if has('nvim')
    set scrollback=-1 " NeoVim terminal unlimited scrolling
    let g:vim_share_dir=g:local_share_dir . '/nvim'
    set inccommand=nosplit
else
    set pyxversion=2
    set viminfofile=$HOME/.vim/viminfo
    let g:vim_share_dir=g:local_share_dir . '/vim'
endif

" persistence
set swapfile
set writebackup " write backup before overriding file
set nobackup " delete backup file after successful save
set undofile
let g:vim_sesssions_dir=g:vim_share_dir . '/sessions'
let &undodir=g:tmp_dir . '/vim/undo'
let &backupdir=g:vim_share_dir . '/backup'

if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif
if !isdirectory(g:vim_share_dir)
    call mkdir(g:vim_share_dir, 'p', 0700)
endif
if !isdirectory(g:vim_sesssions_dir)
    call mkdir(g:vim_sesssions_dir, 'p', 0700)
endif
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0700)
endif

" mappings
let mapleader = ','
let maplocalleader = '\'

vmap . :normal .<CR>
cmap w!! %!sudo tee > /dev/null %
nnoremap <Space>t :%s/\s\+$//<CR>
" set very magic regex (perl compatitible)
nnoremap / /\v
vnoremap / /\v
cnoremap g/ g/\v
cnoremap v/ v/\v
" stay in visual mode while changing indentation
nnoremap gV `[v`] " select last changed text, original gV mapping is obscure
" better history scrolling, with context
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" moving lines up and down
nnoremap <silent> <A-p> :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap <silent> <A-n> :<C-u>execute 'move +'. v:count1<CR>
inoremap <silent> <A-n> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-p> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-n> :m '>+1<CR>gv=gv
vnoremap <silent> <A-p> :m '<-2<CR>gv=gv
" insert spaces
nnoremap <silent> [<space>  :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap <silent> ]<space> :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" edit register
nnoremap <silent> <Leader>@ :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><LEFT>

nnoremap <C-s> :w<Enter>
inoremap <C-s> <ESC>:w<Enter>a
inoremap <A-m> <ESC>o

inoremap jk <ESC>
inoremap jK <ESC>
inoremap Jk <ESC>
inoremap JK <ESC>

nnoremap Y y$

vnoremap <LocalLeader>y "+y
vnoremap <LocalLeader>d "+d
vnoremap <LocalLeader>p "+p
nnoremap <Leader><Space>p a <ESC>"+p
nnoremap <Space>p a <ESC>p
nnoremap <Space>P i <ESC>P
nnoremap <Leader>pf :put =expand('%:p')<CR>
nnoremap <Leader>pd :put =expand('%:r')<CR>

nnoremap <LocalLeader>y "+y
nnoremap <LocalLeader>Y "+y$
nnoremap <LocalLeader>d "+d
nnoremap <LocalLeader>D "+D
nnoremap <LocalLeader>p "+p
nnoremap <LocalLeader>P "+P
nnoremap c* ciw
nnoremap d* diw

inoremap <A-h> <LEFT>
inoremap <A-l> <RIGHT>
inoremap <A-k> <UP>
inoremap <A-j> <DOWN>
cnoremap <A-h> <LEFT>
cnoremap <A-l> <RIGHT>
cnoremap <A-k> <UP>
cnoremap <A-j> <DOWN>
" conflicts with builtin mapping that has duplicate in <C-m>
inoremap <C-j> <ESC>o
inoremap <C-l> <DEL>

vnoremap <A-j> gj
vnoremap <A-k> gk
nnoremap <A-j> gj
nnoremap <A-k> gk

nnoremap <silent> <Leader>ps :mksession! <C-r>=GetSessionName()<CR>
nnoremap <silent> <Leader>pl :SLoad <C-r>=GetSessionName()<CR>
nnoremap <silent> <Leader>pd :SDelete<CR>
nnoremap <silent> <Leader>pc :SClose<CR>

nnoremap <silent> <Leader>ev :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>eb :edit $HOME/.bashrc<CR>

" buffers
nnoremap <silent> <Leader>bn :call Execute(['new', 'only'])<CR>
nnoremap <silent> <Leader>bs :call Execute(['new'])<CR>
nnoremap <silent> <Leader>bv :call Execute(['vnew'])<CR>
nnoremap <silent> <Leader>bd :call Execute(['bdelete'])<CR>
nnoremap <silent> <Leader>bu :call Execute(['call ChangeBuffer(1)', 'bdelete#'])<CR>
nnoremap <silent> <Leader>bh :call Execute(['hide'])<CR>
nnoremap <silent> <Leader>bc :call Execute(['close'])<CR>
nnoremap <silent> <Leader>bo :%bdelete<CR><C-^><C-^>:bdelete<CR>
nnoremap <silent> <Leader>bl :Buffers<CR>
nnoremap <silent> <Tab> :call ChangeBuffer(1)<CR>
nnoremap <silent> <S-Tab> :call ChangeBuffer(0)<CR>

" terminal
tnoremap jk <C-\><C-n>
nnoremap <silent> <Leader>Tn :call Execute(['new', 'only', 'terminal'])<CR>
nnoremap <silent> <Leader>Ts :call Execute(['new', 'terminal'])<CR>
nnoremap <silent> <Leader>Tv :call Execute(['vnew', 'terminal'])<CR>
nnoremap <silent> <Leader>Tt :call Execute(['tabnew', 'terminal'])<CR>

" tabs
nnoremap <silent> <Leader>tn :call Execute(['tabnew'])<CR>
nnoremap <silent> <Leader>to :tabonly<CR>
nnoremap <silent> <Leader>td :tabclose<CR>

" unimpaired mappings
nnoremap [a :<C-U>previous<CR>
nnoremap ]a :<C-U>next<CR>
nnoremap [A :<C-U>first<CR>
nnoremap ]A :<C-U>last<CR>
nnoremap <silent> [b :<C-U>call ChangeBuffer(0)<CR>
nnoremap <silent> ]b :<C-U>call ChangeBuffer(1)<CR>
nnoremap [B :<C-U>bfirst<CR>
nnoremap ]B :<C-U>blast<CR>
nnoremap <silent> [l :<C-U>Lprevious<CR>
nnoremap <silent> <C-k> :<C-U>Lprevious<CR>
nnoremap <silent> ]l :C-U>Lnext<CR>
nnoremap <silent> <C-j> :<C-U>Lnext<CR>
nnoremap [L :<C-U>lfirst<CR>
nnoremap ]L :<C-U>llast<CR>
nnoremap =l :<C-U>lwindow<CR>
nnoremap =L :<C-U>lclose<CR>
nnoremap <silent> [q :<C-U>Cprevious<CR>
nnoremap <silent> <C-h> :<C-U>Cprevious<CR>
nnoremap <silent> ]q :<C-U>Cnext<CR>
nnoremap <silent> <C-l> :<C-U>Cnext<CR>
nnoremap [Q :<C-U>cfirst<CR>
nnoremap ]Q :<C-U>clast<CR>
nnoremap =q :<C-U>cwindow<CR>
nnoremap =Q :<C-U>cclose<CR>
nnoremap [t gT
nnoremap ]t gt
nnoremap [T :<C-U>tfirst<CR>
nnoremap ]T :<C-U>tlast<CR>

nnoremap <silent> ]n :call Conflict(0)<CR>
nnoremap <silent> [n :call Conflict(1)<CR>

nnoremap [ob :set background=light<CR>
nnoremap [oc :set nocursorline<CR>
nnoremap [od :diffoff<CR>
nnoremap [oD :windo diffoff<CR>
nnoremap [oh :set nohlsearch<CR>
nnoremap [oi :set noignorecase<CR>
nnoremap [ol :set nolist<CR>
nnoremap [on :set nonumber<CR>
nnoremap [op :set nopaste<CR>
nnoremap [or :set norelativenumber<CR>
nnoremap [os :set nospell<CR>
nnoremap [ou :set nocursorcolumn<CR>
nnoremap [ov :set virtualedit=""<CR>
nnoremap [ow :set nowrap<CR>
nnoremap [ox :set nocursorline nocursorcolumn<CR>

nnoremap ]ob :set background=dark<CR>
nnoremap ]oc :set cursorline<CR>
nnoremap ]od :diffthis<CR>
nnoremap ]oD :windo diffthis<CR>
nnoremap ]oh :set hlsearch<CR>
nnoremap ]oi :set ignorecase<CR>
nnoremap ]ol :set list<CR>
nnoremap ]on :set number<CR>
nnoremap ]op :set nopaste<CR>
nnoremap ]or :set relativenumber<CR>
nnoremap ]os :set spell<CR>
nnoremap ]ou :set cursorcolumn<CR>
nnoremap ]ov :set virtualedit=""<CR>
nnoremap ]ow :set wrap<CR>
nnoremap ]ox :set cursorline cursorcolumn<CR>

nnoremap =ob :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap =oc :set cursorline!<CR>
nnoremap =od :set diff!<CR>
nnoremap =od :set diff!<CR>
nnoremap =oh :set hlsearch!<CR>
nnoremap =oi :set ignorecase!<CR>
nnoremap =ol :set list!<CR>
nnoremap =on :set number!<CR>
nnoremap =op :set paste!<CR>
nnoremap =or :set relativenumber!<CR>
nnoremap =os :set spell!<CR>
nnoremap =ou :set cursorcolumn!<CR>
" nnoremap =ov :set virtualedit=""<CR>
nnoremap =ow :set wrap!<CR>
nnoremap =ox :set cursorline! cursorcolumn!<CR>
nnoremap [of zN
nnoremap ]of zn
nnoremap <silent> =of :call ToggleFoldmethod()<CR>
nnoremap ]ofd :setlocal foldmethod=diff<CR>
nnoremap ]ofi :setlocal foldmethod=indent<CR>
nnoremap ]ofm :setlocal foldmethod=manual<CR>
nnoremap ]ofm :setlocal foldmethod=marker<CR>
nnoremap ]ofs :setlocal foldmethod=syntax<CR>

let g:loaded_2html_plugin = 1
let g:loaded_skim = 1

"##### TUI
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"##### Windows
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
let g:winresizer_start_key = ''
Plug 'wellle/visual-split.vim', { 'on': ['VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow', '<Plug>(Visual-Split-VSResize)', '<Plug>(Visual-Split-VSSplit)', '<Plug>(Visual-Split-VSSplitAbove)', '<Plug>(Visual-Split-VSSplitBelow)'] }
Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' }
nnoremap <silent> <Leader>wr :WinResizerStartResize<CR>
xmap <Leader>ws <Plug>(Visual-Split-VSSplit)
nmap <Leader>wl <Plug>(choosewin)
nnoremap <silent> <Leader>wz :call CloseAuxiliaryWindows()<CR>
nnoremap <silent> <C-w>z :call CloseAuxiliaryWindows()<CR>
nnoremap <silent> <Leader>wL :Windows<CR>
nnoremap <silent> <Leader>wQ :quitall<CR>
Plug 'troydm/zoomwintab.vim'
let g:zoomwintab_remap=0
nnoremap <silent> <C-w>u :ZoomWinTabToggle<CR>
nnoremap <silent> <Leader>wu :ZoomWinTabToggle<CR>

"##### Refactoring; edition
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'PeterRincker/vim-argumentative'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'fenuks/vim-bracket-objects'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
noremap <silent> <c-_> :Commentary<CR>
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature', {'on': 'SignatureToggleSigns'}

"#### Version Control
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <Leader>vL :UndotreeToggle<CR>
Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' } " shows which lines were added and such
let g:signify_vcs_list=['git', 'hg']
Plug 'airblade/vim-gitgutter'
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
let g:gitgutter_map_keys = 0
nnoremap <Leader>vll :GitGutterToggle<CR>
nnoremap <Leader>vlL :SignifyToggle<CR>
nmap <Leader>vls <Plug>GitGutterStageHunk
nmap <Leader>vlr <Plug>GitGutterUndoHunk
nmap <Leader>vld <Plug>GitGutterPreviewHunk
"GIT
Plug 'tpope/vim-fugitive'
nnoremap <Leader>va :Gwrite<CR>
nnoremap <Leader>vb :Gblame<CR>
nnoremap <Leader>vc :Gcommit<CR>
nnoremap <Leader>vd :Gvdiff<CR>
nnoremap <Leader>vh :0Glog<CR>
nnoremap <Leader>vm :Gmove<CR>
nnoremap <Leader>U  :GundoToggle<CR>
nnoremap <Leader>vp :Git! diff --staged<CR>
nnoremap <Leader>vP :Git! diff<CR>
nnoremap <Leader>vr :Gread<CR>
nnoremap <Leader>vR :Gremove<CR>
nnoremap <Leader>vs :Gstatus<CR>
Plug 'rbong/vim-flog', {'on': 'Flog'}
nnoremap <Leader>vg :Flog<CR>
Plug 'junegunn/gv.vim', {'on': 'GV'}
nnoremap <Leader>vG :GV<CR>
Plug 'jreybert/vimagit', { 'on': 'Magit' }
nnoremap <Leader>vM :Magit<CR>
Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }
"HG
" Plug 'ludovicchabant/vim-lawrencium' " disabled, it takes 5ms to load
" Plug 'jlfwong/vim-mercenary'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
nnoremap <silent> <Leader>dg :diffget<CR>
nnoremap <silent> <Leader>dp :diffput<CR>

nnoremap <Leader>dp :diffput<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <silent> <Leader>df :call DiffOrig()<CR>

"#### Filesystem
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
command! -nargs=* Agp
  \ call fzf#vim#ag(<q-args>, '2> /dev/null',
  \                 fzf#vim#with_preview({'left':'90%'},'up:60%'))
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>fl :Files<CR>
nnoremap <silent> <Leader>fd :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>gt :Tags<CR>
nnoremap <silent> <Leader>gh :History<CR>
nnoremap <silent> <Leader>gT :BTags<CR>
snoremap <silent> <C-k> <ESC>ddi

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <silent> <Leader>ft :NERDTreeToggle<CR>
nnoremap <silent> <Leader>fT :NERDTreeFind<CR>
nnoremap <silent> <Leader>fs :call ReadSkeletonFile()<CR>
let g:NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__']
let g:NERDTreeMinimalUI=1

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<Plug>(GrepperOperator)'] }
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.prompt_quote = 3
nnoremap <Leader>ss :Grepper -tool rg<CR>
nnoremap <Leader>sS :Grepper -tool rg -side<CR>
nnoremap <leader>s* :Grepper -tool rg -open -switch -cword -noprompt<CR>
nnoremap <Leader>s% :Grepper -open -switch -cword -noprompt -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
nnoremap <Leader>sf :Grepper -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
vmap <Leader>s <Plug>(GrepperOperator)
nmap <Leader>so <Plug>(GrepperOperator)
nnoremap <leader>sd :Grepper -tool rg -dir file<CR>
nnoremap <leader>sD :Grepper -tool rg -dir file -side<CR>
" search url ((\w+://)|/)[a-zA-Z0-9.?&/]+
" vim regex: ( |"|\[|\=)((\w+:\/\/)|\/)[a-zA-Z0-9.?&/\-{}*]+

"##### Navigation
" gtags
" GNU global
" set cscopeprg=gtags-cscope
" source /usr/share/vim/vimfiles/plugin/gtags.vim
" source /usr/share/vim/vimfiles/plugin/gtags-cscope.vim
nnoremap <silent> <Leader>ol :mode\|nohlsearch<CR>
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
Plug 'nelstrom/vim-visual-star-search'
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['.mypy_cache']
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
let g:airline#extensions#tabline#enabled = 1
" Plug 'devjoe/vim-codequery' " rich support for searching symbols support
Plug 'easymotion/vim-easymotion'
Plug 'fenuks/vim-uncommented'
Plug 'andymass/vim-matchup'
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_mappings = {
\ 'w' : 'g-',
\ 'b' : '_',
\ 'e' : '-',
\ 'ge' : 'g_',
\ 'aw' : 'a-',
\ 'iw' : 'i-',
\ '<C-R><C-W>' : '<C-R><M-w>'
\ }

imap <C-q> <C-\><C-o>d_
Plug 'arthurxavierx/vim-caser'


Plug 'lambdalisue/lista.nvim', { 'on': 'Lista' }

"##### Formatting
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_json = ['prettier', 'js-beautify', 'jq']
let g:neoformat_enabled_yaml = ['prettier']
nnoremap <silent> <Leader>q :Neoformat<CR>

Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
xmap <Leader>ga <Plug>(EasyAlign)
nmap <Leader>ga <Plug>(EasyAlign)
"Plug 'godlygeek/tabular'
"Plug 'tommcdo/vim-lion'
"let g:lion_squeeze_spaces = 1

"##### Syntax analysis
Plug 'dense-analysis/ale'
let g:ale_linters = {
\   'python': ['mypy', 'pylint', 'flake8'],
\   'java': ['javalsp', 'pmd']
\}
let g:ale_fixers = {
\   '': ['trim_whitespace'],
\   'javascript': ['eslint'],
\   'json': ['fixjson'],
\   'python': ['yapf', 'isort']
\}
let g:ale_c_parse_makefile=0
let g:ale_c_parse_compile_commands=1
let g:ale_python_mypy_options='--ignore-missing-imports'
let g:airline#extensions#ale#enabled = 1
nnoremap <Leader>cf :ALEFix<CR>
nmap <silent> <Leader>cp <Plug>(ale_previous_wrap)
nmap <silent> <Leader>cn <Plug>(ale_next_wrap)
nnoremap <silent> <Leader>co :lwindow<CR>
nnoremap <silent> <Leader>cO :lclose<CR>
" let g:ale_open_list = 1 " conflicts with ultisnips jumping

"##### Tasks
Plug 'neomake/neomake', { 'on': ['Neomake', 'NeomakeProject'] }
let g:neomake_open_list = 2
let g:airline#extensions#neomake#enabled = 0
nnoremap <Leader>mb :make compile<CR>
nnoremap <Leader>mi :make install<CR>
nnoremap <Leader>mc :make clean<CR>

Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit'] }
let g:test#strategy = 'neovim'
nnoremap <silent> <leader>xn :TestNearest<CR>
nnoremap <silent> <leader>xf :TestFile<CR>
nnoremap <silent> <leader>xa :TestSuite<CR>
nnoremap <silent> <leader>xl :TestLast<CR>
nnoremap <silent> <leader>xg :TestVisit<CR>

"##### Colorshemes
" Plug 'Olical/vim-syntax-expand' " adds abbreviations that make editor pretty
Plug 'gruvbox-community/gruvbox'
Plug 'iCyMind/NeoSolarized'

"##### Autocomplete
" Plug 'Raimondi/delimitMate'
" Plug 'Townk/vim-autoclose'
" Plug 'jiangmiao/auto-pairs'
Plug '~/Projects/thirdparty/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
\                    '„':'”', '‘':'’', '“':'”'}
let g:AutoClosePairs_add = '<> | „” ‘’'
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''

" ##### Code autocompletion
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'make release', 'on': ['LanguageClientStart'] }
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'on': ['CocInstall', 'CocConfig', 'CocEnable'] }

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

Plug 'Valloric/YouCompleteMe', { 'for': ['java', 'javascript'] }
" Plug 'lifepillar/vim-mucomplete'
" Plug 'maralla/completor.vim'
" Plug 'Shougo/neocomplete.vim'
" let g:neocomplete#enable_at_startup = 1
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-dictionary'
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    " Plug 'zchee/deoplete-go', { 'for': 'go' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
execute 'source ' . g:vim_custom_scripts . 'autocomplete.vim'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
" let g:UltiSnipsListSnippets='<C-\>'
Plug 'honza/vim-snippets'

"#### Language specific
Plug 'sheerun/vim-polyglot'
if has('nvim')
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    Plug 'arakashic/chromatica.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:chromatica#enable_at_startup=1
    let g:chromatica#responsive_mode=1
    let g:polyglot_disabled = ['python', 'c', 'cpp', 'objc', 'objcpp', 'org']
endif
" ##### VIML
Plug 'junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }
augroup vim
    autocmd!
    autocmd FileType vim nnoremap <buffer> <silent> K :help <C-r><C-w><CR>
    autocmd FileType qf setlocal nobuflisted " exclude quickfix withow from :bnext, etc.
    autocmd FileType text setlocal commentstring=#\ %s
    autocmd FileType conf setlocal commentstring=#\ %s
    autocmd CursorHold * checktime " needed for autoread to be triggered
    " reopening a file, restore last cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END

augroup filetype_detect
    autocmd!
    autocmd BufRead,BufNewFile *.recipe setfiletype python
    autocmd BufRead,BufNewFile *.conf setfiletype conf
    autocmd BufRead,BufNewFile *.conf setfiletype vader
    autocmd BufRead,BufNewFile env setfiletype sh
    autocmd BufRead,BufNewFile PKGBUILD call ConfigurePkgbuild()
augroup END

"##### HTML5
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }

"##### CSS
Plug 'ap/vim-css-color'
" Plug 'lilydjwg/colorizer', {'for': ['css']}

"##### JS
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }

"##### Typescript
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim', { 'for': ['javascript', 'typescript'] }
" Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
" Plug 'Quramy/tsuquyomi', { 'for': ['javascript', 'typescript'] }

"##### Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'python-rope/ropevim', { 'for': 'python' }

" ##### Julia
Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

"##### Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

"##### Golang
"Plug 'fatih/vim-go'

"##### JVM
"##### Java
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'mikelue/vim-maven-plugin', { 'on': ['Mvn', 'MvnNewMainFile'] }
let g:java_highlight_functions=1

"##### Scala
"Plug 'ensime/ensime-vim', { 'for': ['java', 'scala'] }

"##### Haskell
" Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
augroup haskell
    autocmd!
    autocmd FileType haskell call ConfigureCoc()
augroup END

" ##### C family
" Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
let g:rtagsUseDefaultMappings = 1
let g:rtagsAutoLaunchRdm=1
" Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }

"##### Natural language
"##### Markdown
" Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }

"##### ORG
Plug 'jceb/vim-orgmode', { 'for': 'org' }

"##### TeX
Plug 'lervag/vimtex', { 'for': 'tex' }
" Plug 'scrooloose/vim-slumlord'

" Plug 'vim-scripts/LanguageTool'
Plug 'dpelle/vim-LanguageTool', { 'for': ['markdown', 'rst', 'org'] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }

call plug#end()

if has('gui_running')
    let g:solarized_diffmode='high'
    colorscheme gruvbox
    set lines=50 columns=140
    set guifont=Fira\ Code
elseif &diff
    colorscheme gruvbox
else
    colorscheme gruvbox
endif

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'smart_case': v:true,
    \ 'ignore_case': v:false,
    \ 'ignore_sources': {'c': ['tag'], 'cpp': ['tag'], 'xml': ['tag']}
\ })
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'sorters', [])
" transparent: CandyPaper,
" gruvbox, badwolf
" truecolor: onedark, OceanicNext

""" functions
execute 'source ' . g:vim_custom_scripts . 'functions.vim'
command! Cnext call WrapListCommand('cnext', 'cfirst')
command! Cprevious call WrapListCommand('cprev', 'clast')
command! Lnext call WrapListCommand('lnext', 'lfirst')
command! Lprevious call WrapListCommand('lprev', 'llast')

function! ConfigurePkgbuild() abort
    setlocal makeprg=makepkg
    nnoremap <buffer> <Leader>mi :make -i<CR>
    nnoremap <buffer> <Leader>mb :make<CR>
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal filetype=sh
endfunction

execute 'source ' . g:vim_custom_scripts . 'spelling.vim'

command! PlugInit !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

function DiffCurrentQuickfixEntry() abort
  cc
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    for i in reverse(range(len(diff)))
      exe (i ? 'rightbelow' : 'leftabove') 'vert diffsplit' fnameescape(diff[i].filename)
      wincmd p
    endfor
  endif
endfunction
