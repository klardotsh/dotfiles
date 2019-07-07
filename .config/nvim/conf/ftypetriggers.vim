au FileType py set textwidth=80
au FileType markdown set textwidth=80

autocmd! BufWritePre *.c,*.cpp,*.h,*.hpp,*.py,*.hy,*.js,*.jsx,*.ts,*.css,*.scss,*.sass,*.fs,*.fsi,*.fsx,*.rs,*.md,*.toml,*.ini,*.json,*.html,*.service,*.timer,*.yaml DeleteTrailingWhitespace

augroup rainbow_lisp
  autocmd!
  autocmd FileType hy,lisp,clojure,scheme RainbowParentheses
augroup END
