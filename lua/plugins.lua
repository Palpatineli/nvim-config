local paq = require'paq-nvim'.paq
paq {'savq/paq-nvim', opt=true}
paq 'akinsho/nvim-bufferline.lua'
paq 'jalvesaq/vimcmdline'
paq 'chrisbra/Colorizer'
paq 'nvim-lua/completion-nvim'
paq 'steelsojka/completion-buffers'
paq 'tpope/vim-dadbod'
paq 'kristijanhusak/vim-dadbod-ui'
paq 'kristijanhusak/vim-dadbod-completion'
paq 'sindrets/diffview.nvim'
paq 'mattn/emmet-vim'
paq 'airblade/vim-gitgutter'
paq 'rhysd/vim-grammarous'
paq 'glepnir/galaxyline.nvim'
paq 'lukas-reineke/indent-blankline.nvim'
paq 'b3nj5m1n/kommentary'
paq 'ggandor/lightspeed.nvim'
paq 'neovim/nvim-lspconfig'
paq 'glepnir/lspsaga.nvim'
paq 'nvim-lua/lsp-status.nvim'
paq {'euclio/vim-markdown-composer', run='cargo build --release'}
paq 'jbyuki/nabla.nvim'
paq 'TimUntersberger/neogit'
paq 'Vimjas/vim-python-pep8-indent'
-- telescope and its support
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'luochen1990/rainbow'
paq 'nvim-telescope/telescope.nvim'
paq 'nvim-telescope/telescope-fzf-writer.nvim'
paq 'folke/todo-comments.nvim'
paq 'kyazdani42/nvim-tree.lua'
paq 'hrsh7th/vim-vsnip'
paq 'hrsh7th/vim-vsnip-integ'
paq 'kyazdani42/nvim-web-devicons'

-- general
vim.g.mapleader = ";"

-- colorschemes
-- paq{'dracula/vim', as='dracula'}
-- paq 'arcticicestudio/nord-vim'
-- paq 'RRethy/nvim-base16'
paq 'marko-cerovac/material.nvim'
vim.g.material_style = "lighter"
require('material').set()

-- kommentary
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

-- todo-comments
require("todo-comments").setup()
vim.api.nvim_set_keymap("n", "<leader>T", ":TodoTelescope<cr>", {})

-- nvim-tree
vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<cr>", {})
