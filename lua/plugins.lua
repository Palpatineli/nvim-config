local paq = require'paq-nvim'.paq
paq {'savq/paq-nvim', opt=true}
paq 'akinsho/nvim-bufferline.lua'
paq 'jalvesaq/vimcmdline'
paq 'chrisbra/Colorizer'
paq 'nvim-lua/completion-nvim'
paq 'steelsojka/completion-buffers'
paq 'mattn/emmet-vim'
paq 'tpope/vim-fugitive'
paq 'rhysd/vim-grammarous'
paq 'glepnir/galaxyline.nvim'
paq 'sjl/gundo.vim'
paq 'Yggdroot/indentLine'
paq 'neovim/nvim-lspconfig'
paq 'glepnir/lspsaga.nvim'
paq 'nvim-lua/lsp-status.nvim'
paq {'euclio/vim-markdown-composer', run='cargo build --release'}
paq 'scrooloose/nerdcommenter'
paq 'Vimjas/vim-python-pep8-indent'
paq 'goldfeld/vim-seek'
-- telescope and its support
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'luochen1990/rainbow'
paq 'nvim-telescope/telescope.nvim'
paq 'hrsh7th/vim-vsnip'
paq 'hrsh7th/vim-vsnip-integ'
paq 'roxma/nvim-yarp'
paq 'kyazdani42/nvim-web-devicons'

-- colorschemes
-- paq{'dracula/vim', as='dracula'}
-- paq 'arcticicestudio/nord-vim'
paq 'RRethy/nvim-base16'
local colorscheme = require('base16-colorscheme')
colorscheme.setup('brushtrees')
