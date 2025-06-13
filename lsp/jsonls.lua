return {
    cmd = { 'vscode-json-languageserver', '--stdio' },
    filetypes = { 'json', 'jsonc', 'javascript' },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { '.git' },
    capabilities = require'blink.cmp'.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = {"__provenance.json"},
                    url = "~/.templates/schemas/ProvenanceSchema.json",
                }
            }
        }
    },
}
