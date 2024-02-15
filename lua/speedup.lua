local M = {};
M.setup = function()
    vim.g.loaded_matchit           = false
    vim.g.loaded_logiPat           = false
    vim.g.loaded_tarPlugin         = false
    vim.g.loaded_gzip              = false
    vim.g.loaded_zipPlugin         = false
    vim.g.loaded_2html_plugin      = false
    vim.g.loaded_shada_plugin      = true
    vim.g.loaded_tutor_mode_plugin = false
    vim.g.loaded_remote_plugins    = false
    vim.g.do_filetype_lua          = true
    vim.g.python3_host_prog = '/usr/bin/python'
end
return M
