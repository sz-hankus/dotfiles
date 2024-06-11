-- Basic settings for usability
local opt = vim.opt
local fn = vim.fn
opt.syntax = 'on'
opt.termguicolors = true

opt.number = true
opt.relativenumber = true

opt.autoindent = true
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.ignorecase = true
opt.smartcase = true

opt.mouse = 'a'

opt.scrolloff = 4
opt.cursorline = true
opt.wrap = false
-- opt.textwidth = 80


-- Cursor
opt.guicursor:append('n-v-c:blinkon1')
opt.guicursor:append('n-v-c:blinkwait10')

-- Mappings
local keymap = vim.keymap
vim.g.mapleader = ' '

if vim.g.vscode then
	keymap.set('n', '<leader>w', ':call VSCodeCall(\'workbench.action.files.save\')<cr>')
	keymap.set('n', '<leader><cr>', ':noh<cr>')
	keymap.set('n', '<leader>ff', ':call VSCodeNotify(\'workbench.action.quickOpen\', 1)<CR>')
	keymap.set('n', '<leader>fg', ':call VSCodeNotify(\'workbench.action.findInFiles\', { \'query\': expand(\'<cword>\')})<CR>')
	return
else
	keymap.set('n', '<Leader><cr>', ':noh<cr>', { silent = true })
	keymap.set('n', '<Leader>w', ':w!<cr>')
	keymap.set('n', '<leader>ff', ':Telescope find_files hidden=true<cr>')
	keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
	keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
	keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')
	keymap.set('n', '<Leader>nt', ':NvimTreeToggle<cr>')
end

-- Install packer if not installed
packer_location = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
repo = 'https://github.com/wbthomason/packer.nvim'
if fn.empty(fn.glob(packer_location)) > 0 then
	print('Cloning the nvim.packer repository...')
	vim.api.nvim_command('! git clone '..repo..' '..packer_location)
	vim.api.nvim_command('packadd packer.nvim')
	print('Done')
	-- On the first launch sync packer and return
	require('plugins')
	return require('packer').sync()
end

-- Plugins
require('plugins')

-- Colors
vim.cmd('colorscheme gruvbox-material')

-- Plugin configs
-- NVIM-TREE
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
	side = 'right',
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- TREESITTER
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "json", "dockerfile", "sql" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  ignore_install = { },

  highlight = {
    enable = true,

    -- Disable slow highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

-- LUALINE
require('lualine').setup()

