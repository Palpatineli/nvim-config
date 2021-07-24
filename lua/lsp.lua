local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")
local lsp_status = require('lsp-status')

lsp_status.register_progress()

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
        end
    },
}

-- sumneko lua --
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end
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

--- simple ---
local on_attach = function(client)
    vim.api.nvim_command [[ hi LspReferenceText guibg=#4c566a ]]
    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    require("completion").on_attach()
    lsp_status.on_attach(client)
end

local on_attach_nohl = function(client)
    vim.api.nvim_command [[ hi LspReferenceText guibg=#4c566a ]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    require("completion").on_attach()
    lsp_status.on_attach(client)
end

local servers = {
    "bashls",
    "pyright",
    "rust_analyzer",
    "angularls",
    "tsserver",
    "html",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{on_attach = on_attach}
end

local servers_nohl = {
    "jsonls",
    "dotls",
}
for _, lsp in ipairs(servers_nohl) do
    lspconfig[lsp].setup{on_attach = on_attach_nohl}
end


--- vim ---
lspconfig.vimls.setup {
    on_attach = on_attach,
    init_options = {
        runtimepath = vim.api.nvim_get_option("runtimepath"),
        indexes = {gap = 75, count = 5}
    }
}

--- yaml ---
lspconfig.yamlls.setup {
    on_attach = on_attach_nohl,
    settings = {
        yaml = {format = {enable = true, singleQuote = true}, validate = true}
    }
}

--- cssls ---
lspconfig.cssls.setup {
    on_attach = on_attach,
    cmd = {"css-language-server", "--stdio"},
}
