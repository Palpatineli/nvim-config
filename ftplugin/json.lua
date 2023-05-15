vim.keymap.set('n', '<F5>', function() vim.lsp.buf.formatting() end, {noremap=true, silent=true})

local add_comma = function()
    local line = vim.api.nvim_get_current_line()
    local should_add_comma = string.find(line, '[^,{[]$')
    if should_add_comma then
        return 'A,<cr>'
    else
        return 'o'
    end
end

vim.keymap.set('n', 'o', add_comma, {buffer=true, expr=true})
