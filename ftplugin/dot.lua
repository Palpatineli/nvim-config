-- output as png files
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR> :!dot -Tsvg % -o %<.svg <CR>', {noremap=true})
vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', ':w<CR> :!neato -Tsvg % -o %<.svg <CR>', {noremap=true})
vim.api.nvim_buf_set_keymap(0, 'n', '<F7>', ':w<CR> :!sfdp -Tsvg % -o %<.svg <CR>', {noremap=true})
