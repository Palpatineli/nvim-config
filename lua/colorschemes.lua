local M = {}
local catppuccin = function()
    local catppuccin = require'catppuccin'
    catppuccin.setup({
        dim_inactive = {enabled = true},
        integrations = {
            lightspeed = true,
            ts_rainbow = true
        },
        compile = {enabled = true}
    })
    vim.g.catppuccin_flavour = 'frappe'
    vim.cmd[[colorscheme catppuccin]]
end

local nightfox = function(flavor)
    require'nightfox'.setup{
        options = {
            dim_inactive = true,
            styles = { types = 'bold' },
        }
    }
    vim.cmd[[colorscheme dawnfox]]
end

M.catppuccin = catppuccin
M.nightfox = nightfox
return M
