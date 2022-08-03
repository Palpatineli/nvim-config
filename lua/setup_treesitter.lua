local M = {}
M.setup = function()
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main"
        },
    }
    parser_configs.norg_meta = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
            files = { "src/parser.c" },
            branch = "main"
        },
    }
    parser_configs.norg_table = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
            files = { "src/parser.c" },
            branch = "main"
        },
    }
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "c", "css", "dockerfile", "html", "javascript", "json", "lua", "norg",
            "norg_meta", "norg_table", "python", "regex", "rust", "scss", "toml", "typescript", "yaml"},
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
end

return M
