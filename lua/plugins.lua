-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=main", -- latest stable release
        lazyrepo,
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

local setup_conform = function ()
    require'conform'.setup{
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettierd", "prettier" } },
        }
    }
    vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line:len() },
            }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
end

local setup_tmux_navigation = function()
    require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>"
        }
    }
end

local setup_trouble = function()
    require'trouble'.setup{}
    vim.keymap.set("n", "<space>X", "<cmd>Trouble diagnostics toggle<cr>", {silent=true, noremap=true})
    vim.keymap.set("n", "<space>W", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {silent=true, noremap=true})
    vim.keymap.set("n", "<space>O", "<cmd>Trouble symbols toggle<cr>", {silent=true, noremap=true})
    vim.keymap.set("n", "<space>L", "<cmd>Trouble lsp toggle<cr>", {silent=true, noremap=true})
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
    vim.g.ai_context_before = 30
    vim.g.ai_context_after = 10
    vim.g.ai_temperature = 0.7
    vim.g.ai_timeout = 20
    vim.keymap.set("i", "<c-c>", [[<cmd>Chat<cr>]], {noremap=true})
end

local setup_gitlab = function()
    require'dressing'.setup{input={enabled=true}}
    local gitlab = require'gitlab'
    gitlab.setup{}
    vim.keymap.set("n", "<space>lr", gitlab.review)
    vim.keymap.set("n", "<space>ls", gitlab.summary)
    vim.keymap.set("n", "<space>lA", gitlab.approve)
    vim.keymap.set("n", "<space>lR", gitlab.revoke)
    vim.keymap.set("n", "<space>lc", gitlab.create_comment)
    vim.keymap.set("n", "<space>ln", gitlab.create_note)
    vim.keymap.set("n", "<space>ld", gitlab.toggle_discussions)
    vim.keymap.set("n", "<space>laa", gitlab.add_assignee)
    vim.keymap.set("n", "<space>lad", gitlab.delete_assignee)
    vim.keymap.set("n", "<space>lra", gitlab.add_reviewer)
    vim.keymap.set("n", "<space>lrd", gitlab.delete_reviewer)
    vim.keymap.set("n", "<space>lp", gitlab.pipeline)
    vim.keymap.set("n", "<space>lo", gitlab.open_in_browser)
end

require('lazy').setup({
    {'stevearc/aerial.nvim', dependencies={"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
        config=function()
            require'aerial'.setup{}
            vim.keymap.set('n', '<F9>', '<cmd>AerialToggle!<CR>')
        end
    },
    {'akinsho/bufferline.nvim', dependencies={'nvim-tree/nvim-web-devicons'}, config=setup_bufferline},
    {"aduros/ai.vim", commit='921f467', config=setup_ai},
    {'hrsh7th/nvim-cmp',
        dependencies={'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 'saadparwaiz1/cmp_luasnip', "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim", 'hrsh7th/cmp-nvim-lsp-signature-help'},
        config=require'setup_lsp'.setup},
    {'stevearc/conform.nvim', ft={'python'}, config=setup_conform},
    {"williamboman/mason-lspconfig.nvim", dependencies="williamboman/mason.nvim"},
    {'saadparwaiz1/cmp_luasnip', dependencies={'L3MON4D3/LuaSnip'},
        config=require'setup_luasnip'.setup},
    {'mfussenegger/nvim-dap', ft={'python'},
        dependencies={'rcarriga/nvim-dap-ui', 'mfussenegger/nvim-dap-python', 'nvim-neotest/nvim-nio'},
        config=require'setup_dap'.setup},
    {'LiadOz/nvim-dap-repl-highlights', config=true},
    {'rcarriga/cmp-dap', dependencies={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}},
    {'folke/flash.nvim', event='VeryLazy', keys={
        {'s', mode={'n', 'x', 'o'}, function() require'flash'.jump() end, desc='flash'}
    }, config=true},
    {'neanias/everforest-nvim', version=false, lazy=false, priority=1000,
        config=function()
            local theme = require'everforest'
            theme.setup{background='hard'}
            theme.load()
        end},
    {'f-person/git-blame.nvim'},
    {'akinsho/git-conflict.nvim', config=true},
    {'harrisoncramer/gitlab.nvim',
        enabled=function() return vim.fn.executable('go') == 1 end,
        dependencies={'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim', enabled=true,},
        build=function() require'gitlab.server'.build(true) end,
        config=setup_gitlab},
    {'lewis6991/gitsigns.nvim', config=true},
    {'RRethy/vim-illuminate'},
    {'Vigemus/iron.nvim', ft={'python'}, config=function() require'setup_repl'.iron() end},
    {'kdheepak/lazygit.nvim', lazy=true, dependencies={'nvim-lua/plenary.nvim'},
        keys= {{'<space>g', '<cmd>LazyGit<cr>', desc='LazyGit'}}},
    {'nvim-lualine/lualine.nvim', dependencies={'neanias/everforest'},
        config=function() require'setup_statusline'.lualine('everforest') end},
    {'iamcco/markdown-preview.nvim', cmd={ "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" }, build = function() vim.fn["mkdp#util#install"]() end,},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {"prichrd/netrw.nvim", config=function()
        require'netrw'.setup{mappings ={['p']=function(payload) print(vim.inspect(payload))end}}
    end},
    {'ojroques/nvim-osc52', config=setup_osc},
    {'epwalsh/obsidian.nvim', lazy=true, dependencies={'nvim-lua/plenary.nvim'},
        event={
            'BufReadPre '..'/mnt/e/notes/segmentation/**.md',
            'BufNewFile '..'/mnt/e/notes/segmentation/**.md'
        },
        opts={workspaces={{name='work', path='/mnt/e/notes/segmentation'}}}
    },
    {'cameron-wags/rainbow_csv.nvim', ft={'csv', 'tsv'}, config=true,
        cmd={'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim'}},
    {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config=require'setup_telescope'.setup},
    { 'alexghergh/nvim-tmux-navigation', config=setup_tmux_navigation},
    {'folke/todo-comments.nvim', config=setup_todo_comments, dependencies={'nvim-telescope/telescope.nvim'} },
    {'nvim-treesitter/nvim-treesitter', dependencies={'LiadOz/nvim-dap-repl-highlights'},
        config=require'setup_treesitter'.setup},
    {'folke/trouble.nvim', dependencies='nvim-tree/nvim-web-devicons', config=setup_trouble},
    {'chomosuke/typst-preview.nvim', ft='typst', build=function() require'typst-preview'.update() end},
    install = { colorscheme = { "everforest" } },
    checker = { enabled = true },
})
