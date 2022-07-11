vim.g.tex_fold_enabled = 1
vim.api.nvim_buf_set_keymap(0, 'n', '<F4>', ":w<CR>:!rubber --into=~/Desktop/temp --pdf --warn all %:r<CR>:!okular ~/Desktop/temp/%:t:r.pdf &<CR>", {})
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ":w<CR>:!cd ~/Desktop/temp;R CMD Sweave %:p;rubber --into ~/Desktop/temp --pdf --warn all %:r<CR>:!okular ~/Desktop/temp/%:t:r.pdf &<CR>", {})
