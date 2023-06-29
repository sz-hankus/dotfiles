return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Colorschemes
	use 'sainnhe/gruvbox-material'

	use 'nvim-lua/plenary.nvim'
	use 'tpope/vim-commentary'
	use 'michaeljsmith/vim-indent-object'
	use 'nvim-telescope/telescope.nvim'
	-- use 'andymass/vim-matchup'
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	}
	use {
		  'nvim-lualine/lualine.nvim',
		    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
end)
