local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#373e4d',
  yellow = '#ebcb8b',
  cyan = '#88c0d0',
  darkblue = '#e5e9f0',
  green = '#a3be8c',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#b48ead',
  grey = '#4c566a',
  lightgrey = '#3b4252',
  blue = '#81a1c1',
  red = '#bf616a'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left = {
    { ViMode = {
        provider = function()
            local mode_color = {n = colors.green, i = colors.yellow, v = colors.blue, [''] = colors.blue, V = colors.blue, c = colors.green,
            no = colors.magenta, s = colors.orange, S = colors.orange, [''] = colors.orange, ic = colors.yellow, R = colors.red, Rv = colors.red,
            cv = colors.red, ce=colors.red, r = colors.cyan, rm = colors.cyan, ['r?'] = colors.cyan, ['!']  = colors.red, t = colors.red}
            vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
            return '   '
        end,
        separator = ' ',
        separator_highlight = {colors.yellow, colors.grey},
        highlight = {colors.grey, colors.bg, 'bold'},
    }},
    { FileName = { provider = {'FileName'}, condition = buffer_not_empty, separator = ' ', separator_highlight = {colors.blue, colors.lightgrey}, highlight = {colors.darkblue, colors.grey} }},
    { GitIcon = { provider = function() return ' ' end, condition = buffer_not_empty, highlight = {colors.blue, colors.lightgrey} }},
    { GitBranch = { provider = 'GitBranch', separator = ' ', separator_highlight = {colors.blue, colors.lightgrey}, condition = buffer_not_empty, highlight = {colors.cyan, colors.lightgrey} }},
    { DiffAdd = { provider = 'DiffAdd', condition = checkwidth, icon = '  ', highlight = {colors.green, colors.bg} }},
    { DiffModified = { provider = 'DiffModified', condition = checkwidth, icon = '  ', highlight = {colors.blue, colors.bg} }},
    { DiffRemove = { provider = 'DiffRemove', condition = checkwidth, icon = '  ', highlight = {colors.red, colors.bg} }},
    { LeftEnd = { provider = function() return ' ' end, separator = ' ', separator_highlight = {colors.blue, colors.bg}, highlight = {colors.blue, colors.bg} }},
    { DiagnosticError = { provider = 'DiagnosticError', icon = '  ', highlight = {colors.red, colors.bg} }},
    { Space = { provider = function () return '' end }},
    { DiagnosticWarn = { provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.purple, colors.bg} }},
    { DiagnosticHint = { provider = 'DiagnosticHint', icon = '   ', highlight = {colors.blue, colors.bg} }},
    { DiagnosticInfo = { provider = 'DiagnosticInfo', icon = '   ', highlight = {colors.orange, colors.bg} }},
}
gls.right = {
    { FileIcon = { separator = ' ', provider = 'FileIcon', condition = buffer_not_empty, separator_highlight = {colors.blue, colors.bg}, highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg} }},
    { FileType = { provider = 'FileTypeName', separator = ' ', separator_highlight = {colors.bg, colors.bg}, highlight = {colors.darkblue, colors.bg} }},
    { Space2 = { provider = function () return ' ' end, separator = ' ', separator_highlight = {colors.blue, colors.bg}, highlight = {colors.darkblue, colors.bg}}},
    { LineInfo = { provider = 'LineColumn', separator = ' ', separator_highlight = {colors.blue, colors.lightgrey}, highlight = {colors.darkblue, colors.lightgrey} }},
    { Space3 = { provider = function () return ' ' end, separator = ' ', separator_highlight = {colors.blue, colors.lightgrey}, highlight = {colors.darkblue, colors.lightgrey} }},
    { PerCent = { provider = 'LinePercent', separator = ' ', separator_highlight = {colors.blue, colors.grey}, highlight = {colors.darkblue, colors.grey} }},
}
