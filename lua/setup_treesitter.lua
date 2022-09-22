local M = {}
M.setup = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "c", "css", "dockerfile", "html", "javascript", "json", "lua","markdown",
            "python", "regex", "rust", "scss", "toml", "typescript", "yaml"},
        highlight = { enable = true, },
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
        }
    }
end

return M
