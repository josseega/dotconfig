"=================================================================================
"general
"=================================================================================

"syntax on
set ma
set mouse=a
set cursorline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoread
set nobackup
set nowritebackup
set noswapfile
set nu
set foldlevelstart=99
set scrolloff=7
"use y and p with the system clipboard
set clipboard=unnamedplus

"==================================================================================
"plugins
"==================================================================================

call plug#begin('~/.config/nvim/autoload/')

"Colour scheme
" My fave colour schemes:
" dracula/dracula-theme, rakr/vim-one, gosukiwi/vim-atom-dark,
" phanviet/vim-monokai-pro rhysd/vim-color-spring-night arzg/vim-colors-xcode
" kyoz/purify 'jonathanfilip/vim-lucius'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Language packs
Plug 'sheerun/vim-polyglot'

"File browsing
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

"Buffer navigation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Grammar checking because I can't english
Plug 'rhysd/vim-grammarous'

"git diff
Plug 'sindrets/diffview.nvim'


call plug#end()

"key combos
"==============================================================================

set encoding=UTF-8
let mapleader = " "

"==============================================================================
" plugin configs
"==============================================================================
"
"
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

"****************************************************
" Telescope Configs
"****************************************************
"

"****************************************************
"Airline Config
"****************************************************

let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"****************************************************
" Treesitter config
"****************************************************

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


"****************************************************
" Catpuccin
"****************************************************

lua << EOF
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup({
    transparent_background = true

    })
EOF

colorscheme catppuccin

