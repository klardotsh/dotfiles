" Disable mouse click to go to position
set mouse-=a

set pastetoggle=<F2>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-e> :bufdo edit<Space>

"let g:ctrlp_map = '<C-t>'
map <C-t> :Files<CR>

let mapleader=","
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
