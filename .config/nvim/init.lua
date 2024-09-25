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

	if type(mode) == "string" then
		vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	elseif type(mode) == "table" then
		for _, imode in ipairs(mode) do
			map(imode, lhs, rhs, opts)
		end
	else
		error("first arg to map() must be a string or a table of strings")
	end
end

function unfuck_colors()
	-- So many colorschemes set bg/fg colors. Stop. I already defined 16 of them
	-- in my terminal config. Especially, if you color NonText, I hate you.
	cmd 'hi Normal ctermfg=none ctermbg=none guifg=none guibg=none'
	cmd 'hi NonText ctermbg=none'
	cmd 'hi VertSplit ctermbg=none guibg=none'
	cmd 'hi StatusLineNC ctermbg=none guibg=none'
	cmd 'hi Comment ctermbg=none cterm=italic'
	cmd 'hi Constant ctermbg=none cterm=italic'

	-- Unfuck vim-boring specifically (this should basically become a fork honestly)
	-- Specifically works better than stock when toggling between light and dark themes.
	cmd 'hi String ctermfg=8 ctermbg=none'
	cmd 'hi Statement ctermbg=none cterm=bold'
	cmd 'hi Special ctermbg=none cterm=italic'

	-- Sidebar gutter colors are mostly (1) light variants, and (2) with backgrounds
	-- in vim-boring. Fix all of that.
	cmd 'hi DiagnosticError ctermbg=none ctermfg=1'
	cmd 'hi DiagnosticWarn ctermbg=none ctermfg=3'
	cmd 'hi DiagnosticInfo ctermbg=none ctermfg=5'
	cmd 'hi DiagnosticHint ctermbg=none ctermfg=9'
	cmd 'hi diffAdded ctermbg=none ctermfg=green'
	cmd 'hi diffRemoved ctermbg=none ctermfg=red'
	cmd 'hi diffChanged ctermbg=none ctermfg=yellow'
	cmd 'hi diffLine ctermbg=none'
	cmd 'hi diffNewFile ctermbg=none'
	cmd 'hi diffOldFile ctermbg=none'
	cmd 'hi diffIndexLine ctermbg=none'
	cmd 'hi diffFile ctermbg=none'
end

-- As much as <Space> as a leader is in vogue right now and compatible with
-- Helix, Doom Emacs, etc., this was my leader key for almost a decade, and the
-- muscle memory is strong. On Dvorak, it's an extremely comfortable jump
-- anyway.
g.mapleader=","

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
opt.list = true
opt.listchars = {
	tab = '· ',
	trail = '·',
	nbsp = '·',
}
opt.number = false
opt.relativenumber = false
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
opt.termguicolors = false
opt.title = true -- set terminal window title
opt.updatetime = 300

-- Helix-like (ish) sane line wrapping, thanks @jbauer!
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↪"

g.monochrome_italic_comments = 1
g.nofrils_strbackgrounds = 1

local SELECTED_COLORSCHEME = 'boring'

vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
	'tani/vim-jetpack',
	'nvim-lua/plenary.nvim', -- general helper lib
	'rktjmp/lush.nvim', -- colorscheme helper lib

	-- diagnostics...
	'tweekmonster/startuptime.vim',

	-- themes: I tend to prefer those that work with <=16 colors generically
	'jeffkreeftmeijer/vim-dim',
	'noahfrederick/vim-noctu',
	'robertmeta/nofrils',
	'karoliskoncevicius/distilled-vim',
	't184256/vim-boring',

	-- the tpope section
	'tpope/vim-abolish',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-markdown',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-speeddating',

	-- messing with numbers
	'glts/vim-magnum', -- dependency, big integer library
	'glts/vim-radical', -- convert between dec/hex/oct/bin nums with crX binds

	-- interface / misc
	'editorconfig/editorconfig-vim', -- force buffer to use editorconfig settings
	'ntpeters/vim-better-whitespace',
	'vim-scripts/DeleteTrailingWhitespace',

	-- finders and so forth
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
	'nvim-telescope/telescope-symbols.nvim',
	'chip/telescope-software-licenses.nvim',
	{'nvim-telescope/telescope.nvim',
	config = function()
		local telescope = require('telescope')
		telescope.load_extension('fzf')
		telescope.load_extension('software-licenses')
		telescope.setup({
			pickers = {
				buffers = { theme = 'ivy' },
				diagnostics = { theme = 'ivy' },
				help_tags = { theme = 'ivy' },
				live_grep = { theme = 'ivy' },
				find_files = { theme = 'ivy' },
				symbols = { theme = 'ivy' },
			},
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,
				},
			},
		})

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<C-t>', builtin.find_files, {})
		vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})
		vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>b', builtin.buffers, {})
		vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>sy', builtin.symbols, {})
		map('', '<Leader>sl', ':Telescope software-licenses find theme=ivy<CR>')
	end},

	-- provide :menubar command completion like helix/kakoune
	{'vzze/cmdline.nvim',
	config = function()
		require('cmdline')({
			window = {
				matchFuzzy = true,
				offset     = 1, -- depending on 'cmdheight' you might need to offset
				debounceMs = 10
			},

			hl = {
				default   = "Pmenu",
				selection = "PmenuSel",
				directory = "Directory",
				substr    = "LineNr"
			},

			column = {
				maxNumber = 6,
				minWidth  = 20
			},

			binds = {
				next = "<Tab>",
				back = "<S-Tab>"
			}
		})
	end},

	{'brenton-leighton/multiple-cursors.nvim',
	config = function()
		require("multiple-cursors").setup()

		map({'n', 'i'}, '<C-Down>', '<cmd>MultipleCursorsAddDown<CR>')
		map({''}, '<C-j>', '<cmd>MultipleCursorsAddDown<CR>')
		map({'n', 'i'}, '<C-Up>', '<cmd>MultipleCursorsAddUp<CR>')
		map({''}, '<C-k>', '<cmd>MultipleCursorsAddUp<CR>')
		map({'n', 'i'}, "<C-LeftMouse>", "<cmd>MultipleCursorsMouseAddDelete<CR>")
		map({'n', 'v'}, "<Leader>a", "<cmd>MultipleCursorsAddToWordUnderCursor<CR>")
	end},

	{'ggandor/leap.nvim',
	config = function()
		require('leap').create_default_mappings()
	end},

	{'ggandor/flit.nvim',
	config = function()
		require('flit').setup()
	end},

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
	end},

	'ourigen/skyline.vim',
	'markonm/traces.vim', -- Pattern/range previews where NeoVim doesn't already provide them

	-- automatically create any non-existent directories before writing the buffer
	-- > :e this/does/not/exist/file.txt
	-- > :w
	'pbrisbin/vim-mkdir',

	{'nvim-treesitter/nvim-treesitter',
	run = ":TSUpdate",
	config = function()
		require'nvim-treesitter.configs'.setup {
			ensure_installed = "all",
			highlight = { enable = true },
			indent = { enable = false },
		}

		vim.treesitter.language.register("bash", "apkbuild")
	end},

	-- Misc. language support - generally speaking treesitter has wiped out most of what
	-- used to make up this list
	'gpanders/vim-scdoc',
	'reasonml-editor/vim-reason-plus',
	'klardotsh/gale.vim',
	'Matt-Deacalion/vim-systemd-syntax',
	'NLKNguyen/cloudformation-syntax.vim',
	'uarun/vim-protobuf',
	'tridactyl/vim-tridactyl',

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

	{'VonHeikemen/lsp-zero.nvim',
	config = function()
		local lspconfig = require('lspconfig')
		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(_, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({buffer = bufnr})
		end)

		-- thanks, https://stackoverflow.com/a/74303272
		local opts = { noremap=true, silent=true }

		local function quickfix()
			vim.lsp.buf.code_action({
				filter = function(a) return a.isPreferred end,
				apply = true
			})
		end

		local function quickfix_all()
			vim.lsp.buf.code_action({
				apply = true
			})
		end

		vim.keymap.set('n', '<leader>f', quickfix, opts)
		vim.keymap.set('n', '<leader>F', quickfix_all, opts)

		-- LSP bindings. TODO: how many of these are now unnecessary given the above?
		map('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>')
		map('n', '<Leader>crn', '<cmd>lua vim.lsp.buf.rename()<CR>')
		map('n', '<Leader>cref', '<cmd>lua vim.lsp.buf.references()<CR>')
		map('n', '<Leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
		map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

		lspconfig.bashls.setup({})
		lspconfig.dhall_lsp_server.setup({})
		lspconfig.eslint.setup({})
		lspconfig.fennel_ls.setup({})
		lspconfig.gopls.setup({})
		lspconfig.jsonnet_ls.setup({})
		lspconfig.lua_ls.setup({})
		lspconfig.nomad_lsp.setup({})
		lspconfig.pylsp.setup({})
		lspconfig.rust_analyzer.setup({})
		lspconfig.sorbet.setup({})
		lspconfig.terraform_lsp.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.zls.setup({})
	end},
}

map('', '<Leader>/', ':nohlsearch<CR>', { silent = true })

-- reflow or reformat text
map('n', 'Q', 'gqap')
map('v', 'Q', 'gq')
map('', '<Leader>j', ':%!jq -S<CR>')

-- buffer/file management
map('', '<C-e>', ':bufdo edit<Space>')
map('', '<C-N>', ':bn<CR>')
map('', '<C-P>', ':bp<CR>')

-- First try to go to first real character of line, then allow going to
-- beginning of line
map('', '<Home>', "col('.') == match(getline('.'),'\\S')+1 ? '0' : '^'", {
	expr = true,
	silent = true,
})

-- Set colorscheme as the final things in the config.
vim.cmd('colorscheme ' .. SELECTED_COLORSCHEME)
unfuck_colors()
