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
vim.keymap.set("n", "<F5>", function() require('nabla').action() end, {noremap = true})

-- note taking
vim.g.note_root = vim.fn.expand("~/note")
vim.api.nvim_buf_set_keymap(0, "n", "<cr>", "", {noremap = true, callback=require'setup/note'.follow_link})

local grep_file_tag = function()
    local tag = vim.fn.expand('%<')  -- needs the escape as [ is special in telescope
    local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    require("telescope.builtin").grep_string{cwd=root_dir, search=tag}
end

vim.keymap.set('n', '<leader>z', grep_file_tag, {noremap = true})
