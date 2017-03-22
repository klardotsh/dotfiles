au FileType py set textwidth=80
au FileType markdown set textwidth=80

autocmd! BufRead *.js,*.html,*.py,*.sh,*.rs,*.ex* Neomake
autocmd! BufWritePost *.js,*.html,*.py,*.sh,*.rs,*.ex* Neomake
autocmd! BufWritePre *.py,*.js,*.css,*.scss,*.sass,*.fs,*.fsi,*.fsx DeleteTrailingWhitespace

augroup rainbow_lisp
  autocmd!
  autocmd FileType hy,lisp,clojure,scheme RainbowParentheses
augroup END
