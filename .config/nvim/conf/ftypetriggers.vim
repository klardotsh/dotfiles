au FileType py set textwidth=80
au FileType markdown set textwidth=80

autocmd! BufWritePre *.py,*.js,*.css,*.scss,*.sass,*.fs,*.fsi,*.fsx,*.rs DeleteTrailingWhitespace

augroup rainbow_lisp
  autocmd!
  autocmd FileType hy,lisp,clojure,scheme RainbowParentheses
augroup END
