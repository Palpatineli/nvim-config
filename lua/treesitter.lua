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
            enable = true,
            keymaps = { smart_rename = "<leader>r" },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gd",
                list_definitions = "gD",
                list_definitions_toc = "gO",
                goto_next_usage = "<C-j>",
                goto_previous_usage = "<C-k>"
            }
        }
    }
}
