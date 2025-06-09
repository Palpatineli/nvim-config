vim.g.loaded_logiPat           = false
vim.g.loaded_shada_plugin      = true
vim.g.loaded_remote_plugins    = false
vim.g.editorconfig             = false
vim.g.do_filetype_lua          = true
vim.g.python3_host_prog = '/usr/bin/python'

local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
   -- disable lsp watcher. Too slow on linux
   wf._watchfunc = function()
     return function() end
   end
end

