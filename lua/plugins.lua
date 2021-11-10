-- general
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
end

local setup_kommentary = function()
    vim.g.kommentary_create_default_mappings = false
    vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
    vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
    vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
    vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})
end

local setup_treesitter = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"bash", "c", "css", "dockerfile", "html", "javascript", "json", "lua", "python", "r", "regex", "rust", "scss", "toml", "typescript", "yaml"},
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

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'akinsho/nvim-bufferline.lua', config=setup_bufferline}
    use {'ojroques/nvim-bufdel',
        config=setup_bufdel
    }
    use {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end}
    use {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'octaltree/cmp-look', 'hrsh7th/cmp-path', requires={'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp', requires={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}}
    use {'ray-x/cmp-treesitter', requires={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-vsnip',
        requires = {'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ', 'hrsh7th/nvim-cmp'},
        config=setup_vsnip
    }
    use {'hrsh7th/nvim-cmp', config=setup_cmp}
    use {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}}
    use {'kristijanhusak/vim-dadbod-ui', ft={'sql'}}
    use {'mfussenegger/nvim-dap', ft={'python'}, config=setup_dap}
    use {'nvim-telescope/telescope-dap.nvim', requires={'mfussenegger/nvim-dap'}, ft={'python'}, config=setup_dap_telescope}
    use {'mfussenegger/nvim-dap-python', requires={'mfussenegger/nvim-dap'}, ft={'python'}}
    use {'sindrets/diffview.nvim', config=function() require('diffview').setup() end}
    use {'mattn/emmet-vim', ft={'html', 'xml', 'svg'}}
    use 'tpope/vim-fugitive'
    use {'SmiteshP/nvim-gps', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'rhysd/vim-grammarous', ft={'markdown'}}
    use {'glepnir/galaxyline.nvim', requires={'SmiteshP/nvim-gps'}, config=require('statusline').setup}
    use 'lukas-reineke/indent-blankline.nvim'
    use {"hkupty/iron.nvim", ft={'python'}}
    use {'b3nj5m1n/kommentary', config=setup_kommentary}
    use 'ggandor/lightspeed.nvim'
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim', requires={'hrsh7th/nvim-cmp'}}
    use 'nvim-lua/lsp-status.nvim'
    use {'euclio/vim-markdown-composer', run='cargo build --release', opt={'markdown'}}
    use {'marko-cerovac/material.nvim',
         config=function()
            vim.g.material_style = "lighter"
            vim.cmd[[colorscheme material]]
        end
    }
    use {'jbyuki/nabla.nvim', ft={'markdown'}}
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
end)
