require'paq' {
    {'savq/paq-nvim'};
    'akinsho/nvim-bufferline.lua';
    'ojroques/nvim-bufdel';
    'norcalli/nvim-colorizer.lua';
    'hrsh7th/cmp-buffer';
    'kdheepak/cmp-latex-symbols';
    'octaltree/cmp-look';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-path';
    'ray-x/cmp-treesitter';
    'hrsh7th/cmp-vsnip';
    'hrsh7th/nvim-cmp';
    {'kristijanhusak/vim-dadbod', branch='async-query', opt=true};
    {'kristijanhusak/vim-dadbod-ui', opt=true};
    'sindrets/diffview.nvim';
    {'mattn/emmet-vim', opt=true};
    'airblade/vim-gitgutter';
    {'rhysd/vim-grammarous', opt=true};
    'glepnir/galaxyline.nvim';
    'SmiteshP/nvim-gps';
    'lukas-reineke/indent-blankline.nvim';
    {"hkupty/iron.nvim", opt=true};
    'b3nj5m1n/kommentary';
    'ggandor/lightspeed.nvim';
    'neovim/nvim-lspconfig';
    'nvim-lua/lsp-status.nvim';
    {'euclio/vim-markdown-composer', run='cargo build --release', opt=true};
    'marko-cerovac/material.nvim';
    {'jbyuki/nabla.nvim', opt=true};
    'TimUntersberger/neogit';
    'ojroques/vim-oscyank';
    {'Vimjas/vim-python-pep8-indent', opt=true};
    -- telescope and its support
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';
    'p00f/nvim-ts-rainbow';
    'folke/todo-comments.nvim';
    'kyazdani42/nvim-tree.lua';
    'nvim-treesitter/nvim-treesitter';
    'nvim-treesitter/nvim-treesitter-refactor';
    'jbyuki/venn.nvim';
    'hrsh7th/vim-vsnip';
    'hrsh7th/vim-vsnip-integ';
    'kyazdani42/nvim-web-devicons';
}

-- general
vim.g.mapleader = ";"  -- seem to be separate from vim mapleader

-- bufferline
require'bufferline'.setup()
vim.api.nvim_set_keymap("n", "<leader>j", "<cmd>BufferLineCycleNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>BufferLineCyclePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>BufferLinePick<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>BufferLinePickClose<CR>", {silent = true, noremap = true})

-- bufdel
require'bufdel'.setup { next = 'cycle' }
vim.api.nvim_set_keymap("n", "qw", ":w\\|BufDel<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "qq", "<cmd>BufDel!<cr>", { silent = true, noremap = true })

-- colorizer
require'colorizer'.setup()

-- colorschemes
vim.g.material_style = "lighter"
vim.cmd[[colorscheme material]]

-- nvim-cmp
local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'vsnip' },
        { name = 'latex_symbols' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'treesitter' },
        { name = 'look', keyword_length=2 },
        { name = 'buffer' },
    }
}

-- kommentary
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

-- neogit
require('neogit').setup{}
require('diffview').setup{}
vim.api.nvim_set_keymap("n", "<F3>", "<cmd>Neogit<cr>", {noremap = true, silent = true})

-- oscyank
vim.g.oscyank_term = 'tmux'
vim.g.oscyank_silent = true
vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]

-- my statusline based on galaxyline
require('statusline')

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
    indent = { enable = true, disable = {"python"}, },
    -- nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 10000,
        colors = {
            "#39ADB5",
            "#FF5370",
            "#6182B8",
            "#F6A434",
            "#91B859",
            "#E53935",
            "#5E8526"
        }
    },
    -- refactor
    refactor = {
        highlight_definitions = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = { smart_rename = "<leader>r", },
        }
    }
}

-- venn
vim.api.nvim_set_keymap("v", "<c-m>", ":'<,'>VBox<cr>", {noremap=true, silent=true})

-- vsnip
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"
vim.api.nvim_set_keymap("i", "<c-n>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<cmd>call compe#complete()<cr>')", {expr = true})
vim.api.nvim_set_keymap("s", "<C-n>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<cmd>call compe#complete()<cr>')", {expr = true})
vim.api.nvim_set_keymap("i", "<C-p>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'", {expr = true})
vim.api.nvim_set_keymap("s", "<C-p>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'", {expr = true})
