return {
    'saghen/blink.cmp', dependencies='rafamadriz/friendly-snippets',
    version = '*',
    config = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'super-tab' },
        appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        completion = {
            documentation = {
                auto_show_delay_ms = 250, treesitter_highlighting = true, window = { border = "rounded" }
            },
            menu = { border = "rounded", },
        },
    },
    opts_extend = { 'sources.default' }
}
