" Josh Klar [klardotsh] vimrc
" 2019 Edition

call plug#begin('~/.local/share/nvim/plugged')

" Interface / Misc
Plug 'Konfekt/FastFold'
Plug 'w0ng/vim-hybrid'
Plug 'editorconfig/editorconfig-vim' " Force buffer to use editorconfig settings
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'

Plug 'junegunn/vim-emoji'
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'noahfrederick/vim-noctu'
Plug 'deviantfero/wpgtk.vim'
Plug 'yuttie/comfortable-motion.vim'

" Automatically create any non-existent directories before writing the buffer.
" > :e this/does/not/exist/file.txt
" > :w
Plug 'pbrisbin/vim-mkdir'

" Git Integration (ish)
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

" Linting & Fixing
Plug 'dense-analysis/ale'

" Language support (how many of these are still needed with cocs?)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'HerringtonDarkholme/yats.vim' " TypeScript
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'fisadev/vim-isort' " Python-related
Plug 'hdima/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim' " Elixir-related
Plug 'reasonml-editor/vim-reason-plus'
Plug 'neovimhaskell/haskell-vim'

" Config formats support
Plug 'GutenYe/json5.vim'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'NLKNguyen/cloudformation-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'chase/vim-ansible-yaml'
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'markcornick/vim-vagrant'
Plug 'uarun/vim-protobuf'
Plug 'hashivim/vim-terraform'

call plug#end()

let g:ctrlp_custom_ignore = {
	\'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|dist|\.stack-work)$'
	\}

let g:lightline = {
      \ 'colorscheme': 'wal',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" comfy-scroll config - pulled from vim.reaper
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
let g:comfortable_motion_friction = 50.0
let g:comfortable_motion_air_drag = 1.0

" coc overrides - pulled from vim.reaper

" Define Error Symbols and colors
let g:coc_status_warning_sign = ''
let g:coc_status_error_sign = ''
hi CocWarningSign ctermfg=blue
hi CocErrorSign ctermfg=red
hi CocInfoSign ctermfg=yellow
hi CocHintSign ctermfg=green

" Transparent popup window
hi! Pmenu ctermbg=black
hi! PmenuSel ctermfg=2
hi! PmenuSel ctermbg=0

" fzf config -from vim.reaper
"let g:fzf_colors =
"\ { 'fg':      ['bg', 'Normal'],
"\ 'bg':      ['bg', 'Normal'],
"\ 'hl':      ['fg', 'Comment'],
"\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"\ 'bg+':     ['fg', 'CursorLine', 'CursorColumn'],
"\ 'hl+':     ['fg', 'Statement'],
"\ 'info':    ['fg', 'PreProc'],
"\ 'border':  ['fg', 'Ignore'],
"\ 'prompt':  ['fg', 'Conditional'],
"\ 'pointer': ['fg', 'Exception'],
"\ 'marker':  ['fg', 'Keyword'],
"\ 'spinner': ['fg', 'Label'],
"\ 'header':  ['fg', 'Comment'] }

" Hide status bar while using fzf commands
if has('nvim') || has('gui_running')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2
endif

" Centered floating window for fzf
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

if !exists("g:syntax_on")
	syntax enable
endif

augroup rainbow_lisp
  autocmd!
  autocmd FileType hy,lisp,clojure,scheme RainbowParentheses
augroup END

au BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
au BufRead,BufNewFile *.eslintrc set filetype=json
au BufRead,BufNewFile *.js set suffixesadd+=.js
au BufRead,BufNewFile *.js,*.jsx,*.tag let npm_bin = system('npm bin')
au BufRead,BufNewFile *.js,*.jsx,*.tag let $PATH .= ';' . npm_bin
au BufRead,BufNewFile *.jsx set suffixesadd+=.jsx filetype=javascript.jsx
au BufRead,BufNewFile *.tag set filetype=html
au BufRead,BufNewFile *.tmux.conf set filetype=config
au FileType markdown set textwidth=80
au FileType py set textwidth=80

" for [jsonc](https://code.visualstudio.com/docs/languages/json) support
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType javascript nnoremap <silent> <buffer> <Leader>d :TernDef<CR>
autocmd FileType rust nnoremap <Leader>d :YcmCompleter GoTo<CR>
autocmd! BufWritePre *.c,*.cpp,*.h,*.hpp,*.py,*.hy,*.js,*.jsx,*.ts,*.css,*.scss,*.sass,*.fs,*.fsi,*.fsx,*.rs,*.md,*.toml,*.ini,*.json,*.html,*.service,*.timer,*.yaml DeleteTrailingWhitespace

filetype off
filetype plugin indent on

imap <silent> <Home> <C-O><Home>

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_fix_on_save = 1
let g:ale_go_bingo_executable = 'gopls'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_python_auto_pipenv = 1
let g:ale_python_black_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '!'
let g:ale_fixers = {
\   'go': ['gofmt'],
\   'python': ['black', 'isort'],
\   'javascript': ['prettier', 'eslint'],
\   'jsx': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'haskell': ['hindent', 'stylish-haskell'],
\   'ocaml': ['ocamlformat'],
\}

" have to kill ghc and a few other defaults that throw errors on non-stdlib
" imports
let g:ale_linters ={
\   'haskell': ['hlint', 'hdevtools', 'hfmt'],
\}

let g:cabal_indent_section = 4
let g:gitgutter_override_sign_column_highlight = 0
let g:go_def_mapping_enabled = 0 " disable vim-go :GoDef short cut (gd) - this is handled by LanguageClient [LC]
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:rustfmt_autosave = 1
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:yaml_formatter_indent_collection=1
let loaded_matchparen=1
let mapleader=","

map <C-t> :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>j :%!jq -S<CR>

nmap Q gqap
vmap Q gq

nnoremap ; :
nnoremap <C-e> :bufdo edit<Space>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>

nmap <Leader>cd <Plug>(coc-definition)
nmap <Leader>ct <Plug>(coc-type-definition)
nmap <Leader>ci <Plug>(coc-implementation)
nmap <Leader>crn <Plug>(coc-rename)
nnoremap <Leader>cc :<C-u>CocList commands<CR>

" First try to go to first real character of line, then allow going to
" beginning of line
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

set autoindent
set background=dark
set backspace=indent,eol,start
set clipboard+=unnamedplus
set cmdheight=2 " Better display for messages
set completeopt-=preview
set fillchars=vert:\ ,stl:\ ,stlnc:\
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list listchars=tab:»\ ,trail:·,nbsp:·
set mouse-=a " Disable mouse click to go to position
set noexpandtab
set nowrap
set omnifunc=ale#completion#OmniFunc
set pastetoggle=<F2>
set ruler
set shiftround
set shiftwidth=4
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set smartindent
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*node_modules*

colorscheme wpgtkAlt

highlight Normal ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight SignColumn ctermbg=none
" not a huge fan of the 80col ruler, so hide it
highlight ColorColumn ctermbg=none
" 'listchars' and whatever - tabs/spaces indents
highlight NonText ctermfg=darkgray
highlight Comment ctermfg=darkgray ctermbg=none

source $HOME/.config/nvim/functions.vim
