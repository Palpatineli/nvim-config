-- general
vim.opt.hidden = true
---- set working directory to file directory
vim.opt.autochdir = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.swapfile = false
-- highlight fold
vim.opt.foldtext = ""
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- ui
vim.opt.cmdheight = 0
vim.opt.conceallevel = 1
vim.opt.termguicolors = true
vim.opt.background = 'dark'
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
vim.opt.updatetime = 500

if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'win32yank',
        copy = {
            ["+"] = 'clip.exe',
            ["*"] = 'clip.exe',
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

-- filetypes
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern={"*.md", "*.txt"}, callback=function() vim.bo.filetype = 'markdown' end})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern={"*.typ"}, callback=function() vim.bo.filetype = 'typst' end})

vim.diagnostic.config{
    virtual_text = true,
    float = true,
    virtual_lines = false
}
