require'nvim-treesitter.configs'.setup{
    highlight = {
        enable = true,
        disable = { "c", "rust" }
    },
    indent = { enable = true },
    rainbow = {
        enable = true,
        disable = {'bash'}
    },
    refactor = {
        highlight_current_scope = { enable = false },
        highlight_definitions = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = { smart_rename = "<leader>r" },
        },
        navigation = {
            enable = false,
        }
    }
}
