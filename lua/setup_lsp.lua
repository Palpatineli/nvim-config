local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local setup_cmp = function()
    local cmp = require'cmp'
    local luasnip = require'luasnip'
    cmp.setup({
        enabled = function ()
            return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require'cmp_dap'.is_dap_buffer()
        end,
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete({}),
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
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'dap' },
            { name = 'path' },
            { name = 'treesitter' },
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

local M = {}
M.setup = function()
    local navic = require'nvim-navic'
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local get_servers = require('mason-lspconfig').get_installed_servers
    local util = require("lspconfig.util")

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {noremap=true, silent=true})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {noremap=true, silent=true})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap=true, silent=true})
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, {noremap=true})
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {noremap=true})
      end
    })

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'jsonls',
        'lua_ls',
        'marksman',
        'pyright',
        'yamlls',
      }
    })


    local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end

    for _, server_name in ipairs(get_servers()) do
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = lsp_capabilities,
        })
    end

    lspconfig.pyright.setup{
        default_config = {
            root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirement.txt",
                "Makefile"),
            settings = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = 'openFileOnly'
                },
                pyright = {useLibraryCodeForTypes = true}
            },
            before_init = function(initialize_params)
                initialize_params["workspaceFolders"] = { {name = "workspace", uri = initialize_params["rootUri"]} }
            end,
        }
    }

    lspconfig.yamlls.setup{
        format = {enable = true, singleQuote = true},
        validate = true,
        hover = true,
        completion = true,
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.lua_ls.setup{
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT', path = runtime_path, },
                diagnostics = { globals = {'vim'}, },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), },
                telemetry = { enable = false, },
            },
        },
    }
    setup_cmp()
end
return M
