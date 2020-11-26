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
set foldclose=all " close fold after cursor leaves it

"" misc
set modelines=0 " number of lines vim probes to find vi: commands
set history=1000 " Number of things to remember in history
set cmdwinheight=20 " set commandline window height
set undolevels=1000
set autoread " Automatically reload file changed outside vim if not changed in vim
set completeopt=menuone,noselect " complete longest common text instead of first word

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
" set selection=exclusive

let g:vim_dir_path=fnamemodify($MYVIMRC, ':p:h')
let g:nvim_dir_path=expand('~/.config/nvim/')
let g:vim_custom_scripts=g:nvim_dir_path . 'custom/'
set pyxversion=3

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
" scroll autocomplete popup down with <C-f>
inoremap <unique> <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<C-f>"
" scroll autocomplete popup up with <C-b>
inoremap <unique> <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<C-b>"
inoremap <unique> <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" 'n' always goes forward
" nnoremap <unique> <expr> n  'Nn'[v:searchforward]
" 'N' always goes back
" nnoremap <unique> <expr> N  'nN'[v:searchforward]
" ; always goes forward
" nnoremap <unique> <expr> ; getcharsearch().forward ? ';' : ','
" , always goes back
" nnoremap <unique> <expr> , getcharsearch().forward ? ',' : ';'
" now i.e. 2dj will delete a column of 3 characters below
onoremap <unique> J <C-v>j
" now i.e. 2ck will change a column of 3 characters above
onoremap <unique> K <C-v>k
let mapleader = ','
let maplocalleader = '\'

vnoremap <unique> . :normal .<CR>
cnoremap <unique> w!! %!sudo tee > /dev/null %
" set very magic regex (perl compatitible)
nnoremap <unique> / /\v
vnoremap <unique> / /\v
cnoremap <unique> g/ g/\v
cnoremap <unique> v/ v/\v
" stay in visual mode while changing indentation
nnoremap <unique> gV `[v`] " select last changed text, original gV mapping is obscure
" better history scrolling, with context
cnoremap <unique> <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <unique> <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <unique> <C-a> <Home>
cnoremap <unique> <C-e> <End>

" moving lines up and down
nnoremap <unique> <silent> <M-]> :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap <unique> <silent> <M-[> :<C-u>execute 'move +'. v:count1<CR>
inoremap <unique> <silent> <M-]> <Esc>:m .+1<CR>==gi
inoremap <unique> <silent> <M-[> <Esc>:m .-2<CR>==gi
vnoremap <unique> <silent> <M-]> :m '>+1<CR>gv=gv
vnoremap <unique> <silent> <M-[> :m '<-2<CR>gv=gv
" insert spaces
nnoremap <unique> <silent> [<space>  :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap <unique> <silent> ]<space> :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" allows reusing x and X for other mappings;
" s and <space> can be also reused since cl is fine enough
nnoremap <unique> xp dlp
nnoremap <unique> xP dlP
nnoremap <unique> Xp dhP
nnoremap <unique> XP dhP
" trim trainling spaces
nnoremap <unique> <silent> xt :%s/\s\+$//<CR>
" convert non-breaking spaces to normal ones
nnoremap <unique> <silent> x<Space> :%s/\%u00a0/ /g<CR>
nnoremap <unique> <silent> xS :,$!sort<CR>
vnoremap <unique> <silent> xs :!sort<CR>
nnoremap <unique> <silent> xs :set opfunc=SortOperator<CR>g@
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

" edit register
nnoremap <unique> <silent> <Leader>@ :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><LEFT>

" mapping for indenting brackets
inoremap <unique> <C-M-CR> <CR><CR><UP><TAB>
inoremap <unique> <C-j> <END><CR>
" mapped as <C-S-j> in custom keymap
inoremap <unique> <C-S-CR> <Home><CR><UP>

nnoremap <unique> <C-s> :w<Enter>
inoremap <unique> <C-s> <ESC>:w<Enter>a
inoremap <unique> <C-l> <DEL>
inoremap <unique> jk <ESC>
inoremap <unique> jK <ESC>
inoremap <unique> Jk <ESC>
inoremap <unique> JK <ESC>

nnoremap <unique> Y y$
vnoremap <unique> <LocalLeader>y "+y
vnoremap <unique> <LocalLeader>d "+d
vnoremap <unique> <LocalLeader>p "+p
nnoremap <unique> <Leader><Space>p a <ESC>"+p
nnoremap <unique> <Space>p a <ESC>p
nnoremap <unique> <Space>P i <ESC>P
nnoremap <unique> yp "0p
nnoremap <unique> yP "0P
nnoremap <unique> <M-y> "+y
vnoremap <unique> <M-y> "+y
nnoremap <unique> <M-S-y> "+y$
nnoremap <unique> <M-p> "+p
vnoremap <unique> <M-p> "+p
inoremap <unique> <M-p> <C-o>"+p
nnoremap <unique> <Leader>pf :put =expand('%:p')<CR>
nnoremap <unique> <Leader>pd :put =expand('%:r')<CR>

nnoremap <unique> <LocalLeader>y "+y
nnoremap <unique> <LocalLeader>Y "+y$
nnoremap <unique> <LocalLeader>d "+d
nnoremap <unique> <LocalLeader>D "+D
nnoremap <unique> <LocalLeader>p "+p
nnoremap <unique> <LocalLeader>P "+P
nnoremap <unique> c* ciw
nnoremap <unique> d* diw

inoremap <unique> <M-h> <LEFT>
inoremap <unique> <M-l> <RIGHT>
inoremap <unique> <M-k> <UP>
inoremap <unique> <M-j> <DOWN>
cnoremap <unique> <M-h> <LEFT>
cnoremap <unique> <M-l> <RIGHT>
cnoremap <unique> <M-k> <UP>
cnoremap <unique> <M-j> <DOWN>

vnoremap <unique> <M-j> gj
vnoremap <unique> <M-k> gk
nnoremap <unique> <M-j> gj
nnoremap <unique> <M-k> gk
" select last inserted/pasted text
nnoremap <unique> gy `[v`]

nnoremap <unique> <silent> Ss :mksession! <C-r>=GetSessionName()<CR>
nnoremap <unique> <silent> Sl :SLoad <C-r>=GetSessionName()<CR>
nnoremap <unique> <silent> Sd :SDelete<CR>
nnoremap <unique> <silent> Sc :SClose<CR>

nnoremap <unique> <silent> <Leader>ev :edit $MYVIMRC<CR>
nnoremap <unique> <silent> <Leader>eb :edit $HOME/.bashrc<CR>

" buffers
nnoremap <unique> <silent> <Leader>bn :<C-u>call Execute(['enew'])<CR>
nnoremap <unique> <silent> <Leader>bs :<C-u>call Execute(['new'])<CR>
nnoremap <unique> <silent> <Leader>bv :<C-u>call Execute(['vnew'])<CR>
nnoremap <unique> <silent> <Leader>bd :<C-u>call Execute(['bdelete'])<CR>
nnoremap <unique> <silent> <Leader>bu :<C-u>call Execute(['call ChangeBuffer(1)', 'bdelete#'])<CR>
nnoremap <unique> <silent> <Leader>bh :<C-u>call Execute(['hide'])<CR>
nnoremap <unique> <silent> <Leader>bc :<C-u>call Execute(['close'])<CR>
nnoremap <unique> <silent> <Leader>bo :%bdelete<CR><C-^><C-^>:bdelete<CR>
nnoremap <unique> <silent> <Leader>bl :Buffers<CR>
nnoremap <unique> <silent> <Leader>br call DeleteHiddenBuffers()<CR>
nnoremap <unique> <silent> <Tab> :call ChangeBuffer(1)<CR>
nnoremap <unique> <silent> <S-Tab> :call ChangeBuffer(0)<CR>

nnoremap <unique> <silent> dJ :<C-u>call DJ())<CR>
nnoremap <unique> <silent> dK :<C-u>call DK())<CR>
nnoremap <unique> <silent> gx :<C-u>call OpenUrl()<CR>
vnoremap <unique> <silent> gx :<C-u>call OpenUrlVisual()<CR>
nnoremap <unique> <silent> gX :<C-u>call SearchWeb()<CR>
vnoremap <unique> <silent> gX :<C-u>call SearchWebVisual()<CR>

" terminal
tnoremap <unique> jk <C-\><C-n>
nnoremap <unique> <silent> <Leader>Tn :<C-u>call Execute(['new', 'only', 'terminal'])<CR>
nnoremap <unique> <silent> <Leader>Ts :<C-u>call Execute(['new', 'terminal'])<CR>
nnoremap <unique> <silent> <Leader>Tv :<C-u>call Execute(['vnew', 'terminal'])<CR>
nnoremap <unique> <silent> <Leader>Tt :<C-u>call Execute(['tabnew', 'terminal'])<CR>

" tabs
nnoremap <unique> <silent> <Leader>tn :<C-u>call Execute(['tabnew'])<CR>
nnoremap <unique> <silent> <Leader>to :tabonly<CR>
nnoremap <unique> <silent> <Leader>td :tabclose<CR>

" unimpaired mappings
nnoremap <unique> [a :<C-U>previous<CR>
nnoremap <unique> ]a :<C-U>next<CR>
nnoremap <unique> [A :<C-U>first<CR>
nnoremap <unique> ]A :<C-U>last<CR>
nnoremap <unique> <silent> [b :<C-U>call ChangeBuffer(0)<CR>
nnoremap <unique> <silent> ]b :<C-U>call ChangeBuffer(1)<CR>
nnoremap <unique> [B :<C-U>bfirst<CR>
nnoremap <unique> ]B :<C-U>blast<CR>
nnoremap <unique> <silent> [l :<C-U>Lprevious<CR>
nnoremap <unique> <silent> <C-k> :<C-U>Lprevious<CR>
nnoremap <unique> <silent> ]l :C-U>Lnext<CR>
nnoremap <unique> <silent> <C-j> :<C-U>Lnext<CR>
nnoremap <unique> [L :<C-U>lfirst<CR>
nnoremap <unique> ]L :<C-U>llast<CR>
nnoremap <unique> =l :<C-U>lwindow<CR>
nnoremap <unique> =L :<C-U>lclose<CR>
nnoremap <unique> <silent> [q :<C-U>Cprevious<CR>
nnoremap <unique> <silent> <C-h> :<C-U>Cprevious<CR>
nnoremap <unique> <silent> ]q :<C-U>Cnext<CR>
nnoremap <unique> <silent> <C-l> :<C-U>Cnext<CR>
nnoremap <unique> [Q :<C-U>cfirst<CR>
nnoremap <unique> ]Q :<C-U>clast<CR>
nnoremap <unique> =q :<C-U>cwindow<CR>
nnoremap <unique> =Q :<C-U>cclose<CR>
nnoremap <unique> [t gT
nnoremap <unique> ]t gt
nnoremap <unique> [T :<C-U>tfirst<CR>
nnoremap <unique> ]T :<C-U>tlast<CR>

nnoremap <unique> <silent> ]n :call Conflict(0)<CR>
nnoremap <unique> <silent> [n :call Conflict(1)<CR>

nnoremap <unique> [ob :set background=light<CR>
nnoremap <unique> [oc :set nocursorline<CR>
nnoremap <unique> [od :diffoff<CR>
nnoremap <unique> [oD :windo diffoff<CR>
nnoremap <unique> [oh :set nohlsearch<CR>
nnoremap <unique> [oi :set noignorecase<CR>
nnoremap <unique> [ol :set nolist<CR>
nnoremap <unique> [on :set nonumber<CR>
nnoremap <unique> [op :set nopaste<CR>
nnoremap <unique> [or :set norelativenumber<CR>
nnoremap <unique> [os :set nospell<CR>
nnoremap <unique> [ou :set nocursorcolumn<CR>
nnoremap <unique> [ov :set virtualedit=""<CR>
nnoremap <unique> [ow :set nowrap<CR>
nnoremap <unique> [ox :set nocursorline nocursorcolumn<CR>

nnoremap <unique> ]ob :set background=dark<CR>
nnoremap <unique> ]oc :set cursorline<CR>
nnoremap <unique> ]od :diffthis<CR>
nnoremap <unique> ]oD :windo diffthis<CR>
nnoremap <unique> ]oh :set hlsearch<CR>
nnoremap <unique> ]oi :set ignorecase<CR>
nnoremap <unique> ]ol :set list<CR>
nnoremap <unique> ]on :set number<CR>
nnoremap <unique> ]op :set nopaste<CR>
nnoremap <unique> ]or :set relativenumber<CR>
nnoremap <unique> ]os :set spell<CR>
nnoremap <unique> ]ou :set cursorcolumn<CR>
nnoremap <unique> ]ov :set virtualedit=""<CR>
nnoremap <unique> ]ow :set wrap<CR>
nnoremap <unique> ]ox :set cursorline cursorcolumn<CR>

nnoremap <unique> =ob :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <unique> =oc :set cursorline!<CR>
nnoremap <unique> =od :set diff!<CR>
nnoremap <unique> =oh :set hlsearch!<CR>
nnoremap <unique> =oi :set ignorecase!<CR>
nnoremap <unique> =ol :set list!<CR>
nnoremap <unique> =on :set number!<CR>
nnoremap <unique> =op :set paste!<CR>
nnoremap <unique> =or :set relativenumber!<CR>
nnoremap <unique> =os :set spell!<CR>
nnoremap <unique> =ou :set cursorcolumn!<CR>
" nnoremap =ov :set virtualedit=""<CR>
nnoremap <unique> =ow :set wrap!<CR>
nnoremap <unique> =ox :set cursorline! cursorcolumn!<CR>
nnoremap <unique> [of zN
nnoremap <unique> ]of zn
nnoremap <unique> <silent> =of :call ToggleFoldmethod()<CR>
nnoremap <unique> ]ofd :setlocal foldmethod=diff<CR>
nnoremap <unique> ]ofi :setlocal foldmethod=indent<CR>
nnoremap <unique> ]ofm :setlocal foldmethod=manual<CR>
nnoremap <unique> ]ofM :setlocal foldmethod=marker<CR>
nnoremap <unique> ]ofs :setlocal foldmethod=syntax<CR>

nnoremap <unique> <SPACE>K :Man<CR>
" Reveal syntax group under cursor.
nnoremap <unique> <F2> :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

function! OpenMan()
    try
        call man#open_page(v:count, v:count1, 'tabs', 'dirent')
    catch
        call man#open_page(v:count, v:count1, 'tabs', 'dirent.h')
    catch
    endtry
endfunction

let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_2html_plugin = 1
let g:loaded_skim = 1
let g:loaded_tutor_mode_plugin = v:true
packadd termdebug
" packadd cfilter
packadd justify


"##### TUI
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"##### Windows
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
let g:winresizer_start_key = ''
Plug 'wellle/visual-split.vim', { 'on': ['VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow', '<Plug>(Visual-Split-VSResize)', '<Plug>(Visual-Split-VSSplit)', '<Plug>(Visual-Split-VSSplitAbove)', '<Plug>(Visual-Split-VSSplitBelow)'] }
Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' }
nnoremap <unique> <silent> <Leader>wr :WinResizerStartResize<CR>
xmap <unique> <Leader>ws <Plug>(Visual-Split-VSSplit)
nmap <unique> <Leader>wl <Plug>(choosewin)
nnoremap <unique> <silent> <Leader>wz :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <C-w>z :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <C-w><C-z> :call CloseAuxiliaryWindows()<CR>
nnoremap <unique> <silent> <Leader>wL :Windows<CR>
nnoremap <unique> <silent> <Leader>wQ :quitall<CR>
Plug 'troydm/zoomwintab.vim'
let g:zoomwintab_remap=0
nnoremap <unique> <silent> <C-w>u :ZoomWinTabToggle<CR>
nnoremap <unique> <silent> <C-w><C-u> :ZoomWinTabToggle<CR>
nnoremap <unique> <silent> <Leader>wu :ZoomWinTabToggle<CR>

"##### Refactoring; edition
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'PeterRincker/vim-argumentative'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'fenuks/vim-bracket-objects'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
noremap <unique> <silent> <c-_> :Commentary<CR>
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature', {'on': 'SignatureToggleSigns'}
Plug 'vim-scripts/ReplaceWithRegister'
nmap <unique> sp <Plug>ReplaceWithRegisterOperator
nmap <unique> spp <Plug>ReplaceWithRegisterLine
xmap <unique> sp <Plug>ReplaceWithRegisterVisual

"#### Version Control
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <unique> <Leader>vL :UndotreeToggle<CR>
Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' } " shows which lines were added and such
let g:signify_vcs_list=['git', 'hg']
Plug 'airblade/vim-gitgutter'
nmap <unique> ]c <Plug>(GitGutterNextHunk)
nmap <unique> [c <Plug>(GitGutterPrevHunk)
let g:gitgutter_map_keys = 0
nnoremap <unique> <Leader>vll :GitGutterToggle<CR>
nnoremap <unique> <Leader>vlL :SignifyToggle<CR>
nmap <unique> <Leader>vla <Plug>(GitGutterStageHunk)
nmap <unique> <Leader>vlu <Plug>(GitGutterUndoHunk)
nmap <unique> <Leader>vld <Plug>(GitGutterPreviewHunk)
"GIT
Plug 'tpope/vim-fugitive'
nnoremap <unique> <Leader>va :Gwrite<CR>
nnoremap <unique> <Leader>vb :Gblame<CR>
nnoremap <unique> <Leader>vc :Gcommit<CR>
nnoremap <unique> <Leader>vd :Gvdiff<CR>
nnoremap <unique> <Leader>vh :0Glog<CR>
nnoremap <unique> <Leader>vm :Gmove<CR>
nnoremap <unique> <Leader>U  :GundoToggle<CR>
nnoremap <unique> <Leader>vp :Git! diff --staged<CR>
nnoremap <unique> <Leader>vP :Git! diff<CR>
nnoremap <unique> <Leader>vr :Gread<CR>
nnoremap <unique> <Leader>vR :Gremove<CR>
nnoremap <unique> <Leader>vs :Gstatus<CR>
Plug 'rbong/vim-flog', {'on': 'Flog'}
nnoremap <unique> <Leader>vg :Flog<CR>
Plug 'junegunn/gv.vim', {'on': 'GV'}
nnoremap <unique> <Leader>vG :GV<CR>
Plug 'jreybert/vimagit', { 'on': 'Magit' }
nnoremap <unique> <Leader>vM :Magit<CR>
Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }
"HG
" Plug 'ludovicchabant/vim-lawrencium' " disabled, it takes 5ms to load
" Plug 'jlfwong/vim-mercenary'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
nnoremap <unique> <silent> <Leader>dg :diffget<CR>
nnoremap <unique> <silent> <Leader>dp :diffput<CR>

nnoremap <unique> <silent> <Leader>df :call DiffOrig()<CR>

"#### Filesystem
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

command! -nargs=* Agp
  \ call fzf#vim#ag(<q-args>, '2> /dev/null',
  \                 fzf#vim#with_preview({'left':'90%'},'up:60%'))
Plug 'wsdjeg/vim-fetch'
nnoremap <unique> <silent> <C-p> :Files<CR>
nnoremap <unique> <silent> <Leader>fl :Files<CR>
nnoremap <unique> <silent> <Leader>fd :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <unique> <silent> <Leader>gt :Tags<CR>
nnoremap <unique> <silent> <Leader>gh :History<CR>
nnoremap <unique> <silent> <Leader>gT :BTags<CR>
snoremap <unique> <silent> <C-k> <ESC>ddi

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <unique> <silent> <Leader>ft :NERDTreeToggle<CR>
nnoremap <unique> <silent> <Leader>fT :NERDTreeFind<CR>
nnoremap <unique> <silent> <Leader>fs :call ReadSkeletonFile()<CR>
let g:NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__']
let g:NERDTreeMinimalUI=1

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<Plug>(GrepperOperator)'] }
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.prompt_quote = 3
let g:grepper.rg = {}
let g:grepper.rg.grepprg = 'rg -H --no-heading --vimgrep --smart-case'

nnoremap <unique> <Leader>ss :Grepper -tool rg<CR>
nnoremap <unique> <Leader>sS :Grepper -tool rg -side<CR>
nnoremap <unique> <leader>s* :Grepper -tool rg -open -switch -cword -noprompt<CR>
nnoremap <unique> <Leader>s% :Grepper -open -switch -cword -noprompt -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
nnoremap <unique> <Leader>sf :Grepper -tool rg -grepprg rg -H --no-heading --vimgrep -l<CR>
vmap <unique> <Leader>s <Plug>(GrepperOperator)
nmap <unique> <Leader>so <Plug>(GrepperOperator)
nnoremap <unique> <leader>sd :Grepper -tool rg -dir file<CR>
nnoremap <unique> <leader>sD :Grepper -tool rg -dir file -side<CR>
nnoremap <unique> <leader>sb :Grepper -tool rg -buffers<CR>
nnoremap <unique> <leader>sB :Grepper -tool rg -buffers -side<CR>
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
Plug 'nelstrom/vim-visual-star-search'
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['.mypy_cache']
let g:gutentags_ctags_executable_haskell = 'hasktags'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
let g:airline#extensions#tabline#enabled = 1
" Plug 'devjoe/vim-codequery' " rich support for searching symbols support
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_verbose = 0
Plug 'fenuks/vim-uncommented'
nmap <unique> ]/ <Plug>(NextCommented)
nmap <unique> [/ <Plug>(PrevCommented)
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

imap <unique> <C-q> <C-\><C-o>d_
cmap <unique> <C-q> <C-f>d_<C-c><C-c>:<UP>
Plug 'arthurxavierx/vim-caser'


Plug 'lambdalisue/lista.nvim', { 'on': 'Lista' }

"##### Formatting
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
let g:neoformat_enabled_python = ['black', 'isort']
let g:neoformat_enabled_json = ['prettier', 'js-beautify', 'jq']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_haskell = ['stylish-haskell', 'floskell', 'ormolu']
nnoremap <unique> <silent> <Leader>q :Neoformat<CR>

Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
xmap <unique> <Leader>ga <Plug>(EasyAlign)
nmap <unique> <Leader>ga <Plug>(EasyAlign)
"Plug 'godlygeek/tabular'
"Plug 'tommcdo/vim-lion'
"let g:lion_squeeze_spaces = 1

"##### Syntax analysis
Plug 'dense-analysis/ale'
let g:ale_linters = {
\   'haskell': ['cabal_ghc', 'stack-build', 'stack-ghc', 'hlint'],
\   'python': ['mypy', 'pylint', 'flake8'],
\   'java': ['javalsp', 'pmd', 'eclipselsp'],
\   'rust': ['cargo'],
\}
let g:ale_sign_error = '🗴'
let g:ale_sign_warning = '>>'
let g:ale_virtualtext_cursor = 1
let g:ale_sign_highlight_linenrs = 1

 " languagetool doesn't understand md syntax…
let g:ale_linters_ignore = {
\ 'vimwiki': ['languagetool'],
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
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:airline#extensions#ale#enabled = 1
nnoremap <unique> <Leader>cf :ALEFix<CR>
nmap <unique> <silent> <Leader>cp <Plug>(ale_previous_wrap)
nmap <unique> <silent> <Leader>cn <Plug>(ale_next_wrap)
nnoremap <unique> <silent> <Leader>co :lwindow<CR>
nnoremap <unique> <silent> <Leader>cO :lclose<CR>
" let g:ale_open_list = 1 " conflicts with ultisnips jumping

"##### Tasks
Plug 'neomake/neomake', { 'on': ['Neomake', 'NeomakeProject'] }
let g:neomake_open_list = 2
let g:airline#extensions#neomake#enabled = 0
nnoremap <unique> <Leader>mb :make compile<CR>
nnoremap <unique> <Leader>mi :make install<CR>
nnoremap <unique> <Leader>mc :make clean<CR>

Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit'] }
let g:test#strategy = 'neovim'
let g:test#runner_commands = ['PyTest']
nnoremap <unique> <silent> <leader>xn :TestNearest<CR>
nnoremap <unique> <silent> <leader>xf :TestFile<CR>
nnoremap <unique> <silent> <leader>xa :TestSuite<CR>
nnoremap <unique> <silent> <leader>xl :TestLast<CR>
nnoremap <unique> <silent> <leader>xg :TestVisit<CR>

"##### Autocomplete
" Plug 'Raimondi/delimitMate'
" Plug 'Townk/vim-autoclose'
" Plug 'jiangmiao/auto-pairs'
" Plug 'cohama/lexima.vim'
Plug 'fenuks/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
\                    '„':'”', '‘':'’', '“':'”'}
let g:AutoClosePairs_add = '<> | „” ‘’'
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsOnlyWhitespace=v:true
let g:AutoPairsSkipAfter='\a'
let g:AutoPairsSkipBefore=''
let g:AutoPairsMoveCharacter = ''

" Plug 'tmsvg/pear-tree'
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '‘': {'closer': '’'},
            \ '„': {'closer': '”'},
            \ }

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_map_special_keys = 0
" imap <unique> <BS> <Plug>(PearTreeBackspace)
" imap <unique> <C-h> <Plug>(PearTreeBackspace)
" imap <unique> <Space> <Plug>(PearTreeSpace)

" ##### Code autocompletion
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'make release', 'on': ['LanguageClientStart'] }
let g:LanguageClient_diagnosticsList='Location'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'on': ['CocInstall', 'CocConfig', 'CocEnable'] }

Plug 'natebosch/vim-lsc', { 'on': 'LSClientEnable' }

Plug 'Valloric/YouCompleteMe', { 'for': ['javascript', 'python'] }
" Plug 'lifepillar/vim-mucomplete'
" Plug 'maralla/completor.vim'
" Plug 'Shougo/neocomplete.vim'
" let g:neocomplete#enable_at_startup = 1
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " Plug 'zchee/deoplete-go', { 'for': 'go' }
    Plug 'ncm2/float-preview.nvim'
    let g:float_preview#docked = 0
    if has('nvim-0.5')
        Plug 'neovim/nvim-lspconfig'
        Plug 'nvim-lua/completion-nvim'
        let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
        let g:completion_matching_smart_case = 1
        Plug 'tjdevries/lsp_extensions.nvim'
        Plug 'nvim-lua/lsp-status.nvim'
        Plug 'nvim-treesitter/nvim-treesitter'
    endif
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-dictionary'
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }

Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

execute 'source ' . g:vim_custom_scripts . 'autocomplete.vim'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
" let g:UltiSnipsListSnippets='<C-\>'
Plug 'honza/vim-snippets'

"#### Language specific
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['sensible', 'autoindent']
if has('nvim')
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    let g:polyglot_disabled += ['python']
endif
" ##### VIML
Plug 'junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }
augroup vim
    autocmd!
    autocmd FileType vim nnoremap <unique> <buffer> <silent> K :help <C-r><C-w><CR>
    autocmd FileType muttrc nnoremap <unique> <buffer> <silent> K :call SearchMan('neomuttrc', '')<CR>
    autocmd FileType sshconfig nnoremap <unique> <buffer> <silent> K :call SearchMan('ssh_config', '')<CR>
    autocmd FileType qf,fugitive setlocal nobuflisted " exclude quickfix withow from :bnext, etc.
    autocmd CursorHold * checktime " needed for autoread to be triggered
    " reopening a file, restore last cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
    autocmd BufRead *.orig set readonly
augroup END

augroup filetype_detect
    autocmd!
    autocmd BufRead,BufNewFile *.recipe setfiletype python
    autocmd BufRead,BufNewFile *.conf setfiletype conf
    autocmd BufRead,BufNewFile env setfiletype sh
    autocmd BufRead,BufNewFile PKGBUILD call ConfigurePkgbuild()
augroup END

"##### HTML5
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'xml'] }

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
Plug 'rust-lang/rust.vim', { 'for': 'rust' } " optionally, vim-polyglot has it as well

"##### Golang
"Plug 'fatih/vim-go'

"##### JVM
"##### Java
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'mikelue/vim-maven-plugin', { 'on': ['Mvn', 'MvnNewMainFile'] }
let g:java_highlight_functions=1

"####### Functional
"""##### Haskell
" Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" Plug 'vlime/vlime' { 'for': 'lisp' }
Plug 'kovisoft/slimv', { 'for': 'lisp' }
let g:lisp_rainbow=1
let g:scheme_builtin_swank=1

" ##### C family
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp'] }
" Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
let g:rtagsUseDefaultMappings = 1
let g:rtagsAutoLaunchRdm=1
" Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }

"##### Natural language
Plug 'tpope/vim-characterize'
" Plug 'vim-scripts/LanguageTool'
Plug 'dpelle/vim-LanguageTool', { 'for': ['rst'] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }


"##### Markdown
" Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_strikethrough = 1
Plug 'vimwiki/vimwiki'
" let g:vimwiki_key_mappings = { 'all_maps': 0, }
let g:vimwiki_list = [{'path': $XDG_DOCUMENTS_DIR . '/tekst',
                     \ 'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_folding='expr'
nmap <unique> sv <Plug>VimwikiIndex

" Database
let g:sql_type_default='psql'

"##### TeX
Plug 'lervag/vimtex', { 'for': 'tex' }
" Plug 'scrooloose/vim-slumlord'

"##### Colorshemes
" dark
" set background=dark
" Plug 'gruvbox-community/gruvbox'
" Plug 'overcache/NeoSolarized'
" Plug 'lifepillar/vim-solarized8'
" Plug 'romainl/flattened'
" Plug 'arzg/vim-corvine'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'sainnhe/gruvbox-material'
" Plug 'kjssad/quantum.vim'
" Plug 'ayu-theme/ayu-vim'
" Plug 'aonemd/kuroi.vim'
" Plug 'sonph/onehalf'
" Plug 'nlknguyen/papercolor-theme'
Plug 'flazz/vim-colorschemes'
Plug 'sainnhe/edge'
let g:edge_enable_italic = 1

set background=light
if &background ==# 'light'
    let g:ayucolor='light'
    Plug 'vim-airline/vim-airline-themes'
endif

call plug#end()

if has('gui_running')
    let g:solarized_diffmode='high'
    colorscheme gruvbox
    set lines=50 columns=140
    set guifont=Fira\ Code
elseif &diff
    colorscheme gruvbox
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
" truecolor: onedark, OceanicNext

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'smart_case': v:true,
    \ 'ignore_case': v:false,
    \ 'ignore_sources': {'c': ['tag'], 'cpp': ['tag'], 'xml': ['tag']}
\ })
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'sorters', [])

""" functions
execute 'source ' . g:vim_custom_scripts . 'functions.vim'
command! Cnext call WrapListCommand('cnext', 'cfirst')
command! Cprevious call WrapListCommand('cprev', 'clast')
command! Lnext call WrapListCommand('lnext', 'lfirst')
command! Lprevious call WrapListCommand('lprev', 'llast')

function! ConfigurePkgbuild() abort
    setlocal makeprg=makepkg
    nnoremap <unique> <buffer> <Leader>mi :make -i<CR>
    nnoremap <unique> <buffer> <Leader>mb :make<CR>
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

if has('neovim-0.5')
    lua require 'init'
endif
