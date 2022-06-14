set encoding=utf-8
scriptencoding utf-8

" behaviour
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
" set foldclose=all " close fold after cursor leaves it
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldlevelstart=99 " start with all folds opened

"" misc
set modelines=0 " number of lines vim probes to find vi: commands
set history=1000 " Number of things to remember in history
set cmdwinheight=20 " set commandline window height
set undolevels=1000
set autoread " Automatically reload file changed outside vim if not changed in vim
set completeopt=menuone,noselect " complete longest common text instead of first word
set pumheight=15 " maximum autocomplete popup height

" set timeoutlen=150 " Time to wait after ESC (default causes an annoying delay), it affects also leader key, unfortunately
set modeline
set modelines=5
set secure

set updatetime=300 " time, in miliseconds to trigger cursorhold (aslo to write swap file)
set scrolloff=3 " number of context lines visible near cursor
set sidescrolloff=5 " like 'scrolloff' but for columns
set scrollopt+=hor " scroll binded windows also horizontally
set wildmenu " enhanced command-line mode
set wildignore=*.swp,*.bak,*.pyc,*.class,*.git
set hidden " allow background buffers without saving
" set breakat-=_ " don't break at _
" diff mode
set diffopt+=iwhite " ignore whitespace character changes
set diffopt+=filler,internal,algorithm:histogram,indent-heuristic " use vimproved internal patch
set visualbell " don't beep
set noerrorbells " don't beep
set belloff=backspace,error,esc " disable bell for selected events
set confirm " Ask to save instead of complaining
set splitright splitbelow " open splits in more natural position
" set matchpairs+=<:> " make % match between < and >

" formatting
set backspace=indent,eol,start " more powerful backspacing"
set formatprg=par\ w79 " gq formatting program
set formatoptions+=jnor1
set linebreak " breaklines *nicely*, virtually
" formatting formatprg, formatexpr, formatoptions, equalprg
set whichwrap=h,l,[,] " specify keys that can wrap next line
set autoindent " align the new line indent with the previous one
" set tabstop=4 " Set the default tabstop
set softtabstop=8 " Insert/delete 8 spaces when hitting TAB/Backspace
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
if has('nvim-0.7')
    set laststatus=3
endif
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
" set selection=exclusive
set conceallevel=1
set spellsuggest=best,9

let g:vim_dir_path=fnamemodify($MYVIMRC, ':p:h')
let g:nvim_dir_path=expand('~/.config/nvim/')
let g:vim_custom_scripts=g:nvim_dir_path . 'custom/'
set pyxversion=3

if has('unix')
    let g:tmp_dir='/tmp'
    let g:local_share_dir=expand('~/.local/share')

    call plug#begin('~/.local/share/nvim/plugged')

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
    set scrollback=-1 " nvim terminal unlimited scrolling
    let g:vim_share_dir=g:local_share_dir . '/nvim'
    set inccommand=nosplit
    " set signcolumn=yes:2
else
    " syntax highlight on, it breaks source order on neovim
    " https://github.com/neovim/neovim/issues/16928
    syntax on
    set viminfofile=$HOME/.vim/viminfo
    let g:vim_share_dir=g:local_share_dir . '/vim'
    set runtimepath+=~/.config/nvim,~/.config/nvim/after
endif

" persistence
set swapfile
set writebackup " write backup before overriding file
set nobackup " delete backup file after successful save
set undofile
let g:vim_sesssions_dir=g:vim_share_dir . '/sessions'
if has('nvim')
    let &undodir=g:tmp_dir . '/nvim/undo'
else
    let &undodir=g:tmp_dir . '/vim/undo'
endif
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
" scroll autocomplete popup down with <C-f>
inoremap <unique> <silent> <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<C-f>"
" scroll autocomplete popup up with <C-b>
inoremap <unique> <silent> <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<C-b>"
" disable, doing it for compe
" inoremap <unique> <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <unique> <silent> <expr> <C-e> col(".") == col("$") ? "<Del>" : "<C-o>de"
" ; always goes forward
" nnoremap <unique> <expr> ; getcharsearch().forward ? ';' : ','
" , always goes back
" nnoremap <unique> <expr> , getcharsearch().forward ? ',' : ';'
" now i.e. 2dJ will delete a column of 3 characters below
onoremap <unique> <silent> J <C-v>j
" now i.e. 2cK will change a column of 3 characters above
onoremap <unique> <silent> K <C-v>k
let mapleader = ','
let maplocalleader = '\'

vnoremap <unique> <silent> . :normal .<CR>
vnoremap <unique> <silent> @@ :normal @@<CR>
" set very magic regex (perl compatitible)
nnoremap <unique> <silent> gV `[v`] " select last changed text, original gV mapping is obscure
" better history scrolling, with context

" moving lines up and down
nnoremap <unique> <silent> <M-[> :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap <unique> <silent> <M-]> :<C-u>execute 'move +'. v:count1<CR>
inoremap <unique> <silent> <M-[> <Esc>:m .-2<CR>==gi
inoremap <unique> <silent> <M-]> <Esc>:m .+1<CR>==gi
vnoremap <unique> <silent> <M-[> :m '<-2<CR>gv=gv
vnoremap <unique> <silent> <M-]> :m '>+1<CR>gv=gv
" moving words left and right
nnoremap <unique> <silent> [w dawbPb
nnoremap <unique> <silent> [W daWBPB
nnoremap <unique> <silent> ]w dawelpb
nnoremap <unique> <silent> ]W daWElpB
nnoremap <unique> <silent> [, F,2dwbhPb

" insert spaces
nnoremap <unique> <silent> <space>[ :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap <unique> <silent> <space>] :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" allows reusing x and X for other mappings;
" s and <space> can be also reused since cl is fine enough
nnoremap <unique> <silent> xp dlp
nnoremap <unique> <silent> xP dlP
nnoremap <unique> <silent> Xp dhP
nnoremap <unique> <silent> XP dhP

vnoremap <unique> <silent> <LocalLeader>d "+d
vnoremap <unique> <silent> rd "_d

" freeing some less useful keys…
nnoremap <unique> q <NOP>
nnoremap <unique> Q <NOP>
nnoremap <unique> r <NOP>
nnoremap <unique> s <NOP>
nnoremap <unique> S <NOP>
nnoremap <unique> x <NOP>
nnoremap <unique> X <NOP>

nnoremap <unique> q@ q
nnoremap <unique> <silent> qq :qall<CR>

" it's wasteful to sacrifice r just for char replace…
nnoremap <unique> rr r
nnoremap <unique> <silent> r@ q

nnoremap <unique> <silent> sx :set opfunc=RunShellOperator<CR>g@
nnoremap <unique> <silent> sxx ^:set opfunc=RunShellOperator<CR>g@$
nnoremap <unique> <silent> sX :set opfunc=FilterShellOperator<CR>g@
nnoremap <unique> <silent> sXX ^:set opfunc=FilterShellOperator<CR>g@$

" trim trailing whitespaces
nnoremap <unique> <silent> x$ :call SubstituteNoHs('%s/\s\+$//')<CR>
vnoremap <unique> <silent> x$ :<C-u>call SubstituteNoHs("'<,'>s/\\s\\+$//")<CR>
" trim leading whitespaces
nnoremap <unique> <silent> x^ :call SubstituteNoHs('%s/^\s\+//')<CR>
vnoremap <unique> <silent> x^ :call SubstituteNoHs("'<,'>s/^\\s\\+//")<CR>
" remove empty lines
nnoremap <unique> <silent> x<CR> :call SubstituteNoHs('g/^\s\*$/d')<CR>
nnoremap <unique> <silent> x, :call SubstituteNoHs('%s/,\s*/\r/g')<CR>
vnoremap <unique> <silent> x, :call SubstituteNoHs("'<,'>s/,\\s*/\\r/g")<CR>
nnoremap <unique> <silent> X, :call SubstituteNoHs('1,$-1s/\n/, /')<CR>
vnoremap <unique> <silent> X, :-1s/\n/, /<CR>
" convert non-breaking spaces to normal ones
nnoremap <unique> <silent> x<Space> :call SubstituteNoHs('%s/\s\+/\r/g')<CR>
vnoremap <unique> <silent> x<Space> :call SubstituteNoHs("'<,'>s/\\s\\+/\\r/g")<CR>
" remove annotation like [1]
nnoremap <unique> <silent> xa :call SubstituteNoHs('%s/\[\d\+\]//g')<CR>
vnoremap <unique> <silent> xa :<C-u>call SubstituteNoHs("'<,'>s/\\[\\d\\+\\]//g")<CR>

nnoremap <unique> <silent> xSs :,$!sort -h<CR>
nnoremap <unique> <silent> xSS :,$!sort -h<CR>
vnoremap <unique> <silent> xss :!sort -h<CR>
nnoremap <unique> <silent> xss :set opfunc=SortOperator<CR>g@

nnoremap <unique> <silent> xSu :,$!sort -hu<CR>
nnoremap <unique> <silent> xSU :,$!sort -hu<CR>
vnoremap <unique> <silent> xsu :!sort -hu<CR>
nnoremap <unique> <silent> xsu :set opfunc=SortOperatorUnique<CR>g@

nnoremap <unique> <silent> qcj :set opfunc=PandocJiraOperator<CR>g@
nnoremap <unique> <silent> qcc :call PandocFzf()<CR>
" nnoremap <unique> <silent> xcc :set opfunc=PandocUniversalOperator<CR>g@

nnoremap <unique> <silent> xD :,$!sort \| uniq -d<CR>
vnoremap <unique> <silent> xd :!sort \| uniq -d<CR>
nnoremap <unique> <silent> xd :set opfunc=DuplicateOperator<CR>g@

nnoremap <unique> <silent> xaL :,$left<CR>
vnoremap <unique> <silent> xal :left<CR>
nnoremap <unique> <silent> xal :set opfunc=LeftAlignOperator<CR>g@
nnoremap <unique> <silent> xaR :,$right<CR>
vnoremap <unique> <silent> xar :right<CR>
nnoremap <unique> <silent> xar :set opfunc=RightAlignOperator<CR>g@
nnoremap <unique> <silent> xaC :,$center<CR>
vnoremap <unique> <silent> xac :center<CR>
nnoremap <unique> <silent> xac :set opfunc=CenterAlignOperator<CR>g@
nnoremap <unique> <silent> xaJ :,$Justify<CR>
vnoremap <unique> <silent> xaj :Justify<CR>
nnoremap <unique> <silent> xaj :set opfunc=JustifyOperator<CR>g@
nnoremap <unique> <silent> xj :set opfunc=JoinOperatorWithSpaces<CR>g@
nnoremap <unique> <silent> xJ :set opfunc=JoinOperator<CR>g@

" edit register
nnoremap <unique> <silent> x@ :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><LEFT>

" mapping for indenting brackets
inoremap <unique> <silent> <C-M-CR> <CR><CR><UP><TAB>
inoremap <unique> <silent> <C-j> <END><CR>
" mapped as <C-S-j> in custom keymap
inoremap <unique> <silent> <C-S-CR> <Home><CR><UP>
inoremap <unique> <silent> <C-z> <C-o>:suspend<CR>

nnoremap <unique> <silent> <C-s> :w<Enter>
inoremap <unique> <silent> <C-s> <ESC>:w<Enter>a
inoremap <unique> <silent> <C-l> <DEL>

if !has('nvim-0.6')
    nnoremap <unique> <silent> Y y$
endif
vnoremap <unique> <silent> <LocalLeader>y "+y
nnoremap <unique> <silent> <M-y> "+y
vnoremap <unique> <silent> <M-y> "+y
nnoremap <unique> <silent> <M-S-y> "+y$

vnoremap <unique> <silent> <LocalLeader>p "+p
nnoremap <unique> <silent> <Leader><Space>p a <ESC>"+p
nnoremap <unique> <silent> <Space>p a <ESC>p
nnoremap <unique> <silent> <Space>P i <ESC>P
nnoremap <unique> <silent> sp :call NewlinePaste('p', 'o')<CR>
nnoremap <unique> <silent> Sp :call NewlinePaste('p', 'O')<CR>
nnoremap <unique> <silent> SP :call NewlinePaste('p', 'O')<CR>
vnoremap <unique> <silent> sj, s/\,\s*/\r/g<CR>
nnoremap <unique> <silent> yp "0p
nnoremap <unique> <silent> yP "0P
nnoremap <unique> <silent> yv `<v`>y
nnoremap <unique> <silent> ys :call CopySelection()<CR>
nnoremap <unique> <silent> <M-p> "+p
vnoremap <unique> <silent> <M-p> "+p
inoremap <unique> <silent> <M-p> <C-o>"+p
nnoremap <unique> <silent> <Leader>pf :put =expand('%:p')<CR>
nnoremap <unique> <silent> <Leader>pd :put =expand('%:r')<CR>

nnoremap <unique> <silent> <LocalLeader>y "+y
nnoremap <unique> <silent> <LocalLeader>Y "+y$
nnoremap <unique> <silent> <LocalLeader>d "+d
nnoremap <unique> <silent> <LocalLeader>D "+D
nnoremap <unique> <silent> <LocalLeader>p "+p
nnoremap <unique> <silent> <LocalLeader>P "+P
nnoremap <unique> <silent> c* ciw
nnoremap <unique> <silent> d* diw

inoremap <unique> <silent> <M-h> <LEFT>
inoremap <unique> <silent> <M-l> <RIGHT>
inoremap <unique> <silent> <M-k> <UP>
inoremap <unique> <silent> <M-j> <DOWN>

cnoremap <unique> <M-h> <LEFT>
cnoremap <unique> <M-l> <RIGHT>
cnoremap <unique> <M-k> <UP>
cnoremap <unique> <M-j> <DOWN>
cnoremap <unique> %e e <C-r>=expand('%:h')<CR>/
if has('nvim')
cnoremap <unique> w!! w !sudo --askpass ksshaskpass tee > /dev/null %
else
cnoremap <unique> w!! w !sudo tee > /dev/null %
endif
" cnoremap <unique> g/ g/\v
" cnoremap <unique> v/ v/\v
" nnoremap <unique> / /\v
" vnoremap <unique> / /\v
cnoremap <unique> <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <unique> <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <unique> <C-a> <Home>
cnoremap <unique> <C-e> <End>

vnoremap <unique> <silent> <M-j> gj
vnoremap <unique> <silent> <M-k> gk
nnoremap <unique> <silent> <M-j> gj
nnoremap <unique> <silent> <M-k> gk
" open fold and descent into it
nnoremap <unique> <silent> gj zogj
" select last inserted/pasted text
" nnoremap <unique> <silent> sp `[v`]
nnoremap <unique> <silent> gl :e <cfile><CR>

nnoremap <unique> Ss :mksession! <C-r>=GetSessionName()<CR>
nnoremap <unique> Sl :source <C-r>=GetSessionName()<CR>
nnoremap <unique> Sd :echo delete('<C-r>=GetSessionName()<CR>')
nnoremap <unique> Sc :SClose<CR>

nnoremap <unique> <silent> <Leader>ev :edit $MYVIMRC<CR>
nnoremap <unique> <silent> <Leader>eb :edit $HOME/.bashrc<CR>

" buffers
nnoremap <unique> <silent> <Leader>bn :<C-u>call Execute(['enew'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bs :<C-u>call Execute(['new'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bv :<C-u>call Execute(['vnew'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bd :<C-u>call Execute(['call ChangeBuffer(1)', 'bdelete#'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bu :<C-u>call Execute(['bdelete'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bh :<C-u>call Execute(['hide'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bc :<C-u>call Execute(['close'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>bo :%bdelete<CR><C-^><C-^>:bdelete<CR>
nnoremap <unique> <silent> <Leader>b/ :call GatherSearchResults()<CR>
nnoremap <unique> <silent> <Leader>br call DeleteHiddenBuffers()<CR>
nnoremap <unique> <silent> <Leader>brh call DeleteBufsOnLeft()<CR>
nnoremap <unique> <silent> <Leader>brl call DeleteBufsOnRight()<CR>
nnoremap <unique> <silent> <Tab> :call ChangeBuffer(1)<CR>
nnoremap <unique> <silent> <S-Tab> :call ChangeBuffer(0)<CR>
" TAB == CTRL-I, therfore mapping <Tab> breaks going to new pos in jump list
nnoremap <unique> <silent> <C-p> <C-i>


nnoremap <unique> <silent> dJ :<C-u>call DJ())<CR>
nnoremap <unique> <silent> dK :<C-u>call DK())<CR>
nnoremap <unique> <silent> gx :<C-u>call OpenUrl()<CR>
vnoremap <unique> <silent> gx :<C-u>call OpenUrlVisual()<CR>
nnoremap <unique> <silent> gX :<C-u>call SearchWeb()<CR>
vnoremap <unique> <silent> gX :<C-u>call SearchWebVisual()<CR>

" terminal
tnoremap <unique> <silent> jk <C-\><C-n>
tnoremap <unique> <silent> <C-[> <C-\><C-n>
nnoremap <unique> <silent> <Leader>Tn :<C-u>call Execute(['new', 'only', 'terminal'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>T. :terminal<CR>
nnoremap <unique> <silent> <Leader>Ts :<C-u>call Execute(['new', 'terminal'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>Tv :<C-u>call Execute(['vnew', 'terminal'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>Tt :<C-u>call Execute(['tabnew', 'terminal'], v:count1)<CR>

" tabs
nnoremap <unique> <silent> <Leader>tn :<C-u>call Execute(['tabnew'], v:count1)<CR>
nnoremap <unique> <silent> <Leader>to :tabonly<CR>
nnoremap <unique> <silent> <Leader>td :tabclose<CR>

" unimpaired mappings
nnoremap <unique> <silent> [a :<C-U>previous<CR>
nnoremap <unique> <silent> ]a :<C-U>next<CR>
nnoremap <unique> <silent> [A :<C-U>first<CR>
nnoremap <unique> <silent> ]A :<C-U>last<CR>
nnoremap <unique> <silent> [b :<C-U>call ChangeBuffer(0)<CR>
nnoremap <unique> <silent> ]b :<C-U>call ChangeBuffer(1)<CR>
nnoremap <unique> <silent> [B :<C-U>bfirst<CR>
nnoremap <unique> <silent> ]B :<C-U>blast<CR>
nnoremap <unique> <silent> [l :<C-U>Lprevious<CR>
nnoremap <unique> <silent> <C-k> :<C-U>Lprevious<CR>
nnoremap <unique> <silent> ]l :C-U>Lnext<CR>
nnoremap <unique> <silent> <C-j> :<C-U>Lnext<CR>
nnoremap <unique> <silent> [L :<C-U>lfirst<CR>
nnoremap <unique> <silent> ]L :<C-U>llast<CR>
nnoremap <unique> <silent> =l :<C-U>lwindow<CR>
nnoremap <unique> <silent> =L :<C-U>lclose<CR>
nnoremap <unique> <silent> [q :<C-U>Cprevious<CR>
nnoremap <unique> <silent> <C-h> :<C-U>Cprevious<CR>
nnoremap <unique> <silent> ]q :<C-U>Cnext<CR>
" ignore default nvim mapping
nnoremap <silent> <C-l> :<C-U>Cnext<CR>
nnoremap <unique> <silent> [Q :<C-U>cfirst<CR>
nnoremap <unique> <silent> ]Q :<C-U>clast<CR>
nnoremap <unique> <silent> =q :<C-U>cwindow<CR>
nnoremap <unique> <silent> =Q :<C-U>cclose<CR>
nnoremap <unique> <silent> [t gT
nnoremap <unique> <silent> ]t gt
nnoremap <unique> <silent> [T :<C-U>tfirst<CR>
nnoremap <unique> <silent> ]T :<C-U>tlast<CR>

nnoremap <unique> <silent> ]n :call Conflict(0)<CR>
nnoremap <unique> <silent> [n :call Conflict(1)<CR>

nnoremap <unique> <silent> [ob :set background=light<CR>
nnoremap <unique> <silent> [oc :set nocursorline<CR>
nnoremap <unique> <silent> [od :diffoff<CR>
nnoremap <unique> <silent> [oD :windo call CommandOnBuffer('diffoff')<CR>
nnoremap <unique> <silent> [oh :set nohlsearch<CR>
nnoremap <unique> <silent> [oi :set noignorecase<CR>
nnoremap <unique> <silent> [ol :set nolist<CR>
nnoremap <unique> <silent> [on :set nonumber<CR>
nnoremap <unique> <silent> [op :set nopaste<CR>
nnoremap <unique> <silent> [or :set norelativenumber<CR>
nnoremap <unique> <silent> [os :set nospell<CR>
nnoremap <unique> <silent> [ou :set nocursorcolumn<CR>
nnoremap <unique> <silent> [ov :set virtualedit=""<CR>
nnoremap <unique> <silent> [ow :set nowrap<CR>
nnoremap <unique> <silent> [ox :set nocursorline nocursorcolumn<CR>

nnoremap <unique> <silent> ]ob :set background=dark<CR>
nnoremap <unique> <silent> ]oc :set cursorline<CR>
nnoremap <unique> <silent> ]od :diffthis<CR>
nnoremap <unique> <silent> ]oD :windo call CommandOnBuffer('diffthis')<CR>
nnoremap <unique> <silent> ]oh :set hlsearch<CR>
nnoremap <unique> <silent> ]oi :set ignorecase<CR>
nnoremap <unique> <silent> ]ol :set list<CR>
nnoremap <unique> <silent> ]on :set number<CR>
nnoremap <unique> <silent> ]op :set nopaste<CR>
nnoremap <unique> <silent> ]or :set relativenumber<CR>
nnoremap <unique> <silent> ]os :set spell<CR>
nnoremap <unique> <silent> ]ou :set cursorcolumn<CR>
nnoremap <unique> <silent> ]ov :set virtualedit=""<CR>
nnoremap <unique> <silent> ]ow :set wrap<CR>
nnoremap <unique> <silent> ]ox :set cursorline cursorcolumn<CR>

nnoremap <unique> <silent> =ob :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <unique> <silent> =oc :set cursorline!<CR>
nnoremap <unique> <silent> =od :set diff!<CR>
nnoremap <unique> <silent> =oh :set hlsearch!<CR>
nnoremap <unique> <silent> =oi :set ignorecase!<CR>
nnoremap <unique> <silent> =ol :set list!<CR>
nnoremap <unique> <silent> =on :set number!<CR>
nnoremap <unique> <silent> =op :set paste!<CR>
nnoremap <unique> <silent> =or :set relativenumber!<CR>
nnoremap <unique> <silent> =os :set spell!<CR>
nnoremap <unique> <silent> =ou :set cursorcolumn!<CR>
" nnoremap =ov :set virtualedit=""<CR>
nnoremap <unique> <silent> =ow :set wrap!<CR>
nnoremap <unique> <silent> =ox :set cursorline! cursorcolumn!<CR>
nnoremap <unique> <silent> [of zN
nnoremap <unique> <silent> ]of zn
nnoremap <unique> <silent> =of :call ToggleFoldmethod()<CR>
nnoremap <unique> <silent> ]ofd :setlocal foldmethod=diff<CR>
nnoremap <unique> <silent> ]ofi :setlocal foldmethod=indent<CR>
nnoremap <unique> <silent> ]ofm :setlocal foldmethod=manual<CR>
nnoremap <unique> <silent> ]ofM :setlocal foldmethod=marker<CR>
nnoremap <unique> <silent> ]ofs :setlocal foldmethod=syntax<CR>

nnoremap <unique> <silent> z] :call GoToOpenFold(1)<CR>
nnoremap <unique> <silent> z[ :call GoToOpenFold(-1)<CR>

nnoremap <unique> <silent> <SPACE>K :Man<CR>
" Reveal syntax group under cursor.
nnoremap <unique> <silent> <F2> :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
nnoremap <unique> <silent> <F1> :call NextColour(1)<CR>
nnoremap <unique> <silent> <F7> :call RandomColour()<CR>
 " <S-F8>
nnoremap <unique> <silent> <F20> :call NextColor(-1)<CR>
nnoremap <unique> <silent> <F9> :call NextAirlineTheme(1)<CR>
nnoremap <unique> <silent> <F21> :call NextAirlineTheme(-1)<CR> " <S-F9>

inoremap <silent> <unique> <M-r> <C-O>:call VimFootnotes('roman')<CR>
inoremap <silent> <unique> <M-a> <C-O>:call VimFootnotes('alpha')<CR>
inoremap <silent> <unique> <M-n> <C-O>:call VimFootnotes('arabic')<CR>

" make I and A work with visual and visual line modes
vnoremap <unique> <silent> gA :<C-u>call VisualBlockOperation('A')<CR>
vnoremap <unique> <silent> gI :<C-u>call VisualBlockOperation('I')<CR>
vnoremap <unique> <silent> iu :<C-U>call URLTextObj()<CR>
onoremap <unique> <silent> iu :<C-U>call URLTextObj()<CR>
nnoremap <unique> <silent> ]u :call vimwiki#base#find_next_link()<CR>
nnoremap <unique> <silent> [u :call vimwiki#base#find_prev_link()<CR>


let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_2html_plugin = 1
let g:loaded_skim = 1
let g:loaded_tutor_mode_plugin = v:true
packadd termdebug
" packadd cfilter
packadd justify

"##### TUI
Plug 'https://github.com/bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"##### Windows
Plug 'https://github.com/simeji/winresizer', { 'on': 'WinResizerStartResize' }
let g:winresizer_start_key = ''
Plug 'https://github.com/wellle/visual-split.vim', { 'on': ['VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow', '<Plug>(Visual-Split-VSResize)', '<Plug>(Visual-Split-VSSplit)', '<Plug>(Visual-Split-VSSplitAbove)', '<Plug>(Visual-Split-VSSplitBelow)'] }
Plug 'https://github.com/t9md/vim-choosewin', { 'on': '<Plug>(choosewin)' }
nnoremap <unique> <silent> <Leader>wr :WinResizerStartResize<CR>
xmap <unique> <silent> <Leader>ws <Plug>(Visual-Split-VSSplit)
nmap <unique> <silent> <Leader>wl <Plug>(choosewin)
nnoremap <unique> <silent> <Leader>wz :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <C-w>z :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <C-w><C-z> :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <Leader>wL :Windows<CR>
nnoremap <unique> <silent> <Leader>wQ :quitall<CR>
Plug 'https://github.com/troydm/zoomwintab.vim', { 'on': 'ZoomWinTabToggle'}
let g:zoomwintab_remap=0
nnoremap <unique> <silent> <C-w>u :ZoomWinTabToggle<CR>
nnoremap <unique> <silent> <C-w><C-u> :ZoomWinTabToggle<CR>
nnoremap <unique> <silent> <Leader>wu :ZoomWinTabToggle<CR>

"##### Refactoring; edition; text objects
Plug 'https://github.com/wellle/targets.vim'
let g:targets_aiAI='ai  '
Plug 'https://github.com/michaeljsmith/vim-indent-object'
Plug 'https://github.com/jessekelighine/vindent.vim'
let g:vindent_blockmotion_OO_prev = '<space>p'
let g:vindent_blockmotion_OO_next = '<space>n'
let g:vindent_motion_less_prev =    '[<'
let g:vindent_motion_less_next =    ']<'
let g:vindent_motion_more_prev =    '[>'
let g:vindent_motion_more_next =    ']>'
let g:vindent_motion_diff_prev =    '<space>k'
let g:vindent_motion_diff_next =    '<space>j'
let g:vindent_object_ii =           'ii'
let g:vindent_object_iI =           'iI'
let g:vindent_object_ai =           'ai'
let g:vindent_object_aI =           'aI'
let g:vindent_tabstop   =           &tabstop " let vindent know to treat 1 <Tab> as tabstop # of <Spaces>s.
" text objects that require vim-textobj-user
Plug 'https://github.com/kana/vim-textobj-user'
" Plug 'https://github.com/thinca/vim-textobj-comment'
" Plug 'https://github.com/glts/vim-textobj-comment' " ic
" Plug 'https://github.com/beloglazov/vim-textobj-quotes' " iq
Plug 'https://github.com/Julian/vim-textobj-variable-segment' " iv

Plug 'https://github.com/machakann/vim-sandwich'
Plug 'https://github.com/fenuks/vim-bracket-objects'
Plug 'https://github.com/mg979/vim-visual-multi'
Plug 'https://github.com/tpope/vim-commentary', { 'on': 'Commentary'}
noremap <unique> <silent> <c-_> :Commentary<CR>
Plug 'https://github.com/tommcdo/vim-exchange'
Plug 'https://github.com/kshenoy/vim-signature', {'on': 'SignatureToggleSigns'}
Plug 'https://github.com/inkarkat/vim-ReplaceWithRegister', {'on': ['<Plug>ReplaceWithRegisterOperator', '<Plug>ReplaceWithRegisterLine', '<Plug>ReplaceWithRegisterVisual']}
nmap <unique> <silent> ro <Plug>ReplaceWithRegisterOperator
nmap <unique> <silent> roo <Plug>ReplaceWithRegisterLine
xmap <unique> <silent> ro <Plug>ReplaceWithRegisterVisual
Plug 'https://github.com/sk1418/Join'

Plug 'https://github.com/fenuks/toggle-values.vim'
" <a-t>
nmap <unique> <silent> ß <Plug>(ToggleValueNormal)
vmap <unique> <silent> ß <Plug>(ToggleValueVisual)
nmap <unique> <silent> © <Plug>(ToggleValueOperator)
imap <unique> <silent> ß <C-o><Plug>(ToggleValueNormal)<right>
let g:toggle_values = {
\    'filetypes': {
\        '':
\            [
\                {'ignore_case': v:true,'keep_case': v:true, 'values': ['True', 'False']},
\            ],
\    },
\    'languages': {
\        'en_gb': {
\          'ignore_case': v:true,
\          'keep_case': v:true,
\          'definitions': [
\            ['yes', 'no'],
\            ['on', 'off'],
\          ]
\        },
\        'pl': {
\          'ignore_case': v:true,
\          'keep_case': v:true,
\          'definitions': [
\            ['tak', 'nie'],
\          ]
\        }
\    }
\}

"#### Version Control
Plug 'https://github.com/sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'https://github.com/mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <unique> <silent> <Leader>vL :UndotreeToggle<CR>
Plug 'https://github.com/mhinz/vim-signify', { 'on': 'SignifyToggle' } " shows which lines were added and such
let g:signify_vcs_list=['git', 'hg']
Plug 'https://github.com/airblade/vim-gitgutter'
nmap <unique> <silent> ]c <Plug>(GitGutterNextHunk)
nmap <unique> <silent> [c <Plug>(GitGutterPrevHunk)
let g:gitgutter_map_keys = 0
nnoremap <unique> <silent> <Leader>vll :GitGutterToggle<CR>
nnoremap <unique> <silent> <Leader>vlL :SignifyToggle<CR>
nmap <unique> <silent> <Leader>vla <Plug>(GitGutterStageHunk)
nmap <unique> <silent> <Leader>vlu <Plug>(GitGutterUndoHunk)
nmap <unique> <silent> <Leader>vld <Plug>(GitGutterPreviewHunk)
"GIT
Plug 'https://github.com/tpope/vim-fugitive'
nnoremap <unique> <silent> <Leader>va :Gwrite<CR>
nnoremap <unique> <silent> <Leader>vb :Git blame<CR>
nnoremap <unique> <silent> <Leader>vc :Git commit<CR>
nnoremap <unique> <silent> <Leader>vh :0Gclog<CR>
nnoremap <unique> <silent> <Leader>vm :GMove<CR>
nnoremap <unique> <silent> <Leader>vds :Git! diff --staged<CR>
nnoremap <unique> <silent> <Leader>vdd :Git! diff<CR>
nnoremap <unique> <silent> <Leader>vdb :Gvdiffsplit<CR>
nnoremap <unique> <silent> <Leader>vqq :Git difftool<CR>
nnoremap <unique> <silent> <Leader>vqQ :Git difftool --name-only<CR>
nnoremap <unique> <silent> <Leader>vqs :Git difftool --staged<CR>
nnoremap <unique> <silent> <Leader>vqS :Git difftool --staged --name-only<CR>
nnoremap <unique> <silent> <Leader>vr :Gread<CR>
nnoremap <unique> <silent> <Leader>vR :GRemove<CR>
nnoremap <unique> <silent> <Leader>vs :Git<CR>

nnoremap <unique> <silent> <Leader>U  :GundoToggle<CR>

Plug 'https://github.com/rbong/vim-flog', {'on': 'Flog'}
nnoremap <unique> <silent> <Leader>vg :Flog<CR>
Plug 'https://github.com/junegunn/gv.vim', {'on': 'GV'}
nnoremap <unique> <silent> <Leader>vG :GV<CR>
Plug 'https://github.com/jreybert/vimagit', { 'on': 'Magit' }
nnoremap <unique> <silent> <Leader>vM :Magit<CR>
Plug 'https://github.com/rhysd/git-messenger.vim', { 'on': 'GitMessenger' }
"HG
" Plug 'https://github.com/ludovicchabant/vim-lawrencium' " disabled, it takes 5ms to load
" Plug 'https://github.com/jlfwong/vim-mercenary'
Plug 'https://github.com/will133/vim-dirdiff', { 'on': 'DirDiff' }
nnoremap <unique> <silent> <Leader>df :call DiffOrig()<CR>
nnoremap <unique> <silent> <Leader>dw :windo call CommandOnBuffer('diffthis')<CR>
nnoremap <unique> <silent> <Leader>dW :windo call CommandOnBuffer('diffoff')<CR>

Plug 'https://github.com/wsdjeg/vim-fetch'
snoremap <unique> <silent> <C-k> <ESC>ddi
inoremap <unique> <silent> <C-S-u> <C-o>D

Plug 'https://github.com/scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <unique> <silent> <Leader>ft :NERDTreeToggle<CR>
nnoremap <unique> <silent> <Leader>fT :NERDTreeFind<CR>
nnoremap <unique> <silent> <Leader>fs :call ReadSkeletonFile()<CR>
let g:NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__', 'jdt.ls-java-project']
let g:NERDTreeMinimalUI=1
let g:NERDTreeBookmarksFile=g:vim_share_dir . '/NERDTreeBookmarks'

Plug 'https://github.com/mhinz/vim-grepper', { 'on': ['Grepper', '<Plug>(GrepperOperator)'] }
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.prompt_quote = 3
let g:grepper.rg = {}
let g:grepper.rg.grepprg = 'rg -H --no-heading --vimgrep --smart-case'

nnoremap <unique> <silent> s/ :Grepper -tool rg<CR>
nnoremap <unique> <silent> si/ :Grepper -tool rg -grepprg rg --no-heading --vimgrep --ignore-case<CR>
nnoremap <unique> <silent> ss :Grepper -tool rg -side<CR>
nnoremap <unique> <silent> s* :Grepper -tool rg -open -switch -cword -noprompt<CR>
nnoremap <unique> <silent> s% :Grepper -open -switch -cword -noprompt -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
nnoremap <unique> <silent> sf :Grepper -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
nnoremap <unique> <silent> sk :Grepper -tool rg -dir file<CR>
nnoremap <unique> <silent> sK :Grepper -tool rg -dir file -side<CR>
vmap <unique> <silent> s* <Plug>(GrepperOperator)
nmap <unique> <silent> so <Plug>(GrepperOperator)
nnoremap <unique> <silent> sb :Grepper -tool rg -buffers<CR>
nnoremap <unique> <silent> sB :Grepper -tool rg -buffers -side<CR>
" nnoremap <unique> <silent> sj <C-f>
" nnoremap <unique> <silent> sk <C-b>
" search url ((\w+://)|/)[a-zA-Z0-9.?&/]+
" vim regex: ( |"|\[|\=)((\w+:\/\/)|\/)[a-zA-Z0-9.?&/\-{}*]+

"##### Navigation
" gtags
" GNU global
" set cscopeprg=gtags-cscope
" source /usr/share/vim/vimfiles/plugin/gtags.vim
" source /usr/share/vim/vimfiles/plugin/gtags-cscope.vim
nnoremap <unique> <silent> <Leader>ol :mode\|nohlsearch<CR>
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
Plug 'https://github.com/bronson/vim-visual-star-search'
Plug 'https://github.com/ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['.mypy_cache']
" let g:gutentags_ctags_executable_haskell = 'hasktags'
Plug 'https://github.com/majutsushi/tagbar', { 'on': 'TagbarToggle' }
let g:airline#extensions#tabline#enabled = 1
" Plug 'https://github.com/devjoe/vim-codequery' " rich support for searching symbols support

" Plug 'https://github.com/rhysd/clever-f.vim'
" let g:clever_f_not_overwrites_standard_mappings=v:true
" " let g:clever_f_mark_char_color='ErrorMsg'
" map f <Plug>(clever-f-reset)<Plug>(clever-f-f)
" map ; <Plug>(clever-f-repeat-forward)

Plug 'https://github.com/fenuks/vim-uncommented', { 'on': ['<Plug>(NextCommented)', '<Plug>(NextUncommented)'] }
nmap <unique> <silent> ]/ <Plug>(NextCommented)
nmap <unique> <silent> [/ <Plug>(PrevCommented)
nmap <unique> <silent> ]\ <Plug>(NextUncommented)
nmap <unique> <silent> [\ <Plug>(PrevUncommented)
Plug 'https://github.com/andymass/vim-matchup'
Plug 'https://github.com/chaoren/vim-wordmotion'
let g:wordmotion_mappings = {
\ 'w' : '-',
\ 'b' : '_',
\ 'e' : 'g-',
\ 'ge' : 'g_',
\ 'aw' : 'a-',
\ 'iw' : 'i-',
\ '<C-R><C-W>' : '<C-R><M-w>'
\ }

imap <unique> <silent> <C-q> <C-\><C-o>d_
cmap <unique> <C-q> <C-f>d_<C-c><C-c>:<UP>
Plug 'https://github.com/arthurxavierx/vim-caser'
Plug 'https://github.com/justinmk/vim-sneak', { 'on': ['<Plug>Sneak_s', '<Plug>Sneak_S'] }
map <unique> <silent> s; <Plug>Sneak_s
map <unique> <silent> s, <Plug>Sneak_S


"##### Formatting
Plug 'https://github.com/sbdchd/neoformat', { 'on': 'Neoformat' }
let g:neoformat_enabled_python = ['black', 'isort']
let g:neoformat_enabled_json = ['prettier', 'js-beautify', 'jq']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_haskell = ['stylish-haskell', 'floskell', 'ormolu']
let g:neoformat_all_subfiletypes_formatters = 1

nnoremap <unique> <silent> <Leader>q :Neoformat<CR>

Plug 'https://github.com/junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
xmap <unique> <silent> <Leader>ga <Plug>(EasyAlign)
nmap <unique> <silent> <Leader>ga <Plug>(EasyAlign)
"Plug 'https://github.com/godlygeek/tabular'
"Plug 'https://github.com/tommcdo/vim-lion'
"let g:lion_squeeze_spaces = 1

Plug 'https://github.com/obreitwi/vim-sort-folds', { 'on': 'SortFolds' }

"##### Syntax analysis
Plug 'https://github.com/dense-analysis/ale'
let g:ale_linters = {
\   'haskell': ['cabal_ghc', 'stack-build', 'stack-ghc', 'hlint'],
\   'python': ['mypy', 'pylint', 'flake8'],
\   'java': ['pmd'],
\   'rust': ['cargo'],
\}
let g:ale_sign_error = '𐄂'
" let g:ale_sign_error = '✖'
" let g:ale_sign_info = 'Ꭵ'
" let g:ale_sign_info = '¿'
" let g:ale_sign_info = 'į'
let g:ale_sign_info = 'ɨ'
" let g:ale_sign_warning = '>>'
let g:ale_sign_warning = '■'
let g:ale_virtualtext_cursor = 1
let g:ale_sign_highlight_linenrs = 1

 " languagetool doesn't understand md syntax…
let g:ale_linters_ignore = {
\ 'vimwiki': ['languagetool'],
\ 'markdown': ['languagetool'],
\}
" disabled languagetool for vimwiki since it doesn't understand markdown syntax,
" and reportss plenty of errors
let g:ale_fixers = {
\   '': ['trim_whitespace'],
\   'javascript': ['eslint'],
\   'json': ['fixjson'],
\   'python': ['yapf', 'isort']
\}
let g:ale_c_parse_makefile=0
let g:ale_c_parse_compile_commands=1
let g:ale_python_mypy_options='--ignore-missing-imports'
let g:ale_python_flake8_options='--append-config ' . $HOME . '.config/flake8'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:airline#extensions#ale#enabled = 1
nnoremap <unique> <silent> <Leader>cf :ALEFix<CR>
nmap <unique> <silent> <Leader>cp <Plug>(ale_previous_wrap)
nmap <unique> <silent> <Leader>cn <Plug>(ale_next_wrap)
nnoremap <unique> <silent> <Leader>co :lwindow<CR>
nnoremap <unique> <silent> <Leader>cO :lclose<CR>
" let g:ale_open_list = 1 " conflicts with ultisnips jumping

"##### Tasks
Plug 'https://github.com/neomake/neomake', { 'on': ['Neomake', 'NeomakeProject'] }
let g:neomake_open_list = 2
let g:airline#extensions#neomake#enabled = 0
nnoremap <unique> <silent>  <Leader>mb :make \| redraw \| cwindow<CR>
" non-unique, can be redefined per filetype
nnoremap <silent> <Leader>mi :make install<CR>
nnoremap <silent> <Leader>mc :make clean<CR>

if filereadable('build/Makefile')
    compiler! cmake
endif

Plug 'https://github.com/vim-test/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit'] }
let g:test#strategy = 'neovim'
let g:test#runner_commands = ['PyTest']
nnoremap <unique> <silent> <leader>xn :TestNearest<CR>
nnoremap <unique> <silent> <leader>xf :TestFile<CR>
nnoremap <unique> <silent> <leader>xa :TestSuite<CR>
nnoremap <unique> <silent> <leader>xl :TestLast<CR>
nnoremap <unique> <silent> <leader>xg :TestVisit<CR>

" Plug 'https://github.com/puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'

" ##### Code autocompletion
Plug 'https://github.com/natebosch/vim-lsc', { 'on': 'LSClientEnable' }

Plug 'https://github.com/Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
if has('nvim')
    let g:my_use_nvim_autopairs = v:true
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    let g:echodoc#type = 'virtual'
    Plug 'https://github.com/ncm2/float-preview.nvim'
    let g:float_preview#docked = 0
    let g:float_preview#max_height=100
    " LSP
    Plug 'https://github.com/neovim/nvim-lspconfig'
    Plug 'https://github.com/ray-x/lsp_signature.nvim'
    Plug 'https://github.com/simrat39/rust-tools.nvim'
    Plug 'https://github.com/kosayoda/nvim-lightbulb'
    Plug 'https://github.com/mfussenegger/nvim-jdtls'
    " autocomplete
    Plug 'https://github.com/hrsh7th/nvim-cmp'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
    Plug 'https://github.com/hrsh7th/cmp-buffer'
    Plug 'https://github.com/hrsh7th/cmp-path'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lua'
    Plug 'https://github.com/f3fora/cmp-spell'
    Plug 'https://github.com/quangnguyen30192/cmp-nvim-ultisnips'
    " treesitter
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter-refactor'
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'https://github.com/nvim-treesitter/playground'
    Plug 'https://github.com/romgrk/nvim-treesitter-context'
    Plug 'https://github.com/windwp/nvim-ts-autotag'
    Plug 'https://github.com/abecodes/tabout.nvim'

    Plug 'https://github.com/windwp/nvim-autopairs'
    Plug 'https://github.com/simrat39/symbols-outline.nvim'

    Plug 'https://github.com/nvim-telescope/telescope.nvim'
    Plug 'https://github.com/nvim-telescope/telescope-fzy-native.nvim'
    nnoremap <unique> <silent> z= :Telescope spell_suggest<CR>
    nnoremap <unique> <silent> xx :Telescope find_files<CR>
    nnoremap <unique> <silent> <Leader>fl :Telescope find_files<CR>
    nnoremap <unique> <silent> <Leader>fd :lua require('telescope.builtin').find_files({cwd=require('telescope.utils').buffer_dir()})<CR>
    nnoremap <unique> <silent> g? :Telescope current_buffer_tags<CR>
    nnoremap <unique> <silent> <Leader>gt :Telescope tags<CR>
    nnoremap <unique> <silent> <Leader>gh :Telescope oldfiles<CR>
    nnoremap <unique> <silent> <Leader>bl :Telescope buffers<CR>

    Plug 'https://github.com/phaazon/hop.nvim'
    nnoremap <unique> <silent> <Leader><Leader>b :HopWordBC<CR>
    nnoremap <unique> <silent> <Leader><Leader>w :HopWordAC<CR>
    nnoremap <unique> <silent> <Leader><Leader>j :HopLineAC<CR>
    nnoremap <unique> <silent> <Leader><Leader>k :HopLineBC<CR>
    nnoremap <unique> <silent> <Leader><Leader>f :HopChar1CurrentLineAC<CR>
    nnoremap <unique> <silent> <Leader><Leader>F :HopChar1CurrentLineBC<CR>
    nnoremap <unique> <silent> <Leader><Leader>/ :HopPatternAC<CR>
    nnoremap <unique> <silent> <Leader><Leader>? :HopPatternBC<CR>

    Plug 'https://github.com/windwp/nvim-ts-autotag'

    Plug 'https://github.com/kristijanhusak/orgmode.nvim'
    " FIXME
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'
else
    Plug 'https://github.com/Shougo/deoplete.nvim'
    Plug 'https://github.com/roxma/nvim-yarp'
    Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
    let g:echodoc#type = 'floating'
    Plug 'https://github.com/easymotion/vim-easymotion'
    let g:EasyMotion_verbose = 0
    runtime ftplugin/man.vim

    let g:my_use_nvim_autopairs = v:false
    "##### Autocomplete
    Plug 'https://github.com/fenuks/auto-pairs'
    let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
    \                    '„':'”', '‚': '’', '‘':'’', '“':'”'}
    let g:AutoClosePairs_add = '<> | „” ‘’'
    let g:AutoPairsShortcutToggle=''
    let g:AutoPairsShortcutFastWrap=''
    let g:AutoPairsShortcutJump=''
    let g:AutoPairsShortcutBackInsert=''
    let g:AutoPairsOnlyWhitespace=v:true
    let g:AutoPairsSkipAfter='\a'
    let g:AutoPairsSkipBefore=''
    let g:AutoPairsMoveCharacter = ''
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'
    nnoremap <unique> <silent> xx :Files<CR>
    nnoremap <unique> <silent> <Leader>fl :Files<CR>
    nnoremap <unique> <silent> <Leader>fd :Files <C-r>=expand("%:h")<CR>/<CR>
    nnoremap <unique> <silent> g? :Tags<CR>
    nnoremap <unique> <silent> <Leader>gt :Tags<CR>
    nnoremap <unique> <silent> <Leader>gh :History<CR>
    nnoremap <unique> <silent> <Leader>gT :BTags<CR>
    nnoremap <unique> <silent> <Leader>bl :Buffers<CR>

    Plug 'https://github.com/alvan/vim-closetag', { 'for': ['html', 'xml'] }
endif

Plug 'https://github.com/deoplete-plugins/deoplete-dictionary'
Plug 'https://github.com/zchee/deoplete-jedi', { 'for': 'python' }
Plug 'https://github.com/Shougo/neco-vim', { 'for': 'vim' }
" Plug 'https://github.com/zchee/deoplete-go', { 'for': 'go' }

let g:deoplete#enable_at_startup = 1
execute 'source ' . g:vim_custom_scripts . 'autocomplete.vim'

" snippets
Plug 'https://github.com/SirVer/ultisnips'

let g:UltiSnipsExpandTrigger = 'æ'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
let g:UltiSnipsListSnippets = '<c-x><c-s>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" let g:UltiSnipsJumpForwardTrigger='æ' " <a-f>
" let g:UltiSnipsJumpBackwardTrigger='Æ' " <a-s-f>
" <a-f>
" imap <unique> <silent> æ <Plug>(ultisnips_expand)

"#### Language specific
let g:polyglot_disabled = ['sensible', 'autoindent']
" Plug 'https://github.com/sheerun/vim-polyglot'

" ##### VIML
Plug 'https://github.com/junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }

"##### HTML5
Plug 'https://github.com/mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }

"##### CSS
Plug 'https://github.com/ap/vim-css-color'
" Plug 'https://github.com/RRethy/vim-hexokinase'

"##### javascript
let g:javascript_plugin_jsdoc = 1

"##### Python
Plug 'https://github.com/davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'https://github.com/jupyter-vim/jupyter-vim', { 'for': 'python' }
let g:jupyter_mapkeys = 0
" Plug 'https://github.com/dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

"##### JVM
"##### Java
" Plug 'https://github.com/artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'https://github.com/mikelue/vim-maven-plugin', { 'on': ['Mvn', 'MvnNewMainFile'] }
let g:java_highlight_functions=1

"####### Functional
"""##### Haskell
" Plug 'https://github.com/parsonsmatt/intero-neovim', { 'for': 'haskell' }

" Plug 'https://github.com/vlime/vlime' { 'for': 'lisp' }
Plug 'https://github.com/kovisoft/slimv', { 'for': 'lisp' }
let g:lisp_rainbow=1
let g:scheme_builtin_swank=1

" ##### C family
Plug 'https://github.com/jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp'] }

Plug 'https://github.com/ziglang/zig.vim', { 'for': ['zig'] }
let g:zig_fmt_autosave = 0

"##### Natural language
Plug 'https://github.com/tpope/vim-characterize'
" Plug 'https://github.com/vim-scripts/LanguageTool'
Plug 'https://github.com/dpelle/vim-LanguageTool', { 'for': ['rst'] }
Plug 'https://github.com/rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }


"##### Markdown
" Plug 'https://github.com/suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'https://github.com/plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_strikethrough = 1
Plug 'https://github.com/vimwiki/vimwiki', { 'branch': 'dev' }
let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_list = [{'path': $XDG_DOCUMENTS_DIR . '/notatki/',
                     \  'name': 'wiki', 'auto_toc': 1,
                     \ 'syntax': 'markdown', 'ext': '.md' },
                     \ {'path': $XDG_DOCUMENTS_DIR . '/notatki/zettel',
                     \ 'name': 'zettel',
                     \ 'syntax': 'markdown', 'ext': '.md' }
\]
let g:vimwiki_autowriteall=0
let g:vimwiki_folding='expr'
let g:vimwiki_url_maxsave=25
let g:vimwiki_key_mappings = { 'links': 0, 'table_mappings': 0}
nmap <unique> <silent> sv <Plug>VimwikiIndex
" Plug 'https://github.com/fenuks/vim-zettel'
let g:zettel_format='%title'
let g:zettel_default_mappings = 0
let g:zettel_fzf_command = 'rg --column --line-number --smart-case --no-heading --color=always'
let g:zettel_options = [{}, {'front_matter' : [['tags', ''], ['type','note']]}]

Plug 'https://github.com/m-pilia/vim-mediawiki', { 'for': 'mediawiki' }

" Database
let g:sql_type_default='psql'

"##### TeX
Plug 'https://github.com/lervag/vimtex', { 'for': 'tex' }
" Plug 'https://github.com/scrooloose/vim-slumlord' " plantuml previews
let g:tex_flavor='latex'
let g:vimtex_view_method='okular'
let g:tex_conceal='abdmg'

"##### Colourshemes
" set background=dark
Plug 'https://github.com/gruvbox-community/gruvbox'
Plug 'https://github.com/overcache/NeoSolarized'
Plug 'https://github.com/lifepillar/vim-solarized8'
Plug 'https://github.com/romainl/flattened'
Plug 'https://github.com/arzg/vim-corvine'
Plug 'https://github.com/lifepillar/vim-gruvbox8'
Plug 'https://github.com/sainnhe/gruvbox-material'
Plug 'https://github.com/kjssad/quantum.vim'
Plug 'https://github.com/ayu-theme/ayu-vim'
Plug 'https://github.com/sonph/onehalf'
Plug 'https://github.com/nlknguyen/papercolor-theme'
Plug 'https://github.com/sainnhe/edge'
let g:edge_enable_italic = 1
Plug 'https://github.com/savq/melange'
Plug 'https://github.com/Shatur/neovim-ayu'
Plug 'https://github.com/Pocco81/Catppuccino.nvim'
Plug 'https://github.com/projekt0n/github-nvim-theme'
Plug 'https://github.com/sainnhe/everforest'
Plug 'https://github.com/marko-cerovac/material.nvim'
Plug 'https://github.com/shaunsingh/solarized.nvim'
if has('nvim')
    Plug 'https://github.com/folke/tokyonight.nvim', { 'branch': 'main' }
endif

set background=light
if &background ==# 'light'
    let g:ayucolor='light'
    Plug 'https://github.com/vim-airline/vim-airline-themes'
endif

call plug#end()

set guifont=Hack:h20
if has('gui_running') || exists(':GuiFont')
    let g:solarized_diffmode='high'
    colorscheme gruvbox
    set lines=50 columns=140
else
    if &background ==# 'light'
        let g:airline_theme='edge'
        colorscheme edge
    else
        colorscheme gruvbox8
    endif
endif
" transparent: CandyPaper,
" gruvbox, badwolf
" truecolour: onedark, OceanicNext

execute 'source ' . g:vim_custom_scripts . 'functions.vim'
execute 'source ' . g:vim_custom_scripts . 'spelling.vim'

if &diff
    call ConfigureDiff()
endif

call deoplete#custom#option({
    \ 'ignore_sources': {'c': ['tag'], 'cpp': ['tag'], 'xml': ['tag']},
    \ 'auto_complete': v:false
\ })
call deoplete#custom#source('_', {
    \ 'matchers': ['matcher_full_fuzzy'],
\ })
call deoplete#custom#source('_', 'smart_case', v:true)
call deoplete#custom#source('dictionary', {
    \ 'matchers': ['matcher_head'],
    \ 'sorters': [],
    \ 'converters': ['converter_case'],
    \ 'ignore_case': v:true,
    \ 'smart_case': v:false,
    \ 'camel_case': v:false,
\ })

""" functions
command! Cnext call WrapListCommand('cnext', 'cfirst')
command! Cprevious call WrapListCommand('cprev', 'clast')
command! Lnext call WrapListCommand('lnext', 'lfirst')
command! Lprevious call WrapListCommand('lprev', 'llast')

augroup vim
    autocmd!
    autocmd FileType muttrc nnoremap <unique> <silent> <buffer> K :call SearchMan('neomuttrc', '', '<cword>')<CR>
    autocmd FileType firejail nnoremap <unique> <silent> <buffer> K :call SearchMan('firejail-profile', '', '<cfile>')<CR>
    autocmd FileType sshconfig nnoremap  <unique> <silent> <buffer> K :call SearchMan('ssh_config', '', '<cfile>')<CR>
    autocmd FileType gitconfig nnoremap  <unique> <silent> <buffer> K :call SearchMan('git-config', '', '<cfile>')<CR>
    autocmd FileType cmake nnoremap <unique> <silent> <buffer>  K :call SearchCmakeMan()<CR>
    autocmd FileType qf,fugitive setlocal nobuflisted " exclude quickfix withow from :bnext, etc.
    " needed for autoread to be triggered
    autocmd CursorHold * call ChecktimeFileBuffer()
    " reopening a file, restore last cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
    autocmd BufRead *.orig set readonly
    autocmd BufRead *.sh.spec compiler shellspec
    " equalize splits on resize event
    autocmd VimResized * wincmd =
    " highlight trailing spaces
    call CustomSyntax()
    autocmd ColorScheme * call CustomSyntax()
    autocmd OptionSet diff call ConfigureDiff()
augroup END

augroup filetype_detect
    autocmd!
    autocmd BufRead,BufNewFile *.recipe setfiletype python
    autocmd BufRead,BufNewFile *.conf setfiletype conf
    autocmd BufRead,BufNewFile env setfiletype sh
    autocmd BufRead,BufNewFile PKGBUILD call ConfigurePkgbuild()
    autocmd BufNewFile,BufRead neomutt-* setf mail
augroup END

function! ConfigurePkgbuild() abort
    setlocal makeprg=makepkg
    nnoremap <silent><buffer> <Leader>mi :make -i<CR>
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal filetype=sh
endfunction

command! PlugInit !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if has('nvim')
    augroup nvim
        autocmd!
        autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
        autocmd DiagnosticChanged lua vim.diagnostic.setloclist()
    augroup END
    lua require 'init'
endif

" keymap, langmap
