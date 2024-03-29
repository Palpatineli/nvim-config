-- general
---- bootstrap packadd somehow not working
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.g.mapleader = ";"  -- seem to be separate from vim mapleader

local setup_dap = function()
    vim.api.nvim_set_keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require'dap'.continue()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>ds", ":lua require'dap'.step_into()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>dn", ":lua require'dap'.step_over()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>du", ":lua require'dap'.repl.open()<cr>", {})
    require('dap.ext.vscode').load_launchjs()
end

local setup_dap_telescope = function()
    vim.api.nvim_set_keymap("n", "<leader>tC", ":Telescope dap commands<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tc", ":Telescope dap configurations<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tb", ":Telescope dap list_breakpoints<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tv", ":Telescope dap variables<cr>", {})
end

local setup_bufferline = function()
    require('bufferline').setup()
    vim.api.nvim_set_keymap("n", "<leader>j", "<cmd>BufferLineCycleNext<CR>", {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>BufferLineCyclePrev<CR>", {silent = true})
    vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>BufferLinePick<CR>", {silent = true, noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>BufferLinePickClose<CR>", {silent = true, noremap = true})
end

local setup_bufdel = function()
    require'bufdel'.setup { next = 'cycle' }
    vim.api.nvim_set_keymap("n", "qw", ":w\\|BufDel<cr>", { silent = true, noremap = true })
    vim.api.nvim_set_keymap("n", "qq", "<cmd>BufDel!<cr>", { silent = true, noremap = true })
end

local setup_cmp = function()
    local cmp = require'cmp'
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
            { name = 'vsnip' },
            { name = 'neorg' },
            { name = 'latex_symbols' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'treesitter' },
            { name = 'look', keyword_length=2 },
            { name = 'buffer' },
        },
        formatting = {
            format = require'lspkind'.cmp_format({with_text = false, maxwidth = 50})
        }
    }
    cmp.setup.cmdline(':', { sources = {{ name = 'cmdline' }}})
    cmp.setup.cmdline('/', { sources = {{ name = 'buffer' }}})
end

local setup_kommentary = function()
    vim.g.kommentary_create_default_mappings = false
    vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
    vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
    vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
    vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})
end

vim.api.nvim_set_keymap("n", "<leader>gv", ":Neorg gtd views<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>gc", ":Neorg gtd capture<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ge", ":Neorg gtd edit<CR>", {})

local setup_neorg = function()
    require('neorg').setup {
        load = {
            ['core.defaults'] = {},
            ['core.gtd.base'] = {
                config ={
                    workspace = 'central',
                    default_lists = { inbox = "inbox.norg" },
                    syntax = { context = "#contexts", start = "#time.start",
                               due = "#time.due", waiting = "#waiting.for", },
                    displayers = { projects = { show_completed_projects = false, show_projects_without_tasks = true }},
                    custom_tag_completion = true
                }
            },
            ['core.norg.concealer'] = {},
            ['core.norg.completion'] = {config = {engine = "nvim-cmp"}},
            ['core.norg.dirman'] = {
                config = {
                    workspaces = {
                        central = "~/Sync/note"
                    }
                }
            },
            ['core.integrations.telescope'] = {},
        },
        hook = function()
             local neorg_callbacks = require('neorg.callbacks')
             neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
                keybinds.map_event_to_mode("norg", {
                    n = {
                        { "<leader>gd", "core.norg.qol.todo_items.todo.task_done" },
                        { "<leader>gu", "core.norg.qol.todo_items.todo.task_undone" },
                        { "<leader>gp", "core.norg.qol.todo_items.todo.task_pending" },
                        { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },
                        { "<leader>gl", "core.integrations.telescope.find_linkable" },
                    },
                    i = {
                        { "<c-l>", "core.integrations.telescope.insert_link" },
                    },
                }, { silent = true, noremap = true })
            end)
        end
    }
end

local setup_treesitter = function()
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main"
        },
    }
    parser_configs.norg_meta = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
            files = { "src/parser.c" },
            branch = "main"
        },
    }
    parser_configs.norg_table = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
            files = { "src/parser.c" },
            branch = "main"
        },
    }
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "c", "css", "dockerfile", "html", "javascript", "json", "lua", "norg",
            "norg_meta", "norg_table", "python", "regex", "rust", "scss", "toml", "typescript", "yaml"},
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = ";tn",
                node_incremental = ";tk",
                node_decremental = ";tj",
                scope_incremental = ";tl"
            },
        },
        indent = { enable = true, disable = {"python"}, },
        -- nvim-ts-rainbow
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 10000,
            colors = {
                "#39ADB5",
                "#FF5370",
                "#6182B8",
                "#F6A434",
                "#91B859",
                "#E53935",
                "#5E8526"
            }
        },
        -- refactor
        refactor = {
            highlight_definitions = { enable = true },
            smart_rename = {
                enable = true,
                keymaps = { smart_rename = "<leader>r", },
            }
        }
    }
end

local setup_vsnip = function()
    vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"
    vim.api.nvim_set_keymap("i", "<c-n>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<cmd>call compe#complete()<cr>')", {expr = true})
    vim.api.nvim_set_keymap("s", "<C-n>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<cmd>call compe#complete()<cr>')", {expr = true})
    vim.api.nvim_set_keymap("i", "<C-p>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'", {expr = true})
    vim.api.nvim_set_keymap("s", "<C-p>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'", {expr = true})
end

local setup_indent_blankline = function()
    vim.cmd [[
        highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine
        highlight IndentEven guifg=NONE guibg=#f0f0f0 gui=nocombine
    ]]
    require'indent_blankline'.setup{
        char = "",
        char_highlight_list = {"IndentOdd", "IndentEven"},
        space_char_highlight_list = {"IndentOdd", "IndentEven"},
        show_trailing_blankline_indent = false,
    }
end

local setup_lsp_fidget = function()
    require('fidget').setup{ text={spinner='dots' } }
end

local setup_diffview = function()
    require'diffview'.setup()
    vim.api.nvim_set_keymap("n", "<F4>", ":DiffviewOpen -uno master<cr>", {silent=true})
    vim.api.nvim_set_keymap("n", "<F5>", ":DiffviewOpen -uno HEAD<cr>", {silent=true})
    vim.api.nvim_set_keymap("n", "<F9>", ":DiffviewClose<cr>", {silent=true})
    vim.api.nvim_set_keymap("n", "<F2>", ":DiffviewToggleFiles<cr>", {silent=true})
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'akinsho/nvim-bufferline.lua', config=setup_bufferline}
    use {'ojroques/nvim-bufdel',
        config=setup_bufdel
    }
    use {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end}
    use {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'octaltree/cmp-look', 'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline', requires={'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp', requires={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}}
    use {'ray-x/cmp-treesitter', requires={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-vsnip',
        requires = {'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ', 'hrsh7th/nvim-cmp'},
        config=setup_vsnip
    }
    use 'hrsh7th/vim-vsnip'
    use {'hrsh7th/vim-vsnip-integ', requires = {'hrsh7th/vim-vsnip'}}
    use {'hrsh7th/nvim-cmp', config=setup_cmp}
    use {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}}
    use {'kristijanhusak/vim-dadbod-ui', ft={'sql'}}
    use {'mfussenegger/nvim-dap', ft={'python'}, config=setup_dap}
    use {'nvim-telescope/telescope-dap.nvim', requires={'mfussenegger/nvim-dap'}, ft={'python'}, config=setup_dap_telescope}
    use {'mfussenegger/nvim-dap-python', requires={'mfussenegger/nvim-dap'}, ft={'python'}}
    use {'sindrets/diffview.nvim', config=setup_diffview}
    use {'mattn/emmet-vim', ft={'html', 'xml', 'svg'}}
    use 'tpope/vim-fugitive'
    use {'SmiteshP/nvim-gps', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'rhysd/vim-grammarous', ft={'markdown'}}
    use {'nvim-lualine/lualine.nvim', requires={'SmiteshP/nvim-gps'}, config=require('statusline').setup}
    use {'lukas-reineke/indent-blankline.nvim', config=setup_indent_blankline}
    use {"hkupty/iron.nvim", ft={'python'}}
    use {'b3nj5m1n/kommentary', config=setup_kommentary}
    use 'ggandor/lightspeed.nvim'
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim', requires={'hrsh7th/nvim-cmp'}}
    use {'j-hui/fidget.nvim', requires={'neovim/nvim-lspconfig'}, config=setup_lsp_fidget}
    use {'euclio/vim-markdown-composer', run='cargo build --release', opt={'markdown'}}
    use {'marko-cerovac/material.nvim',
         config=function()
            vim.g.material_style = "lighter"
            vim.cmd[[colorscheme material]]
        end
    }
    use {'jbyuki/nabla.nvim', ft={'markdown'}}
    use 'nvim-lua/plenary.nvim'
    use 'nvim-neorg/neorg-telescope'
    use {'nvim-neorg/neorg', config=setup_neorg}
    use {'ojroques/vim-oscyank',
        config=function()
            vim.g.oscyank_term = 'tmux'
            vim.g.oscyank_silent = true
            vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
        end
    }
    use {'Vimjas/vim-python-pep8-indent', ft={'python'}}
    use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}}
    use {'p00f/nvim-ts-rainbow', requires='nvim-treesitter/nvim-treesitter'}
    use {'folke/todo-comments.nvim', config=
        function()
            require("todo-comments").setup()
            vim.api.nvim_set_keymap("n", "<leader>T", ":TodoTelescope<cr>", {})
        end,
        requires={'nvim-telescope/telescope.nvim'}
    }
    use {'nvim-treesitter/nvim-treesitter', config=setup_treesitter}
    use {'nvim-treesitter/nvim-treesitter-refactor', requires={'nvim-treesitter/nvim-treesitter'}}
    use 'mg979/vim-visual-multi'
    use 'kyazdani42/nvim-web-devicons'
    if packer_bootstrap then
        require('packer').sync()
    end
end)
