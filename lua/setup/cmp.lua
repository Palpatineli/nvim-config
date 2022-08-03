local M = {}
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.setup = function()
    local luasnip = require'luasnip'
    local cmp = require'cmp'
    cmp.setup {
        enabled = function ()
            return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require'cmp_dap'.is_dap_buffer()
        end,
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
        },
        sources = {
            { name = 'latex_symbols' },
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'dap' },
            { name = 'path' },
            { name = 'neorg' },
            { name = 'treesitter' },
            { name = 'buffer', keyword_length = 4},
        },
        formatting = {
            format = require'lspkind'.cmp_format({with_text = false, maxwidth = 50})
        }
    }
    cmp.setup.cmdline(':', { sources = {{ name = 'cmdline' }}})
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
