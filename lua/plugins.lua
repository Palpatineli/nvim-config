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

require('lazy').setup({
    {'stevearc/aerial.nvim', dependencies={"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"},
        config=function()
            require'aerial'.setup{}
            vim.keymap.set('n', '<F9>', '<cmd>AerialToggle!<CR>')
        end
    },
    {'saghen/blink.cmp', dependencies='rafamadriz/friendly-snippets',
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'super-tab' },
            appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
            sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
            signature = { enabled = true },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 250, treesitter_highlighting = true, window = { border = "rounded" } },
                list = { selection = { preselect = false, auto_insert = true } },
                ghost_text = { enabled = true },
                menu = {
                    border = "rounded",
                    draw = {
                        columns = {{"label", "label_description", gap = 1}, {"kind"}}
                    }
                },
            },
        },
        opts_extend = { 'sources.default' }
    },
    {'akinsho/bufferline.nvim', config=setup_bufferline},
    {'stevearc/conform.nvim', ft={'python'}, config=setup_conform},
    {"williamboman/mason-lspconfig.nvim", dependencies="williamboman/mason.nvim"},
    {'mfussenegger/nvim-dap', ft={'python'},
        dependencies={'rcarriga/nvim-dap-ui', 'mfussenegger/nvim-dap-python', 'nvim-neotest/nvim-nio'},
        config=require'setup_dap'.setup},
    {'LiadOz/nvim-dap-repl-highlights', config=true},
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
    {'lewis6991/gitsigns.nvim', config=true},
    {'RRethy/vim-illuminate'},
    {'Vigemus/iron.nvim', ft={'python'}, config=function() require'setup_repl'.iron() end},
    {'kdheepak/lazygit.nvim', lazy=true, dependencies={'nvim-lua/plenary.nvim'},
        keys= {{'<space>g', '<cmd>LazyGit<cr>', desc='LazyGit'}}},
    {'tzachar/local-highlight.nvim', config=function () require'local-highlight'.setup{disable_file_types={'markdown'}} end},
    {'neovim/nvim-lspconfig', dependencies={'saghen/blink.cmp'}, config=require'setup_lsp'.setup},
    {'nvim-lualine/lualine.nvim', dependencies={'neanias/everforest'},
        config=function() require'setup_statusline'.lualine('everforest') end},
    {'iamcco/markdown-preview.nvim', cmd={ "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" }, build = function() vim.fn["mkdp#util#install"]() end,},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {"prichrd/netrw.nvim", config=function()
        require'netrw'.setup{mappings ={['p']=function(payload) print(vim.inspect(payload))end}}
    end},
    {'ojroques/nvim-osc52', config=setup_osc},
    {'cameron-wags/rainbow_csv.nvim', ft={'csv', 'tsv'}, config=true,
        cmd={'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim'}},
    {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config=require'setup_telescope'.setup},
    { 'alexghergh/nvim-tmux-navigation', config=setup_tmux_navigation},
    {'folke/todo-comments.nvim', config=setup_todo_comments, dependencies={'nvim-telescope/telescope.nvim'} },
    {'nvim-treesitter/nvim-treesitter', dependencies={'LiadOz/nvim-dap-repl-highlights'},
        config=require'setup_treesitter'.setup},
    {'folke/trouble.nvim', dependencies='nvim-tree/nvim-web-devicons', config=setup_trouble},
    install = { colorscheme = { "everforest" } },
    checker = { enabled = true },
})
