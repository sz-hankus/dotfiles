" Basic settings for usability
set nocompatible " remove compatibility with vi
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set scrolloff=4 " Keep 4 lines below and above the cursor
set cursorline
set nowrap
set textwidth=80
set ignorecase 
set smartcase

" Automatically install vim-plug (if not installed)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" PLUGINS
call plug#begin()
	" Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

	" Color schemes
	Plug 'phha/zenburn.nvim'
	Plug 'arcticicestudio/nord-vim'
	Plug 'jacoborus/tender.vim'
	Plug 'morhetz/gruvbox'
	Plug 'lifepillar/vim-solarized8'
	Plug 'sainnhe/gruvbox-material'
	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

	" Tab bar
	" Plug 'romgrk/barbar.nvim'
	" Coc (Conquer Of Completion)
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Cursor blinking
set guicursor+=n-v-c:blinkon1
set guicursor+=n-v-c:blinkwait10

if exists("g:vscode")
	let mapleader = " "
	nnoremap <leader>w <cmd>call VSCodeCall('workbench.action.files.save')<cr>
	nnoremap <silent> <leader><cr> :noh<cr>
	nnoremap <leader>ff  <cmd>call VSCodeNotifyVisual('workbench.action.quickOpen', 1)<CR>
	nnoremap <leader>fg <cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
else
	" KEYBINDINGS
	let mapleader = " "
	map <silent> <leader><cr> :noh<cr>
	nmap <leader>ne :silent! NERDTree<cr>
	nmap <leader>w :w!<cr>
	" telescope
	nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>

	" NERDTree
	let g:NERDTreeNaturalSort = 1
	let g:NERDTreeWinPos = "right"
endif


"Set COLOR THEMES

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
set background=dark
colorscheme gruvbox-material

" set airline theme
" let g:airline_theme = 'nord'

