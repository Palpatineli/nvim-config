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
paq 'sjl/gundo.vim'
paq 'lukas-reineke/indent-blankline.nvim'
paq 'neovim/nvim-lspconfig'
paq 'glepnir/lspsaga.nvim'
paq 'nvim-lua/lsp-status.nvim'
paq {'euclio/vim-markdown-composer', run='cargo build --release'}
paq 'TimUntersberger/neogit'
paq 'scrooloose/nerdcommenter'
paq 'kristijanhusak/orgmode.nvim'
paq 'Vimjas/vim-python-pep8-indent'
paq 'goldfeld/vim-seek'
-- telescope and its support
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'luochen1990/rainbow'
paq 'nvim-telescope/telescope.nvim'
paq 'nvim-telescope/telescope-fzf-writer.nvim'
paq 'hrsh7th/vim-vsnip'
paq 'hrsh7th/vim-vsnip-integ'
paq 'roxma/nvim-yarp'
paq 'kyazdani42/nvim-web-devicons'

-- colorschemes
-- paq{'dracula/vim', as='dracula'}
-- paq 'arcticicestudio/nord-vim'
-- paq 'RRethy/nvim-base16'
paq 'marko-cerovac/material.nvim'
vim.g.material_style = "lighter"
require('material').set()
