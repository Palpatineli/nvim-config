require'speedup'.setup()

-- general
vim.opt.hidden = true
---- set working directory to file directory
vim.opt.autochdir = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- ui
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.background = 'light'
---- substitutions go global by default
vim.opt.gdefault = true
---- program title shows file name
vim.opt.title = true
---- highlight hard tab
vim.opt.list = true
vim.opt.listchars = 'trail:~,tab:>-,nbsp:␣'
vim.opt.hlsearch = false
vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess = vim.opt.shortmess + 'c'
-- no message when completion is selected
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.inccommand = 'nosplit'
vim.opt.clipboard = 'unnamedplus'

if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'win32yank',
        copy = {
            ["+"] = 'win32yank.exe -i --crlf',
            ["*"] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ["+"] = 'win32yank.exe -o --lf',
            ["*"] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
end

-- filetypes
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern={"*.md", "*.txt"}, callback=function() vim.bo.filetype = 'markdown' end})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern={"*.typ"}, callback=function() vim.bo.filetype = 'typst' end})

-- mapping
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'
vim.cmd[[ca w!! w !sudo tee "%"]]
---- Move around between windows
vim.keymap.set('n', '<c-j>', '<c-w>j', {silent=true})
vim.keymap.set('n', '<c-k>', '<c-w>k', {silent=true})
vim.keymap.set('n', '<c-h>', '<c-w>h', {silent=true})
vim.keymap.set('n', '<c-l>', '<c-w>l', {silent=true})
---- Move around in terminal
vim.keymap.set('t', '<c-h>', '<C-\\><C-n><C-w>h', {silent=true})
vim.keymap.set('t', '<c-j>', '<C-\\><C-n><C-w>j', {silent=true})
vim.keymap.set('t', '<c-k>', '<C-\\><C-n><C-w>k', {silent=true})
vim.keymap.set('t', '<c-l>', '<C-\\><C-n><C-w>l', {silent=true})
---- close buffer while keep split
vim.keymap.set('n', 'qq', function() vim.cmd[[bp|bd #]] end, {})
---- replace word under cursor
vim.keymap.set('n', '<leader>e', [[:%s/\<<C-r><C-w>\>//<Left>]], {silent=true})
---- Insert date time
vim.cmd[[iab <expr> dts strftime("%F %T")]]

local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end

-- fold
local function get_custom_foldtxt_suffix(foldstart)
    local fold_suffix_str = string.format(
        "  %s [%s lines]",
        '┉',
        vim.v.foldend - foldstart + 1
    )

    return { fold_suffix_str, "Folded" }
end

local function get_custom_foldtext(foldtxt_suffix, foldstart)
    local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)[1]

    return {
        { line, "Normal" },
        foldtxt_suffix
    }
end

_G.get_foldtext = function()
    local foldstart = vim.v.foldstart
    local ts_foldtxt = vim.treesitter.foldtext()
    local foldtxt_suffix = get_custom_foldtxt_suffix(foldstart)

    if type(ts_foldtxt) == "string" then
        return get_custom_foldtext(foldtxt_suffix, foldstart)
    end

    table.insert(ts_foldtxt, foldtxt_suffix)
    return ts_foldtxt
end

vim.opt.foldtext = "v:lua.get_foldtext()"

require'plugins'
require'helix-mapping'
