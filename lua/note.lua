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

return M
