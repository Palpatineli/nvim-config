require("neuron").setup { neuron_dir = os.getenv("HOME") .. "/note" }
vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>lua require'neuron'.enter_link()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zn", "<cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zz", "<cmd>lua require'neuron/telescope'.find_zettels()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zZ", "<cmd>lua require'neuron/telescope'.find_zettels {insert = true}<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zb", "<cmd>lua require'neuron/telescope'.find_backlinks()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zB", "<cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zt", "<cmd>lua require'neuron/telescope'.find_tags()<CR>", {noremap = true})
