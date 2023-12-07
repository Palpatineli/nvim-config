# vim.bo.cindent = true
vim.bo.cino = 'j1,(0,ws,Ws'
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':wa<CR>:!clang++ % -o %< -Ofast -lstdc++ -std=c++17 -pthread<CR>', {noremap=true})
