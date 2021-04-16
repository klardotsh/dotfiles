if !exists("g:syntax_on")
        syntax enable
endif

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

filetype off
filetype plugin indent on

imap <silent> <Home> <C-O><Home>
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

" at this point I barely remember where many of these came from - broadly
" speaking, colorschemes LOVE doing absolutely insane shit with colors,
" roughly akin to melting down a box of crayons onto your screen (often
" because the theme wasn't tested on, or explicitly is not designed for, 16
" color mode and/or cterm). this is the part where I override that stuff.
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
highlight CocFloating ctermbg=0
highlight Pmenu ctermbg=0 ctermfg=none
highlight PmenuSel ctermbg=0 ctermfg=9
