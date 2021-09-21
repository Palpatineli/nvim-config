-- General
vim.wo.foldnestmax=2

vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<cr>:!python %<cr>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "i", "<F6>", "import pdb; pdb.set_trace()", {noremap = true})

-- vimcmdline
vim.cmd [[
packadd vim-python-pep8-indent
packadd vimcmdline
]]

vim.g.cmdline_app = {python='python3 -c "import IPython; IPython.terminal.ipapp.launch_new_instance()" --no-autoindent'}

vim.api.nvim_buf_set_keymap(0, "n", "<F7>", "<cmd>call VimCmdLineStartApp()<cr>", {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, "n", "<F9>", "<cmd>call VimCmdLineQuit('python')<cr>", {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>R", "?^##<cr>jV/^##<cr>k<esc>:call VimCmdLineSendSelection()<cr>jj:nohl<cr>", {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, "v", "<leader>R", "<esc>:call VimCmdLineSendSelection()<cr>", {noremap = true, silent = true})
