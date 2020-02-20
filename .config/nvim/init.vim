" Josh Klar [klardotsh] vimrc
" 2019 Edition

call plug#begin('~/.local/share/nvim/plugged')

" Interface / Misc
Plug 'Konfekt/FastFold'
Plug 'deviantfero/wpgtk.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'editorconfig/editorconfig-vim' " Force buffer to use editorconfig settings
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/DeleteTrailingWhitespace'

" Automatically create any non-existent directories before writing the buffer.
" > :e this/does/not/exist/file.txt
" > :w
Plug 'pbrisbin/vim-mkdir'

" Git Integration (ish)
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Server Protocol / Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Language support (how many of these are still needed with cocs?)
Plug 'HerringtonDarkholme/yats.vim' " TypeScript
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'fisadev/vim-isort' " Python-related
Plug 'hdima/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim' " Elixir-related

" Config formats support
Plug 'GutenYe/json5.vim'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'NLKNguyen/cloudformation-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'chase/vim-ansible-yaml'
Plug 'markcornick/vim-vagrant'
Plug 'uarun/vim-protobuf'

call plug#end()

let g:ctrlp_custom_ignore = {
	\'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|dist)$'
	\}

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }
let g:lightline = {
      \ 'colorscheme': 'selenized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }


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
\}

let g:gitgutter_override_sign_column_highlight = 0
let g:go_def_mapping_enabled = 0 " disable vim-go :GoDef short cut (gd) - this is handled by LanguageClient [LC]
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:rustfmt_autosave = 1
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
nnoremap <Leader><Enter> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <silent> <Leader>d :call LanguageClient#textDocument_definition()<CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

colorscheme pencil

highlight Normal ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight SignColumn ctermbg=none
" 'listchars' and whatever - tabs/spaces indents
highlight NonText ctermfg=darkgray

