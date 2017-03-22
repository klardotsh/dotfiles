call plug#begin('~/.local/share/nvim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'Shougo/vimproc.vim'
Plug 'neomake/neomake'

" Auto- and Tab-Completion
Plug 'Shougo/deoplete.nvim'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'ervandew/supertab'

" Interface
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'

" Git Support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'

" Misc
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-surround'
Plug 'Konfekt/FastFold'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'ntpeters/vim-better-whitespace'

" Language Support
"" Various configuration formats
Plug 'cespare/vim-toml'
Plug 'chase/vim-ansible-yaml'
Plug 'markcornick/vim-vagrant'

"" JavaScript
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'moll/vim-node'
Plug 'ternjs/tern_for_vim', { 'do': 'yarn' }
Plug 'othree/jspc.vim'
Plug 'jaawerth/neomake-local-eslint-first'

"" JSON5
Plug 'GutenYe/json5.vim'

"" Go
Plug 'fatih/vim-go'

"" Python
Plug 'hdima/python-syntax'
Plug 'davidhalter/jedi-vim'

"" Rust
Plug 'rust-lang/rust.vim'

"" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

call plug#end()
