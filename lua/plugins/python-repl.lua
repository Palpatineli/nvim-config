return {
    {"geg2102/nvim-python-repl",
    ft = {"python", "lua", "scala"}, 
    config = function()
        require("nvim-python-repl").setup({
            execute_on_send = true,
            vsplit = false,
        })
        vim.keymap.set("v", ";<space>", function() require('nvim-python-repl').send_visual_to_repl() end, { desc = "Send visual selection to REPL"})
        vim.api.nvim_set_keymap("n", ";<space>", "?^# %%<cr>jV/^# %%<cr>k<esc>:lua require('nvim-python-repl').send_visual_to_repl()<cr>jj:nohl<cr>", { desc = "Send section to REPL", noremap = true})
    end},
}
