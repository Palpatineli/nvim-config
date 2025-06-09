return {
    {'norcalli/nvim-colorizer.lua'},
    {'hat0uma/csvview.nvim', cmd = {'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle'}, },
    {'LiadOz/nvim-dap-repl-highlights'},
    {'neanias/everforest-nvim', priority=1000, config=function()
        require'everforest'.setup{background='hard'}
        require'everforest'.load()
    end},
    {"cdmill/focus.nvim", cmd = { "Focus", "Zen", "Narrow" }, opts={}},
    {'f-person/git-blame.nvim'},
    {'akinsho/git-conflict.nvim'},
    {'RRethy/vim-illuminate'},
    {'tzachar/local-highlight.nvim', config=function ()
        require'local-highlight'.setup{disable_file_types={'markdown'}} end},
    {'iamcco/markdown-preview.nvim', cmd={ "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" }, build = function() vim.fn["mkdp#util#install"]() end,},
    {"williamboman/mason-lspconfig.nvim", dependencies="williamboman/mason.nvim"},
    {"ecthelionvi/NeoColumn.nvim", config=function() require'NeoColumn'.setup{NeoColumn="120", always_on=true} end},
    {'ojroques/nvim-osc52', config=function()
        local function copy()
            if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                require('osc52').copy_register('+')
            end
        end
        vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
    end},
    {'cameron-wags/rainbow_csv.nvim', ft={'csv', 'tsv'}, config=true,
        cmd={'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim'}},
    { 'alexghergh/nvim-tmux-navigation', opts = { disable_when_zoomed = true }},
}
