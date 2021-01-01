require'nvim-treesitter.configs'.setup{
    highlight = {
        enable = true,
        disable = { "c", "rust" }
    },
    indent = { enable = false },
    rainbow = {
        enable = true,
        disable = {'bash'}
    },
    refactor = {
        highlight_current_scope = { enable = false },
        highlight_definitions = { enable = false },
        smart_rename = {
            enable = false,
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gd",
                list_definitions = "gD",
                list_definitions_toc = "gO",
            }
        }
    }
}
