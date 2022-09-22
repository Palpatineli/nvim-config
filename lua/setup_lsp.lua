local M = {}
M.setup = function()
    local util = require("lspconfig.util")
    local zero = require'lsp-zero'
    local luasnip = require'luasnip'
    local cmp = require'cmp'
    zero.preset('lsp-compe')
    zero.set_preferences{
        set_lsp_keymaps = false
    }
    local keymap = function()
        vim.keymap.set("n", "<Leader>J", vim.diagnostic.goto_next, {noremap=true, silent=true})
        vim.keymap.set("n", "<Leader>K", vim.diagnostic.goto_prev, {noremap=true, silent=true})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap=true, silent=true})
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {noremap=true})
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    zero.on_attach(function(client, bufnr) keymap() end)
    cmp.setup({
        enabled = function ()
            return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require'cmp_dap'.is_dap_buffer()
        end,
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete({}),
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
            { name = 'treesitter' },
            { name = 'buffer', keyword_length = 4},
        },
        formatting = {
            format = require'lspkind'.cmp_format({with_text = false, maxwidth = 50})
        }
    })
    cmp.setup.cmdline(':', { sources = {{ name = 'cmdline' }}})
    cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' }
        },
        {
            { name = 'buffer' }
        })
    })
    zero.ensure_installed{
        "prosemd_lsp", "pyright", "sumneko_lua", "bashls", "cssls", "rust_analyzer", "tsserver", "html", "lemminx",
        "jsonls", "dotls", "vimls", "yamlls"
    }
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    zero.configure('sumneko_lua', {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT', path = runtime_path, },
                diagnostics = { globals = {'vim'}, },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), },
                telemetry = { enable = false, },
            },
        },
    })

    zero.configure('pyright', {
        default_config = {
            root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt", "Makefile"),
            settings = {
                analysis = {autoSearchPaths = true},
                pyright = {useLibraryCodeForTypes = true}
            },
            before_init = function(initialize_params)
                initialize_params["workspaceFolders"] = { {name = "workspace", uri = initialize_params["rootUri"]} }
            end,
        }
    })
    zero.configure('emmet_ls', {filetypes = {'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less'}})
    zero.configure('vimls', {
        init_options = { runtimepath = vim.api.nvim_get_option("runtimepath"), indexes = {gap = 75, count = 5} }
    })
    zero.configure('yamlls', { settings = { yaml = {format = {enable = true, singleQuote = true}, validate = true} } })

    zero.setup()
end
return M
