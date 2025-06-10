return {
    cmd = { 'ruff', 'server' },
    capabilities = require'blink.cmp'.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    settings = {},
}
