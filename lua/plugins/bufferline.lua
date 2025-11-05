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
    {'nvim-lualine/lualine.nvim', dependencies={'catppuccin/nvim'},
        config = function ()
            local trunc = require'core.util'.trunc
            local current_treesitter_context = require'core.util'.current_treesitter_context
            local frappe = require("catppuccin.palettes").get_palette("frappe")
            require('lualine').setup({
                options = {
                    icons_enabled=true,
                    theme = 'catppuccin',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {
                        {'branch', color={bg=frappe.base, fg=frappe.text},
                            fmt=trunc(180, 15, 80, false)},
                        'diff',
                        {'filename', file_status=true, path=1, fmt=trunc(180, 15, 80, false)},
                    },
                    lualine_c = {
                        {'diagnostics', source={'nvim_lsp'}, sections={'error', 'warn', 'info'},
                            always_visible=true, symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}}
                    },
                    lualine_x = {{current_treesitter_context, fmt=trunc(180, 35, 80, false)}},
                    lualine_y = {{'filetype', color={bg=frappe.base}}},
                    lualine_z = {{'%4l:%3c', color={bg=frappe.text}}, '%L'},
                }
            })
        end},
}

