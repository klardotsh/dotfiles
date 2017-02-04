call plug#begin('~/.local/share/nvim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'Shougo/vimproc.vim'

Plug 'neomake/neomake'
Plug 'jaawerth/neomake-local-eslint-first'

Plug 'Shougo/deoplete.nvim'

Plug 'ervandew/supertab'

Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'tpope/vim-surround'
Plug 'Konfekt/FastFold'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'strogonoff/vim-coffee-script'
Plug 'moll/vim-node'

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'othree/jspc.vim'

Plug 'chase/vim-ansible-yaml'
Plug 'markcornick/vim-vagrant'

Plug 'cespare/vim-toml'

Plug 'fatih/vim-go'

Plug 'hdima/python-syntax'
Plug 'davidhalter/jedi-vim'

Plug 'rust-lang/rust.vim'

Plug 'peterhoeg/vim-qml'

Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}

Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'

Plug 'itchyny/lightline.vim'

Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'

call plug#end()

