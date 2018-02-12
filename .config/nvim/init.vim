" editor behavior
set t_Co=256
set history=1000 " Number of things to remember in history."
" set textwidth=80 " max line width
set formatprg=par " gq formatting program
set formatoptions+=j " more intelligent j joining
" formatting formatprg, formatexpr, formatoptions
set whichwrap=h,l " specify keys that can wrap next line
set ignorecase " Do case insensitive matching with
set infercase " Do *not* ignore case in autocompletion
set smartcase " Do case sensitive if text contains upper letters
set autoread " Automatically reload file changed outside vim if not changed in vim
set completeopt=longest,menuone,preview " complete longest common text instead of first word
" set incsearch " Search while typing
set hlsearch " highlight search
" set timeoutlen=150 " Time to wait after ESC (default causes an annoying delay), it affects also leader key, unfortunately
set backspace=indent,eol,start " more powerful backspacing"
set autoindent " align the new line indent with the previous one
" set tabstop=4 " Set the default tabstop
set softtabstop=4 " Insert/delete 4 spaces when hitting TAB/Backspace
set shiftwidth=4 " Set the default shift width for indents
set expandtab " Make tabs into spaces (set by tabstop)
set smarttab " Smarter tab levels
set scrolloff=3 " number of context lines visible near cursor
set wildmenu " enhanced command-line mode
set wildignore=*.swp,*.bak,*.pyc,*.class
set lazyredraw " redraw only at the end of the macro
set hidden " allow background buffers without saving
set linebreak " breaklines *nicely*
set spelllang=en_gb,pl
" set breakat-=_ " don't break at _
" diff mode
set diffopt+=iwhite " ignore whitespace character changes
set exrc " read vimrc in current directory
set secure " disallow dangerous commands in external vimrc files
set includeexpr=substitute(v:fname,'\\.','/','g') " expression to change gf filename mapping
set visualbell " don't beep
set noerrorbells " don't beep

if !isdirectory('/tmp/vim-undo-dir')
    call mkdir('/tmp/vim-undo-dir', '', 0700)
endif
set undodir=/tmp/vim-undo-dir
set undofile
set undolevels=1000

" editor appearance
syntax on " syntax highlight on
filetype indent plugin on " enable filetype detection
set number " Show line numbers
set relativenumber " show relative numbers
set noruler " show line and column numbers
set showcmd " Display an incomplete command in the lower right corner of the Vim window"
set noshowmode " show current mode
set showmatch  " Show matching brackets
" set matchpairs+=<:> " make % match between < and >
set cursorline " highlight current line
set colorcolumn=80 " show vertical line at column
set laststatus=2 " always show status line
set title " update terminal title
set ruler " show line position on bottom ruler
set cmdwinheight=20 " set commandline window height
set listchars=tab:▸\ ,eol:¬,trail:·

if has('nvim')
    set termguicolors " use trucolor
    set scrollback=-1 " NeoVim terminal unlimited scrolling
    tnoremap jk <C-\><C-n>
else
    set viminfofile=$HOME/.config/nvim/viminfo
endif

" language
set dictionary+=/usr/share/dict/british,/usr/share/dict/polish
set thesaurus+=/usr/share/thesaurus/moby-thesaurus.txt
digraph !! 8252 " ‼
digraph ?! 8264 " ⁈
digraph !? 8265 " ⁉

nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>eb :e $HOME/.bashrc<CR>
" set very magic regex (perl compatitible)
nnoremap / /\v
vnoremap / /\v
" better history scrolling, with context
cnoremap <C-n> <down>
cnoremap <C-p> <up>
cnoremap g/ g/\v

" shortcuts
let mapleader = ","
inoremap jk <ESC>
nnoremap <C-s> :w<Enter>
inoremap <C-s> <ESC>:w<Enter>a
" shitf + enter add new line
inoremap OM <ESC>o
" inoremap  <ESC>o
" inoremap <S-CR> <ESC>o

" trigger autocomplete <c+space>
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-x><C-o>

" moving lines up and down
nnoremap <silent> <A-p> :<c-u>execute 'move -1-'. v:count1<CR>
nnoremap <silent> <A-n> :<c-u>execute 'move +'. v:count1<CR>
inoremap <silent> <A-n> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-p> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-n> :m '>+1<CR>gv=gv
vnoremap <silent> <A-p> :m '<-2<CR>gv=gv
" insert spaces
nnoremap <silent> [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap <silent> ]<space> :<c-u>put =repeat(nr2char(10), v:count1)<CR>

" edit register
nnoremap <silent> <Leader>@ :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left><Paste>

inoremap <A-h> <LEFT>
inoremap <A-l> <RIGHT>
inoremap <A-k> <UP>
inoremap <A-j> <DOWN>

vnoremap <A-j> gj
vnoremap <A-k> gk
nnoremap <A-j> gj
nnoremap <A-k> gk

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
nnoremap ]l :<C-U>lnext<CR>
nnoremap [L :<C-U>lfirst<CR>
nnoremap ]L :<C-U>llast<CR>
nnoremap [q :<C-U>cprevious<CR>
nnoremap ]q :<C-U>cnext<CR>
nnoremap [Q :<C-U>cfirst<CR>
nnoremap ]Q :<C-U>clast<CR>
nnoremap [t gT
nnoremap ]t gt
nnoremap [T :<C-U>tfirst<CR>
nnoremap ]T :<C-U>tlast<CR>

function! Conflict(reverse)
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

nnoremap <silent> ]n :call Conflict(0)<CR>
nnoremap <silent> [n :call Conflict(1)<CR>

nnoremap [ob :set background=light<CR>
nnoremap [oc :set nocursorline<CR>
nnoremap [od :diffoff<CR>
nnoremap [oh :set nohlsearch<CR>
nnoremap [oi :set noignorecase<CR>
nnoremap [ol :set nolist<CR>
nnoremap [on :set nonumber<CR>
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
nnoremap =or :set relativenumber!<CR>
nnoremap =os :set spell!<CR>
nnoremap =ou :set cursorcolumn!<CR>
" nnoremap =ov :set virtualedit=""<CR>
nnoremap =ow :set wrap!<CR>
nnoremap =ox :set cursorline! cursorcolumn!<CR>

nnoremap [<CR> O<ESC>
nnoremap ]<CR> o<ESC>

nnoremap Y y$

vmap <Leader>y "+y

vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <Leader>y "+y
nmap <Leader>Y "+y$
nmap <Leader>d "+d
nmap <Leader>D "+D
nmap <Leader>p "+p
nmap <Leader>P "+P

vnoremap . :normal .<CR>

cmap w!! %!sudo tee > /dev/null %

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

"##### TUI
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"##### Windows
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
let g:winresizer_start_key = ''
nnoremap <C-w>m :WinResizerStartResize<CR>
Plug 'wellle/visual-split.vim', { 'on': ['VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow', '<Plug>(Visual-Split-VSResize)', '<Plug>(Visual-Split-VSSplit)', '<Plug>(Visual-Split-VSSplitAbove)', '<Plug>(Visual-Split-VSSplitBelow)'] }
xmap <C-W>s <Plug>(Visual-Split-VSSplit)

"##### Autocomplete
"Plug 'Townk/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
\                    '„':'”', '‘':'’', '“':'”'}
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
" Plug 'ervandew/supertab'
" let g:SuperTabDefaultCompletionType = '<c-n>'

"##### Code autocompletion
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins', 'for': ['haskell', 'javascript', 'rust', 'typescript', 'vue'] }
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'java': ['jdtls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'vue': ['vls'],
    \ }
" \ 'cpp': ['cquery', '--language-server', '--log-file=/tmp/cq.log'],

" let g:LanguageClient_autoStart = 1

nnoremap <silent> <Leader>lk :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Leader>lt :call LanguageClient_workspace_symbol()<CR>
nnoremap <silent> <Leader>lT :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <Leader>lu :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <Leader>lq :call LanguageClient_textDocument_formatting()<CR>
" setlocal omnifunc=LanguageClient#complete

" Plug 'Valloric/YouCompleteMe'
" Plug 'lifepillar/vim-mucomplete'
" Plug 'maralla/completor.vim'
if has('nvim')
    " DEOPLETE
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " let g:deoplete#enable_at_startup = 1
    let g:deoplete#omni#input_patterns = {} " faster, called by deoplete
    " let g:deoplete#omni#input_patterns._ = '.+'
    let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
    let g:deoplete#omni#input_patterns.javascript = ''
    " let g:deoplete#omni#input_patterns.cpp = ['[^. *\t]\.\w*', '[^. *\t]\::\w*', '[^. *\t]\->\w*', '[<"].*/']
    " let g:deoplete#omni#input_patterns.python = '.+'
    let g:deoplete#omni_patterns = {}  " slower, called by vim, https://github.com/Shougo/deoplete.nvim/issues/190
    " let g:deoplete#omni_patterns._ = '.+'
    " let g:deoplete#omni#functions = {}
    " let g:deoplete#omni#functions.javascript = tern#Complete
    " let g:deoplete#omni#functions.python = 'jedi#completions'
    " let g:deoplete#omni#functions.python = 'RopeCompleteFunc'
    " DEOPLETE PLUGINS
    " Plug 'tweekmonster/deoplete-clang2', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
    " Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
    " Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
    let g:deoplete#sources#ternjs#types = 1
    let g:deoplete#sources#ternjs#docs = 1
    " Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    let g:deoplete#sources#jedi#show_docstring=1
    " alternatively use jedi-vim
    " Plug 'zchee/deoplete-go', { 'for': 'go' }

    " NVIM COMPLETION MANAGER
    Plug 'roxma/nvim-completion-manager'
else
    Plug 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
endif


Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='gn'
let g:UltiSnipsJumpBackwardTrigger='gp'
Plug 'honza/vim-snippets'

"##### Refactoring; edition
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'PeterRincker/vim-argumentative'
Plug 'tpope/vim-surround'
Plug 'fenuks/vim-bracket-objects'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature', {'on': 'SignatureToggleSigns'}
"##### Navigation
" GNU global
" set cscopeprg=gtags-cscope
" source /usr/share/vim/vimfiles/plugin/gtags.vim
" source /usr/share/vim/vimfiles/plugin/gtags-cscope.vim
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
Plug 'nelstrom/vim-visual-star-search'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
let g:airline#extensions#tabline#enabled = 1
map <Leader>gt :TagbarToggle<CR>
" Plug 'devjoe/vim-codequery' " rich support for searching symbols support
" gtags
Plug 'easymotion/vim-easymotion'
Plug 'fenuks/vim-uncommented'
nmap <C-j> <Plug>(NextUncommented)
nmap <C-k> <Plug>(PrevUncommented)
" nmap <C-S-j> <Plug>(NextCommented)
" nmap <C-S-k> <Plug>(PrevCommented)

"##### Formatting
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
nnoremap <Leader>q :Neoformat<CR>

Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
xmap <Leader>ga <Plug>(EasyAlign)
nmap <Leader>ga <Plug>(EasyAlign)
"Plug 'godlygeek/tabular'
"Plug 'tommcdo/vim-lion'
"let g:lion_squeeze_spaces = 1

"##### Syntax analysis
"Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
" let g:ale_open_list = 1 " conflicts with ultisnips jumping

"##### Tasks
Plug 'neomake/neomake', { 'on': ['Neomake', 'NeomakeProject'] }
let g:neomake_open_list = 2
let g:airline#extensions#neomake#enabled = 0
Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit'] }
let test#strategy = 'neomake'
nmap <silent> <leader>xn :TestNearest<CR>
nmap <silent> <leader>xf :TestFile<CR>
nmap <silent> <leader>xa :TestSuite<CR>
nmap <silent> <leader>xl :TestLast<CR>
nmap <silent> <leader>xg :TestVisit<CR>

"##### Colorshemes
" Plug 'Olical/vim-syntax-expand' " adds abbreviations that make editor pretty
Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'fmoralesc/molokayo'

"#### Version Control
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <Leader>u :UndotreeToggle<CR>
Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' } " shows which lines were added and such
let g:signify_vcs_list=['git', 'hg']
nmap <Leader>vl :SignifyToggle<CR>
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
Plug 'gregsexton/gitv', {'on': 'Gitv'}
nnoremap <Leader>vg :Gitv<CR>
Plug 'junegunn/gv.vim', {'on': 'GV'}
nnoremap <Leader>vG :GV<CR>
Plug 'jreybert/vimagit'
"HG
Plug 'ludovicchabant/vim-lawrencium'
" Plug 'jlfwong/vim-mercenary'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }

"#### Filesystem
" Plugin 'kien/ctrlp.vim'
command! -nargs=* Agp
  \ call fzf#vim#ag(<q-args>, '2> /dev/null',
  \                 fzf#vim#with_preview({'left':'90%'},'up:60%'))

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
noremap <Leader>f :Files<CR>
noremap <Leader>t :Tags<CR>
noremap <Leader>T :BTags<CR>
noremap <Leader>b :Buffers<CR>

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
map <Leader>F :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<Plug>(GrepperOperator)'] }
" let g:grepper.highlight = 1
nnoremap <Leader>s :Grepper -tool ag<CR>

""" Language specific
" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['python']
"##### HTML5
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }

"##### ORG
Plug 'jceb/vim-orgmode', { 'for': 'org' }

"##### Markdown
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }

"##### CSS
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
" Plug 'lilydjwg/colorizer', {'for': ['css']}

"##### JS
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
augroup filetype_js
    autocmd!
    autocmd FileType javascript nnoremap <buffer> gd :TernDef<CR>
    autocmd FileType javascript nnoremap <buffer> <Leader>u :TernRefs<CR>
    autocmd FileType javascript nnoremap <buffer> <Leader>r :TernRename<CR>
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
augroup END

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
let g:jedi#completions_command = "<C-space>"
let g:jedi#goto_command = "gd"
let g:jedi#goto_definitions_command = "gD"
let g:jedi#rename_command = "<Leader>r"
let g:jedi#show_call_signatures = "2"
let g:jedi#usages_command = "<Leader>u"

let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ""


Plug 'python-rope/ropevim', { 'for': 'python' }
let ropevim_enable_shortcuts = 0

"##### Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

"##### Go
"Plug 'fatih/vim-go'

"##### JVM
"##### Java
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug '/usr/share/vim/vimfiles/plugin/eclim.vim', { 'dir': '/usr/share/vim/vimfiles/', 'for': 'java' }
augroup filetype_java
    autocmd!
    " autocmd FileType java setlocal omnifunc=javacomplete#Complete
augroup END
nmap <Leader>ii <Plug>(JavaComplete-Imports-AddSmart)
nmap <Leader>iI <Plug>(JavaComplete-Imports-Add)
nmap <Leader>ia <Plug>(JavaComplete-Imports-AddMissing)
nmap <Leader>id <Plug>(JavaComplete-Imports-RemoveUnused)

nmap <Leader>am <Plug>(JavaComplete-Generate-AbstractMethods)
nmap <Leader>aA <Plug>(JavaComplete-Generate-Accessors)
nmap <Leader>as <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <Leader>ag <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <Leader>aa <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <Leader>ats <Plug>(JavaComplete-Generate-ToString)
nmap <Leader>aeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <Leader>aI <Plug>(JavaComplete-Generate-Constructor)
nmap <Leader>ai <Plug>(JavaComplete-Generate-DefaultConstructor)

nmap <silent> <buffer> <Leader>ac <Plug>(JavaComplete-Generate-NewClass)
nmap <silent> <buffer> <Leader>aC <Plug>(JavaComplete-Generate-ClassInFile)

"##### Scala
"Plug 'ensime/ensime-vim', { 'for': ['java', 'scala'] }

"##### Haskell
" Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }

"##### C family
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }
let g:rtagsUseDefaultMappings = 1
let g:rtagsAutoLaunchRdm=1
Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }


"##### Natural language
" Plug 'vim-scripts/LanguageTool'
Plug 'dpelle/vim-LanguageTool', { 'for': ['markdown', 'rst'] }
Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'rst'] }
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#use_vim_spelllang = 1
augroup natural_language
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType hgcommit setlocal spell
    autocmd FileType org setlocal spell
    autocmd FileType text setlocal commentstring=#\ %s
augroup END

call plug#end()

if has('gui_running')
    let g:solarized_diffmode="high"
    colorscheme solarized
    set lines=50 columns=140
    set guifont=Fira\ Code
elseif &diff
    colorscheme Monokai
else
    colorscheme Tomorrow-Night
endif
" transparent: CandyPaper,
" gruvbox, badwolf
" truecolor: onedark, OceanicNext
