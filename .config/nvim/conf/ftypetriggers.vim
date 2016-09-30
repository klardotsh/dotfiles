au FileType py set textwidth=80
autocmd FileType javascript,c,cpp,java,ruby,python,rust,qml autocmd BufWritePre <buffer> StripWhitespace
autocmd! BufRead *.js,*.html,*.py,*.sh,*.rs Neomake
autocmd! BufWritePost *.js,*.html,*.py,*.sh,*.rs Neomake
