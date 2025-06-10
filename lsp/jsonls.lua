return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { '.git' },
    capabilities = require'blink.cmp'.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
