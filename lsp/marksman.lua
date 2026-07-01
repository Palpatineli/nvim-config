local bin_name = 'marksman'
local cmd = { bin_name, 'server' }

local current_file = vim.api.nvim_buf_get_name(0)
local root_match = vim.fs.find({'.marksman.toml', '.git'}, {path=current_file, upward=true})[1]
local resolved_root = root_match and vim.fs.dirname(root_match) or vim.uv.cwd()
resolved_root = resolved_root:gsub("\\", "/")

return {
    capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = cmd,
    filetypes = { 'markdown', 'markdown.mdx' },
    root_dir = resolved_root,
    root_markers = {'.marksman.toml', '.git'},
}
