return {
    {'folke/flash.nvim', event='VeryLazy', keys={
        {'s', mode={'n', 'x', 'o'}, function() require'flash'.jump() end, desc='flash'}
    }, config=true},
    {'folke/snacks.nvim', priority=1000, lazy=false, config=true,
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
            },
            zen = {
            },
        },
        keys = {
            { '<F2>', function() Snacks.explorer() end},
            { '<F3>', function() Snacks.zen() end },
            { "<space>f", function() Snacks.picker.git_files{untracked = true} end, desc = "Find Git Files" },
            { '<space>g', function() Snacks.lazygit() end},
            { "<space>a", function() Snacks.picker.git_grep{ untracked=true } end, desc = "Live Search"},
            { "<space>A", function() Snacks.picker.grep_word{ live=true } end, desc = "Visual selection or word",
                mode = { "n", "x" } },
            { "<space>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<space>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definitions" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementations" },
            { "gr", function() Snacks.picker.lsp_references() end, desc = "Goto References" },
        }
    },
    {'folke/trouble.nvim', dependencies='nvim-tree/nvim-web-devicons', install = { colorscheme = { "catppuccin" } },
        checker = { enabled = true }, config=true,
        keys = {
            {"<space>x", "<cmd>Trouble diagnostics toggle<cr>"},
            {"<space>w", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"},
            {"<space>o", "<cmd>Trouble symbols toggle<cr>"},
            {"<space>l", "<cmd>Trouble lsp toggle<cr>"},
        },
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
}

