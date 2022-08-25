M = {}
local match_link = function(pattern)
    local qry = string.format("fd -t file -e txt -e md %s %s", pattern:sub(3, -3), vim.g.note_root)
    local f = io.popen(qry)
    local s = f:read("l")
    return s
end

M.follow_link = function()
    local word = string.match(vim.fn.expand("<cWORD>"), "%[%[([A-Za-z0-9_%-]+)%]%]", 1)
    if word == nil then
        error("no link undercursor")
        return
    end
    local file_path = match_link(word)
    if file_path == nil then
        file_path = string.format("%s/%s.txt", vim.g.note_root, word)
    end
    vim.cmd("edit " .. file_path)
end

local grep_file_tag = function()
    local tag = vim.fn.expand('%<')  -- needs the escape as [ is special in telescope
    local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    require("telescope.builtin").grep_string{cwd=root_dir, search=tag}
end

vim.keymap.set('n', '<leader>z', grep_file_tag, {noremap = true})

M.zk = function()
    require'zk'.setup{
        picker='telescope',
    }
end

M.todo = function()
    local todo = require'todotxt-nvim'
    todo.setup{todo_file='~/Sync/note/todo.txt'}
    vim.keymap.set('n', '<leader>to', todo.toggle_task_pane)
    vim.keymap.set('n', '<leader>ta', todo.capture)
end

return M
