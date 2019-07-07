filetype off
filetype plugin indent on

au BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
au BufRead,BufNewFile *.eslintrc set filetype=json
au BufRead,BufNewFile *.tag set filetype=html
au BufRead,BufNewFile *.js set suffixesadd+=.js
au BufRead,BufNewFile *.jsx set suffixesadd+=.jsx filetype=javascript.jsx
au BufRead,BufNewFile *.tmux.conf set filetype=config

au BufRead,BufNewFile *.js,*.jsx,*.tag let npm_bin = system('npm bin')
au BufRead,BufNewFile *.js,*.jsx,*.tag let $PATH .= ';' . npm_bin
