" Josh Klar [iv597] vimrc
" 2015 Rewrite Edition

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" The following are installed through pacman:
" - vim-syntastic
" - vim-systemd
" - vim-surround

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'

Plugin 'marijnh/tern_for_vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'fatih/vim-go'

call vundle#end()

filetype plugin indent on

set t_Co=16
set background=dark
colorscheme peachpuff 
syntax on

hi Comment ctermfg=2

let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']

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

set hidden
set ruler
set nowrap

set backspace=indent,eol,start

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

set pastetoggle=<F2>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

let mapleader=","
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap ; :

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Reflow selection or paragraph
vmap Q gq
nmap Q gqap

au FileType py set textwidth=80 " PEP8

