-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })

vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1}) end, {noremap=true, silent=true})
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1}) end, {noremap=true, silent=true})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap=true, silent=true})
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, {noremap=true})
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {noremap=true})

local lsp_dir = vim.fn.stdpath('config') .. '/lsp'
local lsp_servers = {}
for _, f in pairs(vim.fn.readdir(lsp_dir)) do
    table.insert(lsp_servers, vim.fn.fnamemodify(f, ':t:r'))
end
vim.lsp.enable(lsp_servers)
