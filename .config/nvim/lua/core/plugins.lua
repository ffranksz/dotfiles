-- Franklin Souza @frannksz

-----------------------------------------------------
--                 VIM-PLUG SETUP                   --
-----------------------------------------------------
vim.cmd [[
call plug#begin('~/.config/nvim/plugged')

" ===================== UI ===================== "
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'zaldih/themery.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Mofiqul/dracula.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'scottmckendry/cyberdream.nvim'
Plug 'rose-pine/neovim'
Plug 'sainnhe/sonokai'
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'DanilaMihailov/beacon.nvim'
Plug 'wfxr/minimap.vim'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'

" ===================== DASHBOARD ===================== "
Plug 'nvimdev/dashboard-nvim'

" ===================== CORE ===================== "
Plug 'nvim-lua/plenary.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" ===================== TOOLING ===================== "
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'Djancyp/better-comments.nvim'
Plug 'ellisonleao/carbon-now.nvim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'tc50cal/vim-terminal'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'ellisonleao/carbon-now.nvim'

" =======================================================
"                           THEMES
" =======================================================
Plug 'ellisonleao/gruvbox.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'tanvirtin/monokai.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
Plug 'xero/miasma.nvim'
Plug 'comfysage/evergarden'
Plug 'shrikecode/kyotonight.vim'
Plug 'romainl/Apprentice'
Plug 'rose-pine/neovim'
Plug 'scottmckendry/cyberdream.nvim'
Plug 'sho-87/kanagawa-paper.nvim'
Plug 'sainnhe/sonokai'
Plug 'qaptoR-nvim/chocolatier.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'ntk148v/habamax.nvim'

call plug#end()
]]

