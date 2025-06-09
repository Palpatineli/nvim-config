local M = {};
M.setup = function()
    vim.g.loaded_logiPat           = false
    vim.g.loaded_shada_plugin      = true
    vim.g.loaded_remote_plugins    = false
    vim.g.editorconfig             = false
    vim.g.do_filetype_lua          = true
    vim.g.python3_host_prog = '/usr/bin/python'
end
return M
