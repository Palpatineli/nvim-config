local util = require('lspconfig/util')
local root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt", "Makefile")(vim.fn.getcwd())
function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

local dap_python = require('dap-python')
if exists(root_dir.."/pyenv/") then
    print("found project root: "..root_dir)
    dap_python.setup(root_dir.."/pyenv/bin/python")
elseif exists(root_dir.."/venv/") then
    dap_python.setup(root_dir.."/venv/bin/python")
else
    dap_python.setup("python")
end
dap_python.test_runner = "pytest"
vim.g.dap_virtual_text = true
