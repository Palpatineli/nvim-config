return {
    'saghen/blink.cmp', dependencies='rafamadriz/friendly-snippets',
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'super-tab' },
        appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 250, treesitter_highlighting = true,
                window = { border = "rounded" } },
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
}
