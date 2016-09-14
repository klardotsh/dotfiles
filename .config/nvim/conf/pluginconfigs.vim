let g:airline_powerline_fonts = 1

let g:neomake_javascript_eslint_exe = nrun#Which('eslint')
let g:neomake_javascript_enabled_makers = ['eslint']

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let loaded_matchparen=1

" Let plugins show effects after 500ms, not 4s
set updatetime=500

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
