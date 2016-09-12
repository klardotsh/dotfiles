au FileType py set textwidth=80
autocmd FileType javascript,c,cpp,java,ruby,python,rust autocmd BufWritePre <buffer> StripWhitespace
autocmd! BufRead *.js,*.html,*.py,*.sh Neomake
autocmd! BufWritePost *.js,*.html,*.py,*.sh Neomake
