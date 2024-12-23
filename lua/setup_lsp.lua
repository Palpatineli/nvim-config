M = {}
M.setup = function()
    local lspconfig = require('lspconfig')
    local blink = require'blink.cmp'
    local get_servers = require('mason-lspconfig').get_installed_servers
    local util = require("lspconfig.util")

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(_)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1}) end, {noremap=true, silent=true})
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1}) end, {noremap=true, silent=true})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap=true, silent=true})
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, {noremap=true})
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {noremap=true})
      end
    })

    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'emmet_language_server',
            'jsonls',
            'lua_ls',
            'marksman',
            'pyright',
            'ruff',
            'rust_analyzer',
            'yamlls',
        },
        automatic_installation = false
    })

    local capabilities = blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
    for _, server_name in ipairs(get_servers()) do
        lspconfig[server_name].setup({ capabilities = capabilities, })
    end

    lspconfig.clangd.setup({ capabilities = capabilities })
    if vim.fn.exists(':ClangdSwitchSourceHeader') then
        vim.keymap.set("n", "<F4>", "<cmd>ClangdSwitchSourceHeader<cr>")
    end

    lspconfig.pyright.setup{
        default_config = {
            root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt",
                "Makefile"),
            settings = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = 'openFileOnly'
                },
                pyright = {useLibraryCodeForTypes = true}
            },
            before_init = function(initialize_params)
                initialize_params["workspaceFolders"] = { {name = "workspace", uri = initialize_params["rootUri"]} }
            end,
        }
    }

    lspconfig.yamlls.setup{
        format = {enable = true, singleQuote = true},
        validate = true,
        hover = true,
        completion = true,
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.lua_ls.setup{
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT', path = runtime_path, },
                diagnostics = { globals = {'vim'}, },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), },
                telemetry = { enable = false, },
            },
        },
    }
end
return M
