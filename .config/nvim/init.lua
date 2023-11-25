-- klardotsh's vimrc, 2023 edition
-- released under 0BSD (https://www.tldrlegal.com/license/bsd-0-clause-license)
--
-- requires nvim >=0.9.0 (or at least that's all I've tested it against)

local api = vim.api
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local jetpackfile = vim.fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
	vim.fn.system(string.format('curl -fsSLo %s --create-dirs %s', jetpackfile, jetpackurl))
end

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function unfuck_colors()
	-- everything else playing nice with base16 plz
	cmd 'hi VertSplit ctermbg=none guibg=none'
	cmd 'hi StatusLineNC ctermbg=none guibg=none'

	-- nofrils sets a default background colour. bad dog!
	-- distilled sets a default **foreground** colour. still bad dog!
	cmd 'hi Normal ctermfg=none ctermbg=none guifg=none guibg=none'

	-- monochrome sets a default background colour for empty space, bad dog!
	cmd 'hi NonText ctermbg=none'

	-- monochrome sets a background for comments, nuke that too
	-- then make comments readable in dark colorschemes, and stand out in
	-- general
	cmd 'hi Comment ctermbg=none ctermfg=4 cterm=italic'

	-- monochrome sets a background for things like = and +, goodbye
	cmd 'hi Statement ctermbg=none'

	-- yui darkens strings/constants by default, which is *very* hard to read
	-- on dark screens. this value looks fine on both dark and light
	-- backgrounds
	cmd 'hi Constant ctermfg=7'

	-- Preferences/modifying monochrome, mostly
	cmd 'hi Constant ctermbg=none cterm=italic'
end

-- As much as <Space> as a leader is in vogue right now and compatible with
-- Helix, Doom Emacs, etc., this was my leader key for almost a decade, and the
-- muscle memory is strong. On Dvorak, it's an extremely comfortable jump
-- anyway.
g.mapleader=","
if not g.syntax_on then
	cmd 'syntax on'
end

opt.autoindent = true
opt.background = 'dark'
opt.backspace = {'indent', 'eol', 'start'}
opt.clipboard:append {'unnamedplus'}
opt.cmdheight = 2
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
opt.number = false
opt.relativenumber = false
opt.pastetoggle = '<F2>'
opt.ruler = true
opt.scrolloff = 7 -- show 7 lines around the cursor line
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = true
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.updatetime = 300

-- Helix-like (ish) sane line wrapping, thanks @jbauer!
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = ">>"

g.tokyonight_hide_inactive_statusline = 1
g.tokyonight_lualine_bold = 1
g.base16_transparent_background = 1
g.srcery_italic = 1
g.srcery_bg_passthrough = 1
g.monochrome_italic_comments = 1
g.dracula_colorterm = 0
g.nofrils_strbackgrounds = 1

vim.cmd('set notermguicolors')

vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
	{'tani/vim-jetpack'},
	'jeffkreeftmeijer/vim-dim',
	'noahfrederick/vim-noctu',
	'robertmeta/nofrils',
	'karoliskoncevicius/distilled-vim',
	'cideM/yui',
	'https://git.jaderune.net/jbauer/vim-monochrome',

	-- the junegunn section
	'junegunn/fzf.vim',
	'junegunn/rainbow_parentheses.vim',
	'junegunn/vim-emoji',

	-- the tpope section
	'tpope/vim-abolish',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-markdown',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-speeddating',

	-- interface / misc
	'editorconfig/editorconfig-vim', -- force buffer to use editorconfig settings
	'ntpeters/vim-better-whitespace',
	'vim-scripts/DeleteTrailingWhitespace',

	{'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup()

		-- make gitsigns.nvim and lsp play nice in a base16 world
		cmd 'hi SignColumn ctermbg=none guibg=none'
		cmd 'hi DiffAdd ctermbg=none guibg=none'
		cmd 'hi DiffChange ctermbg=none guibg=none'
		cmd 'hi DiffDelete ctermbg=none guibg=none'
		cmd 'hi DiffText ctermbg=none guibg=none'
		cmd 'hi GitSignsAdd ctermbg=none guibg=none'
		cmd 'hi GitSignsChange ctermbg=none guibg=none'
		cmd 'hi GitSignsDelete ctermbg=none guibg=none'
	end,
},

'ourigen/skyline.vim',
'markonm/traces.vim', -- Pattern/range previews where NeoVim doesn't already provide them

-- automatically create any non-existent directories before writing the buffer
-- > :e this/does/not/exist/file.txt
-- > :w
'pbrisbin/vim-mkdir',

-- language support - generally speaking treesitter has wiped out most of what
-- used to make up this list
'gpanders/vim-scdoc',
'jjo/vim-cue',
'neovimhaskell/haskell-vim',
'purescript-contrib/purescript-vim',
'reasonml-editor/vim-reason-plus',
'rust-lang/rust.vim',
'vmchale/dhall-vim',
'alaviss/nim.nvim',
'ziglang/zig.vim',
'karolbelina/uxntal.vim',
'bfrg/vim-jq',
'klardotsh/gale.vim',
'https://git.sr.ht/~sircmpwn/hare.vim',

-- config formats support
'GutenYe/json5.vim',
'Matt-Deacalion/vim-systemd-syntax',
'NLKNguyen/cloudformation-syntax.vim',
'cespare/vim-toml',
'hashivim/vim-terraform',
'markcornick/vim-vagrant',
'tarekbecker/vim-yaml-formatter',
'uarun/vim-protobuf',
'ron-rs/ron.vim',

-- completion and language server nonsense, the bane of every config I've
-- written in the past several years
'neovim/nvim-lspconfig',
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-buffer",
"hrsh7th/cmp-path",
"hrsh7th/cmp-cmdline",
"hrsh7th/cmp-vsnip",
"hrsh7th/vim-vsnip",
{
	"hrsh7th/nvim-cmp",
	config = function()
		require('cmp').setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
		})
	end
},
}

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

-- LSP bindings
map('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<Leader>crn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>cref', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<Leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- Set colorscheme as the final things in the config.
vim.cmd('colorscheme noctu')
unfuck_colors()
