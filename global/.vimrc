set t_Co=256
set nocompatible
syntax on
filetype plugin indent on
au BufRead,BufNewFile *.md set filetype=markdown

set background=dark
colorscheme molokai
hi Normal ctermbg=none
hi LineNr ctermbg=none
hi NonText ctermbg=none

" vim-buftabs in [community] does wonders...
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-e> :bufdo edit 

" Keep buffers open without needing to save them
set hidden

" Because screw underlining HTML <a>'s
hi link htmlLink NONE

set nobackup

set number
set numberwidth=4
set ruler

set encoding=utf-8

" Because <TAB>'s are no fun
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent
set copyindent

set nowrap " Because line-breaking is no fun, either

set hlsearch " Highlight search results
set incsearch " ... as I type!
" Clears search buffer to stop highlighting stuff when done with it
nmap <silent> ,/ :nohlsearch<CR>

set pastetoggle=<F2> " Stop breaking pastes...

" Reformat paragraph or selection
vmap Q gq
nmap Q gqap

