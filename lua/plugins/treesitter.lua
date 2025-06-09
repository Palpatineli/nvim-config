return {{
    'nvim-treesitter/nvim-treesitter', dependencies={'LiadOz/nvim-dap-repl-highlights'},
    build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = {"bash", "dockerfile", "html", "javascript", "json", "lua",
            "markdown", "python", "toml", "yaml"},
        fold = { enable = true },
        indent = { enable = true, },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'markdown' },
        },
        autopairs = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = ";tn",
                node_incremental = ";tk",
                node_decremental = ";tj",
                scope_incremental = ";tl"
            },
        },
    }
}}
