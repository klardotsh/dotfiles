" Disable mouse click to go to position
set mouse-=a

set pastetoggle=<F2>
let mapleader=","

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-e> :bufdo edit<Space>

map <C-t> :Files<CR>
map <Leader>b :Buffers<CR>

nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap ; :

" format JSON
map <Leader>j :%!python -m json.tool<CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Reflow selection or paragraph
vmap Q gq
nmap Q gqap

autocmd FileType javascript nnoremap <silent> <buffer> <Leader>d :TernDef<CR>
autocmd FileType rust nnoremap <Leader>d :YcmCompleter GoTo<CR>

nnoremap <Leader><Enter> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <Leader>d :call LanguageClient#textDocument_definition()<CR>
