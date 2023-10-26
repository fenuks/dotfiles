if has('unix')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin(g:vim_dir_path . '/vimfiles/plugged')
end

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
nnoremap <unique> <silent> <Leader>fr :call ReadSkeletonFile()<CR>
let g:NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__', 'jdt.ls-java-project']
let g:NERDTreeMinimalUI=1
let g:NERDTreeBookmarksFile=g:vim_share_dir . '/NERDTreeBookmarks'
let g:NERDTreeNaturalSort=1

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
let g:gutentags_ctags_exclude = ['.mypy_cache', 'node_modules', 'target', '*.json']
" let g:gutentags_ctags_executable_haskell = 'hasktags'
Plug 'https://github.com/majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <unique> <silent> <F8> :TagbarToggle<CR>
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
let g:ale_python_mypy_options='--ignore-missing-imports --check-untyped-defs'
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
    Plug 'https://github.com/smoka7/hop.nvim'

    Plug 'https://github.com/windwp/nvim-ts-autotag'

    Plug 'https://github.com/hkupty/iron.nvim'
    Plug 'https://github.com/kristijanhusak/orgmode.nvim'
    " FIXME use only telescope for nvim
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'

    Plug 'https://github.com/glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    if exists('g:started_by_firenvim')
      let g:loaded_airline = 1
      set laststatus=0
      " firenvim doesn't support | blinking cursor (it stays invisible)
      set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
      let g:firenvim_config = { 
          \ 'globalSettings': {
              \ 'alt': 'all',
          \  },
          \ 'localSettings': {
              \ '.*': {
                  \ 'cmdline': 'neovim',
                  \ 'content': 'text',
                  \ 'priority': 0,
                  \ 'selector': 'textarea',
                  \ 'takeover': 'always',
              \ },
          \ }
      \ }
      let fc = g:firenvim_config['localSettings']
      let fc['https?://mattermost'] = { 'takeover': 'never', 'priority': 1 }
      let fc['https?://jira'] = { 'takeover': 'never', 'priority': 1 }
      imap <C-S-v> <C-R>+
      cmap <C-S-v> <C-R>+
      augroup firenvim
        autocmd!
        autocmd BufEnter *gitlab*.txt set filetype=markdown
      augroup END
    end
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

let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
nnoremap <silent> <unique> <Leader>ru <Cmd>call UltiSnips#RefreshSnippets()<CR>
let g:UltiSnipsListSnippets = '<c-x><c-s>'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

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
Plug 'https://github.com/rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
let g:grammarous#languagetool_cmd = 'languagetool'


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
" let g:vimtex_view_method='okular'
let g:vimtex_view_method = 'zathura'
let g:tex_conceal='abdmg'
let g:vimtex_imaps_enabled = 0

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
Plug 'https://github.com/shaunsingh/solarized.nvim'

set background=light
if &background ==# 'light'
    let g:ayucolor='light'
    Plug 'https://github.com/vim-airline/vim-airline-themes'
endif

call plug#end()

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
