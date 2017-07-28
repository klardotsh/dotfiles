let g:airline_powerline_fonts = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:ale_linters = {'javascript': ['eslint']}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_args = '-m flake8'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:rustfmt_autosave = 1

let loaded_matchparen=1

let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = {
	\'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|dist)$'
	\}

" Let plugins show effects after 500ms, not 4s
set updatetime=500

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
