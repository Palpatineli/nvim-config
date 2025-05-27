-- Combined fold expression function
function CombinedFoldExpr(lnum)
    local line = vim.fn.getline(lnum)
    local ts_fold = vim.api.nvim_eval("nvim_treesitter#foldexpr()")

    -- Base fold level from Tree-sitter
    local base_level = 0
    if ts_fold == ">1" then
        base_level = 1
    elseif ts_fold == ">2" then
        base_level = 2
    elseif ts_fold == ">3" then
        base_level = 3
    elseif ts_fold == "<1" then
        base_level = 0
    elseif ts_fold == "<2" then
        base_level = 1
    elseif ts_fold == "<3" then
        base_level = 2
    else
        base_level = vim.fn.foldlevel(lnum - 1)
    end

    -- Add one level for '# %%' marker
    if string.match(line, "^# %%") then
        return ">" .. (base_level + 1)
    end

    -- End the marker fold level before the next '# %%'
    local nextline = vim.fn.getline(lnum + 1)
    if string.match(nextline, "^# %%") then
        return "<" .. base_level
    end

    -- Otherwise, return Tree-sitter's fold level or maintain current level
    return ts_fold
end

_G.CombinedFoldExpr = CombinedFoldExpr
vim.opt.foldtext = ""
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.CombinedFoldExpr(v:lnum)'
