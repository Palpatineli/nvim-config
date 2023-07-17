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

local setup_osc = function()
    local function copy()
      if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
        require('osc52').copy_register('+')
      end
    end
    vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
end

local setup_bufferline = function()
    local bufferline = require'bufferline'
    bufferline.setup({ options = {
        separator_style = 'slant',
        show_close_icon = false,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        enforce_regular_tabs = true,
    }})
    vim.keymap.set('n', '<leader>j', function() require'bufferline'.cycle(1) end,
        {silent=true, noremap=true})
    vim.keymap.set('n', '<leader>k', function() require'bufferline'.cycle(-1) end,
        {silent=true, noremap=true})
    vim.keymap.set('n', '<leader>b', require'bufferline.commands'.pick, {silent=true, noremap=true})
end

local setup_trouble = function()
    require'trouble'.setup{
        mode = "document_diagnostics"
    }
    vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent=true, noremap=true})
    vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent=true, noremap=true})
end

local setup_comment = function()
    require'Comment'.setup{
        toggler = {
            line = ';cc',
            block = ';bc'
        },
        opleader = {
            line = ';c',
            block = ';b'
        },
        mappings = {
            extra = false
        }
    }
end

local setup_todo_comments = function()
    require("todo-comments").setup({
        keywords={
            DEBUG = {icon=" ", color="warning"}
        }
    })
    vim.keymap.set("n", "<space>T", ":TodoTelescope<cr>", {})
end

local setup_ai = function()
    vim.g.ai_completions_model = "gpt-3.5-turbo"
    vim.g.ai_edits_model = "code-davinci-edit-001"
    vim.g.ai_context_before = 30
    vim.g.ai_context_after = 10
    vim.g.ai_temperature = 0.7
    vim.g.ai_timeout = 20
    vim.keymap.set("i", "<c-c>", [[<cmd>Chat<cr>]], {noremap=true})
end

require('lazy').setup({
    {'stevearc/aerial.nvim', config=function()
        require'aerial'.setup{}
        vim.keymap.set('n', '<F9>', '<cmd>AerialToggle!<CR>')
    end},
    {'akinsho/bufferline.nvim', dependencies={'nvim-tree/nvim-web-devicons'}, config=setup_bufferline},
    {"aduros/ai.vim", commit='921f467', config=setup_ai},
    {"asiryk/auto-hlsearch.nvim", config=true},
    {'hrsh7th/nvim-cmp',
        dependencies={'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 'saadparwaiz1/cmp_luasnip', "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim", "SmiteshP/nvim-navic", 'hrsh7th/cmp-nvim-lsp-signature-help'},
        config=require'setup_lsp'.setup},
    {'numToStr/Comment.nvim', config=setup_comment},
    {'saadparwaiz1/cmp_luasnip', dependencies={'L3MON4D3/LuaSnip'},
        config=require'setup_luasnip'.setup},
    {'mfussenegger/nvim-dap', ft={'python'},
        dependencies={'rcarriga/nvim-dap-ui', 'mfussenegger/nvim-dap-python'},
        config=require'setup_dap'.setup},
    {'LiadOz/nvim-dap-repl-highlights', config=true},
    {'rcarriga/cmp-dap', dependencies={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}},
    {'folke/flash.nvim', event='VeryLazy', keys={
        {'s', mode={'n', 'x', 'o'}, function() require'flash'.jump() end, desc='flash'}
    }, config=true},
    {'sainnhe/everforest', config=function() require'colorschemes'.everforest('light', 'hard') end},
    {'akinsho/git-conflict.nvim', config=true},
    {'f-person/git-blame.nvim'},
    {'lewis6991/gitsigns.nvim', config=true},
    {'RRethy/vim-illuminate'},
    {'Vigemus/iron.nvim', ft={'python'}, config=function() require'setup_repl'.iron() end},
    {'nvim-lualine/lualine.nvim', dependencies={'sainnhe/everforest', 'SmiteshP/nvim-navic'},
        config=function() require'setup_statusline'.lualine('everforest') end},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {"prichrd/netrw.nvim", config=function()
        require'netrw'.setup{mappings ={['p']=function(payload) print(vim.inspect(payload))end}}
    end},
    {'ojroques/nvim-osc52', config=setup_osc},
    {'cameron-wags/rainbow_csv.nvim', ft={'csv', 'tsv'}, config=true,
        cmd={'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim'}},
    {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config=require'setup_telescope'.setup},
    {'folke/todo-comments.nvim', config=setup_todo_comments, dependencies={'nvim-telescope/telescope.nvim'} },
    {'nvim-treesitter/nvim-treesitter', dependencies={'LiadOz/nvim-dap-repl-highlights'},
        config=require'setup_treesitter'.setup},
    {'folke/trouble.nvim', dependencies='nvim-tree/nvim-web-devicons', config=setup_trouble},
    {'kevinhwang91/nvim-ufo', dependencies={'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter'},
        config=require'setup_ufo'.setup},
    'mg979/vim-visual-multi',
})
