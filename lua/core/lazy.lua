-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=main", -- latest stable release
        lazyrepo,
        lazypath,
    })
end ---@diagnostic disable-next-line:undefined-field
vim.opt.rtp:prepend(lazypath)

require"lazy".setup({ import = "plugins" }, {
    install = { colorscheme = { "everforest" }},
    checker = { enabled = true },
    performance = { rtp = { disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
    }}},
})
