-- mapping
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

--- Helix
vim.keymap.set('n', 'gh', '0', {silent=true})
vim.keymap.set('v', 'gh', '0', {silent=true})
vim.keymap.set('n', 'gl', '$', {silent=true})
vim.keymap.set('v', 'gl', '$', {silent=true})
vim.keymap.set('n', 'ge', 'G', {silent=true})
vim.keymap.set('v', 'ge', 'G', {silent=true})
vim.keymap.set('n', 'x', 'V', {silent=true})
vim.keymap.set('v', 'x', 'V', {silent=true})
vim.keymap.set('n', 'd', 'x', {silent=true})
vim.keymap.set('n', '<space>y', '"+y', {})
vim.keymap.set('n', '<space>p', '"+p', {})
vim.keymap.set('n', 'U', '<c-r>', {})
