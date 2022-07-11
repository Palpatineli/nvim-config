vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR>:!gcc -std=c99 -O3 % -o %<<CR>', {noremap=true})
