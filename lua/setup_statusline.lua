local M = {}
local setup_gps = function()
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
    return gps
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

M.cycle = function(x)
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

M.lualine = function()
    local gps = setup_gps()
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
            lualine_x = {{gps.get_location, cond=gps.is_available}},
            lualine_y = {'filetype'},
            lualine_z = {'progress'},
        },
    })
end

M.miniline = function()
    local gps = setup_gps()
    local mini = require'mini.statusline'
    local mini_active = function ()
        local git = mini.section_git({ trunc_width = 25 })
        local diagnostics = mini.section_diagnostics({ trunc_width = 25 })
        local filename = mini.section_filename({ trunc_width = 15 })
        local fileinfo = mini.section_fileinfo({ trunc_width = 10 })
        local location = mini.section_location({ trunc_width = 25 })
        local _, mode_hl = mini.section_mode({ trunc_width = 120 })
        return mini.combine_groups({
            {hl=mode_hl, strings={ filename }},
            '%<',
            {hl='MiniStatuslineFilename', strings={git, ' | ', diagnostics}},
            '%=',
            {strings={gps.get_location(), ' | '}},
            {hl='MiniStatuslineDevInfo', strings={fileinfo}},
            {hl=mode_hl, strings={location}},
        })
    end
    local mini_inactive = function ()
        local git = mini.section_git({ trunc_width = 25 })
        local filename = mini.section_filename({ trunc_width = 25 })
        local fileinfo = mini.section_fileinfo({ trunc_width = 10 })
        return mini.combine_groups({
            {hl='MiniStatuslineInactive', strings={ filename }},
            '%<',
            {hl='FoldColumn', strings={git}},
            '%=',
            {hl='FoldColumn', strings={fileinfo}},
        })
    end
    mini.setup({
        content = {active=mini_active, inactive=mini_inactive},
        set_vim_settings=false,
    })
end
return M
