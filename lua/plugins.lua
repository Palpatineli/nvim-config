-- general
---- bootstrap packadd somehow not working
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.g.mapleader = ";"  -- seem to be separate from vim mapleader

local setup_dap = function()
    vim.api.nvim_set_keymap("n", "<leader>db", "", {callback=require'dap'.toggle_breakpoint})
    vim.api.nvim_set_keymap("n", "<leader>dc", "", {callback=require'dap'.continue})
    vim.api.nvim_set_keymap("n", "<leader>ds", "", {callback=require'dap'.step_into})
    vim.api.nvim_set_keymap("n", "<leader>dn", "", {callback=require'dap'.step_over})
    vim.api.nvim_set_keymap("n", "<leader>du", "", {callback=require'dap'.repl.open})
    require('dap.ext.vscode').load_launchjs()
end

local setup_dap_telescope = function()
    vim.api.nvim_set_keymap("n", "<leader>tC", ":Telescope dap commands<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tc", ":Telescope dap configurations<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tb", ":Telescope dap list_breakpoints<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>tv", ":Telescope dap variables<cr>", {})
end

local setup_dap_python = function()
    require('dap-python').setup('~/.venvs/debugpy/bin/python3')
    require('dap-python').test_runner = 'pytest'
    vim.api.nvim_set_keymap("n", "<leader>df", '', {callback=require('dap-python').test_method, silent=true})
    vim.api.nvim_set_keymap("n", "<leader>dF", '', {callback=require('dap-python').test_class, silent=true})
    vim.api.nvim_set_keymap("v", "<leader>DS", '<esc>', {callback=require('dap-python').debug_selection, silent=true})
end

local setup_iron = function()
    local iron = require'iron'
    iron.core.setup {
        config = {
            should_map_plug = false,
            scratch_repl = false,
            buflisted = true,
            repl_definition = {
                python = require'iron.fts.python'.ipython
            },
            repl_open_cmd = "botright 40 split"
        },
        keymaps = {
            visual_send = "<leader><space>",
            send_line = "<leader><space>",
            cr = "<leader>i<cr>",
            interrupt = "<leader>ic",
            exit = "<leader>iq"
        }
    }
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>ir", "?^##<cr>jV/^##<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>", {noremap = true, silent = true})
end

local setup_bufdel = function()
    require'bufdel'.setup { next = 'cycle' }
    vim.api.nvim_set_keymap("n", "qw", ":w\\|BufDel<cr>", { silent = true, noremap = true })
    vim.api.nvim_set_keymap("n", "qq", "<cmd>BufDel!<cr>", { silent = true, noremap = true })
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local setup_cmp = function()
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
            { name = 'luasnip' },
            { name = 'neorg' },
            { name = 'latex_symbols' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'dap' },
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
    cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' }
        },
        {
            { name = 'buffer' }
        })
    })
end

local setup_kommentary = function()
    vim.g.kommentary_create_default_mappings = false
    vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
    vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
    vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
    vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})
end

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
    vim.api.nvim_set_keymap("n", "<leader>gv", ":Neorg gtd views<CR>", {})
    vim.api.nvim_set_keymap("n", "<leader>gc", ":Neorg gtd capture<CR>", {})
    vim.api.nvim_set_keymap("n", "<leader>ge", ":Neorg gtd edit<CR>", {})
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

local setup_indent_blankline = function()
    vim.cmd [[
        highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine
        highlight IndentEven guifg=NONE guibg=#fcf1f0 gui=nocombine
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
    vim.api.nvim_set_keymap("n", "<F6>", ":DiffviewClose<cr>", {silent=true})
    vim.api.nvim_set_keymap("n", "<F2>", ":DiffviewToggleFiles<cr>", {silent=true})
end

local setup_lazygit = function()
    vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<cr>', {})
    require'telescope'.load_extension('lazygit')
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
            require'lazygit.utils'.project_root_dir()
        end,
        desc = "reload project root for buffer entry"
    })
    vim.api.nvim_set_keymap('n', '<leader>go', "", {callback=require'telescope'.extensions.lazygit.lazygit})
end

local setup_dadbod_ui = function()
    vim.g.dbs = {
        MACS="sqlserver://bos-dbrnd01:1433/MACS",
        MACS_PreProd="sqlserver://bos-dbrnd01:1433/MACS_PreProd"
    }
    vim.api.nvim_set_keymap('n', '<F3>', '<cmd>DBUIToggle<cr>', {silent=true})
end

local setup_dadbod_comp = function()
    vim.api.nvim_create_autocmd("FileType", {pattern={"sql", "mysql", "plsql"},
        callback = function()
            require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
        end})
    vim.g.completion_chain_complete_list = { sql = { {complete_items = {'vim-dadbod-completion'}}, }, }
    vim.g.completion_matching_strategy_list = {'exact', 'substring'}
    vim.g.completion_matching_ignore_case = 1
    vim.g.vim_dadbod_completion_mark = ''
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'ojroques/nvim-bufdel',
        config=setup_bufdel
    }
    use {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end}
    use {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'octaltree/cmp-look', 'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline', requires={'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp', requires={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp-signature-help', requires={'hrsh7th/cmp-nvim-lsp'}}
    use {'ray-x/cmp-treesitter', requires={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/nvim-cmp', config=setup_cmp}
    use {'L3MON4D3/LuaSnip', config=function() require'luasnippets'.setup() end}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}}
    use {'Palpatineli/vim-dadbod-ui', requires={'kristijanhusak/vim-dadbod'}, ft={'sql'}, config=setup_dadbod_ui}
    use {'Palpatineli/vim-dadbod-completion', requires={'kristijanhusak/vim-dadbod', 'hrsh7th/nvim-cmp'}, ft={'sql'}, config=setup_dadbod_comp}
    use {'mfussenegger/nvim-dap', config=setup_dap}
    use {'nvim-telescope/telescope-dap.nvim', requires={'mfussenegger/nvim-dap'}, after='nvim-dap', config=setup_dap_telescope}
    use {'mfussenegger/nvim-dap-python', requires={'mfussenegger/nvim-dap'}, after='nvim-dap', ft={'python'}, config=setup_dap_python}
    use {'rcarriga/cmp-dap', requires={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}, after='nvim-dap'}
    use {'sindrets/diffview.nvim', config=setup_diffview}
    use {'mattn/emmet-vim', ft={'html', 'xml', 'svg'}}
    use {'j-hui/fidget.nvim', requires={'neovim/nvim-lspconfig'}, config=setup_lsp_fidget}
    use 'tpope/vim-fugitive'
    use {'SmiteshP/nvim-gps', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'rhysd/vim-grammarous', ft={'markdown'}}
    use {'nvim-lualine/lualine.nvim', requires={'SmiteshP/nvim-gps', "EdenEast/nightfox.nvim"}, config=require('statusline').setup}
    use {'lukas-reineke/indent-blankline.nvim', config=setup_indent_blankline}
    use {"hkupty/iron.nvim", ft={'python'}, config=setup_iron}
    use {'b3nj5m1n/kommentary', config=setup_kommentary}
    use {'kdheepak/lazygit.nvim', requires={'nvim-telescope/telescope.nvim'}, config=setup_lazygit}
    use 'ggandor/lightspeed.nvim'
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim', requires={'hrsh7th/nvim-cmp'}}
    use {'euclio/vim-markdown-composer', run='cargo build --release', opt={'markdown'}}
    use {"EdenEast/nightfox.nvim",
         config=function()
            vim.g.material_style = "lighter"
            vim.cmd[[colorscheme dawnfox]]
        end
    }
    use {'mvllow/modes.nvim',
        config=function()
            vim.opt.cursorline = true
            require('modes').setup()
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
    use {'lewis6991/spellsitter.nvim', config=function() require'spellsitter'.setup(); vim.opt.spell = true end}
    use {'simrat39/symbols-outline.nvim', config=
         function() vim.api.nvim_set_keymap('n', '<F9>', ':SymbolsOutline<cr>', {}) end}
    use {'sunjon/shade.nvim', config=function() require'shade'.setup() end}
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
