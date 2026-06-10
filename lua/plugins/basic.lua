return {
    {'norcalli/nvim-colorizer.lua'},
    {'hat0uma/csvview.nvim', cmd = {'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle'}, },
    {'LiadOz/nvim-dap-repl-highlights'},
    { "catppuccin/nvim", name='catppuccin', config=function()
        require'catppuccin'.setup{flavour='frappe'}
        vim.cmd.colorscheme('catppuccin')
        end, priority = 1000 },
    {'f-person/git-blame.nvim'},
    {'akinsho/git-conflict.nvim'},
    {'RRethy/vim-illuminate'},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {'ojroques/nvim-osc52', config=function()
        local function copy()
            if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                require('osc52').copy_register('+')
            end
        end
        vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
    end},
}
