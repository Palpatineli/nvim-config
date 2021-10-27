local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")
local lsp_status = require('lsp-status')

lsp_status.register_progress()
local capabilities = require'cmp_nvim_lsp'.update_capabilities(lsp_status.capabilities)

--- general ---
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent = true})

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
        on_attach = lsp_status.on_attach,
        capabilities = capabilities,
    },
}

-- sumneko lua --
local system_name
if vim.fn.has("unix") == 1 then
    system_name = "Linux"
    local runtime_path = vim.split(package.path, ';')
    local sumneko_root_path = os.getenv('HOME')..'/.local/share/lua-language-server'
    local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    require'lspconfig'.sumneko_lua.setup {
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
else
end

--- simple ---
local servers = {
    "bashls",
    "rust_analyzer",
    "angularls",
    "tsserver",
    "html",
    "pyright",
    "jsonls",
    "dotls",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{on_attach = lsp_status.on_attach, capabilities = capabilities}
end

--- vim ---
lspconfig.vimls.setup {
    on_attach = lsp_status.on_attach,
    init_options = {
        runtimepath = vim.api.nvim_get_option("runtimepath"),
        indexes = {gap = 75, count = 5}
    }
}

--- yaml ---
lspconfig.yamlls.setup {
    on_attach = lsp_status.on_attach,
    settings = {
        yaml = {format = {enable = true, singleQuote = true}, validate = true}
    }
}

--- cssls ---
lspconfig.cssls.setup {
    on_attach = lsp_status.on_attach,
    cmd = {"css-language-server", "--stdio"},
}
