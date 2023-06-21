local M = {}

M.setup_key = function()
    vim.keymap.set("n", "<leader>db", require'dap'.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", require'dap'.continue, {})
    vim.keymap.set("n", "<leader>ds", require'dap'.step_into, {})
    vim.keymap.set("n", "<leader>dn", require'dap'.step_over, {})
    vim.keymap.set("n", "<leader>du", require'dap'.repl.open, {})
    local config_path = os.getenv("HOME") .. '/.vscode/launch.json'
    local open_config = function() vim.cmd('e ' .. config_path) end
    vim.keymap.set("n", "<leader>da", open_config, {})
    require('dap.ext.vscode').load_launchjs(config_path)
end

M.setup_python = function()
    require('dap-python').setup('~/.venvs/debugpy/bin/python3', {})
    require('dap-python').test_runner = 'pytest'
    vim.keymap.set("n", "<leader>df", require('dap-python').test_method, {silent=true})
    vim.keymap.set("n", "<leader>dF", require('dap-python').test_class, {silent=true})
    vim.keymap.set("v", "<leader>DS", require('dap-python').debug_selection, {silent=true})
end


M.setup_ui = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.5
                    }, {
                        id = "breakpoints",
                        size = 0.25
                    }, {
                        id = "stacks",
                        size = 0.25
                    }
                },
                position = 'left',
                size = 80
            }, {
                elements = {
                    {
                        id = "repl",
                        size = 1.0
                    }
                },
                position = 'bottom',
                size = 20
            }
        },
        mappings = {}
    })
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end
return M
