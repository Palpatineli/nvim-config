local M = {}
M.setup = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "dap_repl", "dockerfile", "html", "javascript", "json", "lua",
            "markdown", "python", "toml", "yaml"},
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
        indent = { enable = true, },
    }
end

return M
