set laststatus=2

set hidden
set ruler
set nowrap

set list listchars=tab:»·,trail:·,nbsp:·
set fillchars=vert:\ ,stl:\ ,stlnc:\ 

set splitbelow
set splitright

set clipboard+=unnamedplus

set background=dark
colorscheme gotham

if !exists("g:syntax_on")
	syntax enable
endif

let g:lightline = { 'colorscheme': 'gotham' }
let g:gitgutter_override_sign_column_highlight = 0

highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none
