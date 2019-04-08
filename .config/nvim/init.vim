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
set undofile
set undolevels=1000
set autoread " Automatically reload file changed outside vim if not changed in vim
set completeopt=longest,menuone,preview " complete longest common text instead of first word
" set timeoutlen=150 " Time to wait after ESC (default causes an annoying delay), it affects also leader key, unfortunately
set scrolloff=3 " number of context lines visible near cursor
set sidescrolloff=5 " like 'scrolloff' but for columns
set wildmenu " enhanced command-line mode
set wildignore=*.swp,*.bak,*.pyc,*.class,*.git
set hidden " allow background buffers without saving
" set breakat-=_ " don't break at _
" diff mode
set diffopt+=iwhite " ignore whitespace character changes
" set diffopt+=internal,algorithm:patience,indent-heuristic " use vimproved internal patch
set includeexpr=substitute(v:fname,'\\.','/','g') " expression to change gf filename mapping
set visualbell " don't beep
set noerrorbells " don't beep
set confirm " Ask to save instead of complaining
set splitright splitbelow " open splits in more natural position
" set matchpairs+=<:> " make % match between < and >

" formatting
set backspace=indent,eol,start " more powerful backspacing"
set formatprg=par " gq formatting program
set formatoptions+=j " more intelligent j joining
set linebreak " breaklines *nicely*, virtually
" formatting formatprg, formatexpr, formatoptions, equalprg
set whichwrap=h,l " specify keys that can wrap next line
set autoindent " align the new line indent with the previous one
" set tabstop=4 " Set the default tabstop
set softtabstop=4 " Insert/delete 4 spaces when hitting TAB/Backspace
set shiftwidth=4 " Set the default shift width for indents
set shiftround " Round indent to multiple of 'shiftwidth'.
set expandtab " Make tabs into spaces (set by tabstop)
set smarttab " Smarter tab levels
" set textwidth=80 " max line width

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
set title " change terminal title as formatted by `titlestring`
set signcolumn=yes
set termguicolors " use trucolor
" set showbreak='@' " show line continuation sign

" language
set spelllang=en_gb,pl
set dictionary+=/usr/share/dict/british,/usr/share/dict/polish
set thesaurus+=/usr/share/thesaurus/moby-thesaurus.txt
digraph !! 8252 " ‼
digraph ?! 8264 " ⁈
digraph !? 8265 " ⁉

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
    call plug#begin(fnamemodify($MYVIMRC, ':p:h') . '/vimfiles/plugged')
    let g:tmp_dir=$TMP
    let g:local_share_dir=$APP_DATA
endif

if has('nvim')
    set scrollback=-1 " NeoVim terminal unlimited scrolling
    let g:vim_share_dir=g:local_share_dir . '/nvim'
else
    set viminfofile=$HOME/.config/nvim/viminfo
    let g:vim_share_dir=g:local_share_dir . '/vim'
endif

let g:vim_sesssions_dir=g:vim_share_dir . '/sessions'
let &undodir=g:tmp_dir . '/vim-undo-dir'

if !isdirectory(&undodir)
    call mkdir(&undodir, 0600)
endif
if !isdirectory(g:vim_share_dir)
    call mkdir(g:vim_share_dir, 0600)
endif
if !isdirectory(g:vim_sesssions_dir)
    call mkdir(g:vim_sesssions_dir, 0600)
endif

" mappings
let mapleader = ','
let maplocalleader = '\'

vmap . :normal .<CR>
cmap w!! %!sudo tee > /dev/null %
nnoremap <Leader><Space>s :%s/\s\+$//<CR>
" set very magic regex (perl compatitible)
nnoremap / /\v
vnoremap / /\v
cnoremap g/ g/\v
cnoremap v/ v/\v
" stay in visual mode while changing indentation
nnoremap gV `[v`] " select last changed text, original gV mapping is obscure
" better history scrolling, with context
cnoremap <C-n> <down>
cnoremap <C-p> <up>
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

nnoremap <LocalLeader>y "+y
nnoremap <LocalLeader>Y "+y$
nnoremap <LocalLeader>d "+d
nnoremap <LocalLeader>D "+D
nnoremap <LocalLeader>p "+p
nnoremap <LocalLeader>P "+P

inoremap <A-h> <LEFT>
inoremap <A-l> <RIGHT>
inoremap <A-k> <UP>
inoremap <A-j> <DOWN>
" conflicts with builtin mapping that has duplicate in <C-m>
inoremap <C-j> <ESC>o

vnoremap <A-j> gj
vnoremap <A-k> gk
nnoremap <A-j> gj
nnoremap <A-k> gk

nnoremap <silent> <Leader>ps :SSave <C-r>=GetSessionName()<CR>
nnoremap <silent> <Leader>pl :SLoad <C-r>=GetSessionName()<CR>
nnoremap <silent> <Leader>pd :SDelete<CR>
nnoremap <silent> <Leader>pc :SClose<CR>

nnoremap <silent> <Leader>ev :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>eb :edit $HOME/.bashrc<CR>

" buffers
nnoremap <silent> <Leader>bn <CMD>call Normal([":new", ":only"])<CR>
nnoremap <silent> <Leader>bs <CMD>call Normal([":new"])<CR>
nnoremap <silent> <Leader>bv <CMD>call Normal([":vnew"])<CR>
nnoremap <silent> <Leader>bd <CMD>call Normal([":bdelete"])<CR>
nnoremap <silent> <Leader>bh <CMD>call Normal([":hide"])<CR>
nnoremap <silent> <Leader>bc <CMD>call Normal([":close"])<CR>
nnoremap <silent> <Leader>bo :%bd<CR><C-^><C-^>:bd<CR>
nnoremap <silent> <Leader>bl :Buffers<CR>

" terminal
tnoremap jk <C-\><C-n>
nnoremap <silent> <Leader>Tn <CMD>call Normal([":new\|:only\|:terminal"])<CR> " there seems to be bug, cannot pass list
nnoremap <silent> <Leader>Ts <CMD>call Normal([":new\|:terminal"])<CR>
nnoremap <silent> <Leader>Tv <CMD>call Normal([":vnew\|:terminal"])<CR>
nnoremap <silent> <Leader>Tt <CMD>call Normal([":tabnew\|:terminal"])<CR>

" tabs
nnoremap <silent> <Leader>tn <CMD>call Normal([":tabnew"])<CR>
nnoremap <silent> <Leader>to :tabonly<CR>

" unimpaired mappings
nnoremap [a :<C-U>previous<CR>
nnoremap ]a :<C-U>next<CR>
nnoremap [A :<C-U>first<CR>
nnoremap ]A :<C-U>last<CR>
nnoremap [b :<C-U>bprevious<CR>
nnoremap ]b :<C-U>bnext<CR>
nnoremap [B :<C-U>bfirst<CR>
nnoremap ]B :<C-U>blast<CR>
nnoremap [l :<C-U>lprevious<CR>
nnoremap <C-k> :<C-U>lprevious<CR>
nnoremap ]l :<C-U>lnext<CR>
nnoremap <C-j> :<C-U>lnext<CR>
nnoremap [L :<C-U>lfirst<CR>
nnoremap ]L :<C-U>llast<CR>
nnoremap =l :<C-U>lwindow<CR>
nnoremap =L :<C-U>lclose<CR>
nnoremap [q :<C-U>cprevious<CR>
nnoremap <C-h> :<C-U>cprevious<CR>
nnoremap ]q :<C-U>cnext<CR>
nnoremap <C-l> :<C-U>cnext<CR>
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

"##### TUI
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"##### Windows
Plug 'mhinz/vim-startify'
let g:startify_session_dir=g:vim_sesssions_dir
let g:startify_fortune_use_unicode = 1
let g:startify_use_env = 1
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
let g:winresizer_start_key = ''
Plug 'wellle/visual-split.vim', { 'on': ['VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow', '<Plug>(Visual-Split-VSResize)', '<Plug>(Visual-Split-VSSplit)', '<Plug>(Visual-Split-VSSplitAbove)', '<Plug>(Visual-Split-VSSplitBelow)'] }
Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' }
nnoremap <silent> <Leader>wr :WinResizerStartResize<CR>
xmap <Leader>ws <Plug>(Visual-Split-VSSplit)
nnoremap <silent> <Leader>ws :split<CR>
nnoremap <silent> <Leader>wv :vsplit<CR>
nmap <Leader>wl <Plug>(choosewin)
nnoremap <silent> <Leader>wL :Windows<CR>
nnoremap <silent> <Leader>wc :close<CR>
nnoremap <silent> <Leader>wo :only<CR>
nnoremap <silent> <Leader>wq :quit<CR>
nnoremap <silent> <Leader>wQ :quitall<CR>
nnoremap <silent> <Leader>wh <C-w>h
nnoremap <silent> <Leader>wj <C-w>j
nnoremap <silent> <Leader>wk <C-w>k
nnoremap <silent> <Leader>wl <C-w>l
Plug 'troydm/zoomwintab.vim'

"##### Refactoring; edition
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'PeterRincker/vim-argumentative'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'fenuks/vim-bracket-objects'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature', {'on': 'SignatureToggleSigns'}

"#### Version Control
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <Leader>vL :UndotreeToggle<CR>
Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' } " shows which lines were added and such
let g:signify_vcs_list=['git', 'hg']
Plug 'airblade/vim-gitgutter'
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
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
nnoremap <Leader>vh :Glog<CR>
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
Plug 'ludovicchabant/vim-lawrencium'
" Plug 'jlfwong/vim-mercenary'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
nnoremap <silent> <Leader>dg :diffget<CR>
nnoremap <silent> <Leader>dp :diffput<CR>

nnoremap ,dp :diffput<CR>
nnoremap ,dg :diffget<CR>

"#### Filesystem
" Plugin 'kien/ctrlp.vim'
command! -nargs=* Agp
  \ call fzf#vim#ag(<q-args>, '2> /dev/null',
  \                 fzf#vim#with_preview({'left':'90%'},'up:60%'))

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>fl :Files<CR>
nnoremap <silent> <Leader>fd :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>gt :Tags<CR>
nnoremap <silent> <Leader>gT :BTags<CR>

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <silent> <Leader>ft :NERDTreeToggle<CR>
nnoremap <silent> <Leader>fT :NERDTreeFind<CR>
let g:NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__']

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<Plug>(GrepperOperator)'] }
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.prompt_quote = 3
nnoremap <Leader>ss :Grepper -tool rg<CR>
nnoremap <Leader>sS :Grepper -tool rg -side<CR>
nnoremap <leader>s* :Grepper -tool rg -open -switch -cword -noprompt<CR>
vmap <Leader>s* <Plug>(GrepperOperator)
nmap <Leader>so <Plug>(GrepperOperator)
nnoremap <leader>sd :Grepper -tool rg -dir file<CR>
nnoremap <leader>sD :Grepper -tool rg -dir file -side<CR>

"##### Navigation
" gtags
" GNU global
" set cscopeprg=gtags-cscope
" source /usr/share/vim/vimfiles/plugin/gtags.vim
" source /usr/share/vim/vimfiles/plugin/gtags-cscope.vim
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

Plug 'lambdalisue/lista.nvim', { 'on': 'Lista' }

"##### Formatting
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_json = ['prettier', 'js-beautify', 'jq']
nnoremap <silent> <Leader>q :Neoformat<CR>

Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
xmap <Leader>ga <Plug>(EasyAlign)
nmap <Leader>ga <Plug>(EasyAlign)
"Plug 'godlygeek/tabular'
"Plug 'tommcdo/vim-lion'
"let g:lion_squeeze_spaces = 1

"##### Syntax analysis
"Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
let g:ale_linters = {
\   'python': ['mypy', 'pylint', 'flake8'],
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
let g:test#strategy = 'neomake'
nnoremap <silent> <leader>xn :TestNearest<CR>
nnoremap <silent> <leader>xf :TestFile<CR>
nnoremap <silent> <leader>xa :TestSuite<CR>
nnoremap <silent> <leader>xl :TestLast<CR>
nnoremap <silent> <leader>xg :TestVisit<CR>

"##### Colorshemes
" Plug 'Olical/vim-syntax-expand' " adds abbreviations that make editor pretty
Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'fmoralesc/molokayo'

"##### Autocomplete
" Plug 'Raimondi/delimitMate'
" Plug 'Townk/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
\                    '„':'”', '‘':'’', '“':'”'}
let g:AutoClosePairs_add = '<> | „” ‘’'
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''

" ##### Code autocompletion
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'make release', 'for': ['haskell', 'rust', 'typescript', 'vue', 'c', 'cpp', 'xml'] }
let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],
    \ 'haskell': ['hie-wrapper'],
    \ 'java': ['jdtls', '-javaagent:/usr/share/java/lombok/lombok.jar', '-Xbootclasspath/p:/usr/share/java/lombok/lombok.jar'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'xml': ['lsp4xml'],
    \ 'mvn_pom': ['lsp4xml'],
    \ 'vue': ['vls'],
    \ }
    " \ 'c': ['clangd'],

let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile='/tmp/lc.log'
let g:LanguageClient_serverStderr = '/tmp/ls.log'
" setlocal omnifunc=LanguageClient#complete

nnoremap <silent> <Leader>lk :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Leader>lt :call LanguageClient_workspace_symbol()<CR>
nnoremap <silent> <Leader>lT :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <Leader>lu :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <Leader>lq :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <Leader>la :call LanguageClient#textDocument_codeAction()<CR>

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/vim-lsp.log')

" augroup vim_lsp
"     autocmd!
"     autocmd User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
"         \ 'whitelist': ['rust'],
"         \ })
"
"     autocmd FileType rust setlocal omnifunc=lsp#complete
" augroup END


Plug 'Valloric/YouCompleteMe', { 'for': ['java', 'javascript', 'python'] }
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_semantic_triggers =  {
  \   'java' : ['.', '@', '::'],
  \ }
" Plug 'lifepillar/vim-mucomplete'
" Plug 'maralla/completor.vim'
" Plug 'Shougo/neocomplete.vim'
" let g:neocomplete#enable_at_startup = 1
if has('nvim')
    " DEOPLETE
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " let g:deoplete#omni#input_patterns = {} " faster, called by deoplete
    " let g:deoplete#omni#input_patterns._ = '.+'
    " let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
    " let g:deoplete#omni#input_patterns.javascript = ''
    " let g:deoplete#omni#input_patterns.cpp = ['[^. *\t]\.\w*', '[^. *\t]\::\w*', '[^. *\t]\->\w*', '[<"].*/']
    " let g:deoplete#omni#input_patterns.python = '.+'
    " let g:deoplete#omni_patterns = {}  " slower, called by vim, https://github.com/Shougo/deoplete.nvim/issues/190
    " let g:deoplete#omni_patterns._ = '.+'
    " let g:deoplete#omni#functions = {}
    " let g:deoplete#omni#functions.javascript = tern#Complete
    " let g:deoplete#omni#functions.python = 'jedi#completions'
    " let g:deoplete#omni#functions.python = 'RopeCompleteFunc'
    " DEOPLETE PLUGINS
    " Plug 'tweekmonster/deoplete-clang2', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
    " Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
    " Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
    " let g:deoplete#sources#ternjs#types = 1
    " let g:deoplete#sources#ternjs#docs = 1

    " Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    let g:deoplete#sources#jedi#show_docstring=1

    " alternatively use jedi-vim
    " Plug 'zchee/deoplete-go', { 'for': 'go' }

    " NVIM COMPLETION MANAGER
    " Plug 'ncm2/ncm2'
    " Plug 'roxma/nvim-yarp'
    " Plug 'ncm2/ncm2-bufword'
    " Plug 'ncm2/ncm2-path'
    " Plug 'ncm2/ncm2-ultisnips'
    " Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
    " Plug 'ncm2/ncm2-pyclang', { 'for': ['c', 'cpp'] }
    " Plug 'ncm2/ncm2-cssomni', { 'for': ['html', 'css', 'jsx'] }
    " Plug 'ncm2/ncm2-html-subscope', { 'for': 'html' }
    " Plug 'ncm2/ncm2-tern',  { 'do': 'npm install', 'for': 'javascript' }
    " augroup NCM
    "     autocmd BufEnter * call ncm2#enable_for_buffer()
    " augroup END
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif


Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
" let g:UltiSnipsListSnippets='<C-\>'
Plug 'honza/vim-snippets'

"#### Language specific
Plug 'sheerun/vim-polyglot'
if has('nvim')
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins' }
    Plug 'arakashic/chromatica.nvim', { 'for': ['c', 'cpp', 'objc', 'objcpp'], 'do': ':UpdateRemotePlugins' }
    let g:chromatica#enable_at_startup=1
    let g:chromatica#responsive_mode=1
    " let g:polyglot_disabled = ['python', 'c', 'cpp', 'objc', 'objcpp']
    let g:polyglot_disabled = ['python', 'c', 'cpp', 'objc', 'objcpp', 'org']
endif
" ##### VIML
Plug 'junegunn/vader.vim', { 'on': 'Vader' }
augroup vim
    autocmd!
    autocmd FileType vim nnoremap <buffer> <silent> K :help <C-r><C-w><CR>
    autocmd FileType qf setlocal nobuflisted " exclude quickfix withow from :bnext, etc.
    autocmd FileType text setlocal commentstring=#\ %s
    autocmd BufRead,BufNewFile *.conf setfiletype conf
    autocmd FileType conf setlocal commentstring=#\ %s
    autocmd CursorHold * checktime " needed for autoread to be triggered
augroup END

"##### HTML5
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }

"##### CSS
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
" Plug 'lilydjwg/colorizer', {'for': ['css']}

"##### JS
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
augroup filetype_js
    autocmd!
    autocmd FileType javascript call ConfigureJavascript()
augroup END
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }

"##### Typescript
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim', { 'for': ['javascript', 'typescript'] }
" Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
" Plug 'Quramy/tsuquyomi', { 'for': ['javascript', 'typescript'] }

"##### Python
augroup filetype_python
    autocmd!
    autocmd BufRead,BufNewFile *.recipe setfiletype python
    autocmd FileType call ConfigurePython()
augroup END

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
let g:jedi#completions_command = '<C-space>'
let g:jedi#goto_command = 'gd'
let g:jedi#goto_definitions_command = 'gD'
let g:jedi#rename_command = '<Leader>rn'
let g:jedi#show_call_signatures = '2'
let g:jedi#usages_command = '<Leader>u'

let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ''

" Plug 'python-rope/ropevim', { 'for': 'python' }
let g:ropevim_enable_shortcuts = 0

" ##### Julia
Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

"##### Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
augroup filetype_rust
    autocmd!
    autocmd FileType rust call ConfigureRust()
augroup END

"##### Golang
"Plug 'fatih/vim-go'

" Plug 'mitsuse/autocomplete-swift', { 'for': 'swift' }

"##### JVM
"##### Java
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'mikelue/vim-maven-plugin', { 'on': ['Mvn', 'MvnNewMainFile'] }

augroup filetype_java
    autocmd!
    " autocmd FileType java setlocal makeprg=mvn errorformat='[%tRROR]\ %f:[%l]\ %m,%-G%.%#'
    autocmd FileType java call ConfigureJava()
augroup END

"##### Scala
"Plug 'ensime/ensime-vim', { 'for': ['java', 'scala'] }

"##### Haskell
" Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }

"##### C family
" Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
let g:rtagsUseDefaultMappings = 1
let g:rtagsAutoLaunchRdm=1
" Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }


"##### Shell
augroup shell
    autocmd!
    autocmd BufRead,BufNewFile PKGBUILD call ConfigurePkgbuild()
augroup END

"##### Natural language
"##### Markdown
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }

augroup yaml
    autocmd!
    autocmd FileType yaml setlocal softtabstop=2 shiftwidth=2
augroup END

"##### ORG
Plug 'jceb/vim-orgmode', { 'for': 'org' }

"##### TeX
Plug 'lervag/vimtex', { 'for': 'tex' }

" Plug 'vim-scripts/LanguageTool'
Plug 'dpelle/vim-LanguageTool', { 'for': ['markdown', 'rst', 'org'] }
Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'rst', 'org'] }
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#use_vim_spelllang = 1
augroup natural_language
    autocmd!
    autocmd FileType gitcommit,hgcommit,org,help setlocal spell
augroup END

call plug#end()

if has('gui_running')
    let g:solarized_diffmode='high'
    colorscheme solarized
    set lines=50 columns=140
    set guifont=Fira\ Code
elseif &diff
    colorscheme Monokai
else
    colorscheme evening
endif

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'smart_case': v:true,
    \ 'ignore_case': v:false,
    \ 'ignore_sources': {'c': ['tag'], 'cpp': ['tag'], 'xml': ['tag']}
\ })
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" transparent: CandyPaper,
" gruvbox, badwolf
" truecolor: onedark, OceanicNext

""" functions
function! GetSessionName() abort
    " return g:vim_sesssions_dir . '/' . fnamemodify(getcwd(), ':p:h:t') . '.vim'
    return fnamemodify(getcwd(), ':p:h:t') . '.vim'
endfunction

function! Normal(commands) abort
    """Executes array of normal commands respecting count""""
    let l:count = v:count
    if l:count == 0
        let l:count = 1
    endif
    let l:command = join(a:commands, "\<CR>")
    if len(a:commands) == 1
        let l:command = l:command . "\<CR>"
    endif
    for i in range(1, l:count)
        silent execute 'normal ' . l:command
    endfor
endfunction

function! Conflict(reverse) abort
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

function! ConfigureJavascript() abort
    " setlocal path=.,src,node_modules
    nnoremap <buffer> <silent> gd :TernDef<CR>
    nnoremap <buffer> <silent> <Leader>u :TernRefs<CR>
    nnoremap <buffer> <silent> <Leader>r :TernRename<CR>
    setlocal softtabstop=2 shiftwidth=2
    setlocal suffixesadd=.js,.jsx
endfunction

function! ConfigurePython() abort
    python nnoremap <buffer> <silent> <Leader>U :YcmCompleter GoToReferences<CR>
    python let b:neoformat_run_all_formatters = 1
    call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction

function! ConfigureRust() abort
    nnoremap <buffer> <silent> gd <Plug>(rust-def)
    nnoremap <buffer> <silent> <C-]> <Plug>(rust-def)
    nnoremap <buffer> <silent> <C-w><C-]> <Plug>(rust-def-split)
    nnoremap <buffer> <silent> <C-w>} <Plug>(rust-def-vertical)
    nnoremap <buffer> <silent> K <Plug>(rust-doc)
endfunction

function! ConfigureJava() abort
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
    " autocmd FileType java setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()

    nnoremap <buffer> <Leader>cf :YcmCompleter FixIt<CR>
    nnoremap <buffer> gd :YcmCompleter GoTo<CR>
    nnoremap <buffer> K :YcmCompleter GetDoc<CR>
    nnoremap <buffer> gq :YcmCompleter Format<CR>
    vnoremap <buffer> gq :YcmCompleter Format<CR>
    nnoremap <buffer> <Leader>gu :YcmCompleter GoToReferences<CR>
    nnoremap <buffer> <Leader>rn :YcmCompleter RefactorRename
endfunction

function! ConfigurePkgbuild() abort
    setlocal makeprg=makepkg
    nnoremap <buffer> <Leader>mi :make -i<CR>
    nnoremap <buffer> <Leader>mb :make<CR>
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal filetype=sh
endfunction

let g:foldmethods = {
\ 'manual': 'indent',
\ 'indent': 'expr',
\ 'expr': 'marker',
\ 'marker': 'syntax',
\ 'syntax': 'diff',
\ 'diff': 'manual'
\}

function! ToggleFoldmethod() abort
    let l:next_foldmethod = g:foldmethods[&foldmethod]
    execute 'setlocal foldmethod=' . l:next_foldmethod
    setlocal foldmethod?
endfunction
