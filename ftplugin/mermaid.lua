vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR>:!mmdc -i % -o %<.svg --iconPacks=@iconify-json/carbon<CR>', {noremap=true})
