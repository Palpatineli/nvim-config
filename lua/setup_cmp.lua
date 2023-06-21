local M = {}
M.setup = function()
    local cmp = require'cmp'
    local luasnip = require'luasnip'
    cmp.setup({
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer', keyword_length = 4},
        }
    })
    cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' }
        },
        {
            { name = 'buffer' }
        })
    })
end
return M
