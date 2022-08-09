local M = {}
M.catppuccin = function(flavor)
    local catppuccin = require'catppuccin'
    catppuccin.setup({
        dim_inactive = {enabled = true},
        integrations = {
            lightspeed = true,
            ts_rainbow = true
        },
        compile = {enabled = true}
    })
    vim.g.catppuccin_flavour = flavor
    vim.cmd[[colorscheme catppuccin]]
end

M.nightfox = function(flavor)
    require'nightfox'.setup{
        options = {
            dim_inactive = true,
            styles = { types = 'bold' },
        }
    }
    vim.cmd('colorscheme '..flavor)
end

M.everforest = function(bw, flavor)
    vim.opt.background = bw
    vim.g.everforest_background = flavor
    vim.g.everforest_better_performance = 1
    vim.cmd[[colorscheme everforest]]
end
return M
