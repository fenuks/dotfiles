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
set belloff=backspace,cursor,error,esc,operator " disable bell for selected events
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
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:␣
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

    if has('mac')
        let g:python_host_prog='/usr/local/bin/python2'
        let g:python3_host_prog='/usr/local/bin/python3'
    else
        let g:python_host_prog='/usr/bin/python2'
        let g:python3_host_prog='/usr/bin/python3'
    endif

else
    let g:tmp_dir=$TMP
    let g:local_share_dir=$APP_DATA
endif

if has('nvim')
    set scrollback=-1 " nvim terminal unlimited scrolling
    let g:vim_share_dir=g:local_share_dir . '/nvim'
    set inccommand=nosplit
    " set signcolumn=yes:2
    set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon500-blinkoff150
else
    " syntax highlight on, it breaks source order on neovim
    " https://github.com/neovim/neovim/issues/16928
    syntax on
    set viminfofile=$HOME/.vim/viminfo
    let g:vim_share_dir=g:local_share_dir . '/vim'
    set runtimepath+=~/.config/nvim,~/.config/nvim/after
    " set cursor shapes like in nvim
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
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
vnoremap <unique> x <NOP>
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
" replace selection
xnoremap <unique> xv :<C-u>%s/<C-R>=GetVisualSelection()<CR>/

nnoremap <unique> <silent> xSs :,$!sort -h<CR>
nnoremap <unique> <silent> xSS :,$!sort -h<CR>
vnoremap <unique> <silent> xss :!sort -h<CR>
nnoremap <unique> <silent> xss :set opfunc=SortOperator<CR>g@

nnoremap <unique> <silent> xSu :,$!sort -u<CR>
nnoremap <unique> <silent> xSU :,$!sort -u<CR>
vnoremap <unique> <silent> xsu :!sort -u<CR>
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
" nnoremap <unique> <silent> gj zogj
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

" windows TODO check if window has neighbour on the right/bottom
nnoremap <unique> <silent> <expr> <C-S-Up> MyHWinResize(2, 1)
nnoremap <unique> <silent> <expr> <C-S-Down> MyHWinResize(2, 0)
nnoremap <unique> <silent> <expr> <C-S-Right> MyVWinResize(2, 1)
nnoremap <unique> <silent> <expr> <C-S-Left> MyVWinResize(2, 0)

vnoremap <unique> <silent> <CR> :<C-u>call VJumpToWithOffset('^\s*$', 'Wz', -1)<CR>gv
vnoremap <unique> <silent> <S-CR> :<C-u>call VJumpToWithOffset('^\s*$', 'bWz', 1)<CR>gv
" nnoremap <unique> <silent> <CR> }
" nnoremap <unique> <silent> <S-CR> {

nnoremap <unique> <silent> dJ :<C-u>call DJ())<CR>
nnoremap <unique> <silent> dK :<C-u>call DK())<CR>
nnoremap <unique> <silent> gx :<C-u>call OpenUrl()<CR>
vnoremap <unique> <silent> gx :<C-u>call OpenUrlVisual('')<CR>
nnoremap <unique> <silent> gX :<C-u>call OpenUrlToLineEnd()<CR>
vnoremap <unique> gX :<C-u>call OpenUrlVisual('')<Left><Left>

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

if filereadable('build/Makefile')
    compiler! cmake
endif

let g:my_plugins_loaded = !filereadable('/etc/openwrt_release')

if g:my_plugins_loaded
  packadd termdebug
  " packadd cfilter
  " packadd justify " adds unwanted _j mappings
  execute 'source ' . g:vim_custom_scripts . 'plugins.vim'
end

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
      \   {
      \     'buns'    : ['‘', '’'],
      \   },
      \ ]

set guifont=Hack:h20
if has('gui_running') || exists(':GuiFont')
  let g:solarized_diffmode='high'
  if g:my_plugins_loaded
    colorscheme gruvbox
  end
  set lines=50 columns=140
else
  if g:my_plugins_loaded
    if &background ==# 'light'
        let g:airline_theme='edge'
        colorscheme edge
    else
        colorscheme gruvbox8
    endif
  end
endif
" transparent: CandyPaper,
" gruvbox, badwolf
" truecolour: onedark, OceanicNext

execute 'source ' . g:vim_custom_scripts . 'functions.vim'
execute 'source ' . g:vim_custom_scripts . 'spelling.vim'

if &diff
    call ConfigureDiff()
endif

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
    if g:my_plugins_loaded
      lua require 'init'
    end
endif

" keymap, langmap
