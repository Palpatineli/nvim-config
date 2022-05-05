local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
  }
}

local M = {}

local get_lsp_client = function()
    -- Get lsp client for current buffer
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.buf_get_clients()
    if next(clients) == nil then
        return nil
    end
    for _, client in pairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
            return client
        end
    end
    return nil
end

M.get_lsp_client = get_lsp_client

local setup_keymap = function()
    vim.api.nvim_set_keymap('n', '<leader>f', '', {silent=true, callback=function()
        require("telescope.builtin").git_files(require("telescope.themes").get_dropdown{previewer = false})
    end})
    vim.api.nvim_set_keymap('n', '<leader>b', '', {silent=true, callback=function()
        require("telescope.builtin").buffers(require("telescope.themes").get_dropdown{previewer = false})
    end})
    vim.api.nvim_set_keymap('n', '<leader>e', '', {silent=true, callback=require("telescope.builtin").diagnostics})
    vim.api.nvim_set_keymap('n', '<leader>F', '', {silent=true, callback=require("telescope.builtin").lsp_references})
    vim.api.nvim_set_keymap('n', '<leader>d', '', {silent=true, callback=require("telescope.builtin").lsp_definitions})
    vim.api.nvim_set_keymap('n', '<leader>i', '', {silent=true, callback=require("telescope.builtin").lsp_implementations})
    vim.api.nvim_set_keymap('n', '<leader>o', '', {silent=true, callback=require("telescope.builtin").treesitter})
    vim.api.nvim_set_keymap('n', '<leader>a', '', {silent=true, callback=function()
        require("telescope.builtin").live_grep{cwd=get_lsp_client().config.root_dir}
    end})
    vim.api.nvim_set_keymap('n', '<leader>A', '', {silent=true, callback=function()
       require("telescope.builtin").grep_string{cwd=get_lsp_client().config.root_dir}
    end})
end

setup_keymap()
return M
