local M = {}

M.setup_key = function()
    vim.keymap.set("n", "<leader>db", require'dap'.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", require'dap'.continue, {})
    vim.keymap.set("n", "<leader>ds", require'dap'.step_into, {})
    vim.keymap.set("n", "<leader>dn", require'dap'.step_over, {})
    vim.keymap.set("n", "<leader>du", require'dap'.repl.open, {})
end

M.setup_python = function()
    local dap_python = require'dap-python'
    dap_python.setup()
    dap_python.test_runner = 'pytest'
    vim.keymap.set("n", "<leader>df", dap_python.test_method, {silent=true})
    vim.keymap.set("n", "<leader>dF", dap_python.test_class, {silent=true})
    vim.keymap.set("v", "<leader>DS", dap_python.debug_selection, {silent=true})
end


M.setup_cpp = function ()
    local dap = require'dap'
    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
        name = 'lldb'
    }
    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},

            -- 💀
            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
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
M.setup = function()
    M.setup_key()
    M.setup_python()
    M.setup_cpp()
    M.setup_ui()
    local config_path
    if vim.fn.has('win32') == 1 then
        config_path = os.getenv("UserProfile") .. '\\.vscode\\launch.json'
    else
        config_path = os.getenv("HOME") .. '/.vscode/launch.json'
    end
    local open_config = function() vim.cmd('e ' .. config_path) end
    vim.keymap.set("n", "<leader>da", open_config, {})
    require('dap.ext.vscode').load_launchjs(config_path)
end
return M
