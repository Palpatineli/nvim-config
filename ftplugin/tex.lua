vim.bo.spell = true
-- clean the temp folder
vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', ":!rm *.aux *.log *.bbl *.blg<CR>:!echo 'cleared the intermediate files'<CR>", {})
vim.api.nvim_buf_set_keymap(0, 'v', '<c-i>', [[y:'<,'>s/\(<c-r>"\)/{\\it \1}/<CR>]], {noremap=true})
vim.api.nvim_buf_set_keymap(0, 'v', '<c-b>', [[y:'<,'>s/\(<c-r>"\)/{\\bf \1}/<CR>]], {noremap=true})
vim.api.nvim_buf_set_keymap(0, 'v', '<c-u>', [[y:'<,'>s/\(<c-r>"\)/\\underline{\1}/<CR>]], {noremap=true})
