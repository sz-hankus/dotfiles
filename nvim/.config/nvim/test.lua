-- Basic settings for usability
local opt = vim.opt
opt.number = true
opt.relativenumber = true

opt.autoindent = true
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.mouse = a

opt.scrolloff = 4
opt.cursorline = true
opt.wrap = false


-- Cursor
opt.guicursor = opt.guicursor['_value'] .. ',n-v-c:blinkon1'
opt.guicursor = opt.guicursor['_value'] .. ',n-v-c:blinkwait10'


-- Mappings
local keymap = vim.keymap
vim.g.mapleader = ' '

keymap.set('n', '<Leader><cr>', ':noh<cr>', { silent = true })
keymap.set('n', '<Leader>w', ':w!<cr>')

