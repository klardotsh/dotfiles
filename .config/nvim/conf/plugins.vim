call plug#begin('~/.local/share/nvim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'Shougo/vimproc.vim'
Plug 'elebow/ale', { 'branch': 'auto-pipenv-option-for-python-linters' }

Plug 'pbrisbin/vim-mkdir'

" Auto- and Tab-Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'ervandew/supertab'

" Interface
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'

" Git Support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'metalelf0/base16-black-metal-scheme'

" Misc
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-surround'
Plug 'Konfekt/FastFold'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'ntpeters/vim-better-whitespace'

" Language Support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"" Various configuration formats
Plug 'cespare/vim-toml'
Plug 'chase/vim-ansible-yaml'
Plug 'markcornick/vim-vagrant'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'NLKNguyen/cloudformation-syntax.vim'

"" JavaScript
Plug 'moll/vim-node'
Plug 'ternjs/tern_for_vim', { 'do': 'yarn' }
Plug 'jelera/vim-javascript-syntax'

"" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript'

"" JSON5
Plug 'GutenYe/json5.vim'

"" Protobuf-esque
Plug 'uarun/vim-protobuf'
Plug 'peter-edge/vim-capnp'

"" Go
Plug 'fatih/vim-go'

"" Python
Plug 'hdima/python-syntax'
Plug 'fisadev/vim-isort'

"" Rust
Plug 'rust-lang/rust.vim'

"" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

call plug#end()
