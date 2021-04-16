" ¯\_(ツ)_/¯ this chunk is a cobbled up disaster of whatever I've accumulated
" since the last burn-to-the-ground rewrite (2016ish?)
let g:ale_completion_tsserver_autoimport = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_fix_on_save = 1
let g:ale_go_bingo_executable = 'gopls'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_python_auto_pipenv = 1
let g:ale_python_black_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '!'
let g:ale_fixers = {
\   'go': ['gofmt'],
\   'python': ['black', 'isort'],
\   'javascript': ['prettier', 'eslint'],
\   'jsx': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'haskell': ['hindent', 'stylish-haskell'],
\   'ocaml': ['ocamlformat'],
\   'dhall': ['dhall'],
\   'rust': ['rustfmt'],
\   'nix': ['nixpkgs-fmt'],
\}

" disable ALE's completion because it fights with coc.nvim, which understands
" most formats better than ALE anyway.
let g:ale_completion_enabled = 0

" have to kill ghc and a few other defaults that throw errors on non-stdlib
" imports
let g:ale_linters ={
\   'haskell': ['hlint', 'hdevtools', 'hfmt'],
\}
