" iv597's vimrc of awesomesauseful minimalism
" Josh Klar <j@iv597.com> 
" http://iv597.com/code/dotz/tree/general/.vimrc

set t_Co=256
set nocompatible
syntax on
filetype plugin indent on
au BufRead,BufNewFile *.md set filetype=markdown

set background=dark
colorscheme torte
hi Normal ctermbg=none
hi LineNr ctermbg=none
hi NonText ctermbg=none
hi SignColumn ctermbg=none ctermfg=cyan
hi LineNr ctermfg=yellow

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

" Because <TAB>'s are fun!
set ts=3
set shiftwidth=3
set tabstop=3
set noexpandtab

set autoindent
set copyindent

" set textwidth=72 " Annoying as all hell can be, auto-wraps my lines. 
" Need a 'soft width' option...
set nowrap " Because line-breaking is no fun, either

set hlsearch " Highlight search results
set incsearch " ... as I type!
" Clears search buffer to stop highlighting stuff when done with it
nmap <silent> ,/ :nohlsearch<CR>

set pastetoggle=<F2> " Stop breaking pastes...

" Reformat paragraph or selection
vmap Q gq
nmap Q gqap

" Unbind the cursor keys in insert, normal and visual modes.
"for prefix in ['i', 'n', 'v']
"  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"    exe prefix . "noremap " . key . " <Nop>"
"  endfor
"endfor

