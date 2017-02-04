au FileType py set textwidth=80
autocmd! BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
autocmd! BufRead *.js,*.html,*.py,*.sh,*.rs Neomake
autocmd! BufWritePost *.js,*.html,*.py,*.sh,*.rs Neomake
autocmd! BufWritePre *.py,*.js,*.css,*.scss,*.sass DeleteTrailingWhitespace
