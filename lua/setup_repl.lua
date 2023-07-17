local M = {}
M.iron = function()
    local iron = require'iron'
    iron.core.setup {
        config = {
            should_map_plug = false,
            scratch_repl = false,
            buflisted = true,
            repl_definition = {
                python = { command = {'python', '-m', 'IPython'} },
                sh = { command = {"bash"} }
            },
            repl_open_cmd = "botright 40 split"
        },
        keymaps = {
            visual_send = "<leader><space>",
            send_line = "<leader>ir",
            cr = "<leader>i<cr>",
            interrupt = "<leader>ic",
            exit = "<leader>iq"
        }
    }
    vim.keymap.set("n", "<leader><space>",
        "?^# %%<cr>jV/^# %%<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>",
        {noremap = true, silent = true})
end

M.sniprun = function()
    local sniprun = require'sniprun'
    sniprun.setup{
        display = { 'Terminal' },
        display_options = {
            terminal_line_number = false,
            terminal_signcolumn = false,
            terminal_width = 80,
        },
        repl_enable = { 'python' },
    }
    vim.keymap.set('v', '<leader><space>', function() sniprun.run('v') end, {})
    vim.keymap.set("n", "<leader><space>",
        "?^# %%<cr>jV/^# %%<cr>k<esc>:lua require'sniprun'.run('v')<cr>jj:nohl<cr>", {})
end

M.yarepl = function()
    local yarepl = require'yarepl'
    yarepl.setup{
        metas = {
            ipython = { cmd = 'python -m IPython', formatter = yarepl.formatter.bracketed_pasting },
        },
        wincmd = 'belowright 45 split',
    }

    vim.keymap.set('n', '<leader>ir', function() vim.cmd[[REPLStart ipython]] end, {})
    vim.keymap.set('v', '<leader><space>', function() vim.cmd[[REPLSendVisual]] end, {})
    vim.keymap.set("n", "<leader><space>", "?^# %%<cr>jV/^# %%<cr>k<esc>:REPLSendVisual<cr>jj:nohl<cr>", {})
end
return M
