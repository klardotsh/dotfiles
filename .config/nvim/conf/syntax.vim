set background=dark
colorscheme lucario

if !exists("g:syntax_on")
	syntax enable
endif

let g:gitgutter_override_sign_column_highlight = 0

hi Normal ctermbg=none ctermfg=none
hi NonText ctermbg=none
hi SpecialKey ctermbg=none
highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none
