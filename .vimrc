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

Plugin 'editorconfig/editorconfig-vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'marijnh/tern_for_vim'

"Plugin 'jelera/vim-javascript-syntax'
"Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'markcornick/vim-vagrant'
Plugin 'fatih/vim-go'

Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

filetype plugin indent on

set t_Co=16
set background=light
colorscheme solarized
syntax on

au BufRead,BufNewFile *.eslintrc set filetype=json

let g:gitgutter_override_sign_column_highlight = 0

hi Comment ctermfg=2

highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none

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

set modeline

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

let loaded_matchparen=1

set pastetoggle=<F2>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-e> :bufdo edit<Space>

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

