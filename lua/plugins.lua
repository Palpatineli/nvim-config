-- general
---- bootstrap packadd somehow not working
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local setup_dap = function()
    vim.keymap.set("n", "<leader>db", require'dap'.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", require'dap'.continue, {})
    vim.keymap.set("n", "<leader>ds", require'dap'.step_into, {})
    vim.keymap.set("n", "<leader>dn", require'dap'.step_over, {})
    vim.keymap.set("n", "<leader>du", require'dap'.repl.open, {})
    require('dap.ext.vscode').load_launchjs()
end

local setup_dap_telescope = function()
    vim.keymap.set("n", "<leader>tC", ":Telescope dap commands<cr>", {})
    vim.keymap.set("n", "<leader>tc", ":Telescope dap configurations<cr>", {})
    vim.keymap.set("n", "<leader>tb", ":Telescope dap list_breakpoints<cr>", {})
    vim.keymap.set("n", "<leader>tv", ":Telescope dap variables<cr>", {})
end

local setup_dap_python = function()
    require('dap-python').setup('~/.venvs/debugpy/bin/python3', {})
    require('dap-python').test_runner = 'pytest'
    vim.keymap.set("n", "<leader>df", require('dap-python').test_method, {silent=true})
    vim.keymap.set("n", "<leader>dF", require('dap-python').test_class, {silent=true})
    vim.keymap.set("v", "<leader>DS", require('dap-python').debug_selection, {silent=true})
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
    vim.keymap.set("n", "<leader>ir", "?^##<cr>jV/^##<cr>k<esc>:lua require('iron').core.visual_send()<cr>jj:nohl<cr>", {noremap = true, silent = true})
end

local setup_bufdel = function()
    vim.keymap.set("n", "qw", [[:w<cr>:lua require'bufdelete'.bufwipeout(0)<cr>]], { silent = true, noremap = true })
    vim.keymap.set("n", "qq", function() require'bufdelete'.bufwipeout(0, true) end, { silent = true, noremap = true })
end

local setup_kommentary = function()
    vim.g.kommentary_create_default_mappings = false
    vim.keymap.set("n", "<leader>ci", "<Plug>kommentary_line_increase", {})
    vim.keymap.set("n", "<leader>cd", "<Plug>kommentary_line_decrease", {})
    vim.keymap.set("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
    vim.keymap.set("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})
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
    require'indent_blankline'.setup{
        show_current_context = true,
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
    vim.keymap.set("n", "<F4>", ":DiffviewOpen -uno master<cr>", {silent=true})
    vim.keymap.set("n", "<F5>", ":DiffviewOpen -uno HEAD<cr>", {silent=true})
    vim.keymap.set("n", "<F6>", ":DiffviewClose<cr>", {silent=true})
    vim.keymap.set("n", "<F2>", ":DiffviewToggleFiles<cr>", {silent=true})
end

local setup_lazygit = function()
    vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>", {})
    require'telescope'.load_extension('lazygit')
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
            require'lazygit.utils'.project_root_dir()
        end,
        desc = "reload project root for buffer entry"
    })
    vim.keymap.set("n", "<leader>go", require'telescope'.extensions.lazygit.lazygit, {})
end

local setup_dadbod_ui = function()
    vim.g.dbs = {
        MACS="sqlserver://bos-dbrnd01:1433/MACS",
        MACS_PreProd="sqlserver://bos-dbrnd01:1433/MACS_PreProd"
    }
    vim.keymap.set("n", "<F3>", "<cmd>DBUIToggle<cr>", {silent=true})
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

local setup_bufferline = function ()
    vim.opt.termguicolors = true
    require'bufferline'.setup({
        options = {
            diagnostic = 'nvim_lsp',
            show_buffer_close_icons = false,
            show_close_icon = false,
            enforce_regular_tabs = true,
            separator_style = 'slant'
        }
    })
    vim.keymap.set("n", "<leader>j", "", {noremap=true, silent=true, callback=function() require'bufferline'.cycle(1) end})
    vim.keymap.set("n", "<leader>k", "", {noremap=true, silent=true, callback=function() require'bufferline'.cycle(-1) end})
    vim.keymap.set("n", "<leader>b", "", {noremap=true, silent=true, callback=function() require'bufferline'.pick_buffer() end})
end

local setup_lightspeed = function()
    require'lightspeed'.setup({})
end

local setup_ufo = function()
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = -1
    vim.o.foldenable = true
    local ufo = require'ufo'
    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, {chunkText, hlGroup})
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
    end
    ufo.setup({
        provider_selector = function(bufnr, filetype, buftype) return {'treesitter', 'indent'} end,
        fold_virt_text_handler = handler
    })
end

local setup_osc = function()
    vim.g.oscyank_term = 'tmux'
    vim.g.oscyank_silent = true
    vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'famiu/bufdelete.nvim', config=setup_bufdel }
    use {'akinsho/bufferline.nvim', config=setup_bufferline}
    use {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end}
    use {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline', requires={'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp', requires={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp-signature-help', requires={'hrsh7th/cmp-nvim-lsp'}}
    use {'ray-x/cmp-treesitter', requires={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/nvim-cmp', config=require'setup/cmp'.setup}
    use {'L3MON4D3/LuaSnip', config=require'setup/luasnippets'.setup()}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}}
    use {'Palpatineli/vim-dadbod-ui', requires={'kristijanhusak/vim-dadbod'}, ft={'sql'}, config=setup_dadbod_ui}
    use {'Palpatineli/vim-dadbod-completion', requires={'kristijanhusak/vim-dadbod', 'hrsh7th/nvim-cmp'}, ft={'sql'}, config=setup_dadbod_comp}
    use {'mfussenegger/nvim-dap', config=setup_dap}
    use {'nvim-telescope/telescope-dap.nvim', requires={'mfussenegger/nvim-dap'}, after='nvim-dap', config=setup_dap_telescope}
    use {'mfussenegger/nvim-dap-python', requires={'mfussenegger/nvim-dap'}, after='nvim-dap', ft={'python'}, config=setup_dap_python}
    use {'rcarriga/cmp-dap', requires={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}, after='nvim-dap'}
    use {'sindrets/diffview.nvim', config=setup_diffview}
    use {'j-hui/fidget.nvim', requires={'neovim/nvim-lspconfig'}, config=setup_lsp_fidget}
    use 'tpope/vim-fugitive'
    use {'SmiteshP/nvim-gps', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'rhysd/vim-grammarous', ft={'markdown'}}
    use {'ggandor/lightspeed.nvim', requires={'tpope/vim-repeat'}, config=setup_lightspeed}
    use {'nvim-lualine/lualine.nvim', requires={'SmiteshP/nvim-gps'}, after="nightfox.nvim",
        config=require('setup/statusline').setup}
    use {'lukas-reineke/indent-blankline.nvim', config=setup_indent_blankline}
    use {"hkupty/iron.nvim", ft={'python'}, config=setup_iron}
    use {'b3nj5m1n/kommentary', config=setup_kommentary}
    use {'kdheepak/lazygit.nvim', requires={'nvim-telescope/telescope.nvim'}, config=setup_lazygit}
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim', requires={'hrsh7th/nvim-cmp'}}
    use {'euclio/vim-markdown-composer', run='cargo build --release', opt={'markdown'}}
    use {'EdenEast/nightfox.nvim', config=function() require'setup/colorschemes'.nightfox('dawnfox') end}
    use {'jbyuki/nabla.nvim', ft={'markdown'}}
    use 'nvim-lua/plenary.nvim'
    use 'nvim-neorg/neorg-telescope'
    use {'nvim-neorg/neorg', config=require'setup/note'.neorg}
    use {'ojroques/vim-oscyank', config=setup_osc}
    use {'Vimjas/vim-python-pep8-indent', ft={'python'}}
    use {'lewis6991/spellsitter.nvim', config=function() require'spellsitter'.setup(); vim.opt.spell = true end}
    use {'simrat39/symbols-outline.nvim', config=
         function() vim.keymap.set("n", "<F9>", ":SymbolsOutline<cr>", {}) end}
    use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}}
    use {'p00f/nvim-ts-rainbow', requires='nvim-treesitter/nvim-treesitter'}
    use {'folke/todo-comments.nvim', config=
        function()
            require("todo-comments").setup()
            vim.keymap.set("n", "<leader>T", ":TodoTelescope<cr>", {})
        end,
        requires={'nvim-telescope/telescope.nvim'}
    }
    use {'nvim-treesitter/nvim-treesitter', config=setup_treesitter}
    use {'nvim-treesitter/nvim-treesitter-refactor', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', after={'nvim-treesitter'}, config=setup_ufo}
    use 'mg979/vim-visual-multi'
    use 'kyazdani42/nvim-web-devicons'
    if packer_bootstrap then
        require('packer').sync()
    end
end)
