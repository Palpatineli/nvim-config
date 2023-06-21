-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=main", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local setup_iron = function()
    local iron = require'iron'
    iron.core.setup {
        config = {
            should_map_plug = false,
            scratch_repl = false,
            buflisted = true,
            repl_definition = {
                python = require'iron.fts.python'.ipython,
                sh = { command = {"bash"} }
            },
            repl_open_cmd = "botright 40 split"
        },
        keymaps = {
            visual_send = "<leader><space>",
            send_line = "<leader><space>",
            cr = "<leader>i<cr>",
            interrupt = "<leader>ic",
            exit = "<leader>iq"
        }
    }
    vim.keymap.set("n", "<leader>ir", "?^##<cr>jV/^##<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>",
        {noremap = true, silent = true})
end

local setup_osc = function()
    local function copy()
      if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
        require('osc52').copy_register('+')
      end
    end
    vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
end

require('lazy').setup({
    {'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
        dependencies={'hrsh7th/nvim-cmp'}, config=require'setup_cmp'.setup},
    {'hrsh7th/cmp-nvim-lsp',
        dependencies={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp', "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"}, config=require'setup_lsp'.setup},
    {"hkupty/iron.nvim", ft={'python'}, config=setup_iron},
    {'ojroques/nvim-osc52', config=setup_osc},
    {'sainnhe/everforest', config=function()
        vim.opt.background = 'light'
        vim.g.everforest_background = 'hard'
        vim.g.everforest_better_performance = 1
        vim.cmd[[colorscheme everforest]]
    end},
    {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config=require'setup_telescope'.setup},
    {'nvim-treesitter/nvim-treesitter', config=function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {"bash", "json", "lua", "markdown", "python", "toml", "yaml"},
            highlight = { enable = true },
            autopairs = { enable = true },
            indent = { enable = true, },
        }
    end},
})
