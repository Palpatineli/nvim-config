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
vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.opt.guifont = 'FiraCode NF:h8'
vim.opt.printfont = 'FiraCode NF:h8'
---- substitutions go global by default
vim.opt.gdefault = true
---- program title shows file name
vim.opt.title = true
---- highlight hard tab
vim.opt.list = true
vim.opt.listchars = 'tab:<+'
vim.opt.hlsearch = false
vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess = vim.opt.shortmess + 'c'
-- no message when completion is selected
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.inccommand = 'nosplit'

-- filetypes
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern={"*.md", "*.txt"}, callback=function() vim.bo.filetype = 'markdown' end})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern='*.qml', callback=function() vim.bo.filetype = 'javascript' end}) -- qtquick
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {pattern='*.msc', callback=function() vim.bo.filetype = 'mscgen' end})

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
---- replace word under cursor
vim.keymap.set('n', '<Leader>s', [[:%s/\<<C-r><C-w>\>//<Left>]], {silent=true})
---- Insert date time
vim.cmd[[iab <expr> dts strftime("%F %T")]]
vim.keymap.set('n', '<leader>m', ':message<cr>', {silent=true})

if vim.fn.executable('nvr') == 1 then
    vim.fn.setenv("GIT_EDITOR", "nvr -cc split --remote-wait +'set bufhidden=wipe'")
end

vim.api.nvim_set_hl(0, 'ColorColumn', {bg="magenta"})
vim.fn.matchadd('ColorColumn', [[\%121v]], 120)

require'plugins'