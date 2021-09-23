-- klardotsh's vimrc, 2021 edition
-- released under CC0 (https://creativecommons.org/publicdomain/zero/1.0/)
--
-- requires nvim >=0.5.0

-- big ol thanks to https://oroques.dev/notes/neovim-init/ for the help
-- in migrating a vimrc to init.lua

local api = vim.api
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require 'paq' {
	'savq/paq-nvim';

	-- colorschemes
	'jeffkreeftmeijer/vim-dim'; -- works in any term
	'noahfrederick/vim-noctu';
	'folke/tokyonight.nvim'; -- a new one to play with!
	'Soares/base16.nvim';
	'srcery-colors/srcery-vim';

	-- interface / misc
	'Konfekt/FastFold';
	'editorconfig/editorconfig-vim'; -- force buffer to use editorconfig settings
	'ervandew/supertab';
	'hoob3rt/lualine.nvim';
	'markonm/traces.vim';
	'ntpeters/vim-better-whitespace';
	'vim-scripts/DeleteTrailingWhitespace';
	'yuttie/comfortable-motion.vim';
	'nvim-lua/plenary.nvim';
	'lewis6991/gitsigns.nvim';

	-- the junegunn section
	'junegunn/fzf.vim';
	'junegunn/rainbow_parentheses.vim';
	'junegunn/vim-emoji';

	-- the tpope section
	'tpope/vim-abolish';
	'tpope/vim-commentary';
	'tpope/vim-fugitive';
	'tpope/vim-markdown';
	'tpope/vim-repeat';
	'tpope/vim-surround';

	-- completion stuff
	'nvim-lua/completion-nvim';
	'hrsh7th/nvim-compe';

	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	};

	-- automatically create any non-existent directories before writing the buffer
	-- > :e this/does/not/exist/file.txt
	-- > :w
	'pbrisbin/vim-mkdir';

	-- language support - generally speaking treesitter has wiped out most of
	-- what used to make up this list
	--
	-- 'HerringtonDarkholme/yats.vim'; -- typescript
	-- 'digitaltoad/vim-pug';
	-- 'evanleck/vim-svelte';
	-- 'fatih/vim-go';
	-- 'fisadev/vim-isort'; -- Python-related
	-- 'gpanders/vim-scdoc';
	-- 'hdima/python-syntax';
	-- 'jelera/vim-javascript-syntax';
	-- 'jjo/vim-cue';
	-- 'moll/vim-node';
	-- 'neovimhaskell/haskell-vim';
	-- 'purescript-contrib/purescript-vim';
	-- 'reasonml-editor/vim-reason-plus';
	-- 'rust-lang/rust.vim';
	'vmchale/dhall-vim';
	-- 'zah/nim.vim';
	-- 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	'alaviss/nim.nvim';
	'ziglang/zig.vim';

	-- config formats support
	'GutenYe/json5.vim';
	'Matt-Deacalion/vim-systemd-syntax';
	'NLKNguyen/cloudformation-syntax.vim';
	'cespare/vim-toml';
	'chase/vim-ansible-yaml';
	'hashivim/vim-terraform';
	'markcornick/vim-vagrant';
	'tarekbecker/vim-yaml-formatter';
	'uarun/vim-protobuf';
}

opt.completeopt = "menu,menuone,noselect"
require'compe'.setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	allow_prefix_unmatch = false,
	source = {
		path = true,
		buffer = true,
		calc = true,
		ultisnips = true,
		vsnip = false,
		nvim_lua = true,
		spell = true,
		tags = true
	},
}

-- from https://github.com/nvim-treesitter/nvim-treesitter/blob/c37e79803e21abfae960174a6c661da166c87e8b/README.md
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,              -- false will disable the whole extension
	},
}

require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'gruvbox', -- closest thing I have for now, auto doesn't work??
		component_separators = {'|', '|'},
		section_separators = {'', ''},
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {'filename'},
		lualine_x = {},
		lualine_y = {'filetype', 'encoding'},
		lualine_z = {'progress', 'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {},
		lualine_y = {'filetype', 'encoding'},
		lualine_z = {'progress', 'location'}
	},
	tabline = {
		--[[
		lualine_a = {'filename'},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
		]]
	},
	extensions = {}
}

require'gitsigns'.setup()

if not g.syntax_on then
	cmd 'syntax enable'
end

opt.autoindent = true
opt.background = 'dark'
opt.backspace = {'indent', 'eol', 'start'}
opt.clipboard:append {'unnamedplus'}
opt.cmdheight = 2
opt.completeopt = {'menuone', 'noinsert', 'noselect'}
opt.expandtab = false
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 2
opt.listchars = {
	tab = '» ',
	trail = '·',
	nbsp = '·',
}
--opt.mouse ???
opt.number = false
opt.relativenumber = false
opt.pastetoggle = '<F2>'
opt.ruler = true
opt.scrolloff = 7 -- show 7 lines around the cursor line
opt.shiftround = true
opt.shiftwidth = 4
-- opt.shortmess:append {'c'}
-- opt.signcolumn = true
opt.smartindent = true
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
-- kinda explicitly *not* what I want, but it makes matching schemes look
-- better, so we'll roll with it
opt.termguicolors = true
opt.updatetime = 300
opt.wrap = false

g.tokyonight_hide_inactive_statusline = 1
g.tokyonight_lualine_bold = 1
g.base16_transparent_background = 1
g.srcery_italic = 1
g.srcery_bg_passthrough = 1
cmd 'colorscheme srcery'

cmd 'let mapleader=","'

map('', '<Leader>/', ':nohlsearch<CR>', { silent = true })

-- reflow or reformat text
map('n', 'Q', 'gqap')
map('v', 'Q', 'gq')
map('', '<Leader>j', ':%!jq -S<CR>')

-- buffer/file management
map('', '<C-t>', ':Files<CR>')
map('', '<C-e>', ':bufdo edit<Space>')
map('', '<C-N>', ':bn<CR>')
map('', '<C-P>', ':bp<CR>')
map('', '<Leader>b', ':Buffers<CR>')

-- First try to go to first real character of line, then allow going to
-- beginning of line
map('', '<Home>', "col('.') == match(getline('.'),'\\S')+1 ? '0' : '^'", {
	expr = true,
	silent = true,
})

-- from vim.reaper
g.comfortable_motion_friction = 50.0
g.comfortable_motion_air_drag = 1.0
map('', '<ScrollWheelDown>', '<cmd>comfortable_motion#flick(40)<CR>')
map('', '<ScrollWheelUp>', '<cmd>comfortable_motion#flick(-40)<CR>')

-- color normalization so themes and plugins don't impose their will on me
cmd 'hi SignColumn ctermbg=none guibg=none'
cmd 'hi DiffAdd ctermbg=none guibg=none'
cmd 'hi DiffChange ctermbg=none guibg=none'
cmd 'hi DiffDelete ctermbg=none guibg=none'
cmd 'hi DiffText ctermbg=none guibg=none'

-- everything else playing nice with base16 plz
cmd 'hi VertSplit ctermbg=none guibg=none'
