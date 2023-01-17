vim.o.expandtab = false
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR>:!make -f %<CR>', {noremap=true})
