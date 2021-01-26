local repo_path = require("lspconfig/util").root_pattern(".git", "Makefile")(".")
if repo_path == nil or repo_path == "" then
    interpreter_path = '/usr/local/bin/python3'
else
    interpreter_path = repo_path..'/pvenv/bin/python'
end
require('dap-python').setup()

