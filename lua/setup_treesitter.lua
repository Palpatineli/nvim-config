local M = {}
M.setup = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "c", "css", "dap_repl", "dockerfile", "html", "javascript", "json", "lua",
            "markdown", "python", "regex", "rust", "scss", "toml", "typescript", "yaml"},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'markdown' },
        },
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
            query='rainbow-parens',
            strategy=require'ts-rainbow.strategy.global',
        }
    }
end

return M
