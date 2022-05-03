local M = {}
local setup_statusline = function()
    local gps = require("nvim-gps")
    gps.setup({
        icons = {
            ["class-name"] = ' ',      -- Classes and class-like objects
            ["function-name"] = ' ',   -- Functions
            ["method-name"] = ' '      -- Methods (functions inside class-like objects)
        },
        languages = {                    -- You can disable any language individually here
            ["c"] = true,
            ["cpp"] = true,
            ["go"] = true,
            ["java"] = true,
            ["javascript"] = true,
            ["lua"] = true,
            ["python"] = true,
            ["rust"] = true,
        },
        separator = ' > ',
    })

    local search_result = function()
      if vim.v.hlsearch == 0 then
        return ''
      end
      local last_search = vim.fn.getreg('/')
      if not last_search or last_search == '' then
        return ''
      end
      local searchcount = vim.fn.searchcount({ maxcount = 9999 })
      return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    require('lualine').setup({
        options = {
            icons_enabled=true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            globalstatus = true,
        },
        sections = {
            lualine_a = {'filename'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {
                {
                    'diagnostics', source={'nvim_lsp'}, sections={'error', 'warn', 'info'},
                    always_visible=true,
                },
            },
            lualine_x = {{
                'buffers',
                hide_filename_extension = true,
                buffers_color = {
                    active= {bg = '#907aa9', fg='#faf4ed'},
                    inactive = {fg = '#618774'}},
            }},
            lualine_y = {{gps.get_location, cond=gps.is_available}, 'filetype'},
            lualine_z = {'progress'},
        },
    })
end

local setup_keymap = function()
    vim.api.nvim_set_keymap('n', '<leader>1', ":LualineBuffersJump 1<cr>", {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>2', ":LualineBuffersJump 2<cr>", {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>3', ":LualineBuffersJump 3<cr>", {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>4', ":LualineBuffersJump 4<cr>", {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>5', ":LualineBuffersJump 5<cr>", {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>6', ":LualineBuffersJump 6<cr>", {silent=true})
end

setup_keymap()
M.setup = setup_statusline
return M
