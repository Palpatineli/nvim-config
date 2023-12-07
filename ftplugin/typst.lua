vim.opt.spell = true
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<cr>:!typst compile %<cr>", {noremap = true})
