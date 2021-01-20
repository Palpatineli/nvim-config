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

--- move diagnostics to quickfix ---
do
  local method = "textDocument/publishDiagnostics"
  local default_callback = vim.lsp.callbacks[method]
  vim.lsp.callbacks[method] = function(err, method, result, client_id)
    default_callback(err, method, result, client_id)
    if result and result.diagnostics then
      for _, v in ipairs(result.diagnostics) do
        v.bufnr = client_id
        v.lnum = v.range.start.line + 1
        v.col = v.range.start.character + 1
        v.text = v.message
      end
      vim.lsp.util.set_qflist(result.diagnostics)
    end
  end
end

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

--- simple ---
local on_attach = function(client)
    vim.api.nvim_command [[ hi LspReferenceText guibg=#247695 ]]
    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    require("completion").on_attach()
    lsp_status.on_attach(client)
end

local on_attach_nohl = function(client)
    vim.api.nvim_command [[ hi LspReferenceText guibg=#247695 ]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    require("completion").on_attach()
    lsp_status.on_attach(client)
end

local servers = {
    "bashls",
    "cssls",
    "jsonls",
    "pyright"
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{on_attach = on_attach}
end

local servers_nohl = {
    "jsonls",
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
    on_attach = on_attach,
    settings = {
        yaml = {format = {enable = true, singleQuote = true}, validate = true}
    }
}
