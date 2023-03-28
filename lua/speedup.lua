local M = {};
local set_speedup = function()
    vim.g.loaded_matchit           = false
    vim.g.loaded_logiPat           = false
    vim.g.loaded_tarPlugin         = false
    vim.g.loaded_gzip              = false
    vim.g.loaded_zipPlugin         = false
    vim.g.loaded_2html_plugin      = false
    vim.g.loaded_shada_plugin      = false
    vim.g.loaded_tutor_mode_plugin = false
    vim.g.loaded_remote_plugins    = false
    vim.g.do_filetype_lua          = true
end
M.setup = set_speedup
return M
