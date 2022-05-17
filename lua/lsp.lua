local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

--- handlers ---
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = false,
        virtual_text = { prefix = "" }
    }
)

vim.fn.sign_define( "LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define( "LspDiagnosticsSignWarning", { text = "", texthl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define( "LspDiagnosticsSignInformation", { text = "", texthl = "LspDiagnosticsSignInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "➤", texthl = "LspDiagnosticsSignHint"})

-- prosemd --
configs.prosemd = {
    default_config = {
        cmd = {"prosemd-lsp", "--stdio"},
        filetypes = {"markdown"},
        root_dir = function(fname)
            return util.find_git_ancestor(fname) or vim.fn.getcwd()
        end,
        settings = {},
        capabilities = capabilities,
    }
}
lspconfig.prosemd.setup{}

-- omnisharp --
local omnisharp_bin
if vim.loop.os_uname().sysname == "Windows_NT" then
    omnisharp_bin = '~/.local/share/omnisharp/OmniSharp.exe'
else
    omnisharp_bin = '~/.local/share/omnisharp/run'
end
lspconfig.omnisharp.setup {
    capabilities = capabilities,
    cmd = {vim.fn.expand(omnisharp_bin), '--languageserver'}
}

--- pyright ---
configs.pyright = {
    default_config = {
        cmd = {"pyright-langserver", "--stdio"},
        filetypes = {"python"},
        root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt", "Makefile"),
        settings = {
            analysis = {autoSearchPaths = true},
            pyright = {useLibraryCodeForTypes = true}
        },
        before_init = function(initialize_params)
            initialize_params["workspaceFolders"] = {
                {name = "workspace", uri = initialize_params["rootUri"]}
            }
        end,
        capabilities = capabilities,
    },
}

-- sumneko lua --
local system_name
if vim.loop.os_uname().sysname == "Windows_NT" then
    lua_langserver_bin = "lua-language-server.exe"
else
    lua_langserver_bin = "lua-language-server"
end
local runtime_path = vim.split(package.path, ';')
local sumneko_root_path = vim.fn.expand('~/.local/share/lua-language-server')
local sumneko_binary = sumneko_root_path.."/bin/"..lua_langserver_bin
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
        settings = {
            Lua = {
            runtime = { version = 'LuaJIT', path = runtime_path, },
            diagnostics = { globals = {'vim'}, },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), },
            telemetry = { enable = false, },
        },
    },
}

--- simple ---
local servers = {
    "bashls",
    "cssls",
    "rust_analyzer",
    -- "angularls",
    "tsserver",
    "html",
    "lemminx",
    "pyright",
    "jsonls",
    "dotls",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{capabilities = capabilities}
end

--- vim ---
lspconfig.vimls.setup {
    capabilities = capabilities,
    init_options = {
        runtimepath = vim.api.nvim_get_option("runtimepath"),
        indexes = {gap = 75, count = 5}
    }
}

--- yaml ---
lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
        yaml = {format = {enable = true, singleQuote = true}, validate = true}
    }
}

--- display ---
vim.api.nvim_set_keymap("n", "<leader>h", "", {callback = vim.lsp.diagnostic.open_float})
vim.api.nvim_set_keymap( 'n', '<Leader>J', '', { noremap = true, silent = true, callback = vim.diagnostic.goto_next })
vim.api.nvim_set_keymap( 'n', '<Leader>K', '', { noremap = true, silent = true, callback = vim.diagnostic.goto_prev })
vim.api.nvim_set_keymap( 'n', 'K', '', { noremap = true, silent = true, callback = vim.lsp.buf.hover })

