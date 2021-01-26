require('telescope').load_extension('dap')
local repo_path = require("lspconfig/util").root_pattern(".git", "Makefile")(".")
require('dap-python').setup(repo_path..'/pvenv/bin/python')
