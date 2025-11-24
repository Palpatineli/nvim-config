return {
    {'Vigemus/iron.nvim', ft={'python'},
        opts={
            config = {
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
        },
        keys = { {
            "<leader><space>", "?^# %%<cr>jV/^# %%<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>"
        } }
    },
}
