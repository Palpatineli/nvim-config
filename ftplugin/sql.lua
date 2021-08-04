vim.g.dbs = {["aam-macs"] = "sqlserver://bos-dbrnd01.acadian-asset.com:1433"}
vim.cmd [[
    packadd vim-dadbod 
    packadd vim-dadbod-ui
    packadd vim-dadbod-completion
]]

require"compe".setup {
    source = {
        buffer = true,
        calc = true,
        dadbod = true,
    }
}

vim.api.nvim_set_keymap("n", "<F3>", "<cmd>DBUIToggle<cr>", {noremap = true})
