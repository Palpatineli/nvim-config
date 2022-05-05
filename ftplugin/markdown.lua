-- vim-markdown-composer
vim.g.markdown_composer_autostart = false

vim.wo.spell = true
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":ComposerStart<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", "<F6>", ":!cat % | pulldown-cmark -TSFLP > %<.html<cr>", {noremap = true})

-- bold, italic and super/sub-script
vim.api.nvim_buf_set_keymap(0, "v", "<c-b>", "<Esc>`>a**<Esc>`<i**<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-i>", "<Esc>`>a_<Esc>`<i_<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-a-u>", "<Esc>`>a^<Esc>`<i^<Esc>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "v", "<c-u>", "<Esc>`>a~<Esc>`<i~<Esc>", {noremap = true})
vim.cmd [["command! SSplit :s/\([\.!?]['"]\?\) /\1\r"]]

-- nabla
vim.api.nvim_set_keymap("n", "<F5>", "", {noremap = true, callback = require('nabla').action})

-- note taking
vim.g.note_root = vim.fn.expand("~/note")
vim.api.nvim_buf_set_keymap(0, "n", "<cr>", "", {noremap = true, callback=require'note'.follow_link})
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua require("telescope").extensions.fzf_writer.staged_grep()<cr>\\[\\[' .. vim.fn.expand('%<') .. '\\]\\]', {noremap = true})
