vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR> :!mscgen -T svg -i % -o %<.svg<CR>', {})
