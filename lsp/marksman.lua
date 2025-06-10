local bin_name = 'marksman'
local cmd = { bin_name, 'server' }

return {
    capabilities = require'blink.cmp'.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = cmd,
    filetypes = { 'markdown', 'markdown.mdx' },
    root_markers = { '.marksman.toml', '.git' },
}
