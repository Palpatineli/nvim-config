require'speedup'.setup()

-- general
vim.api.nvim_set_option('hidden', true)
---- set working directory to file directory
vim.api.nvim_set_option('autochdir', true)
vim.api.nvim_set_option('number', true)
vim.api.nvim_set_option('relativenumber', true)
vim.api.nvim_set_option('backup', false)
vim.api.nvim_set_option('swapfile', false)
vim.api.nvim_set_option('foldmethod', 'expr')
vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
-- ui
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_set_option('background', 'light')
vim.api.nvim_set_option('guifont', 'FiraCode NF:h8')
vim.api.nvim_set_option('printfont', 'FiraCode NF:h8')
---- substitutions go global by default
vim.api.nvim_set_option('gdefault', true)
---- program title shows file name
vim.api.nvim_set_option('title', true)
---- highlight hard tab
vim.api.nvim_set_option('list', true)
vim.api.nvim_set_option('listchars', 'tab:<+')
vim.api.nvim_set_option('hlsearch', false)
vim.api.nvim_set_option('completeopt', 'menuone,noselect')
vim.opt.shortmess = vim.opt.shortmess + 'c'
-- no message when completion is selected
vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('shiftwidth', 4)
vim.api.nvim_set_option('inccommand', 'nosplit')

-- filetypes
vim.api.nvim_create_autocmd('BufNewFile,BufRead', {pattern='*.md,*.txt', callback=function() vim.bo.filetype = 'markdown' end})
vim.api.nvim_create_autocmd('BufNewFile,BufRead', {pattern='*.qml', callback=function() vim.bo.filetype = 'javascript' end}) -- qtquick
vim.api.nvim_create_autocmd('BufNewFile,BufRead', {pattern='*.msc', callback=function() vim.bo.filetype = 'mscgen' end})

-- mapping
vim.o.mapleader = ';'
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
require'lsp'
