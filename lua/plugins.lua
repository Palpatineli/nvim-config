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

require('lazy').setup({
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
    {'akinsho/bufferline.nvim', config=function()
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
    },
    {'stevearc/conform.nvim', ft={'python'}, config=function()
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
    },
    {'hat0uma/csvview.nvim', cmd = {'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle'},
        ---@module "csvview"
        ---@type CsvView.Options
        opts = { }
    },
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
    {'RRethy/vim-illuminate'},
    {'Vigemus/iron.nvim', ft={'python'}, config=function() require'setup_repl'.iron() end},
    {'tzachar/local-highlight.nvim', config=function () require'local-highlight'.setup{disable_file_types={'markdown'}} end},
    {'neovim/nvim-lspconfig', dependencies={'saghen/blink.cmp'}, config=require'setup_lsp'.setup},
    {'nvim-lualine/lualine.nvim', dependencies={'neanias/everforest'},
        config=function() require'setup_statusline'.lualine('everforest') end},
    {'iamcco/markdown-preview.nvim', cmd={ "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" }, build = function() vim.fn["mkdp#util#install"]() end,},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {'ojroques/nvim-osc52', config=function()
        local function copy()
            if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                require('osc52').copy_register('+')
            end
        end
        vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
    end
    },
    {'cameron-wags/rainbow_csv.nvim', ft={'csv', 'tsv'}, config=true,
        cmd={'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim'}},
    {'folke/snacks.nvim', priority=1000, lazy=false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            lazygit = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            ---@class snacks.picker.Config
            picker = {
                enabled = true,
                sources = {
                    explorer = { },
                    todo_comments = { }
                }
            }
        },
        keys = {
            { '<F2>', function() Snacks.explorer() end},
            { "<space>f", function() Snacks.picker.git_files{untracked = true} end, desc = "Find Git Files" },
            { '<space>g', function() Snacks.lazygit() end},
            { "<space>a", function() Snacks.picker.git_grep{ untracked=true } end, desc = "Live Search"},
            { "<space>A", function() Snacks.picker.grep_word{ live=true } end, desc = "Visual selection or word", mode = { "n", "x" } },
            { "<space>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<space>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definitions" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementations" },
            { "gr", function() Snacks.picker.lsp_references() end, desc = "Goto References" },
        }
    },
    { 'alexghergh/nvim-tmux-navigation', config=function()
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
    },
    {'folke/todo-comments.nvim', dependencies={'folke/snacks.nvim'},
        keys = { {"n", "<space>T", function() Snacks.picker.todo_comments() end, desc="TODO" } },
        config = function()
            require("todo-comments").setup({
                keywords={
                    DEBUG = {icon=" ", color="warning"}
                }
            })
        end
    },
    {'nvim-treesitter/nvim-treesitter', dependencies={'LiadOz/nvim-dap-repl-highlights'},
        config=require'setup_treesitter'.setup},
    {'folke/trouble.nvim', dependencies='nvim-tree/nvim-web-devicons', install = { colorscheme = { "everforest" } },
        checker = { enabled = true },
        config=function ()
            require'trouble'.setup{}
            vim.keymap.set("n", "<space>x", "<cmd>Trouble diagnostics toggle<cr>", {silent=true, noremap=true})
            vim.keymap.set("n", "<space>w", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {silent=true, noremap=true})
            vim.keymap.set("n", "<space>o", "<cmd>Trouble symbols toggle<cr>", {silent=true, noremap=true})
            vim.keymap.set("n", "<space>l", "<cmd>Trouble lsp toggle<cr>", {silent=true, noremap=true})
        end,
        specs = {
            "folke/snacks.nvim",
            opts = function(_, opts)
                return vim.tbl_deep_extend("force", opts or {}, {
                    picker = {
                        actions = require("trouble.sources.snacks").actions,
                        win = { input = { keys = { ["<c-t>"] = { "trouble_open", mode = { "n", "i" } } } } }
                    },
                })
            end,
        },
    },
})
