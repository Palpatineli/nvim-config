return {
    {"Vigemus/iron.nvim",
    ft = {"python", "lua", "scala"}, 
    config = function()
        local iron = require'iron.core'
        local view = require'iron.view'
        local common = require'iron.fts.common'
        iron.setup{
            config={
                scratch_repl = true,
                repl_definition = {
                    python = {
                        command = {'ipython', '--no-autoindent'},
                        format = common.bracketed_paste_python,
                        block_dividers = { "# %%", "#%%" },
                        env = {PYTHON_BASIC_REPL = "1"} --this is needed for python3.13 and up.
                    }
                },
                repl_filetype = function(bufnr, ft) return ft end,
                dap_integration = true,
                repl_open_cmd = view.split.botright(40),
            },
            keymaps = {
                visual_send = ";<space>",
                send_code_block_and_move = ";<space>"
            },
            highlight = {italic = true},
            ignore_blank_lines = true,
        }
    end},
}
