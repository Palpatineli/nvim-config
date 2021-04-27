local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
    bg = '#2E3440',
    yellow = '#EBCB8B',
    cyan = '#88C0D0',
    white = '#D8DEE9',
    green = '#A3BE8C',
    orange = '#D5967B',
    purple = '#9B98B7',
    magenta = '#B48EAD',
    grey = '#3B4252',
    lightgrey = '#4C566A',
    blue = '#81A1C1',
    red = '#BF616A',
    shade0 = '#2E3440',
    shade1 = '#3B4252',
    shade2 = '#434C5E',
    shade3 = '#4C566A',
    shade4 = '#D8DEE9',
    shade5 = '#E5E9F0',
    shade6 = '#ECEFF4'
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
local mode_color = {n = colors.green, i = colors.yellow, v = colors.blue, [''] = colors.blue, V = colors.blue, c = colors.green,
no = colors.magenta, s = colors.orange, S = colors.orange, [''] = colors.orange, ic = colors.yellow, R = colors.red, Rv = colors.red,
cv = colors.red, ce=colors.red, r = colors.cyan, rm = colors.cyan, ['r?'] = colors.cyan, ['!']  = colors.red, t = colors.red}

gls.left = {
    { ViMode = {
        provider = function()
            vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
            return '   '
        end,
        separator = ' ',
        separator_highlight = { colors.shade0, colors.shade6},
        highlight = {colors.grey, colors.bg, 'bold'},
    }},
    { FileName = { provider = {'FileName'}, condition = buffer_not_empty, separator = ' ', separator_highlight = {colors.shade6, colors.shade4}, highlight = {colors.blue, colors.shade6} }},
    { GitIcon = { provider = function() return ' ' end, condition = buffer_not_empty, highlight = {colors.magenta, colors.shade4} }},
    { GitBranch = { provider = 'GitBranch', separator = ' ', separator_highlight = {colors.shade4, colors.shade4}, condition = buffer_not_empty, highlight = {colors.magenta, colors.shade4} }},
    { DiffAdd = { provider = 'DiffAdd', condition = checkwidth, icon = '  ', highlight = {colors.green, colors.shade4} }},
    { DiffModified = { provider = 'DiffModified', condition = checkwidth, icon = '  ', highlight = {colors.blue, colors.shade4} }},
    { DiffRemove = { provider = 'DiffRemove', condition = checkwidth, icon = '  ', highlight = {colors.red, colors.shade4} }},
    { GitEnd = { provider = function() return ' ' end, highlight = {colors.shade4, colors.shade3} }},
    { DiagnosticError = { provider = 'DiagnosticError', icon = '  ', highlight = {colors.red, colors.shade3} }},
    { Space = { provider = function () return '' end }},
    { DiagnosticWarn = { provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.purple, colors.shade3} }},
    { DiagnosticHint = { provider = 'DiagnosticHint', icon = '   ', highlight = {colors.blue, colors.shade3} }},
    { DiagnosticInfo = { provider = 'DiagnosticInfo', icon = '   ', highlight = {colors.orange, colors.shade3} }},
    { LeftEnd = { provider = function() return ' ' end, highlight = {colors.shade3, colors.bg} }},
}
gls.right = {
    { RightEnd = { provider = function() return ' ' end, highlight = {colors.shade3, colors.bg} }},
    { FileIcon = { separator = ' ', provider = 'FileIcon', condition = buffer_not_empty, separator_highlight = {colors.shade3, colors.shade3}, highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.shade3} }},
    { FileType = { provider = 'FileTypeName', separator = ' ', separator_highlight = {colors.shade3, colors.shade3}, highlight = {colors.blue, colors.shade3} }},
    { Space2 = { provider = function () return '  ' end, highlight = {colors.shade4, colors.shade3}}},
    { LineInfo = { provider = 'LineColumn', separator = ' ', separator_highlight = {colors.shade4, colors.shade4}, highlight = {colors.purple, colors.shade4} }},
    { PerCent = { provider = 'LinePercent', separator = ' ', separator_highlight = {colors.shade6, colors.shade4}, highlight = {colors.cyan, colors.shade6} }},
}
