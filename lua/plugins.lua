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

local setup_lsp_fidget = function()
    require('fidget').setup{ text={spinner='dots' } }
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

local setup_osc = function()
    vim.g.oscyank_term = 'tmux'
    vim.g.oscyank_silent = true
    vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
end

local setup_yanky = function()
    require'yanky'.setup{}
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
    require'telescope'.load_extension('yank_history')
    vim.keymap.set("n", "<leader>y", "<cmd>Telescope yank_history<cr>")
end

local setup_mini = function ()
    local mini_bufremove = require('mini.bufremove')
    mini_bufremove.setup({})
    vim.keymap.set("n", "qw", [[:w<cr>:lua require'mini.bufremove'.wipeout(0)<cr>]], { silent = true, noremap = true })
    vim.keymap.set("n", "qq", function() mini_bufremove.wipeout(0, true) end, { silent = true, noremap = true })
    require'mini.comment'.setup{
        mappings={
            comment='ci',
            textobject='ci'
        }
    }
    -- wait for mini.snippet to switch to mini.completion
    require'mini.cursorword'.setup({})
    require'mini.indentscope'.setup({})
    require'mini.jump'.setup({mappings={forward='f', backward='F', forward_till='', backward_till='', repeat_jump='.'}, delay={highlight=10000000, idle_stop=500}})
    require'mini.pairs'.setup({})
    require'setup_statusline'.miniline()
    require'mini.trailspace'.setup({})
end

local setup_todo_comments = function()
    require("todo-comments").setup({
        keywords={
            DEBUG = {icon=" ", color="warning"}
        }
    })
    vim.keymap.set("n", "<leader>T", ":TodoTelescope<cr>", {})
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'akinsho/bufferline.nvim', config=setup_bufferline}
    use {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end}
    use {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline', requires={'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp', requires={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/cmp-nvim-lsp-signature-help', requires={'hrsh7th/cmp-nvim-lsp'}}
    use {'ray-x/cmp-treesitter', requires={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}}
    use {'hrsh7th/nvim-cmp'}
    use {'L3MON4D3/LuaSnip', config=require'setup_luasnip'.setup}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}}
    use {'Palpatineli/vim-dadbod-ui', requires={'kristijanhusak/vim-dadbod'}, ft={'sql'}, config=setup_dadbod_ui}
    use {'Palpatineli/vim-dadbod-completion', requires={'kristijanhusak/vim-dadbod', 'hrsh7th/nvim-cmp'}, ft={'sql'},
        config=setup_dadbod_comp}
    use {'mfussenegger/nvim-dap', config=setup_dap}
    use {'nvim-telescope/telescope-dap.nvim', requires={'mfussenegger/nvim-dap'}, after='nvim-dap',
        config=setup_dap_telescope}
    use {'mfussenegger/nvim-dap-python', requires={'mfussenegger/nvim-dap'}, after='nvim-dap', ft={'python'},
        config=setup_dap_python}
    use {'rcarriga/cmp-dap', requires={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}, after='nvim-dap'}
    use {'j-hui/fidget.nvim', after={'lsp-zero.nvim'}, config=setup_lsp_fidget}
    use {'lewis6991/gitsigns.nvim', config=function() require'gitsigns'.setup() end}
    use {'SmiteshP/nvim-gps', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'rhysd/vim-grammarous', ft={'markdown'}}
    use {'VonHeikemen/lsp-zero.nvim', after={'mason.nvim', 'mason-lspconfig.nvim', 'nvim-cmp', 'LuaSnip',
        'lspkind-nvim', 'telescope.nvim'}, config=require'setup_lsp'.setup}
    use {'nvim-lualine/lualine.nvim', requires={'SmiteshP/nvim-gps'}, after="everforest",
        config=require('setup_statusline').lua}
    use {"hkupty/iron.nvim", ft={'python'}, config=setup_iron}
    use {'kdheepak/lazygit.nvim', requires={'nvim-telescope/telescope.nvim'}, config=setup_lazygit}
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim', requires={'hrsh7th/nvim-cmp'}}
    use {"williamboman/mason.nvim", config=function() require'mason'.setup() end}
    use {"williamboman/mason-lspconfig.nvim"}
    use {"phaazon/mind.nvim", ft={'markdown'}, config=require'setup_note'.mind, after='plenary.nvim'}
    use {"echasnovski/mini.nvim", config=setup_mini, after='gitsigns.nvim'}
    use {'sainnhe/everforest', config=function() require'colorschemes'.everforest('light', 'hard') end}
    use 'nvim-lua/plenary.nvim'
    use {'ojroques/vim-oscyank', config=setup_osc}
    use {'lcheylus/overlength.nvim', config=function() require'overlength'.setup{default_overlength=120} end}
    use {'Vimjas/vim-python-pep8-indent', ft={'python'}}
    use {'lewis6991/spellsitter.nvim', config=function() require'spellsitter'.setup(); vim.opt.spell = true end}
    use {'simrat39/symbols-outline.nvim', config=
         function() vim.keymap.set("n", "<F9>", ":SymbolsOutline<cr>", {}) end}
    use {'nvim-telescope/telescope.nvim', requires={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config=require'setup_telescope'.setup}
    use {'p00f/nvim-ts-rainbow', requires='nvim-treesitter/nvim-treesitter'}
    use {'B4mbus/todo-comments.nvim', config=setup_todo_comments, requires={'nvim-telescope/telescope.nvim'} }
    use {'nvim-treesitter/nvim-treesitter', config=require'setup_treesitter'.setup}
    use {'nvim-treesitter/nvim-treesitter-refactor', requires={'nvim-treesitter/nvim-treesitter'}}
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', after={'nvim-treesitter'},
        config=require'setup_ufo'.setup}
    use 'mg979/vim-visual-multi'
    use 'kyazdani42/nvim-web-devicons'
    if packer_bootstrap then
        require('packer').sync()
    end
    use {'gbprod/yanky.nvim', after='telescope.nvim', config=setup_yanky}
end)
