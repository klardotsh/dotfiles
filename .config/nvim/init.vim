" Josh Klar [iv597] vimrc
" 2016 nvim Rewrite Edition

set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'Shougo/vimproc.vim'

Plug 'neomake/neomake'
Plug 'jaawerth/neomake-local-eslint-first'

Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'tpope/vim-surround'
Plug 'Konfekt/FastFold'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'

Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'strogonoff/vim-coffee-script'

Plug 'chase/vim-ansible-yaml'
Plug 'markcornick/vim-vagrant'
Plug 'fatih/vim-go'

Plug 'hdima/python-syntax'
Plug 'davidhalter/jedi-vim'

Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-airline/vim-airline'

Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin indent on

set t_Co=16
set background=dark
colorscheme lucario

if !exists("g:syntax_on")
	syntax enable
endif

au BufRead,BufNewFile *.eslintrc set filetype=json
au BufRead,BufNewFile *.tag set filetype=html
au BufRead,BufNewFile *.js set suffixesadd+=.js
au BufRead,BufNewFile *.jsx set suffixesadd+=.jsx
au BufRead,BufNewFile *.tmux.conf set filetype=config

au BufRead,BufNewFile *.js,*.jsx,*.tag let npm_bin = system('npm bin')
au BufRead,BufNewFile *.js,*.jsx,*.tag let $PATH .= ';' . npm_bin

autocmd FileType javascript,c,cpp,java,ruby,python,rust autocmd BufWritePre <buffer> StripWhitespace
autocmd! BufRead *.js,*.html,*.py,*.sh Neomake
autocmd! BufWritePost *.js,*.html,*.py,*.sh Neomake

let g:gitgutter_override_sign_column_highlight = 0

hi Normal ctermbg=none ctermfg=none
hi NonText ctermbg=none
"hi Comment ctermfg=3
hi SpecialKey ctermbg=none
highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none

" let g:neomake_javascript_enabled_makers = ['eslint']

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" YCM gives you popups and splits by default that some people might not
" like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

let g:airline_powerline_fonts = 1
set laststatus=2

set undofile

set hidden
set ruler
"set number
set nowrap

set splitbelow
set splitright

set backspace=indent,eol,start

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*node_modules*

set incsearch
set hlsearch

set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

set ignorecase
set autoindent
set smartindent

let loaded_matchparen=1

set pastetoggle=<F2>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-e> :bufdo edit<Space>

"let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<C-t>'

let mapleader=","
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap ; :

" format JSON
map <Leader>j :%!python -m json.tool<CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Reflow selection or paragraph
vmap Q gq
nmap Q gqap

au FileType py set textwidth=80 " PEP8

