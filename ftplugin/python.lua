-- General
vim.wo.foldnestmax=2
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<cr>:!python %<cr>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "i", "<F6>", "import pdb; pdb.set_trace()", {noremap = true})
