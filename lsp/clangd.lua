local capabilities = vim.lsp.protocol.make_client_capabilities()

local function swich_source_header(bufnr)
    local method_name = 'textDocument/switchSourceHeader'
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
    if not client then
        return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
    end
    local params = vim.lsp.util.make_text_document_params(bufnr)
    client.request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify('corresponding file cannot be determined')
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

return {
    cmd = { 'clangd', "--background-index", "--clang-tidy"},
    filetypes = { 'c', 'cpp' },
    root_markers = { '.clangd', 'compile_commands.json', '.git' },
    capabilities = require'blink.cmp'.get_lsp_capabilities({
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    }),
    on_attach = function(client, bufnr)
        vim.key.set('n', '<F4>', function() swich_source_header(bufnr) end)
    end,
}
