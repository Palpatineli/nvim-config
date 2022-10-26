local M = {}
local state = {
    is_picking = false,
    hovered = nil,
    custom_sort = nil,
    current_element_index = nil,
    components = {},
    __components = {},
    visible_components = {},
    left_offset_size = 0,
    right_offset_size = 0,
}
M.get_current_element_index = function(current_state, opts)
  opts = opts or { include_hidden = false }
  local list = opts.include_hidden and current_state.__components or current_state.components
  for index, item in ipairs(list) do
        local element = item:as_element()
        if element and element.id == vim.api.nvim_get_current_buf() then return index, element end
      end
end
M.cycle = function(direction)
    if vim.opt.showtabline == 0 then
        if direction > 0 then vim.cmd("bnext") end
        if direction < 0 then vim.cmd("bprev") end
    end
    local index = M.get_current_element_index(state)
    if not index then return end
    local length = #state.components
    local next_index = index + direction
    if next_index <= length and next_index >= 1 then
        next_index = index + direction
    elseif index + direction <= 0 then
        next_index = length
    else
        next_index = 1
    end
    local item = state.components[next_index]
    if not item then return string.format("This %s does not exist", item.type) end
    vim.api.nvim_set_current_buf(item.id)
end
return M
