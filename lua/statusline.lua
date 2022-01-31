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

    local colors = {
        bg      = '#FAFAFA',
        yellow  = '#F6A434',
        cyan    = '#39ADB5',
        white   = '#FFFFFF',
        green   = '#91B859',
        orange  = '#F76D47',
        purple  = '#7C4DFF',
        magenta = '#FF5370',
        grey    = '#717CB4',
        lightgrey = '#939ED6',
        blue    = '#6182B8',
        red     = '#E53935',
        shade0 = '#EEEEEE',
        shade3 = '#E7E7E8',
        shade4 = '#D8DADB',
        shade6 = '#CFCEC2'
    }

    local theme = {
        normal = {
            a = { fg = colors.bg, bg = colors.green, },
            b = { fg = colors.purple, bg = colors.shade6, },
            c = { fg = colors.lightgrey, bg = colors.bg, },
            },
        insert = {
            a = { fg = colors.bg, bg = colors.yellow },
        },
        visual = {
            a = { fg = colors.bg, bg = colors.blue },
        },
        replace = {
            a = { fg = colors.bg, bg = colors.red },
        },
    }

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
            theme = theme,
            component_separators = { left = '\\', right = '/' },
            section_separators = { left = '', right = '' },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = {'filename'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {
                {
                    'diagnostics', source={'nvim'}, sections={'error'},
                    diagnostics_color={error={fg=colors.red}},
                },
                {
                    'diagnostics', source={'nvim'}, sections={'warn'},
                    diagnostics_color={error={fg=colors.red}},
                },
            },
            lualine_d = {},
            lualine_x = {{gps.get_location, cond=gps.is_available}},
            lualine_y = {search_result, 'filetype'},
            lualine_z = {'location', 'progress'},
        }
    })
end

M.setup = setup_statusline
return M
