local M = {}
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

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local current_treesitter_context = function()
  if not package.loaded["nvim-treesitter"] then
    return " "
  end
  local f = require'nvim-treesitter'.statusline({
    indicator_size = 300,
    type_patterns = {"class", "function", "method"}
  })
  local fun_name = string.format("%s", f) -- convert to string, it may be a empty ts node

  -- print(string.find(fun_name, "vim.NIL"))
  if fun_name == "vim.NIL" then
    return " "
  end
  return " " .. fun_name
end

M.lualine = function(theme)
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
                    bg = custom_theme.normal.c.bg } })
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

    require('lualine').setup {
        options = {
            theme = theme,
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = process_sections {
            lualine_a = { 'mode' },
            lualine_b = {
                { 'branch', color = { bg = custom_theme.normal.b.fg, fg = custom_theme.normal.b.bg },
                    fmt = trunc(180, 15, 80, false) },
                { 'diff', always_visible = true, },
                { 'filename', file_status = true, path = 1, fmt = trunc(180, 15, 80, false) },
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
            lualine_x = { current_treesitter_context, fmt = trunc(180, 35, 80, false) },
            lualine_y = { {'filetype', color={bg=custom_theme.normal.b.bg}} },
            lualine_z = { {'%4l:%3c', color={bg = custom_theme.command.a.bg} }, '%L' },
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
