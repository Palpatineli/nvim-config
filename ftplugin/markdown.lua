vim.cmd [[
    packadd vim-grammarous
    packadd vim-markdown-composer
    packadd nabla.nvim
    packadd neuron.nvim
]]

-- vim-markdown-composer
vim.g.markdown_composer_autostart = false

vim.wo.spell = true
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":ComposerStart<CR>", {noremap = true})

-- bold, italic and super/sub-script
vim.api.nvim_buf_set_keymap(0, "v", "<c-b>", "<Esc>`>a**<Esc>`<i**<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-i>", "<Esc>`>a_<Esc>`<i_<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-a-u>", "<Esc>`>a^<Esc>`<i^<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-u>", "<Esc>`>a~<Esc>`<i~<Esc>", {noremap = true})
vim.cmd [["command! SSplit :s/\([\.!?]['"]\?\) /\1\r"]]

-- nabla
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require('nabla').action()<cr>", {noremap = true})

-- neuron
require("neuron").setup { neuron_dir = "~/note" }
vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>lua require'neuron'.enter_link()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zn", "<cmd>lua require'neuron/cmd'.new_edit('~/note')<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zz", "<cmd>lua require'neuron/telescope'.find_zettels()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zZ", "<cmd>lua require'neuron/telescope'.find_zettels {insert = true}<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zb", "<cmd>lua require'neuron/telescope'.find_backlinks()<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zB", "<cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", ";zt", "<cmd>lua require'neuron/telescope'.find_tags()<CR>", {noremap = true})
