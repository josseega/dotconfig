"=================================================================================
"general
"=================================================================================

syntax enable

let g:python3_host_prog = '/usr/bin/python3'

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
"set foldlevelstart=99
set scrolloff=7
"use y and p with the system clipboard
set clipboard=unnamedplus

setlocal spell
set spelllang=en_gb,es_mx
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

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

Plug 'nvim-telescope/telescope-fzy-native.nvim'
"Plug 'nvim-telescope/telescope-file-browser.nvim'

"Buffer navigation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Grammar checking because I can't english
Plug 'rhysd/vim-grammarous'

"git diff
Plug 'sindrets/diffview.nvim'

" To use LaTeX

Plug 'lervag/vimtex'


" To see colors while editing
Plug 'gko/vim-coloresque'

"
" UltiSnips

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'


" Autocompletion deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Folding
"
Plug 'matze/vim-tex-fold'


call plug#end()

"==============================================================================
"key combos
"==============================================================================

"****************************************************
" General config
"****************************************************
set encoding=UTF-8
let mapleader = " "

" Mapings for the inkscape figures

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Tab navigation

nnoremap <C-n> <cmd>tabnew<cr>
nnoremap <C-t> <cmd>tabn<cr>


"****************************************************
" Telescope Maps
"****************************************************

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>



"****************************************************
" Snips Maps
"****************************************************
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"date

"****************************************************
" Vimtex Maps
"****************************************************

let maplocalleader = ","

nnoremap <leader>tt <cmd>VimtexTocToggle<cr>

" Error window do not open automatically
let g:vimtex_quickfix_mode = 0

set conceallevel=1
let g:tex_conceal='abdmg'

"==============================================================================
" plugin configs
"==============================================================================
"
"
"****************************************************
" Vimtex Config
"****************************************************

filetype plugin indent on


let g:vimtex_view_method = 'zathura'

"****************************************************
" DEoplete config
"****************************************************

let g:deoplete#enable_at_startup = 1

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

"****************************************************
" UltiSnips Config
"
"****************************************************
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"****************************************************
" Telescope Configs
"****************************************************
"

lua << EOF

local sorters, actions, previewers =
  require('telescope.sorters'), require('telescope.actions'), require('telescope.previewers')

-- Setup Telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = ' ❯',
    file_ignore_patterns = { '.git/*'},
    color_devicons = true,
    shorten_path= true,
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<Esc>'] = actions.close,
      },
    },
  },
  pickers = {
    find_files = { 
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
      },
  },  
  extensions = {
    -- Fast, fast, really fast sorter
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

-- Load Telescope extensions
require('telescope').load_extension('fzy_native')


EOF


"****************************************************
"Airline Config
"****************************************************

let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"****************************************************
" Treesitter config
"****************************************************

"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()


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

