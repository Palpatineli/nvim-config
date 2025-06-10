return {
    {'akinsho/bufferline.nvim', config=function()
        local bufferline = require'bufferline'
        bufferline.setup({ options = {
            separator_style = 'slant',
            show_close_icon = false,
            show_buffer_icons = false,
            show_buffer_close_icons = false,
            enforce_regular_tabs = true,
        }})
        vim.keymap.set('n', '<leader>j', function() require'bufferline'.cycle(1) end,
            {silent=true, noremap=true})
        vim.keymap.set('n', '<leader>k', function() require'bufferline'.cycle(-1) end,
            {silent=true, noremap=true})
        vim.keymap.set('n', '<leader>b', require'bufferline.commands'.pick, {silent=true, noremap=true})
    end},
    {'nvim-lualine/lualine.nvim', dependencies={'neanias/everforest'},
        config = function ()
            local trunc = require'core.util'.trunc
            local current_treesitter_context = require'core.util'.current_treesitter_context
            local theme = "everforest"
            local custom_theme = require('lualine.themes.'..theme)
            require('lualine').setup({
                options = {
                    icons_enabled=true,
                    theme = theme,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {
                        {'branch', color={bg=custom_theme.normal.b.fg, fg=custom_theme.normal.b.bg},
                            fmt=trunc(180, 15, 80, false)},
                        'diff',
                        {'filename', file_status=true, path=1, fmt=trunc(180, 15, 80, false)},
                    },
                    lualine_c = {
                        {'diagnostics', source={'nvim_lsp'}, sections={'error', 'warn', 'info'},
                            always_visible=true, symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}}
                    },
                    lualine_x = {{current_treesitter_context, fmt=trunc(180, 35, 80, false)}},
                    lualine_y = {{'filetype', color={bg=custom_theme.normal.b.bg}}},
                    lualine_z = {{'%4l:%3c', color={bg=custom_theme.command.a.bg}}, '%L'},
                }
            })
        end},
}

