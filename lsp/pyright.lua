return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetype = { 'python' },
    root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt", "Makefile" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
    capabilities = require'blink.cmp'.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', function()
            client:exec_cmd({
                command = 'pyright.organizeimports',
                arguments = { vim.uri_from_bufnr(bufnr) },
            })
        end, {
        desc = 'Organize Imports',
    })
}
