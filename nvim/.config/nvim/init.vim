" Set basic settings for usability
:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

" PLUGINS
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'jacoborus/tender.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'

call plug#end()

" COLOR THEMES

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme tender

" set airline theme
let g:airline_theme = 'tender'
