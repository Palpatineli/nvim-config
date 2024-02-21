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

local function setup_ast_grep()
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local configs = require'lspconfig.configs'
    local util = require("lspconfig.util")
    if not configs.dart then
        configs.ast_grep = {
            default_config = {
                cmd = {'sg', 'lsp'};
                filetypes = {'typescript'};
                single_file_support = true;
                root_dir = util.root_pattern('.git', 'sgconfig.yml');
            };
        }
    end
    require'lspconfig'.ast_grep.setup{
        capabilities = lsp_capabilities
    }
end

local M = {}
M.setup = function()
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
        'clangd',
        'jsonls',
        'lua_ls',
        'marksman',
        'pyright',
        'rust_analyzer',
        'yamlls',
      }
    })

    for _, server_name in ipairs(get_servers()) do
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end

    setup_ast_grep()

    lspconfig.pyright.setup{
        default_config = {
            capabilities = lsp_capabilities,
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
        capabilities = lsp_capabilities,
        format = {enable = true, singleQuote = true},
        validate = true,
        hover = true,
        completion = true,
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.lua_ls.setup{
        capabilities = lsp_capabilities,
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
