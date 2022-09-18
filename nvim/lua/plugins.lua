local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

	use 'navarasu/onedark.nvim'
	-- use 'sunjon/Shade.nvim'

	use 'psliwka/vim-smoothie'

	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-unimpaired'

	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	-- use 'nvim-telescope/telescope-project.nvim'

	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use { "akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
		require("toggleterm").setup()
	end }

	use 'nvim-treesitter/nvim-treesitter'

	-- use 'sheerun/vim-polyglot'

	use '/mnt/c/dev/lua/plugins/BetterBlockSelect'
	-- use 'mg979/vim-visual-multi'

end)

require('bbs')


local onedark = require('onedark')
local colors = require('onedark.palette')

onedark.setup {
	highlights = {
		-- TelescopeBorder = {bg = colors.dark.red},
		TelescopePromptBorder = { fg = colors.dark.red },
		TelescopeResultsBorder = { fg = colors.dark.light_grey },
		TelescopePreviewBorder = { fg = colors.dark.light_grey },
		TelescopePromptPrefix = { fg = colors.dark.light_grey },
		StatusLineNC = { fg = colors.dark.grey, bg = colors.dark.bg0 },
		StatusLine = { fg = colors.dark.grey, bg = colors.dark.bg1 }
	}
}

onedark.load()


require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "python", "rust" },

	highlight = {
		enable = true
	},

	indent = { enable = true }
}

require('telescope').setup {
	defaults = {
		-- Your defaults config goes in here
	},
	pickers = {
		find_files = { true },
		-- Your special builtin config goes in here
		buffers = {
			sort_lastused = true,
			theme = 'ivy',
			previewer = false,
			mappings = {
				i = {
					['<c-d>'] = 'delete_buffer',
				},
				n = {
					['<c-d>'] = require('telescope.actions').delete_buffer,
				}
			}
		},
		live_grep = {
			theme = 'ivy'
		},
	},
	extensions = {}
}

require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})


require("toggleterm").setup {
	size = 20,
	open_mapping = [[<c-t>]],
	hide_numbers = true,
	shade_terminal = false,
	direction = "horizontal"
}

require('nvim-lsp-installer').setup {}

require('config.lsp')

require('config.dap')
