vim.api.nvim_buf_set_keymap(0, 'n', 'tw', ':HdevtoolsType<CR>', {noremap=true})
vim.api.nvim_buf_set_keymap(0, 'n', 'tc', ':HdevtoolsClear<CR>', {noremap=true, silent=true})
vim.api.nvim_buf_set_keymap(0, 'n', 'ti', ':HdevtoolsInfo<CR>', {noremap=true, silent=true})
