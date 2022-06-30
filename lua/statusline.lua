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

    require('lualine').setup({
        options = {
            icons_enabled=true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            globalstatus = true,
        },
        sections = {
            lualine_a = {{ 'buffers', hide_filename_extension = true, buffers_color = {active = {bg = '#575279'}}}
            },
            lualine_b = {'branch', 'diff'},
            lualine_c = {
                {
                    'diagnostics', source={'nvim_lsp'}, sections={'error', 'warn', 'info'},
                    always_visible=true,
                },
            },
            lualine_x = {{gps.get_location, cond=gps.is_available}},
            lualine_y = {'filetype'},
            lualine_z = {'progress'},
        },
    })
end

local count_buffers = function()
    local buflisted = vim.fn.buflisted
    local len = 0
    for buffer = 1, vim.fn.bufnr('$') do
        if buflisted(buffer) == 1 then
            len = buffer
        end
    end
    return len
end

local sign = function(x)
    if x < 0 then return -1
    elseif x > 0 then return 1
    else return 0 end
end

local cycle = function(x)
    if x == 0 then return end
    local index = vim.api.nvim_get_current_buf()
    local bufcount = count_buffers()
    if not index then
        return
    end
    local next_index = index + x
    local step = sign(x)
    while (true) do
        if next_index < 0 or next_index > bufcount then
            next_index = next_index % bufcount
        end
        if next_index == 0 then
            next_index = bufcount
        end
        if vim.fn.buflisted(next_index) == 1 then
            vim.api.nvim_set_current_buf(next_index)
            break
        end
        next_index = next_index + step
    end
end

M.setup = setup_statusline
M.cycle = cycle
return M
