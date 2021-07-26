require'paq' {
    {'savq/paq-nvim'};
    'akinsho/nvim-bufferline.lua';
    'jalvesaq/vimcmdline';
    'chrisbra/Colorizer';
    'nvim-lua/completion-nvim';
    'steelsojka/completion-buffers';
    'tpope/vim-dadbod';
    'kristijanhusak/vim-dadbod-ui';
    'kristijanhusak/vim-dadbod-completion';
    'sindrets/diffview.nvim';
    'mattn/emmet-vim';
    'airblade/vim-gitgutter';
    'rhysd/vim-grammarous';
    'glepnir/galaxyline.nvim';
    'lukas-reineke/indent-blankline.nvim';
    'b3nj5m1n/kommentary';
    'ggandor/lightspeed.nvim';
    'neovim/nvim-lspconfig';
    'glepnir/lspsaga.nvim';
    'nvim-lua/lsp-status.nvim';
    {'euclio/vim-markdown-composer', run='cargo build --release'};
    'marko-cerovac/material.nvim';
    'jbyuki/nabla.nvim';
    {'oberblastmeister/neuron.nvim', branch="unstable"};
    'TimUntersberger/neogit';
    'Vimjas/vim-python-pep8-indent';
    -- telescope and its support
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';
    'nvim-telescope/telescope-fzf-writer.nvim';
    'p00f/nvim-ts-rainbow';
    'folke/todo-comments.nvim';
    'kyazdani42/nvim-tree.lua';
    'nvim-treesitter/nvim-treesitter';
    'hrsh7th/vim-vsnip';
    'hrsh7th/vim-vsnip-integ';
    'kyazdani42/nvim-web-devicons';
}

-- general
vim.g.mapleader = ";"

-- vim-markdown-composer
vim.g.markdown_composer_autostart = false

-- colorschemes
-- paq{'dracula/vim', as='dracula'}
-- paq 'arcticicestudio/nord-vim'
-- paq 'RRethy/nvim-base16'
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

-- tree-sitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"bash", "c", "css", "dockerfile", "html", "javascript", "json", "lua", "python", "r", "regex", "rust", "scss", "toml", "typescript", "yaml"},
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = ";tn",
            node_incremental = ";tk",
            node_decremental = ";tj",
            scope_incremental = ";tl"
        },
    },
    indent = { enable = true },
    -- nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 10000
    },
}

