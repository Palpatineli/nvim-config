-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local setup_aerial = function()
    require'aerial'.setup{
    }
    vim.keymap.set('n', '<F9>', '<cmd>AerialToggle!<CR>')
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
                python = require'iron.fts.python'.ipython,
                sh = { command = {"bash"} }
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
    require('fidget').setup{ text={spinner='dots' }, window={blend=0} }
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

local setup_osc = function()
    vim.g.oscyank_term = 'tmux'
    vim.g.oscyank_silent = true
    vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
end

local setup_barbar = function()
    local api = require'bufferline.api'  -- this is a barbar module, not that of the plugin bufferline
    vim.keymap.set('n', '<leader>j', function() api.goto_buffer_relative(1) end, {silent=true, noremap=true})
    vim.keymap.set('n', '<leader>k', function() api.goto_buffer_relative(-1) end, {silent=true, noremap=true})
    vim.keymap.set('n', '<leader>b', api.pick_buffer, {silent=true, noremap=true})
end

local setup_trouble = function()
    require'trouble'.setup{
        mode = "document_diagnostics"
    }
    vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent=true, noremap=true})
    vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent=true, noremap=true})
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

local setup_overlength = function()
    require'overlength'.setup({
        default_overlength=120,
        textwidth_mode=0,
        bg='#E59E9F',
        disable_ft={ 'qf', 'help', 'man', 'packer', 'NvimTree', 'Telescope', 'WhichKey', 'lazygit', 'lazy', 'mason', 'ipython'}
    })
end

require('lazy').setup({
    {'stevearc/aerial.nvim', config=setup_aerial},
    {'romgrk/barbar.nvim', dependencies={'kyazdani42/nvim-web-devicons'}, config=setup_barbar},
    {'norcalli/nvim-colorizer.lua', config=function() require('colorizer').setup() end},
    {'hrsh7th/cmp-buffer', 'kdheepak/cmp-latex-symbols', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', dependencies={'hrsh7th/nvim-cmp'}},
    {'hrsh7th/cmp-nvim-lsp', dependencies={'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp'}},
    {'hrsh7th/cmp-nvim-lsp-signature-help', dependencies={'hrsh7th/cmp-nvim-lsp'}},
    {'ray-x/cmp-treesitter', dependencies={'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp'}},
    'hrsh7th/nvim-cmp',
    {'L3MON4D3/LuaSnip', config=require'setup_luasnip'.setup},
    {'saadparwaiz1/cmp_luasnip'},
    {'kristijanhusak/vim-dadbod', branch='async-query', ft={'sql'}},
    {'Palpatineli/vim-dadbod-ui', dependencies={'kristijanhusak/vim-dadbod'}, ft={'sql'}, config=setup_dadbod_ui},
    {'Palpatineli/vim-dadbod-completion', dependencies={'kristijanhusak/vim-dadbod', 'hrsh7th/nvim-cmp'}, ft={'sql'}, config=setup_dadbod_comp},
    {'mfussenegger/nvim-dap', config=setup_dap},
    {'nvim-telescope/telescope-dap.nvim', dependencies={'mfussenegger/nvim-dap'}, config=setup_dap_telescope},
    {'mfussenegger/nvim-dap-python', dependencies={'mfussenegger/nvim-dap'}, ft={'python'}, config=setup_dap_python},
    {'rcarriga/cmp-dap', dependencies={'mfussenegger/nvim-dap', 'hrsh7th/nvim-cmp'}},
    {'sindrets/diffview.nvim', dependencies={'nvim-lua/plenary.nvim'}},
    {'j-hui/fidget.nvim', dependencies={'VonHeikemen/lsp-zero.nvim'}, config=setup_lsp_fidget},
    {'lewis6991/gitsigns.nvim', config=function() require'gitsigns'.setup() end},
    {'SmiteshP/nvim-gps', dependencies={'nvim-treesitter/nvim-treesitter'}},
    {'rhysd/vim-grammarous', ft={'markdown'}},
    {"asiryk/auto-hlsearch.nvim", config=function() require'auto-hlsearch'.setup() end},
    {'VonHeikemen/lsp-zero.nvim', dependencies={'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip', 'onsails/lspkind-nvim', 'nvim-telescope/telescope.nvim'}, config=require'setup_lsp'.setup},
    {"hkupty/iron.nvim", ft={'python'}, config=setup_iron},
    {'kdheepak/lazygit.nvim', dependencies={'nvim-telescope/telescope.nvim'}, config=setup_lazygit},
    'neovim/nvim-lspconfig',
    {'onsails/lspkind-nvim', dependencies={'hrsh7th/nvim-cmp'}},
    {'nvim-lualine/lualine.nvim', dependencies={'sainnhe/everforest'},
        config=function() require'setup_statusline'.lualine_power('everforest') end},
    {"williamboman/mason.nvim", config=function() require'mason'.setup() end},
    {"williamboman/mason-lspconfig.nvim"},
    {"echasnovski/mini.nvim", config=setup_mini, dependencies={'lewis6991/gitsigns.nvim', 'nvim-telescope/telescope.nvim'}},
    'nvim-lua/plenary.nvim',
    {'epwalsh/obsidian.nvim', tag='v1.6.0', dependencies={'nvim-telescope/telescope-dap.nvim'}, config=function() require'setup_note'.obsidian() end},
    {'ojroques/vim-oscyank', config=setup_osc},
    {'sainnhe/everforest', config=function() require'colorschemes'.everforest('light', 'hard') end},
    {'lcheylus/overlength.nvim', config=setup_overlength},
    {'Vimjas/vim-python-pep8-indent', ft={'python'}},
    {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}, config=require'setup_telescope'.setup},
    {'mrjones2014/nvim-ts-rainbow', dependencies='nvim-treesitter/nvim-treesitter'},
    {'folke/todo-comments.nvim', config=setup_todo_comments, dependencies={'nvim-telescope/telescope.nvim'} },
    {'nvim-treesitter/nvim-treesitter', config=require'setup_treesitter'.setup},
    {'folke/trouble.nvim', dependencies='kyazdani42/nvim-web-devicons', config=setup_trouble},
    {'kevinhwang91/nvim-ufo', dependencies={'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter'}, config=require'setup_ufo'.setup},
    'mg979/vim-visual-multi',
    'kyazdani42/nvim-web-devicons'
})
