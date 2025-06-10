local M = {}

function M.current_treesitter_context()
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

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

function M.follow_link()
    if require'obsidian'.util.cursor_on_markdown_link() then
        return '<cmd>ObsidianFollowLink<CR>'
    else
        return 'gf'
    end
end

return M
