set laststatus=2

set hidden
set ruler
set nowrap

set list listchars=tab:»·,trail:·,nbsp:·

set splitbelow
set splitright

set clipboard+=unnamedplus

set background=dark
colorscheme nord

if !exists("g:syntax_on")
	syntax enable
endif

let g:gitgutter_override_sign_column_highlight = 0

hi Normal ctermbg=none ctermfg=none
hi NonText ctermbg=none
hi SpecialKey ctermbg=none
highlight SignColumn ctermbg=none
"highlight GitGutterAdd ctermfg=green ctermbg=none
"highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none

hi Normal ctermbg=None

" https://gist.github.com/paulrouget/ad44d1a907a668d012d23b0c1bdf72f9
hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=237
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi Comment ctermfg=102
"hi clear SignColumn
hi SignColumn ctermbg=None
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
"set guicursor=a:ver25
