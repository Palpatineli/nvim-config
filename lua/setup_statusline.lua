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

M.lualine = function(theme)
    local gps = setup_gps()
    require('lualine').setup({
        options = {
            icons_enabled=true,
            theme = theme,
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
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        }
    })
end

M.lualine_power = function(theme)
    local custom_theme = require('lualine.themes.'..theme)
    local empty = require('lualine.component'):extend()
    function empty:draw(default_highlight)
      self.status = ''
      self.applied_separator = ''
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
          table.insert(section, pos * 2, { empty, color = { fg = custom_theme.normal.a.fg,
                    bg = custom_theme.normal.a.fg } })
        end
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = '' } or { left = '' }
        end
      end
      return sections
    end

    local navic = require'nvim-navic'
    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = process_sections {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'error' },
            diagnostics_color = { error = { bg = custom_theme.visual.a.bg, fg = custom_theme.normal.a.fg } },
          },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'warn' },
            diagnostics_color = { warn = { bg = custom_theme.replace.a.bg, fg = custom_theme.normal.a.fg } },
          },
          { 'filename', file_status = true, path = 1 },
          {
            '%w',
            cond = function()
              return vim.wo.previewwindow
            end,
          },
          {
            '%r',
            cond = function()
              return vim.bo.readonly
            end,
          },
          {
            '%q',
            cond = function()
              return vim.bo.buftype == 'quickfix'
            end,
          },
        },
        lualine_c = {},
        lualine_x = { 'navic' },
        lualine_y = { {'filetype', color={bg=custom_theme.normal.b.bg}} },
        lualine_z = { {'%l:%c', color={bg = custom_theme.command.a.bg} }, '%p%%/%L' },
      },
      inactive_sections = {
        lualine_c = { '%f %y %m' },
        lualine_x = {},
      },
    }
end

M.miniline = function()
    local gps = setup_gps()
    local mini = require'mini.statusline'
    local mini_active = function ()
        local git = mini.section_git({ trunc_width = 100 })
        local diagnostics = mini.section_diagnostics({ trunc_width = 100 })
        local filename = mini.section_filename({ trunc_width = 250 })
        local fileinfo = mini.section_fileinfo({ trunc_width = 200 })
        local location = mini.section_location({ trunc_width = 100 })
        local _, mode_hl = mini.section_mode({ trunc_width = 120 })
        return mini.combine_groups({
            {hl=mode_hl, strings={ filename }},
            '%<',
            {hl='Todo', strings={git}},
            {hl='WinBarNC', strings={diagnostics}},
            '%=',
            {hl='WinBarNC', strings={gps.get_location()}},
            {hl='Todo', strings={fileinfo}},
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
            {hl='Folded', strings={git}},
            '%=',
            {hl='Folded', strings={fileinfo}},
        })
    end
    mini.setup({
        content = {active=mini_active, inactive=mini_inactive}
    })
end
return M
