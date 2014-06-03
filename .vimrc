" iv597's vimrc

set t_Co=256
set nocompatible

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.mustache set filetype=mustache
au BufRead,BufNewFile *.json set filetype=json
au BufNewFile,BufReadPost *.ls setl foldmethod=indent
au BufWritePost *.ls silent LiveScriptMake! -p | cwindow | redraw!

autocmd QuickFixCmdPost * nested cwindow

syntax on
set cursorline
set background=dark
colorscheme peachpuff

hi CursorLine term=NONE cterm=NONE ctermbg=234
hi SpecialKey ctermbg=none
hi SignColumn ctermbg=none ctermfg=cyan
hi Folded ctermbg=none
hi Todo ctermbg=none ctermfg=yellow
hi Error ctermbg=none ctermfg=red
hi SyntasticError cterm=underline ctermbg=none ctermfg=red
hi SyntasticWarning cterm=underline ctermbg=none ctermfg=yellow

hi link htmlLink NONE

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_python_flake8_args = '--ignore=W191'
"let g:syntastic_auto_loc_list=1

let mapleader=","
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-e> :bufdo edit<Space>

nmap <Leader>m :silent make!<CR>:redraw!<CR>

nmap <silent> <Leader>/ :nohlsearch<CR>
" Reflow selection or paragraph
vmap Q gq
nmap Q gqap

inoremap <C-s> <c-o>:update<CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

set pastetoggle=<F2>

set hidden " Keep buffers open without needing to save them

set nobackup

"set number
"set numberwidth=3
set ruler

set encoding=utf-8
set fileencoding=utf-8

set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab " They've converted me to the dark side...

set autoindent
set copyindent
filetype plugin indent on

set foldmethod=indent

set textwidth=72
set nowrap

set hlsearch " Highlight search results...
set incsearch " ... as I type!

