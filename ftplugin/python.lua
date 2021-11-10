-- General
vim.wo.foldnestmax=2

vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<cr>:!python %<cr>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "i", "<F6>", "import pdb; pdb.set_trace()", {noremap = true})

vim.cmd [[
packadd nvim-dap
packadd nvim-dap-python
packadd iron.nvim
]]

-- dap
require('dap-python').setup('~/.venvs/debugpy/bin/python3')
require('dap-python').test_runner = 'pytest'
vim.api.nvim_set_keymap("n", "<leader>df", ":lua require('dap-python').test_method()<cr>", {})

-- vimcmdline
vim.g.iron_map_defaults = false
vim.g.iron_map_extended = false
local iron = require'iron'
iron.core.set_config {
    preferred = {
        python = "ipython",
    },
    repl_open_cmd = 'rightbelow 30 split'
}

vim.api.nvim_buf_set_keymap(0, "n", "<F7>", "<cmd>IronRepl<cr>", {noremap=true})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ir", "<Plug>(iron-send-motion)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ir", "?^##<cr>jV/^##<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>", {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, "v", "<leader>ir", "<Plug>(iron-visual-send)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ip", "<Plug>(iron-repeat-cmd)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader><space>", "<Plug>(iron-send-line)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>i<cr>", "<Plug>(iron-cr)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ii", "<Plug>(iron-interrupt)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>iq", "<Plug>(iron-exit)", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ic", "<Plug>(iron-clear)", {})
